fbGetAdAccountUsers <- function(accounts_id  = getOption("rfacebookstat.accounts_id") ,
                                business_id  = getOption("rfacebookstat.business_id"),
                                api_version  = getOption("rfacebookstat.api_version"),
                                console_type = "progressbar",
                                username     = getOption("rfacebookstat.username"),
                                token_path   = fbTokenPath(),
                                access_token = getOption("rfacebookstat.access_token")){
  
  # auth 
  if ( is.null(access_token) ) {    
    
    if ( Sys.getenv("RFB_API_TOKEN") != "" )  {
	    access_token <- Sys.getenv("RFB_API_TOKEN")    
 	} else {
        access_token <- fbAuth(username   = username, 
                               token_path = token_path)$access_token
    }
  }
  
  if ( inherits(access_token, "fb_access_token") ) {
    
    access_token <- access_token$access_token
    
  }
  
  # load account list
  if ( is.null(accounts_id) ) {
    
    message("...Loading your account list.")
    accounts_id <- suppressMessages(fbGetAdAccounts()$id)
    message("...Loading users from ", length(accounts_id), " account", ifelse( length(accounts_id) > 1, "s", "" ))
    
  }
  
  if (length(accounts_id) == 1) {
    console_type <- "message"
  }
  
  # attributes
  rq_ids      <- list()
  out_headers <- list()
  
  #Progress settings
  pb_step <- 1
  
  if ( console_type == "progressbar" ) {
    pb <- utils::txtProgressBar(pb_step, length(accounts_id), style = 3)
  }
  
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
                        stringsAsFactors      = F)
  
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
    
    # attr
    rq_ids      <- append(rq_ids, setNames(list(status_code(answer)), answer$headers$`x-fb-trace-id`))
    out_headers <- append(out_headers, setNames(list(headers(answer)), answer$headers$`x-fb-trace-id`))
    
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
  
  #Finish progressbar
  if(console_type == "progressbar"){
    pb_step <- pb_step + 1
    utils::setTxtProgressBar(pb, length(accounts_id))
    close(pb)}
	
  # set attributes
  attr(result, "request_ids") <- rq_ids
  attr(result, "headers")     <- out_headers
  
  #Loaded data info message
  packageStartupMessage("Done", appendLF = T)
  packageStartupMessage(paste0("Load userlist from ", account_number - error_number, " accounts."), appendLF = T)
  if(error_number > 0) packageStartupMessage(paste0("Error in ", error_number, " accounts."), appendLF = T)
  return(result)
}

