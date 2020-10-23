\name{fbGetBusinessManagersUsers}
\alias{fbGetBusinessManagersUsers}
\title{Get a list of business manager users}
\description{Loading user list from business managers.}
\usage{
fbGetBusinessManagersUsers(
   business_ids = getOption("rfacebookstat.business_id"),
   user_types   = c('business_users', 
                    'system_users', 
                    'pending_users'),
   api_version  = getOption("rfacebookstat.api_version"), 
   username     = getOption("rfacebookstat.username"),
   token_path   = fbTokenPath(),
   access_token = getOption("rfacebookstat.access_token"))
}

\arguments{
  \item{business_ids}{IDs by your Business Manager}
  \item{user_types}{user types: business_users, system_users, pending_users.}
  \item{username}{your username on Facebook}
  \item{token_path}{path to dir with credentials}
  \item{access_token}{Your facebook API token.}
  \item{api_version}{Current Facebook API version.}
}

\value{
Data frame with bussiness managers user list.
}

\author{Alexey Seleznev}

\examples{
\dontrun{
options(rfacebookstat.business_id  = 000000000000)

bm_users <- fbGetBusinessManagersUsers()
}
}
