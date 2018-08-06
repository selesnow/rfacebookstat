fbGetAdCreative <- function(accounts_id = NULL,
                            api_version = 'v3.1',
                            access_token = NULL){
  QueryString <- paste0("https://graph.facebook.com/",api_version,"/",accounts_id,"/adcreatives?fields=ad_id,name,status,url_tags,object_story_spec,account_id&limit=1000&access_token=",access_token)
  
  res <- data.frame()
  api_answer  <- GET(QueryString)
  pars_answer <- content(api_answer, as = "parsed")
  
  if(!is.null(pars_answer$error)) {
    error <- pars_answer$error
    message(message(pars_answer$error))
  }
  
  # parsing 
  for (obj in 1:length(pars_answer$data)) {
    res <- bind_rows(res,
                     data.frame(
                       id     = pars_answer$data[[obj]]$id,
                       name   = pars_answer$data[[obj]]$name,
                       status = pars_answer$data[[obj]]$status,
                       url_tags =  ifelse(is.null(pars_answer$data[[obj]]$url_tags), NA, pars_answer$data[[obj]]$url_tags), 
                       account_id =  ifelse(is.null(pars_answer$data[[obj]]$account_id), NA, pars_answer$data[[obj]]$account_id),
                       page_id = ifelse(is.null(pars_answer$data[[obj]]$object_story_spec$page_id), NA, pars_answer$data[[obj]]$object_story_spec$page_id),
                       link = ifelse( is.null(pars_answer$data[[obj]]$object_story_spec$link_data$link), NA, pars_answer$data[[obj]]$object_story_spec$link_data$link),
                       message = ifelse( is.null(pars_answer$data[[obj]]$object_story_spec$link_data$message), NA, pars_answer$data[[obj]]$object_story_spec$link_data$message),
                       caption = ifelse( is.null(pars_answer$data[[obj]]$object_story_spec$link_data$caption), NA, pars_answer$data[[obj]]$object_story_spec$link_data$caption),
                       attachment_style = ifelse( is.null(pars_answer$data[[obj]]$object_story_spec$link_data$attachment_style), NA, pars_answer$data[[obj]]$object_story_spec$link_data$attachment_style),
                       description = ifelse( is.null(pars_answer$data[[obj]]$object_story_spec$link_data$description), NA, pars_answer$data[[obj]]$object_story_spec$link_data$description),
                       image_hash = ifelse( is.null(pars_answer$data[[obj]]$object_story_spec$link_data$image_hash), NA,pars_answer$data[[obj]]$object_story_spec$link_data$image_hash)))
  }
  
  # paging
  while (!is.null(pars_answer$paging$`next`)) {
    
    api_answer  <- GET(pars_answer$paging$`next`)
    pars_answer <- content(api_answer, as = "parsed")
    
    # parsing 
    for (obj in 1:length(pars_answer$data)) {
      res <- bind_rows(res,
                       data.frame(
                         id     = pars_answer$data[[obj]]$id,
                         name   = pars_answer$data[[obj]]$name,
                         status = pars_answer$data[[obj]]$status,
                         url_tags =  ifelse(is.null(pars_answer$data[[obj]]$url_tags), NA, pars_answer$data[[obj]]$url_tags), 
                         account_id =  ifelse(is.null(pars_answer$data[[obj]]$account_id), NA, pars_answer$data[[obj]]$account_id),
                         page_id = ifelse(is.null(pars_answer$data[[obj]]$object_story_spec$page_id), NA, pars_answer$data[[obj]]$object_story_spec$page_id),
                         link = ifelse( is.null(pars_answer$data[[obj]]$object_story_spec$link_data$link), NA, pars_answer$data[[obj]]$object_story_spec$link_data$link),
                         message = ifelse( is.null(pars_answer$data[[obj]]$object_story_spec$link_data$message), NA, pars_answer$data[[obj]]$object_story_spec$link_data$message),
                         caption = ifelse( is.null(pars_answer$data[[obj]]$object_story_spec$link_data$caption), NA, pars_answer$data[[obj]]$object_story_spec$link_data$caption),
                         attachment_style = ifelse( is.null(pars_answer$data[[obj]]$object_story_spec$link_data$attachment_style), NA, pars_answer$data[[obj]]$object_story_spec$link_data$attachment_style),
                         description = ifelse( is.null(pars_answer$data[[obj]]$object_story_spec$link_data$description), NA, pars_answer$data[[obj]]$object_story_spec$link_data$description),
                         image_hash = ifelse( is.null(pars_answer$data[[obj]]$object_story_spec$link_data$image_hash), NA,pars_answer$data[[obj]]$object_story_spec$link_data$image_hash)))
    }
  }
  return(res)
}
