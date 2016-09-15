### Learning Analytics Twitter Text Code Mining

# Load required libraries
require(wordcloud)
require(tm)
require(RCurl)
require(twitteR)
require(ROAuth)

## Put keys in quotes
setup_twitter_oauth(Consumer_Key, Consumer_Secret, Access_Token, Access_Secret)

# Pull Twitter Values
LATwitter <- searchTwitteR('Learning Analytics', n=5000, resultType ="yearly")
# Check Class to confirm list
class(LATwitter)

# Extract text
LAtext <- sapply(LATwitter, function(x) x$getText())
# Check class structure
str(LAtext)

# Remove Websites
CleanLAText <- gsub("(f|ht)tp(s?)://(.*)[.][a-z]+", "", LAtext)

# Clean Spammed Tweets by only selecting unique ones 
la_unique <- unique(CleanLAText)

# Create Text Corpus Value
LACorpus <- Corpus(VectorSource(la_unique))

# Create and Clean Corpus
LA_clean <- tm_map(LACorpus, removePunctuation)
LA_clean <- tm_map(LA_clean, content_transformer(tolower))
LA_clean <- tm_map(LA_clean, removeWords, stopwords("english"))
LA_clean <- tm_map(LA_clean, removeNumbers)
LA_clean <- tm_map(LA_clean, stripWhitespace)
LA_clean <- tm_map(LA_clean, removeWords, c("Learning Analytics","https","Learning","learning","analytics"))

# Create Word cloud
wordcloud(LA_clean, max.words = 100, random.order = F, col= rainbow(20), scale = c(6, .5))