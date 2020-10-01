library(tidyr)
library(dplyr)

# Question 1 ---------------------------------


# Read boston crime data to dataframe
bcd <- read.csv("boston_crime_data.csv")

# Count number of crimes as per group of district & month to dataframe
count_records <- bcd %>% count(DISTRICT,MONTH)

# Create subset dataframe whch has no districts as NA and External
count_records <- subset(count_records, DISTRICT != "External")
count_records <- subset(count_records, DISTRICT != "")

# Write dataframe to CSV
write.csv(count_records, "bcd.csv", row.names = FALSE)

#Embed Link:
# <div class="flourish-embed flourish-chart" data-src="visualisation/2463719" data-url="https://flo.uri.sh/visualisation/2463719/embed"><script src="https://public.flourish.studio/resources/embed.js"></script></div>

#Visualisation Link:
# https://public.flourish.studio/visualisation/2463719/

# Question 2 --------------------------------


# Read global mobility report to dataframe
gmr <- read.csv("Global_Mobility_Report.csv")

# Filter by US to dataframe
mobility_us <- gmr %>% filter(country_region_code == "US")

# Groupby date
mobility <- group_by(mobility_us, date)

# Calculate mean for the dataframe
covid <- summarise(mobility, 
          retail_and_recreation_percent_change_from_baseline = mean(retail_and_recreation_percent_change_from_baseline, na.rm = TRUE),
          grocery_and_pharmacy_percent_change_from_baseline = mean(grocery_and_pharmacy_percent_change_from_baseline, na.rm = TRUE),
          parks_percent_change_from_baseline = mean(parks_percent_change_from_baseline, na.rm = TRUE),
          transit_stations_percent_change_from_baseline = mean(transit_stations_percent_change_from_baseline, na.rm = TRUE),
          workplaces_percent_change_from_baseline = mean(workplaces_percent_change_from_baseline, na.rm = TRUE), 
          residential_percent_change_from_baseline = mean(residential_percent_change_from_baseline, na.rm = TRUE))

# Write dataframe to CSV
write.csv(covid, "us_covid.csv", row.names = FALSE)

#Embed Link:
# <div class="flourish-embed flourish-chart" data-src="visualisation/2414565" data-url="https://flo.uri.sh/visualisation/2414565/embed"><script src="https://public.flourish.studio/resources/embed.js"></script></div>

#Visualisation Link:
# https://public.flourish.studio/visualisation/2414565/

# Question 3 ------------------------------------

#Embed Link:
# <div class="flourish-embed flourish-table" data-src="visualisation/2420034" data-url="https://flo.uri.sh/visualisation/2420034/embed"><script src="https://public.flourish.studio/resources/embed.js"></script></div>

#Visualisation Link:
# https://public.flourish.studio/visualisation/2420034/



















