# authorization

#' Get API facebook token.
#' @description Get API facebook token for access to facebook ads API.
#'
#' @param app_id ID of your Facebook App
#' @param scopes Permissions provide a way for your app to access data from Facebook. For detail see \href{https://developers.facebook.com/docs/permissions}{docmentation}
#'
#' @return API token
#' @export
#'
#' @examples
#' \dontrun{
#' tkn <- fbGetToken()
#' }
fbGetToken <-
  function(
    app_id = NULL,
    scopes = c("ads_read", "business_management", "pages_manage_ads", "ads_management", "public_profile") 
    ) 
  {
    
    if(is.null(app_id)) stop("Enter your app id.")
    scopes <- paste(scopes, collapse = ",")
    utils::browseURL(paste0("https://www.facebook.com/dialog/oauth?client_id=",app_id  ,"&display=popup&redirect_uri=https://selesnow.github.io/rfacebookstat/getToken/get_token.html&response_type=token&scope=",scopes))
    token <- readline(prompt = "Enter your token: ")
    options(rfacebookstat.access_token = token)
    return(token)
}

# checking token
fbCheckToken <- function(input_token, access_token) {
  
  link <- str_interp("https://graph.facebook.com/debug_token?input_token=${input_token}&access_token=${access_token}")
  
  ans <- GET(link)
  token_info <- content(ans)
  
  return(token_info$data)
  
}

# change token to lingtime
fbGetLongTimeToken <-
  function(client_id = NULL,client_secret = NULL,fb_exchange_token = NULL){
    if(is.null(client_id)|is.null(client_secret)|is.null(fb_exchange_token)){
      stop("Enter your Client ID, client_secret and short time token!")
    }
    link <- paste0("https://graph.facebook.com/oauth/access_token?grant_type=fb_exchange_token&client_id=",client_id,"&client_secret=",client_secret,"&fb_exchange_token=",fb_exchange_token)
    raw_token <- GET(link)
    token_list <- content(raw_token)
    
    if(!is.null(token_list$error)) {
      error <- token_list$error
      message(error)
    }
    
    message("Token changed to long time successfully")

    return(token_list$access_token)
}

# patj to dir with token file
fbTokenPath <- function() {
  
  
  ifelse( is.null(getOption("rfacebookstat.token_path")), 
          getwd(), 
          getOption("rfacebookstat.token_path") )
  
  
}

# user information
fbGetUserInfo <- function(access_token = getOption("rfacebookstat.access_token"),
                          user_id      = "me",
                          api_version  = getOption("rfacebookstat.api_version")) {
  
  link      <- paste0("https://graph.facebook.com/", api_version,"/", user_id, "?fields=id,name&access_token=", access_token)
  
  answer    <- GET(link)
  user_info <- content(answer)
  
  return(user_info)
  
}

# authorize
fbAuth <- function(username    = getOption("rfacebookstat.username"),
                   app_id      = getOption("rfacebookstat.app_id"), 
                   app_secret  = getOption("rfacebookstat.app_secret"), 
                   token_path  = fbTokenPath(),
                   scopes      =  c("ads_read", "business_management", "pages_manage_ads", "ads_management", "public_profile"),
                   reauth      = FALSE,
                   skip_option = FALSE) {
  
  access_path <- file.path(token_path, paste(username, "rfb_auth.rds", sep = "."))
  
  # check options
  if ( ! is.null(getOption( "rfacebookstat.access_token" )) && !skip_option ) {
    
    message("Access token was setted by option, if you want set new access token use skip_options = TRUE.")
    return( getOption( "rfacebookstat.access_token" ) )
    
  }
  
  # check environ variables
  if ( Sys.getenv("RFB_API_TOKEN") != "" && !skip_option ) {
    
    message("Access token was setted from environment variables, if you want set new access token use skip_options = TRUE.")
    return( Sys.getenv("RFB_API_TOKEN")  )
    
  }
  
  if ( file.exists( access_path ) && !reauth ) {
    
    fb_token <- readRDS(access_path)
    message(str_interp("Token load from ${access_path}"))
    
    if ( fb_token$token_info$expires_at != 0 ) {
      
      day_for_expired <- difftime(as.POSIXlt( fb_token$token_info$expires_at,  origin = "1970-01-01"), Sys.Date(), units = "days")
      
      if ( day_for_expired <= 10 ) {
        
        message(str_interp("Your token will be expires after ${day_for_expired} days, auto refreshing"))
        
        # change for longtime
        lt_token <- fbGetLongTimeToken(client_id         = app_id,
                                       client_secret     = app_secret, 
                                       fb_exchange_token = fb_token$access_token)
        
        # check token
        token_info <- fbCheckToken(lt_token, str_interp("${app_id}|${app_secret}"))
        
        # get user info 
        user_info  <- fbGetUserInfo(access_token = lt_token, 
                                    user_id      = ifelse( is.null(token_info$user_id), "me", token_info$user_id))
        
        # create token object
        fb_token   <- list(access_token = lt_token, 
                           token_info   = token_info,
                           user_info    = user_info)
        
        class(fb_token) <- "fb_access_token"
        
        # rewrite rds
        saveRDS(object = fb_token, 
                file   = access_path)
        
        message(str_interp("Refresh token saved in ${access_path}"))
        
      }
      
    }
    
    # set option
    options( rfacebookstat.access_token = fb_token$access_tokn)
    return(fb_token)
    
  } else {
    
    # check mode
    if ( !interactive() ) {
      stop(str_interp("File ${access_path} dont find, run fbAuth in interactive mode for authorization."))
    }
    
    # if reauth
    if ( reauth ) {
      message("Re authorization", ifelse( is.null(username), "", paste0(" under ",username)) )
    }
    
    # get shorttime token
    st_token <- fbGetToken(app_id, scopes)
    
    # change for longtime
    lt_token <- fbGetLongTimeToken(client_id         = app_id,
                                   client_secret     = app_secret, 
                                   fb_exchange_token = st_token)
    
    # check token
    token_info <- fbCheckToken(lt_token, str_interp("${app_id}|${app_secret}"))
    
    # get user info 
    user_info  <- fbGetUserInfo(access_token = lt_token, 
                                user_id      = token_info$user_id)
    
    # create token object
    fb_token   <- list(access_token = lt_token, 
                       token_info   = token_info,
                       user_info    = user_info)
    
    class(fb_token) <- "fb_access_token"
    
    # ask fo cache
    message(str_interp("Do you want save your access token into rds file ${access_path} for use it between R sessions ? "))
    to_cash <- readline( str_interp("y / n (recmedation y) ?: ") )
    
    # cache 
    if ( to_cash %in% tolower( c("y", "yes", "ok", "save") ) ) {
      
      if ( !dir.exists(token_path) ) {
        
        dir.create(token_path, recursive = T)
        
      }
      
      saveRDS(object = fb_token, 
              file   = access_path)
      
      message(str_interp("Token saved in ${access_path}"))
      
    }
    
    # set option
    options( rfacebookstat.access_token = fb_token$access_tokn ,
             rfacebookstat.username     = username)
    return(fb_token)
  }
}



