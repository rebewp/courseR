#having a look at the covid data
install.packages("COVID19")
library(tidyverse)
library(COVID19)
library(rvest)

?covid19

#getting data
city <- covid19(c("Germany"), level = 3)
x <- covid19()
us_covid_base_lvl_3 <- covid19(c("US"), end = "2021-02-01", level = 3)
us_covid_base_lvl_2 <- covid19(c("US"), end = "2021-02-01", level = 2)

#saving locally
save(us_covid_base_lvl_2, file = "us_covid_base_lvl_2.Rdata")
save(us_covid_base_lvl_3, file = "us_covid_base_lvl_3.Rdata")
saveRDS(us_covid_base_lvl_3, file = "us_covid_base_lvl_3.Rds")
saveRDS(us_covid_base_lvl_2, file = "us_covid_base_lvl_2.Rds")

saveRDS(wiki_governors_base, file = "wiki_governors.Rds")

#trying/loading of local file
#load == .Rdata
load("us_covid_base_lvl_2.Rdata")
load("us_covid_base_lvl_3.Rdata")

# xyz <- readRDS == .Rds
us_covid_base_lvl_3 <- readRDS("us_covid_base_lvl_3.Rds")
us_covid_base_lvl_2 <- readRDS("us_covid_base_lvl_2.Rds")

# state governors party

wiki_governors_base <- read_html("https://en.wikipedia.org/wiki/List_of_current_United_States_governors") %>% 
  html_table(fill = TRUE) %>% 
  .[[1]] 

wiki_governors <- wiki_governors_base

names(wiki_governors) <- c("State", "Portrait", "Governor", "Party_un", "Party", "Born", "na", "prior public experience", "na", "na", "na")
wiki_governors <- wiki_governors[-c(1), ] %>% 
  select(State, Party)

wiki_governors[23, 2] = "Democratic"
wiki_governors[48, 2] = "Republican"

######## tidying 




