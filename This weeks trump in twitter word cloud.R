# Trumps Week Twitter Text Code Mining
## Create a Word Cloud using Twitter
require(wordcloud)
require(tm)
require(RCurl)
require(twitteR)
require(ROAuth)

Setup_twitter_oauth("GNPEgOwQ1wzj324bMCqBrHBgQ", "6IDQUQVLYPE0VCmsBrwQ1rGunEdexj7drvujpyhLidOzc3R7Nd", access_token= "775774019178168322-YKwYEHI8Y43W265WgmNJuayvTV7QNnZ", access_secret= "gUcDbFhitpPkTWuJAAS2MRTLmKrTZxdp6QLJ9kzNxEGb5")
TrumpsWeek <- searchTwitteR('trump', n=500, resultType ="weekly")

# Check Class to confirm list
class(TrumpsWeek)

# Extract Text 
TrumpsWeek_Text <- sapply(TrumpsWeek, function(x) x$getText())

# Check structure of TrumpSupporters_Text Value
str(TrumpsWeek_Text)

# Us TM pachage to convert collection of texts to a text corpus.
trumpweek_corpus <- Corpus(VectorSource(TrumpsWeek_Text))

# Start Cleaning data
# Create new clean value
# Remove puncuation
trumpweek_clean <- tm_map(trumpweek_corpus, removePunctuation)

# Convert all characters to lower case
trumpweek_clean <- tm_map(trumpweek_clean, content_transformer(tolower))
# Remove all stop words ("and" "the" "etc").
trumpweek_clean <- tm_map(trumpweek_clean, removeWords, stopwords("english"))
# Remove numbers
trumpweek_clean <- tm_map(trumpweek_clean, removeNumbers)
# Remove all the white space
trumpweek_clean <- tm_map(trumpweek_clean, stripWhitespace)
# Remove obvious words: 'president+trump+election'
trumpweek_clean <- tm_map(trumpweek_clean, removeWords, c("president","trump","election","Trump","Donald","campaign","https"))

# Now we make the word cloud
wordcloud(trumpweek_clean, max.words = 100)
