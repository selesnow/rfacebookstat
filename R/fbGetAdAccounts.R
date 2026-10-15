fbGetAdAccounts <- function(source_id    = getOption("rfacebookstat.business_id"), 
                            api_version  = getOption("rfacebookstat.api_version"), 
                            username     = getOption("rfacebookstat.username"),
                            token_path   = fbTokenPath(),
                            access_token = getOption("rfacebookstat.access_token"),
                            limit        = 50,
                            filtering    = NULL) {
  
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
  
  # filters handling to JSON
  if ( ! is.null(filtering) ) {
    
    if ( is.list(filtering) ) {
      
      filters <- list()
      for ( f in filtering ) {
        filter <- list(field    = f$field,
                       operator = f$operator,
                       value    = f$value)
        filters <- append(filters, list(filter))
      }
      filtering <- as.character(toJSON(filters, auto_unbox = TRUE))
      
    } else if ( is.character(filtering) ) {
      
      if ( ! validate(filtering)[[1]] ) {
        
        # check single quotes
        fixed_quotes <- gsub("'", "\"", filtering)
        if ( validate(fixed_quotes)[[1]] ) {
          filtering <- fixed_quotes
        } else {
          # string format "field operator value"
          filters <- list()
          for ( f in filtering ) {
            temp_fil    <- str_split(f, " ")[[1]]
            temp_filter <- list(field    = temp_fil[1],
                                operator = temp_fil[2])
            
            if ( temp_fil[2] %in% c("IN_RANGE", "NOT_IN_RANGE", "IN", "NOT_IN") ) {
              temp_filter$value <- str_split(temp_fil[3], ",")[[1]]
            } else {
              temp_filter$value <- temp_fil[3]
            }
            filters <- append(filters, list(temp_filter))
          }
          filtering <- as.character(toJSON(filters, auto_unbox = TRUE))
        }
      }
    }
  }
  
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
    
    # query parameters
    query_params <- list(fields       = "id,name,account_id,account_status,amount_spent,created_time,balance,business_name,media_agency,currency,owner,partner,age,timezone_name,disable_reason,spend_cap",
                         limit        = limit,
                         access_token = access_token)
    
    if ( ! is.null(filtering) ) {
      query_params$filtering <- filtering
    }
    
    # send request
    answer  <- GET(url, query = query_params)

    # attr
    rq_ids      <- append(rq_ids, setNames(list(status_code(answer)), answer$headers$`x-fb-trace-id`))
    out_headers <- append(out_headers, setNames(list(headers(answer)), answer$headers$`x-fb-trace-id`))
    
    # Parse result
    raw <- content(answer, "parse", "application/json", encoding = "UTF-8")
    
    # Check error
    if(!is.null(raw$error)) {
      err_msg <- raw$error$message
      if (!is.null(raw$error$error_user_title)) err_msg <- paste0(raw$error$error_user_title, ": ", err_msg)
      if (!is.null(raw$error$error_user_msg))   err_msg <- paste0(err_msg, ". ", raw$error$error_user_msg)
      if (!is.null(raw$error$code))             err_msg <- paste0(err_msg, " (Code: ", raw$error$code, ")")
      stop(err_msg)
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
      
      if(!is.null(raw$error)) {
        err_msg <- raw$error$message
        if (!is.null(raw$error$code)) err_msg <- paste0(err_msg, " (Code: ", raw$error$code, ")")
        stop(err_msg)
      }
      
      #Add data to result data frame
      temp_data <- map_df(raw$data, flatten)
      result    <- bind_rows(result, temp_data)

    }
  }
  
  if (nrow(result) > 0) {
    # Transform to numeric
    if ("balance" %in% names(result)) {
      result$balance      <- as.numeric(result$balance) / 100
    }
    if ("amount_spent" %in% names(result)) {
      result$amount_spent <- as.numeric(result$amount_spent) / 100
    }
    if ("spend_cap" %in% names(result)) {
      result$spend_cap    <- as.numeric(result$spend_cap) / 100
    }
    
    # joining disable reason names
    if ("disable_reason" %in% names(result)) {
      result$disable_reason <- as.numeric(result$disable_reason)
      result <- left_join(result,
                          fb_data.disable_reason,
                          by = c("disable_reason" = "reason_id"))
    }
    
    if ("account_status" %in% names(result)) {
      result$account_status <- as.numeric(result$account_status)
      result <- left_join(result,
                          fb_data.account_statuses,
                          by = c("account_status" = "status_id"))
    }
  }
  
  # set attributes
  attr(result, "request_ids") <- rq_ids
  attr(result, "headers")     <- out_headers
  return(result)
}
