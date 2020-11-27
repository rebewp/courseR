#Assignment 2
##reading & tidying data

#package loading
install.packages("readxl")
library(readxl)
library(tidyverse) 

#reading in data

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


publishers <- read_xlsx("datasets/publishers.xlsx")


# Using excel_sheets, we can get the names of sheets and create a list with them.
publisher_sheets <- readxl::excel_sheets("datasets/publishers.xlsx")
publisher_sheets <- as.list(publisher_sheets)

# When we have the list, we createa loop for each sheet and we save the data in the variable "finalData".

## testtesttest
finalData <- data.frame()
for (i in 1:length(sheets)){
  if (nrow(finalData) == 0 ) {
    data <- read_excel("example.xlsx", sheet = sheets[[i]] )
    finalData <- data
  }else{
    dataNext <- read_excel("example.xlsx", sheet = sheets[[i]] )
    finalData <-  cbind(finalData,  dataNext)
  }
}
finalData

publishers <- tibble()
for (i in 1:length(publisher_sheets)){
  if (nrow(publishers) == 0){
    data <- read_excel("datasets/publishers.xlsx", sheet = publisher_sheets[[i]])
    publishers <- data
  }else{
    dataNext <- read_excel("datasets/publishers.xlsx", sheet = publisher_sheets[[i]])
    publishers <- cbind(publishers, dataNext)
  }
}

read_excel_allsheets <- function(filename, tibble = TRUE) {
  # I prefer straight data.frames
  # but if you like tidyverse tibbles (the default with read_excel)
  # then just pass tibble = TRUE
  sheets <- readxl::excel_sheets(filename)
  x <- lapply(sheets, function(X) readxl::read_excel(filename, sheet = X))
  if(!tibble) x <- lapply(x, as.data.frame)
  names(x) <- sheets
  x
}

publishers <- read_excel_allsheets("datasets/publishers.xlsx")
bind_rows(publishers)


spotify2018 <- read_csv("datasets/spotify2018.csv")
