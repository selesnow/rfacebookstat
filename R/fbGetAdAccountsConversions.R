fbGetAdAccountsConversions <- function(accounts_id  = getOption("rfacebookstat.accounts_id"),
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
  
  # load account lists
  if ( is.null(accounts_id) ) {
    message("Loading accounts list.")
    accounts_id <- suppressMessages( fbGetUserAdAccounts()$id )
    message("...Loading conversions from ", length(accounts_id), " account", ifelse( length(accounts_id) > 1, "s", "" ))
    
  }
  
  # attributes
  rq_ids      <- list()
  out_headers <- list()
  
  # check account format
  accounts_id <- ifelse(grepl("^act_", accounts_id), accounts_id, paste0("act_",accounts_id))
  
  
  #Create result data frame
  result    <- list()
  
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
  
  # loading
  for ( account_id in  accounts_id ) {
    
    
    url <- str_interp("https://graph.facebook.com/${api_version}/${account_id}/customconversions")
    
    answer  <- GET(url, 
                   query = list(fields       = "d,name,rule,aggregation_rule,creation_time,custom_event_type,default_conversion_value,description,event_source_type,first_fired_time,is_archived,is_unavailable,last_fired_time,pixel,retention_days,account_id,business",
                                limit        = 150,
                                access_token = access_token))
  
    # attr
    rq_ids       <- append(rq_ids, setNames(list(status_code(answer)), answer$headers$`x-fb-trace-id`))
    out_headers  <- append(out_headers, setNames(list(headers(answer)), answer$headers$`x-fb-trace-id`))
    
    account_custom_conversion <- content(answer, as = "parsed", encoding = "UTF-8")
    
    
    if(!is.null(account_custom_conversion$error)) {
      error <- account_custom_conversion$error
      message("\n",account_custom_conversion$error,"\n")
    }
    
    
    result <- append(result, 
                     lapply( account_custom_conversion$data, fbParserAdConversions))
    
    #Paging
    while ( !is.null(account_custom_conversion$paging$`next`) ) {
      
      link      <- account_custom_conversion$paging$`next`
      answer    <- GET(link)
      
      # attr
      rq_ids      <- append(rq_ids, setNames(list(status_code(answer)), answer$headers$`x-fb-trace-id`))
      out_headers <- append(out_headers, setNames(list(headers(answer)), answer$headers$`x-fb-trace-id`))
      
      account_custom_conversion <- content(answer, as = "parsed", encoding = "UTF-8")
      result <- append(result, 
                       lapply( account_custom_conversion$data, fbParserAdConversions))
      
    }
    
    if ( exists("pb") ) {
      pb_step <- pb_step + 1
      utils::setTxtProgressBar(pb, pb_step)
    }

  }
  
  result <- map_df(result, flatten)
  
  # set attributes
  attr(result, "request_ids") <- rq_ids
  attr(result, "headers")     <- out_headers
  
  # close pb
  if( pgbar ) close(pb)
  
  return(result)
}
