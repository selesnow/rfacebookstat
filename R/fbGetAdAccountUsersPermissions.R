fbGetAdAccountUsersPermissions <- function(accounts_id = getOption("rfacebookstat.accounts_id") ,
                                           api_version = getOption("rfacebookstat.api_version"),
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

  # attributes
  rq_ids      <- list()
  out_headers <- list()
  
  #Create
  result <- data.frame(stringsAsFactors = F)

  accounts_id <- ifelse(grepl("^act_",accounts_id), accounts_id, paste0("act_",accounts_id))

  #Progress settings
  pb_step <- 1

  if(console_type == "progressbar" & length(accounts_id) > 1){
    pb <- utils::txtProgressBar(pb_step, length(accounts_id), style = 3)}
  else{
    console_type <- "message"
  }

  for(account in accounts_id){

    QueryString <- paste0("https://graph.facebook.com/",api_version,"/",account,"/users","?access_token=",access_token)
    ans <- httr::GET(QueryString)
	
    # attr
    rq_ids      <- append(rq_ids, setNames(list(status_code(ans)), ans$headers$`x-fb-trace-id`))
    out_headers <- append(out_headers, setNames(list(headers(ans)), ans$headers$`x-fb-trace-id`))
	
    ans_pars <- httr::content(ans)

    if(console_type == "progressbar"){
      pb_step <- pb_step + 1
      utils::setTxtProgressBar(pb, pb_step)}

    if(length(ans_pars$data) == 0) next

    for(row in 1:length(ans_pars$data)){
      result <- rbind(result,
                      data.frame(name = ans_pars$data[[row]]$name,
                                 id   = ans_pars$data[[row]]$id,
                                 role = paste0(ans_pars$data[[row]]$tasks, collapse = ", "),
                                 account_id = account))
    }
  }
  
  # set attributes
  attr(result, "request_ids") <- rq_ids
  attr(result, "headers")     <- out_headers
  
  return(result)
}
