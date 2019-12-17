\name{fbGetAds}
\alias{fbGetAds}

\title{Get ads list from facebook marketing API}
\description{Get ads list with parameters from facebook marketing API. Contains information to display an ad and associate it an ad set. Each ad is associated with an ad set and all ads in a set have the same daily or lifetime budget, schedule, and targeting. Creating multiple ads in an ad set helps optimize their delivery based on variations in images, links, video, text or placements.}
\usage{
fbGetAds(accounts_id  = getOption("rfacebookstat.accounts_id"), 
         api_version  = getOption("rfacebookstat.api_version"),
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
\item{1. id}{The ID of this ad.}
\item{2. name}{Name of the ad.}
\item{3. creative_id}{The ID or creative spec of the ad creative to be used by this ad.}
\item{4. adset_id}{The ID of the ad set, required on creation.}
\item{5. campaign_id}{ID of the ad campaign that contains this ad.}
\item{6. account_id}{The ID of the ad account that this ad belongs to.}
\item{7. bid_amount}{Bid amount for this ad which will be used in auction instead of the ad set bid_amount, if specified. Any updates to the ad set bid_amount will overwrite this value with the new ad set value.}
\item{8. bid_type}{Bid type, one of CPC, CPM, MULTI_PREMIUM, ABSOLUTE_OCPM, CPA}
\item{9. configured_status}{The configured status of the ad.}
\item{10. effective_status}{The effective status of the ad. The status could be effective either because of its own status, or the status of its parent units.}
}

\author{Alexey Seleznev}


\examples{
\dontrun{
library(rfacebookstat)
fb_token <- fbGetToken(app_id = 0000000)
ads <- fbGetAds(accounts_id  = "act_11111111111111111",
                api_version  = 'v3.0',
                access_token = fb_token)
}

}
