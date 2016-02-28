#Wczytywanie danych

library(RISmed)
query_clinical = "(plaque psoriasis) AND ((“randomized controlled trial”) OR (random*) OR (RCT) OR (((singl* OR doubl* OR trebl* OR tripl*) AND (blind* OR mask*)) OR (single blind) OR (double blind) OR (triple blind) OR (placebo) OR (placebo-controlled) OR (blinding) OR (controlled clinical trial) OR (random* AND controlled AND study*) OR (random* AND controlled AND trial*) OR ((random OR randomly) AND (allocation OR allocate*))))"
query_eco_qol = "(plaque psoriasis) AND (utilities OR utility or SF-36 or SF36 OR “SF 36” OR SF-6D OR EuroQol OR EQ5D or EQ-5D OR “EQ 5D” OR QoL OR QALY OR QUALY OR QLY OR Quality-of-Life OR preferences OR TTO OR “time trade off” OR SG OR “standard gamble”)"
query_eco_cost = "(plaque psoriasis) AND (economic OR economical OR economics OR economic OR cost-benefit OR “cost benefit” OR cost-consequences OR “cost consequences” OR cost-minimisation OR “cost minimisation” OR cost-minimization OR “cost minimization” OR cost-effectiveness OR “cost effectiveness” OR cost-utility OR “cost utility” OR CEA OR CUA OR CMA OR “decision tree” OR “Markov model” OR “DES” OR “discrete event simulation” OR “economic review”)"
query_budget = "(plaque psoriasis) AND (epidemiol* OR epidemiology OR epidemiologic OR epidemiological OR cross-section OR cross-sectional OR “cross sectional” OR register OR longitudinal OR population-based OR prospective OR retrospective OR cohort OR registry OR registries OR observational OR longitudinal OR database)"
res_clinical = EUtilsSummary(query_clinical, type="esearch", db="pubmed")
res_eco_qol = EUtilsSummary(query_eco_qol, type="esearch", db="pubmed")
res_eco_cost = EUtilsSummary(query_eco_cost, type="esearch", db="pubmed")
res_budget = EUtilsSummary(query_budget, type="esearch", db="pubmed")
clinical = EUtilsGet(res_clinical)
eco_qol = EUtilsGet(res_eco_qol)
eco_cost = EUtilsGet(res_eco_cost)
budget = EUtilsGet(res_budget)
rm(list = grep("(query)|(res)", x = ls(), value = T))

#Stworzenie mniejszego zbioru tekstów, który będzie służył jako przykład, ilustrujący działanie funkcji

medline = EUtilsSummary(query_clinical, type="esearch", db="pubmed", retmax = 20)
medline = EUtilsGet(medline)