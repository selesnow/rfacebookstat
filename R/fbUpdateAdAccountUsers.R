fbUpdateAdAccountUsers <- function(user_ids = NULL, 
                                   role = "advertiser", 
                                   accounts_id = getOption("rfacebookstat.accounts_id"),
                                   api_version = getOption("rfacebookstat.api_version"),
                                   access_token = getOption("rfacebookstat.access_token")){
  
  #Check account_id, token and uid
  if(is.null(accounts_id)|is.null(access_token)|is.null(user_ids)){
    stop("Arguments user_ids, accounts_id and access_token is require.")
  }
  
  #Check role
  role <- switch(tolower(role), 
                 "administator" = 1001,
                 "advertiser"   = 1002,
                 "ad manager"   = 1002,
                 "analyst"      = 1003,
                 "sales"        = 1004,
                 "direct sales" = 1004,
                 tolower(role))
  
  for(account_id in accounts_id){
    
    for(uid in user_ids){
      print(paste0("Add user ", uid, " to account ", account_id))
      #Compose query
      QueryString <- paste0("https://graph.facebook.com/",api_version,"/",account_id,"/users?uid=",uid,"&role=",role,"&access_token=",access_token)
      #Send query
      ans <- httr::POST(QueryString)
      #Parse query
      ans <- content(ans)
      #Message
      print(ans)} 
      #sleep 3 second before next request
      Sys.sleep(3)
  }
}
