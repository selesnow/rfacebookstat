fbGetPages <-
function(accounts_id  = getOption("rfacebookstat.accounts_id"), 
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
  
  if ( is.null(accounts_id) ) {
    
    message("...Loading your account list.")
    accounts_id <- suppressMessages(fbGetAdAccounts()$id)
    message("...Loading pages from ", length(accounts_id), " account", ifelse( length(accounts_id) > 1, "s", "" ))
    
  }
  
  # attributes
  rq_ids      <- list()
  out_headers <- list()	 
  
  result <- tibble()
  
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
  
  for(account_id in accounts_id){
  
    QueryString <- paste0("https://graph.facebook.com/",api_version,"/",account_id,"/promote_pages?fields=id,name,username,link,general_info,website,is_owned,is_published,about,description,app_id,bio,business,category&access_token=",access_token)
    answer      <- GET(QueryString)
	
	# attr
    rq_ids      <- append(rq_ids, setNames(list(status_code(answer)), answer$headers$`x-fb-trace-id`))
    out_headers <- append(out_headers, setNames(list(headers(answer)), answer$headers$`x-fb-trace-id`))
	
    answerobject <- content(answer, as = "parsed")
	
    tempData     <- map_df(answerobject$data, fbParserPages) %>%
                    mutate(account_id = account_id)
    
    # add info about account
    if ( nrow(tempData) > 0 && length(accounts_id) > 1 ) {
      
      tempData$account_id <- account_id
      
    }
    
	  result <- bind_rows(result, tempData)
    
	if(!is.null(answerobject$error)) {
      error <- answerobject$error
      message(message(answerobject$error))
    }
	
    if(exists("tempData")){rm(tempData)}
	
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
