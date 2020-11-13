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
chicken_count <- ceiling(chicken + chicken * 0.75)
chicken_count

cows_count <- farmers_animals[2]
cows_count <- ceiling(cows + cows * 0.3)
cows_count

horses_count <- farmers_animals[3]
horses_count <- ceiling(horses + horses * 0.5)
horses_count

more_animals_after_eating <- c(chicken = chicken_count, cows = cows_count, horses = horses_count)
more_animals_after_eating
