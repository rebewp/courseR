#Assignment 2
##reading & tidying data

#package loading
library(readxl)
library(tidyverse) 

#reading data

##books
books_tsv <- read_tsv("datasets/books.tsv") 
#separating authors
books_tsv_tidy <- books_tsv %>% 
  separate(author, into = c("author_1", "author_2", "author_3"), sep = " and ")


books_txt <- read.delim("datasets/books.txt", sep = "|") 
#separating authors
books_txt_tidy <- books_txt %>% 
  separate(author, into = c("author_1", "author_2", "author_3"), sep = " and ")


#ches data
ches_2017 <- read_csv("datasets/ches_2017.csv")
ches_2017_modified <- read_csv("datasets/ches_2017_modified.csv", skip = 4)

#each variable gets a column
ches_2017_modified_tidy <- ches_2017_modified %>% 
  pivot_wider(names_from = variable, values_from = value)

#publisher excel with two sheets
publishers_sheet_1 <- read_xlsx("datasets/publishers.xlsx", sheet = 1)
publishers_sheet_2 <- read_xlsx("datasets/publishers.xlsx", sheet = 2)

#tidying each sheet
publishers_sheet_1_tidy <- publishers_sheet_1 %>% 
  separate(city, into = c("city", "state"), sep = ", ")

publishers_sheet_2_tidy <- publishers_sheet_2 %>% 
  separate(place, into = c("city", "state"), sep = ", ")

# binding the different excel sheets together
publishers_complete_tidy <- bind_rows(publishers_sheet_1_tidy, publishers_sheet_2_tidy)

#spotify data
spotify2018 <- read_csv("datasets/spotify2018.csv")
