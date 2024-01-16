\name{fbGetMarketingStat}
\alias{fbGetMarketingStat}

\title{Get statistic by ad accounts.}
\description{fbGetMarketingStat is main function of rfacebookstat package, intended for load statiscit data by your ad, adset, campaign or account}
\usage{
fbGetMarketingStat(
  accounts_id = getOption("rfacebookstat.accounts_id"), 
  sorting = NULL, level = "account", breakdowns = NULL, 
	action_breakdowns = NULL, 
	fields = "account_id,campaign_name,impressions,clicks,reach,spend",
  filtering = NULL, date_start = NULL,
  date_stop = NULL, date_preset = "last_30d",
  attribution_window = NULL,
	api_version = getOption("rfacebookstat.api_version"), 
	action_report_time = NULL, interval = "day", 
	use_account_attribution_setting = FALSE,
	console_type = "progressbar", request_speed = "normal",
	fetch_by = NULL,
  username = getOption("rfacebookstat.username"),
  token_path = fbTokenPath(),	
	access_token = getOption("rfacebookstat.access_token"))
}
\arguments{
  \item{accounts_id}{ID of your ad account.}
  \item{sorting}{Field to sort the result, and direction of sorting. You can specify sorting direction by appending "_ascending" or "_descending" to the sort field. For example, "reach_descending". This array supports no more than one element. By default, the sorting direction is ascending.}
  \item{level}{Represents the level of result. Avable ad, adset, campaign, account.}
  \item{action_breakdowns}{group results in the actions field. You can use the following breakdowns for action_breakdowns, for details \href{https://developers.facebook.com/docs/marketing-api/insights/breakdowns/#actionsbreakdown}{go}, or see details}
  \item{breakdowns}{Permutations marked with an asterisk (*) can be joined with action_type and action_target_id. Avable age, country, gender, frequency_value, hourly_stats_aggregated_by_advertiser_time_zone, hourly_stats_aggregated_by_audience_time_zone, impression_device, place_page_id, placement, device_platform, product_id, region. See details.}
  \item{fields}{List of fields which you want get in R.}
  \item{filtering}{Vector of filtring or JSON string with array of filtring parameters, on example \code{"ad.effective_status IN ARCHIVED"} \code{[{/'field/':/'ad.effective_status/',/'operator/':/'IN/',/'value/':[/'ARCHIVED/']}}, see filtring block for more examples}
  \item{date_start}{Start reporting date.}
  \item{date_stop}{End reporting day}
  \item{date_preset}{Represents a relative time range. This field is ignored if time_range or time_ranges is specified. One of: today, yesterday, this_month, last_month, this_quarter, lifetime, last_3d, last_7d, last_14d, last_28d, last_30d, last_90d, last_week_mon_sun, last_week_sun_sat, last_quarter, last_year, this_week_mon_today, this_week_sun_today, this_year}
  \item{attribution_window}{The conversion attribution window provides timeframes that define when we attribute an event to an ad on Facebook. See Attribution Window sections.}
  \item{request_speed}{Speed beetwen API request, "normal", "fast" or "slow", depend of you API access level.}
  \item{fetch_by}{Character, split your requst by time interval, one of: day, week, month, quarter, year.}
  \item{api_version}{Current Facebook API version.}
  \item{action_report_time}{Determines the report time of action stats.}
  \item{interval}{Character value for split by time interval, one of "day", "week", "month", "quarter", "year". By default = "day"}
  \item{use_account_attribution_setting}{When this parameter is set to true, your ads results will be shown using the attribution settings defined for the ad account.}
  \item{console_type}{Character value for manage console output message, one of "progressbar", "message". By default = "progressbar". See more at Detail}
  \item{username}{your username on Facebook}
  \item{token_path}{path to dir with credentials}
  \item{access_token}{Your facebook API token}
}

\value{Data frame with statistic.}
\details{
Console_type parameters, if chose "progressbar" you can see load progress in percent, and if chose "message" you get message about loading process.
}

\section{Breakdowns}{
Allowed values for breakdowns.
\itemize{
  \item ad_format_asset
  \item age
  \item body_asset
  \item call_to_action_asset
  \item country
  \item description_asset
  \item gender
  \item image_asset
  \item impression_device
  \item link_url_asset
  \item product_id
  \item region
  \item title_asset
  \item video_asset
  \item dma
  \item frequency_value
  \item hourly_stats_aggregated_by_advertiser_time_zone
  \item hourly_stats_aggregated_by_audience_time_zone
  \item place_page_id
  \item publisher_platform
  \item platform_position
  \item device_platform
 }
}

\section{Action Breakdowns}{
Group results in the actions field. You can use the following breakdowns for action_breakdowns.
Now you can use next action breakdowns:
\describe{
  \item{action_device}{The device on which the conversion event you're tracking occurred. For example, "Desktop" if someone converted on a desktop computer.}
  \item{action_destination}{The destination where people go after clicking on your ad. This could be your Facebook Page, an external URL for your conversion pixel or an app configured with the software development kit (SDK).}
  \item{action_reaction}{The number of reactions on your ads or boosted posts. The reactions button on an ad allows people to share different reactions on its content: Like, Love, Haha, Wow, Sad or Angry.}
  \item{action_target_id}{The id of destination where people go after clicking on your ad. This could be your Facebook Page, an external URL for your conversion pixel or an app configured with the software development kit (SDK).}
  \item{action_type}{The kind of actions taken on your ad, Page, app or event after your ad was served to someone, even if they didn't click on it. Action types include Page likes, app installs, conversions, event responses and more.}
  \item{action_type,action_reaction}{Together of action types and reactions brekdown.}
 }
}

\section{Available Combinations Of Breakdowns}{
Grouping types marked with an asterisk (*) can be combined with action_type, action_target_id, and action_destination (action_target_id).
\itemize{
  \item action_type *
  \item action_target_id *
  \item action_device *
  \item action_device, impression_device *
  \item action_device, publisher_platform *
  \item action_device, publisher_platform, impression_device *
  \item action_device, publisher_platform, platform_position *
  \item action_device, publisher_platform, platform_position, impression_device *
  \item action_reaction
  \item action_type, action_reaction
  \item age *
  \item gender *
  \item age, gender *
  \item country *
  \item region *
  \item publisher_platform *
  \item publisher_platform, impression_device *
  \item publisher_platform, platform_position *
  \item publisher_platform, platform_position, impression_device *
  \item product_id *
}
}

\section{Attribution Window}{
The conversion attribution window provides time intervals that determine the attribution period of an event for advertising on Facebook.
For background information, see Facebook Ads Help Center, How Attribution Reporting Works. We measure the actions that occur when a conversion event occurs and look back in time 1-day, 7-days, and 28 days.
To view actions attributed to different attribution windows, use \code{attribution_window}.

\describe{
  \item{account_default}{Use the account level attribution window setting}
  \item{default}{The FB default attribution window is 1 day views, 28 day clicks}
  \item{inline}{Inline attribution only (0 day views, 0 day clicks)}
  \item{1d_view}{1 day views, 0 day clicks}
  \item{7d_view}{7 day views, 0 day clicks}
  \item{28d_view}{28 day views, 0 day clicks}
  \item{1d_click}{0 day views, 1 day clicks}
  \item{7d_click}{0 day views, 7 day clicks}
  \item{28d_click}{0 day views, 28 day clicks}
  \item{1d_view_1d_click}{1 day views, 1 day clicks}
  \item{7d_view_1d_click}{7 day views, 1 day clicks}
  \item{28d_view_1d_click}{28 day views, 1 day clicks}
  \item{1d_view_7d_click}{1 day views, 7 day clicks}
  \item{1d_view_28d_click}{1 day views, 28 day clicks}
  \item{28d_view_28d_click}{28 day views, 28 day clicks}
 }

Also you can get more than one attribution window in one request, for example \code{attribution_window = c('default', '1d_view', '28d_view', '28d_click')}
}

\section{Filtering}{
Filters on the report data. This parameter is an array of filter objects.
You can set string vector or JSON string with field, operator and value.
\describe{
  \item{field}{Field for filtering.}
  \item{operator}{One of EQUAL, NOT_EQUAL, GREATER_THAN, GREATER_THAN_OR_EQUAL, LESS_THAN, LESS_THAN_OR_EQUAL, IN_RANGE, NOT_IN_RANGE, CONTAIN, NOT_CONTAIN, IN, NOT_IN, STARTS_WITH, ANY, ALL, AFTER, BEFORE, NONE.}
  \item{value}{Field value for filtering.}
 }
 Simple filtring:
 \describe{
   \item{Example vector}{\code{filtering = "publisher_platform IN instagram"}}
   \item{Example JSON}{\code{filtering = "[{'field':'publisher_platform','operator':'IN','value':['instagram']}]"}}
 Example of using two or more conditions: \code{filtering = "[{'field':'clicks','operator':'LESS_THAN','value':500},{'field':'impressions','operator':'GREATER_THAN','value':20000}]"}
}
Filtring by two or more conditions:
\describe{
   \item{Example vector}{\code{filtering = c("clicks LESS_THAN 500", "impressions GREATER_THAN 20000")}}
   \item{Example JSON}{\code{filtering = '[{"field":"clicks","operator":"LESS_THAN","value":"500"},{"field":"impressions","operator":"GREATER_THAN","value":"20000"}]'}}
   }
Filtring with operators IN_RANGE, NOT_IN_RANGE, IN, NOT_IN

\describe{
   \item{Example vector}{\code{filtering = 'publisher_platform IN instagram,facebook'}}
   \item{Example JSON}{\code{filtering = '[{"field":"publisher_platform","operator":"IN","value":["instagram","facebook"]}]'}}
   }
}
\author{Alexey Seleznev}

\seealso{
All avable field, and discription of all parameters you can see oh this  \href{https://developers.facebook.com/docs/marketing-api/reference/ad-account/insights}{link}.
More information about breakdowns and action brekdowns on this \href{https://developers.facebook.com/docs/marketing-api/insights/breakdowns}{link}.
More information about action field in this \href{https://developers.facebook.com/docs/marketing-api/reference/ads-action-stats/}{documentation}.
}
\examples{
\dontrun{
fbStat <- fbGetMarketingStat(accounts_id = "act_xxxxxxxxxxxxxxx",
                             level = "campaign",
                             fields = "account_name,campaign_name,impressions",
                             breakdowns = "device_platform",
                             date_start = "2016-08-01",
                             date_stop = "2016-08-10",
			     interval = "day",
                             access_token = "xxxxxxxxxxxxxxxxxxxxxxxxxxxxx")
}
}

