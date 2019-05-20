fbGetProjects <-
function(bussiness_id = getOption("rfacebookstat.business_id"), 
         api_version = getOption("rfacebookstat.api_version"), 
		 access_token = getOption("rfacebookstat.access_token")){
  
  QueryString <- paste0("https://graph.facebook.com/",api_version,"/",bussiness_id,"/businessprojects?access_token=",access_token)
  answer <- getURL(QueryString)
  answerobject <- fromJSON(answer)
  result <- answerobject$data
  if(!is.null(answerobject$error)) {
    error <- answerobject$error
    message(message(answerobject$error))
  }
  return(result)
}
