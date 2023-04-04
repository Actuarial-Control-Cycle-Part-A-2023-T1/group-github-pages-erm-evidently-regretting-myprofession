library("readxl")
library("dplyr")
library("statmod")
library("gamlss")
library("gamlss.dist")
library("tweedie")


#for sim
simtemp<-read.csv("SimTemplate.csv")
SimL_p<-simtemp
SimM_p<-simtemp
SimH_p<-simtemp
SimVH_p<-simtemp
SimL<-simtemp
SimM<-simtemp
SimH<-simtemp
SimVH<-simtemp

####Severity Model####
HistoricalData <- read_excel("HistoricalData1991pos.xlsx") 

###Data Cleaning###
HistoricalData<-HistoricalData[,-11]
colnames(HistoricalData)[2] <- "HazardEvent"
colnames(HistoricalData)[5] <- "Duration"
colnames(HistoricalData)[8] <- "HazardCategory"
colnames(HistoricalData)[9] <- "2021Cost"

HistoricalData$Region <- as.factor(HistoricalData$Region)
HistoricalData$Quarter <- as.factor(HistoricalData$Quarter)
HistoricalData$HazardCategory <- as.factor(HistoricalData$HazardCategory)

HistoricalData<-HistoricalData %>%
  filter(HazardCategory!="other") %>%
  filter(HazardCategory!="Other") %>%
  filter(Year>1990)

HistoricalData<- na.omit(HistoricalData)

#Gamma
model_gam <- glm(log(`2021Cost`) ~  Region + Quarter + HazardCategory + MajMedMin 
                 , family = Gamma(link=identity), data = HistoricalData)

#### FREQUENCY MODEL ####
#Data cleaning
data <- read_excel("Model Inputs Pos.xlsx") 
df.data<-as.data.frame(data)
df.data$Region<-as.factor(df.data$Region)
df.data$Quarter<-as.factor(df.data$Quarter)
df.data$`Hazard Type` <- as.factor(df.data$`Hazard Type`)
colnames(df.data)[5]<-c("HazardCategory")

#Calculating expectations per city type
cityprop<-read_excel("CityDisasterProp.xlsx") 

cityexpect_minor<-mapply(`*`,as.data.frame(cityprop[1,2:4]),as.data.frame(df.data$`Minor Expectation`))
cityexpect_minor<-as.data.frame(cityexpect_minor)
colnames(cityexpect_minor)<-c("Minor-High","Minor-Med","Minor-Low") #formatted "Disastertype-CityRisk"

cityexpect_medium<-mapply(`*`,as.data.frame(cityprop[2,2:4]),as.data.frame(df.data$`Medium Expectation`))
cityexpect_medium<-as.data.frame(cityexpect_medium)
colnames(cityexpect_medium)<-c("Medium-High","Medium-Med","Medium-Low")

cityexpect_major<-mapply(`*`,as.data.frame(cityprop[3,2:4]),as.data.frame(df.data$`Major Expectation`))
cityexpect_major<-as.data.frame(cityexpect_major)
colnames(cityexpect_major)<-c("Major-High","Major-Med","Major-Low")

df.data[,colnames(cityexpect_minor)]<-cityexpect_minor
df.data[,colnames(cityexpect_medium)]<-cityexpect_medium
df.data[,colnames(cityexpect_major)]<-cityexpect_major

df.data<-df.data[,-6:-8]



