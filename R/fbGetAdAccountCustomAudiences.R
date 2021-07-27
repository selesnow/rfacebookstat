fbGetAdAccountCustomAudiences <- 
  function(
    business_ids = getOption("rfacebookstat.business_id"),
    accounts_id  = getOption("rfacebookstat.accounts_id"),
    pixel_id     = NULL,
    filtering    = NULL,
    api_version  = getOption("rfacebookstat.api_version"),
    username     = getOption("rfacebookstat.username"),
    token_path   = fbTokenPath(),
    access_token = getOption("rfacebookstat.access_token")) {
    
    
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
    
    
    # attributes
    rq_ids      <- list()
    out_headers <- list()
    
    res <- list()
    
    
    # load account list
    if ( is.null(accounts_id) ) {
      
      message("...Loading your account list.")
      accounts_id <- suppressMessages(fbGetAdAccounts()$id)
      message("...Loading customaudiences from ", length(accounts_id), " account", ifelse( length(accounts_id) > 1, "s", "" ))
      
    }
    
    # activate progress bar
    if ( length(accounts_id) > 1 ) {
      
      pgbar <- TRUE
      pb_step <- 1
      pb      <- txtProgressBar(pb_step, 
                                length(accounts_id), 
                                style = 3, 
                                title = "Loading:", 
                                label = "load" )
      
    } else {
      
      # progres bar
      pgbar <- FALSE
      
    }
    
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
    
    for( account_id in accounts_id ) {
      
      
      url <- str_interp("https://graph.facebook.com/${api_version}/${account_id}/customaudiences")
      
      api_answer  <- GET(url, 
                         query = list(fields       = "id,account_id,approximate_count,customer_file_source,data_source,delivery_status,description,external_event_source,is_value_based,lookalike_audience_ids,lookalike_spec,name,operation_status,opt_out_link,permission_for_actions,pixel_id,retention_days,rule,rule_aggregation,sharing_status,subtype,time_content_updated,time_created,time_updated",
                                      filtering    = filtering,
                                      limit        = 30,
                                      access_token = access_token))
      
      # attr
      rq_ids      <- append(rq_ids, setNames(list(status_code(api_answer)), api_answer$headers$`x-fb-trace-id`))
      out_headers <- append(out_headers, setNames(list(headers(api_answer)), api_answer$headers$`x-fb-trace-id`))
      
      pars_answer <- content(api_answer, as = "parsed")
      
      if(!is.null(pars_answer$error)) {
        error <- pars_answer$error
        if ( length(accounts_id) > 1 ) {
            warning(account_id, ' - ', pars_answer$error$message)
            next
        } else {
            stop("\n",pars_answer$error$message,"\n")
        }
      }
      
      # pars
      temp <- tibble(data = pars_answer$data) %>% 
              unnest_wider('data')
      
      if ( 'data_source' %in% names(temp) )            temp <- unnest_wider(temp, 'data_source', names_sep = "_")
      if ( 'delivery_status' %in% names(temp) )        temp <- unnest_wider(temp, 'delivery_status', names_sep = "_")
      if ( 'operation_status' %in% names(temp) )       temp <- unnest_wider(temp, 'operation_status', names_sep = "_")
      if ( 'permission_for_actions' %in% names(temp) ) temp <- unnest_wider(temp, 'permission_for_actions', names_sep = "_")
      if ( 'external_event_source' %in% names(temp) )  temp <- rowwise(temp) %>% mutate('external_event_source' = paste0(unlist('external_event_source'), collapse = ', '))
      if ( 'lookalike_audience_ids' %in% names(temp) ) temp <- rowwise(temp) %>% mutate('lookalike_audience_ids'  = paste0(unlist('lookalike_audience_ids'), collapse = ', '))
      if ( 'lookalike_spec' %in% names(temp) )         temp <- unnest_wider(temp, 'lookalike_spec', names_sep = "_") %>% unnest_wider('lookalike_spec_origin', names_sep = '_') %>% unnest_wider('lookalike_spec_origin_1', names_sep = "_")
      
      res <- append(res, 
                    list(temp))
      
      # paging
      while (!is.null(pars_answer$paging$`next`)) {
        
        api_answer  <- GET(pars_answer$paging$`next`)
        pars_answer <- content(api_answer, as = "parsed")
        
        if(!is.null(pars_answer$error)) {
          error <- pars_answer$error
          if ( length(accounts_id) > 1 ) {
            warning(account_id, ' - ', pars_answer$error$message)
            next
          } else {
            stop("\n",pars_answer$error$message,"\n")
          }
        }
        
        # pause between query
        Sys.sleep(0.2) 
        
        # pars
        temp <- tibble(data = pars_answer$data) %>% 
          unnest_wider('data')
        
        if ( 'data_source' %in% names(temp) )            temp <- unnest_wider(temp, 'data_source', names_sep = "_")
        if ( 'delivery_status' %in% names(temp) )        temp <- unnest_wider(temp, 'delivery_status', names_sep = "_")
        if ( 'operation_status' %in% names(temp) )       temp <- unnest_wider(temp, 'operation_status', names_sep = "_")
        if ( 'permission_for_actions' %in% names(temp) ) temp <- unnest_wider(temp, 'permission_for_actions', names_sep = "_")
        if ( 'external_event_source' %in% names(temp) )  temp <- rowwise(temp) %>% mutate('external_event_source' = paste0(unlist('external_event_source'), collapse = ', '))
        if ( 'lookalike_audience_ids' %in% names(temp) ) temp <- rowwise(temp) %>% mutate('lookalike_audience_ids'  = paste0(unlist('lookalike_audience_ids'), collapse = ', '))
        if ( 'lookalike_spec' %in% names(temp) )         temp <- unnest_wider(temp, 'lookalike_spec', names_sep = "_") %>% unnest_wider('lookalike_spec_origin', names_sep = '_') %>% unnest_wider('lookalike_spec_origin_1', names_sep = "_")
        
        res <- append(res, 
                      list(temp))
        
      }
      
      # pause between query
      Sys.sleep(0.2)  
      
      # set progress bar
      if( pgbar ) {
        pb_step <- pb_step + 1
        setTxtProgressBar(pb, pb_step)
      }
    }
    
    
    res <- bind_rows(res)
    
    # set attributes
    attr(res, "request_ids") <- rq_ids
    attr(res, "headers")     <- out_headers
    
    # close pb
    if( pgbar ) close(pb)
    
    return(res)
    
  }