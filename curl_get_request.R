library(jsonlite);
library(RCurl);

# GET request to the API
# https://dev.twitter.com/docs/auth/authorizing-request

curl_get_request <- function(url, api, params, print_result=FALSE) {
  if(is.na(params["oauth_timestamp"])) {
    params["oauth_timestamp"] <- as.character(as.integer(Sys.time()));
  }
  
  if(is.na(params["oauth_nonce"])) {
    params["oauth_nonce"] <- sprintf("%d%s",as.integer(Sys.time()),paste(floor(runif(6)*10^6),collapse=""));
  }
  
  params["oauth_signature"] <- oauth1_signature(method = "GET", url, api, params);
  
  httpheader <- c(
    "Authorization" = sprintf(paste(c(
      'OAuth oauth_consumer_key="%s", oauth_nonce="%s", oauth_signature="%s", ',
      'oauth_signature_method="%s", oauth_timestamp="%s", oauth_token="%s", oauth_version="1.0"'),
      collapse=""),
      params["oauth_consumer_key"], params["oauth_nonce"], params["oauth_signature"],
      params["oauth_signature_method"], params["oauth_timestamp"], params["oauth_token"], params["oauth_version"])
  );
  
  q <- paste(paste(names(api),api,sep="="), collapse="&");
  urlq <- paste(url,q,sep="?");
  
  result <- getURL(urlq, httpheader=httpheader);
  
  if(print_result) {
    cat(prettify(result));
  }
  
  return(result);
}