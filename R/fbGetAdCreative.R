fbGetAdCreative <- function(accounts_id  = getOption("rfacebookstat.accounts_id"),
                            api_version  = getOption("rfacebookstat.api_version"),
                            username     = getOption("rfacebookstat.username"),
                            token_path   = fbTokenPath(),
                            access_token = getOption("rfacebookstat.access_token")){
	
  # auth 
  if ( is.null(access_token) ) {    
    
    if ( Sys.getenv("RFB_API_TOKEN") != "" )  {
	    access_token <- Sys.getenv("RFB_API_TOKEN")    
 	} else {
        access_token <- fbAuth(username   = username, 
                               token_path = token_path)$access_token
    }
  }
  
  if ( class(access_token) == "fb_access_token" ) {
    
    access_token <- access_token$access_token
    
  }
  
  
  # attributes
  rq_ids      <- list()
  out_headers <- list()
  
  res <- list()
  
  # load account list
  if ( is.null(accounts_id) ) {
    
    message("...Loading your account list.")
    accounts_id <- suppressMessages(fbGetAdAccounts()$id)
    message("...Loading adscreatives from ", length(accounts_id), " account", ifelse( length(accounts_id) > 1, "s", "" ))
    
  }
  
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
  
  for( account_id in accounts_id ) {
      
    
      url <- str_interp("https://graph.facebook.com/${api_version}/${account_id}/adcreatives")
    
      api_answer  <- GET(url, 
                         query = list(fields       = "ad_id,name,title,body,status,link_url,template_url,url_tags,object_story_spec,object_id,object_type,account_id",
                                      limit        = 1000,
                                      access_token = access_token))
      
      # attr
      rq_ids      <- append(rq_ids, setNames(list(status_code(api_answer)), api_answer$headers$`x-fb-trace-id`))
      out_headers <- append(out_headers, setNames(list(headers(api_answer)), api_answer$headers$`x-fb-trace-id`))
      
      pars_answer <- content(api_answer, as = "parsed")
      
      if(!is.null(pars_answer$error)) {
        error <- pars_answer$error
        message("\n",pars_answer$error,"\n")
      }
      
      # pars
      res <- append(res, 
                    lapply( pars_answer$data, fbParserAdCreatives ))
      
      # paging
      while (!is.null(pars_answer$paging$`next`)) {
        
        api_answer  <- GET(pars_answer$paging$`next`)
        pars_answer <- content(api_answer, as = "parsed")
        
        # pars
        res <- append(res, 
                      lapply( pars_answer$data, fbParserAdCreatives ))
        
      }
      
      # pause between query
      if (pgbar) Sys.sleep(0.1)  
      
      # set progress bar
      if( pgbar ) {
        pb_step <- pb_step + 1
        setTxtProgressBar(pb, pb_step)
      }
  }
  

  res <- map_df(res, flatten)
  
  # set attributes
  attr(res, "request_ids") <- rq_ids
  attr(res, "headers")     <- out_headers
  
  # close pb
  if( pgbar ) close(pb)
  
  return(res)
}
