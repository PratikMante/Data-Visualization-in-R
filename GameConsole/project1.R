library(tidyr)
library(dplyr)
library(tidyverse)

vgsales <- read.csv("/Users/pratikmante/Downloads/vgsales.csv")
vgsales

# Number of games produced for different consoles
count_consoles <- vgsales %>% count(Platform)
count_consoles
write.csv(count_consoles, "count_consoles.csv", row.names = FALSE)

# count regional sales
count_sales <- vgsales %>% gather(Region, Sales, NA_Sales: Other_Sales)
count_sales <- count_sales %>% group_by(Region) %>% summarise(Sales = sum(Sales))
count_sales
write.csv(count_sales, "count_sales.csv", row.names = FALSE)

# Group by genres
count_genres <- vgsales %>% count(Genre)
count_genres
write.csv(count_genres, "count_genres.csv", row.names = FALSE)

# region sales by genres %>% spread(Genre, Sales)
count_region_genres <- vgsales %>% gather(Region, Sales, NA_Sales: Other_Sales) %>% 
  group_by(Region, Genre) %>% summarise(Sales = sum(Sales)) 
count_region_genres  
write.csv(count_region_genres, "count_region_genres.csv", row.names = FALSE)

# year wise sales
count_years <- vgsales %>% group_by(Year) %>% summarise(Sales = sum(Global_Sales))
count_years
write.csv(count_years, "count_years.csv", row.names = FALSE)

# top 5 games sold globally
top_global <- vgsales %>% arrange(desc(Global_Sales)) %>% top_n(5)
top_global
write.csv(top_global, "top_global.csv", row.names = FALSE)

# top 5 games sold in NA
top_regional_NA <- vgsales %>% gather(Region, Sales, NA_Sales) %>% arrange(desc(Sales)) %>% top_n(5)
top_regional_NA
write.csv(top_regional_NA, "top_regional_NA.csv", row.names = FALSE)

# top 5 games sold in EU
top_regional_EU <- vgsales %>% gather(Region, Sales, EU_Sales) %>% arrange(desc(Sales)) %>% top_n(5)
top_regional_EU
write.csv(top_regional_EU, "top_regional_EU.csv", row.names = FALSE)

# top 5 games sold in JP
top_regional_JP <- vgsales %>% gather(Region, Sales, JP_Sales) %>% arrange(desc(Sales)) %>% top_n(5)
top_regional_JP
write.csv(top_regional_JP, "top_regional_JP.csv", row.names = FALSE)

# top 5 games sold in other
top_regional_other <- vgsales %>% gather(Region, Sales, Other_Sales) %>% arrange(desc(Sales)) %>% top_n(5)
top_regional_other
write.csv(top_regional_other, "top_regional_other.csv", row.names = FALSE)

# game publishers and number of games produced
count_publishers <- vgsales %>% count(Publisher)
count_publishers
write.csv(count_publishers, "count_publishers.csv", row.names = FALSE)

# number of games produced by publishers every year
count_publishers_year <- vgsales %>% group_by(Publisher) %>% count(Year) %>% spread(Year, n) 
count_publishers_year 
write.csv(count_publishers_year, "count_publishers_year.csv", row.names = FALSE)

# games released each year
count_year_released <- vgsales %>% count(Year)
count_year_released
write.csv(count_year_released, "count_year_released.csv", row.names = FALSE)

# games sold in region every year
count_region_year <- select(vgsales,-c(1:3,5:6))

count_region_year <- count_region_year %>%
  group_by(Year) %>% summarise_all(sum)

write.csv(count_region_year, "count_region_year.csv", row.names = FALSE)

# games sold by publishers globally
count_publishers_sales <- vgsales %>% group_by(Publisher) %>% summarise(Sales = sum(Global_Sales))
count_publishers_sales <- count_publishers_sales %>% 
  arrange(desc(Sales)) %>% 
  top_n(20)
write.csv(count_publishers_sales, "count_publishers_sales.csv", row.names = FALSE)

#most sold games
count_games <- vgsales %>% arrange(desc(Global_Sales)) %>% top_n(20)
count_games
write.csv(count_games, "count_games.csv", row.names = FALSE)

