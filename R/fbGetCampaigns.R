fbGetCampaigns <- function(accounts_id = NULL,
                           api_version = 'v3.1',
                           access_token = NULL){
  QueryString <- paste0("https://graph.facebook.com/",api_version,"/",accounts_id,"/campaigns?fields=id,name,created_time,bid_strategy,daily_budget,budget_remaining,spend_cap,buying_type,status,configured_status,account_id,recommendations,source_campaign_id&limit=1000&access_token=",access_token)
  
  result <- list()
  
  api_answer  <- GET(QueryString)
  pars_answer <- content(api_answer, as = "parsed")
  
  if(!is.null(pars_answer$error)) {
    error <- pars_answer$error
    message(message(pars_answer$error))
  }
  
  result <- c(result, pars_answer$data)
  
  # paging
  while (!is.null(pars_answer$paging$`next`)) {
    
    api_answer  <- GET(pars_answer$paging$`next`)
    pars_answer <- content(api_answer, as = "parsed")
    
    result <- c(result, pars_answer$data)
  }
  
  result <- bind_rows(result)
  return(result)
}
