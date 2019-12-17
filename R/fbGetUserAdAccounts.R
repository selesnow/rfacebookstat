fbGetUserAdAccounts <- function(user_id      = "me",
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
                                     
  if ( class(access_token) == "fb_access_token" ) {
  
    access_token <- access_token$access_token
                                       
  }
                                   
  # attributes
  rq_ids      <- list()
  out_headers <- list()
  
  #Create result data frame
  result    <- tibble()
  
  link      <- paste0("https://graph.facebook.com/", api_version,"/", user_id, "/adaccounts", "?fields=id,name,account_id,account_status,amount_spent,balance,business_name,currency,owner&limit=5000&access_token=", access_token)
  answer    <- GET(link)
  
  # attr
  rq_ids       <- append(rq_ids, setNames(list(status_code(answer)), answer$headers$`x-fb-trace-id`))
  out_headers  <- append(out_headers, setNames(list(headers(answer)), answer$headers$`x-fb-trace-id`))
  
  user_account <- content(answer)
  
  if ( !is.null(user_account$error) ) {
    stop(user_account$error$message)
  }
  
  result       <- bind_rows(user_account$data)
  
  #Paging
  while ( !is.null(user_account$paging$`next`) ) {
    
    link      <- user_account$paging$`next`
    answer    <- GET(link)
    
    # attr
    rq_ids      <- append(rq_ids, setNames(list(status_code(answer)), answer$headers$`x-fb-trace-id`))
    out_headers <- append(out_headers, setNames(list(headers(answer)), answer$headers$`x-fb-trace-id`))
    
    user_account <- content(answer)
	
	if ( !is.null(user_account$error) ) {
       stop(user_account$error$message)
    }
	
    result    <- bind_rows(user_account$data)
    
    }

  # set attributes
  attr(result, "request_ids") <- rq_ids
  attr(result, "headers")     <- out_headers
  
  return(result)
}
