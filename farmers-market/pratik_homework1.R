# The directory of farmers market across the US is given in the file fm.csv.  Answer the following questions from the dataset

fm <- read.csv("fm.csv")
library(tidyr)
library(dplyr)

# 1. Write a code to compute the number of farmers markets by state and arrange them in descending order of number of farmers market. (20 points)

count_state <- fm %>% count(State) %>% 
  arrange(desc(n))

count_state

# 2. Write a code to compute the number of farmers market by cities in Massachusetts and display top five cities. (20 points)

count_mass <- fm %>% count(State,city) %>% 
  filter(State == "Massachusetts") %>% 
  arrange(desc(n)) %>% 
  top_n(5)

count_mass

# 3. Generate the following table using pivot function. First column should contain the states. Second column should have Payment System. For Payment System consider the columns, “Credit”, “WIC”, “WICcash”, and “SNAP” from the original farmers market data. Third column should have the number of farmers market offering the payment services. (40 points)

count_payment <- fm %>% 
  pivot_longer(cols = c("Credit", "WIC", "WICcash", "SNAP"),
               names_to = "PaymentSystem",
               values_to = "FarmersMarket") %>% 
  count(State, PaymentSystem, FarmersMarket) %>% 
  filter(FarmersMarket == "Y") %>% 
  rename(No.FarmersMarket = n)

select(count_payment, -FarmersMarket)

# 4. Create two new columns and add the columns to the farmers market dataframe. The first column should be named “Startdate” and the second column must be name “Enddate”. The Season1Date column has most entries of the form “05/05/2015 to 10/27/2015”. Split the date entries of Season1Date and allocate the first value to Startdate and the second value to Enddate. (20 points)

separate(fm,Season1Date, c("StartDate","EndDate"), sep = "to")
