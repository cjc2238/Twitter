### Learning Analytics Twitter Text Code Mining


# Load required libraries
require(wordcloud)
require(tm)
require(RCurl)
require(twitteR)
require(ROAuth)

## Put keys in quotes
setup_twitter_oauth("GNPEgOwQ1wzj324bMCqBrHBgQ", "6IDQUQVLYPE0VCmsBrwQ1rGunEdexj7drvujpyhLidOzc3R7Nd", access_token= "775774019178168322-YKwYEHI8Y43W265WgmNJuayvTV7QNnZ", access_secret= "gUcDbFhitpPkTWuJAAS2MRTLmKrTZxdp6QLJ9kzNxEGb5")

# Pull Twitter Values
LATwitter <- searchTwitteR('Learning Analytics', n=500, resultType ="weekly")
# Check Class to confirm list
class(LATwitter)

# Extract text
LAtext <- sapply(LATwitter, function(x) x$getText())
# Check class structure
str(LAtext)

# Create Text Corpus Value
LACorpus <- Corpus(VectorSource(LAtext))

# Create and Clean Corpus
LA_clean <- tm_map(LACorpus, removePunctuation)
LA_clean <- tm_map(LA_clean, content_transformer(tolower))
LA_clean <- tm_map(LA_clean, removeWords, stopwords("english"))
LA_clean <- tm_map(LA_clean, removeNumbers)
LA_clean <- tm_map(LA_clean, stripWhitespace)
LA_clean <- tm_map(LA_clean, removeWords, c("president","trump","election","Trump","Donald","campaign","https"))

# Create Word cloud
