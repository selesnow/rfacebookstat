\name{fbGetBusinessManagers}
\alias{fbGetBusinessManagers}
\title{Get avable business Managers.}
\description{fbGetBusinessManagers get data frame with avable bussines managers list in R.}
\usage{
fbGetAdAccounts(api_version = "v2.10", access_token = NULL)
}

\arguments{
  \item{access_token}{Your facebook API token.}
  \item{api_version}{Current Facebook API version.}
}

\value{
Data frame with ad account list.
}

\author{Alexey Seleznev}

\examples{
BM <- fbGetBusinessManagers(api_version = "v2.10", access_token = "xxxxxxxxxxxxxxxxxxxxxxxxxxxxx")
}
