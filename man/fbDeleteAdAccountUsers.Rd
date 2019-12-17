\name{fbDeleteAdAccountUsers}
\alias{fbDeleteAdAccountUsers}
\title{Delete users from ad accounts.}
\description{fbDeleteAdAccountUsers is method for remove users access from ad accounts.}
\usage{
fbDeleteAdAccountUsers(
    user_ids     = NULL, 
    accounts_id  = getOption("rfacebookstat.accounts_id"),
	api_version  = getOption("rfacebookstat.api_version"),
	username     = getOption("rfacebookstat.username"),
    token_path   = fbTokenPath(),
	access_token = getOption("rfacebookstat.access_token"))
}

\arguments{
  \item{accounts_id}{vector with ID of your ad account, for example c("act_00001","act_00002").}
  \item{access_token}{Your facebook API token.}
  \item{user_ids}{vector with users ids who need remove from ad account.}
  \item{username}{your username on Facebook}
  \item{token_path}{path to dir with credentials}
  \item{api_version}{Current Facebook API version.}
}

\details{
ads_management permission is required.
You need 'Administrator' access to the ad account to remove users
}
\author{Alexey Seleznev}

\examples{
\dontrun{
#Attach package
library(rfacebookstat)
#Get token, where 0000000000000 is id of your app in facebook
tk <- fbAuth(0000000000000) 
#Remove user with id 001 and 002 from accounts act_0001 and act_0002
fbDeleteAdAccountUsers(user_ids = c(001,002), 
                       accounts_id = c("act_0001","act_0002"), 
                       api_version = "v2.12",
                       access_token = "abcdef123456" )
}
}
