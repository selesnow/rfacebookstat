fbDeleteAdAccountUsers <-  function(user_ids = NULL, accounts_id = NULL,api_version = "v3.1",access_token = NULL){
  
  if(is.null(accounts_id)|is.null(access_token)){
    stop("Arguments accounts_id and access_token is require.")
  }
  
  for(account_id in accounts_id){
    
    for(uid in user_ids){
      print(paste0("Account ",account_id))
      QueryString <- paste0("https://graph.facebook.com/",api_version,"/",account_id,"/users/",uid,"?access_token=",access_token)
      ans <- httr::DELETE(QueryString)
      ans <- content(ans)
      print(ans)
      Sys.sleep(3)
    }
  }
}
