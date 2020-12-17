#Assignment 3
##Manipulating data, dates and factors

#packages as usual
#install.packages("rtweet")
library(lubridate)
library(tidyverse)
library(rtweet)
library(ggplot2)


#Imdb
##reading the dataset
imdb_2006_2016 <- read.csv("datasets/number_3/imdb2006-2016.csv")

#finding duplicated movie
imdb_2006_2016_duplicated_movie <- imdb_2006_2016 %>% 
  filter(duplicated(Title) | duplicated(Title, fromLast = TRUE))

#longest movie
imdb_2006_2016_director_of_longest_movie <- imdb_2006_2016 %>% 
  filter(Runtime..Minutes. == max(Runtime..Minutes.)) %>% 
  select(Director, Title, Runtime..Minutes.)

#highest ranked movie
imdb_2006_2016_highest_ranked_movie <- imdb_2006_2016 %>% 
  filter(Rating == max(Rating)) %>% 
  select(Title, Rating)

#most votes
imdb_2006_2016_most_votes <- imdb_2006_2016 %>% 
  filter(Votes == max(Votes)) %>% 
  select(Title, Votes)

#highest revenue ##todo combining in one filter
imdb_2006_2016_biggest_revenue_2016 <- imdb_2006_2016 %>% 
  group_by(Year) %>% 
  filter(Revenue..Millions. == max(Revenue..Millions., na.rm = TRUE) & Year == 2016)

#combined revenue per year
imdb_2006_2016_combined_revenue_per_year <- imdb_2006_2016 %>% 
  group_by(Year) %>% 
  summarise(complete_revenue = sum(Revenue..Millions., na.rm = TRUE))

##more than average runtime
imdb_2006_2016_runtime_above_average <- imdb_2006_2016 %>% 
  filter(Runtime..Minutes. > mean(Runtime..Minutes.))

#direceted by jj abrams
imdb_2006_2016_director_jj_abrams <- imdb_2006_2016 %>% 
  filter(Director == "J.J. Abrams")

#more votes than median
imdb_2006_2016_more_votes_than_median <- imdb_2006_2016 %>% 
  filter(Votes > median(Votes, na.rm = TRUE))

#mode
##using helper function
my_mode <- function(x){ 
  ta = table(x)
  tam = max(ta)
  if (all(ta == tam))
    mod = NA
  else
    if(is.numeric(x))
      mod = as.numeric(names(ta)[ta == tam])
  else
    mod = names(ta)[ta == tam]
  return(mod)
}

imdb_2006_2016_mode_of_votes <- imdb_2006_2016 %>% 
  filter(Rating == my_mode(Rating))


##lubridate

#getting twitter data with rtweet
juncker_timeline <- get_timeline(user = "@JunckerEU", n = 1000)

#saving timeline as csv in working directory
write_as_csv(juncker_timeline, file_name = "juncker_twitter_timeline_rtweet")

#dropping all columns except created_at, initiating new ones: day, month, year, month, hour
juncker_timeline_tidy <- juncker_timeline %>% 
  select(-(!created_at)) %>% 
  mutate(day = day(created_at), month = month(created_at), year = year(created_at), hour = hour(created_at))

# counting post per year and month in two tibbles
juncker_timeline_posts_per_year <- juncker_timeline_tidy %>% 
  group_by(year) %>% 
  summarise(occurrence = n())

juncker_timeline_posts_per_month <- juncker_timeline_tidy %>% 
  mutate(month = month(month, label = TRUE)) %>% 
  group_by(month) %>%   
  summarise(occurrence = n())

#visualization
##visualization years
juncker_timeline_posts_per_year_plot <- ggplot(juncker_timeline_posts_per_year,
                                               aes(x = occurrence,
                                                   y = year)) +
  geom_point() +
  ggtitle("Posts of J.C. Juncker per Year")+
  coord_flip()+
  theme_bw()
juncker_timeline_posts_per_year_plot

##visualization months
  
juncker_timeline_posts_per_month_plot <- juncker_timeline_posts_per_month %>% 
  ggplot(aes(x = month,
             y = occurrence)) +
  geom_point()+
  theme_bw()+
  ggtitle("Posts of J.C. Juncker per Month (2014 - 2019)")
juncker_timeline_posts_per_month_plot

#rounding dates to the first day of month
#maybe makes more sense because of gaining more information, in this case also the year, out of one column(?)
juncker_timeline_tidy_months_rounded <- juncker_timeline_tidy %>% 
  mutate(created_at = round_date(created_at, "month"))


#forcats

#reading ess
##reading ess2016.csv
ess2016 <- read_csv("datasets/number_3/ess2016_ger.csv")
ess2016$party_vote

#converting party_code to party_code_fct
##no variable party_code available, working with party_vote instead
ess2016_party_vote_fct <- ess2016 %>% 
  mutate(party_vote_fct = as_factor(party_vote)) %>% 
  select(-(!party_vote_fct))

#finding the four most common parties
sort(table(ess2016_party_vote_fct$party_vote_fct),decreasing=TRUE)[1:3]

#excluding NA`s`
ess2016_party_vote_fct_without_na <-ess2016_party_vote_fct %>% 
  filter(!is.na(party_vote_fct))

#using recode
ess2016_party_vote_fct_recode <- ess2016_party_vote_fct_without_na %>% 
  group_by(party_vote_fct) %>% 
  mutate(party_vote_fct = fct_recode(party_vote_fct, 
                                     "Other" = "NPD", 
                                     "Other" = "AfD",
                                     "Other" = "FDP",
                                     "Other" = "Andere Partei",
                                     "Other" = "Piratenpartei"))

#using collapse
ess2016_party_vote_fct_collapse <- ess2016_party_vote_fct_without_na %>% 
  group_by(party_vote_fct) %>% 
  mutate(party_vote_fct = fct_collapse(party_vote_fct, 
                                       Other = c("NPD", "AfD", "FDP", "Andere Partei", "Piratenpartei")))
#using lump
ess2016_party_vote_fct_lump <- ess2016_party_vote_fct_without_na %>% 
  mutate(party_vote_fct = fct_lump(party_vote_fct,
                                   n = 4))


