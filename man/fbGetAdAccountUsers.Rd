\name{fbGetAdAccountUsers}
\alias{fbGetAdAccountUsers}
\title{Get avable business Managers.}
\description{fbGetAdAccountUsers get data frame with adaccounts user list in R.}
\usage{
fbGetAdAccountUsers(accounts_id = NULL, 
                    api_version = "v3.1", 
					console_type = "progressbar", 
					access_token = NULL)
}

\arguments{
  \item{accounts_id}{vector with ID of your ad account, for example c("act_00001","act_00002").}
  \item{access_token}{Your facebook API token.}
  \item{console_type}{Console output type, "progressbar" or "message"}
  \item{api_version}{Current Facebook API version.}
}

\value{
Data frame with ad account list.
}

\author{Alexey Seleznev}

\examples{
\dontrun{
accountUsers <- fbGetAdAccountUsers(accounts_id = c("act_00001","act_00002"), 
                                    access_token = "xxxxxxxxxxxxxxxxxxxxxxxxxxxxx")
}
}
