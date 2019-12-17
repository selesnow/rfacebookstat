fbGetCatalogs <- function(business_id  = getOption("rfacebookstat.business_id") ,
                          api_version  = getOption("rfacebookstat.api_version"),
                          username     = getOption("rfacebookstat.username"),
                          token_path   = fbTokenPath(),
                          access_token = getOption("rfacebookstat.access_token")) {
  
  # auth 
  if ( is.null(access_token) ) {    
    
    if ( Sys.getenv("RFB_API_TOKEN") != "" )  {
	    access_token <- Sys.getenv("RFB_API_TOKEN")    
 	} else {
        access_token <- fbAuth(username   = username, 
                               token_path = token_path)$access_token
    }
  }
  
  if ( class(access_token) == "fb_access_token" ) {
    
    access_token <- access_token$access_token
    
  }
  
  if(is.null(business_id)|is.null(access_token)){
    stop("Arguments business_id and access_token is require.")
  }
  
  # attributes
  rq_ids      <- list()
  out_headers <- list()
  
  #check stringAsFactor
  factor_change <- FALSE
  
  #change string is factor if TRUE
  if(getOption("stringsAsFactors")){
    options(stringsAsFactors = F)
    factor_change <- TRUE
  }
  
  QueryString <- paste0("https://graph.facebook.com/",api_version,"/",business_id,"/owned_product_catalogs?limit=1500&access_token=",access_token)
  answer_owned_product_catalogs <- httr::GET(QueryString)
  
  # attr
  rq_ids      <- append(rq_ids, setNames(list(status_code(answer_owned_product_catalogs)), answer_owned_product_catalogs$headers$`x-fb-trace-id`))
  out_headers <- append(out_headers, setNames(list(headers(answer_owned_product_catalogs)), answer_owned_product_catalogs$headers$`x-fb-trace-id`))
  
  
  content_owned_product_catalogs <- content(answer_owned_product_catalogs)
  owned_product_catalogs <- map_df(content_owned_product_catalogs$data, ~ 
                                     data.frame(id = .x$id,
                                     name = .x$name)) %>%
                            mutate(catalog_typr = "owner")
 
  QueryString <- paste0("https://graph.facebook.com/",api_version,"/",business_id,"/client_product_catalogs?limit=1500&access_token=",access_token)
  answer_client_product_catalogs <- httr::GET(QueryString)
  
  # attr
  rq_ids      <- append(rq_ids, setNames(list(status_code(answer_client_product_catalogs)), answer_client_product_catalogs$headers$`x-fb-trace-id`))
  out_headers <- append(out_headers, setNames(list(headers(answer_client_product_catalogs)), answer_client_product_catalogs$headers$`x-fb-trace-id`))
    
  content_client_product_catalogs <- content(answer_client_product_catalogs)
  
  client_product_catalogs <- map_df(content_client_product_catalogs$data, ~ 
                                     data.frame(id = .x$id,
                                                name = .x$name)) %>%
                             mutate(catalog_typr = "client")
  
  result <- bind_rows(owned_product_catalogs, client_product_catalogs)
  
  # set attributes
  attr(result, "request_ids") <- rq_ids
  attr(result, "headers")     <- out_headers
  
  return(result)
}