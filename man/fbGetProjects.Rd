\name{fbGetProjects}
\alias{fbGetProjects}
\title{Get project list}
\description{Load data about all avable projects}
\usage{
fbGetProjects(bussiness_id = NULL, access_token = NULL)
}

\arguments{
  \item{bussiness_id}{ID by your Business Manager}
  \item{access_token}{Your API facebook token}
}

\value{Data frame with project list}

\author{Alexey Seleznev}

\examples{
fbProject <- fbGetProjects(bussiness_id = "xxxxxxxxx", access_token = "xxxxxxxxxxxxxxxxxxxxxxxxxxxx")
}
