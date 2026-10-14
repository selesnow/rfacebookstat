\name{fbGetAdAccount}
\alias{fbGetAdAccount}
\title{Get ad account details by ID.}
\description{Load ad account details for a specific ad account or a vector of ad account IDs from Facebook Marketing API into R.}
\usage{
fbGetAdAccount(
  account_id = getOption("rfacebookstat.account_id"),
  fields = paste0("id,name,account_id,account_status,amount_spent,",
                  "created_time,balance,business_name,currency,owner,",
                  "timezone_name,disable_reason,spend_cap"),
  api_version = getOption("rfacebookstat.api_version"),
  username = getOption("rfacebookstat.username"),
  token_path = fbTokenPath(),
  access_token = getOption("rfacebookstat.access_token")
)
}
\arguments{
  \item{account_id}{Vector of one or more Facebook Ad Account IDs (with or without 'act_' prefix).}
  \item{fields}{Character string or vector of requested fields separated by comma. Default includes basic account info, status, spend and balance.}
  \item{api_version}{Current Facebook Marketing API version.}
  \item{username}{Your username on Facebook.}
  \item{token_path}{Path to directory with credentials.}
  \item{access_token}{Your Facebook API access token.}
}
\value{
Data frame (tibble) with ad account details.
}
\author{Alexey Seleznev}
\examples{
\dontrun{
# Get details for a single account
acc <- fbGetAdAccount(account_id = "1090055510425474")

# Get details for multiple accounts
accs <- fbGetAdAccount(account_id = c("1090055510425474", "act_2090055510425474"))
}
}
