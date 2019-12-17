\name{fbGetBusinessUserAdAccounts}
\alias{fbGetBusinessUserAdAccounts}
\title{Get a list of accounts for a business manager user}
\description{Loading account list for business manager user.}
\usage{
fbGetBusinessUserAdAccounts(
     business_users_id = NULL, 
     business_id       = getOption("rfacebookstat.business_id"), 
     api_version       = getOption("rfacebookstat.api_version"), 
	 username          = getOption("rfacebookstat.username"),
     token_path        = fbTokenPath(),
     access_token      = getOption("rfacebookstat.access_token"))
}

\arguments{
  \item{business_users_id}{ID by business manager user.}
  \item{business_id}{ID by your Business Manager}
  \item{username}{your username on Facebook}
  \item{token_path}{path to dir with credentials}
  \item{access_token}{Your facebook API token.}
  \item{api_version}{Current Facebook API version.}
}

\value{
Data frame with ad account list.
}

\author{Alexey Seleznev}

\examples{
\dontrun{
options(rfacebookstat.business_id  = 000000000000,
        rfacebookstat.access_token = "abcde12345....")

my_accs <- fbGetBusinessUserAdAccounts(
                     business_users_id = 777423445991332
					 )
}
}
