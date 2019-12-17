\name{fbAuth}
\alias{fbAuth}

\title{Authorization in Facebook.}
\description{Wrapper for \code{fbGetToken()} and \code{fbGetLongtimeToken()}.}
\usage{
fbAuth(app_id      = getOption("rfacebookstat.app_id"), 
       app_secret  = getOption("rfacebookstat.app_secret"), 
       username    = getOption("rfacebookstat.username"),
       token_path  = fbTokenPath(),
	   reauth      = FALSE,
       skip_option = FALSE)
}

\arguments{
  \item{app_id}{ID of Facebook App}
  \item{app_secret}{Secret of Facebook App}
  \item{username}{your username on Facebook}
  \item{token_path}{path to dir with credentials}
  \item{reauth}{boolean, do reauthorization}
  \item{skip_option}{logical, skip access token from options or not}
}

\value{API token object}

\author{Alexey Seleznev}

\examples{
\dontrun{
fbAuth()
}
}
