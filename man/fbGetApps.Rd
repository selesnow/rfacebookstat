\name{fbGetApps}
\alias{fbGetApps}

\title{Get all the apps under a project}
\description{Get data frame with list apps under a project.}
\usage{
fbGetApps(projects_id = NULL, access_token = NULL)
}
\arguments{
  \item{projects_id}{ Your project ID.}
  \item{access_token}{Your facebook API token.}
}

\value{
Data frame with apps list.
}

\author{Alexey Seleznev}


\examples{
fbApps <- fbGetApps(projects_id = "xxxxxxxxxxxxx", access_token = "xxxxxxxxxxxxxxxxxxxxxxxxxxxxx")
}
% Add one or more standard keywords, see file 'KEYWORDS' in the
% R documentation directory.
\keyword{ ~kwd1 }% use one of  RShowDoc("KEYWORDS")
\keyword{ ~kwd2 }% __ONLY ONE__ keyword per line
