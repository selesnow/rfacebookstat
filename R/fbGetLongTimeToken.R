fbGetLongTimeToken <-
function(client_id= NULL,client_secret = NULL,fb_exchange_token = NULL){
  if(is.null(client_id)|is.null(client_secret)|is.null(fb_exchange_token)){
    warning("Enter your Client ID, client_secret and short time token!")
    return()
  }
  link <- paste0("https://graph.facebook.com/oauth/access_token?grant_type=fb_exchange_token&client_id=",client_id,"&client_secret=",client_secret,"&fb_exchange_token=",fb_exchange_token)
  browseURL(link)
  token <- readline(prompt = "Enter your token: ")
  return(token)
}
