#' GET requests Twitter API
#'
#' @param url f.x. "https://api.twitter.com/1.1/friends/ids.json"
#' @param api f.x. c(cursor=-1, screen_name="hrw", count=10)
#' @param params named vector needed for generating oauth1 signature
#' @param print_result TRUE if you want to have resulting JSON printed out
#' @param use_cygwin TRUE if you would like to resort to Cygwin/Curl workaround
#' @param cygwin_bash f.x. "c:\\cygwin64\\bin\\bash.exe"
#' @return JSON
#' @export
twitter_api_call <- function(
    url, api, params, print_result=FALSE, 
    use_cygwin=FALSE, cygwin_bash="c:\\cygwin64\\bin\\bash.exe", print_cmd=FALSE,
    test=FALSE) {
  library(jsonlite);
  library(RCurl);
  
  if(is.na(params["oauth_timestamp"])) {
    params["oauth_timestamp"] <- as.character(as.integer(Sys.time()));
  }
  
  if(is.na(params["oauth_nonce"])) {
    params["oauth_nonce"] <- sprintf("%d%s",as.integer(Sys.time()),paste(floor(runif(6)*10^6),collapse=""));
  }
  
  if(test) {
    test_data <- oauth1_signature(method = "GET", url, api, params, test=TRUE);
    params["oauth_signature"] <- test_data[["signature_escaped"]]
  } else {
    params["oauth_signature"] <- oauth1_signature(method = "GET", url, api, params, test=FALSE);
  }
  
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
  
  if(!test) {
    if(!use_cygwin) {
      result <- getURL(urlq, httpheader=httpheader);
    } else {
      httpheader_escaped <- sprintf("Authorization: %s",gsub('"','\"',httpheader["Authorization"]))
      cmd <- sprintf("%s -c \"/usr/bin/curl --silent --get '%s' --data '%s' --header '%s'\"", cygwin_bash, url, q, httpheader_escaped)
      if(print_cmd) {
        cat(cmd)
      }
      result <- system(cmd, intern=TRUE)
    }
  } else {
    result <- "{}"
  }
  
  if(print_result) {
    cat(prettify(result));
  }
  
  if(test) {
    test_data[["httpheader"]] <- httpheader
    test_data[["q"]] <- q
    test_data[["urlq"]] <- urlq
    
    return(test_data)
  }
  
  return(result);
}