#testing stuff nr 3
library(tidyverse)

#brief overview
glimpse(imdb_2006_2016)
head(imdb_2006_2016)

imdb_2006_2016_duplicated_movie <- imdb_2006_2016 %>% 
  filter(duplicated(Title) | duplicated(Title, fromLast = TRUE))

#longest movie
imdb_2006_2016_director_of_longest_movie <- imdb_2006_2016 %>% 
  filter(Runtime..Minutes. == max(Runtime..Minutes.)) %>% 
  select(Director, Title, Runtime..Minutes.)

max(imdb_2006_2016$Runtime..Minutes.)

#highest ranked movie
imdb_2006_2016_highest_ranked_movie <- imdb_2006_2016 %>% 
  filter(Rating == max(Rating)) %>% 
  select(Title, Rating)

#most votes
imdb_2006_2016_most_votes <- imdb_2006_2016 %>% 
  filter(Votes == max(Votes)) %>% 
  select(Title, Votes)

imdb_2006_2016_votes <- imdb_2006_2016 %>% 
  filter(Votes > 1791910)

glimpse(imdb_2006_2016)

#todo more testing
imdb_2006_2016_biggest_revenue_2016 <- imdb_2006_2016 %>% 
  filter(Year == 2016) %>% 
  filter(Revenue..Millions. == max(Revenue..Millions., na.rm = TRUE))

max(imdb_2006_2016$Revenue..Millions., na.rm = TRUE)
test <- imdb_2006_2016 %>% 
  filter(Revenue..Millions. > 500)

imdb_2006_2016_biggest_revenue_2016_2 <- imdb_2006_2016 %>% 
  filter(Revenue..Millions. == max(Revenue..Millions., na.rm = TRUE) & Year == 2016)

#revenue in year total
imdb_2006_2016_combined_revenue_per_year <- imdb_2006_2016 %>% 
  filter(Year) %>% 
  mutate(complete_revenue = Revenue..Millions.)