l<-0
for (l in 1:1000){

###Poisson Model for each disaster per region per year/quarter###

#Low Emissions
Low_Data<-df.data %>%
  filter(Emissions=="Low")

Low_Freq_Sim<-Low_Data
Low_Freq_Sim$`Minor-High`<-rep(0,nrow(Low_Data))
Low_Freq_Sim$`Minor-Med`<-rep(0,nrow(Low_Data))
Low_Freq_Sim$`Minor-Low`<-rep(0,nrow(Low_Data))
Low_Freq_Sim$`Medium-High`<-rep(0,nrow(Low_Data))
Low_Freq_Sim$`Medium-Med`<-rep(0,nrow(Low_Data))
Low_Freq_Sim$`Medium-Low`<-rep(0,nrow(Low_Data))
Low_Freq_Sim$`Major-High`<-rep(0,nrow(Low_Data))
Low_Freq_Sim$`Major-Med`<-rep(0,nrow(Low_Data))
Low_Freq_Sim$`Major-Low`<-rep(0,nrow(Low_Data))

i<-1
for (i in 1:nrow(Low_Freq_Sim)){
  Low_Freq_Sim[i,6]<-rpois(1,Low_Data[i,6])
  Low_Freq_Sim[i,7]<-rpois(1,Low_Data[i,7])
  Low_Freq_Sim[i,8]<-rpois(1,Low_Data[i,8])
  Low_Freq_Sim[i,9]<-rpois(1,Low_Data[i,9])
  Low_Freq_Sim[i,10]<-rpois(1,Low_Data[i,10])
  Low_Freq_Sim[i,11]<-rpois(1,Low_Data[i,11])
  Low_Freq_Sim[i,12]<-rpois(1,Low_Data[i,12])
  Low_Freq_Sim[i,13]<-rpois(1,Low_Data[i,13])
  Low_Freq_Sim[i,14]<-rpois(1,Low_Data[i,14])
}


#Medium Emissions
Med_Data<-df.data %>%
  filter(Emissions=="Medium")

Med_Freq_Sim<-Med_Data
Med_Freq_Sim$`Minor-High`<-rep(0,nrow(Med_Data))
Med_Freq_Sim$`Minor-Med`<-rep(0,nrow(Med_Data))
Med_Freq_Sim$`Minor-Low`<-rep(0,nrow(Med_Data))
Med_Freq_Sim$`Medium-High`<-rep(0,nrow(Med_Data))
Med_Freq_Sim$`Medium-Med`<-rep(0,nrow(Med_Data))
Med_Freq_Sim$`Medium-Low`<-rep(0,nrow(Med_Data))
Med_Freq_Sim$`Major-High`<-rep(0,nrow(Med_Data))
Med_Freq_Sim$`Major-Med`<-rep(0,nrow(Med_Data))
Med_Freq_Sim$`Major-Low`<-rep(0,nrow(Med_Data))

i<-1
for (i in 1:nrow(Med_Freq_Sim)){
  Med_Freq_Sim[i,6]<-rpois(1,Med_Data[i,6])
  Med_Freq_Sim[i,7]<-rpois(1,Med_Data[i,7])
  Med_Freq_Sim[i,8]<-rpois(1,Med_Data[i,8])
  Med_Freq_Sim[i,9]<-rpois(1,Med_Data[i,9])
  Med_Freq_Sim[i,10]<-rpois(1,Med_Data[i,10])
  Med_Freq_Sim[i,11]<-rpois(1,Med_Data[i,11])
  Med_Freq_Sim[i,12]<-rpois(1,Med_Data[i,12])
  Med_Freq_Sim[i,13]<-rpois(1,Med_Data[i,13])
  Med_Freq_Sim[i,14]<-rpois(1,Med_Data[i,14])
}

#High Emissions
High_Data<-df.data %>%
  filter(Emissions=="High")

High_Freq_Sim<-High_Data
High_Freq_Sim$`Minor-High`<-rep(0,nrow(High_Data))
High_Freq_Sim$`Minor-Med`<-rep(0,nrow(High_Data))
High_Freq_Sim$`Minor-Low`<-rep(0,nrow(High_Data))
High_Freq_Sim$`Medium-High`<-rep(0,nrow(High_Data))
High_Freq_Sim$`Medium-Med`<-rep(0,nrow(High_Data))
High_Freq_Sim$`Medium-Low`<-rep(0,nrow(High_Data))
High_Freq_Sim$`Major-High`<-rep(0,nrow(High_Data))
High_Freq_Sim$`Major-Med`<-rep(0,nrow(High_Data))
High_Freq_Sim$`Major-Low`<-rep(0,nrow(High_Data))

i<-1
for (i in 1:nrow(High_Freq_Sim)){
  High_Freq_Sim[i,6]<-rpois(1,High_Data[i,6])
  High_Freq_Sim[i,7]<-rpois(1,High_Data[i,7])
  High_Freq_Sim[i,8]<-rpois(1,High_Data[i,8])
  High_Freq_Sim[i,9]<-rpois(1,High_Data[i,9])
  High_Freq_Sim[i,10]<-rpois(1,High_Data[i,10])
  High_Freq_Sim[i,11]<-rpois(1,High_Data[i,11])
  High_Freq_Sim[i,12]<-rpois(1,High_Data[i,12])
  High_Freq_Sim[i,13]<-rpois(1,High_Data[i,13])
  High_Freq_Sim[i,14]<-rpois(1,High_Data[i,14])
}

#Very High Emissions
VHigh_Data<-df.data %>%
  filter(Emissions=="Very High")

VHigh_Freq_Sim<-VHigh_Data
VHigh_Freq_Sim$`Minor-High`<-rep(0,nrow(VHigh_Data))
VHigh_Freq_Sim$`Minor-Med`<-rep(0,nrow(VHigh_Data))
VHigh_Freq_Sim$`Minor-Low`<-rep(0,nrow(VHigh_Data))
VHigh_Freq_Sim$`Medium-High`<-rep(0,nrow(VHigh_Data))
VHigh_Freq_Sim$`Medium-Med`<-rep(0,nrow(VHigh_Data))
VHigh_Freq_Sim$`Medium-Low`<-rep(0,nrow(VHigh_Data))
VHigh_Freq_Sim$`Major-High`<-rep(0,nrow(VHigh_Data))
VHigh_Freq_Sim$`Major-Med`<-rep(0,nrow(VHigh_Data))
VHigh_Freq_Sim$`Major-Low`<-rep(0,nrow(VHigh_Data))

i<-1
for (i in 1:nrow(VHigh_Freq_Sim)){
  VHigh_Freq_Sim[i,6]<-rpois(1,VHigh_Data[i,6])
  VHigh_Freq_Sim[i,7]<-rpois(1,VHigh_Data[i,7])
  VHigh_Freq_Sim[i,8]<-rpois(1,VHigh_Data[i,8])
  VHigh_Freq_Sim[i,9]<-rpois(1,VHigh_Data[i,9])
  VHigh_Freq_Sim[i,10]<-rpois(1,VHigh_Data[i,10])
  VHigh_Freq_Sim[i,11]<-rpois(1,VHigh_Data[i,11])
  VHigh_Freq_Sim[i,12]<-rpois(1,VHigh_Data[i,12])
  VHigh_Freq_Sim[i,13]<-rpois(1,VHigh_Data[i,13])
  VHigh_Freq_Sim[i,14]<-rpois(1,VHigh_Data[i,14])
}

##Data Cleaning for use in Severity Model

#adding MajMedMin Variable
Low_Freq_Sim_Minor<-Low_Freq_Sim[,1:8]
Low_Freq_Sim_Minor$MajMedMin<-as.factor("Minor")
colnames(Low_Freq_Sim_Minor)[6:8]<-c("High","Med","Low")

Low_Freq_Sim_Med<-Low_Freq_Sim[,-6:-8]
Low_Freq_Sim_Med<-Low_Freq_Sim_Med[,-9:-11]
Low_Freq_Sim_Med$MajMedMin<-as.factor("Medium")
colnames(Low_Freq_Sim_Med)[6:8]<-c("High","Med","Low")

Low_Freq_Sim_High<-Low_Freq_Sim[,-6:-11]
Low_Freq_Sim_High$MajMedMin<-as.factor("Major")
colnames(Low_Freq_Sim_High)[6:8]<-c("High","Med","Low")

Low_Freq_Sim <- rbind(Low_Freq_Sim_Minor,Low_Freq_Sim_Med)
Low_Freq_Sim <- rbind(Low_Freq_Sim, Low_Freq_Sim_High)

Med_Freq_Sim_Minor<-Med_Freq_Sim[,1:8]
Med_Freq_Sim_Minor$MajMedMin<-as.factor("Minor")
colnames(Med_Freq_Sim_Minor)[6:8]<-c("High","Med","Low")

Med_Freq_Sim_Med<-Med_Freq_Sim[,-6:-8]
Med_Freq_Sim_Med<-Med_Freq_Sim_Med[,-9:-11]
Med_Freq_Sim_Med$MajMedMin<-as.factor("Medium")
colnames(Med_Freq_Sim_Med)[6:8]<-c("High","Med","Low")

Med_Freq_Sim_High<-Med_Freq_Sim[,-6:-11]
Med_Freq_Sim_High$MajMedMin<-as.factor("Major")
colnames(Med_Freq_Sim_High)[6:8]<-c("High","Med","Low")

Med_Freq_Sim <- rbind(Med_Freq_Sim_Minor,Med_Freq_Sim_Med)
Med_Freq_Sim <- rbind(Med_Freq_Sim, Med_Freq_Sim_High)

High_Freq_Sim_Minor<-High_Freq_Sim[,1:8]
High_Freq_Sim_Minor$MajMedMin<-as.factor("Minor")
colnames(High_Freq_Sim_Minor)[6:8]<-c("High","Med","Low")

High_Freq_Sim_Med<-High_Freq_Sim[,-6:-8]
High_Freq_Sim_Med<-High_Freq_Sim_Med[,-9:-11]
High_Freq_Sim_Med$MajMedMin<-as.factor("Medium")
colnames(High_Freq_Sim_Med)[6:8]<-c("High","Med","Low")

High_Freq_Sim_High<-High_Freq_Sim[,-6:-11]
High_Freq_Sim_High$MajMedMin<-as.factor("Major")
colnames(High_Freq_Sim_High)[6:8]<-c("High","Med","Low")

High_Freq_Sim <- rbind(High_Freq_Sim_Minor,High_Freq_Sim_Med)
High_Freq_Sim <- rbind(High_Freq_Sim, High_Freq_Sim_High)

VHigh_Freq_Sim_Minor<-VHigh_Freq_Sim[,1:8]
VHigh_Freq_Sim_Minor$MajMedMin<-as.factor("Minor")
colnames(VHigh_Freq_Sim_Minor)[6:8]<-c("High","Med","Low")

VHigh_Freq_Sim_Med<-VHigh_Freq_Sim[,-6:-8]
VHigh_Freq_Sim_Med<-VHigh_Freq_Sim_Med[,-9:-11]
VHigh_Freq_Sim_Med$MajMedMin<-as.factor("Medium")
colnames(VHigh_Freq_Sim_Med)[6:8]<-c("High","Med","Low")

VHigh_Freq_Sim_High<-VHigh_Freq_Sim[,-6:-11]
VHigh_Freq_Sim_High$MajMedMin<-as.factor("Major")
colnames(VHigh_Freq_Sim_High)[6:8]<-c("High","Med","Low")

VHigh_Freq_Sim <- rbind(VHigh_Freq_Sim_Minor,VHigh_Freq_Sim_Med)
VHigh_Freq_Sim <- rbind(VHigh_Freq_Sim, VHigh_Freq_Sim_High)

#Organizing data by consecutive year/quarter
Low_Freq_Sim <- Low_Freq_Sim %>%
  arrange(Quarter) %>%
  arrange(Year)

Med_Freq_Sim <- Med_Freq_Sim %>%
  arrange(Quarter) %>%
  arrange(Year)

High_Freq_Sim <- High_Freq_Sim %>%
  arrange(Quarter) %>%
  arrange(Year)

VHigh_Freq_Sim <- VHigh_Freq_Sim %>%
  arrange(Quarter) %>%
  arrange(Year)


####Severity Model predictions####
#Cost Predictions per disaster
Low_Freq_Sim$PredCost <- exp(predict(model_gam, Low_Freq_Sim))
Med_Freq_Sim$PredCost <- exp(predict(model_gam, Med_Freq_Sim))
High_Freq_Sim$PredCost <- exp(predict(model_gam, High_Freq_Sim))
VHigh_Freq_Sim$PredCost <- exp(predict(model_gam, VHigh_Freq_Sim))

#Overall disaster costs per city risk profile 
Low_Disaster_Cost<-Low_Freq_Sim %>%
  mutate(HighCost=High*PredCost) %>%
  mutate(MedCost=Med*PredCost) %>%
  mutate(LowCost=Low*PredCost)
Low_Disaster_Cost<-Low_Disaster_Cost[,-10]

Med_Disaster_Cost<-Med_Freq_Sim %>%
  mutate(HighCost=High*PredCost) %>%
  mutate(MedCost=Med*PredCost) %>%
  mutate(LowCost=Low*PredCost)
Med_Disaster_Cost<-Med_Disaster_Cost[,-10]

High_Disaster_Cost<-High_Freq_Sim %>%
  mutate(HighCost=High*PredCost) %>%
  mutate(MedCost=Med*PredCost) %>%
  mutate(LowCost=Low*PredCost)
High_Disaster_Cost<-High_Disaster_Cost[,-10]

VHigh_Disaster_Cost<-VHigh_Freq_Sim %>%
  mutate(HighCost=High*PredCost) %>%
  mutate(MedCost=Med*PredCost) %>%
  mutate(LowCost=Low*PredCost)
VHigh_Disaster_Cost<-VHigh_Disaster_Cost[,-10]

##Demand Surge Costs
#Proportion Sim
Low_Disaster_Cost_DMa<- Low_Disaster_Cost %>% 
  filter(MajMedMin=="Major") %>%
  mutate(DemandSurge=runif(sum(Low_Disaster_Cost$MajMedMin=="Major"),0.35,0.5))

Low_Disaster_Cost_DMe<- Low_Disaster_Cost %>% 
  filter(MajMedMin=="Medium") %>%
  mutate(DemandSurge=runif(sum(Low_Disaster_Cost$MajMedMin=="Medium"),0.15,0.35)) 

Low_Disaster_Cost_DMi<- Low_Disaster_Cost %>% 
  filter(MajMedMin=="Minor") %>%
  mutate(DemandSurge=runif(sum(Low_Disaster_Cost$MajMedMin=="Minor"),0,0.15))

Low_Disaster_Cost <- rbind(Low_Disaster_Cost_DMa, Low_Disaster_Cost_DMe)
Low_Disaster_Cost <- rbind(Low_Disaster_Cost, Low_Disaster_Cost_DMi)

Med_Disaster_Cost_DMa<- Med_Disaster_Cost %>% 
  filter(MajMedMin=="Major") %>%
  mutate(DemandSurge=runif(sum(Med_Disaster_Cost$MajMedMin=="Major"),0.35,0.5))

Med_Disaster_Cost_DMe<- Med_Disaster_Cost %>% 
  filter(MajMedMin=="Medium") %>%
  mutate(DemandSurge=runif(sum(Med_Disaster_Cost$MajMedMin=="Medium"),0.15,0.35)) 

Med_Disaster_Cost_DMi<- Med_Disaster_Cost %>% 
  filter(MajMedMin=="Minor") %>%
  mutate(DemandSurge=runif(sum(Med_Disaster_Cost$MajMedMin=="Minor"),0,0.15))

Med_Disaster_Cost <- rbind(Med_Disaster_Cost_DMa, Med_Disaster_Cost_DMe)
Med_Disaster_Cost <- rbind(Med_Disaster_Cost, Med_Disaster_Cost_DMi)

High_Disaster_Cost_DMa<- High_Disaster_Cost %>% 
  filter(MajMedMin=="Major") %>%
  mutate(DemandSurge=runif(sum(High_Disaster_Cost$MajMedMin=="Major"),0.35,0.5))

High_Disaster_Cost_DMe<- High_Disaster_Cost %>% 
  filter(MajMedMin=="Medium") %>%
  mutate(DemandSurge=runif(sum(High_Disaster_Cost$MajMedMin=="Medium"),0.15,0.35)) 

High_Disaster_Cost_DMi<- High_Disaster_Cost %>% 
  filter(MajMedMin=="Minor") %>%
  mutate(DemandSurge=runif(sum(High_Disaster_Cost$MajMedMin=="Minor"),0,0.15))

High_Disaster_Cost <- rbind(High_Disaster_Cost_DMa, High_Disaster_Cost_DMe)
High_Disaster_Cost <- rbind(High_Disaster_Cost, High_Disaster_Cost_DMi)

VHigh_Disaster_Cost_DMa<- VHigh_Disaster_Cost %>% 
  filter(MajMedMin=="Major") %>%
  mutate(DemandSurge=runif(sum(VHigh_Disaster_Cost$MajMedMin=="Major"),0.35,0.5))

VHigh_Disaster_Cost_DMe<- VHigh_Disaster_Cost %>% 
  filter(MajMedMin=="Medium") %>%
  mutate(DemandSurge=runif(sum(VHigh_Disaster_Cost$MajMedMin=="Medium"),0.15,0.35)) 

VHigh_Disaster_Cost_DMi<- VHigh_Disaster_Cost %>% 
  filter(MajMedMin=="Minor") %>%
  mutate(DemandSurge=runif(sum(VHigh_Disaster_Cost$MajMedMin=="Minor"),0,0.15))

VHigh_Disaster_Cost <- rbind(VHigh_Disaster_Cost_DMa, VHigh_Disaster_Cost_DMe)
VHigh_Disaster_Cost <- rbind(VHigh_Disaster_Cost, VHigh_Disaster_Cost_DMi)

#Calculating costs
Low_Disaster_Cost$HighDemandSurgeCost<-Low_Disaster_Cost$DemandSurge*Low_Disaster_Cost$HighCost
Low_Disaster_Cost$MedDemandSurgeCost<-Low_Disaster_Cost$DemandSurge*Low_Disaster_Cost$MedCost
Low_Disaster_Cost$LowDemandSurgeCost<-Low_Disaster_Cost$DemandSurge*Low_Disaster_Cost$LowCost
  
Med_Disaster_Cost$HighDemandSurgeCost<-Med_Disaster_Cost$DemandSurge*Med_Disaster_Cost$HighCost
Med_Disaster_Cost$MedDemandSurgeCost<-Med_Disaster_Cost$DemandSurge*Med_Disaster_Cost$MedCost
Med_Disaster_Cost$LowDemandSurgeCost<-Med_Disaster_Cost$DemandSurge*Med_Disaster_Cost$LowCost

High_Disaster_Cost$HighDemandSurgeCost<-High_Disaster_Cost$DemandSurge*High_Disaster_Cost$HighCost
High_Disaster_Cost$MedDemandSurgeCost<-High_Disaster_Cost$DemandSurge*High_Disaster_Cost$MedCost
High_Disaster_Cost$LowDemandSurgeCost<-High_Disaster_Cost$DemandSurge*High_Disaster_Cost$LowCost

VHigh_Disaster_Cost$HighDemandSurgeCost<-VHigh_Disaster_Cost$DemandSurge*VHigh_Disaster_Cost$HighCost
VHigh_Disaster_Cost$MedDemandSurgeCost<-VHigh_Disaster_Cost$DemandSurge*VHigh_Disaster_Cost$MedCost
VHigh_Disaster_Cost$LowDemandSurgeCost<-VHigh_Disaster_Cost$DemandSurge*VHigh_Disaster_Cost$LowCost

## Equipment damage Costs
#Proportion sim
Low_Disaster_Cost$EquipmentDamageProp <- runif(as.numeric(count(Low_Disaster_Cost)),0.4,0.7)

Med_Disaster_Cost$EquipmentDamageProp <- runif(as.numeric(count(Med_Disaster_Cost)),0.4,0.7)

High_Disaster_Cost$EquipmentDamageProp <- runif(as.numeric(count(High_Disaster_Cost)),0.4,0.7)

VHigh_Disaster_Cost$EquipmentDamageProp <- runif(as.numeric(count(VHigh_Disaster_Cost)),0.4,0.7)

#Calculating costs
Low_Disaster_Cost$HighEquipmentDamageCost <- Low_Disaster_Cost$EquipmentDamageProp*Low_Disaster_Cost$HighCost
Low_Disaster_Cost$MedEquipmentDamageCost <- Low_Disaster_Cost$EquipmentDamageProp*Low_Disaster_Cost$MedCost
Low_Disaster_Cost$LowEquipmentDamageCost <- Low_Disaster_Cost$EquipmentDamageProp*Low_Disaster_Cost$LowCost

Med_Disaster_Cost$HighEquipmentDamageCost <- Med_Disaster_Cost$EquipmentDamageProp*Med_Disaster_Cost$HighCost
Med_Disaster_Cost$MedEquipmentDamageCost <- Med_Disaster_Cost$EquipmentDamageProp*Med_Disaster_Cost$MedCost
Med_Disaster_Cost$LowEquipmentDamageCost <- Med_Disaster_Cost$EquipmentDamageProp*Med_Disaster_Cost$LowCost

High_Disaster_Cost$HighEquipmentDamageCost <- High_Disaster_Cost$EquipmentDamageProp*High_Disaster_Cost$HighCost
High_Disaster_Cost$MedEquipmentDamageCost <- High_Disaster_Cost$EquipmentDamageProp*High_Disaster_Cost$MedCost
High_Disaster_Cost$LowEquipmentDamageCost <- High_Disaster_Cost$EquipmentDamageProp*High_Disaster_Cost$LowCost

VHigh_Disaster_Cost$HighEquipmentDamageCost <- VHigh_Disaster_Cost$EquipmentDamageProp*VHigh_Disaster_Cost$HighCost
VHigh_Disaster_Cost$MedEquipmentDamageCost <- VHigh_Disaster_Cost$EquipmentDamageProp*VHigh_Disaster_Cost$MedCost
VHigh_Disaster_Cost$LowEquipmentDamageCost <- VHigh_Disaster_Cost$EquipmentDamageProp*VHigh_Disaster_Cost$LowCost

####Temporary Housing Costs####
CensusPop <- read_excel("Census Transposed Data.xlsx", sheet = "TranposeCensusPop", col_names=TRUE)

###Data Cleaning###
CensusPop$Region<-as.factor(CensusPop$Region)

##low
Mergehistpop_LSim <- merge(CensusPop,Low_Disaster_Cost[,1:12],by="Region")
Mergehistpop_LSim$Hoccupiedhousesaffected<-round((Mergehistpop_LSim$HighCost/Mergehistpop_LSim$`Median Value of Owner-Occupied Housing Units`)*4)
Mergehistpop_LSim$Moccupiedhousesaffected<-round((Mergehistpop_LSim$MedCost/Mergehistpop_LSim$`Median Value of Owner-Occupied Housing Units`)*4)
Mergehistpop_LSim$Loccupiedhousesaffected<-round((Mergehistpop_LSim$LowCost/Mergehistpop_LSim$`Median Value of Owner-Occupied Housing Units`)*4)


#Assume housing costs for 3 months (1 quarter)
Mergehistpop_LSim$HTempHousingCost<- Mergehistpop_LSim$Hoccupiedhousesaffected * Mergehistpop_LSim$`Persons per Household, 2016-2020` * Mergehistpop_LSim$`Temporary housing cost with disaster (per person per month)`*3 
Mergehistpop_LSim$MTempHousingCost<- Mergehistpop_LSim$Moccupiedhousesaffected * Mergehistpop_LSim$`Persons per Household, 2016-2020` * Mergehistpop_LSim$`Temporary housing cost with disaster (per person per month)`*3 
Mergehistpop_LSim$LTempHousingCost<- Mergehistpop_LSim$Loccupiedhousesaffected * Mergehistpop_LSim$`Persons per Household, 2016-2020` * Mergehistpop_LSim$`Temporary housing cost with disaster (per person per month)`*3 

##med
Mergehistpop_MSim <- merge(CensusPop,Med_Disaster_Cost[,1:12],by="Region")
Mergehistpop_MSim$Hoccupiedhousesaffected<-round((Mergehistpop_MSim$HighCost/Mergehistpop_MSim$`Median Value of Owner-Occupied Housing Units`)*4)
Mergehistpop_MSim$Moccupiedhousesaffected<-round((Mergehistpop_MSim$MedCost/Mergehistpop_MSim$`Median Value of Owner-Occupied Housing Units`)*4)
Mergehistpop_MSim$Loccupiedhousesaffected<-round((Mergehistpop_MSim$LowCost/Mergehistpop_MSim$`Median Value of Owner-Occupied Housing Units`)*4)



#Assume housing costs for 3 months (1 quarter)
Mergehistpop_MSim$HTempHousingCost<- Mergehistpop_MSim$Hoccupiedhousesaffected * Mergehistpop_MSim$`Persons per Household, 2016-2020` * Mergehistpop_MSim$`Temporary housing cost with disaster (per person per month)`*3 
Mergehistpop_MSim$MTempHousingCost<- Mergehistpop_MSim$Moccupiedhousesaffected * Mergehistpop_MSim$`Persons per Household, 2016-2020` * Mergehistpop_MSim$`Temporary housing cost with disaster (per person per month)`*3 
Mergehistpop_MSim$LTempHousingCost<- Mergehistpop_MSim$Loccupiedhousesaffected * Mergehistpop_MSim$`Persons per Household, 2016-2020` * Mergehistpop_MSim$`Temporary housing cost with disaster (per person per month)`*3 

##High
Mergehistpop_HSim <- merge(CensusPop, High_Disaster_Cost[,1:12],by="Region")
Mergehistpop_HSim$Hoccupiedhousesaffected<-round((Mergehistpop_HSim$HighCost/Mergehistpop_HSim$`Median Value of Owner-Occupied Housing Units`)*4)
Mergehistpop_HSim$Moccupiedhousesaffected<-round((Mergehistpop_HSim$MedCost/Mergehistpop_HSim$`Median Value of Owner-Occupied Housing Units`)*4)
Mergehistpop_HSim$Loccupiedhousesaffected<-round((Mergehistpop_HSim$LowCost/Mergehistpop_HSim$`Median Value of Owner-Occupied Housing Units`)*4)


#Assume housing costs for 3 months (1 quarter)
Mergehistpop_HSim$HTempHousingCost<- Mergehistpop_HSim$Hoccupiedhousesaffected * Mergehistpop_HSim$`Persons per Household, 2016-2020` * Mergehistpop_HSim$`Temporary housing cost with disaster (per person per month)`*3 
Mergehistpop_HSim$MTempHousingCost<- Mergehistpop_HSim$Moccupiedhousesaffected * Mergehistpop_HSim$`Persons per Household, 2016-2020` * Mergehistpop_HSim$`Temporary housing cost with disaster (per person per month)`*3 
Mergehistpop_HSim$LTempHousingCost<- Mergehistpop_HSim$Loccupiedhousesaffected * Mergehistpop_HSim$`Persons per Household, 2016-2020` * Mergehistpop_HSim$`Temporary housing cost with disaster (per person per month)`*3 

##VHigh
Mergehistpop_VHSim <- merge(CensusPop,VHigh_Disaster_Cost[,1:12],by="Region")
Mergehistpop_VHSim$Hoccupiedhousesaffected<-round((Mergehistpop_VHSim$HighCost/Mergehistpop_VHSim$`Median Value of Owner-Occupied Housing Units`)*4)
Mergehistpop_VHSim$Moccupiedhousesaffected<-round((Mergehistpop_VHSim$MedCost/Mergehistpop_VHSim$`Median Value of Owner-Occupied Housing Units`)*4)
Mergehistpop_VHSim$Loccupiedhousesaffected<-round((Mergehistpop_VHSim$LowCost/Mergehistpop_VHSim$`Median Value of Owner-Occupied Housing Units`)*4)


#Assume housing costs for 3 months (1 quarter)
Mergehistpop_VHSim$HTempHousingCost<- Mergehistpop_VHSim$Hoccupiedhousesaffected * Mergehistpop_VHSim$`Persons per Household, 2016-2020` * Mergehistpop_VHSim$`Temporary housing cost with disaster (per person per month)`*3 
Mergehistpop_VHSim$MTempHousingCost<- Mergehistpop_VHSim$Moccupiedhousesaffected * Mergehistpop_VHSim$`Persons per Household, 2016-2020` * Mergehistpop_VHSim$`Temporary housing cost with disaster (per person per month)`*3 
Mergehistpop_VHSim$LTempHousingCost<- Mergehistpop_VHSim$Loccupiedhousesaffected * Mergehistpop_VHSim$`Persons per Household, 2016-2020` * Mergehistpop_VHSim$`Temporary housing cost with disaster (per person per month)`*3 

##Adding to overall cost data frame
Mergehistpop_LSim <- Mergehistpop_LSim[,-2:-13]
Mergehistpop_LSim <- Mergehistpop_LSim[,-6:-15]
Low_Disaster_Cost<-merge(Low_Disaster_Cost, Mergehistpop_LSim ,by = c("Region","Year","Quarter","HazardCategory","Emissions"))

Mergehistpop_MSim <- Mergehistpop_MSim[,-2:-13]
Mergehistpop_MSim <- Mergehistpop_MSim[,-6:-15]
Med_Disaster_Cost<-merge(Med_Disaster_Cost, Mergehistpop_MSim ,by = c("Region","Year","Quarter","HazardCategory","Emissions"))

Mergehistpop_HSim <- Mergehistpop_HSim[,-2:-13]
Mergehistpop_HSim <- Mergehistpop_HSim[,-6:-15]
High_Disaster_Cost<-merge(High_Disaster_Cost, Mergehistpop_HSim ,by = c("Region","Year","Quarter","HazardCategory","Emissions"))

Mergehistpop_VHSim <- Mergehistpop_VHSim[,-2:-13]
Mergehistpop_VHSim <- Mergehistpop_VHSim[,-6:-15]
VHigh_Disaster_Cost<-merge(VHigh_Disaster_Cost, Mergehistpop_VHSim ,by = c("Region","Year","Quarter","HazardCategory","Emissions"))

### adding Owner/renting %s
OccupancyData <- read_xlsx("Occupancy Data.xlsx")

Low_Disaster_Cost<-merge(Low_Disaster_Cost,OccupancyData, by="Region")
Med_Disaster_Cost<-merge(Med_Disaster_Cost,OccupancyData, by="Region")
High_Disaster_Cost<-merge(High_Disaster_Cost,OccupancyData, by="Region")
VHigh_Disaster_Cost<-merge(VHigh_Disaster_Cost,OccupancyData, by="Region")



##Overall Detailed Costs
OverallCostDetailed_L<-Low_Disaster_Cost[,1:5]
OverallCostDetailed_L$MajMedMin<-Low_Disaster_Cost$MajMedMin
OverallCostDetailed_L$HCost<-(Low_Disaster_Cost$HighCost + Low_Disaster_Cost$HighDemandSurgeCost)*Low_Disaster_Cost$`Owner Occupied Rate` + Low_Disaster_Cost$HighEquipmentDamageCost*(Low_Disaster_Cost$`Owner Occupied Rate`+Low_Disaster_Cost$`Renting Rate`) + Low_Disaster_Cost$HTempHousingCost*(Low_Disaster_Cost$`Owner Occupied Rate`+Low_Disaster_Cost$`Renting Rate`)
OverallCostDetailed_L$MCost<-(Low_Disaster_Cost$MedCost + Low_Disaster_Cost$MedDemandSurgeCost)*Low_Disaster_Cost$`Owner Occupied Rate` + Low_Disaster_Cost$MedEquipmentDamageCost*(Low_Disaster_Cost$`Owner Occupied Rate`+Low_Disaster_Cost$`Renting Rate`) + Low_Disaster_Cost$MTempHousingCost*(Low_Disaster_Cost$`Owner Occupied Rate`+Low_Disaster_Cost$`Renting Rate`)
OverallCostDetailed_L$LCost<-(Low_Disaster_Cost$HighCost + Low_Disaster_Cost$LowDemandSurgeCost)*Low_Disaster_Cost$`Owner Occupied Rate` + Low_Disaster_Cost$LowEquipmentDamageCost*(Low_Disaster_Cost$`Owner Occupied Rate`+Low_Disaster_Cost$`Renting Rate`) + Low_Disaster_Cost$LTempHousingCost*(Low_Disaster_Cost$`Owner Occupied Rate`+Low_Disaster_Cost$`Renting Rate`)

OverallCostDetailed_L$OverallCost<-OverallCostDetailed_L$HCost+OverallCostDetailed_L$MCost+OverallCostDetailed_L$LCost


OverallCostDetailed_M<-Med_Disaster_Cost[,1:5]
OverallCostDetailed_M$MajMedMin<-Med_Disaster_Cost$MajMedMin
OverallCostDetailed_M$HCost<-(Med_Disaster_Cost$HighCost + Med_Disaster_Cost$HighDemandSurgeCost)*Med_Disaster_Cost$`Owner Occupied Rate` + Med_Disaster_Cost$HighEquipmentDamageCost*(Med_Disaster_Cost$`Owner Occupied Rate`+Med_Disaster_Cost$`Renting Rate`) + Med_Disaster_Cost$HTempHousingCost*(Med_Disaster_Cost$`Owner Occupied Rate`+Med_Disaster_Cost$`Renting Rate`)
OverallCostDetailed_M$MCost<-(Med_Disaster_Cost$MedCost + Med_Disaster_Cost$MedDemandSurgeCost)*Med_Disaster_Cost$`Owner Occupied Rate` + Med_Disaster_Cost$MedEquipmentDamageCost*(Med_Disaster_Cost$`Owner Occupied Rate`+Med_Disaster_Cost$`Renting Rate`) + Med_Disaster_Cost$MTempHousingCost*(Med_Disaster_Cost$`Owner Occupied Rate`+Med_Disaster_Cost$`Renting Rate`)
OverallCostDetailed_M$LCost<-(Med_Disaster_Cost$HighCost + Med_Disaster_Cost$LowDemandSurgeCost)*Med_Disaster_Cost$`Owner Occupied Rate` + Med_Disaster_Cost$LowEquipmentDamageCost*(Med_Disaster_Cost$`Owner Occupied Rate`+Med_Disaster_Cost$`Renting Rate`) + Med_Disaster_Cost$LTempHousingCost*(Med_Disaster_Cost$`Owner Occupied Rate`+Med_Disaster_Cost$`Renting Rate`)

OverallCostDetailed_M$OverallCost<-OverallCostDetailed_M$HCost+OverallCostDetailed_M$MCost+OverallCostDetailed_M$LCost


OverallCostDetailed_H<-High_Disaster_Cost[,1:5]
OverallCostDetailed_H$MajMedMin<-High_Disaster_Cost$MajMedMin
OverallCostDetailed_H$HCost<-(High_Disaster_Cost$HighCost + High_Disaster_Cost$HighDemandSurgeCost)*High_Disaster_Cost$`Owner Occupied Rate` + High_Disaster_Cost$HighEquipmentDamageCost*(High_Disaster_Cost$`Owner Occupied Rate`+High_Disaster_Cost$`Renting Rate`) + High_Disaster_Cost$HTempHousingCost*(High_Disaster_Cost$`Owner Occupied Rate`+High_Disaster_Cost$`Renting Rate`)
OverallCostDetailed_H$MCost<-(High_Disaster_Cost$MedCost + High_Disaster_Cost$MedDemandSurgeCost)*High_Disaster_Cost$`Owner Occupied Rate` + High_Disaster_Cost$MedEquipmentDamageCost*(High_Disaster_Cost$`Owner Occupied Rate`+High_Disaster_Cost$`Renting Rate`) + High_Disaster_Cost$MTempHousingCost*(High_Disaster_Cost$`Owner Occupied Rate`+High_Disaster_Cost$`Renting Rate`)
OverallCostDetailed_H$LCost<-(High_Disaster_Cost$HighCost + High_Disaster_Cost$LowDemandSurgeCost)*High_Disaster_Cost$`Owner Occupied Rate` + High_Disaster_Cost$LowEquipmentDamageCost*(High_Disaster_Cost$`Owner Occupied Rate`+High_Disaster_Cost$`Renting Rate`) + High_Disaster_Cost$LTempHousingCost*(High_Disaster_Cost$`Owner Occupied Rate`+High_Disaster_Cost$`Renting Rate`)

OverallCostDetailed_H$OverallCost<-OverallCostDetailed_H$HCost+OverallCostDetailed_H$MCost+OverallCostDetailed_H$LCost


OverallCostDetailed_VH<-VHigh_Disaster_Cost[,1:5]
OverallCostDetailed_VH$MajMedMin<-VHigh_Disaster_Cost$MajMedMin
OverallCostDetailed_VH$HCost<-(VHigh_Disaster_Cost$HighCost + VHigh_Disaster_Cost$HighDemandSurgeCost)*VHigh_Disaster_Cost$`Owner Occupied Rate` + VHigh_Disaster_Cost$HighEquipmentDamageCost*(VHigh_Disaster_Cost$`Owner Occupied Rate`+VHigh_Disaster_Cost$`Renting Rate`) + VHigh_Disaster_Cost$HTempHousingCost*(VHigh_Disaster_Cost$`Owner Occupied Rate`+VHigh_Disaster_Cost$`Renting Rate`)
OverallCostDetailed_VH$MCost<-(VHigh_Disaster_Cost$MedCost + VHigh_Disaster_Cost$MedDemandSurgeCost)*VHigh_Disaster_Cost$`Owner Occupied Rate` + VHigh_Disaster_Cost$MedEquipmentDamageCost*(VHigh_Disaster_Cost$`Owner Occupied Rate`+VHigh_Disaster_Cost$`Renting Rate`) + VHigh_Disaster_Cost$MTempHousingCost*(VHigh_Disaster_Cost$`Owner Occupied Rate`+VHigh_Disaster_Cost$`Renting Rate`)
OverallCostDetailed_VH$LCost<-(VHigh_Disaster_Cost$HighCost + VHigh_Disaster_Cost$LowDemandSurgeCost)*VHigh_Disaster_Cost$`Owner Occupied Rate` + VHigh_Disaster_Cost$LowEquipmentDamageCost*(VHigh_Disaster_Cost$`Owner Occupied Rate`+VHigh_Disaster_Cost$`Renting Rate`) + VHigh_Disaster_Cost$LTempHousingCost*(VHigh_Disaster_Cost$`Owner Occupied Rate`+VHigh_Disaster_Cost$`Renting Rate`)

OverallCostDetailed_VH$OverallCost<-OverallCostDetailed_VH$HCost+OverallCostDetailed_VH$MCost+OverallCostDetailed_VH$LCost


#Costs Per Time
CostTime_L <- OverallCostDetailed_L %>%                                     
  group_by(Year, Quarter,Region) %>%
  summarise(OverallCost2 = sum(OverallCost)) %>% 
  as.data.frame()
  
CostTime_M <- OverallCostDetailed_M %>%                                     
  group_by(Year, Quarter,Region) %>%
  summarise(OverallCost2 = sum(OverallCost)) %>% 
  as.data.frame()

CostTime_H <- OverallCostDetailed_H %>%                                     
  group_by(Year, Quarter,Region) %>%
  summarise(OverallCost2 = sum(OverallCost)) %>% 
  as.data.frame()

CostTime_VH <- OverallCostDetailed_VH %>%                                     
  group_by(Year, Quarter,Region) %>%
  summarise(OverallCost2 = sum(OverallCost)) %>% 
  as.data.frame()

Sim_n<-paste0("Sim",l)

SimL[, Sim_n]<-CostTime_L[4]

SimM[, Sim_n]<-CostTime_M[4]

SimH[, Sim_n]<-CostTime_H[4]

SimVH[, Sim_n]<-CostTime_VH[4]


#####Incorporating After Policy Changes#####
#Adding exposure factors
OwnerExposureData <- read_xlsx("OwnerExposureFactors.xlsx")
OwnerExposureData <- OwnerExposureData %>%
  filter(OwnerExposureData$Year!="BASE")

Low_Disaster_Cost<-merge(Low_Disaster_Cost,OwnerExposureData, by=c("Region","Year","Quarter"))
Med_Disaster_Cost<-merge(Med_Disaster_Cost,OwnerExposureData, by=c("Region","Year","Quarter"))
High_Disaster_Cost<-merge(High_Disaster_Cost,OwnerExposureData, by=c("Region","Year","Quarter"))
VHigh_Disaster_Cost<-merge(VHigh_Disaster_Cost,OwnerExposureData, by=c("Region","Year","Quarter"))

ExposureData <- read_xlsx("ExposureFactors.xlsx")
ExposureData <- ExposureData %>%
  filter(ExposureData$Year!="BASE")

Low_Disaster_Cost<-merge(Low_Disaster_Cost,ExposureData, by=c("Region","Year","Quarter"))
Med_Disaster_Cost<-merge(Med_Disaster_Cost,ExposureData, by=c("Region","Year","Quarter"))
High_Disaster_Cost<-merge(High_Disaster_Cost,ExposureData, by=c("Region","Year","Quarter"))
VHigh_Disaster_Cost<-merge(VHigh_Disaster_Cost,ExposureData, by=c("Region","Year","Quarter"))

##Overall Detailed Costs (No Buyback/rent subsidy Costs)
OverallCostDetailed_P_L<-Low_Disaster_Cost[,1:5]
OverallCostDetailed_P_L$MajMedMin<-Low_Disaster_Cost$MajMedMin
OverallCostDetailed_P_L$HCost<-(Low_Disaster_Cost$HighCost + Low_Disaster_Cost$HighDemandSurgeCost)*Low_Disaster_Cost$`Owner Occupied Rate`*Low_Disaster_Cost$HighOwnerExposure + Low_Disaster_Cost$HighEquipmentDamageCost*(Low_Disaster_Cost$`Owner Occupied Rate`+Low_Disaster_Cost$`Renting Rate`)*Low_Disaster_Cost$HighExposureFactor + Low_Disaster_Cost$HTempHousingCost*(Low_Disaster_Cost$`Owner Occupied Rate`+Low_Disaster_Cost$`Renting Rate`)*Low_Disaster_Cost$HighExposureFactor
OverallCostDetailed_P_L$MCost<-(Low_Disaster_Cost$MedCost + Low_Disaster_Cost$MedDemandSurgeCost)*Low_Disaster_Cost$`Owner Occupied Rate`*Low_Disaster_Cost$MedOwnerExposure + Low_Disaster_Cost$MedEquipmentDamageCost*(Low_Disaster_Cost$`Owner Occupied Rate`+Low_Disaster_Cost$`Renting Rate`)*Low_Disaster_Cost$MedExposureFactor + Low_Disaster_Cost$MTempHousingCost*(Low_Disaster_Cost$`Owner Occupied Rate`+Low_Disaster_Cost$`Renting Rate`)*Low_Disaster_Cost$MedExposureFactor
OverallCostDetailed_P_L$LCost<-(Low_Disaster_Cost$LowCost + Low_Disaster_Cost$LowDemandSurgeCost)*Low_Disaster_Cost$`Owner Occupied Rate`*Low_Disaster_Cost$LowOwnerExposure + Low_Disaster_Cost$LowEquipmentDamageCost*(Low_Disaster_Cost$`Owner Occupied Rate`+Low_Disaster_Cost$`Renting Rate`)*Low_Disaster_Cost$LowExposureFactor + Low_Disaster_Cost$LTempHousingCost*(Low_Disaster_Cost$`Owner Occupied Rate`+Low_Disaster_Cost$`Renting Rate`)*Low_Disaster_Cost$LowExposureFactor

OverallCostDetailed_P_L$OverallCost<-OverallCostDetailed_P_L$HCost+OverallCostDetailed_P_L$MCos+OverallCostDetailed_P_L$LCost

OverallCostDetailed_P_M<-Med_Disaster_Cost[,1:5]
OverallCostDetailed_P_M$MajMedMin<-Med_Disaster_Cost$MajMedMin
OverallCostDetailed_P_M$HCost<-(Med_Disaster_Cost$HighCost + Med_Disaster_Cost$HighDemandSurgeCost)*Med_Disaster_Cost$`Owner Occupied Rate`*Med_Disaster_Cost$HighOwnerExposure + Med_Disaster_Cost$HighEquipmentDamageCost*(Med_Disaster_Cost$`Owner Occupied Rate`+Med_Disaster_Cost$`Renting Rate`)*Med_Disaster_Cost$HighExposureFactor + Med_Disaster_Cost$HTempHousingCost*(Med_Disaster_Cost$`Owner Occupied Rate`+Med_Disaster_Cost$`Renting Rate`)*Med_Disaster_Cost$HighExposureFactor
OverallCostDetailed_P_M$MCost<-(Med_Disaster_Cost$MedCost + Med_Disaster_Cost$MedDemandSurgeCost)*Med_Disaster_Cost$`Owner Occupied Rate`*Med_Disaster_Cost$MedOwnerExposure + Med_Disaster_Cost$MedEquipmentDamageCost*(Med_Disaster_Cost$`Owner Occupied Rate`+Med_Disaster_Cost$`Renting Rate`)*Med_Disaster_Cost$MedExposureFactor + Med_Disaster_Cost$MTempHousingCost*(Med_Disaster_Cost$`Owner Occupied Rate`+Med_Disaster_Cost$`Renting Rate`)*Med_Disaster_Cost$MedExposureFactor
OverallCostDetailed_P_M$LCost<-(Med_Disaster_Cost$LowCost + Med_Disaster_Cost$LowDemandSurgeCost)*Med_Disaster_Cost$`Owner Occupied Rate`*Med_Disaster_Cost$LowOwnerExposure + Med_Disaster_Cost$LowEquipmentDamageCost*(Med_Disaster_Cost$`Owner Occupied Rate`+Med_Disaster_Cost$`Renting Rate`)*Med_Disaster_Cost$LowExposureFactor + Med_Disaster_Cost$LTempHousingCost*(Med_Disaster_Cost$`Owner Occupied Rate`+Med_Disaster_Cost$`Renting Rate`)*Med_Disaster_Cost$LowExposureFactor

OverallCostDetailed_P_M$OverallCost<-OverallCostDetailed_P_M$HCost+OverallCostDetailed_P_M$MCos+OverallCostDetailed_P_M$LCost

OverallCostDetailed_P_H<-High_Disaster_Cost[,1:5]
OverallCostDetailed_P_H$MajMedMin<-High_Disaster_Cost$MajMedMin
OverallCostDetailed_P_H$HCost<-(High_Disaster_Cost$HighCost + High_Disaster_Cost$HighDemandSurgeCost)*High_Disaster_Cost$`Owner Occupied Rate`*High_Disaster_Cost$HighOwnerExposure + High_Disaster_Cost$HighEquipmentDamageCost*(High_Disaster_Cost$`Owner Occupied Rate`+High_Disaster_Cost$`Renting Rate`)*High_Disaster_Cost$HighExposureFactor + High_Disaster_Cost$HTempHousingCost*(High_Disaster_Cost$`Owner Occupied Rate`+High_Disaster_Cost$`Renting Rate`)*High_Disaster_Cost$HighExposureFactor
OverallCostDetailed_P_H$MCost<-(High_Disaster_Cost$MedCost + High_Disaster_Cost$MedDemandSurgeCost)*High_Disaster_Cost$`Owner Occupied Rate`*High_Disaster_Cost$MedOwnerExposure + High_Disaster_Cost$MedEquipmentDamageCost*(High_Disaster_Cost$`Owner Occupied Rate`+High_Disaster_Cost$`Renting Rate`)*High_Disaster_Cost$MedExposureFactor + High_Disaster_Cost$MTempHousingCost*(High_Disaster_Cost$`Owner Occupied Rate`+High_Disaster_Cost$`Renting Rate`)*High_Disaster_Cost$MedExposureFactor
OverallCostDetailed_P_H$LCost<-(High_Disaster_Cost$LowCost + High_Disaster_Cost$LowDemandSurgeCost)*High_Disaster_Cost$`Owner Occupied Rate`*High_Disaster_Cost$LowOwnerExposure + High_Disaster_Cost$LowEquipmentDamageCost*(High_Disaster_Cost$`Owner Occupied Rate`+High_Disaster_Cost$`Renting Rate`)*High_Disaster_Cost$LowExposureFactor + High_Disaster_Cost$LTempHousingCost*(High_Disaster_Cost$`Owner Occupied Rate`+High_Disaster_Cost$`Renting Rate`)*High_Disaster_Cost$LowExposureFactor

OverallCostDetailed_P_H$OverallCost<-OverallCostDetailed_P_H$HCost+OverallCostDetailed_P_H$MCos+OverallCostDetailed_P_H$LCost

OverallCostDetailed_P_VH<-VHigh_Disaster_Cost[,1:5]
OverallCostDetailed_P_VH$MajMedMin<-VHigh_Disaster_Cost$MajMedMin
OverallCostDetailed_P_VH$HCost<-(VHigh_Disaster_Cost$HighCost + VHigh_Disaster_Cost$HighDemandSurgeCost)*VHigh_Disaster_Cost$`Owner Occupied Rate`*VHigh_Disaster_Cost$HighOwnerExposure + VHigh_Disaster_Cost$HighEquipmentDamageCost*(VHigh_Disaster_Cost$`Owner Occupied Rate`+VHigh_Disaster_Cost$`Renting Rate`)*VHigh_Disaster_Cost$HighExposureFactor + VHigh_Disaster_Cost$HTempHousingCost*(VHigh_Disaster_Cost$`Owner Occupied Rate`+VHigh_Disaster_Cost$`Renting Rate`)*VHigh_Disaster_Cost$HighExposureFactor
OverallCostDetailed_P_VH$MCost<-(VHigh_Disaster_Cost$MedCost + VHigh_Disaster_Cost$MedDemandSurgeCost)*VHigh_Disaster_Cost$`Owner Occupied Rate`*VHigh_Disaster_Cost$MedOwnerExposure + VHigh_Disaster_Cost$MedEquipmentDamageCost*(VHigh_Disaster_Cost$`Owner Occupied Rate`+VHigh_Disaster_Cost$`Renting Rate`)*VHigh_Disaster_Cost$MedExposureFactor + VHigh_Disaster_Cost$MTempHousingCost*(VHigh_Disaster_Cost$`Owner Occupied Rate`+VHigh_Disaster_Cost$`Renting Rate`)*VHigh_Disaster_Cost$MedExposureFactor
OverallCostDetailed_P_VH$LCost<-(VHigh_Disaster_Cost$LowCost + VHigh_Disaster_Cost$LowDemandSurgeCost)*VHigh_Disaster_Cost$`Owner Occupied Rate`*VHigh_Disaster_Cost$LowOwnerExposure + VHigh_Disaster_Cost$LowEquipmentDamageCost*(VHigh_Disaster_Cost$`Owner Occupied Rate`+VHigh_Disaster_Cost$`Renting Rate`)*VHigh_Disaster_Cost$LowExposureFactor + VHigh_Disaster_Cost$LTempHousingCost*(VHigh_Disaster_Cost$`Owner Occupied Rate`+VHigh_Disaster_Cost$`Renting Rate`)*VHigh_Disaster_Cost$LowExposureFactor

OverallCostDetailed_P_VH$OverallCost<-OverallCostDetailed_P_VH$HCost+OverallCostDetailed_P_VH$MCos+OverallCostDetailed_P_VH$LCost

###Buyback Costs###
##Overall Costs Regardless of disaster type or disaster severity
OverallCost_L <- OverallCostDetailed_P_L %>%                                     
  group_by(Year, Quarter,Region) %>%
  summarise(OverallCost2 = sum(OverallCost)) %>% 
  as.data.frame()

OverallCost_M <- OverallCostDetailed_P_M %>%                                     
  group_by(Year, Quarter,Region) %>%
  summarise(OverallCost2 = sum(OverallCost)) %>% 
  as.data.frame()

OverallCost_H <- OverallCostDetailed_P_H %>%                                     
  group_by(Year, Quarter,Region) %>%
  summarise(OverallCost2 = sum(OverallCost)) %>% 
  as.data.frame()

OverallCost_VH <- OverallCostDetailed_P_VH %>%                                     
  group_by(Year, Quarter,Region) %>%
  summarise(OverallCost2 = sum(OverallCost)) %>% 
  as.data.frame()


##Adding Buybacks and rent subsidy costs 
BuyBCostData <- read_xlsx("BuyBackCost.xlsx") 
BuyBCostData <- BuyBCostData %>%
  filter(Year!="BASE")

RentCostData <- read_xlsx("RentCost.xlsx") 
RentCostData <- RentCostData %>%
  filter(Year!="BASE")

OverallCost_L_bb<-merge(OverallCost_L,BuyBCostData)
OverallCost_L_bbr<-merge(OverallCost_L_bb,RentCostData)

OverallCost_M_bb<-merge(OverallCost_M,BuyBCostData)
OverallCost_M_bbr<-merge(OverallCost_M_bb,RentCostData)

OverallCost_H_bb<-merge(OverallCost_H,BuyBCostData)
OverallCost_H_bbr<-merge(OverallCost_H_bb,RentCostData)

OverallCost_VH_bb<-merge(OverallCost_VH,BuyBCostData)
OverallCost_VH_bbr<-merge(OverallCost_VH_bb,RentCostData)

####Costs Per Time with Policy####
#Costs Per Time with policy
CostTime_P_L <- OverallCost_L_bbr %>%                                     
  group_by(Year, Quarter,Region) %>%
  summarise(OverallCost3 = sum(OverallCost2,HighBuybackCost,MedBuybackCost,HighRentCost,MedRentCost)) %>% 
  as.data.frame()

CostTime_P_M <- OverallCost_M_bbr %>%                                     
  group_by(Year, Quarter,Region) %>%
  summarise(OverallCost3 = sum(OverallCost2,HighBuybackCost,MedBuybackCost,HighRentCost,MedRentCost)) %>% 
  as.data.frame()

CostTime_P_H <- OverallCost_H_bbr %>%                                     
  group_by(Year, Quarter,Region) %>%
  summarise(OverallCost3 = sum(OverallCost2,HighBuybackCost,MedBuybackCost,HighRentCost,MedRentCost)) %>% 
  as.data.frame()

CostTime_P_VH <- OverallCost_VH_bbr %>%                                     
  group_by(Year, Quarter,Region) %>%
  summarise(OverallCost3 = sum(OverallCost2,HighBuybackCost,MedBuybackCost,HighRentCost,MedRentCost)) %>% 
  as.data.frame()

Sim_n<-paste0("Sim",l)


SimL_p[, Sim_n]<-CostTime_P_L[4]

SimM_p[, Sim_n]<-CostTime_P_M[4]

SimH_p[, Sim_n]<-CostTime_P_H[4]

SimVH_p[, Sim_n]<-CostTime_P_VH[4]
print(paste0("Sim",l," Complete",Sys.time()))
}


write.csv(SimL,"SimL.csv")
write.csv(SimM,"SimM.csv")
write.csv(SimH,"SimH.csv")
write.csv(SimVH,"SimVH.csv")


write.csv(SimL_p,"SimL_p.csv")
write.csv(SimM_p,"SimM_p.csv")
write.csv(SimH_p,"SimH_p.csv")
write.csv(SimVH_p,"SimVH_p.csv")