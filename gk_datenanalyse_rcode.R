#Aufgabenblatt 
##Signifikanztest und Mittelwertvergleich

library(tidyverse)
library(haven)
library(gmodels)

ess_2018 <- read_sav("datasets/ESS9e03.sav")

##Aufgabe 1
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


##Aufgabe2
#T-Test linke und fdp wähler unterschied afd

#vergleich linke und afd
ess_2018_linke_afd <- ess_2018 %>% 
  filter(prtvede2 == 6 | prtvede2 == 3) %>% 
  select(-(!gincdif & !prtvede2))

t.test(ess_2018_linke_afd$gincdif ~ ess_2018_linke_afd$prtvede2, var.equal = FALSE)

#vergleich fdp und afd
ess_2018_fdp_afd <- ess_2018 %>% 
  filter(prtvede2 == 6 | prtvede2 == 5) %>% 
  select(-(!gincdif & !prtvede2))

t.test(ess_2018_fdp_afd$gincdif ~ ess_2018_fdp_afd$prtvede2, var.equl = FALSE)


##Aufgabe3
#vergleich zufriedenheit wähler*innen regierungsparteien - nichtregierungsparteien
#de, at, pl
#stfdem

#Deutschland und Österreich 
#prtvtcat at wahlen -> övp & grüne
#prtvede2 de wahlen -> cdu/csu & spd
ess_2018_de_at <- ess_2018 %>% 
  select(cntry, prtvtcat, prtvede2) %>% 
  filter(cntry == "AT" | cntry == "DE") %>% 
  mutate(regparty_gewaehlt = case_when(
    prtvtcat == 2  ~ "Yes",
    prtvtcat == 5 ~ "Yes",
    prtvede2 == 1 ~ "Yes",
    prtvede2 == 2 ~ "Yes",
    TRUE ~ "No")
    )





ess_2018_de_at$cntry

#Deutschland und Polen
ess_2018_de_pl <- ess_2018 %>% 
  filter(cntry == "PL" | cntry == "DE")


