\name{fbGetAdAccounts}
\alias{fbGetAdAccounts}
\title{Get avable ad account list.}
\description{fbGetAdAccounts get data frame with avable in your bussines manager ad account list in R.}
\usage{
fbGetAdAccounts(source_id = getOption("rfacebookstat.business_id"), 
                api_version = getOption("rfacebookstat.api_version"), 
				access_token = getOption("rfacebookstat.access_token"))
}

\arguments{
  \item{source_id}{ Your business manager or project ID.}
  \item{access_token}{Your facebook API token.}
  \item{api_version}{Current Facebook API version.}
}

\value{
Data frame with ad account list.
}

\author{Alexey Seleznev}

\examples{
\dontrun{
fbAccounts <- fbGetAdAccounts(source_id = "xxxxxxxxxxxxx",
                              api_version = "v2.10", 
							  access_token = "xxxxxxxx")
							  
}
}
