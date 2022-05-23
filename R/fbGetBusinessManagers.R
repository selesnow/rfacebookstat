fbGetBusinessManagers <- function(api_version  = getOption("rfacebookstat.api_version"), 
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
  
  #Check of fill out access_token
  if(is.null(access_token)){
    stop("access_token id require argument!")
  }
  	
  # attributes
  rq_ids      <- list()
  out_headers <- list()

  #Create result data frame
  result <- tibble()
 
  #Compose query string
  QueryString <- paste0("https://graph.facebook.com/",api_version,"/me/businesses?fields=id,name,primary_page,creation_time,created_by&access_token=",access_token)

  #Send query to API server
  answer <- GET(QueryString)
  
  # attr
  rq_ids      <- append(rq_ids, setNames(list(status_code(answer)), answer$headers$`x-fb-trace-id`))
  out_headers <- append(out_headers, setNames(list(headers(answer)), answer$headers$`x-fb-trace-id`))
	
  #Parse result
  raw <- content(answer, "parse", "application/json", encoding = "UTF-8")

  #Check error
  if(!is.null(raw$error)){
    stop(raw$error)
  }
  
  #Add data to result data frame
  temp_data <- map_df(raw$data, fbParserBM)
  result    <- bind_rows(result, temp_data)
  
  #Pagination
  while(!is.null(raw$paging$`next`)){
    QueryString <- raw$paging$`next`
    answer <- GET(QueryString)
	
	  # attr
    rq_ids      <- append(rq_ids, setNames(list(status_code(answer)), answer$headers$`x-fb-trace-id`))
    out_headers <- append(out_headers, setNames(list(headers(answer)), answer$headers$`x-fb-trace-id`))
	
    raw <- content(answer, "parse", "application/json", encoding = "UTF-8")
    #Add data to result data frame
    temp_data <- map_df(raw$data, fbParserBM)
    result    <- bind_rows(result, temp_data)
  }

  # set attributes
  attr(result, "request_ids") <- rq_ids
  attr(result, "headers")     <- out_headers
  
return(result)
}
