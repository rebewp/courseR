#Assignment 4
#provided code
library(tidyverse)
library(lubridate)
library(COVID19)
library(RcppRoll)

south_africa <- 710
uk <- 826
european <- c(56, 276, 372, 380, 442, 528, 620, 724, 756)
african <- c(72, 748, 426, 516, 508, 716)

europe_data <- covid19(european) %>% 
  filter(date >= ymd("2020-08-26")) %>% 
  group_by(id) %>% 
  group_split() %>% 
  map_dfr(~.x %>% 
            mutate(new_cases = confirmed - lag(confirmed),
                   cases_population_1000000 = (new_cases/population)*1000000,
                   rolling_avg = roll_mean(cases_population_1000000, n = 7, fill = NA_real_)) %>% 
            select(id, date, confirmed, new_cases, cases_population_1000000, rolling_avg)) %>% 
  filter(between(date, ymd("2020-09-01"), ymd("2021-01-01"))) %>% 
  group_by(date) %>% 
  summarize(average_cases = mean(rolling_avg)) %>% 
  mutate(type = "neighboring Europe") %>% 
  select(type, date, average_cases)

africa_data <- covid19(african) %>% 
  filter(date >= ymd("2020-08-26")) %>% 
  group_by(id) %>% 
  group_split() %>% 
  map_dfr(~.x %>% 
            mutate(new_cases = confirmed - lag(confirmed),
                   cases_population_1000000 = (new_cases/population)*1000000,
                   rolling_avg = roll_mean(cases_population_1000000, n = 7, fill = NA_real_)) %>% 
            select(id, date, confirmed, new_cases, cases_population_1000000, rolling_avg)) %>% 
  filter(between(date, ymd("2020-09-01"), ymd("2021-01-01"))) %>% 
  group_by(date) %>% 
  summarize(average_cases = mean(rolling_avg)) %>% 
  mutate(type = "neighboring Africa") %>% 
  select(type, date, average_cases)

sa_data <- covid19(south_africa) %>% 
  mutate(new_cases = confirmed - lag(confirmed),
         cases_population_1000000 = (new_cases/population)*1000000,
         average_cases = roll_mean(cases_population_1000000, n = 7, fill = NA_real_)) %>% 
  filter(between(date, ymd("2020-09-01"), ymd("2021-01-01"))) %>% 
  mutate(type = "South Africa") %>% 
  select(type, date, average_cases)

uk_data <- covid19(uk) %>% 
  mutate(new_cases = confirmed - lag(confirmed),
         cases_population_1000000 = (new_cases/population)*1000000,
         average_cases = roll_mean(cases_population_1000000, n = 7, fill = NA_real_)) %>% 
  filter(between(date, ymd("2020-09-01"), ymd("2021-01-01"))) %>% 
  mutate(type = "United Kingdom") %>% 
  select(type, date, average_cases)
#provided code ending
