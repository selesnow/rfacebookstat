fbGetProjects <-
function(bussiness_id = NULL, api_version = "v3.1", access_token = NULL){
  
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
