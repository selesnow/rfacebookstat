# block for parsing helpers function
# check for null
fbNullReplacer <- function(x) {
  
  return(
    ifelse( is.null(x), 
            NA,
            x) 
  )
}

# pasing ads
fbParserAds <- function(x) {
  
  return(
    list(id                = x$id,
         name              = x$name,
         creative_id       = x$creative$id,
         adset_id          = x$adset_id,
         campaign_id       = x$campaign_id,
         account_id        = x$account_id,
         bid_amount        = fbNullReplacer(x$bid_amount) ,
         bid_type          = x$bid_type,
         configured_status = x$configured_status,
         effective_status  = x$effective_status)
  )
  
}



# pasing ad creatives
fbParserAdCreatives <- function(x) {
  
  return(
    list(
      id               = x$id,
      name             = x$name,
      title            = x$title,
      body             = x$body,
      status           = x$status,
      url_tags         = fbNullReplacer(x$url_tags),
      account_id       = fbNullReplacer(x$account_id),
      page_id          = fbNullReplacer(x$object_story_spec$page_id), 
      link             = fbNullReplacer(x$object_story_spec$link_data$link), 
      link_nested      = ifelse(is.null(x$object_story_spec$link_data$child_attachments), 
                                NA, 
                                paste0(lapply(x$object_story_spec$link_data$child_attachments, 
                                              function (x) paste0(x$link)), collapse = ";")), 
      call_to_action   = ifelse(is.null(x$object_story_spec$link_data$call_to_action), 
                                NA, 
                                paste0(lapply(x$object_story_spec$link_data$call_to_action, 
                                              function (x) paste0(x)), collapse = ",")),
      message          = fbNullReplacer(x$object_story_spec$link_data$message), 
      caption          = fbNullReplacer(x$object_story_spec$link_data$caption), 
      attachment_style = fbNullReplacer(x$object_story_spec$link_data$attachment_style), 
      description      = fbNullReplacer(x$object_story_spec$link_data$description), 
      image_hash       = fbNullReplacer(x$object_story_spec$link_data$image_hash),
      object_type      = fbNullReplacer(x$object_type)
    )
  )
  
}

# pasing bussines managers
fbParserBM <- function(x) {
  
  return(
    list(id                       = x$id,
         name                     = x$name,
         primary_page_id          = x$primary_page$id,
         primary_page_name        = x$primary_page$name,
         created_by_id            = x$created_by$id,
         created_by_name          = x$created_by$name,
         created_by_business_id   = x$created_by$business$id,
         created_by_business_name = x$created_by$business$name)
  )
  
}

# advideo parser
fbParserAdVideos <- function(x, account_id) {
  
  return(
    list(id                       = x$id,
         video_status             = fbNullReplacer(x$status$video_status),
         processing_progress      = fbNullReplacer(x$status$processing_progress),
         published                = x$published,
         source                   = x$source,
         length                   = x$length,
         icon                     = x$icon,
         content_category         = x$content_category,
         created_time             = x$created_time,
         updated_time             = x$updated_time,
         embeddable               = x$embeddable,
         embed_html               = x$embed_html,
         is_crosspost_video       = x$is_crosspost_video,
         is_crossposting_eligible = x$is_crossposting_eligible,
         is_episode               = x$is_episode,
         is_instagram_eligible    = x$is_instagram_eligible,
         account_id               = account_id)
  )
  
}

# conversions parser
fbParserAdConversions <- function(x) {
  
  return(
    list(id                       = x$id,
         name                     = x$name,
         rule                     = x$rule,
         creation_time            = x$creation_time,
         custom_event_type        = x$custom_event_type,
         default_conversion_value = x$default_conversion_value,
         event_source_type        = x$event_source_type,
         first_fired_time         = fbNullReplacer(x$first_fired_time),
         is_archived              = x$is_archived,
         is_unavailable           = x$is_unavailable,
         pixel_ids                = ifelse(is.null(x$pixel), 
                                           NA, 
                                           paste0(lapply(x$pixel, 
                                                         function (x) paste0(x)), collapse = ",")), 
         retention_days           = x$retention_days,
         account_id               = x$account_id)
  )
  
}
