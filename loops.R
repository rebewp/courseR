#checking out some for loops
#could also use purrr, needs tidyverse!

#good to know:
#The ith element of a vector can be accessed by using either [[i]] or [i].

#The ith element of a list can be obtained by using [[i]] – [i] 
#would return a sub-list instead of the element. The second element
#of the ith element in a list (if it were a vector or a list) can be obtained using [[i]][[2]] etc.

#The ith column of a tibble can be accessed as a vector using [[i]]. 
#The second value of the ith column of a tibble can be accessed using [[i]][[2]]

library(tidyverse)

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
set.s
set.seed(123)
x <- sample(10, 1)
x
x
x
