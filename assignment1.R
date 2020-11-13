library(tidyverse)
#Assignment first session 
farmers_animals <- c(53323, 1334, 4323)
named_farmers_animals <- set_names(farmers_animals, c("chicken", "cows", "horses"))
named_farmers_animals
# different method
farmers_animals_2 <- c(chicken = 53323, cows = 1334, horses = 4323)
farmers_animals_2
# more: 75% chicken, 30% cows, 50% horses ; absolute numbers; rounding with ceiling()
chicken <- farmers_animals[1]
chicken <- ceiling(chicken + chicken * 0.75)
chicken

cows <- farmers_animals[2]
cows <- ceiling(cows + cows * 0.3)
cows

horses <- farmers_animals[3]
horses <- ceiling(horses + horses * 0.5)
horses
