fbGetMarketingStat <-
function(accounts_id = NULL,
         sorting = NULL,
         level = "account",
         breakdowns = NULL,
         fields ="account_id,account_name,campaign_name,impressions,unique_impressions,clicks,unique_clicks,reach,spend",
         filtering = NULL,
         date_start = "2000-01-01",
         date_stop = Sys.Date(),
	 api_version = "v2.8",
         access_token = NULL){
  result <- data.frame()
  for(i in 1:length(accounts_id)){
    #Создаём строку запроса
    QueryString <- gsub("&{1,5}","&",
                          paste(paste0("https://graph.facebook.com/",api_version,"/",accounts_id[i],"/insights?"),
                          ifelse(is.null(sorting),"",paste0("sort=",sorting)),
                          paste0("level=",level),
                          ifelse(is.null(breakdowns),"",paste0("breakdowns=",breakdowns)),
                          paste0("fields=",fields),
                          ifelse(is.null(filtering),"",paste0("filtering=",filtering)),
                          paste0("time_range={\"since\":\"",date_start,"\",\"until\":\"",date_stop,"\"}"),
			  "limit=5000",
                          paste0("access_token=",access_token),
                          sep = "&"))
    #Отправка запроса
    answer <- getURL(QueryString)
    answerobject <- fromJSON(answer)
    tempData <- answerobject$data
    result <- rbind(result, tempData)
    if(!is.null(answerobject$error)) {
      error <- answerobject$error
      stop(answerobject$error)
    }
    if(exists("tempData")){rm(tempData)}
	  #Запуск процесса пейджинации
	      while(!is.null(answerobject$paging$`next`)){
                 QueryString <- answerobject$paging$`next`
                 answer <- getURL(QueryString)
                 answerobject <- fromJSON(answer)
                 tempData <- answerobject$data
                 result <- rbind(result, tempData)}
  }
  return(result)
}
