#Assignment 2
##reading & tidying data

#loading tidyverse just to get the included functions, don't know if its necessary yet
library(tidyverse) 
install.packages("readxl")
library(readxl)


books_tsv <- read_tsv("datasets/books.tsv") # because of the .tsv we need to use read_tsv

books_txt <- read.delim("datasets/books.txt", sep = "|") 
# in this case we use read and its included function delim. 
# Calling it with the command read.delim and we need to ad the sign the data uses to separate single lines,
# in this case its "|". When you open up the books.txt file in a texteditor you easily find out the so called seperator

ches_2017 <- read_csv("datasets/ches_2017.csv")#basically the same as .tsv
ches_2017_modified <- read_csv("datasets/ches_2017_modified.csv", skip = 4)
# the first 4 lines are not containing anything 
#so with skip we tell are to skip those

publishers <- read_xlsx("datasets/publishers.xlsx")# we first have to install and load the readrxl package 

spotify2018 <- read_csv("datasets/spotify2018.csv")# just as the first .csv file
