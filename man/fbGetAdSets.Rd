\name{fbGetAdSets}
\alias{fbGetAdSets}

\title{Get creative list from facebook marketing API}
\description{Get ads creatives list with parameters from facebook marketing API. An ad set is a group of ads that share the same daily or lifetime budget, schedule, bid type, bid info, and targeting data. Ad sets enable you to group ads according to your criteria, and you can retrieve the ad-related statistics that apply to a set. }
\usage{
fbGetAdSets(accounts_id = getOption("rfacebookstat.accounts_id"), 
 api_version = getOption("rfacebookstat.api_version"), 
 username     = getOption("rfacebookstat.username"),
 token_path   = fbTokenPath(),
 access_token = getOption("rfacebookstat.access_token"))
}
\arguments{
  \item{accounts_id}{Your account ID, for example 'act_11111111111111111'.}
  \item{api_version}{Current Facebook API version.}
  \item{username}{your username on Facebook}
  \item{token_path}{path to dir with credentials}
  \item{access_token}{Your facebook API token.}
}

\value{
Data frame with ads list.
\item{1. id}{Ad set ID.}
\item{2. name}{Name of ad set.}
\item{3. account_id}{Ad Account ID.}
\item{4. budget_remaining}{Remaining budget.}
\item{5. configured_status}{The status set at the ad set level. It can be different from the effective status due to its parent campaign. Prefer using 'status' instead of this, one of ACTIVE, PAUSED, DELETED, ARCHIVED.}
\item{6. effective_status}{The effective status of the ad set, which can be either its own status or caused by its parent campaign, one of ACTIVE, PAUSED, DELETED, PENDING_REVIEW, DISAPPROVED, PREAPPROVED, PENDING_BILLING_INFO, CAMPAIGN_PAUSED, ARCHIVED, ADSET_PAUSED.}
\item{7. status}{The status set at the ad set level. It can be different from the effective status due to its parent campaign. The field returns the same value as 'configured_status', and is the suggested one to use (ACTIVE, PAUSED, DELETED, ARCHIVED).}
\item{8. created_time}{Created time.}
\item{9. bid_strategy}{Choose bid strategy for this ad set to suit your specific business goals. Each strategy has tradeoffs and may be available for certain optimization_goals:
LOWEST_COST_WITHOUT_CAP: Designed to get the most results for your budget based on your ad set optimization_goal without limiting your bid amount. This is the best strategy if you care most about cost efficiency. However with this strategy it may be harder to get stable average costs as you spend. This strategy is also known as automatic bidding. Learn more in Ads Help Center, About bid strategies: Lowest cost.
LOWEST_COST_WITH_BID_CAP: Designed to get the most results for your budget based on your ad set optimization_goal while limiting actual bid to your specified amount. With a bid cap you have more control over your cost per actual optimization event. However if you set a limit which is too low you may get less ads delivery. If you select this, you must provide a bid cap with the bid_amount field. Note: during creation this bid strategy is set if you provide bid_amount only. This strategy is also known as manual maximum-cost bidding. Learn more in Ads Help Center, About bid strategies: Lowest cost.
TARGET_COST: Maintains a stable average cost based on your optimization_goal as you raise your ad set budget. Select this strategy if you care most about maintaining stable average costs for your ads. However, note that this strategy may be less cost-efficient than the lowest cost strategy. If you select this, you must provide a target cost with the bid_amount field. Target cost bid strategy is also known as manual average-cost bidding. Learn more in Ads Help Center, About bid strategies: Target cost.
Note: If you enable campaign budget optimization, you should set bid_strategy at the parent campaign level.}
\item{10. pacing_type}{Defines the pacing type, standard by default or using ad scheduling}
}

\author{Alexey Seleznev}


\examples{
\dontrun{
library(rfacebookstat)
fb_token <- fbGetToken(app_id = 0000000)
adsets <- fbGetAdSets(accounts_id  = "act_11111111111111111",
                      api_version  = 'v3.0',
                      access_token = fb_token)
}

}
