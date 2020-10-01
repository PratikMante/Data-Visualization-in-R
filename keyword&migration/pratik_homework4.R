library(tidyr)
library(dplyr)
library(readxl)
library(igraph)
library(reshape2)



# Question 1

setwd("/Users/pratikmante/Documents/Data Visualization")

#Stack dataset and drop na
keys1 <- stack(keyword) %>% 
  drop_na()

#find keywords and assign matrix, row names and col names
keys <- unique(keys1$values)
val <- matrix(0,248,248)
colnames(val) <- keys
rownames(val) <- keys

#function to create adjacency matrix
for (i in 1:12) {
  keywordmatrix <- unlist(keyword[i,])
  keywordmatrix <-keywordmatrix[!is.na(keywordmatrix)]
  combination <- combn(keywordmatrix,2)
  for(j in 1:length(combination[1,])) {
    row_var <- which(rownames(val) == combination[1,j])
    col_var <- which(colnames(val) == combination[2,j])
    val[row_var,col_var] <- val[row_var,col_var] + 1
    val[col_var,row_var] <- val[col_var,row_var] + 1
  }
}

#convert matrix to graph
network_adj <- graph_from_adjacency_matrix(
  val,
  mode = c("undirected"),
  weighted = TRUE
)

#write to files
from_adjacency( )
link=get.data.frame(network_adj)
write.csv(link,"link.csv")
write.csv(data.frame(keys),"node.csv")
network_adj <- graph_from_adjacency_matrix(val,mode = "undirected",weighted = TRUE)
degr <- degree(network_adj)
degr <- as.data.frame(degr)
write.csv(degr,"degree.csv")




# Question 2 
# For this question, first few rows containing information like UN logo and UN information have been removed directly from excel.
# Column name has also been changed to "destination", as the given sheet column had multiple values in the column name.
# After writing to file, ".." was replaced by 0 in sheet.
# Above operations were done directly in excel.

#Read Excel file to dataframe
migrate <- read_excel("UN_MigrantStockByOriginAndDestination_2017.xlsx", sheet = 2)
migrate

#Filter destination by United States of America
migrate <- migrate %>% filter(destination == "United States of America")

#Reshape dataframe to have column sources
migrate <- migrate %>% gather(Source, Count, Afghanistan:Zimbabwe) %>%
  group_by(year)

#Write to CSV file
write.csv(migrate,"migrate.csv",row.names = FALSE)



