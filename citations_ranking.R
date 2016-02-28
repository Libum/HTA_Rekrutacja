library(XML)
library(httr)
library(RISmed)

#Funkcja wydobywająca informacje o nazwisku pierwszego autora danego tekstu
extract_authors = function(medline){
        n = length(ArticleId(medline))
        list_authors = Author(medline)
        authors = character(length = n)
        for (i in 1:n){
                authors[i] = list_authors[[i]][1,1]
        }
        authors
}

#Funkcja sprawdzająca ilość cytowań danego tekstu w Google Scholar
check_citations = function(url){
        Sys.sleep(time = sample(x = seq(4,15,0.1), size = 1))
        page = httr::GET(url = url, cookies = FALSE)
        warn_for_status(page)
        page = httr::content(x = page, as = "text")
        start = regexpr(pattern = "Cytowane przez ", text = page)[1]
        if (start != -1){
                page = substr(x = page, start = start, stop = nchar(page))
                stop = regexpr(pattern = "<", text = page)[1]
                citations = substr(page, start = nchar("Cytowane przez ")+1, stop = stop-1)
                as.numeric(citations)
        } else {
                ifelse(grepl(pattern = "— nie spełniają żadne artykuły.", x = page), NA, 0)
        }
}

#Fukcja tworząca adresy URL, będące zapytaniami do GS o poszczególne teksty. Przy wyszukiwaniu stosowany jest
#tytuł artykułu oraz nazwisko jego pierwszego autora
create_urls = function(Medline){
        titles = ArticleTitle(Medline)
        authors = extract_authors(Medline)
        n = length(ArticleId(Medline))
        urls = character(length = n)
        for (i in 1:n){
                url_title = gsub(pattern = " ", replacement = "+", x = titles[i])
                url_title = paste0("\"", url_title, "\"")
                url_author = paste0("+autor%3A", authors[i], "&btnG=&hl=pl&as_sdt=0%2C5")
                url = paste0("https://scholar.google.pl/scholar?q=", url_title, url_author)
                urls[i] = url
        }
        urls
}

#Funkcja finalna, tworzaca ranking tekstów w oparciu o ilość cytowań
create_ranking = function(Medline){
        urls = create_urls(Medline = Medline)
        titles = ArticleTitle(Medline)
        citations = sapply(X = urls, FUN = check_citations)
        final = data.frame(Title = titles, Num_of_citations = citations, row.names = NULL)
        final[order(final$Num_of_citations, decreasing = TRUE),]
}