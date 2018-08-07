fbGetApps <-
function(projects_id = NULL, api_version = "v3.1", access_token = NULL){
  result <- data.frame()
  for(i in 1:length(projects_id)){
    QueryString <- paste0("https://graph.facebook.com/",api_version,"/",projects_id[i],"/apps?fields=name,id&access_token=",access_token)
    answer <- getURL(QueryString)
    answerobject <- fromJSON(answer)
    tempData <- answerobject$data
    result <- rbind(result, tempData)
    if(!is.null(answerobject$error)) {
      error <- answerobject$error
      message(message(answerobject$error))
    }
    if(exists("tempData")){rm(tempData)}
  }
  return(result)
}
