\name{fbGetAdVideos}
\alias{fbGetAdVideos}

\title{Get videos list from ad accounts}
\description{Load all videos from faceboob ad accounts.}
\usage{
fbGetAdVideos(accounts_id  = getOption("rfacebookstat.accounts_id"), 
              api_version  = getOption("rfacebookstat.api_version"),
		      username     = getOption("rfacebookstat.username"),
	          token_path   = fbTokenPath(),
              access_token = getOption("rfacebookstat.access_token"))
}
\arguments{
  \item{accounts_id}{Your account ID, for example 'act_11111111111111111'.}
  \item{api_version}{Current Facebook API version.}
  \item{username}{Your username on Facebook}
  \item{token_path}{Path to dir with credentials}
  \item{access_token}{Your facebook API token.}
}

\value{
Data frame with video parameters list.
}

\author{Alexey Seleznev}


\examples{
\dontrun{
ads <- fbGetAdVideos()
}

}
