\name{fbGetCampaigns}
\alias{fbGetCampaigns}

\title{Get campaign list from facebook marketing API}
\description{Get campaign list with parameters from facebook marketing API.}
\usage{
fbGetCampaigns(accounts_id = NULL,
               api_version = "v3.1", 
			   access_token = NULL)
}
\arguments{
  \item{accounts_id}{ Your account ID, for example 'act_11111111111111111'.}
  \item{api_version}{Current Facebook API version.}
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
% Add one or more standard keywords, see file 'KEYWORDS' in the
% R documentation directory.
\keyword{ ~kwd1 }% use one of  RShowDoc("KEYWORDS")
\keyword{ ~kwd2 }% __ONLY ONE__ keyword per line
