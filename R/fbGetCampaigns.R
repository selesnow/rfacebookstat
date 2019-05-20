fbGetCampaigns <- function(accounts_id = getOption("rfacebookstat.accounts_id"),
                           api_version = getOption("rfacebookstat.api_version"),
                           access_token = getOption("rfacebookstat.access_token")){
  QueryString <- paste0("https://graph.facebook.com/",api_version,"/",accounts_id,"/campaigns?fields=id,name,created_time,bid_strategy,daily_budget,budget_remaining,spend_cap,buying_type,status,configured_status,account_id,recommendations,source_campaign_id&limit=1000",
                                                "&filtering=[{'field':'campaign.delivery_info','operator':'NOT_IN','value':['stupid_filter']}]",
                                                "&access_token=",access_token)
  
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
