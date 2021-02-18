#Assignment 5
library(tidyverse)

cars_tbl <- mtcars %>% 
  rownames_to_column(var = "model_name") %>% 
  select(mpg, cyl, disp, hp, gear)

# Loops -------------------------------------------------------------------

output <- double(length = ncol(cars_tbl))
output <- set_names(output, colnames(cars_tbl))
output

#1 Renaming columnnames with "mean_" + old name
for (i in seq_along(output)) {
  names(output)[i] <- paste('mean_',names(output[i]), sep = "")
}
output

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


# Functions ---------------------------------------------------------------

#1
rescale0to1 <- function(x) {
  (x - min(x, na.rm = TRUE)) / (max(x, na.rm = TRUE) - min(x, na.rm = TRUE))
}

rescale0to1_second_possibility <- function(x) {
  range_x <- range(x, na.rm = TRUE)
  (x - range_x[1] / range_x[2] - range_x[1])
}

#2
play_roulette_restricted <- function(bet = 1, number) {
  if (number > 36) stop("You can only bet on numbers between 0 and 36.")
  draw <- sample(0:36, 1)
  tibble(
    winning_number = draw,
    your_number = number,
    your_bet = bet,
    your_return = if (number == draw) {
      bet * 36
    } else {
      0
    }
  )
  #return(tbl_return)
}

#for loop
roulette_plays_for <- list()
for (i in 1:10) {
  output_r <- play_roulette_restricted(number = 35)
  roulette_plays_for[[i]] <- output_r
}
roulette_play_for_tibble <- roulette_plays_for %>% bind_rows()
roulette_play_for_tibble

#while loop
roulette_plays_while <- list()
indicator <- 1
while (indicator <= 10) {
  output_r <- play_roulette_restricted(number = 35)
  roulette_plays_while[[indicator]] <- output_r
  indicator <- indicator + 1
}
roulette_play_while_tibble <- roulette_plays_while %>% bind_rows()
roulette_play_while_tibble

#map()
roulette_plays_map <- list(1,2,3,4,5,6,7,8,9,10)

roulette_plays_map %>% map_dfr(., ~as.list(play_roulette_restricted(number = 35)), .id = "iteration")

###roulette
#color bullet proofing

red_fields <- c(32, 19, 21, 25, 34, 27, 36, 30, 23, 5, 16, 1, 14, 9, 18, 7, 12, 3)
black_fields <- setdiff(1:36, red_fields)
zero <- 0
possible_colors <- c("red", "black", "zero")

##necessary function
determine_color <- function(x){
  if (x %in% red_fields) {
    return("red")
  }else if (x %in% black_fields) {
    return("black")
  }else{
    return("zero")
  }
}

play_roulette_restricted_color <- function(bet = 1, number = NULL, color = NULL) {
  if (is.null(number) && is.null(color)) stop("You have to bet on a color or number")
  if (!is.null(number) && !is.null(color)) stop("Please place your bet on a color OR number")
  if (!is.null(number) && number > 36) stop("You can only bet on numbers between 0 and 36.")
  if (color %in% possible_colors == FALSE) stop("You can only choose between red, black or zero")
  if (!is.null(number) && number < 36){
    draw <- sample(0:36, 1)
    tibble(
      winning_number = draw,
      winning_color = determine_color(winning_number),
      your_number = number,
      your_bet = bet,
      your_return = if (number == draw) {
        bet * 36
      } else {
        0
      }
    )
  }else{
    draw <- sample(0:36, 1)
    tibble(
      winning_number = draw,
      winning_color = determine_color(winning_number),
      your_color = color,
      your_bet = bet,
      your_return = if (color == winning_color) {
        bet * 2
      } else {
        0
      }
    )
    
  }
  #return(tbl_return)
}
play_roulette_restricted_color(color = "green")

