\name{fbGetPages}
\alias{fbGetPages}

\title{Get pages list}
\description{Load data about all avable pages}
\usage{
fbGetPages(projects_id = NULL, 
           api_version = "v3.1", 
		   access_token = NULL)
}

\arguments{
  \item{projects_id}{ Your project ID.}
  \item{api_version}{Current Facebook API version.}
  \item{access_token}{Your facebook API token.}
}


\value{Data frame with pages list}

\author{Alexey Seleznev}

\examples{
\dontrun{
fbPages <- fbGetPages(projects_id = "xxxxxxxxxxxxx", 
                      api_version = "v2.8", 
					  access_token = "xxxxxxxxxxxxxxxxxxxxxxxxxxxxx")
}
}
