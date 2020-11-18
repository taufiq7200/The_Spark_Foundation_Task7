                             ##### THE SPARK FOUNDATION ######
                                ##### GRIPNOV20 #######
                                   ##### TASK 7 #######
                             ##### SENTIMENT ANALYSIS ######
                              ######## TEXT ANALYSIS ########


Text_data = read.csv(file.choose() , header = T)
head(Text_data)
tail(Text_data)

summary(Text_data)
str(Text_data)

install.packages('tm')
library(tm)

## Build Corpus
corpus=iconv(Text_data$headline_text)
corpus=Corpus(VectorSource(corpus))
inspect(corpus[1:5])


### Cleaning the text

corpus = tm_map(corpus , tolower)
inspect(corpus[1:5])

corpus=tm_map(corpus , removeNumbers)
corpus=tm_map(corpus , removePunctuation)
inspect(corpus[1:10])

stopwords('english')
clean_set=tm_map(corpus , removeWords , stopwords('english'))
inspect(corpus[1:15])


## term doc marix
doc_matrix = TermDocumentMatrix(clean_set)
doc_matrix

doc_matrix = as.matrix(doc_matrix)
doc_matrix[1:10 , 1:20]
w=rowSums(doc_matrix)
w
w=subset(w,w>5)
barplot(w,las=2 , col=rainbow(50))


## wordcloud
install.packages('wordcloud')
library(wordcloud)
w=sort(rowSums(doc_matrix) , decreasing = T)
set.seed(0)
wordcloud(words = names(w),
          freq = w,
          max.words = 300,
          random.color = F,
          min.freq = 5)

