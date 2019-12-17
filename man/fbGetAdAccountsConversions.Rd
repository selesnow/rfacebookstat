\name{fbGetAdAccountsConversions}
\alias{fbGetAdAccountsConversions}
\title{Get list of custom conversion from ad accounts.}
\description{Custom conversions on Facebook allows you to optimize and track actions without having to add anything to your Facebook pixel base code. They also allow you to optimize for and track actions that are different from the 9 standard events that come with the Facebook pixel.}
\usage{
fbGetAdAccountsConversions(
   accounts_id  = getOption("rfacebookstat.accounts_id"),
   api_version  = getOption("rfacebookstat.api_version"), 
   username     = getOption("rfacebookstat.username"),
   token_path   = fbTokenPath(),
   access_token = getOption("rfacebookstat.access_token")) 
}

\arguments{
  \item{accounts_id}{Your account ID, for example 'act_11111111111111111'.}
  \item{access_token}{Your facebook API token.}
  \item{username}{your username on Facebook}
  \item{token_path}{path to dir with credentials}
  \item{api_version}{Current Facebook API version.}
}

\value{
Data frame with custom conversion list.
}

\author{Alexey Seleznev}

\examples{
\dontrun{
conversions <- fbGetAdAccountsConversions()
							  
}
}
