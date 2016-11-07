\name{fbGetAdAccounts}
\alias{fbGetAdAccounts}
\title{Get avable ad account list.}
\description{fbGetAdAccounts get data frame with avable in your bussines manager ad account list in R.}
\usage{
fbGetAdAccounts(projects_id = NULL, api_version = "v2.8", access_token = NULL)
}

\arguments{
  \item{projects_id}{ Your project ID.}
  \item{access_token}{Your facebook API token.}
  \item{api_version}{Current Facebook API version.}
}

\value{
Data frame with ad account list.
}

\author{Alexey Seleznev}

\examples{
fbAccounts <- fbGetAdAccounts(projects_id = "xxxxxxxxxxxxx", api_version = "v2.8", access_token = "xxxxxxxxxxxxxxxxxxxxxxxxxxxxx")
}
