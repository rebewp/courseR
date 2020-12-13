#Aufgabenblatt 
##Signifikanztest und Mittelwertvergleich

library(tidyverse)
library(haven)
library(gmodels)

ess_2018 <- read_sav("datasets/ESS9e03.sav")

#Aufgabe 1
#Konfidenzintervall "government should reduce difference in income levels" == gincdif
#agree strongly - disagree strogly, afd, fdp, linke
#90% & 99% kfi
#prtvede1 prtvede2

ess_2018$gincdif
ess_2018$prtvede2

#afd
ess_2018_afd_agree <- ess_2018 %>% 
  filter(gincdif == 1, prtvede2 == 6) %>% 
  select(-(!gincdif & !prtvede2))

ess_2018_afd_disagree <- ess_2018 %>% 
  filter(gincdif == 5, prtvede2 == 6) %>% 
  select(-(!gincdif & !prtvede2))

#linke
ess_2018_linke_agree <- ess_2018 %>% 
  filter(gincdif == 1, prtvede2 == 3) %>% 
  select(-(!gincdif & !prtvede2))

ess_2018_linke_disagree <- ess_2018 %>% 
  filter(gincdif == 5, prtvede2 == 3) %>% 
  select(-(!gincdif & !prtvede2))

#fdp
ess_2018_fdp_agree <- ess_2018 %>% 
  filter(gincdif == 1, prtvede2 == 5) %>% 
  select(-(!gincdif & !prtvede2))

ess_2018_fdp_disagree <- ess_2018 %>% 
  filter(gincdif == 5, prtvede2 == 5) %>% 
  select(-(!gincdif & !prtvede2))

#linke
ess_2018_linke <- ess_2018 %>% 
  filter(prtvede2 == 3) %>% 
  select(-(!gincdif & !prtvede2))

linke_konfidenzintervall <- ci(as.double(ess_2018_linke$gincdif), 0.90)
linke_konfidenzintervall

ci(as.double(ess_2018_afd_agree$gincdif), 0.90)
ci(as.double(ess_2018_afd_agree$gincdif), 0.99)


data <- iris
ci(data$Sepal.Length, 0.90)

glimpse(data)
glimpse(ess_2018_afd_agree)
