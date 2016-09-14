## Create a Word Cloud using Twitter

# Install and load these packages
require(wordcloud)
require(tm)
require(RCurl)
require(twitteR)
require(ROAuth)

setup_twitter_oauth(Consumer_Key, Consumer_Secret, Access_Token, Access_Secret)

# Convert list to vector
HillarySupporters <- searchTwitteR('president+Hillary+election', n=5000, resultType ="weekly")

# Chack Class to confirm list
class(HillarySupporters)

# Extract Text 
HillarySupporters_Text <- sapply(HillarySupporters, function(x) x$getText())

# Check structure of HillarySupporters_Text Value
str(HillarySupporters_Text)

# Remove Websites
CleanHillarySupportersText <- gsub("(f|ht)tp(s?)://(.*)[.][a-z]+", "", HillarySupporters_Text)

# Remove spammed values by only selecting unique tweets
Hillary_unique <- unique(CleanHillarySupportersText)

# Us TM pachage to convert collection of texts to a text corpus.
Hillary_corpus <- Corpus(VectorSource(HillarySupporters_Text))

# Start Cleaning data
# Create new clean value
# Remove puncuation
Hillary_clean <- tm_map(Hillary_corpus, removePunctuation)

# Convert all characters to lower case
Hillary_clean <- tm_map(Hillary_corpus, content_transformer(tolower))
# Remove all stop words ("and" "the" "etc").
Hillary_clean <- tm_map(Hillary_corpus, removeWords, stopwords("english"))
# Remove numbers
Hillary_clean <- tm_map(Hillary_corpus, removeNumbers)
# Remove all the white space
Hillary_clean <- tm_map(Hillary_corpus, stripWhitespace)
# Remove obvious words: 'president+Hillary+election'
Hillary_clean <- tm_map(Hillary_clean, removeWords, c("president","President","hillary","election","Election","Hillary","Clinton","clinton"))

# Make and Scale the Word Cloud
wordcloud(Hillary_clean, max.words = 100, random.order = F, col= rainbow(20), scale = c(6, .5))