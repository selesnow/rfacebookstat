\name{fbAuth}
\alias{fbAuth}

\title{Authorization in Facebook.}
\description{Wrapper for \code{fbGetToken()} and \code{fbGetLongtimeToken()}.}
\usage{
fbAuth(username    = getOption("rfacebookstat.username"),
       app_id      = getOption("rfacebookstat.app_id"), 
       app_secret  = getOption("rfacebookstat.app_secret"), 
       token_path  = fbTokenPath(),
       scopes      = c("ads_read", 
                       "business_management", 
                       "pages_manage_ads", 
                       "ads_management", 
                       "public_profile"),
	     reauth      = FALSE,
       skip_option = FALSE)
}

\arguments{
  \item{username}{your username on Facebook}
  \item{app_id}{ID of Facebook App}
  \item{app_secret}{Secret of Facebook App}
  \item{token_path}{path to dir with credentials}
  \item{scopes}{Permissions provide a way for your app to access data from Facebook. For detail see \href{https://developers.facebook.com/docs/permissions}{docmentation}}
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
