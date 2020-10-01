library(tidyr)
library(dplyr)
library(rgdal)


#Read Massachusetts health data to dataframe
health <- read.csv("health.csv")

#Read Massachusetts counties geojson to dataframe
mass_counties <- readOGR("Massachusetts_Counties.geojson")

#Check data in geojson dataframe
head(mass_counties@data)

#Remove redundant columns from health dataframe
health <- select(health, -c("ID.Year", "ID.Geography", "Slug.Geography"))

#Group health dataframe by Geography
health %>% group_by(Geography)

#Reshape health dataframe to have diabetes prevalence of counties for each year
health <- reshape(health, direction = "wide", idvar = "Geography", timevar = "Year")
names(health) <- gsub("Diabetes.Prevalence.", "", names(health)) 

#Add index to health dataframe which will be used to dataframes
health <- health %>% arrange(Geography) %>%
  mutate(id = row_number())

#Merge dataframes into geojson dataframe
mass_counties@data <- merge(mass_counties@data, health, by.x = "OBJECTID", by.y = "id")

#Write geojson dataframe to gejson file
writeOGR(mass_counties, "mass_counties_merged.geojson", "mass_counties", "GeoJSON")
