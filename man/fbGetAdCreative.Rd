\name{fbGetAdCreative}
\alias{fbGetAdCreative}

\title{Get creative list from facebook marketing API}
\description{Get ads creatives list with parameters from facebook marketing API.}
\usage{
fbGetAdCreative(accounts_id = NULL, api_version = 'v3.0', access_token = NULL)
}
\arguments{
  \item{accounts_id}{Your account ID, for example 'act_11111111111111111'.}
  \item{api_version}{Current Facebook API version.}
  \item{access_token}{Your facebook API token.}
}

\value{
Data frame with ads list.
}

\author{Alexey Seleznev}


\examples{
library(rfacebookstat)
fb_token <- fbGetToken(app_id = 0000000)
ads_creative <- fbGetAdCreative(accounts_id  = "act_11111111111111111",
                                api_version  = 'v3.0',
                                access_token = fb_token)

}
% Add one or more standard keywords, see file 'KEYWORDS' in the
% R documentation directory.
\keyword{ ~kwd1 }% use one of  RShowDoc("KEYWORDS")
\keyword{ ~kwd2 }% __ONLY ONE__ keyword per line