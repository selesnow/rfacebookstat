\name{fbGetBusinessManagers}
\alias{fbGetBusinessManagers}
\title{Get avable business Managers.}
\description{fbGetBusinessManagers get data frame with avable bussines managers list in R.}
\usage{
fbGetBusinessManagers(api_version = getOption("rfacebookstat.api_version"), 
                      username     = getOption("rfacebookstat.username"),
                      token_path   = fbTokenPath(),
                      access_token = getOption("rfacebookstat.access_token"))
}

\arguments{
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
BM <- fbGetBusinessManagers(api_version = "v2.10", access_token = "xxxxxxxxxxxxxxxxxxxxxxxxxxxxx")
}
}
