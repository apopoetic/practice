#legendary singer Lata Mangeshkar pased away today (February 06, 2022)
#this practice sessons is dedicated to her
#dataset from "https://atulsongaday.me/category/series-of-articles/yearwise-review-of-lata-mangeshkar-hf-songs/"

#load libraries
library(tidyverse)
library(lubridate)
library(magick)

#load data
lata <- read_csv("lata.csv")
glimpse(lata)
lata$movie_count <- parse_number(lata$movie_count) #parse movie counts to numeric values

#a value in row 58 was NA, coerce it to 0
lata$movie_count[58] <- 0

#remove rows with NA
lata <- lata %>% drop_na() %>% slice(-71)%>% select(-c("songs_recorded", "movie_count"))

#pivot longer
lata$year <- as.double(lata$year)
lata <- lata %>% pivot_longer(cols = c("solo":"other"), names_to = "variables", values_to = "songs") %>%
  mutate(cum_songs = cumsum(songs))

g1 <- ggplot(data = lata, aes(year, songs, fill = variables)) + geom_area(alpha = 0.75) +
 theme_classic() + labs(title = "BODY OF LATA MANGESHKAR JI'S WORK", caption = "A. Jamwal\n Source: https://atulsongaday.me/category/series-of-articles/yearwise-review-of-lata-mangeshkar-hf-songs/", size = 10) +
  xlab("Songs (number)") + ylab("Year") +geom_text(x=2000, y= 200, label = "Cumulative songs = 5255")

#Add awards0
awards <- data.frame(yr = c(1969, 1989, 1999, 2001, 2008, 1972, 1974, 1990),
                     award_name = c("Padma Bhushan", 
                                    "Dada Saheb Phalke Award", 
                                    "Padma Vibhushan", "Bharat Ratna",
                                    "Lifetime Achievement Award", 
                                    "National Award",
                                    "National Award",
                                    "National Award"),
                     n_songs = c(67, 20, 10, 150, 50, 15,40, 80))
labels <- awards$award_name
 #load background image
image <- image_read("lata.jpeg")
img <- rasterGrob(image, width=unit(1,"npc"), height=unit(1,"npc"), interpolate = FALSE)
#combine two graphs
g1 <- ggplot() + annotation_custom(img, -Inf, Inf, -Inf, Inf) + geom_area(data = lata, aes(year, songs, fill = variables)) +
  geom_area(alpha = 0.75) + theme_classic() + theme(axis.text.x = element_text(angle = 90))+
  labs(fill = " ", title = "BODY OF LATA MANGESHKAR JI'S WORK", caption = "A. Jamwal\n Source: https://atulsongaday.me/category/series-of-articles/yearwise-review-of-lata-mangeshkar-hf-songs/", size = 3) +
  xlab("Year") + ylab("Songs (number)") + 
  scale_fill_discrete(labels = c("Female duets", "Male duets", "Others", "Solo")) +
  scale_x_continuous(breaks = round(seq(min(1945), max(2016), by = 2),1)) +
  geom_segment(data = awards, aes(x=yr, xend = yr, y=0, yend=n_songs)) +
  geom_point(data = awards, aes(x =yr, y=n_songs), size =3, colour = "red", 
             fill = alpha("orange", 0.5), alpha = 0.75, shape = 21) + 
  geom_text(data = awards, aes(x =yr, y=n_songs), label= labels, vjust  = -1.5)+
  annotate("text", x = 2000, y = 210, label = "Cumulative songs = 5255", colour  = "pink", size = 2)
