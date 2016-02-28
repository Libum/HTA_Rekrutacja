prepare_to_print = function(medline){
        library(rmarkdown)
        med_list = attributes(medline)
        n = length(ArticleId(medline))
        dir.create(path = "./Abstrakty_do_druku")
        for (i in 1:n){
                text = med_list$AbstractText[i]
                authors = med_list$Author[i]
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
                save(list = c("text", "authors", "journal", "year", "month", "day", "PMID", "ISSN", "affiliation",
                              "volume", "issue", "status", "title", "id"), file = "data.RData")
                file_name = paste0("./Abstrakty_do_druku/Abstract_", i, ".pdf")
                render(input = "Druk_template.Rmd", output_file = file_name, output_format = "pdf_document")
        }
        file.remove("./data.RData")
}