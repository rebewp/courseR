#Assignment 5
library(tidyverse)

cars_tbl <- mtcars %>% 
  rownames_to_column(var = "model_name") %>% 
  select(mpg, cyl, disp, hp, gear)
#loops

output <- double(length = ncol(cars_tbl))
output <- set_names(output, colnames(cars_tbl))
output

#1 Renaming columnnames with "mean_" + old name
for (i in seq_along(output)) {
  names(output)[i] <- paste('mean_',names(output[i]), sep = "")
}
output
#1 using map() 
##todo


#2
output_median <- vector("double", length(cars_tbl))
output_median <- set_names(output_median, paste('median_', colnames(cars_tbl),sep = ""))

for (i in seq_along(cars_tbl)) {
  output_median[[i]] <- median(cars_tbl[[i]])
}
output_median

#3
char_vector <- vector("character", length = 3)
input <- c("i", "accomplished", "task 3")
for (i in seq_along(char_vector)) {
  char_vector[[i]] <- input[[i]]
}
char_vector


#4 getting pmap calls into a tibble
tibble(
  n = 10,
  mean = 1:10,
  sd = 0.5
) %>% 
  pmap(rnorm)

y <- tibble(
  n = 10,
  mean = 1:10,
  sd = 0.5)

tibble_of_pmap <- y %>% pmap(rnorm) %>% set_names(paste("pmap call",rownames(y))) %>% bind_rows 
tibble_of_pmap

#functions
#1
rescale0to1 <- function(x) {
  (x - min(x, na.rm = TRUE)) / (max(x, na.rm = TRUE) - min(x, na.rm = TRUE))
}

#2
#for loop
roulette_plays_for <- list()
for (i in 1:10) {
  output_r <- play_roulette_restricted(number = 35)
  roulette_plays_for[[i]] <- output_r
}
roulette_play_for_tibble <- roulette_plays_for %>% bind_rows()
roulette_play_for_tibble

#while
roulette_plays_while <- list()
indicator <- 1
while (indicator <= 10) {
  output_r <- play_roulette_restricted(number = 35)
  roulette_plays_while[[indicator]] <- output_r
  indicator <- indicator + 1
}
roulette_play_while_tibble <- roulette_plays_while %>% bind_rows()
roulette_play_while_tibble

