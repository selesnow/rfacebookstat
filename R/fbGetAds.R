fbGetAds <- function(accounts_id = NULL,
                     api_version = 'v3.1',
                     access_token = NULL){
  QueryString <- paste0("https://graph.facebook.com/",api_version,"/",accounts_id,"/ads?fields=id,name,object_url,adlabels,adset_id,bid_amount,bid_type,campaign_id,account_id,configured_status,effective_status,creative&limit=1000&access_token=",access_token)
  
  result <- data.frame()
  
  api_answer  <- GET(QueryString)
  pars_answer <- content(api_answer, as = "parsed")
  
  if(!is.null(pars_answer$error)) {
    error <- pars_answer$error
    message(message(pars_answer$error))
  }
  
  for (obj in 1:length(pars_answer$data)) {
    result <- bind_rows(result,
                        data.frame(id = pars_answer$data[[obj]]$id,
                                   name = pars_answer$data[[obj]]$name,
                                   creative_id = pars_answer$data[[obj]]$creative$id,
                                   adset_id = pars_answer$data[[obj]]$adset_id,
                                   campaign_id = pars_answer$data[[obj]]$campaign_id,
                                   account_id = pars_answer$data[[obj]]$account_id,
                                   bid_amount = ifelse( is.null(pars_answer$data[[obj]]$bid_amount), NA, pars_answer$data[[obj]]$bid_amount),
                                   bid_type = pars_answer$data[[obj]]$bid_type,
                                   configured_status = pars_answer$data[[obj]]$configured_status,
                                   effective_status = pars_answer$data[[obj]]$effective_status
                        ))
    
  }
  
  # paging
  while (!is.null(pars_answer$paging$`next`)) {
    
    api_answer  <- GET(pars_answer$paging$`next`)
    pars_answer <- content(api_answer, as = "parsed")
    
    for (obj in 1:length(pars_answer$data)) {
      result <- bind_rows(result,
                          data.frame(id = pars_answer$data[[obj]]$id,
                                     name = pars_answer$data[[obj]]$name,
                                     creative_id = pars_answer$data[[obj]]$creative$id,
                                     adset_id = pars_answer$data[[obj]]$adset_id,
                                     campaign_id = pars_answer$data[[obj]]$campaign_id,
                                     account_id = pars_answer$data[[obj]]$account_id,
                                     bid_amount = ifelse( is.null(pars_answer$data[[obj]]$bid_amount), NA, pars_answer$data[[obj]]$bid_amount),
                                     bid_type = pars_answer$data[[obj]]$bid_type,
                                     configured_status = pars_answer$data[[obj]]$configured_status,
                                     effective_status = pars_answer$data[[obj]]$effective_status))
      
  }
}
return(result)}
