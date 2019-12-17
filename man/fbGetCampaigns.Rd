\name{fbGetCampaigns}
\alias{fbGetCampaigns}

\title{Get campaign list from facebook marketing API}
\description{Get campaign list with parameters from facebook marketing API.}
\usage{
fbGetCampaigns(accounts_id  = getOption("rfacebookstat.accounts_id"),
               api_version  = getOption("rfacebookstat.api_version"), 
			   username     = getOption("rfacebookstat.username"),
               token_path   = fbTokenPath(),
			   access_token = getOption("rfacebookstat.access_token"))
}
\arguments{
  \item{accounts_id}{ Your account ID, for example 'act_11111111111111111'.}
  \item{api_version}{Current Facebook API version.}
  \item{username}{your username on Facebook}
  \item{token_path}{path to dir with credentials}
  \item{access_token}{Your facebook API token.}
}

\value{
Data frame with campaign list.
}

\author{Alexey Seleznev}


\examples{
\dontrun{
library(rfacebookstat)
fb_token <- fbGetToken(app_id = 0000000)
camp <- fbGetCampaigns(accounts_id  = "act_11111111111111111",
                       api_version  = 'v3.0',
                       access_token = fb_token)
}
}

