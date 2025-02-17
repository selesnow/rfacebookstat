fb_error_body <- function(resp) {
  body <- resp_body_json(resp)
  message <- str_glue("{body$error$message} (code: {body$error$code} / subcode {body$error$error_subcode})")
  message
}