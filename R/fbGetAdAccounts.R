fbGetAdAccounts <- function(source_id = NULL, api_version = "v2.10", access_token = NULL){
  
  #Check of fill out access_token
  if(is.null(access_token)){
    stop("access_token id require argument!")
  }
  
  #Check source
  if(is.null(source_id)){
    source_id <- "me"
  }
  
  #Create result data frame
  result <- data.frame(stringsAsFactors = FALSE)
  
  #Compose query string
  QueryString <- paste0("https://graph.facebook.com/",api_version,"/",source_id,"/adaccounts?&fields=name,id,account_id,account_status,user_role,age,business_name,amount_spent,balance,currency,business_city,business_country_code&limit=100&access_token=",access_token)

  #Send query to API server
  answer <- GET(QueryString)

  #Parse result
  raw <- fromJSON(content(answer, "text", "application/json",encoding = "UTF-8"))

  #Check error
  if(!is.null(raw$error)){
    stop(raw$error$message)
  }

#Add to result
result <- rbind(result, raw$data)

#Paging
while(!is.null(raw$paging$`next`)){
  QueryString <- raw$paging$`next`
  answer <- GET(QueryString)
  raw  <- fromJSON(content(answer, "text", "application/json",encoding = "UTF-8")) 
  result <- rbind(result, raw$data)}

return(result)}