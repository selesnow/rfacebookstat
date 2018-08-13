\name{rfacebookstat-package}
\alias{rfacebookstat-package}
\alias{rfacebookstat}
\docType{package}
\title{
\packageTitle{rfacebookstat}
}
\description{
\packageDescription{rfacebookstat}
}
\details{

The DESCRIPTION file:
\packageDESCRIPTION{rfacebookstat}
\packageIndices{rfacebookstat}
}
\author{
\packageAuthor{rfacebookstat}

Maintainer: \packageMaintainer{rfacebookstat}
}

\keyword{ package }
\seealso{
See oficial documantation:
rfacebookstat package - https://selesnow.github.io/rfacebookstat/
Facebook API Marketing - https://developers.facebook.com/docs/marketing-apis/
}
\examples{
\dontrun{
library(rfacebookstat)
# Auth
token <- fbGetToken(app_id = 00000000000000)

# Get statistic
CampStat <- fbGetMarketingStat(accounts_id = "act_0000000000",
level = "campaign", fields = "campaign_name,impressions,clicks",
breakdowns = "age", sorting = "unique_impressions_descending",
filtering = "[{'field':'age','operator':'IN','value':['18-24','25-34']}]",
date_start = "2016-10-01", date_stop = "2016-10-10",
access_token = token)
}
}
