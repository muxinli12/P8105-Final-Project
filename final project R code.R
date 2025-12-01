## Loading necessary packages
library(tidyverse)
library(ggplot2)

## Loading and cleaning data for 2019 ones
bike_files_info = tibble(
  month_code = sprintf("%02d", 1:12),
  month_name = c(
    "Jan", "Feb", "Mar", "Apr", "May", "Jun",
    "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"
  )) |> 
  mutate(
    file_path = paste0("2019/JC-2019", month_code, "-citibike-tripdata.csv")
  )

process_bike_data =
  function(file_path, month_name) {
  if (!file.exists(file_path)) {
    warning(paste("file does not exist, skipped：", file_path))
    return(NULL)
  }
  
  data =
    read_csv(file_path) |>
    janitor::clean_names() |>
    select(
      -start_station_id, -end_station_id, -bikeid, -starttime, -stoptime
    ) |>
    mutate(
      gender = as.factor(gender),
      month = month_name
    )
  
  return(data)
}

list_of_bike_data =
  bike_files_info |>
  select(file_path, month_name) |>
  purrr::pmap(.f = process_bike_data)

all_bike_data_2019 =
  bind_rows(list_of_bike_data)

## Loading and cleaning data for 2020 ones
bike_files_info = tibble(
  month_code = sprintf("%02d", 1:12),
  month_name = c(
    "Jan", "Feb", "Mar", "Apr", "May", "Jun",
    "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"
  )) |> 
  mutate(
    file_path = paste0("2020/JC-2020", month_code, "-citibike-tripdata.csv")
  )

process_bike_data =
  function(file_path, month_name) {
    if (!file.exists(file_path)) {
      warning(paste("file does not exist, skipped：", file_path))
      return(NULL)
    }
    
    data =
      read_csv(file_path) |>
      janitor::clean_names() |>
      select(
        -start_station_id, -end_station_id, -bikeid, -starttime, -stoptime
      ) |>
      mutate(
        gender = as.factor(gender),
        month = month_name
      )
    
    return(data)
  }

list_of_bike_data =
  bike_files_info |>
  select(file_path, month_name) |>
  purrr::pmap(.f = process_bike_data)

all_bike_data_2020 =
  bind_rows(list_of_bike_data)
