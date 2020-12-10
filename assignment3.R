#Assignment 3
##Manipulating data, dates and factors

#packages as usual
install.packages("rtweet")
library(tidyverse)
library(rtweet)


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

#dropping all columns except created_at, initiating new ones: day, month, year, month, hour
juncker_timeline_tidy <- juncker_timeline %>% 
  select(-(!created_at)) %>% 
  mutate(day = day(created_at), month = month(created_at), year = year(created_at), hour = hour(created_at))
