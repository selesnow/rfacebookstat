\name{fbGetToken}
\alias{fbGetToken}

\title{Get API facebook token.}
\description{Get API facebook token for access to facebook ads API.}
\usage{
fbGetToken(
    app_id = NULL, 
    scopes = c("ads_read", 
               "business_management", 
               "pages_manage_ads", 
               "ads_management", 
               "public_profile") 
               )
}

\arguments{
  \item{app_id}{ID of your Facebook App}
  \item{scopes}{Permissions provide a way for your app to access data from Facebook. For detail see \href{https://developers.facebook.com/docs/permissions/reference/}{docmentation}}
}

\value{API token}

\author{Alexey Seleznev}

\examples{
\dontrun{
tkn <- fbGetToken()
}
}
