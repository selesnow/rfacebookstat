fbDeleteAdAccountUsers <-  function(user_ids     = NULL, 
                                    accounts_id  = getOption("rfacebookstat.accounts_id"),
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
