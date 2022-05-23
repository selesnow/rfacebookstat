library(rfacebookstat)
library(dplyr)

# accounts
bm <- fbGetBusinessManagers()
my_acs      <- fbGetAdAccounts()
bm_accounts <- fbGetAdAccounts(bm$id[1])
test_accs   <- sample_n(bm_accounts, size = 10, replace = FALSE)$id
# objects
camp        <- fbGetCampaigns(test_accs)
adsets      <- fbGetAdSets(test_accs)
ads         <- fbGetAds(test_accs)
creo        <- fbGetAdCreative(test_accs)
apps        <- fbGetApps()
pages       <- fbGetPages(test_accs)
videos      <- fbGetAdVideos(my_acs$id[4:10])
conversions <- fbGetAdAccountsConversions()
# users
bm_users         <- fbGetBusinessManagersUsers(bm$id[1])
bm_user_accounts <- fbGetBusinessUserAdAccounts(bm_users$id[7], business_id = bm$id[1])
# statistic
simple_stat <- fbGetMarketingStat(
  test_accs, 
  date_start = Sys.Date() - 12, 
  date_stop = Sys.Date() - 1)

action_stat <- fbGetMarketingStat(
  test_accs[3],
  level  = "adset",
  fields = "campaign_name,
            adset_name,
            impressions,
            clicks,
            reach,
            spend,
            actions,
            action_values",
  date_preset = 'last_7d', 
  breakdowns  = 'publisher_platform',
  attribution_window = c('1d_view','7d_click'),
  action_breakdowns = "action_type",
)

# auth tets
# owner
fbAuth('selesnow')
# test user
fbAuth('alexey_dxqanrl_tester@tfbnw.net')
rfacebookstat:::fbRevokeAppPrivilegies()
