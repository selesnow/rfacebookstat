# action hander 
# https://developers.facebook.com/docs/marketing-api/reference/ads-action-stats/

name        <- NULL
val         <- NULL
.           <- NULL
type        <- NULL
action_type <- NULL

# create methode
fbAction <- function(obj, ...) {
  
  UseMethod("fbAction", obj)
  
}

# cteate parser of all methods
# ============
# actions
# ============
# ============
fbAction.default <- function( obj, ... ) {
  
  actions <-
    map_df(obj$data, 
           function(.x) {
             
             nm <- names(.x)
             nm <- nm[ ! nm %in% names(.x[unlist(map(.x, is.list))]) ]
             
             other_col <- .x[nm] %>% bind_rows()
             
             if ( length(.x$actions ) > 0 ) {
               
               df_actions <-
                 .x$actions %>%
                 bind_rows() %>%
                 pivot_longer(cols = -matches("action\\_.*" ), names_to = "action_sufix", values_to = "val") %>%
                 unite(action_type, matches("action\\_.*" ), remove = T) %>%
                 replace_na(list(val = "0")) %>%
                 pivot_wider(names_from = "action_type", values_from = "val", values_fill = list("val" = "0")) %>%
                 bind_cols(other_col, .)
               
               action_df <- df_actions
             } 
             
             if ( length(.x$conversions ) > 0 ) {
               
               df_conversion <-
                 .x$conversions %>%
                 bind_rows() %>%
                 pivot_longer(cols = -matches("action\\_.*" ), names_to = "action_sufix", values_to = "val") %>%
                 unite(action_type, matches("action\\_.*" ), remove = T) %>%
                 replace_na(list(val = "0")) %>%
                 pivot_wider(names_from = "action_type", values_from = "val", values_fill = list("val" = "0"))
               
               if ( exists("action_df") ) {
                 
                 action_df <- bind_cols(action_df, df_conversion) 
                 
               } else {
                 
                 action_df <- bind_cols(other_col, df_conversion) 
                 
               }
             } 
             
             if ( length(.x$action_values ) > 0 ) {
               
               df_action_values <-
                 .x$action_values %>%
                 bind_rows() %>%
                 pivot_longer(cols = -matches("action\\_.*" ), names_to = "action_sufix", values_to = "val") %>%
                 mutate(action_type = paste0("action_values.", action_type)) %>%
                 unite(action_type, matches("action\\_.*" ), remove = T) %>%
                 replace_na(list(val = "0")) %>%
                 pivot_wider(names_from = "action_type", values_from = "val", values_fill = list("val" = "0")) 
               
               
               if ( exists("action_df") ) {
                 
                 action_df <- bind_cols(action_df, df_action_values) 
                 
               } else {
                 
                 action_df <- bind_cols(other_col, df_action_values) 
                 
               }
               
             }
             
             if ( length(.x$video_thruplay_watched_actions ) > 0 ) {
               
             df_video <-
               .x[['video_thruplay_watched_actions']] %>%
               bind_rows() %>%
               pivot_longer(cols = -matches("action\\_.*" ), names_to = "action_sufix", values_to = "val") %>%
               mutate(action_type = paste0("video_thruplay", action_type)) %>%
               unite(action_type, matches("action\\_.*" ), remove = T) %>%
               replace_na(list(val = "0")) %>%
               pivot_wider(names_from = "action_type", values_from = "val", values_fill = list("val" = "0")) 
             
             if ( exists("action_df") ) {
               
               action_df <- bind_cols(action_df, df_video) 
               
             } else {
               
               action_df <- bind_cols(other_col, df_video) 
               
             }
             }
             
             if ( length( .x$actions ) + length( .x$action_values ) + length(.x$video_thruplay_watched_actions ) + length(.x$conversions ) == 0 ) {
               
               other_col
               
             } else {
               
               action_df
               
             }
             
           }
    )
  
  return(actions)
}
