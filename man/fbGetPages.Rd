\name{fbGetPages}
\alias{fbGetPages}

\title{Get pages list}
\description{Load data about all avable pages}
\usage{
fbGetPages(projects_id = NULL, access_token = NULL)
}

\arguments{
  \item{projects_id}{ Your project ID.}
  \item{access_token}{Your facebook API token.}
}


\value{Data frame with pages list}

\author{Alexey Seleznev}

\examples{
fbPages <- fbGetPages(projects_id = "xxxxxxxxxxxxx", access_token = "xxxxxxxxxxxxxxxxxxxxxxxxxxxxx")
}
