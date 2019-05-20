\name{fbGetAdAccountUsersPermissions}
\alias{fbGetAdAccountUsersPermissions}
\title{Get ad account user list with him permissions.}
\description{fbGetAdAccountUsersPermissions get ad account user list with him permissions. in R.}
\usage{
fbGetAdAccountUsersPermissions(
    accounts_id = getOption("rfacebookstat.accounts_id"), 
	api_version = getOption("rfacebookstat.api_version"), 
	console_type = "progressbar", 
	access_token = getOption("rfacebookstat.access_token"))
}

\arguments{
  \item{accounts_id}{vector with ID of your ad account, for example c("act_00001","act_00002").}
  \item{access_token}{Your facebook API token.}
  \item{console_type}{Console output type.}
  \item{api_version}{Current Facebook API version.}
}

\value{
Data frame with ad account user permissions list.
}

\author{Alexey Seleznev}

\examples{
\dontrun{
UP <- fbGetAdAccountUsersPermissions(accounts_id = c("act_00001","act_00002"), 
                                     api_version = "v2.10", 
	    						     access_token = "xxxxxx")
}
}
