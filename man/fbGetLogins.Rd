\name{fbGetLogins}
\alias{fbGetLogins}
\title{
Get all authorization logins
}
\description{
Get all your authorized facebook logins
}
\usage{
fbGetLogins(
    token_path = fbTokenPath(), 
    set_login = TRUE)
}
\arguments{
  \item{token_path}{
path to dir with credentials
}
  \item{set_login}{
if TRUE you can choise and change current session login
}
}
\author{
Alexey Seleznev
}
\examples{
\dontrun{
fbGetLogins()
}
}
