\name{fbGetAdAccounts}
\alias{fbGetAdAccounts}
\title{Get available ad account list.}
\description{Load data frame with ad accounts available in your Business Manager or user profile from Facebook Marketing API into R.}
\usage{
fbGetAdAccounts(
  source_id = getOption("rfacebookstat.business_id"),
  api_version = getOption("rfacebookstat.api_version"),
  username = getOption("rfacebookstat.username"),
  token_path = fbTokenPath(),
  access_token = getOption("rfacebookstat.access_token"),
  limit = 50,
  filtering = NULL
)
}

\arguments{
  \item{source_id}{Your Business Manager or project ID. If NULL, accounts for current user are returned ('me/adaccounts').}
  \item{access_token}{Your Facebook API access token.}
  \item{username}{Your username on Facebook.}
  \item{token_path}{Path to directory with credentials.}
  \item{api_version}{Current Facebook Marketing API version.}
  \item{limit}{Number of ad accounts requested per API call. Reduce this if you experience unexpected errors. Default is 50.}
  \item{filtering}{Filter ad accounts at the API level. Can be passed as an R list, a JSON string, or a character vector shortcut. See Details.}
}

\details{
The \code{filtering} argument allows filtering ad accounts directly on the Facebook API level, reducing the volume of data transferred and speeding up execution.

Filters can be specified in three formats:
\itemize{
  \item \strong{R list}: A list of lists, where each sublist has elements \code{field}, \code{operator}, and \code{value}.
  \item \strong{JSON string}: A JSON array of filter objects, e.g., \code{'[{"field":"name","operator":"CONTAIN","value":"Shop"}]'}.
  \item \strong{Character vector shortcut}: String format \code{"<field> <operator> <value>"}, e.g., \code{c("account_status EQUAL 1", "name CONTAIN Shop")}.
}

\strong{API supported filterable fields and operators}:
\itemize{
  \item \code{name}: Ad account name. Supported operator: \code{CONTAIN}. Available on both personal profile (\code{me/adaccounts}) and Business Manager.
  \item \code{account_status}: Status code (1 = ACTIVE, 2 = DISABLED, etc.). Supported operator: \code{EQUAL}. (Note: operator \code{IN} is not supported by Facebook on this endpoint).
  \item \code{account_id}: Account ID without prefix. Supported operator: \code{EQUAL} (on \code{me/adaccounts}).
  \item \code{id}: Account ID with \code{act_} prefix (e.g. \code{"act_12345"}). Supported operator: \code{IN} (on Business Manager \code{owned_ad_accounts} / \code{client_ad_accounts}).
}

Note: If you need to retrieve details for a specific set or vector of account IDs, prefer using \code{\link{fbGetAdAccount}}, which queries account nodes directly and does not have edge filtering constraints.
}

\value{
Data frame (tibble) with ad account list and metadata.
}

\author{Alexey Seleznev}

\examples{
\dontrun{
# Load all ad accounts
all_accounts <- fbGetAdAccounts()

# Filter active accounts only (account_status EQUAL 1)
active_accounts <- fbGetAdAccounts(
  source_id = "xxxxxxxxxxxxx",
  filtering = list(
    list(field = "account_status", operator = "EQUAL", value = 1)
  )
)

# Filter accounts by name using JSON string
shop_accounts <- fbGetAdAccounts(
  source_id = "xxxxxxxxxxxxx",
  filtering = '[{"field":"name","operator":"CONTAIN","value":"Shop"}]'
)

# Filter accounts in a Business Manager by ID
bm_accounts <- fbGetAdAccounts(
  source_id = "xxxxxxxxxxxxx",
  filtering = list(
    list(field = "id", operator = "IN", value = list("act_111111", "act_222222"))
  )
)

# Or use fbGetAdAccount() for direct querying of specific IDs
specific_accounts <- fbGetAdAccount(
  account_id = c("1872462700348355", "3281404162010857")
)
}
}
