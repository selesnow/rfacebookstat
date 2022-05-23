fbGetBusinessManagersUsers <- function(business_ids  = getOption("rfacebookstat.business_id"),
                                       user_types    = c('business_users', 'system_users', 'pending_users'),
                                       api_version   = getOption("rfacebookstat.api_version"), 
                                       username      = getOption("rfacebookstat.username"),
                                       token_path    = fbTokenPath(),
                                       access_token  = getOption("rfacebookstat.access_token")) {
  
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
  
  if ( is.null(access_token) || is.null(business_ids) ) {
    stop("Arguments access_token and business_id is require.")
  }
  
  # result obj
  result <- list()
  
  # activate progress bar
  if ( length(business_ids) > 1 ) {
    
    pgbar <- TRUE
    pb_step <- 1
    pb      <- txtProgressBar(pb_step, 
                              length(business_ids), 
                              style = 3, 
                              title = "Loading:", 
                              label = "load" )
    
  } else {
    
    # progres bar
    pgbar <- FALSE
    
  }
  
  # bussiness ids
  for (business_id in  business_ids) {

    # user types
    for (type in user_types) {

      url <- str_interp("https://graph.facebook.com/${api_version}/${business_id}/${type}")
      
      api_answer  <- GET(url, 
                         query = list(fields       = "id,name,business,first_name,last_name,title,role,email",
                                      limit        = 1000,
                                      access_token = access_token))
      
      pars_answer <- content(api_answer, as = "parsed")
      
      if(!is.null(pars_answer$error)) {
        error <- pars_answer$error
        stop(pars_answer$error)
      }
      
      if (length(pars_answer$data) == 0) {
        
        # set progress bar
        if( pgbar ) {
          pb_step <- pb_step + 1
          setTxtProgressBar(pb, pb_step)
        }
        
        next
        
      }
      
      
      # pars
      result <- append(result, 
                       lapply( pars_answer$data, fbParserBMUsers, user_type = type))
      
      # paging
      while (!is.null(pars_answer$paging$`next`)) {
        
        api_answer  <- GET(pars_answer$paging$`next`)
        pars_answer <- content(api_answer, as = "parsed")
        
        # pars
        result <- append(result, 
                         lapply( pars_answer$data, fbParserBMUsers, user_type = type))
        
      }
      
      # pause between query
      if (pgbar) Sys.sleep(0.2)  
      
    }
    
    # pause between query
    if (pgbar) Sys.sleep(0.2)  
    
    # set progress bar
    if( pgbar ) {
      pb_step <- pb_step + 1
      setTxtProgressBar(pb, pb_step)
    }
    
  }
  
  # to df
  result <- map_df(result, flatten)
  
  # result
  return(result)                                       
                                        
}
