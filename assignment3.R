#Assignment 3
##Manipulating data, dates and factors

#packages as usual
library(tidyverse)

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
  filter(Year == 2016) %>% 
  filter(Revenue..Millions. == max(Revenue..Millions., na.rm = TRUE))

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