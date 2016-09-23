fbGetToken <- function(app_id = NULL){
  if(is.null(app_id)){
    warning("Enter your App ID in argument app_id!")
    return()
  }
  link <- paste0("https://www.facebook.com/dialog/oauth?client_id=",app_id,"&display=popup& &redirect_uri=https://www.facebook.com/connect/login_success.html&response_type=token&scope=ads_read,business_management,manage_pages,ads_management")
  browseURL(link)
  token <- readline(prompt = "Enter your token: ")
  return(token)
}
