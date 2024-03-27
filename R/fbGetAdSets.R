fbGetAdSets <- function(accounts_id  = getOption("rfacebookstat.accounts_id"),
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
  
  if ( inherits(access_token, "fb_access_token") ) {
    
    access_token <- access_token$access_token
    
  }
  
  result <- list()
  
  # load account list
  if ( is.null(accounts_id) ) {
    
    message("...Loading your account list.")
    accounts_id <- suppressMessages(fbGetAdAccounts()$id)
    message("...Loading adsets from ", length(accounts_id), " account", ifelse( length(accounts_id) > 1, "s", "" ))
    
  }
  
  # check account format
  accounts_id <- ifelse(grepl("^act_", accounts_id), accounts_id, paste0("act_",accounts_id))
  
  # attributes
  rq_ids      <- list()
  out_headers <- list()
  
  
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
  
  QueryString <- paste0("https://graph.facebook.com/",api_version,"/",account_id,"/adsets?fields=id,name,account_id,bid_amount,bid_strategy,billing_event,budget_remaining,campaign_id,configured_status,effective_status,status,optimization_goal,pacing_type,destination_type,daily_budget,created_time,source_adset_id&limit=500",
                                                "&filtering=[{'field':'adset.delivery_info','operator':'NOT_IN','value':['stupid_filter']}]",
                                                "&access_token=",access_token)
  
  api_answer  <- GET(QueryString)
    
  # attr
  rq_ids      <- append(rq_ids, setNames(list(status_code(api_answer)), api_answer$headers$`x-fb-trace-id`))
  out_headers <- append(out_headers, setNames(list(headers(api_answer)), api_answer$headers$`x-fb-trace-id`))
  
  pars_answer <- content(api_answer, as = "parsed")
  
  if(!is.null(pars_answer$error)) {
    error <- pars_answer$error
    stop(pars_answer$error)
  }

  tempData     <- map_df(pars_answer$data, fbParserAdsets)
  result       <- bind_rows(result, tempData)

  # paging
  while (!is.null(pars_answer$paging$`next`)) {

    api_answer  <- GET(pars_answer$paging$`next`)
    pars_answer <- content(api_answer, as = "parsed")
    
    tempData     <- map_df(pars_answer$data, fbParserAdsets)
    result       <- bind_rows(result, tempData)
  }
   
  # pause between query
  if (pgbar) Sys.sleep(0.2)  
  
  # set progress bar
  if( pgbar ) {
      pb_step <- pb_step + 1
      setTxtProgressBar(pb, pb_step)
   }
  
  }

  # set attributes
  attr(result, "request_ids") <- rq_ids
  attr(result, "headers")     <- out_headers
  
  # close pb
  if( pgbar ) close(pb)
  
  return(result)
}

