setwd("/media/Volume/git-repos/RTwitterAPI/")
source("./twitter_api_call.R");

params <- c(
  "oauth_consumer_key"     = "lAfLvoR3IrJcgy8l33TicvKc5", 
  "oauth_nonce"            = NA,
  "oauth_signature_method" = "HMAC-SHA1",
  "oauth_timestamp"        = NA,
  "oauth_token"            = " 1351429813-2VpzI8sqGtVOgf6lj3zZgfpP5sZ3CYaxadcCcda",
  "oauth_version"          = "1.0",
  "consumer_secret"        = "SLDQxgsEqULMqMaA27BSfzOFYFmH2dJHs48MthBKcEW85Xmxjq",
  "oauth_token_secret"     = "wuviFLxKQqOqXHz0sd6PM769DN4CCeJfPGtW0513Rx5b3"
);

# documentation:
# https://dev.twitter.com/docs/api/1.1/get/friends/ids

url <- "https://api.twitter.com/1.1/friends/ids.json";
query <- c(cursor=-1,screen_name="joyofdata",count=10);

result <- twitter_api_call(url, query, params, print_result=TRUE)

# prints prettify()ed content of result:
#
# {
#   "ids" : [
#     26076934,
#     51754021,
#     391696389,
#     1469734256,
#     19575003,
#     18466967,
#     4816,
#     2329066872,
#     827108112,
#     352947624
#     ],
#   "next_cursor" : 1458759875766514632,
#   "next_cursor_str" : "1458759875766514632",
#   "previous_cursor" : 0,
#   "previous_cursor_str" : "0"
# }