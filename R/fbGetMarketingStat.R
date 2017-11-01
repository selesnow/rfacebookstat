fbGetMarketingStat <-
function(accounts_id = NULL,
         sorting = NULL,
         level = "account",
         breakdowns = NULL,
         fields ="account_id,account_name,campaign_name,impressions,clicks,unique_clicks,reach,spend",
         filtering = NULL,
         date_start = Sys.Date() - 30,
         date_stop = Sys.Date(),
	       api_version = "v2.10",
         interval = "day",
         access_token = NULL){
  
  #Создаём результирующий дата фрейм
  result <- data.frame()
  
  #Проверяем выбранный интервал
  dates_from <- seq.Date(date_start, date_stop, by = interval)
  dates_to   <- dates_from - 1
  dates_to   <- c(dates_to[-1],date_stop)
  dates_df   <- data.frame(dates_from = dates_from,
                          dates_to   = dates_to)
  
  for(i in 1:length(accounts_id)){
    
    #Разбивка по интервалу
    for(dt in 1:nrow(dates_df)){
    #Создаём строку запроса
    QueryString <- gsub("&{1,5}","&",
                          paste(paste0("https://graph.facebook.com/",api_version,"/",accounts_id[i],"/insights?"),
                          ifelse(is.null(sorting),"",paste0("sort=",sorting)),
                          paste0("level=",level),
                          ifelse(is.null(breakdowns),"",paste0("breakdowns=",breakdowns)),
                          paste0("fields=",fields),
                          ifelse(is.null(filtering),"",paste0("filtering=",filtering)),
                          paste0("time_range={\"since\":\"",dates_df$dates_from[dt],"\",\"until\":\"",dates_df$dates_to[dt],"\"}"),
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
  }
  #Возвращаем дата фрейм
  return(result)
}
