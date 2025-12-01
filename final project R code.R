## Loading necessary packages
library(tidyverse)
library(ggplot2)

## Loading and cleaning data
bike_2019_jan = read_csv("2019/JC-201901-citibike-tripdata.csv") |> 
  janitor::clean_names() |> 
  select(
    -start_station_id, -end_station_id, -bikeid, -starttime, -stoptime
  ) |> 
  mutate(
    gender = as.factor(gender)
  )
