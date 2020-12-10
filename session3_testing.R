#testing stuff nr 3
library(tidyverse)
library(lubridate)
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
  group_by(Year) %>% 
  filter(Revenue..Millions. == max(Revenue..Millions., na.rm = TRUE) & Year == 2016)

#revenue in year total
imdb_2006_2016_combined_revenue_per_year <- imdb_2006_2016 %>% 
  group_by(Year) %>% 
  mutate(complete_revenue = sum(Revenue..Millions., na.rm = TRUE)) 

imdb_2006_2016_combined_revenue_per_year <- imdb_2006_2016 %>% 
  group_by(Year) %>% 
  summarise(complete_revenue = sum(Revenue..Millions., na.rm = TRUE))
  

#distinct test
imdb_2006_2016_distinct <- imdb_2006_2016 %>% 
  distinct(Title)

?cumall
?cumsum
x <- c(1:10)
cumall(x)
cumsum(x)
sum(x)

#filtering fun
##more than average runtime
imdb_2006_2016_runtime_above_average <- imdb_2006_2016 %>% 
  filter(Runtime..Minutes. > mean(Runtime..Minutes.))
mean(imdb_2006_2016$Runtime..Minutes.)

#direceted by jj abrams
imdb_2006_2016_director_jj_abrams <- imdb_2006_2016 %>% 
  filter(Director == "J.J. Abrams")

#more votes than median
imdb_2006_2016_more_votes_than_median <- imdb_2006_2016 %>% 
  filter(Votes > median(Votes, na.rm = TRUE))


median(imdb_2006_2016$Votes, na.rm = FALSE)
mean(imdb_2006_2016$Votes, na.rm = FALSE)

#mode
## helper function for mode

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

#lubridate
juncker_timeline <- get_timeline(user = "@JunckerEU", n = 1000)

#saving as csv #todo needs work
data.table::fwrite(juncker_timeline, file = "juncker_twitter_timeline.csv")

#dropping all columns except created_at, initiating new ones: day, month, year, month, hour
juncker_timeline_tidy <- juncker_timeline %>% 
  select(-(!created_at)) %>% 
  mutate(day = day(created_at))
