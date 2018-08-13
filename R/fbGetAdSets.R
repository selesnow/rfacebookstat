fbGetAdSets <- function(accounts_id = NULL,
                        api_version = 'v3.1',
                        access_token = NULL){
  QueryString <- paste0("https://graph.facebook.com/",api_version,"/",accounts_id,"/adsets?fields=id,name,account_id,adset_schedule,bid_amount,bid_strategy,billing_event,budget_remaining,campaign_id,configured_status,effective_status,status,optimization_goal,pacing_type,destination_type,daily_budget,created_time,source_adset_id&limit=1000&access_token=",access_token)

  result <- list()

  api_answer  <- GET(QueryString)
  pars_answer <- content(api_answer, as = "parsed")

  result <- c(result, pars_answer$data)

  # paging
  while (!is.null(pars_answer$paging$`next`)) {

    api_answer  <- GET(pars_answer$paging$`next`)
    pars_answer <- content(api_answer, as = "parsed")

    result <- c(result, pars_answer$data)
  }

  result <- bind_rows(result)
  return(result)}

