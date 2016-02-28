library(tm)
library(proxy)

#Funckja tworząca reprezentację tf-idf abstraktów
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

#Funkcja obliczająca odległości cosinusowe między abstraktami
compute_cosine_dist = function(dtm){
        dtm = as.matrix(dtm)
        distance = dist(x = dtm, method = "cosine")
        distance = as.matrix(distance)
}