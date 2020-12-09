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