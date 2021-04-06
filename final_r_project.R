#having a look at the covid data
install.packages("COVID19")
library(tidyverse)
library(COVID19)
library(rvest)
library(ggplot2)
library(lubridate)

?covid19

sum(1:2)

#getting data
city <- covid19(c("Germany"), level = 3)
x <- covid19(raw = FALSE)
us_covid_base_lvl_3 <- covid19(c("US"), end = "2020-12-31", level = 3)
us_covid_base_lvl_2 <- covid19(c("US"), end = "2020-12-31", level = 2)

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

tidy_us_covid_base_lvl_2 <- us_covid_base_lvl_2 %>% 
  select(date, administrative_area_level_2, confirmed,deaths, 
         school_closing, workplace_closing, cancel_events, gatherings_restrictions, transport_closing,
         stay_home_restrictions, internal_movement_restrictions, international_movement_restrictions,
         information_campaigns, contact_tracing) %>% 
  rename(State = administrative_area_level_2) %>% 
  inner_join(wiki_governors, by = "State")

us_covid_cases_party <- tidy_us_covid_base_lvl_2 %>% 
  select(date, State, confirmed, Party) %>% 
  mutate(month = month(date), 
         year = year(date),
         day = day(date)) %>% 
  group_by(month, year, Party)

##test
#arizona - washington
population_washington <- washington_cases[1,3]
population_arizona <- arizona_cases[1,3]

tidy_us_covid_base_lvl_2_test <- tidy_us_covid_base_lvl_2
tidy_us_covid_base_lvl_2_test <- us_covid_base_lvl_2 %>% 
  select(date,population, administrative_area_level_2, confirmed,deaths, 
         school_closing, workplace_closing, cancel_events, gatherings_restrictions, transport_closing,
         stay_home_restrictions, internal_movement_restrictions, international_movement_restrictions,
         information_campaigns, contact_tracing) %>% 
  rename(State = administrative_area_level_2) %>% 
  inner_join(wiki_governors, by = "State")

arizona_cases <- tidy_us_covid_base_lvl_2 %>% filter(State == "Arizona") %>% 
  select(date, State, confirmed, Party) %>% 
  mutate(year = year(date),
         month = month(date),
         day = day(date)) %>% 
  group_by(month, year, Party) %>% 
  select(-date)

arizona_cases



washington_cases <- tidy_us_covid_base_lvl_2_test %>% filter(State == "Washington") %>% 
  select(date, State, confirmed, Party) %>% 
  mutate(year = year(date),
         month = month(date),
         day = day(date)) %>% 
  group_by(month, year, Party) %>% 
  select(-date)
washington_cases

##test

jan_data <- filter(us_covid_cases_party, month == 1,day == 31) %>% 
  summarise(cases = sum(confirmed, na.rm= TRUE))
feb_data <- filter(us_covid_cases_party, month == 2,day == 28) %>% 
  summarise(cases = sum(confirmed, na.rm= TRUE))
march_data <- filter(us_covid_cases_party, month == 3,day == 31) %>% 
  summarise(cases = sum(confirmed, na.rm= TRUE))
april_data <- filter(us_covid_cases_party, month == 4,day == 30) %>% 
  summarise(cases = sum(confirmed, na.rm= TRUE))
may_data <- filter(us_covid_cases_party, month == 5,day == 31) %>% 
  summarise(cases = sum(confirmed, na.rm= TRUE))
june_data <- filter(us_covid_cases_party, month == 6,day == 30) %>% 
  summarise(cases = sum(confirmed, na.rm= TRUE))
july_data <- filter(us_covid_cases_party, month == 7,day == 31) %>% 
  summarise(cases = sum(confirmed, na.rm= TRUE))
august_data <- filter(us_covid_cases_party, month == 8,day == 31) %>% 
  summarise(cases = sum(confirmed, na.rm= TRUE))
september_data <- filter(us_covid_cases_party, month == 9,day == 30) %>% 
  summarise(cases = sum(confirmed, na.rm= TRUE))
october_data <- filter(us_covid_cases_party, month == 10,day == 31) %>% 
  summarise(cases = sum(confirmed, na.rm= TRUE))
november_data <- filter(us_covid_cases_party, month == 11,day == 30) %>% 
  summarise(cases = sum(confirmed, na.rm= TRUE))
december_data <- filter(us_covid_cases_party, month == 12,day == 31) %>% 
  summarise(cases = sum(confirmed, na.rm= TRUE))

complete_data <- rbind(jan_data, feb_data, march_data, april_data, may_data, 
                       june_data, july_data, august_data, september_data, 
                       october_data, november_data, december_data)

complete_data_save <- complete_data
complete_data <- complete_data_save





####### visualization

covid_cases_per_state_plot <- ggplot(complete_data,
                                     aes(x = cases, 
                                         y = month, 
                                         color = Party)) +
  geom_line()+
  geom_point() +
  coord_flip() +
  scale_x_continuous(labels = scales::number_format(accuracy = 1))+
  scale_y_continuous(breaks = c(2,4,6,8,10,12), labels = c("Feb", "Apr", "Jun", "Aug", "Oct", "Dec")) +
  scale_color_manual(values = c("#223AC4", "#CC1111"))+
  ggtitle("US Covid Cases") +
  labs(subtitle = "by party of governor 2020",x = "Cumulative Cases per Month ", y = "Months") +
  theme_bw()
covid_cases_per_state_plot



