fbGetAdAccountUsersPermissions <- function(accounts_id = NULL ,
                                           api_version = "v3.1",
                                           console_type = "progressbar",
                                           access_token = NULL){

  if(is.null(accounts_id)|is.null(access_token)){
    stop("Arguments accounts_id and access_token is require.")
  }

  #Create
  result <- data.frame(stringsAsFactors = F)

  accounts_id <- ifelse(grepl("^act_",accounts_id),accounts_id,paste0("act_",accounts_id))

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
  return(result)
}
