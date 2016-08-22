fbGetToken <-
function(){
  browseURL("https://www.facebook.com/dialog/oauth?client_id=176943372709235&display=popup& &redirect_uri=https://www.facebook.com/connect/login_success.html&response_type=token&scope=ads_read,business_management,manage_pages,ads_management")
  token <- readline(prompt = "Enter your token: ")
  return(token)
}
