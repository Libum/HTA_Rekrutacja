#Funkcja wykorzystująca wszystkie stworzone wcześniej w celu utworzenia wersji abstraktów do druku, zawierającej
#wszystkie podstawowe informacje o abstrakcie, numer ID abstraktu, liczbę jego cytowań oraz tabelę rankingową podobnych do niego
#tekstów (domyślnie 5)

prepare_to_print = function(medline, ranking = TRUE, similar = TRUE, nsim = 5){
        library(rmarkdown)
        med_list = attributes(medline)
        n = length(ArticleId(medline))
        dir.create(path = "./Abstrakty_do_druku")
        if (ranking == TRUE) {
                citations_ranking = create_ranking(medline)
        }
        if (similar == TRUE){
                tfidf = compute_tfidf(medline)
                dist_matrix = compute_cosine_dist(tfidf)
        }
        for (i in 1:n){
                text = med_list$AbstractText[i]
                authors = med_list$Author[[i]]
                journal = med_list$Title[i]
                year = med_list$YearPubmed[i]
                month = med_list$MonthPubmed[i]
                day = med_list$DayPubmed[i]
                PMID = med_list$PMID[i]
                ISSN = med_list$ISSN[i]
                affiliation = med_list$Affiliation[i]
                volume = med_list$Volume[i]
                issue = med_list$Issue[i]
                status = med_list$PublicationStatus[i]
                title = med_list$ArticleTitle[i]
                id = i
                if (ranking == TRUE){
                        citations = citations_ranking[citations_ranking$Title == title, 2]
                }
                if (similar == TRUE){
                       distances = sort(dist_matrix[i,])
                       sim_id = as.numeric(names(distances)[2:length(distances)])
                       sim_id = sim_id[1:nsim]
                       sim_titles = med_list$ArticleTitle[sim_id]
                }
                list = c("text", "authors", "journal", "year", "month", "day", "PMID", "ISSN", "affiliation",
                         "volume", "issue", "status", "title", "id")
                list = ifelse(ranking == TRUE, c(list, "citations"), list)
                list = ifelse(similar == TRUE, c(list, "sim_id", "sim_titles"), list)
                save(list = list, file = "data.RData")
                file_name = paste0("./Abstrakty_do_druku/Abstract_", i, ".pdf")
                render(input = "Druk_template.Rmd", output_file = file_name, output_format = "pdf_document")
        }
        file.remove("./data.RData")
}