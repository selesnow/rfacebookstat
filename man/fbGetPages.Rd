\name{fbGetPages}
\alias{fbGetPages}

\title{Get pages list}
\description{Load data about all avable pages}
\usage{
fbGetPages(accounts_id  = getOption("rfacebookstat.accounts_id"), 
           api_version  = getOption("rfacebookstat.api_version"), 
           username     = getOption("rfacebookstat.username"),
           token_path   = fbTokenPath(),
           access_token = getOption("rfacebookstat.access_token"))
}

\arguments{
  \item{accounts_id}{Facebook Ad Account ID.}
  \item{api_version}{Current Facebook API version.}
  \item{username}{your username on Facebook}
  \item{token_path}{path to dir with credentials}
  \item{access_token}{Your facebook API token.}
}


\value{Data frame with pages list}

\author{Alexey Seleznev}

\examples{
\dontrun{
accounts <- fbGetAccounts()
fbPages <- fbGetPages(accounts$id)
}
}
