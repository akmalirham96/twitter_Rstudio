#Read file

highway <- read.csv(file.choose(),header = T)
str(highway)

#Build Corpus

library(tm)
library(stopwords)
corpus <- iconv(highway$text,to = 'UTF-8', sub = "byte")
corpus <- Corpus(VectorSource(corpus))

#Cleaning text
corpus <- tm_map(corpus, tolower)
inspect(corpus)

#Remove comar
corpus <- tm_map(corpus, removePunctuation)
inspect(corpus)

#remove number
corpus <- tm_map(corpus, removeNumbers)
inspect(corpus)

#stopword
cleanset <- tm_map(corpus,removeWords,stopwords("ms", source = "stopwords-iso"))
inspect(cleanset)

#Remove url
removeURL <- function(x) gsub('http[[:alnum:]]*','',x)
cleanset <- tm_map(cleanset, content_transformer(removeURL))
inspect(corpus)

#remove word
cleanset <- tm_map(cleanset, removeWords, c('am','pm','amp'))


#remove whitespace
cleanset <- tm_map(cleanset,stripWhitespace)
inspect(cleanset)

#add into matrix
tdm <- TermDocumentMatrix(cleanset)
tdm
tdm <- as.matrix(tdm)
tdm[1:10,1:20]

#bar plot
w <- rowSums(tdm)
w <- subset(w,w>=25)
barplot(w,
        las = 2,
        col = rainbow(50))

#wordcloud
library(wordcloud)
w <- sort(rowSums(tdm),decreasing = TRUE)
set.seed(222)
wordcloud(words = names(w),
          freq = w,
          max.word = 150,
          random.order = F,
          min.freq = 5,
          colors = brewer.pal(8,'Dark2'),
          scale = c(5,0.3),
          rot.per = 0.3)

#wordcloud2
library(wordcloud2)
w <- data.frame(names(w),w)
colnames(w) <- c('word','freq')
wordcloud2(w,
           size = 0.5,
           shape = 'circle',
           rotateRatio = 0.5,
           minSize = 1)

letterCloud(w,
            word = "A",
            size = 2)

#Sentiment Analysis
library(syuzhet)
library(lubridate)
library(ggplot2)
library(scales)
library(reshape2)
library(dplyr)

highway <- read.csv(file.choose(),header = T)
tweet <- iconv(highway$text,to = 'UTF-8', sub = "byte")

#Obtain Sentiment score
s <- get_nrc_sentiment(tweet)
head(s)

#barplot
barplot(colSums(s),
        las = 2,
        col = rainbow(10),
        ylab = 'Count',
        main = 'Sentiment on tweets')

