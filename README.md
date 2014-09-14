RTwitterAPI
===========

A description on how this works can be found here:

http://www.joyofdata.de/blog/talking-to-twitters-rest-api-v1-1-with-r/

```
install.packages("devtools")
devtools::install_github("joyofdata/RTwitterAPI")

library(RTwitterAPI)
 
params <- c(
  "oauth_consumer_key"     = "[API Key]",
  "oauth_nonce"            = NA,
  "oauth_signature_method" = "HMAC-SHA1",
  "oauth_timestamp"        = NA,
  "oauth_token"            = "[Access Token]",
  "oauth_version"          = "1.0",
  "consumer_secret"        = "[API Secret]",
  "oauth_token_secret"     = "[Access Token Secret]"
);

# https://dev.twitter.com/docs/api/1.1/get/followers/ids
url   <- "https://api.twitter.com/1.1/friends/ids.json";
query <- c(cursor=-1, screen_name="hrw", count=10);
 
result <- RTwitterAPI::twitter_api_call(url, query, params, print_result=TRUE)
```
