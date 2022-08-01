## Cyclicist Data from jul 2021 to jun 2022
install.packages("tidyverse")
install.packages("janitor")
install.packages("skimr")
install.packages("rtools")
library("tidyverse")
library("data.table")
library("tidyr")
library("dplyr")
library("janitor")
library("skimr")

##

jul_21 <- read.csv("C:/Users/bicha/OneDrive/Desktop/dacs1/dacs1_unzipped_csv/202107-divvy-tripdata.csv")
aug_21 <- read.csv("C:/Users/bicha/OneDrive/Desktop/dacs1/dacs1_unzipped_csv/202108-divvy-tripdata.csv")
sep_21 <- read.csv("C:/Users/bicha/OneDrive/Desktop/dacs1/dacs1_unzipped_csv/202109-divvy-tripdata.csv")
oct_21 <- read.csv("C:/Users/bicha/OneDrive/Desktop/dacs1/dacs1_unzipped_csv/202110-divvy-tripdata.csv")
nov_21 <- read.csv("C:/Users/bicha/OneDrive/Desktop/dacs1/dacs1_unzipped_csv/202111-divvy-tripdata.csv")
dec_21 <- read.csv("C:/Users/bicha/OneDrive/Desktop/dacs1/dacs1_unzipped_csv/202112-divvy-tripdata.csv")
jan_22 <- read.csv("C:/Users/bicha/OneDrive/Desktop/dacs1/dacs1_unzipped_csv/202201-divvy-tripdata.csv")
feb_22 <- read.csv("C:/Users/bicha/OneDrive/Desktop/dacs1/dacs1_unzipped_csv/202202-divvy-tripdata.csv")
mar_22 <- read.csv("C:/Users/bicha/OneDrive/Desktop/dacs1/dacs1_unzipped_csv/202203-divvy-tripdata.csv")
apr_22 <- read.csv("C:/Users/bicha/OneDrive/Desktop/dacs1/dacs1_unzipped_csv/202204-divvy-tripdata.csv")
may_22 <- read.csv("C:/Users/bicha/OneDrive/Desktop/dacs1/dacs1_unzipped_csv/202205-divvy-tripdata.csv")
jun_22 <- read.csv("C:/Users/bicha/OneDrive/Desktop/dacs1/dacs1_unzipped_csv/202206-divvy-tripdata.csv")

##

str(jul_21)
compare_df_cols(jul_21,aug_21,sep_21,oct_21,nov_21,dec_21,jan_22,feb_22,mar_22,apr_22,may_22,jun_22)
combined_data <- rbind(jul_21,aug_21,sep_21,oct_21,nov_21,dec_21,jan_22,feb_22,mar_22,apr_22,may_22,jun_22)
combined_data$started_at = strptime(combined_data$started_at , "%Y-%m-%d %H:%M:%S")
combined_data$ended_at = strptime(combined_data$ended_at , "%Y-%m-%d %H:%M:%S")
str(combined_data)

## Accuracy of data

combined_data <- mutate(combined_data, trip_duration=difftime(ended_at,started_at,units = "secs"))
combined_data <- mutate(combined_data,day_of_week = weekdays(started_at))
filter(combined_data,trip_duration < 0)

## Cleaning dataset
##remove trips with negative time difference
combined_data <- mutate(combined_data, trip_duration = as.numeric(trip_duration))
combined_data <- filter(combined_data,trip_duration > 0)

## remove incomplete rows
combined_data <- combined_data %>%
  filter(
    !(is.na(start_station_name) |
        start_station_name == "")
  ) %>% 
  
  filter(
    !(is.na(end_station_name) |
        end_station_name == "")
  )
## year
combined_data$year <- format(
  combined_data$started_at, 
  "%Y"
)

## month
combined_data$monthr <- format(
  combined_data$started_at, 
  "%m"
)




write.csv(combined_data , "C:\\Users\\bicha\\OneDrive\\Desktop\\dacs1\\jul21_jun22_data.csv" , row.names = FALSE)











