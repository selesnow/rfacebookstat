\name{fbGetAdAccountUsers}
\alias{fbGetAdAccountUsers}
\title{Get User List From Account}
\description{fbGetAdAccountUsers get data frame with adaccounts user list in R.}
\usage{
fbGetAdAccountUsers(
    accounts_id  = getOption("rfacebookstat.accounts_id"), 
	business_id  = getOption("rfacebookstat.business_id"),
    api_version  = getOption("rfacebookstat.api_version"), 
	console_type = "progressbar", 
	username     = getOption("rfacebookstat.username"),
	token_path   = fbTokenPath(),
	access_token = getOption("rfacebookstat.access_token"))
}

\arguments{
  \item{accounts_id}{vector with ID of your ad account, for example c("act_00001","act_00002").}
  \item{business_id}{ID by your Business Manager}
  \item{access_token}{Your facebook API token.}
  \item{console_type}{Console output type, "progressbar" or "message"}
  \item{username}{your username on Facebook}
  \item{token_path}{path to dir with credentials}
  \item{api_version}{Current Facebook API version.}
}

\value{
Data frame with ad account list.
}

\author{Alexey Seleznev}

\examples{
\dontrun{
accountUsers <- fbGetAdAccountUsers(accounts_id = c("act_00001","act_00002"), 
                                    bussiness_id = 1111111,
                                    access_token = "xxxxxxxxxxxxxxxxxxxxxxxxxxxxx")
}
}
