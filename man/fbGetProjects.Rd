\name{fbGetProjects}
\alias{fbGetProjects}
\title{Get project list}
\description{Load data about all avable projects}
\usage{
fbGetProjects(bussiness_id = getOption("rfacebookstat.business_id"), 
              api_version  = getOption("rfacebookstat.api_version"),
              access_token = getOption("rfacebookstat.access_token"))
}

\arguments{
  \item{bussiness_id}{ID by your Business Manager}
  \item{api_version}{Current Facebook API version.}
  \item{access_token}{Your API facebook token}
}

\value{Data frame with project list}

\author{Alexey Seleznev}

\examples{
\dontrun{
fbProject <- fbGetProjects(bussiness_id = "xxxxxxxxx", 
                           access_token = "xxxxxxxxxxxxxxxxxxxxxxxxxxxx")
}
}
