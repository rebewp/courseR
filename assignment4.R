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
#ending provided code 

#testing#

africa_with_south_africa <- rbind(sa_data, africa_data)

complete_africa_plot <- ggplot(africa_with_south_africa,
                      aes(x = date,
                          y = average_cases,
                          color = type)) +
  geom_line() +
  labs(title = "African and South African covid19 cases between Sept.20 - Jan.21",
       y = "7-day averages of new cases per 1 million inhabitants",
       x = "Dates") +
  theme_bw()
complete_africa_plot
##plotting
africa_plot <- ggplot(africa_data,
                      aes(x = date,
                          y = average_cases)) +
  geom_line() +
  labs(title = "African covid19 cases between Sept.20 - Jan.21",
       y = "7-day averages of new cases per 1 million inhabitants",
       x = "Dates") +
  theme_bw()
africa_plot

##south africa
south_africa_plot <- ggplot(sa_data,
                      aes(x = date,
                          y = average_cases)) +
  geom_line() +
  labs(title = "South African covid19 cases Sept.20 - Jan.21",
       y = "7-day averages of new cases per 1 million inhabitants",
       x = "Dates") +
  theme_bw()
south_africa_plot

#europe
europe_with_uk <- rbind(uk_data, europe_data)

complete_europe_plot <- ggplot(europe_with_uk,
                               aes(x = date,
                                   y = average_cases,
                                   color = type)) +
  geom_line() +
  labs(title = "Europe and UK covid19 cases between Sept.20 - Jan.21",
       y = "7-day averages of new cases per 1 million inhabitants",
       x = "Dates") +
  theme_bw()
complete_europe_plot

europe_plot <- ggplot(europe_data,
                      aes(x = date,
                          y = average_cases)) +
  geom_line() +
  labs(title = "European covid19 between cases Sept.20 - Jan.21",
       y = "7-day averages of new cases per 1 million inhabitants",
       x = "Dates") +
  theme_bw()
europe_plot

#uk
uk_plot <- ggplot(uk_data,
                      aes(x = date,
                          y = average_cases)) +
  geom_line() +
  labs(title = "UK covid19 cases Sept.20 - Jan.21",
       y = "7-day averages of new cases per 1 million inhabitants",
       x = "Dates") +
  theme_bw()
uk_plot


