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
ess_2018_afd <- ess_2018 %>% 
  filter(prtvede2 == 6) %>% 
  select(-(!gincdif & !prtvede2))

afd_konfidenzintervall_90 <- ci(as.double(ess_2018_afd$gincdif), 0.90)
afd_konfidenzintervall_99 <- ci(as.double(ess_2018_afd$gincdif), 0.99)

#fdp
ess_2018_fdp <- ess_2018 %>% 
  filter(prtvede2 == 5) %>% 
  select(-(!gincdif & !prtvede2))

fdp_konfidenzintervall_90 <- ci(as.double(ess_2018_fdp$gincdif), 0.90)
fdp_konfidenzintervall_90 <- ci(as.double(ess_2018_fdp$gincdif), 0.99)


#linke
ess_2018_linke <- ess_2018 %>% 
  filter(prtvede2 == 3) %>% 
  select(-(!gincdif & !prtvede2))

linke_konfidenzintervall_90 <- ci(as.double(ess_2018_linke$gincdif), 0.90)
linke_konfidenzintervall_99 <- ci(as.double(ess_2018_linke$gincdif), 0.99)



data <- iris
ci(data$Sepal.Length, 0.90)

glimpse(data)
glimpse(ess_2018_afd_agree)
