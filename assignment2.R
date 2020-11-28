#Assignment 2
##reading & tidying data

#package loading
library(readxl)
library(tidyverse) 

#reading data

books_tsv <- read_tsv("datasets/books.tsv") 
#separating authors
books_tsv_tidy <- books_tsv %>% 
  separate(author, into = c("author_1", "author_2", "author_3"), sep = " and ")
 

books_txt <- read.delim("datasets/books.txt", sep = "|") 
#separating authors
books_txt_tidy <- books_txt %>% 
  separate(author, into = c("author_1", "author_2", "author_3"), sep = " and ")



ches_2017 <- read_csv("datasets/ches_2017.csv")
ches_2017_modified <- read_csv("datasets/ches_2017_modified.csv", skip = 4)

ches_2017_modified_tidy <- ches_2017_modified %>% 
  pivot_wider(names_from = variable, values_from = value)


publishers_sheet_1 <- read_xlsx("datasets/publishers.xlsx", sheet = 1)
publishers_sheet_2 <- read_xlsx("datasets/publishers.xlsx", sheet = 2)


publishers_sheet_1_tidy <- publishers_sheet_1 %>% 
  separate(city, into = c("city", "state"), sep = ", ")

publishers_sheet_2_tidy <- publishers_sheet_2 %>% 
  separate(place, into = c("city", "state"), sep = ", ")

# binding the different excel sheets together
publishers_complete_tidy <- bind_rows(publishers_sheet_1_tidy, publishers_sheet_2_tidy)

# Using excel_sheets, we can get the names of sheets and create a list with them.
publisher_sheets <- readxl::excel_sheets("datasets/publishers.xlsx")
publisher_sheets <- as.list(publisher_sheets)

# When we have the list, we createa loop for each sheet and we save the data in the variable "finalData".



read_excel_allsheets <- function(filename, tibble = FALSE) {
  # I prefer straight data.frames
  # but if you like tidyverse tibbles (the default with read_excel)
  # then just pass tibble = TRUE
  sheets <- readxl::excel_sheets(filename)
  x <- lapply(sheets, function(X) readxl::read_excel(filename, sheet = X))
  if(!tibble) x <- lapply(x, as.data.frame)
  names(x) <- sheets
  x
}

publisher_testing <- read_excel_allsheets("datasets/publishers.xlsx")
publisher_testing
publisher_list_extraction <- publisher_testing %>% 
  as_tibble()



spotify2018 <- read_csv("datasets/spotify2018.csv")
