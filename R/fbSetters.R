fbSetUsername   <- function(username)     {options(rfacebookstat.username    = username)     ;cat(str_interp("Set username: ${username}"))}
fbSetAccount    <- function(accounts_ids) {options(rfacebookstat.accounts_id = accounts_ids) ;cat(str_interp("Set accounts_id: ${paste0(accounts_ids, collapse=', ')}"))}
fbSetBusinessId <- function(business_ids) {options(rfacebookstat.business_id = business_ids) ;cat(str_interp("Set accounts_id: ${paste0(business_ids, collapse=', ')}"))}
fbSetTokenPath  <- function(token_path)   {options(rfacebookstat.token_path  = token_path)   ;cat(str_interp("Set token_path: ${token_path}"))}
fbSetApiVersion <- function(api_version)  {options(rfacebookstat.api_version = api_version)  ;cat(str_interp("Set api_version: ${api_version}"))}