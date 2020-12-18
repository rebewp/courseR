#Assignment 2
##reading & tidying data

#loading tidyverse just to get the included functions, don't know if its necessary yet
library(tidyverse) 
install.packages('readxl')

books_tsv <- read_tsv("datasets/books.tsv") # because of the .tsv we need to use read_tsv

books_txt <- read.delim("datasets/books.txt", sep = "|") 
# in this case we use read and its included function delim. 
# Calling it with the command read.delim and we need to ad the sign the data uses to separate single lines,
# in this case its "|". When you open up the books.txt file in a texteditor you easily find out the so called seperator

ches_2017 <- read_csv("datasets/ches_2017.csv")#basically the same as .tsv
ches_2017_modified <- read_csv("datasets/ches_2017_modified.csv", skip = 4)
# the first 4 lines are not containing anything so with 
#skip we tell R to skip those

publishers <- readxl::read_xlsx()

##############################
#realstuff!! below


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
