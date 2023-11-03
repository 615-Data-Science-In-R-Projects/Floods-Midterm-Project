library(tidyverse)
library(readr)

storms<- read_csv("StormEvents_details_2021.csv")

floods<- storms |> filter(str_detect(EVENT_TYPE,"Flood")==TRUE)

fema<- read_csv("DisasterDeclarationsSummaries.csv")
fema_floods<- fema |> filter(str_detect(incidentType, "Flood")==TRUE) |> 
                  filter(str_detect(incidentBeginDate,"2021")==TRUE)

fema_assistance<- read.csv("FemaWebDisasterSummaries.csv", header = TRUE) 
#|> 
 # filter(str_detect(paLoadDate,"2021")==TRUE)

fema_combined<- left_join(x=fema_floods,y=fema_assistance, by="disasterNumber")

