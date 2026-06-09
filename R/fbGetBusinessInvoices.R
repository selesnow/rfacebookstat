#' @title Get Business Invoices
#'
#' @description \code{fbGetBusinessInvoices} get invoices for a Facebook Business Manager.
#'
#' @param business_id ID of the Facebook Business Manager.
#' @param start_date Start date for the billing period (YYYY-MM-DD).
#' @param end_date End date for the billing period (YYYY-MM-DD).
#' @param issue_start_date Start date when the invoice was issued (YYYY-MM-DD).
#' @param issue_end_date End date when the invoice was issued (YYYY-MM-DD).
#' @param invoice_id Filter by a specific invoice ID.
#' @param type Type of the document, e.g., "INV", "PRO_FORMA", "CM", "DM".
#' @param api_version Current Facebook API version.
#' @param username your username on Facebook
#' @param token_path path to dir with credentials
#' @param access_token Your facebook API token
#'
#' @author Alexey Seleznev
#'
#' @return Data frame with business invoices.
#'
#' @export
fbGetBusinessInvoices <- function(business_id,
                                  start_date       = NULL,
                                  end_date         = NULL,
                                  issue_start_date = NULL,
                                  issue_end_date   = NULL,
                                  invoice_id       = NULL,
                                  type             = NULL,
                                  api_version  = getOption("rfacebookstat.api_version"), 
                                  username     = getOption("rfacebookstat.username"),
                                  token_path   = fbTokenPath(),
                                  access_token = getOption("rfacebookstat.access_token")){
  
  # auth 
  if ( is.null(access_token) ) {    
    if ( Sys.getenv("RFB_API_TOKEN") != "" )  {
      access_token <- Sys.getenv("RFB_API_TOKEN")    
    } else {
      access_token <- fbAuth(username   = username, 
                             token_path = token_path)$access_token
    }
  }
  
  if ( inherits(access_token, "fb_access_token") ) {
    access_token <- access_token$access_token
  }
  
  if(is.null(access_token)){
    stop("access_token is required argument!")
  }
  
  if(is.null(business_id)){
    stop("business_id is required argument!")
  }
  
  # attributes
  rq_ids      <- list()
  out_headers <- list()
  result      <- tibble()
  
  # Compose query string
  fields <- "id,invoice_id,type,amount,amount_due,currency,invoice_date,billing_period,payment_status,download_uri,cdn_download_uri,advertiser_name,ad_account_ids"
  
  QueryString <- paste0("https://graph.facebook.com/", api_version, "/", business_id, "/business_invoices?fields=", fields)
  
  # Add optional parameters
  if (!is.null(start_date)) {
    QueryString <- paste0(QueryString, "&start_date=", start_date)
  }
  if (!is.null(end_date)) {
    QueryString <- paste0(QueryString, "&end_date=", end_date)
  }
  if (!is.null(issue_start_date)) {
    QueryString <- paste0(QueryString, "&issue_start_date=", issue_start_date)
  }
  if (!is.null(issue_end_date)) {
    QueryString <- paste0(QueryString, "&issue_end_date=", issue_end_date)
  }
  if (!is.null(invoice_id)) {
    QueryString <- paste0(QueryString, "&invoice_id=", invoice_id)
  }
  if (!is.null(type)) {
    QueryString <- paste0(QueryString, "&type=", type)
  }
  
  QueryString <- paste0(QueryString, "&access_token=", access_token)
  
  # Send query to API server
  answer <- GET(QueryString)
  
  # attr
  rq_ids      <- append(rq_ids, setNames(list(status_code(answer)), answer$headers$`x-fb-trace-id`))
  out_headers <- append(out_headers, setNames(list(headers(answer)), answer$headers$`x-fb-trace-id`))
  
  # Parse result
  raw <- content(answer, "parse", "application/json", encoding = "UTF-8")
  
  # Check error
  if(!is.null(raw$error)){
    stop(paste0(raw$error$message, " (Code: ", raw$error$code, ")"))
  }
  
  if (length(raw$data) == 0) {
    message("No business invoices found.")
    return(result)
  }
  
  # Add data to result data frame
  temp_data <- map_df(raw$data, fbParserBusinessInvoices)
  result    <- bind_rows(result, temp_data)
  
  # Pagination
  while(!is.null(raw$paging$`next`)){
    QueryString <- raw$paging$`next`
    answer <- GET(QueryString)
    
    # attr
    rq_ids      <- append(rq_ids, setNames(list(status_code(answer)), answer$headers$`x-fb-trace-id`))
    out_headers <- append(out_headers, setNames(list(headers(answer)), answer$headers$`x-fb-trace-id`))
    
    raw <- content(answer, "parse", "application/json", encoding = "UTF-8")
    
    if(!is.null(raw$error)){
      stop(paste0(raw$error$message, " (Code: ", raw$error$code, ")"))
    }
    
    # Add data to result data frame
    temp_data <- map_df(raw$data, fbParserBusinessInvoices)
    result    <- bind_rows(result, temp_data)
  }
  
  # set attributes
  attr(result, "request_ids") <- rq_ids
  attr(result, "headers")     <- out_headers
  
  return(result)
}
