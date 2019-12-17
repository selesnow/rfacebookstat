fbGetMarketingStat <-
  function(accounts_id        = getOption("rfacebookstat.accounts_id"),
           sorting            = NULL,
           level              = "account",
           breakdowns         = NULL,
           action_breakdowns  = NULL,
           fields             = "account_id,campaign_name,impressions,clicks,reach,spend",
           filtering          = NULL,
           date_start         = Sys.Date() - 30,
           date_stop          = Sys.Date(),
           attribution_window = NULL,
           api_version        = getOption("rfacebookstat.api_version"),
           action_report_time = NULL,
           interval           = "day",
           console_type       = "progressbar",
           request_speed      = "normal",
           username           = getOption("rfacebookstat.username"),
           token_path         = fbTokenPath(),
           access_token       = getOption("rfacebookstat.access_token")){
    
   # auth 
   if ( is.null(access_token) ) {    
    
     if ( Sys.getenv("RFB_API_TOKEN") != "" )  {
	    access_token <- Sys.getenv("RFB_API_TOKEN")    
 	 } else {
        access_token <- fbAuth(username   = username, 
                               token_path = token_path)$access_token
     }
   }
    
    if ( class(access_token) == "fb_access_token" ) {
      
      access_token <- access_token$access_token
      
    }
    
    # Check start time
    start_time <- Sys.time()
    
    # Create result DF
    result <- tibble()
    
    # attributes
    rq_ids      <- list()
    out_headers <- list()
    
    # 
    # clear field list
    fields <- gsub("[\\s\\n\\t]", 
                   "", 
                   fields, 
                   perl = TRUE)
    
    # clear action breakdowns
    action_breakdowns <- gsub("[\\s\\n\\t]", 
                              "", 
                              action_breakdowns, 
                              perl = TRUE)
    
    if ( ! is.null(attribution_window) ) {
      
      attribution_window <- tolower(attribution_window) %>% toJSON()
      
    }
	
	# check account format
	accounts_id <- ifelse(grepl("^act_", accounts_id), accounts_id, paste0("act_",accounts_id))
    
    # answer object class detect
    answer_class <- "actions"
    
    # filters handing to JSON
    if ( ! is.null(filtering) ) {
      if ( ! validate(filtering)[[1]] ) {
        
        filters <- list()
        
        for ( f in filtering ) {
          temp_fil    <- str_split(f, " ")
          temp_filter <- list(field    = temp_fil[[1]][1],
                              operator = temp_fil[[1]][2])
          
          if ( temp_fil[[1]][2] %in% c("IN_RANGE", "NOT_IN_RANGE", "IN", "NOT_IN") ) {
            temp_filter$value <- str_split(temp_fil[[1]][3], ",")[[1]]
          } else {
            temp_filter$value <- temp_fil[[1]][3]
          }
          filters <- append(filters, list(temp_filter))
        }
        filtering <- toJSON(filters, auto_unbox = T)
      }
    }
    
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
      pb <- utils::txtProgressBar(pb_step, length(accounts_id) * nrow(dates_df), style = 3,title = "Loading:", label = "load" )}
    
    #API request counter
    request_counter <- 0
    error_counter   <- 0
    
    for(i in 1:length(accounts_id)){
      
      #Intervals flatten
      for(dt in 1:nrow(dates_df)){
        
        #Create query string
        QueryString <- str_interp("https://graph.facebook.com/${api_version}/${accounts_id[i]}/insights?")
        
        #Progresbar step
        if(console_type == "progressbar"){
          pb_step <- pb_step + 1
          utils::setTxtProgressBar(pb, pb_step)}
        
        #Send API request
        answer <- httr::GET(QueryString,
                            query = list(sort                       = sorting,
                                         level                      = level,
                                         breakdowns                 = breakdowns,
                                         action_breakdowns          = action_breakdowns,
                                         fields                     = fields,
                                         filtering                  = filtering,
                                         action_report_time         = action_report_time,
                                         action_attribution_windows = attribution_window,
                                         time_range                 = str_interp("{\"since\":\"${dates_df$dates_from[dt]}\",\"until\":\"${dates_df$dates_to[dt]}\"}"),
                                         limit                      = 5000,
                                         access_token               = access_token))
        
        # attr
        rq_ids      <- append(rq_ids, setNames(list(status_code(answer)), answer$headers$`x-fb-trace-id`))
        out_headers <- append(out_headers, setNames(list(headers(answer)), answer$headers$`x-fb-trace-id`))
        
        # check limit
        queryrep <- fbAPILimitCheck( answer, console_type, pb, pb_step, accounts_id, dates_df, pause_time  )
        
        # reapet query if out of apilimit
        while ( queryrep ) {
          
          answer <- httr::GET(QueryString,
                              query = list(sort                       = sorting,
                                           level                      = level,
                                           breakdowns                 = breakdowns,
                                           action_breakdowns          = action_breakdowns,
                                           fields                     = fields,
                                           filtering                  = filtering,
                                           action_report_time         = action_report_time,
                                           action_attribution_windows = attribution_window,
                                           time_range                 = str_interp("{\"since\":\"${dates_df$dates_from[dt]}\",\"until\":\"${dates_df$dates_to[dt]}\"}"),
                                           limit                      = 5000,
                                           access_token               = access_token))
          
          # attr
          rq_ids      <- append(rq_ids, setNames(list(status_code(answer)), answer$headers$`x-fb-trace-id`))
          out_headers <- append(out_headers, setNames(list(headers(answer)), answer$headers$`x-fb-trace-id`))
          
          queryrep <- fbAPILimitCheck( answer, console_type, pb, pb_step, accounts_id, dates_df, pause_time )
        }
        
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
              answer <- httr::GET(QueryString,
                                  query = list(sort               = sorting,
                                               level              = level,
                                               breakdowns         = breakdowns,
                                               action_breakdowns  = action_breakdowns,
                                               fields             = fields,
                                               filtering          = filtering,
                                               action_report_time = action_report_time,
                                               action_attribution_windows = attribution_window,
                                               time_range         = str_interp("{\"since\":\"${date_start}\",\"until\":\"${date_stop}\"}"),
                                               limit              = 5000,
                                               access_token       = access_token))
              
            # attr
            rq_ids      <- append(rq_ids, setNames(list(status_code(answer)), answer$headers$`x-fb-trace-id`))
            out_headers <- append(out_headers, setNames(list(headers(answer)), answer$headers$`x-fb-trace-id`))
              
              request_counter <- request_counter + 1
              answerobject <- httr::content(answer, as = "parsed")
              
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
        
        # action breakdown handing
        if ( any(c("actions", "action_values", "conversions", "conversion_values")  %in% unlist(str_split(fields, ","))) ) {
          
          # switch functions
          class(answerobject) <- answer_class
          
          #Adding data to result
          tempData <- fbAction(answerobject)
          
          result   <- bind_rows(result, tempData)
          
          if (exists("tempData")) {
            rm(tempData)
          }
          
        } else {
          #Adding data to result
          tempData <- bind_rows(answerobject$data)
          result   <- bind_rows(result, tempData)
        }
        
        #Pagination
        while (!is.null(answerobject$paging$`next`)) {
          QueryString <- answerobject$paging$`next`
          answer <- httr::GET(QueryString)
          
          # check limit
          queryrep <- fbAPILimitCheck( answer, console_type, pb, pb_step, accounts_id, dates_df, pause_time )
          
          # reapet query if out of apilimit
          while ( queryrep ) {
            
            answer <- httr::GET(QueryString,
                                query = list(sort               = sorting,
                                             level              = level,
                                             breakdowns         = breakdowns,
                                             action_breakdowns  = action_breakdowns,
                                             fields             = fields,
                                             filtering          = filtering,
                                             action_report_time = action_report_time,
                                             action_attribution_windows = attribution_window,
                                             time_range         = str_interp("{\"since\":\"${date_start}\",\"until\":\"${date_stop}\"}"),
                                             limit              = 5000,
                                             access_token       = access_token))
            
            # attr
            rq_ids      <- append(rq_ids, setNames(list(status_code(answer)), answer$headers$`x-fb-trace-id`))
            out_headers <- append(out_headers, setNames(list(headers(answer)), answer$headers$`x-fb-trace-id`))
            
            queryrep <- fbAPILimitCheck( answer, console_type, pb, pb_step, accounts_id, dates_df, pause_time )
          }
          
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
          
          # action breakdown handing
          if ( "actions" %in% unlist(str_split(fields, ",")) ) {
            
            # switch functions
            class(answerobject) <- answer_class
            
            #Adding data to result
            tempData <- fbAction(answerobject)
            
            result   <- bind_rows(result, tempData)
            
            if (exists("tempData")) {
              rm(tempData)
            }
            
          } else {
            #Adding data to result
            tempData <- bind_rows(answerobject$data)
            result   <- bind_rows(result, tempData,)
          }
        }
      }
    }
    
    # prepare output
    # unnesting_values
    vlist <- select_if(result, is.list) %>% names()

    for ( l in vlist ) {

      result <- unnest_wider(result, l, names_sep = "_") %>%
                      select(-matches("^.*\\_action\\_type"))

    }

    # renaming
    newnames <- names(result) %>%
                str_remove_all("NA") %>%
                str_remove("^\\_") %>%
                str_replace("\\_\\_", "\\_") %>%
                str_remove("\\_value$")
   
    names(result) <- newnames
    
    # set attributes
    attr(result, "request_ids") <- rq_ids
    attr(result, "headers")     <- out_headers
    
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