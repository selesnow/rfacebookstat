\name{fbGetMarketingStat}
\alias{fbGetMarketingStat}

\title{Get statistic by ad accounts.}
\description{fbGetMarketingStat is main function of rfacebookstat package, intended for load statiscit data by your ad, adset, campaign or account}
\usage{
fbGetMarketingStat(accounts_id = NULL, sorting = NULL, level = "account",
                   breakdowns = NULL, action_breakdowns = NULL, fields =
                   "account_id,campaign_name,impressions,clicks,reach,spend",
                   filtering = NULL, date_start = Sys.Date() - 30,
                   date_stop = Sys.Date(), api_version = "v3.1", interval
                   = "day", console_type = "progressbar", request_speed =
                   "normal", access_token = NULL)
}
\arguments{
  \item{accounts_id}{ID of your ad account.}
  \item{sorting}{Field to sort the result, and direction of sorting. You can specify sorting direction by appending "_ascending" or "_descending" to the sort field. For example, "reach_descending". This array supports no more than one element. By default, the sorting direction is ascending.}
  \item{level}{Represents the level of result. Avable ad, adset, campaign, account.}
  \item{action_breakdowns}{group results in the actions field. You can use the following breakdowns for action_breakdowns, for details go - https://developers.facebook.com/docs/marketing-api/insights/breakdowns/#actionsbreakdown}
  \item{breakdowns}{Permutations marked with an asterisk (*) can be joined with action_type and action_target_id. Avable age, country, gender, frequency_value, hourly_stats_aggregated_by_advertiser_time_zone, hourly_stats_aggregated_by_audience_time_zone, impression_device, place_page_id, placement, device_platform, product_id, region}
  \item{fields}{List of fields which you want get in R.}
  \item{filtering}{Array of filtring parameters, on example [{/'field/':/'ad.effective_status/',/'operator/':/'IN/',/'value/':[/'ARCHIVED/']}}
  \item{date_start}{Start reporting date.}
  \item{date_stop}{End reporting day}
  \item{request_speed}{Speed beetwen API request, "normal", "fast" or "slow", depend of you API access level.}
  \item{api_version}{Current Facebook API version.}
  \item{interval}{Character value for split by time interval, one of "day", "week", "month", "quarter", "year". By default = "day"}
  \item{console_type}{Character value for manage console output message, one of "progressbar", "message". By default = "progressbar". See more at Detail}
  \item{access_token}{Your facebook API token}
}

\value{Data frame with statistic.}
\details{console_type parameters, if chose "progressbar" you can see load progress in percent, and if chose "message" you get message about loading process.}
\author{Alexey Seleznev}

\seealso{
All avable fields https://developers.facebook.com/docs/marketing-api/insights/fields/v2.7
Description by any parameters https://developers.facebook.com/docs/marketing-api/insights/parameters/v2.7
All avable breakdowns - https://developers.facebook.com/docs/marketing-api/insights/breakdowns/v2.7
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

