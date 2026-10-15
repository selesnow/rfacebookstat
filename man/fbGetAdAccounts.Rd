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
  \item \strong{JSON string}: A JSON array of filter objects, e.g., \code{'[{"field":"account_status","operator":"IN","value":[1]}]'}.
  \item \strong{Character vector shortcut}: String format \code{"<field> <operator> <value>"}, e.g., \code{c("account_status IN 1", "name CONTAIN Shop")}.
}

\strong{Common filterable fields}:
\itemize{
  \item \code{account_status}: Status code of the ad account (1 = ACTIVE, 2 = DISABLED, 3 = UNSETTLED, 7 = PENDING_RISK_REVIEW, 9 = IN_GRACE_PERIOD, 100 = PENDING_CLOSURE, 101 = CLOSED, 201 = ANY_ACTIVE, 202 = ANY_CLOSED).
  \item \code{name}: Ad account name.
  \item \code{id} or \code{account_id}: Ad account ID.
  \item \code{permitted_tasks}: Permissions granted on the account (e.g., \code{"MANAGE"}, \code{"ADVERTISE"}).
}

\strong{Supported operators}:
\itemize{
  \item \code{EQUAL}, \code{NOT_EQUAL}
  \item \code{IN}, \code{NOT_IN}
  \item \code{CONTAIN}, \code{NOT_CONTAIN}
  \item \code{STARTS_WITH}
}
}

\value{
Data frame (tibble) with ad account list and metadata.
}

\author{Alexey Seleznev}

\examples{
\dontrun{
# Load all ad accounts
all_accounts <- fbGetAdAccounts()

# Filter active accounts only using R list format
active_accounts <- fbGetAdAccounts(
  source_id = "xxxxxxxxxxxxx",
  filtering = list(
    list(field = "account_status", operator = "IN", value = list(1))
  )
)

# Filter accounts by name using JSON string
shop_accounts <- fbGetAdAccounts(
  source_id = "xxxxxxxxxxxxx",
  filtering = '[{"field":"name","operator":"CONTAIN","value":"Shop"}]'
)

# Filter specific accounts by ID using list format
specific_accounts <- fbGetAdAccounts(
  source_id = "xxxxxxxxxxxxx",
  filtering = list(
    list(field = "account_id", operator = "IN", value = list("111111", "222222"))
  )
)

# Filter using character vector shortcut format
active_shops <- fbGetAdAccounts(
  source_id = "xxxxxxxxxxxxx",
  filtering = c("account_status IN 1", "name CONTAIN Shop")
)
}
}
