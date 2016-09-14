## Educational Tech Companies in NYC - Twitter Word Cloud
# Load required libraries
require(wordcloud)
require(tm)
require(RCurl)
require(twitteR)
require(ROAuth)

setup_twitter_oauth(Consumer_Key, Consumer_Secret, Access_Token, Access_Secret)
# Pull Twitter Values

EdTechNYCtest <- searchTwitteR('Educational Technology', n=500, resultType ="yearly")
LATwittertest <- searchTwitteR('Learning Analytics', n=5000, resultType ="yearly")

Combined <- LATwittertest + EdTechNYCtest
