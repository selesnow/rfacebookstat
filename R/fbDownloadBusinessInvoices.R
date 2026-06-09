#' @title Download Business Invoices
#'
#' @description \code{fbDownloadBusinessInvoices} downloads invoice PDF files from a vector of URLs. 
#' It automatically handles both Graph API URLs (adding access tokens) and direct CDN URLs.
#'
#' @param urls A character vector of URLs (from `download_uri` or `cdn_download_uri`).
#' @param dest_dir Destination directory where files will be saved. Defaults to the current working directory.
#' @param file_names Optional character vector of file names. If NULL, names will be auto-generated.
#' @param username your username on Facebook
#' @param token_path path to dir with credentials
#' @param access_token Your facebook API token
#'
#' @author Alexey Seleznev
#'
#' @return A data frame (tibble) containing the download status for each URL.
#'
#' @export
fbDownloadBusinessInvoices <- function(urls,
                                       dest_dir     = ".",
                                       file_names   = NULL,
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
  
  if(length(urls) == 0){
    message("URL vector is empty.")
    return(tibble())
  }
  
  # Check directory
  if (!dir.exists(dest_dir)) {
    dir.create(dest_dir, recursive = TRUE)
  }
  
  # Check file names
  if (is.null(file_names)) {
    file_names <- paste0("invoice_", seq_along(urls), ".pdf")
  } else {
    if (length(file_names) != length(urls)) {
      stop("Length of 'file_names' must be equal to the length of 'urls'.")
    }
  }
  
  results <- list()
  
  cat("Downloading invoices...\n")
  pb <- txtProgressBar(min = 0, max = length(urls), style = 3)
  
  for (i in seq_along(urls)) {
    url <- urls[i]
    fname <- file_names[i]
    dest_path <- file.path(dest_dir, fname)
    
    if (is.na(url) || url == "") {
      status <- "Skipped: Empty URL"
    } else {
      # Determine URL type
      if (grepl("graph\\.facebook\\.com", url)) {
        # Graph API URL: requires token
        sep <- ifelse(grepl("\\?", url), "&", "?")
        dl_url <- paste0(url, sep, "access_token=", access_token)
      } else {
        # CDN URL: signed, no token required
        dl_url <- url
      }
      
      # Download using httr
      res <- tryCatch({
        req <- httr::GET(dl_url, httr::write_disk(dest_path, overwrite = TRUE))
        sc <- httr::status_code(req)
        
        if (sc == 200) {
          "Success"
        } else {
          paste0("HTTP Error: ", sc)
        }
      }, error = function(e) {
        paste0("Failed: ", e$message)
      })
      
      status <- res
    }
    
    results[[i]] <- tibble(
      url       = url,
      file_path = dest_path,
      status    = status
    )
    
    setTxtProgressBar(pb, i)
  }
  
  close(pb)
  
  result_df <- bind_rows(results)
  return(result_df)
}
