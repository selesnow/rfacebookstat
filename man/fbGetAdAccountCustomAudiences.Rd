\name{fbGetAdAccountCustomAudiences}
\alias{fbGetAdAccountCustomAudiences}
\title{
The Custom Audiences Associated With the Ad Account.
}
\description{
Get The custom audiences associated with the ad account.
}
\usage{
fbGetAdAccountCustomAudiences(
    business_ids = getOption("rfacebookstat.business_id"),
    accounts_id  = getOption("rfacebookstat.accounts_id"),
    pixel_id     = NULL,
    filtering    = NULL,
    api_version  = getOption("rfacebookstat.api_version"),
    username     = getOption("rfacebookstat.username"),
    token_path   = fbTokenPath(),
    access_token = getOption("rfacebookstat.access_token")
)
}
\arguments{
  \item{business_ids}{ Your business manager or project ID.}
  \item{accounts_id}{Your account ID, for example 'act_11111111111111111'.}
  \item{pixel_id}{This param fetches audiences associated to specific pixel.}
  \item{filtering}{Filters on the report data. This parameter is an array of filter objects.}
  \item{api_version}{Current Facebook API version.}
  \item{username}{your username on Facebook}
  \item{token_path}{path to dir with credentials}
  \item{access_token}{Your facebook API token.}
}
\value{
data.frame with custom audiences data
}
\author{
Alexey Seleznev
}

\seealso{
 \href{https://developers.facebook.com/docs/marketing-api/reference/ad-account/customaudiences/}{Ad Account Customaudiences API Documentation}
}

