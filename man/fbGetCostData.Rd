\name{fbGetCostData}
\alias{fbGetCostData}

\title{Get facebook ads cost data.}
\description{Get cost data for loading it into Google Analytics}
\usage{
fbGetCostData(
    accounts_id = getOption("rfacebookstat.accounts_id"),
    date_start         = Sys.Date() - 30,
    date_stop          = Sys.Date(),
    utm_source         = "facebook",
    utm_medium         = "cpc",
    username           = getOption("rfacebookstat.username"),
    token_path         = fbTokenPath(),
    access_token       = getOption("rfacebookstat.access_token"))
}
\arguments{
  \item{accounts_id}{ID of your ad account.}
  \item{date_start}{Start reporting date.}
  \item{date_stop}{End reporting day}
  \item{utm_source}{UTM source name for Google Analytics.}
  \item{utm_medium}{UTM medium name for Google Analytics.}
  \item{username}{your username on Facebook}
  \item{token_path}{path to dir with credentials}
  \item{access_token}{Your facebook API token}
}

\value{Data frame with statistic.}
\details{
Before loading data create data source at Google Analytics.
}


\author{Alexey Seleznev}

\seealso{

\href{https://support.google.com/analytics/answer/6014980}{Google Analytics: Understand Data Sets }

}
\examples{
\dontrun{

# Use googleAnalyticsR for upload data into Google Analytics
library(googleAnalyticsR)

# load cost data
cost_data <- fbGetCostData(accounts_id = "act_11111",
                           date_start  = "2020-05-10", 
                           date_stop   = "2020-05-14",
                           username    = "fb_login")
                              
# upload into GA source
ga_custom_upload_file(accountId          = xxxx, 
                      webPropertyId      = "UA-xxxx-1", 
                      customDataSourceId = 'abcdefg', 
                      cost_data)
}
}

