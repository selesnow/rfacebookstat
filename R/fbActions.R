# action hander 
# https://developers.facebook.com/docs/marketing-api/reference/ads-action-stats/

name <- NULL
val  <- NULL
.    <- NULL
type <- NULL

# create methode
fbAction <- function(x, ...) {
  
  UseMethod("fbAction", x)
  
}

# cteate parser of all methods
# ============
# actions
# ============
fbAction.actions <- function( obj ) {
 
  # action breakdown handing
    tempData <- list()
    
    for ( o1 in obj$data ) {
      
      if ( ! is.null(o1$actions) ) {
        
        r <- lapply(o1$actions, function(x) list(name = x$action_type,
                                                 val  = x$value)) %>%
            map_df(flatten) %>%
            unique() %>%
            spread(key = name, value = val)

        
        f <-  o1[! names(o1) == "actions"] %>%
              do.call("cbind", .) %>% 
              cbind(., r) %>%
              lapply( as.character )
        
      } else {
        f <-  o1[ ! names(o1) == "actions" ] %>%
          bind_cols()
      }
      
      tempData <- append(tempData, list(f))
      
    }
    
    #Adding data to result
    tempData <- purrr::map_df(tempData, purrr::flatten)
    return(tempData)
}

# ============
# action_device
# ============
fbAction.action_device <- function( obj ) {
  
  # action breakdown handing
  tempData <- list()
  
  for ( o1 in obj$data ) {
    
    if ( ! is.null(o1$actions) ) {
      
      r <- lapply(o1$actions, function(x) list(name = x$action_device,
                                               val  = x$value)) %>%
        map_df(flatten) %>%
        unique() %>%
        spread(key = name, value = val)
      
      
      f <-  o1[! names(o1) == "actions"] %>%
        do.call("cbind", .) %>%
        cbind(., r) %>%
        lapply( as.character )
      
    } else {
      f <-  o1[ ! names(o1) == "actions" ] %>%
        bind_cols()
    }
    
    tempData <- append(tempData, list(f))
    
  }
  
  #Adding data to result
  tempData <- purrr::map_df(tempData, purrr::flatten)
  return(tempData)
}

# ============
# action_destination
# ============
fbAction.action_destination <- function( obj ) {
  
  # action breakdown handing
  tempData <- list()
  
  for ( o1 in obj$data ) {
    
    if ( ! is.null(o1$actions) ) {
      
      r <- lapply(o1$actions, function(x) list(name = x$action_destination,
                                               val  = x$value)) %>%
            map_df(flatten) %>%
            group_by(name) %>%
            summarise(val = sum( as.integer(val) )) %>%
            unique() %>%
            spread(key = name, value = val) 
      
      f <-  o1[! names(o1) == "actions"] %>%
        do.call("cbind", .) %>%
        cbind(., r) %>%
        lapply( as.character )
      
    } else {
      f <-  o1[ ! names(o1) == "actions" ] %>%
        bind_cols()
    }
    
    tempData <- append(tempData, list(f))
    
  }
  
  #Adding data to result
  tempData <- purrr::map_df(tempData, purrr::flatten)
  return(tempData)
}

# ============
# action_reaction
# ============
fbAction.action_reaction <- function( obj ) {
  
  # action breakdown handing
  tempData <- list()
  
  for ( o1 in obj$data ) {
    
    if ( ! is.null(o1$actions) ) {
      
      r <- lapply(o1$actions, function(x) list(name = ifelse( is.null(x$action_reaction), NA,  x$action_reaction),
                                               type = ifelse( is.null(x$action_type), NA,  x$action_type),
                                               val  = x$value)) %>%
        map_df(flatten) %>%
        mutate(name = str_c(type, name, sep = "."),
               name = ifelse( is.na(name), type, name) ) %>%
        select(name, val) %>%
        group_by(name) %>%
        summarise(val = sum( as.integer(val))) %>%
        unique() %>%
        spread(key = name, value = val)
      
      
      f <-  o1[! names(o1) == "actions"] %>%
        do.call("cbind", .) %>%
        cbind(., r) %>%
        lapply( as.character )
      
    } else {
      f <-  o1[ ! names(o1) == "actions" ] %>%
        bind_cols()
    }
    
    tempData <- append(tempData, list(f))
    
  }
  
  #Adding data to result
  tempData <- purrr::map_df(tempData, purrr::flatten)
  return(tempData)
}

# ============
# action_target_id
# ============
fbAction.action_target_id <- function( obj ) {
  
  # action breakdown handing
  tempData <- list()
  
  for ( o1 in obj$data ) {
    
    if ( ! is.null(o1$actions) ) {
      
      r <- lapply(o1$actions, function(x) list(action_target_id = x$action_target_id,
                                               action_value     = x$value)) %>%
           map_df(flatten)
      
      f <-  o1[! names(o1) == "actions"] %>%
                do.call("cbind", .) %>%
                cbind(., r) %>%
        lapply( as.character )
      
    } else {
      f <-  o1[ ! names(o1) == "actions" ] %>%
            bind_cols()
    }
    
    tempData <- append(tempData, list(f))
    
  }
  
  #Adding data to result
  tempData <- bind_rows(tempData)
  return(tempData)
}

# ============
# action_type
# ============
fbAction.action_type <- function( obj ) {
  
  # action breakdown handing
  tempData <- list()
  
  for ( o1 in obj$data ) {
    
    if ( ! is.null(o1$actions) ) {
      
      r <- lapply(o1$actions, function(x) list(name = x$action_type,
                                               val  = x$value)) %>%
        map_df(flatten) %>%
        unique() %>%
        spread(key = name, value = val)
      
      f <-  o1[! names(o1) == "actions"] %>%
        do.call("cbind", .) %>%
        cbind(., r) %>%
        lapply( as.character )
      
    } else {
      f <-  o1[ ! names(o1) == "actions" ] %>%
        bind_cols()
    }
    
    tempData <- append(tempData, list(f))
    
  }
  
  #Adding data to result
  tempData <- bind_rows(tempData)
  return(tempData)
}
