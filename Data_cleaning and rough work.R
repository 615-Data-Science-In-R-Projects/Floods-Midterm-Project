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

census1_2020<- read.csv("Census Download_2023-10-23T135225/ACSST5Y2020.S1701-Data.csv")
census1_metadata<- read.csv("Census Download_2023-10-23T135225/ACSST5Y2020.S1701-Column-Metadata.csv")

census1_2021<- read.csv("Census Download_2023-10-23T140147/ACSDT5Y2021.B25001-Data.csv")

census1_estimates_2020<- census1_2020 |>
        select(colnames(census1_2020)[which(str_sub(colnames(census1_2020),-1,-1)=="E" |
                                         str_sub(colnames(census1_2020),-1,-1)=="M")])

census1_estimates_2021<- census1_2021 |>
  select(colnames(census1_2021)[which(str_sub(colnames(census1_2021),-1,-1)=="E" |
                                        str_sub(colnames(census1_2021),-1,-1)=="M")])

census1_metadata_estimates<- census1_metadata |>filter(
         str_sub(Column.Name,-1,-1)=="E"| str_sub(Column.Name,-1,-1)=="M")


census2_2020<- read.csv("Census Download_2023-10-23T140133/ACSDP5Y2020.DP05-Data.csv")
census2_metadata<- read.csv("Census Download_2023-10-23T140133/ACSDP5Y2020.DP05-Column-Metadata.csv")

census3_2020<- read.csv("Census Download_2023-10-23T140147/ACSDT5Y2020.B25001-Data.csv")
census3_metadata<- read.csv("Census Download_2023-10-23T140147/ACSDT5Y2020.B25001-Column-Metadata.csv")


colnames(census1_estimates_2020)<- census1_estimates_2020[1,]
colnames(census1_estimates_2021)<- census1_estimates_2021[1,]

col_names<- colnames(census_poverty_data)

col_names<- str_replace_all(col_names,"!!", " ")
col_names<- str_replace_all(col_names,"Total Population for whom poverty status is determined",
                                       "Total Population")

col_names<- str_replace_all(col_names,"Population for whom poverty status is determined",
                            "")

col_names<- ifelse(str_detect(col_names,"AGE")==TRUE,str_replace(col_names,
  "Population for whom poverty status is determined AGE", "AGE"),col_names)
col_names_frame<- data.frame(col_names)[,2]

#Replacing age sub-categorizations because they're redundant
col_names<-ifelse(str_detect(col_names,"Under 18 years")==TRUE,
                  str_replace(col_names,"Under 18 years",""),
                  ifelse(str_detect(col_names,"18 to 64 years")==TRUE,
                         str_replace(col_names,"18 to 64 years","" ),
                  col_names))

col_names<- str_replace(col_names,"RACE AND HISPANIC OR LATINO ORIGIN", "RACE")
col_names<- str_replace(col_names,
    "UNRELATED INDIVIDUALS FOR WHOM POVERTY STATUS IS DETERMINED", "UNRELATED INDIVIDUALS")
col_names<- str_replace(col_names,"Population 25 years and over","")
col_names<- str_replace(col_names,"Civilian labor force 16 years and over","")
