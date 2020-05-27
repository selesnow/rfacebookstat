# helpers 
numsum <- function(x) return(as.numeric(x) %>% sum)
ga_date_format <- function(x) format(as.Date(x), "%Y%m%d")

# fix variables 
campaign_name <- NULL
adset_name <- NULL
ad_name <- NULL
spend <- NULL
impressions <- NULL
clicks <- NULL

# main function
fbGetCostData <- 
      function(accounts_id = getOption("rfacebookstat.accounts_id"),
               date_start         = Sys.Date() - 30,
               date_stop          = Sys.Date(),
               utm_source         = "facebook",
               utm_medium         = "cpc",
               username           = getOption("rfacebookstat.username"),
               token_path         = fbTokenPath(),
               access_token       = getOption("rfacebookstat.access_token")) {
        
        
        
        data <- fbGetMarketingStat(accounts_id  = accounts_id, 
                                   level        = "ad",
                                   fields       = "campaign_name,
                                                   adset_name,
                                                   ad_name,
                                                   impressions,
                                                   clicks,
                                                   spend",
                                   date_start   = date_start,
                                   date_stop    = date_stop, 
                                   username     = username,
                                   token_path   = token_path,
                                   access_token = access_token)
        
        if ( nrow(data) ) {
          
          warning(str_interp('There is no data in your account (${accounts_id}) for the specified period (${date_start} - ${date_stop})'))
          
        } else {
          
          data <- group_by(data, 
                           date_start, campaign_name, adset_name, ad_name) %>%
                  summarise_at( c("spend", "impressions", "clicks"),
                                numsum) %>%
                  ungroup() %>%
                  mutate("ga:date"        = ga_date_format(date_start),
                         "ga:medium"      = utm_medium, 
                         "ga:source"      = utm_source) %>%
                  rename("ga:campaign"    = campaign_name,
                         "ga:keyword"     = adset_name,
                         "ga:adContent"   = ad_name,
                         "ga:adCost"      = spend,
                         "ga:impressions" = impressions,
                         "ga:adClicks"    = clicks) %>%
                  select("ga:date",
                         "ga:medium",
                         "ga:source",
                         "ga:adClicks",
                         "ga:adCost",
                         "ga:impressions",
                         "ga:campaign",
                         "ga:keyword",
                         "ga:adContent") %>%
                  mutate_if( is.character, iconv, to = "UTF-8" )
          
        }
        
        return(data)
      }