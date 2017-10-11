fbGetAdAccountUsers <- function(accounts_id = NULL ,api_version = "v2.10", access_token = NULL){
  
  if(is.null(accounts_id)|is.null(access_token)){
    stop("Arguments accounts_id and access_token is require.")
  }

#check stringAsFactor
factor_change <- FALSE

#change string is factor if TRUE
if(getOption("stringsAsFactors")){
  options(stringsAsFactors = F)
  factor_change <- TRUE
}

#Check account ids
accounts_id <- ifelse(grepl("^act_",accounts_id),accounts_id,paste0("act_",accounts_id))

#result df
result <- data.frame(stringsAsFactors = F)

packageStartupMessage("Processing", appendLF = F)
#
#start cycle
for(account in accounts_id){
  if(is.na(account)|is.null(account)) next
#ФОрмируем URL HTTP запроса
 packageStartupMessage(".", appendLF = F)
 QueryString <- paste0("https://graph.facebook.com/",api_version,"/",account,"/users?access_token=",access_token)

 #Отправляем запрос на сервер
 answer <- GET(QueryString)
 raw <- fromJSON(content(answer, "text", "application/json",encoding = "UTF-8"))
 
 #Проверям результат на ошибки
 if(length(raw$error) > 0){
   try(stop(paste0(account," - ",raw$error$code, " - ", raw$error$message)))
   next
 }

 #Парсим ответ и преобразуем его в табицу
 flatten_data <- fromJSON(content(answer, "text", "application/json",encoding = "UTF-8"), flatten = T)$data
 flatten_data$account_id <- account
 
 #Получаем имя пользователя и ссылку на его страницу
 for(user in flatten_data$id){
  
  QueryString <- paste0("https://graph.facebook.com/",api_version,"/",user,"?fields=id,name,link&access_token=",access_token)
  answerUSER <- GET(QueryString)
  stop_for_status(answerUSER)
  raw <- fromJSON(content(answerUSER, "text", "application/json",encoding = "UTF-8"))
  #Проверям результат на ошибки
  if(length(answerUSER$error) > 0){
    try(stop(paste0(raw$error$code, " - ", raw$error$message)))
    next
  }

  rawUSER <- data.frame(fromJSON(content(answerUSER, "text", "application/json",encoding = "UTF-8"), flatten = T))
  flatten_data$link[flatten_data$id == user] <- as.character(rawUSER$link)
  }

 result <- rbind(result, flatten_data)
}

#back string as factor value
if(factor_change){
  options(stringsAsFactors = T)
}
packageStartupMessage("Done", appendLF = T)
return(result)
}
