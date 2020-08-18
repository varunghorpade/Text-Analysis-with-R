#Read File
data = read.csv(file.choose(), header = T)
str(data)

#Build Corpus -- Corpus is a collection of documents. So in this case each tweet will be treated as
                 ## a documnet.

library(tm)
corpus = iconv(data$text, to = "utf-8-mac") #iconv uses system facilities to convert a character vector between encodings: the ‘i’ stands for ‘internationalization’.
corpus = Corpus(VectorSource(corpus))
inspect(corpus[1:5])

#Data Cleaning
corpus = tm_map(corpus, tolower) ## to make everything in lower case.
inspect(corpus[1:5])

corpus = tm_map(corpus, removePunctuation) ## to remove punctuations.
inspect(corpus[1:5])


corpus = tm_map(corpus, removeNumbers) ## to remove the numbers
inspect(corpus[1:5])

cleanset <- tm_map(corpus, removeWords, stopwords("english")) ## to remove common words with no meaning.
inspect(cleanset[1:5])

removeURL <- function(x) gsub('https[[:alnum:]]*','',x)
cleanset <- tm_map(cleanset, content_transformer(removeURL))
inspect(cleanset[1:5])

cleanset <- tm_map(cleanset, removeWords, c("aapl", "apple"))
cleanset <- tm_map(cleanset, gsub,
                   pattern = 'stocks',
                   replacement = 'stock')

cleanset <- tm_map(cleanset, stripWhitespace)
inspect(cleanset[1:5])

#Term Documnet matrix
tdm <- TermDocumentMatrix(cleanset)
tdm
tdm <- as.matrix(tdm)
tdm[1:10, 1:20]
w <- rowSums(tdm)
w <- subset(w, w>=25)
w
barplot(w, 
        las = 2,
        col = rainbow(50))


#Word Cloud
library(wordcloud)
install.packages('wordcloud')

w <- sort(rowSums(tdm), decreasing = TRUE)
set.seed(24579)
wordcloud(words = names(w),
          freq = w,
          max.words = 150,
          random.order = F,
          min.freq = 5,
          colors = brewer.pal(8, 'Dark2'),
          scale = c(5, 0.3),
          rot.per = 0.7)
