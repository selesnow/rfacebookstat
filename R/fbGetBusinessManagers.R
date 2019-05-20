fbGetBusinessManagers <- function(api_version = getOption("rfacebookstat.api_version"), 
                                  access_token = getOption("rfacebookstat.access_token")){
  
  #Check of fill out access_token
  if(is.null(access_token)){
    stop("access_token id require argument!")
  }
  
  #Create result data frame
  result <- data.frame(stringsAsFactors = F)
 
  #Compose query string
  QueryString <- paste0("https://graph.facebook.com/",api_version,"/me/businesses?fields=id,name,primary_page,creation_time,created_by&access_token=",access_token)

  #Send query to API server
  answer <- GET(QueryString)
  
  #Parse result
  raw <- fromJSON(content(answer, "text", "application/json"))
  
  #Check error
  if(!is.null(raw$error)){
    stop(raw$error)
  }
  
  #Add data to result data frame
  result <- rbind(result, raw$data)
  
  #Pagination
  while(!is.null(raw$paging$`next`)){
    QueryString <- raw$paging$`next`
    answer <- GET(QueryString)
    raw <-  fromJSON(content(answer, "text", "application/json")) 
    tempData <- raw$data
    result <- rbind(result, tempData)}

return(result)}
