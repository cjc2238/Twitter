## Create a Word Cloud using Twitter

# Install and load these packages
require(wordcloud)
require(tm)
require(RCurl)
require(twitteR)
require(ROAuth)

setup_twitter_oauth("GNPEgOwQ1wzj324bMCqBrHBgQ", "6IDQUQVLYPE0VCmsBrwQ1rGunEdexj7drvujpyhLidOzc3R7Nd", access_token= "775774019178168322-YKwYEHI8Y43W265WgmNJuayvTV7QNnZ", access_secret= "gUcDbFhitpPkTWuJAAS2MRTLmKrTZxdp6QLJ9kzNxEGb5")

# Convert list to vector
TrumpSupporters <- searchTwitteR('president+trump+election', n=5000, resultType ="weekly")

# Chack Class to confirm list
class(TrumpSupporters)

# Extract Text 
TrumpSupporters_Text <- sapply(TrumpSupporters, function(x) x$getText())

# Check structure of TrumpSupporters_Text Value
str(TrumpSupporters_Text)

# Remove Websites
CleanTrumpText <- gsub("(f|ht)tp(s?)://(.*)[.][a-z]+", "", TrumpSupporters_Text)

# Clean Spammed Tweets by only selecting unique ones 
Trump_unique <- unique(CleanTrumpText)

# Us TM pachage to convert collection of texts to a text corpus.
trump_corpus <- Corpus(VectorSource(Trump_unique))

# Start Cleaning data
# Create new clean value
# Remove puncuation
trump_clean <- tm_map(trump_corpus, removePunctuation)

# Convert all characters to lower case
trump_clean <- tm_map(trump_clean, content_transformer(tolower))

# Remove all stop words ("and" "the" "etc").
trump_clean <- tm_map(trump_clean, removeWords, stopwords("english"))

# Remove numbers
trump_clean <- tm_map(trump_clean, removeNumbers)

# Remove all the white space
trump_clean <- tm_map(trump_clean, stripWhitespace)

# Remove obvious words: 'president+trump+election'
trump_clean <- tm_map(trump_clean, removeWords, c("president","President","trump","election","Election","Trump","Donald","donald"))

# This function makes the word cloud
wordcloud(trump_clean)

# This places the largest values in the center
# This adjusts the scale of the world cloud - max word limit, minimum and maximum values for font size
# This assigns rainbow color values to your word cloud values
wordcloud(trump_clean, max.words = 100, random.order = F, col= rainbow(20), scale = c(6, .5))