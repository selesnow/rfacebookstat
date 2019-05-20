fbGetCatalogs <- function(business_id  = getOption("rfacebookstat.business_id") ,
                          api_version  = getOption("rfacebookstat.api_version"),
                          access_token = getOption("rfacebookstat.access_token")) {
  
  
  if(is.null(business_id)|is.null(access_token)){
    stop("Arguments business_id and access_token is require.")
  }
  
  #check stringAsFactor
  factor_change <- FALSE
  
  #change string is factor if TRUE
  if(getOption("stringsAsFactors")){
    options(stringsAsFactors = F)
    factor_change <- TRUE
  }
  
  QueryString <- paste0("https://graph.facebook.com/",api_version,"/",business_id,"/owned_product_catalogs?limit=1500&access_token=",access_token)
  answer_owned_product_catalogs <- httr::GET(QueryString)
  content_owned_product_catalogs <- content(answer_owned_product_catalogs)
  owned_product_catalogs <- map_df(content_owned_product_catalogs$data, ~ 
                                     data.frame(id = .x$id,
                                     name = .x$name)) %>%
                            mutate(catalog_typr = "owner")
 
  QueryString <- paste0("https://graph.facebook.com/",api_version,"/",business_id,"/client_product_catalogs?limit=1500&access_token=",access_token)
  answer_client_product_catalogs <- httr::GET(QueryString)
  content_client_product_catalogs <- content(answer_client_product_catalogs)
  
  client_product_catalogs <- map_df(content_client_product_catalogs$data, ~ 
                                     data.frame(id = .x$id,
                                                name = .x$name)) %>%
                             mutate(catalog_typr = "client")
  
  result <- bind_rows(owned_product_catalogs, client_product_catalogs)
}