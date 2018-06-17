##########################################
# ANALYSING A TEXT CORPUS
##########################################

# Load libraries
library(tidytext)
library(tidyverse)
library(tm)
library(wordcloud)

# Read in corpus
docs <- Corpus(DirSource('dir'))

# Remove punctuation
docs <- tm_map(docs, removePunctuation)

# Transform to lower case
docs <- tm_map(docs, content_transformer(tolower))

# Remove whitespace
docs <- tm_map(docs, stripWhitespace)

# Remove digits
docs <- tm_map(docs, removeNumbers)

# Stem words
docs <- tm_map(docs, stemDocument)

# Remove stopwords: tm package plus custom
docs <- tm_map(docs, removeWords, stopwords('english'))
myStopwords <- c('word1', etc)
docs <- tm_map(docs, removeWords, myStopwords)

# Create document-term matrix
dtm <- DocumentTermMatrix(docs)

# Convert to tidy tibble
tidydocs <- tidy(dtm)
colnames(tidydocs) <- c('document', 'word', 'count')

# Remove stopwords: tidytext package
tidydocs <- anti_join(tidydocs,
                      stop_words)

# Find frequently occuring terms
freq <- aggregate(count ~ word, data = tidydocs, sum)
freq <- freq[order(freq$count, decreasing = TRUE), ]
head(freq, n = 20)

# Plot frequently occuring terms
ggplot(filter(freq, count > 30),
       aes(x = reorder(word, count), y = count)) +
  geom_col() +
  xlab(NULL) +
  coord_flip()

# Wordcloud of frequently occuring terms
wordcloud(freq$word,
          freq$count,
          min.freq = 30,
          colors = brewer.pal(6, 'Dark2'))

# TF-IDF
words <- left_join(tidydocs, freq, by = 'word')
colnames(words) <- c('document', 'word', 'n', 'total')
words <- bind_tf_idf(words, word, document, n)
words <- words[order(words$tf_idf, decreasing = TRUE), ]
head(words, n = 20)
options(tibble.print_max = Inf)
top <- head(words, n = 120)
top[order(top$document), ]

# Sentiments
sentiments <- inner_join(freq, get_sentiments('nrc'))
head(filter(sentiments, sentiment == 'positive' | sentiment == 'negative'), n = 5)
ggplot(subset(sentiments, 
              sentiments$sentiment != 'positive' & sentiments$sentiment != 'negative'),
       aes(x = sentiment, y = count)) +
  geom_col() +
  xlab('Sentiment') +
  ylab('Count')
docsentiments <- inner_join(tidydocs, get_sentiments('afinn'))
docsentiments <- aggregate(score ~ document, data = docsentiments, sum)
docsentiments <- docsentiments[order(docsentiments$score), ]
ggplot(docsentiments,
       aes(x = document, y = score)) +
  geom_col() +
  scale_x_discrete(labels = c(1:40)) +
  xlab('Document') +
  ylab('Score')