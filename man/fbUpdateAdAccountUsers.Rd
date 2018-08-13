\name{fbUpdateAdAccountUsers}
\alias{fbUpdateAdAccountUsers}
\title{Add users and update permission list.}
\description{fbUpdateAdAccountUsers add users and update permission list for users in ad accounts at facebook.}
\usage{
fbUpdateAdAccountUsers(user_ids = NULL, 
                       role = "advertiser", 
					   accounts_id = NULL, 
					   api_version = "v3.1", 
					   access_token = NULL)
}

\arguments{
  \item{accounts_id}{vector with ID of your ad account, for example c("act_00001","act_00002").}
  \item{role}{Character or integer value, one of administator, advertiser, ad manager, analyst, sales, direct sales, 1001, 1002, 1003,1004 (https://developers.facebook.com/docs/marketing-api/aduser/v2.12).}
  \item{access_token}{Your facebook API token.}
  \item{user_ids}{vector with users ids who need remove from ad account.}
  \item{api_version}{Current Facebook API version.}
}

\details{
Requires:
ads_management permission is required.
You need 'Administrator' access to the ad account to remove users

Roles:
1001 = Administrator access
1002 = Advertiser, or ad manager, access
1003 = Analyst access
1004 = Direct sales access. For limited, directly managed accounts.

Permissions:
1: ACCOUNT_ADMIN: modify list of people associated with the account.
2: ADMANAGER_READ: view campaigns and ads
3: ADMANAGER_WRITE: manage campaigns and ads
4: BILLING_READ: view account billing information
5: BILLING_WRITE: modify account billing information
7: REPORTS: run reports
9, 10 - Apply to some directly managed accounts. Not currently needed for Marketing API calls

For more details go link (https://developers.facebook.com/docs/marketing-api/aduser/)
}
\author{Alexey Seleznev}

\examples{
\dontrun{
#Attach package
library(rfacebookstat)

#Get token, where 0000000000000 is id of your app in facebook
tk <- fbGetToken(0000000000000) 

#Add user with id 001 and 002 to accounts act_0001 and act_0002
fbUpdateAdAccountUsers(user_ids = c("001","002"), 
                       accounts_id = c("act_0001","act_0002"), 
                       role = "advertiser",
                       api_version = "v2.12",
                       access_token = tk)
}
}
