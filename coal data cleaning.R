#import the library
library(tidyverse)

#import the file
coal <- read_csv('http://594442.youcanlearnit.net/coal.csv')
coal <- read_csv('http://594442.youcanlearnit.net/coal.csv', skip = 2)
glimpse(coal)
#change 1st column name
colnames(coal)[1] <- 'region'
summary(coal)

#simplify the column
coal_long <- gather(coal, 'year', 'coal_comsumtion', -region)

#channge data type of year and coal_comsumtion
coal_long$year <- as.integer(coal_long$year)
coal_long$coal_comsumtion <- as.numeric(coal_long$coal_comsumtion)
head(coal_long)

#check the unuque value
unique(coal_long$region)

#separate country and non-country
noncountries <- c("North America", "Central & South America", "Antartica", 'Europe', 
                'Eurasia', 'Middle East', 'Africa', 'Asia & Oceania')

matches <- which(!is.na(match(coal_long$region, noncountries)))

coal_country <- coal_long[-matches,colnames('world', NULL)]
coal_region <- coal_long[matches,]

unique(coal_country$region)
unique(coal_region$region)

#visualize the data
ggplot(data=coal_region, mapping=aes(x=year, y=coal_comsumtion)) +
  geom_line(mapping=aes(color=region))


