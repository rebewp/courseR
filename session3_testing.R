#testing stuff nr 3
install.packages("rtweet")
library(rtweet)
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

#saving as csv #todo needs work, still needs work even with second try
data.table::fwrite(juncker_timeline, file = "juncker_twitter_timeline.csv")
write_as_csv(juncker_timeline, file_name = "juncker_twitter_timeline_rtweet")

#dropping all columns except created_at, initiating new ones: day, month, year, month, hour
juncker_timeline_tidy <- juncker_timeline %>% 
  select(-(!created_at)) %>% 
  mutate(day = day(created_at), month = month(created_at), year = year(created_at), hour = hour(created_at))

?rtweet
#auth
#file.edit("~/.Renviron")

# counting post per year and month in two tibbles
juncker_timeline_posts_per_year <- juncker_timeline_tidy %>% 
  group_by(year) %>% 
  summarise(occurrence = n())

juncker_timeline_posts_per_year_plot <- ggplot(juncker_timeline_posts_per_year,
                                               aes(x = occurrence,
                                                   y = year)) +
  geom_point() +
  ggtitle("Posts of J. Juncker per Year")+
  coord_flip()
juncker_timeline_posts_per_year_plot

glimpse(juncker_timeline_posts_per_year)

juncker_timeline_posts_per_month <- juncker_timeline_tidy %>% 
  mutate(month = month(month, label = TRUE)) %>% 
  group_by(month) %>% 
  summarise(occurrence = n()) %>% 
  ggplot(aes(x = month,
             y = occurrence)) +
  geom_point()+
  ggtitle("Posts of J.C. Juncker per Month (2014 - 2019)")
juncker_timeline_posts_per_month

months <- c("Jan", "Feb", "Mär", "Apr", "Mai", "Jun", "Jul", "Aug", "Sep", "Okt", "Nov", "Dez")

juncker_timeline_tidy_months <- juncker_timeline_tidy %>% 
  mutate(month = month(month, label = TRUE))
  


juncker_timeline_posts_per_month <- juncker_timeline_tidy %>% 
  group_by(month) %>% 
  summarise(occurrence = n()) %>% 
  select(month = month(month, label = TRUE))
month(juncker_timeline_posts_per_month$month, label = TRUE)

#rounding dates to first day of month ?!
?round_date

x <- ymd_hms("2009-08-03 12:01:59.23")
round_date(x, ".5s")
round_date(x, "sec")
round_date(x, "second")
round_date(x, "minute")
round_date(x, "5 mins")
round_date(x, "hour")
round_date(x, "2 hours")
round_date(x, "day")
round_date(x, "week")
round_date(x, "month")
round_date(x, "bimonth")
round_date(x, "quarter") == round_date(x, "3 months")
round_date(x, "halfyear")
round_date(x, "year")

juncker_timeline_tidy_months_rounded <- juncker_timeline_tidy %>% 
  mutate(created_at = round_date(created_at, "month"))

round_date(juncker_timeline_tidy$created_at, "month")

#forcats
##reading ess2016.csv
ess2016 <- read_csv("datasets/number_3/ess2016_ger.csv")
ess2016_2 <- read.csv("datasets/number_3/ess2016_ger.csv")
ess2016_2$party_vote
#converting party_code to party_code_fct
##no variable party_code available, working with party_vote instead
ess2016_party_vote_fct <- ess2016 %>% 
  mutate(party_vote_fct = as_factor(party_vote)) %>% 
  select(-(!party_vote_fct))
  

  

head(ess2016_party_vote_fct)
?rename
