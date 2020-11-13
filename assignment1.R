library(tidyverse)
#Assignment first session 
farmers_animals <- c(53323, 1334, 4323)
named_farmers_animals <- set_names(farmers_animals, c("chicken", "cows", "horses"))
named_farmers_animals
# different method
farmers_animals_2 <- c(chicken = 53323, cows = 1334, horses = 4323)
farmers_animals_2
# more: 75% chicken, 30% cows, 50% horses ; absolute numbers; rounding with ceiling()
chicken_count <- farmers_animals[1]
chicken_count <- ceiling(chicken_count + chicken_count * 0.75)
chicken_count

cows_count <- farmers_animals[2]
cows_count <- ceiling(cows_count + cows_count * 0.3)
cows_count

horses_count <- farmers_animals[3]
horses_count <- ceiling(horses_count + horses_count * 0.5)
horses_count

more_animals <- c(chicken = chicken_count, cows = cows_count, horses = horses_count)
more_animals

#tax amount x for every 2000th
?floor
?max
floor(chicken_count/2000)
floor(cows_count/2000)
floor(horses_count/2000)

##todo max 
#tibble data
farm_animals_tax <- tibble(
  breed = ,
  number_timepoint_1 = ,
  number_timepoint_2 = ,
  number_of_tax_units = 
)

#difference between timepoint 1 and 2
difference <- 