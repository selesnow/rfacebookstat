fbGetAdAccounts <- function(source_id    = getOption("rfacebookstat.business_id"), 
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
  
  # attributes
  rq_ids      <- list()
  out_headers <- list()
  
  
  # Check source
  if(is.null(source_id)){
    source_id <- "me"
  }
  
  # Define endpoint, joint operation with v2.11 and v2.10
  if(source_id == "me"){
     end_points <- "adaccounts"
  } else {
     end_points <- c("owned_ad_accounts", "client_ad_accounts")
  }
  
  # Create result data frame
  result <- tibble()
  
  # start endpoint_cycle
  for ( end_point in end_points ) {
    
    # compose
    url <- str_interp("https://graph.facebook.com/${api_version}/${source_id}/${end_point}")
    
    # send request
    answer  <- GET(url, 
                   query = list(fields       = "id,name,account_id,account_status,amount_spent,created_time,balance,business_name,media_agency,currency,owner,partner,age,timezone_name,disable_reason,spend_cap",
                                limit        = 150,
                                access_token = access_token))

    # attr
    rq_ids      <- append(rq_ids, setNames(list(status_code(answer)), answer$headers$`x-fb-trace-id`))
    out_headers <- append(out_headers, setNames(list(headers(answer)), answer$headers$`x-fb-trace-id`))
    
    # Parse result
    raw <- content(answer, "parse", "application/json", encoding = "UTF-8")
    
    # Check error
    if(!is.null(raw$error)) {
      stop(raw$error$message)
    }
    
    #Add data to result data frame
    temp_data <- map_df(raw$data, flatten)
    result    <- bind_rows(result, temp_data)
    # Paging
    while(!is.null(raw$paging$`next`)) {
      
      QueryString <- raw$paging$`next`
      answer <- GET(QueryString)
      
      # attr
      rq_ids      <- append(rq_ids, setNames(list(status_code(answer)), answer$headers$`x-fb-trace-id`))
      out_headers <- append(out_headers, setNames(list(headers(answer)), answer$headers$`x-fb-trace-id`))
      
      raw <- content(answer, "parse", "application/json", encoding = "UTF-8")
      #Add data to result data frame
      temp_data <- map_df(raw$data, flatten)
      result    <- bind_rows(result, temp_data)

   }
  }
  
  # Transform to numeric
  result$balance      <- as.numeric(result$balance)
  result$balance      <- result$balance / 100
  result$amount_spent <- as.numeric(result$amount_spent)
  result$amount_spent <- result$amount_spent / 100
  result$spend_cap    <- as.numeric(result$spend_cap)
  result$spend_cap    <- result$spend_cap / 100
  
  # joining disable reason names
  result <- left_join(result,
                      fb_data.disable_reason,
                      by = c("disable_reason" = "reason_id"))
  
  result <- left_join(result,
                      fb_data.account_statuses,
                      by = c("account_status" = "status_id"))
  
  # set attributes
  attr(result, "request_ids") <- rq_ids
  attr(result, "headers")     <- out_headers
  return(result)
}
  
