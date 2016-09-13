## Pulling Data from Twitter using API
## Create twitter username
## Then go to https://apps.twitter.com/app/new 
## Create new application
## Once application has been generated, go to "Keys and Tokens" tab.
## Generate new "Access Token" at the bottom of this page.
## Load Twitter Libraries 

library(twitteR)
library(httr)
library(ROAuth)
## Put keys in quotes
setup_twitter_oauth(consumer_key, consumer_secret, access_token=NULL, access_secret=NULL)


