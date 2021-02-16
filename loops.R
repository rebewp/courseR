#checking out some for loops
#could also use purrr, needs tidyverse!

#good to know:
#The ith element of a vector can be accessed by using either [[i]] or [i].

#The ith element of a list can be obtained by using [[i]] – [i] 
#would return a sub-list instead of the element. The second element
#of the ith element in a list (if it were a vector or a list) can be obtained using [[i]][[2]] etc.

#The ith column of a tibble can be accessed as a vector using [[i]]. 
#The second value of the ith column of a tibble can be accessed using [[i]][[2]]
install.packages("nycflights13")
library(tidyverse)
library(nycflights13)

#without purrr
v <- c("this", "is", "a", "vector")

for (i in seq(v)) {
  print(v[[i]])
}

?seq
seq(0, 1, length.out = 11)

example_strings <- c("this", "is", "how", "a", "for", "loop", "works")

for (i in seq_along(example_strings)) {
  print(example_strings[[i]])
}

#with purrr
walk(v, print)

##if statement

#syntax
#if (conditional_statement evaluates to TRUE) {
#  do_something
#} else {
#do_something_else
#}
y <- sample(10, 1)
y
set.s
set.seed(123)
x <- sample(10, 1)
x
seq_along(example_strings)
print(example_strings[1])
print(example_strings[seq_along(example_strings)[1]])

#car example
cars_2 <- mtcars %>% 
  select(mpg, cyl, disp, hp, gear)

cars_tbl <- mtcars %>% 
  rownames_to_column(var = "model_name") %>% 
  select(mpg, cyl, disp, hp, gear)

#leeren vector für bearbeitung generieren
#column names setzen
output <- double(length = ncol(cars_tbl))
output <- set_names(output, colnames(cars_tbl))
output

#durchschnitt der column inhalte von cars_tbl in output schreiben
for (i in seq_along(cars_tbl)) {
  output[[i]] <- mean(cars_tbl[[i]])
}


glimpse(cars_tbl)
head(cars_tbl)
head(cars_2)
?rownames_to_column
has_rownames(mtcars)
has_rownames(cars_2)
mtcars_tbl <- rownames_to_column(mtcars, var = "car") %>% as_tibble()
mtcars_tbl
has_rownames(mtcars)

relevant_columns <- c("mpg", "cyl", "disp", "hp", "gear")

for (var in relevant_columns) {
  mtcars %>% count(.data[[var]]) %>% print()
}

for (i in seq_along(cars_tbl)) {
  cars_tbl[[i]] <- mean(cars_tbl[[i]])
}
cars_tbl_sliced <- cars_tbl %>% 
  slice(1)
cars_tbl_sliced
?slice

#map
add_10 <- function(x) {
  x + 10
}
map(example_dbl, add_10)
map_dbl(example_dbl, add_10)
#map tibble as outcome
map_dfr(cars_tbl, mean)
#anonymous function in map()
example_dbl <- c(1.5, 1.3, 1.8, 1.9, 2.3)
map_dbl(example_dbl, ~{
  .x + 10
})

#map2
map2(10, 5, sample)

?sample
b <- 1:12
sample(b,20, replace = TRUE)

#controlling outcome
typeof(map2(10, 5, sample))

map2(10, 5, sample) %>% flatten_dbl()
typeof(map2(10, 5, sample) %>% flatten_dbl())

#vector longer than one
map2(c(10, 5), c(5, 3), sample) 

#more than two arguments
tibble(
  n = 10,
  mean = 1:10,
  sd = 0.5
) %>% 
  pmap(rnorm)

##basic roulette for function testing
play_roulette <- function(bet, number) {
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
}

play_roulette(bet = 1, number = 35)

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
play_roulette_restricted(number = 35)

play_roulette_basic <- function(bet = 1, number) {
  if (number > 36) stop("You can only bet on numbers between 0 and 36.")
  draw <- sample(0:36, 1)
  if (number == draw) {
    return(paste("Nice, you won", as.character(bet * 36), "Dollars"), sep = " ")
  } else {
    return("I'm sorry, you lost.")
  }
}
play_roulette_basic(number = 35)

?dplyr_tidy_select

