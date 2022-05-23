
# fetchBy date range ------------------------------------------------------
fbDateRanges <- function(start, end, by) {
  start <- as.Date(start)
  end <- as.Date(end)
  by <- tolower(by)
  by <- match.arg(by, c("day", "week", "month", "quarter", "year"))
  dates <- seq.Date(start, end, by = by)
  res <- cbind(start = as.character(dates),
               end = as.character(c(dates[-1] - 1, end)))
  as.data.frame(res, stringsAsFactors = F)
}


# main fun - helper -------------------------------------------------------
fbGetMarketingStatHelper <-
  function(accounts_id        = getOption("rfacebookstat.accounts_id"),
           sorting            = NULL,
           level              = "account",
           breakdowns         = NULL,
           action_breakdowns  = NULL,
           fields             = "account_id,campaign_name,impressions,clicks,reach,spend",
           filtering          = NULL,
           date_start         = NULL,
           date_stop          = NULL,
           date_preset        = 'last_30d',
           attribution_window = NULL,
           api_version        = getOption("rfacebookstat.api_version"),
           action_report_time = NULL,
           interval           = "day",
           use_account_attribution_setting = FALSE,
           console_type       = "progressbar",
           request_speed      = "normal",
           fetch_by           = NULL,
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
    
    if ( inherits(access_token, "fb_access_token") ) {
      
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
    
    # time_increment
    if ( interval == "overall" ) {
      #dates_from <- as.Date(date_start)
      #dates_to   <- as.Date(date_stop)
      time_increment <- 'all_days' 
      
    } else if ( interval == 'day' ) {
      
      time_increment <- 1
      
    } else if ( interval == 'weekly' ) {
      
      time_increment <- 7
    
    } else {
      
      time_increment <- interval
      
    }
    
    # time_range
    if ( !is.null(date_start) & !is.null(date_stop) ) {
      
      time_range <- str_interp("{\"since\":\"${date_start}\",\"until\":\"${date_stop}\"}")
      
    } else {
      
      time_range <- NULL
      
    }
    
    # use_account_attribution_setting
    if ( use_account_attribution_setting ) {
      
      use_account_attribution_setting <- 'true'
      
    } else {
      
      use_account_attribution_setting <- 'false'
      
    }
    #################################################
    # OLD VERSION OF CODE, WITH OUT time_range AND  #
    # time_increment                                #
    # date: 2020-09-24                              #
    #################################################
    
    # else {
    #   #Check dates interval
    #   dates_from <- seq.Date(as.Date(date_start), as.Date(date_stop), by = interval)
    #   dates_to   <- as.Date(dates_from - 1)
    #   dates_to   <- c(as.Date(dates_to[-1]),as.Date(date_stop))
    # 
    # }
    # # Create time interval data frame
    # dates_df   <- data.frame(dates_from = dates_from,
    #                          dates_to   = dates_to)
    
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
    if(length(accounts_id) < 2){
      console_type <- "message"  
    }
    
    if(console_type == "progressbar"){      
      #Progress settings
      pb_step <- 1
      pb <- utils::txtProgressBar(pb_step, length(accounts_id), style = 3,title = "Loading:", label = "load" )}
    
    #API request counter
    request_counter <- 0
    error_counter   <- 0
    
    for(i in 1:length(accounts_id)) {
      
      #################################################
      # OLD VERSION OF CODE, WITH OUT time_range AND  #
      # time_increment                                #
      # date: 2020-09-24                              #
      #################################################
      
      # #Intervals flatten
      # for(dt in 1:nrow(dates_df)){
        
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
                                       time_increment             = time_increment,
                                       time_range                 = time_range,
                                       date_preset                = date_preset,
                                       use_account_attribution_setting = use_account_attribution_setting,
                                       limit                      = 1000,
                                       access_token               = access_token))
        
      # attr
      rq_ids      <- append(rq_ids, setNames(list(status_code(answer)), answer$headers$`x-fb-trace-id`))
      out_headers <- append(out_headers, setNames(list(headers(answer)), answer$headers$`x-fb-trace-id`))
        
      # check limit
      queryrep <- fbAPILimitCheck( answer, console_type, pb, pb_step, accounts_id, pause_time  )
        
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
                                           time_increment             = 1,
                                           time_range                 = time_range,
                                           date_preset                = date_preset,
                                           use_account_attribution_setting = use_account_attribution_setting,
                                           limit                      = 1000,
                                           access_token               = access_token))
          
          # attr
          rq_ids      <- append(rq_ids, setNames(list(status_code(answer)), answer$headers$`x-fb-trace-id`))
          out_headers <- append(out_headers, setNames(list(headers(answer)), answer$headers$`x-fb-trace-id`))
          
          queryrep <- fbAPILimitCheck( answer, console_type, pb, pb_step, accounts_id, pause_time )
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
              message("WARNING: User request limit reached", appendLF = T)
              message("Apply the mechanism for circumvention of the limit", appendLF = T)
              message("Wait few minutes.", appendLF = T)}
            #Start cycle
            while(attempt <= 6){
              if(console_type == "message"){
                message(paste0("attempt number: ",attempt), appendLF = T)}
              
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
                                               time_increment     = 1,
                                               time_range         = time_range,
                                               date_preset        = date_preset,
                                               use_account_attribution_setting = use_account_attribution_setting,
                                               limit              = 1000,
                                               access_token       = access_token))
              
            # attr
            rq_ids      <- append(rq_ids, setNames(list(status_code(answer)), answer$headers$`x-fb-trace-id`))
            out_headers <- append(out_headers, setNames(list(headers(answer)), answer$headers$`x-fb-trace-id`))
              
              request_counter <- request_counter + 1
              answerobject <- httr::content(answer, as = "parsed")
              
              #If many limits up pause time
              if(error_counter >= 3 & pause_time < 5){
                if(console_type == "message"){
                  message("WARNING: More 3 limits error, magnified pause time on 1.5", appendLF = T)}
                pause_time <- pause_time * 1.5
              }
              
              #Check new answer
              if(is.null(answerobject$error$message)) {
                if(console_type == "message"){
                  message("Problem fixed. Continue data collection", appendLF = T)}
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
        if ( any(c("actions", "action_values", "conversions", "conversion_values") %in% unlist(str_split(fields, ","))) ) {
          
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
          queryrep <- fbAPILimitCheck( answer, console_type, pb, pb_step, accounts_id, pause_time )
          
          # reapet query if out of apilimit
          while ( queryrep ) {
            
            answer <- httr::GET(QueryString)
            
            # attr
            rq_ids      <- append(rq_ids, setNames(list(status_code(answer)), answer$headers$`x-fb-trace-id`))
            out_headers <- append(out_headers, setNames(list(headers(answer)), answer$headers$`x-fb-trace-id`))
            
            queryrep <- fbAPILimitCheck( answer, console_type, pb, pb_step, accounts_id, pause_time )
            
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
                message("WARNING: User request limit reached", appendLF = T)
                message("Apply the mechanism for circumvention of the limit", appendLF = T)
                message("Wait few minutes.", appendLF = T)}
              #Start cycle
              while(attempt <= 5){
                if(console_type == "message"){
                  message(paste0("attempt number: ",attempt), appendLF = T)}
                
                #Wait one minute and repaete
                Sys.sleep(61)
                
                #Repeate API request
                answer <- httr::GET(QueryString)
                request_counter <- request_counter + 1
                answerobject <- httr::content(answer, as = "parsed")
                
                #Check new answer
                if(is.null(answerobject$error$message)) {
                  if(console_type == "message"){
                    message("Problem fixed. Continue data collection", appendLF = T)}
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
      utils::setTxtProgressBar(pb, length(accounts_id))
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


# cycle_fun ---------------------------------------------------------------
fbGetMarketingStat <-
  function(accounts_id        = getOption("rfacebookstat.accounts_id"),
           sorting            = NULL,
           level              = "account",
           breakdowns         = NULL,
           action_breakdowns  = NULL,
           fields             = "account_id,campaign_name,impressions,clicks,reach,spend",
           filtering          = NULL,
           date_start         = NULL,
           date_stop          = NULL,
           date_preset        = 'last_30d',
           attribution_window = NULL,
           api_version        = getOption("rfacebookstat.api_version"),
           action_report_time = NULL,
           interval           = "day",
           use_account_attribution_setting = FALSE,
           console_type       = "progressbar",
           request_speed      = "normal",
           fetch_by           = NULL,
           username           = getOption("rfacebookstat.username"),
           token_path         = fbTokenPath(),
           access_token       = getOption("rfacebookstat.access_token")) {
    
    
    # FetchBy
    if ( !is.null(fetch_by) ) {
      
      #dates df
      dates <- fbDateRanges(date_start, date_stop, fetch_by)
      n <- nrow(dates)
      message("Batch processing mode is enabled.")
      message(paste0("Fetching data by ", tolower(fetch_by), ": from ", as.Date(date_start), " to ", as.Date(date_stop), "."))
      console_type <- "message" 
      
    } else {
      #dates df
      dates <- as.data.frame(list(date_start, date_stop), col.names = c("start","end"), stringsAsFactors = F)
      n <- 1
    }
    
    
    if ( n > 1 ) {
      
      # apply fetching
      result <- pblapply(1:n,
                function(X) {
                  suppressMessages( {
                  suppressPackageStartupMessages( {
                   fbGetMarketingStatHelper( 
                       accounts_id        = accounts_id,
                       sorting            = sorting,
                       level              = level,
                       breakdowns         = breakdowns,
                       action_breakdowns  = action_breakdowns,
                       fields             = fields,
                       filtering          = filtering,
                       date_start         = dates$start[X],
                       date_stop          = dates$end[X],
                       date_preset        = date_preset,
                       attribution_window = attribution_window,
                       api_version        = api_version,
                       action_report_time = action_report_time,
                       interval           = interval,
                       use_account_attribution_setting = use_account_attribution_setting,
                       console_type       = console_type,
                       request_speed      = request_speed,
                       fetch_by           = fetch_by,
                       username           = username,
                       token_path         = token_path,
                       access_token       = access_token
                       )
                }
                )
          }
          )
      }
      )
      
    } else {
      
      # simple request
      result <- fbGetMarketingStatHelper( 
                      accounts_id        = accounts_id,
                      sorting            = sorting,
                      level              = level,
                      breakdowns         = breakdowns,
                      action_breakdowns  = action_breakdowns,
                      fields             = fields,
                      filtering          = filtering,
                      date_start         = dates$start,
                      date_stop          = dates$end,
                      date_preset        = date_preset,
                      attribution_window = attribution_window,
                      api_version        = api_version,
                      action_report_time = action_report_time,
                      interval           = interval,
                      use_account_attribution_setting = use_account_attribution_setting,
                      console_type       = console_type,
                      request_speed      = request_speed,
                      fetch_by           = fetch_by,
                      username           = username,
                      token_path         = token_path,
                      access_token       = access_token
                    )
                      
    }
    
    # collect all data
    result <- bind_rows(result)

    # return 
    return( result )
  }
