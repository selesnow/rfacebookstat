fbGetLongTimeToken <-
  function(client_id = NULL,client_secret = NULL,fb_exchange_token = NULL){
    if(is.null(client_id)|is.null(client_secret)|is.null(fb_exchange_token)){
      stop("Enter your Client ID, client_secret and short time token!")
    }
    link <- paste0("https://graph.facebook.com/oauth/access_token?grant_type=fb_exchange_token&client_id=",client_id,"&client_secret=",client_secret,"&fb_exchange_token=",fb_exchange_token)
    raw_token <- GET(link)
    token_list <- content(raw_token)
    
    if(!is.null(token_list$error)) {
      error <- token_list$error
      message(error)
    }
    message("Token changed successfully")
    message("New longtime token: ", token_list$access_token)
    message("Expires in ", Sys.time() + as.numeric(token_list$expires_in, units = "secs"))
    return(token_list$access_token)
}
