fbGetAds <- function(accounts_id  = getOption("rfacebookstat.accounts_id"),
                     api_version  = getOption("rfacebookstat.api_version"),
                     username     = getOption("rfacebookstat.username"),
                     token_path   = fbTokenPath(),
                     access_token = getOption("rfacebookstat.access_token")) {
	
  
  # auth 
  if ( is.null(access_token) ) {    
    
    if ( Sys.getenv("RFB_API_TOKEN") != "" )  {
	    access_token <- Sys.getenv("RFB_API_TOKEN")    
 	} else {
        access_token <- fbAuth(username   = username, 
                               token_path = token_path)$access_token
    }
  }
  
  if ( inherits(access_token, "fb_access_token") ) {
    
    access_token <- access_token$access_token
    
  }
  
  
  # load account list
  if ( is.null(accounts_id) ) {
    
    message("...Loading your account list.")
    accounts_id <- suppressMessages(fbGetAdAccounts()$id)
    message("...Loading ads from ", length(accounts_id), " account", ifelse( length(accounts_id) > 1, "s", "" ))
    
  }
  
  
  # attributes
  rq_ids      <- list()
  out_headers <- list()
  
  result <- list()
  
  # check account format
  accounts_id <- ifelse(grepl("^act_", accounts_id), accounts_id, paste0("act_",accounts_id))
  
  # activate progress bar
  if ( length(accounts_id) > 1 ) {
    
    pgbar <- TRUE
    pb_step <- 1
    pb      <- txtProgressBar(pb_step, 
                              length(accounts_id), 
                              style = 3, 
                              title = "Loading:", 
                              label = "load" )
    
  } else {
    
    # progres bar
    pgbar <- FALSE
    
  }
  
  for ( account_id in accounts_id ) {
      
      url <- str_interp("https://graph.facebook.com/${api_version}/${account_id}/ads")

      api_answer  <- GET(url, 
                         query = list(fields       = "id,name,object_url,adlabels,adset_id,bid_amount,bid_type,campaign_id,account_id,configured_status,effective_status,creative",
                                      limit        = 1000,
                                      filtering    = "[{'field':'ad.delivery_info','operator':'NOT_IN','value':['stupid_filter']}]",
                                      access_token = access_token))
      
      # attr
      rq_ids      <- append(rq_ids, setNames(list(status_code(api_answer)), api_answer$headers$`x-fb-trace-id`))
      out_headers <- append(out_headers, setNames(list(headers(api_answer)), api_answer$headers$`x-fb-trace-id`))
      
      pars_answer <- content(api_answer, as = "parsed")
      
      if(!is.null(pars_answer$error)) {
        error <- pars_answer$error
        stop(pars_answer$error)
      }
      
      if (length(pars_answer$data) == 0) {
        
        # set progress bar
        if( pgbar ) {
          pb_step <- pb_step + 1
          setTxtProgressBar(pb, pb_step)
        }
        
        next
        
      }
      
      
      # pars
      result <- append(result, 
                       lapply( pars_answer$data, fbParserAds ))
    
      # paging
      while (!is.null(pars_answer$paging$`next`)) {
        
        api_answer  <- GET(pars_answer$paging$`next`)
        pars_answer <- content(api_answer, as = "parsed")
        
        # pars
        result <- append(result, 
                         lapply( pars_answer$data, fbParserAds ))
        
    }
    
    # pause between query
    if (pgbar) Sys.sleep(0.2)  
    
    # set progress bar
    if( pgbar ) {
        pb_step <- pb_step + 1
        setTxtProgressBar(pb, pb_step)
    }

}

  # to df
  result <- map_df(result, flatten)
  
  # set attributes
  attr(result, "request_ids") <- rq_ids
  attr(result, "headers")     <- out_headers
  
  
  # close pb
  if( pgbar ) close(pb)
  
  return(result)
}

