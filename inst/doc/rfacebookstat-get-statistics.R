## ----setup, include = FALSE----------------------------------------------
knitr::opts_chunk$set(
  eval=FALSE,
  collapse = TRUE,
  comment = "#>"
)

## ------------------------------------------------------------------------
#  library(rfacebookstat)
#  
#  options(rfacebookstat.access_token = "ваш токен",
#          rfacebookstat.accounts_id  = "act_000000000")
#  
#  fb_data <- fbGetMarketingStat(
#                    level              = "campaign",
#                    fields             = "campaign_name,
#                                          impressions,
#                                          clicks,
#                                          spend,
#                                          actions",
#                    date_start         = "2019-05-01",
#                    date_stop          = "2019-05-10")

## ------------------------------------------------------------------------
#  library(rfacebookstat)
#  
#  options(rfacebookstat.access_token = "ваш токен",
#          rfacebookstat.accounts_id  = "act_000000000")
#  
#  fb_data_breakdowns <- fbGetMarketingStat(
#    level              = "campaign",
#    fields             = "campaign_name,
#                          impressions,
#                          clicks,
#                          spend,
#                          actions",
#    breakdowns         = "region",
#    date_start         = "2019-05-01",
#    date_stop          = "2019-05-10")

## ------------------------------------------------------------------------
#  library(rfacebookstat)
#  
#  options(rfacebookstat.access_token = "ваш токен",
#          rfacebookstat.accounts_id  = "act_000000000")
#  
#  fb_data_action_breakdowns <- fbGetMarketingStat(
#    level              = "campaign",
#    fields             = "campaign_name,
#                          impressions,
#                          clicks,
#                          spend,
#                          actions",
#    action_breakdowns  = "action_reaction",
#    date_start         = "2019-05-01",
#    date_stop          = "2019-05-10")

## ------------------------------------------------------------------------
#  library(rfacebookstat)
#  
#  options(rfacebookstat.access_token = "ваш токен",
#          rfacebookstat.accounts_id  = "act_000000000")
#  fb_data <- fbGetMarketingStat(
#    level              = "campaign",
#    fields             = "campaign_name,
#                          impressions,
#                          clicks,
#                          spend,
#                          actions",
#    filtering          = "impressions LESS_THAN 5000",
#    date_start         = "2019-05-01",
#    date_stop          = "2019-05-10")

## ------------------------------------------------------------------------
#  library(rfacebookstat)
#  
#  options(rfacebookstat.access_token = "ваш токен",
#          rfacebookstat.accounts_id  = "act_000000000")
#  fb_data <- fbGetMarketingStat(
#    level              = "campaign",
#    fields             = "campaign_name,
#                          impressions,
#                          clicks,
#                          spend,
#                          actions",
#    filtering          = "publisher_platform IN instagram,facebook",
#    breakdowns         = "publisher_platform",
#    date_start         = "2019-05-01",
#    date_stop          = "2019-05-10")

## ------------------------------------------------------------------------
#  library(rfacebookstat)
#  
#  options(rfacebookstat.access_token = "ваш токен",
#          rfacebookstat.accounts_id  = "act_000000000")
#  fb_data <- fbGetMarketingStat(
#    level              = "campaign",
#    fields             = "campaign_name,
#                          impressions,
#                          clicks,
#                          spend,
#                          actions",
#    filtering          = c("clicks LESS_THAN 500", "impressions GREATER_THAN 1000"),
#    date_start         = "2019-05-01",
#    date_stop          = "2019-05-10")

