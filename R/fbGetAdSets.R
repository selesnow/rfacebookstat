fbGetAdSets <- function(accounts_id = getOption("rfacebookstat.accounts_id"),
                        api_version = getOption("rfacebookstat.api_version"),
                        access_token = getOption("rfacebookstat.access_token")){
  QueryString <- paste0("https://graph.facebook.com/",api_version,"/",accounts_id,"/adsets?fields=id,name,account_id,adset_schedule,bid_amount,bid_strategy,billing_event,budget_remaining,campaign_id,configured_status,effective_status,status,optimization_goal,pacing_type,destination_type,daily_budget,created_time,source_adset_id&limit=1000",
                                                "&filtering=[{'field':'adset.delivery_info','operator':'NOT_IN','value':['stupid_filter']}]",
                                                "&access_token=",access_token)

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

