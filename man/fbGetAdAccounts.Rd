\name{fbGetAdAccounts}
\alias{fbGetAdAccounts}
\title{Get avable ad account list.}
\description{fbGetAdAccounts get data frame with avable in your bussines manager ad account list in R.}
\usage{
fbGetAdAccounts(projects_id = NULL, access_token = NULL)
}

\arguments{
  \item{projects_id}{ Your project ID.}
  \item{access_token}{Your facebook API token.}
}

\value{
Data frame with ad account list.
}

\author{Alexey Seleznev}

\examples{
fbAccounts <- fbGetAdAccounts(projects_id = "xxxxxxxxxxxxx", access_token = "xxxxxxxxxxxxxxxxxxxxxxxxxxxxx")
}
