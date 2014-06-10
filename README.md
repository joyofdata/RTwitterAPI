RTwitterAPI
===========

A description on how this works can be found here:

http://www.joyofdata.de/blog/talking-to-twitters-rest-api-v1-1-with-r/

```
setwd("/[...]/RTwitterAPI/");
source("./twitter_api_call.R");
 
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
 
url   <- "https://api.twitter.com/1.1/friends/ids.json";
query <- c(cursor=-1, screen_name="hrw", count=10);
 
result <- twitter_api_call(url, query, params, print_result=TRUE)
```
