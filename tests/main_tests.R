library(rfacebookstat)
library(dplyr)

bm <- fbGetBusinessManagers()
my_acs      <- fbGetAdAccounts()
bm_accounts <- fbGetAdAccounts(bm$id[1])
test_accs   <- sample_n(bm_accounts, size = 10, replace = FALSE)$id

camp   <- fbGetCampaigns(test_accs)
adsets <- fbGetAdSets(test_accs)
ads    <- fbGetAds(test_accs)
creo   <- fbGetAdCreative(test_accs)
apps   <- fbGetApps()
pages  <- fbGetPages(test_accs)
videos <- fbGetAdVideos(my_acs$id[4:10])
conversions <- fbGetAdAccountsConversions()
as_tibble(pages)

fb_data.disable_reason <-
tibble(reason_id   = c(0, 1, 2, 3, 4, 5, 6, 7, 8, 9),
       reason_name = c("NONE",
                       "ADS_INTEGRITY_POLICY",
                       "ADS_IP_REVIEW",
                       "RISK_PAYMENT",
                       "GRAY_ACCOUNT_SHUT_DOWN",
                       "ADS_AFC_REVIEW",
                       "BUSINESS_INTEGRITY_RAR",
                       "PERMANENT_CLOSE",
                       "UNUSED_RESELLER_ACCOUNT",
                       "UNUSED_ACCOUNT"))

save(fb_data.disable_reason, file = "D:/packlab/github/testspace/rfacebookstat/R/sysdata.rda")

  fbGetToken
  
  library(httr)
  tkn <- fbAuth()
  ans <- DELETE("https://graph.facebook.com/1246563312029308/permissions?access_token=EAACg7dbgLXMBACgDSVdhZAHjNY6RsxZC59csSGZB1hMMPe9yvH2qd5oEgwgiyL3HHKpdObrVZAkRJnZC7NlPxXAUy8qXe6jVFgZCwHA3zax6UCz8xKDYF4gFTNyZCtflddTZAPBDaJZBwh7JbuQIyv6n08Lh7EhGBmkWGZBxy3NONhnwT14HoVw6Ng
")
  ans2 <- content(ans,as = "parse", "text/html" )
  
  print()