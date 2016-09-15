# Load required libraries
require(wordcloud)
require(tm)
require(RCurl)
require(twitteR)
require(ROAuth)

setup_twitter_oauth(Consumer_Key, Consumer_Secret, Access_Token, Access_Secret)

Online <- searchTwitteR('Online Learning', n=5000, resultType ="recent")

Onlinetext <- sapply(Online, function(x) x$getText())

CleanOnlinetext <- gsub("(f|ht)tp(s?)://(.*)[.][a-z]+", "", Onlinetext)

Online_unique <- unique(CleanOnlinetext)

OnlineCorpus <- Corpus(VectorSource(Online_unique))

Online_clean <- tm_map(OnlineCorpus, removePunctuation)
Online_clean <- tm_map(Online_clean, content_transformer(tolower))
Online_clean <- tm_map(Online_clean, removeWords, stopwords("english"))
Online_clean <- tm_map(Online_clean, removeNumbers)
Online_clean <- tm_map(Online_clean, stripWhitespace)
Online_clean <- tm_map(Online_clean, removeWords, c("Online Learning","https","Learning","the","The","learning","Online","online"))

# Create Word cloud
wordcloud(Online_clean, max.words = 100, random.order = F, col= rainbow(20), scale = c(6, .5))
