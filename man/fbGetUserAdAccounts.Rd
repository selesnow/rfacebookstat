\name{fbGetUserAdAccounts}
\alias{fbGetUserAdAccounts}
\title{User's ad account list.}
\description{The advertising accounts to which this person has access.}
\usage{
fbGetUserAdAccounts(user_id      = "me", 
                    api_version  = getOption("rfacebookstat.api_version"), 
                    username     = getOption("rfacebookstat.username"),
                    token_path   = fbTokenPath(),
                    access_token = getOption("rfacebookstat.access_token"))
}

\arguments{
  \item{user_id}{Facebook user id.}
  \item{access_token}{Your facebook API token.}
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
fbAccounts <- fbGetUserAdAccounts()
							  
}
}
