library(tidyverse)
#Assignment first session 
farmers_animals <- c(53323, 1334, 4323)
named_farmers_animals <- set_names(farmers_animals, c("chicken", "cows", "horses"))
named_farmers_animals
# different method
farmers_animals_2 <- c(chicken = 53323, cows = 1334, horses = 4323)
farmers_animals_2

# more: 75% chicken, 30% cows, 50% horses ; absolute numbers; rounding with ceiling()
#breed function = number of animals plus new ones on depending percentage
breed <- function(x, y){
  (ceiling(x + x * y))
}

chicken_breed <- breed(named_farmers_animals[1], 0.75)
cows_breed <- breed(named_farmers_animals[2], 0.3)
horse_breed <- breed(named_farmers_animals[3], 0.5)

#assigning increased amount of animals to a vector
more_animals <- c(chicken = chicken_breed, cows = cows_breed, horses = horse_breed)
more_animals

#tax amount x for every 2000th birth
number_of_tax_per_2000_in_a_breed <- floor((more_animals - named_farmers_animals)/2000)

#maximum payment
max(number_of_tax_per_2000_in_a_breed)

#tibble data, characters to factor
farm_animals_tax <- tibble(
  breed = as.factor(c("chicken", "cows", "horses")),
  number_timepoint_1 = c(named_farmers_animals[1], named_farmers_animals[2], named_farmers_animals[3]),
  number_timepoint_2 = c(more_animals[1], more_animals[2], more_animals[3]),
  number_of_tax_units = number_of_tax_per_2000_in_a_breed
)

farm_animals_tax

#difference between timepoint 1 and 2
difference <- farm_animals_tax$number_timepoint_2 - farm_animals_tax$number_timepoint_1

