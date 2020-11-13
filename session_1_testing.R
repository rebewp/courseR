install.packages("tidyverse")
library(tidyverse)
getwd()
R.version.string
update.packages(ask = FALSE, checkBuilt = TRUE)
yes
which git()
library(tidyverse)
some_variable <- c(3,2,1)
some_variable
vector_test_integer <- c(1L, 7L, 8)
vector_test_integer_2 <- c(1L, 7L, 8L)
typeof(vector_test_integer)
typeof(vector_test_integer_2)
latter_three <- c(-1, 0, 1)
length(latter_three)
latter_three / 0

atomic_vector_conversion <- sample(1000, 100, replace = TRUE)
?sample()
atomic_vector_conversion
length(atomic_vector_conversion)
y <- atomic_vector_conversion > 500
y
as.double(y)
#naming
named_vector <- c(one = 1, two = 2, three = 3)
named_vector
later_named_vector <- c(1:3)
later_named_vector
set_names(later_named_vector, c("one", "two", "three"))
?set_names
later_named_vector

new_list <- list(numbers = 1:50, characters = c("Hello", "world", "!"), logical_vec = c(TRUE, FALSE), another_list = list(1:5, 6:10))
head(new_list, n = 3)
?head

str(new_list) # structure focused

#factors
mdbs <- factor(levels = c("AfD", "Buendnis90/Die Gruenen", "CDU", "CSU", "Die Linke", "SPD"))
levels(mdbs)
mdbs[1]

#date and time
library(lubridate)
date <- as.Date("1970-01-02")
date
typeof(date)
unclass(date)
typeof(date)
?unclass
class(date)
datetime <- ymd_hms("1970-01-01 01:00:00")
datetime

#tibble time
library(tidyverse)
new_tibble <- tibble(
  a = 1:5,
  b = c("Hi", ",", "it's", "me", "!"),
  `an invalid name` = TRUE
)
new_tibble
#access directly
new_tibble$a
new_tibble$b

typeof(new_tibble[["a"]])
install.packages('usethis')
library(usethis)
usethis::create_github_token()
usethis::c