#' @title Get ad account details by ID
#'
#' @description \code{fbGetAdAccount} loads ad account details for a specific ad account or a vector of ad account IDs from Facebook Marketing API into R.
#'
#' @param account_id Vector of one or more Facebook Ad Account IDs (with or without 'act_' prefix).
#' @param fields Character string or vector of requested fields separated by comma. Default includes basic account info, status, spend and balance.
#' @param api_version Current Facebook Marketing API version.
#' @param username Your username on Facebook.
#' @param token_path Path to directory with credentials.
#' @param access_token Your Facebook API access token.
#'
#' @author Alexey Seleznev
#'
#' @return Data frame (tibble) with ad account details.
#'
#' @export
#'
#' @examples
#' \dontrun{
#' # Get details for a single account
#' acc <- fbGetAdAccount(account_id = "1090055510425474")
#'
#' # Get details for multiple accounts
#' accs <- fbGetAdAccount(account_id = c("1090055510425474", "act_2090055510425474"))
#' }
fbGetAdAccount <- function(
    account_id   = getOption("rfacebookstat.account_id"),
    fields       = paste0("id,name,account_id,account_status,amount_spent,",
                          "created_time,balance,business_name,currency,owner,",
                          "timezone_name,disable_reason,spend_cap"),
    api_version  = getOption("rfacebookstat.api_version"),
    username     = getOption("rfacebookstat.username"),
    token_path   = fbTokenPath(),
    access_token = getOption("rfacebookstat.access_token")
) {
  
  # check account_id
  if (is.null(account_id)) {
    account_id <- getOption("rfacebookstat.accounts_id")
  }
  
  if (is.null(account_id) || length(account_id) == 0) {
    stop("Please specify 'account_id' argument.")
  }
  
  # auth 
  if (is.null(access_token)) {    
    if (Sys.getenv("RFB_API_TOKEN") != "") {
      access_token <- Sys.getenv("RFB_API_TOKEN")    
    } else {
      access_token <- fbAuth(username   = username, 
                             token_path = token_path)$access_token
    }
  }
  
  if (inherits(access_token, "fb_access_token")) {
    access_token <- access_token$access_token
  }
  
  # format fields
  if (length(fields) > 1) {
    fields <- paste0(fields, collapse = ",")
  }
  
  # filter NA and normalize account_id
  account_id <- account_id[!is.na(account_id)]
  if (length(account_id) == 0) {
    stop("Please specify at least one valid account_id")
  }
  act_ids <- unique(ifelse(grepl("^act_", account_id), as.character(account_id), paste0("act_", account_id)))
  
  # attributes
  rq_ids      <- list()
  out_headers <- list()
  result      <- tibble()
  
  # activate progress bar
  if (length(act_ids) > 1) {
    pgbar   <- TRUE
    pb_step <- 0
    pb      <- txtProgressBar(min = 0, 
                              max = length(act_ids), 
                              style = 3, 
                              title = "Loading ad accounts:", 
                              label = "load")
  } else {
    pgbar <- FALSE
  }
  
  for (act_id in act_ids) {
    
    url <- str_interp("https://graph.facebook.com/${api_version}/${act_id}")
    
    answer <- GET(url, query = list(fields       = fields,
                                    access_token = access_token))
    
    # attr
    rq_ids      <- append(rq_ids, setNames(list(status_code(answer)), answer$headers$`x-fb-trace-id`))
    out_headers <- append(out_headers, setNames(list(headers(answer)), answer$headers$`x-fb-trace-id`))
    
    # parse result
    raw <- content(answer, "parse", "application/json", encoding = "UTF-8")
    
    # check error
    if (!is.null(raw$error)) {
      err_msg <- raw$error$message
      if (!is.null(raw$error$error_user_title)) err_msg <- paste0(raw$error$error_user_title, ": ", err_msg)
      if (!is.null(raw$error$error_user_msg))   err_msg <- paste0(err_msg, ". ", raw$error$error_user_msg)
      if (!is.null(raw$error$code))             err_msg <- paste0(err_msg, " (Code: ", raw$error$code, ")")
      stop(err_msg)
    }
    
    # bind to result
    temp_data <- map_df(list(raw), flatten)
    result    <- bind_rows(result, temp_data)
    
    # pause between query
    if (pgbar) Sys.sleep(0.2)
    
    # set progress bar
    if (pgbar) {
      pb_step <- pb_step + 1
      setTxtProgressBar(pb, pb_step)
    }
  }
  
  # close progress bar
  if (pgbar) close(pb)
  
  if (nrow(result) > 0) {
    # Transform cents to currency units
    if ("balance" %in% names(result)) {
      result$balance      <- as.numeric(result$balance) / 100
    }
    if ("amount_spent" %in% names(result)) {
      result$amount_spent <- as.numeric(result$amount_spent) / 100
    }
    if ("spend_cap" %in% names(result)) {
      result$spend_cap    <- as.numeric(result$spend_cap) / 100
    }
    
    # joining disable reason names
    if ("disable_reason" %in% names(result)) {
      result$disable_reason <- as.numeric(result$disable_reason)
      result <- left_join(result,
                          fb_data.disable_reason,
                          by = c("disable_reason" = "reason_id"))
    }
    
    # joining account status names
    if ("account_status" %in% names(result)) {
      result$account_status <- as.numeric(result$account_status)
      result <- left_join(result,
                          fb_data.account_statuses,
                          by = c("account_status" = "status_id"))
    }
  }
  
  # set attributes
  attr(result, "request_ids") <- rq_ids
  attr(result, "headers")     <- out_headers
  
  return(result)
}
