library(readr)
library(tidyverse)
library(dplyr)
library(ggplot2)
library(leaflet)
library(crosstalk)
library(rvest)
library(httr)
library(plotly)


data <- read.csv("data/bike_data_combined.csv")

map_data <- data |>
  select(
    month,
    year,
    start_latitude = start_station_latitude, 
    start_longitude = start_station_longitude,
    end_latitude = end_station_latitude, 
    end_longitude = end_station_longitude) |>
  filter(start_longitude < -74.02, end_longitude < -74.02)

station_counts <- map_data |>
  group_by(end_latitude, end_longitude) |>
  summarise(
    n_trips = n(),
    .groups = "drop"
  )


bins <- quantile(station_counts$n_trips,
                 probs = seq(0, 1, length.out = 6),
                 na.rm = TRUE)

pal <- colorBin(
  palette = c("green", "yellow", "orange", "red", "darkred"),
  domain  = station_counts$n_trips,
  bins    = bins,
  pretty  = FALSE
)

leaflet(station_counts) |>
  addTiles() |>
  setView(lng = -74.006, lat = 40.7128, zoom = 11) |>
  addCircleMarkers(
    ~end_longitude, ~end_latitude,
    radius      = 12,
    stroke      = FALSE,
    fillColor   = ~pal(n_trips),
    fillOpacity = 0.8,
    label       = ~as.character(n_trips),
    labelOptions = labelOptions(
      direction = "top",
      offset    = c(0, -5),
      textsize  = "10px"
    )
  )