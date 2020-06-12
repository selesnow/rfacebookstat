\name{fbGetAdCreative}
\alias{fbGetAdCreative}

\title{Get creative list from facebook marketing API}
\description{Get ads creatives list with parameters from facebook marketing API. Format which provides layout and contains content for the ad. }
\usage{
fbGetAdCreative(
        accounts_id = getOption("rfacebookstat.accounts_id"), 
        filtering   = NULL,
        api_version = getOption("rfacebookstat.api_version"), 
				username    = getOption("rfacebookstat.username"),
	      token_path  = fbTokenPath(),
				access_token = getOption("rfacebookstat.access_token"))
}
\arguments{
  \item{accounts_id}{Your account ID, for example 'act_11111111111111111'.}
  \item{filtering}{filter creatives}
  \item{api_version}{Current Facebook API version.}
  \item{username}{your username on Facebook}
  \item{token_path}{path to dir with credentials}
  \item{access_token}{Your facebook API token.}
}

\value{
Data frame with ads list.
\item{1. id}{The ID of this creative.}
\item{2. name}{The name of the creative in the creative library.}
\item{3. status}{The status of this creative.}
\item{4. url_tags}{A set of query string parameters which will replace or be appended to urls clicked from page post ads, message of the post, and canvas app install creatives only.}
\item{5. account_id}{The ID of the ad account that this ad belongs to.}
\item{5. page_id}{ID of a Facebook page. An unpublished page post will be created on this page. User must have Admin or Editor role for this page.}
\item{5. link}{Link url.}
\item{6. message}{The main body of the post.}
\item{7. caption}{Link caption.}
\item{8. attachment_style}{The style of the attachment}
\item{9. description}{Link description. }
\item{10. image_hash}{Hash of an image in your image library with Facebook. }
}

\author{Alexey Seleznev}


\examples{
\dontrun{
library(rfacebookstat)
fb_token <- fbGetToken(app_id = 0000000)
ads_creative <- fbGetAdCreative(accounts_id  = "act_11111111111111111",
                                api_version  = 'v3.0',
                                access_token = fb_token)
}

}
