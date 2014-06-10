library(RCurl);
library(digest);
library(base64enc);

# calculates the signature for the request as described in the docs:
# https://dev.twitter.com/docs/auth/creating-signature

oauth1_signature <- function(method, url, api, params) {
  
  secrets <- params[c("consumer_secret","oauth_token_secret")];
  
  # exclude *_secret
  params <- params[! names(params) %in% c("consumer_secret","oauth_token_secret")]
  
  params <- c(api, params);
  params <- params[sort(names(params))];
  params <- sapply(params, curlEscape);
  pstr <- paste(paste(names(params),"=",params,sep=""),collapse="&");
  
  final <- sprintf("%s&%s&%s",toupper(method), curlEscape(url), curlEscape(pstr));
  
  sig <- sprintf("%s&%s",curlEscape(secrets["consumer_secret"]),curlEscape(secrets["oauth_token_secret"]));
  
  signature <- base64encode(hmac(sig,final,algo="sha1",raw=TRUE));
  
  return(curlEscape(signature));
}

