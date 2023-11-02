library(janeaustenr)
library(tidyverse)
original_books <- austen_books() |> group_by(books)
library(readr)

storms<- read_csv("Downloads/StormEvents_locations-ftp_v1.0_d2021_c20231017.csv")

storms |> filter(LOCATION=="HOT COFFEE")

storms<-read_csv("Downloads/StormEvents_details-ftp_v1.0_d2021_c20231017.csv")

hotcoffee<-storms |>  filter(BEGIN_LOCATION=="HOT COFFEE")

floods<- storms |> filter(str_detect(EVENT_TYPE,"Flood")==TRUE)

fema<- read_csv("DisasterDeclarationsSummaries.csv")
fema_floods<- fema |> filter(str_detect(incidentType, "Flood")==TRUE) |> 
                  filter(str_detect(incidentBeginDate,"2021")==TRUE)

