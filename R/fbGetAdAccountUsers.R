fbGetAdAccountUsers <- function(accounts_id  = getOption("rfacebookstat.accounts_id") ,
                                business_id  = getOption("rfacebookstat.business_id"),
                                api_version  = getOption("rfacebookstat.api_version"),
                                console_type = "progressbar",
                                access_token = getOption("rfacebookstat.access_token")){
  
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
  
  if (length(accounts_id) == 1) {
    console_type <- "message"
  }
  #Progress settings
  pb_step <- 1
  
  if(console_type == "progressbar"){
    pb <- utils::txtProgressBar(pb_step, length(accounts_id), style = 3)}
  
  #Check account ids
  accounts_id <- ifelse(grepl("^act_",accounts_id),accounts_id,paste0("act_",accounts_id))
  
  #result df
  result <- data.frame( role                  = character(0),
                        status                = character(0),
                        user.name             = character(0),
                        user.id               = character(0),
                        business_persona.name = character(0),
                        business_persona.id   = character(0),
                        account_id            = character(0),
                        email                 = character(0),
                        business.id           = character(0),
                        business.name         = character(0),
                        stringsAsFactors = F)
  
  #Create counter variables
  account_number <- 0
  error_number   <- 0
  
  #Start message
  if(console_type == "message"){
    packageStartupMessage("Processing...", appendLF = T)}
  
  #start cycle
  for(account in accounts_id){
    #Progressbar step
    if(console_type == "progressbar"){
      pb_step <- pb_step + 1
      setTxtProgressBar(pb, pb_step)}
    
    if(is.na(account)|is.null(account)) next
    account_number <- account_number + 1
    
    #Compose URL hhtp request
    if(console_type == "message"){
      packageStartupMessage(account, appendLF = F)}
    
    QueryString <- paste0("https://graph.facebook.com/",api_version,"/",account,"/assigned_users?fields=user,business_persona,tasks,email,status&business=",business_id,"&limit=150&access_token=",access_token)
    
    #Send request
    answer <- httr::GET(QueryString)
    
    raw <- fromJSON(httr::content(answer, "text", "application/json",encoding = "UTF-8"))
    
    #Check answer on error
    if(length(raw$error) > 0){
      if(console_type == "message"){
        packageStartupMessage(paste0(" - ",raw$error$code, " - ", raw$error$message), appendLF = T)}
      error_number   <- error_number + 1
      next
    }
    
    #Parse answer and transform him to data frame
    flatten_data <- fromJSON(httr::content(answer, "text", "application/json",encoding = "UTF-8"), flatten = T)$data
    
    if(is.null(flatten_data)|length(flatten_data) == 0){
      if(console_type == "message"){
        packageStartupMessage(paste0(" - Empty userlist!"), appendLF = T)}
      error_number   <- error_number + 1
      next
    }
    
    #add account id ino data frame
    flatten_data$account_id <- account
    
    #Add all field list
    for (col in names(result)){
      if (is.null(flatten_data[[col]])) {
        flatten_data[[col]] <- NA
      }
    }
    
    #Add to result data.frame
    result <- rbind(result, flatten_data)
    
    if(console_type == "message"){
      packageStartupMessage(paste0(" - Done, ",nrow(flatten_data)," users"), appendLF = T)}
  }
  
  #back string as factor value
  if(factor_change){
    options(stringsAsFactors = T)
  }
  
  #Finish progressbar
  if(console_type == "progressbar"){
    pb_step <- pb_step + 1
    utils::setTxtProgressBar(pb, length(accounts_id))
    close(pb)}
  
  #Loaded data info message
  packageStartupMessage("Done", appendLF = T)
  packageStartupMessage(paste0("Load userlist from ", account_number - error_number, " accounts."), appendLF = T)
  if(error_number > 0) packageStartupMessage(paste0("Error in ", error_number, " accounts."), appendLF = T)
  return(result)
}

