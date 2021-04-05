#having a look at the covid data
install.packages("COVID19")
library(tidyverse)
library(COVID19)
library(rvest)

?covid19

#getting data
city <- covid19(c("Germany"), level = 3)
x <- covid19()
us_covid_base_lvl_3 <- covid19(c("US"), level = 3)
us_covid_base_lvl_2 <- covid19(c("US"), level = 2)

#saving locally
save(us_covid_base_lvl_2, file = "us_covid_base_lvl_2.Rdata")
save(us_covid_base_lvl_3, file = "us_covid_base_lvl_3.Rdata")
saveRDS(us_covid_base_lvl_3, file = "us_covid_base_lvl_3.Rds")
saveRDS(us_covid_base_lvl_2, file = "us_covid_base_lvl_2.Rds")

#trying/loading of local file
#load == .Rdata
load("us_covid_base_lvl_2.Rdata")
load("us_covid_base_lvl_3.Rdata")

# xyz <- readRDS == .Rds
try <- readRDS("us_covid_base_lvl_3.Rds")



