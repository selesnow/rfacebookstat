# limit check
print.fblimits <- function(x, ...) {
  cat(str_interp(" call_count: ${x[[1]]$call_count} \n total_cputime: ${x[[1]]$total_cputime} \n total_time: ${x[[1]]$total_time}"))
}


fbAPILimitCheck <- function( api_answer, console_type, pb, pb_step, accounts_id, pause_time ) {
  
  rep_query <- FALSE
  
  if ( "x-business-use-case-usage" %in% names(headers(api_answer)) ) {
    
    limitions <- fromJSON(headers(api_answer)$`x-business-use-case-usage`)
    
    class(limitions) <- "fblimits"
    
    if ( any( limitions[[1]]$call_count > 85, limitions[[1]]$total_cputime > 85, limitions[[1]]$total_time > 85 ) ) {
      
      if ( exists("console_type") ) {
        if (console_type == "progressbar"){
          close(pb)}
      }
      
      message("API Rate Limit Spent more than 85%")
      print(limitions)
      
      pause_time <- pause_time * 1.5
      
      if ( limitions[[1]]$estimated_time_to_regain_access > 0 ) {
        
        rep_query <- TRUE
      
        message("Wait for estimated_time_to_regain_access: ", limitions[[1]]$estimated_time_to_regain_access, " minutes")
        
        wait_minutes <- limitions[[1]]$estimated_time_to_regain_access
        
        wait_pb <- txtProgressBar(min = 0, max = wait_minutes, style = 3, title = "Please Waiting")
        
        for ( p in 1:wait_minutes ) {
          Sys.sleep( 60 )
          setTxtProgressBar(wait_pb, value = p, title = "Please Waiting")
        }
        Sys.sleep( 2 )
        close(wait_pb)
        
        if ( exists("console_type") ) {
          if (console_type == "progressbar"){
            pb <- txtProgressBar(pb_step, length(accounts_id), style = 3)
            utils::setTxtProgressBar(pb, pb_step)
          }
      }
    }
  }
}
  
  return(rep_query)
}
