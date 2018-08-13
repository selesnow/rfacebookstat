fbGetMarketingStat <-
  function(accounts_id = NULL,
           sorting = NULL,
           level = "account",
           breakdowns = NULL,
           action_breakdowns = NULL,
           fields = "account_id,campaign_name,impressions,clicks,reach,spend",
           filtering = NULL,
           date_start = Sys.Date() - 30,
           date_stop = Sys.Date(),
           api_version = "v3.1",
           interval = "day",
           console_type = "progressbar",
           request_speed = "normal",
           access_token = NULL){
    
    #Check start time
    start_time <- Sys.time()
    
    #Create result DF
    result <- data.table()
    
    if(interval == "overall"){
      dates_from <- as.Date(date_start)
      dates_to   <- as.Date(date_stop)
    } else {
      #Check dates interval
      dates_from <- seq.Date(as.Date(date_start), as.Date(date_stop), by = interval)
      dates_to   <- as.Date(dates_from - 1)
      dates_to   <- c(as.Date(dates_to[-1]),as.Date(date_stop))}
    
    #Create time interval data frame
    dates_df   <- data.frame(dates_from = dates_from,
                             dates_to   = dates_to)
    
    #request step pause
    if(request_speed %in% c("fast","normal","slow")){
      pause_time <- switch(request_speed,
                           "fast" = 0,
                           "normal" = 1 / 5,
                           "slow" = 2)
    } else if(is.numeric(request_speed)|is.integer(request_speed)){
      pause_time <- request_speed
    } else {
      pause_time <- 0
    }
    
    #Check query number
    if(length(accounts_id) * nrow(dates_df) < 2){
      console_type <- "message"  
    }
    
    if(console_type == "progressbar"){      
      #Progress settings
      pb_step <- 1
      pb <- utils::txtProgressBar(pb_step, length(accounts_id) * nrow(dates_df), style = 3)}
    
    #API request counter
    request_counter <- 0
    error_counter   <- 0
    
    for(i in 1:length(accounts_id)){
     
      #Intervals flatten
      for(dt in 1:nrow(dates_df)){
        #Create query string
        QueryString <- gsub("&{1,5}","&",
                            paste(paste0("https://graph.facebook.com/",api_version,"/",accounts_id[i],"/insights?"),
                                  ifelse(is.null(sorting),"",paste0("sort=",sorting)),
                                  paste0("level=",level),
                                  ifelse(is.null(breakdowns),"",paste0("breakdowns=",breakdowns)),
                                  ifelse(is.null(action_breakdowns),"",paste0("action_breakdowns=",action_breakdowns)),
                                  paste0("fields=",fields),
                                  ifelse(is.null(filtering),"",paste0("filtering=",filtering)),
                                  paste0("time_range={\"since\":\"",dates_df$dates_from[dt],"\",\"until\":\"",dates_df$dates_to[dt],"\"}"),
                                  "limit=5000",
                                  paste0("access_token=",access_token),
                                  sep = "&"))
        
        #Progresbar step
        if(console_type == "progressbar"){
          pb_step <- pb_step + 1
          utils::setTxtProgressBar(pb, pb_step)}
        
        #Send API request
        answer <- httr::GET(QueryString)
        request_counter <- request_counter + 1
        #Parse result
        answerobject <- httr::content(answer, as = "parsed")
        
        #Request step pause
        Sys.sleep(pause_time)
        
        #Check answer on errors
        if (!is.null(answerobject$error)) {
          #Add error in error counter
          error_counter <- error_counter + 1
          if (answerobject$error$message == "(#17) User request limit reached") {
            #First attempt
            attempt <- 1
            if(console_type == "message"){
              packageStartupMessage("WARNING: User request limit reached", appendLF = T)
              packageStartupMessage("Apply the mechanism for circumvention of the limit", appendLF = T)
              packageStartupMessage("Wait few minutes.", appendLF = T)}
            #Start cycle
            while(attempt <= 6){
              if(console_type == "message"){
                packageStartupMessage(paste0("attempt number: ",attempt), appendLF = T)}
              
              #Wait one minute and repaete
              Sys.sleep(61)
              
              #Repeate API request
              answer <- getURL(QueryString)
              request_counter <- request_counter + 1
              answerobject <- fromJSON(answer)
              
              #If many limits up pause time
              if(error_counter >= 3 & pause_time < 5){
                if(console_type == "message"){
                  packageStartupMessage("WARNING: More 3 limits error, magnified pause time on 1.5", appendLF = T)}
                pause_time <- pause_time * 1.5
              }
              
              #Check new answer
              if(is.null(answerobject$error$message)) {
                if(console_type == "message"){
                  packageStartupMessage("Problem fixed. Continue data collection", appendLF = T)}
                break}
              #Add error in error counter
              error_counter <- error_counter + 1
              #Next attempt
              attempt <- attempt + 1
            }
          }
          
          #Check other questions  
          if(!is.null(answerobject$error)){
            error <- answerobject$error
            stop(answerobject$error$message)}
          
        }
        
        #Adding data to result
        tempData <- bind_rows(answerobject$data)
        result <- rbind(result, tempData, fill = TRUE)
        
        if (exists("tempData")) {
          rm(tempData)
        }
        #Pagination
        while (!is.null(answerobject$paging$`next`)) {
          QueryString <- answerobject$paging$`next`
          answer <- httr::GET(QueryString)
          request_counter <- request_counter + 1
          answerobject <- httr::content(answer, as = "parsed")
          
          #Request step pause
          Sys.sleep(pause_time)
          
          #Check answer on errors
          if (!is.null(answerobject$error)) {
            #Add error in error counter
            error_counter <- error_counter + 1
            if (answerobject$error$message == "(#17) User request limit reached") {
              #First attempt
              attempt <- 1
              if(console_type == "message"){
                packageStartupMessage("WARNING: User request limit reached", appendLF = T)
                packageStartupMessage("Apply the mechanism for circumvention of the limit", appendLF = T)
                packageStartupMessage("Wait few minutes.", appendLF = T)}
              #Start cycle
              while(attempt <= 5){
                if(console_type == "message"){
                  packageStartupMessage(paste0("attempt number: ",attempt), appendLF = T)}
                
                #Wait one minute and repaete
                Sys.sleep(61)
                
                #Repeate API request
                answer <- httr::GET(QueryString)
                request_counter <- request_counter + 1
                answerobject <- httr::content(answer, as = "parsed")
                
                #Check new answer
                if(is.null(answerobject$error$message)) {
                  if(console_type == "message"){
                    packageStartupMessage("Problem fixed. Continue data collection", appendLF = T)}
                  break}
                #Add error in error counter
                error_counter <- error_counter + 1
                #Next attempt
                attempt <- attempt + 1
              }
            }        
          }
          
          #Adding data to result
          tempData <- answerobject$data
          result <- rbind(result, tempData, fill = TRUE)
        }
      }
    }
    
    #Flatten action
    result <- as.data.frame(result)
    if (length(result$actions) > 0){
      fb_res <- data.table()
      
      for(row in 1:length(result$actions)) {
        #if now have action add this row and go to next step
        if (is.null(result[row, "actions"][[1]]$action_type)) {
          fb_res <- rbind(fb_res,result[row, ], fill = TRUE)
          next
        }
        
        #get all actions
        n <- result[row, "actions"][[1]]$action_type
        #get all values
        d <- data.frame(t(result[row, "actions"][[1]]$value))
        #names all actions
        colnames(d) <- n
        #add to result
        fb_res <- rbind(fb_res, cbind(result[row, ! names(result) %in% "actions"], d), fill = TRUE)
        
      }
      result <- as.data.frame(fb_res)
    }
    
    if(console_type == "progressbar"){  
      #Progressbar close
      utils::setTxtProgressBar(pb, length(accounts_id) * nrow(dates_df))
      close(pb)}
    
    #Out messages
    packageStartupMessage("-----------------------------------------------------", appendLF = T)
    packageStartupMessage("Data loaded successfully!", appendLF = T)
    packageStartupMessage(paste0("Loaded ",nrow(result)," rows."), appendLF = T)
    packageStartupMessage(paste0("Sended ",request_counter," API requests."), appendLF = T)
    if(error_counter > 0) packageStartupMessage(paste0(error_counter," errors of limit request."), appendLF = T)
    if(error_counter > 0) packageStartupMessage(paste0("Error rate ",round(error_counter / request_counter * 100,2),"%"), appendLF = T)
    packageStartupMessage(paste0("Total processing time ",round(difftime(Sys.time(), start_time, units = "secs"), 0) ," seconds."), appendLF = T)
    packageStartupMessage("-----------------------------------------------------", appendLF = T)
    return(result)
  }
