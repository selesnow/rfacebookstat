\name{fbGetProjects}
\alias{fbGetProjects}
\title{Get project list}
\description{Load data about all avable projects}
\usage{
fbGetProjects(bussiness_id = NULL, api_version = "v2.8", access_token = NULL)
}

\arguments{
  \item{bussiness_id}{ID by your Business Manager}
  \item{api_version}{Current Facebook API version.}
  \item{access_token}{Your API facebook token}
}

\value{Data frame with project list}

\author{Alexey Seleznev}

\examples{
fbProject <- fbGetProjects(bussiness_id = "xxxxxxxxx", api_version = "v2.8", access_token = "xxxxxxxxxxxxxxxxxxxxxxxxxxxx")
}
