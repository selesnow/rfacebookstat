\name{fbGetToken}
\alias{fbGetToken}

\title{Get API facebook token.}
\description{Get API facebook token for access to facebook ads API.}
\usage{
fbGetToken(app_id = NULL)
}

\arguments{
  \item{app_id}{ID of your Facebook App}
}

\value{API token}

\author{Alexey Seleznev}

\examples{
\dontrun{
tkn <- fbGetToken()
}
}