print.fb_access_token <- function (x, show_token = FALSE, ...) {
  
  cat("\n", 
      "Facebook access token\n",
      "Access token: ", ifelse(show_token, x$access_token, "<hidden>"), "\n",
      "App id:       ", x$token_info$app_id, "\n",
      "App name:     ", x$token_info$application, "\n",
      "User id:      ", x$token_info$user_id, "\n",
      "User name:    ", x$user_info$name, "\n",
      "Expires at:   ", ifelse( x$token_info$expires_at == 0, "never", format(as.POSIXlt( x$token_info$expires_at,  origin = "1970-01-01"), "%Y-%m-%d %T"))
      )
	  
  if ( Sys.info()["sysname"] == "Windows" ) {
     utils::writeClipboard(x$access_token)
  }
 
}

# get settings
fbGetSettings <- function() {
  
  rfb_sets <- .Options[ grepl("^rfacebookstat", names(.Options) ) ]
  
  hidden_set <- c("rfacebookstat.app_secret", "rfacebookstat.access_token")
  
  
  
  message("You set ", length(rfb_sets), " options:")
  
  maxname <- max( nchar(names(rfb_sets) ) ) - 14
  
  for ( set in  names(rfb_sets) ) {
    
    key    <- gsub( "rfacebookstat\\.", "", set)
    spaces <- paste0(rep(" ", maxname - nchar(key)), collapse = "")
    key_space <- paste0(key, spaces, ":", collapse = "")
    value  <- ifelse( set %in% hidden_set, 
                      "<hidden>", 
                      as.character(
                          paste0(rfb_sets[[set]], collapse = ", ")
                          ) 
                      )
    value_length <- length(value)
    
    if ( value_length > 3 ) {
      value <- paste0("<vector of ", value_length, " values>", collapse = "")
    }
    
    cat(key_space, value, "\n")
    
  }
  
}

# revoke app privilegies
fbRevokeAppPrivilegies <- 
   function( app_id = getOption("rfacebookstat.app_id") ) {
  browseURL(str_interp("https://www.facebook.com/settings/?tab=business_tools&initial_open_app_id=${app_id}"))
}

# get all logins
fbGetLogins <- function(token_path = fbTokenPath(), set_login = TRUE) {

  files <- dir(token_path, pattern = "\\.rfb_auth\\.rds$")
  logins <- gsub("\\.rfb_auth\\.rds$", replacement = "", files)
  
  if (length(files) == 0) {
    message("You does't have any authorize login.")
    return(NULL)
  }
  
  for (i in 1:length(logins)) {
    cat(i, ":\t", logins[i], "\n")
  }
  
  if (set_login) {
    len <- length(logins)
    login_number <- readline(str_glue("Choose login (enter number from 1 to {len}): "))
    login <- logins[as.integer(login_number)]
    options(rfacebookstat.username = login)
    message(str_glue("Set {login} as default session login"))
    return(login)
  }
  
  return(logins)
  
}
