#legendary singer Lata Mangeshkar pased away today (February 06, 2022)
#this practice sessons is dedicated to her
#dataset from "https://atulsongaday.me/category/series-of-articles/yearwise-review-of-lata-mangeshkar-hf-songs/"

#load libraries
library(tidyverse)
library(lubridate)

#load data
lata <- read_csv("C:\\Users\\ankur\\OneDrive\\R scripts\\Practice datasets\\Lata\\lata.csv")
glimpse(lata)
lata$movie_count <- parse_number(lata$movie_count) #parse movie counts to numeric values

#a value in row 58 was NA, coerce it to 0
lata$movie_count[58] <- 0

#remove rows with NA
lata <- lata %>% drop_na()


