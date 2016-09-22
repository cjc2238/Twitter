# Load required libraries
require(wordcloud)
require(tm)
require(RCurl)
require(twitteR)
require(ROAuth)

# Run API Auth File
source('~/GitHub/Searching Twitter Authentication.R')

Online <- searchTwitteR('Online Learning', n=5000, resultType ="recent")

Onlinetext <- sapply(Online, function(x) x$getText())

CleanOnlinetext <- gsub("(f|ht)tp(s?)://(.*)[.][a-z]+", "", Onlinetext)

Online_unique <- unique(CleanOnlinetext)

OnlineCorpus <- Corpus(VectorSource(Online_unique))

# Clean Corpus
Online_clean <- tm_map(OnlineCorpus, removePunctuation)

# Remove old values
remove(Access_Secret, Access_Token, CleanOnlinetext,Consumer_Key,Consumer_Secret,Online,Online_unique,OnlineCorpus,Onlinetext)


Online_clean <- tm_map(Online_clean, content_transformer(tolower))
Online_clean <- tm_map(Online_clean, removeWords, stopwords("english"))
Online_clean <- tm_map(Online_clean, removeNumbers)
Online_clean <- tm_map(Online_clean, stripWhitespace)
Online_clean <- tm_map(Online_clean, removeWords, c("Online Learning","https","Learning","the","The","learning","Online","online"))

# Create Word cloud
wordcloud(Online_clean, max.words = 100, random.order = F, col= rainbow(20), scale = c(6, .5))
