.onAttach <- function(lib, pkg,...){
  packageStartupMessage(rfacebookstatWelcomeMessage())
  
  packageStartupMessage("rfacebookstat presets:")
  
  ## token path
  packageStartupMessage("...Set rfacebookstat token_path: ", appendLF = F)
  if ( Sys.getenv("RFB_TOKEN_PATH") != "" ) {
    packageStartupMessage("success")
  } else {
    packageStartupMessage("none")
  }
  
  ## username
  packageStartupMessage("...Set rfacebookstat username: ", appendLF = F)
  if ( Sys.getenv("RFB_USER") != "" ) {
    packageStartupMessage("success")
  } else {
    packageStartupMessage("none")
  }
  
  ## access token
  packageStartupMessage("...Set rfacebookstat access_token: ", appendLF = F)
  if ( Sys.getenv("RFB_API_TOKEN") != "" ) {
    packageStartupMessage("success")
  } else {
    packageStartupMessage("none")
  }
  
  # api version
  packageStartupMessage("...Set Facebook Marketing API Version: ", appendLF = F)
  packageStartupMessage(getOption("rfacebookstat.api_version"))
}

#
#

rfacebookstatWelcomeMessage <- function(){
  # library(utils)
  
  paste0("\n",
         "---------------------\n",
         "Welcome to rfacebookstat version ", utils::packageDescription("rfacebookstat")$Version, "\n",
         "\n",
         "Author:           Alexey Seleznev (Head of analytics dept at Netpeak).\n",
         "Telegram channel: https://t.me/R4marketing \n",
         "YouTube channel:  https://www.youtube.com/R4marketing/?sub_confirmation=1 \n",
         "Email:            selesnow@gmail.com\n",
         "Site:             https://selesnow.github.io \n",
         "Blog:             https://alexeyseleznev.wordpress.com \n",
         "Facebook:         https://facebook.com/selesnown \n",
         "Linkedin:         https://www.linkedin.com/in/selesnow \n",
         "\n",
         "Type ?rfacebookstat for the main documentation.\n",
         "The github page is: https://github.com/selesnow/rfacebookstat/\n",
		 "Package site: https://selesnow.github.io/rfacebookstat/\n",
         "\n",
         "Suggestions and bug-reports can be submitted at: https://github.com/selesnow/rfacebookstat/issues\n",
         "Or contact: <selesnow@gmail.com>\n",
         "\n",
         "\tTo suppress this message use:  ", "suppressPackageStartupMessages(library(rfacebookstat))\n",
         "---------------------\n"
  )
}

    
.onLoad <- function(libname, pkgname) {
  
  # check environment variables
  ## token path
  if ( Sys.getenv("RFB_TOKEN_PATH") != "" ) {
    
    fb_token_path <- Sys.getenv("RFB_TOKEN_PATH")
    
  } else {
    
    fb_token_path <- NULL
    
  }
  
  ## username
  if ( Sys.getenv("RFB_USER") != "" ) {
    
    fb_user <- Sys.getenv("RFB_USER")
    
  } else {
    
    fb_user <- NULL
    
  }
  
  ## access token
  if ( Sys.getenv("RFB_API_TOKEN") != "" ) {
    
    fb_token <- Sys.getenv("RFB_API_TOKEN")
    
  } else {
    
    fb_token <- NULL
    
  }
  
  op <- options()
  op.rfacebookstat <- list(rfacebookstat.api_version  = "v8.0",
                           rfacebookstat.access_token = fb_token,
                           rfacebookstat.accounts_id  = NULL,
                           rfacebookstat.business_id  = NULL,
                           rfacebookstat.token_path   = fb_token_path,
                           rfacebookstat.username     = fb_user,
                           rfacebookstat.app_id       = 176943372709235,
                           rfacebookstat.app_secret   = "94b55b4f2396e50f6e8780377fe1bab6")
					   
  toset <- !(names(op.rfacebookstat) %in% names(op))
  if (any(toset)) options(op.rfacebookstat[toset])
  
  invisible()
}