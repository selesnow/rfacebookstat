\name{fbGetCatalogs}
\alias{fbGetCatalogs}
\title{Get catalogs}
\description{Load catalogs from business maneger.}
\usage{
fbGetCatalogs(business_id  = getOption("rfacebookstat.business_id") ,
              api_version  = getOption("rfacebookstat.api_version"),
              access_token = getOption("rfacebookstat.access_token"))
}

\arguments{
  \item{business_id}{ID by your Business Manager}
  \item{api_version}{Current Facebook API version.}
  \item{access_token}{Your API facebook token}
}

\value{Data frame with project list}

\author{Alexey Seleznev}

\examples{
\dontrun{
bc <- fbGetCatalogs(business_id = 1111111111,
                    access_token = "xxxxxxxx")
 }
}