#######################
#####testing###
#######################

output <- double(length = ncol(cars_tbl))
output <- set_names(output, colnames(cars_tbl))
output
cars_tbl
head(cars_tbl)
#aufgabe2
output_median <- vector("double", length(cars_tbl))
# not needed 
#names(output_median) <- names(cars_tbl)
output_median <- set_names(output_median, paste('median_', colnames(cars_tbl),sep = ""))

for (i in seq_along(cars_tbl)) {
  output_median[[i]] <- median(cars_tbl[[i]])
}
output_median

#aufgabe 3
char_vector <- vector("character", length = 3)
input <- c("i", "accomplished", "task 3")
seq_along(char_vector)
for (i in seq_along(char_vector)) {
  char_vector[[i]] <- input[[i]]
}
char_vector

#aufgabe 4 //todo

tibble(
  n = 10,
  mean = 1:10,
  sd = 0.5
) %>% 
  pmap(rnorm)
?rnorm
pmap()

#exercises functions
rescale0to1 <- function(x) {
  (x - min(x, na.rm = TRUE)) / (max(x, na.rm = TRUE) - min(x, na.rm = TRUE))
}

#aufgabe1 //todo
colnames(cars_tbl)
names(cars_tbl)
names(output)
output <- set_names(output, paste('mean_',sep = "", colnames(cars_tbl)))
output
# names don't look good -- for loop and change them to "mean_*" using the paste-function
for (i in seq_along(output)) {
  names(output)[i] <- paste('mean_',names(output[i]), sep = "")
}

output



?colnames
names(output) <- paste('mean_', names(cars_tbl), sep = "")
output
m2 <- cbind(1, 1:4)
m2
colnames(m2, do.NULL = FALSE)
colnames(m2) <- c("x","Y")
seq_along(output)

output
for (i in seq_along(cars_tbl)) {
  output[[i]] <- mean(cars_tbl[[i]])
}
output

?paste

output <- double(length = ncol(cars_tbl))
output <- set_names(output, colnames(cars_tbl))
output
colnames(output) <- c(1:5)
colnames(cars_tbl)

map_chr(output, ~{
 colnames(paste('mean_', sep = ""))
})
names(output) <- map_chr(names(output), paste, "mean_", )
output

names(output) <- map_chr(output, ~ paste(.x,"mean_",names(.x), sep = ""))
output
names(output) <- paste("mean_",names(output), sep="")########working fine
#now with anonymous
map_chr(output, ~ paste("mean_", sep=""))
map_chr(output, ~{
  names(paste("mean"))
})

example_dbl <- c(1.5, 1.3, 1.8, 1.9, 2.3)
map_dbl(example_dbl, ~{
  .x + 10
})
?colnames
#r4ds book exercise
output_cars <- vector("double", ncol(mtcars))
names(output_cars) <- names(mtcars)
for (i in seq_along(mtcars)) {
  output_cars[[i]] <- mean(mtcars[[i]])
}
output_cars

output_flights <- vector("list", ncol(nycflights13::flights))
names(output_flights) <- names(nycflights13::flights)
for (i in seq_along(nycflights13::flights)) {
  output_flights[[i]] <- class(nycflights13::flights[[i]])
}
output_flights

#####
cars_tbl <- mtcars %>% 
  rownames_to_column(var = "model_name") %>% 
  select(mpg, cyl, disp, hp, gear)
glimpse(cars_tbl)


output <- double(length = ncol(cars_tbl))
output <- set_names(output, colnames(cars_tbl))
output
str(output)
# names don't look good -- for loop and change them to "mean_*" using the paste-function
# example for paste()
#paste("Pass", "strings", "to", "paste", sep = " ")
for (i in seq_along(output)) {
  names(output[i]) <- paste('mean_')
}
for (i in seq_along(output)) {
  print(names(output[i]))
}

for (names in output) {
  names <- paste('mean_', output[names],sep = "")
}
output

output_1 <- 1:6
names(output_1) <- letters[1:6]
output_1
set_names(output_1)
set_names(output1)
output_1
x

seq_along(output)
?names  
?paste
names(output)
output[i] <- set_names(paste("mean"))
output
