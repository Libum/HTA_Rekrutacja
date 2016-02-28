library(tm)
library(proxy)

compute_tfidf = function(medline){
        medline = attributes(medline)
        corpus = Corpus(VectorSource(medline$AbstractText))
        corpus = tm_map(corpus, removeWords, stopwords("english"))
        corpus = tm_map(corpus, removePunctuation)
        corpus = tm_map(corpus, stripWhitespace)
        corpus = tm_map(corpus, stemDocument, language="english")
        terms = DocumentTermMatrix(corpus,control = list(weighting = function(x) weightTfIdf(x, normalize = FALSE)))
        terms
}

compute_cosine_dist = function(dtm){
        dtm = as.matrix(dtm)
        distance = dist(x = dtm, method = "cosine")
        distance = as.matrix(distance)
}


#read 1000 txt articles from directory data/txt
corpus  <-Corpus(DirSource("data/txt"), readerControl = list(blank.lines.skip=TRUE));
#some preprocessing
corpus <- tm_map(corpus, removeWords, stopwords("english"))
corpus <- tm_map(corpus, stripWhitespace)
corpus <- tm_map(corpus, stemDocument, language="english")
#creating term matrix with TF-IDF weighting
terms <-DocumentTermMatrix(corpus,control = list(weighting = function(x) weightTfIdf(x, normalize = FALSE)))

#or compute cosine distance among documents
dissimilarity(tdm, method = "cosine")