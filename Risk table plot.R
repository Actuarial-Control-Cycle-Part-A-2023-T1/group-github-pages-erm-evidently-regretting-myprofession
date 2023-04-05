getwd()
setwd("~/ACTL/CCA ACTL5100/Group Project")


install.packages("readxl")
library(readxl)
library(ggplot2)
library("dplyr")
library("statmod")
library("gamlss")
library("gamlss.dist")
library("tweedie")

# read the Excel file into R
setwd("~/ACTL/CCA ACTL5100/Group Project")
riskdata <- read_excel("Risk Table v2.xlsx")
riskdata$Impact <- riskdata$Impact / 10
riskdata$Likelihood <- riskdata$Likelihood / 10

plot(riskdata$Likelihood, riskdata$Impact, main = "Risk Assessment Chart", xlab = "Likelihood", ylab = "Impact", ylim=c(0,10),xlim=c(0,10))
text(riskdata$Likelihood, riskdata$Impact, riskdata$Risk, pos=3)


#sensitivity plot

##----------------------------------------------------------------
##BASE
##----------------------------------------------------------------
DataBaseVH <- read.csv("C:/Users/TechFast Australia/Documents/ACTL/CCA ACTL5100/Group Project/Final Model/Sensitivity Base/SimVH_p.csv")
DataBaseVH$avg <- rowMeans(DataBaseVH[,7:1005])

DataBaseH <- read.csv("C:/Users/TechFast Australia/Documents/ACTL/CCA ACTL5100/Group Project/Final Model/Sensitivity Base/SimH_p.csv")
DataBaseH$avg <- rowMeans(DataBaseH[,7:1005])

DataBaseM <- read.csv("C:/Users/TechFast Australia/Documents/ACTL/CCA ACTL5100/Group Project/Final Model/Sensitivity Base/SimM_p.csv")
DataBaseM$avg <- rowMeans(DataBaseM[,7:1005])

DataBaseL <- read.csv("C:/Users/TechFast Australia/Documents/ACTL/CCA ACTL5100/Group Project/Final Model/Sensitivity Base/SimL_p.csv")
DataBaseL$avg <- rowMeans(DataBaseL[,7:1005])

#DataBaseAll <- rbind(DataBaseVH,DataBaseH,DataBaseM,DataBaseL)

#Base_sum <- DataBaseAll %>% group_by(Year) %>% summarise(total=sum(avg))
#plot(Base_sum$Year,Base_sum$total,type='l',col='Black',xlab="Projected Costs", ylab="Year",main="Sensitivity Analysis on Projected Costs")

Base_VH <- DataBaseVH %>% group_by(Year) %>% summarise(total=sum(avg))
Base_H <- DataBaseH %>% group_by(Year) %>% summarise(total=sum(avg))
Base_M <- DataBaseM %>% group_by(Year) %>% summarise(total=sum(avg))
Base_L <- DataBaseL %>% group_by(Year) %>% summarise(total=sum(avg))

plot(Base_VH$Year,Base_VH$total,type='l',col='Black',xlab="Projected Costs", ylab="Year",main="Sensitivity Analysis on Projected Costs")


##----------------------------------------------------------------
##Up 1%
##----------------------------------------------------------------
DataUpVH <- read.csv("C:/Users/TechFast Australia/Documents/ACTL/CCA ACTL5100/Group Project/Final Model/Sensitivity Up/SimVH_p.csv")
DataUpVH$avg <- rowMeans(DataUpVH[,7:106])

DataUpH <- read.csv("C:/Users/TechFast Australia/Documents/ACTL/CCA ACTL5100/Group Project/Final Model/Sensitivity Up/SimH_p.csv")
DataUpH$avg <- rowMeans(DataUpH[,7:106])

DataUpM <- read.csv("C:/Users/TechFast Australia/Documents/ACTL/CCA ACTL5100/Group Project/Final Model/Sensitivity Up/SimM_p.csv")
DataUpM$avg <- rowMeans(DataUpM[,7:106])

DataUpL <- read.csv("C:/Users/TechFast Australia/Documents/ACTL/CCA ACTL5100/Group Project/Final Model/Sensitivity Up/SimL_p.csv")
DataUpL$avg <- rowMeans(DataUpL[,7:106])

#DataUpAll <- rbind(DataUpVH,DataUpH,DataUpM,DataUpL)

#Up_sum <- DataUpAll %>% group_by(Year) %>% summarise(total=sum(avg))
#lines(Up_sum$Year,Up_sum$total,type='l',lty='dashed',col='Green')

Up_VH <- DataUpVH %>% group_by(Year) %>% summarise(total=sum(avg))
Up_H <- DataUpH %>% group_by(Year) %>% summarise(total=sum(avg))
Up_M <- DataUpM %>% group_by(Year) %>% summarise(total=sum(avg))
Up_L <- DataUpL %>% group_by(Year) %>% summarise(total=sum(avg))

lines(Up_VH$Year,Up_VH$total,type='l',lty='dashed',col='Green')

##----------------------------------------------------------------
##Down 1%
##----------------------------------------------------------------
DataDownVH <- read.csv("C:/Users/TechFast Australia/Documents/ACTL/CCA ACTL5100/Group Project/Final Model/Sensitivity Down/SimVH_p.csv")
DataDownVH$avg <- rowMeans(DataDownVH[,7:106])

DataDownH <- read.csv("C:/Users/TechFast Australia/Documents/ACTL/CCA ACTL5100/Group Project/Final Model/Sensitivity Down/SimH_p.csv")
DataDownH$avg <- rowMeans(DataDownH[,7:106])

DataDownM <- read.csv("C:/Users/TechFast Australia/Documents/ACTL/CCA ACTL5100/Group Project/Final Model/Sensitivity Down/SimM_p.csv")
DataDownM$avg <- rowMeans(DataDownM[,7:106])

DataDownL <- read.csv("C:/Users/TechFast Australia/Documents/ACTL/CCA ACTL5100/Group Project/Final Model/Sensitivity Down/SimL_p.csv")
DataDownL$avg <- rowMeans(DataDownL[,7:106])

#DataDownAll <- rbind(DataDownVH,DataDownH,DataDownM,DataDownL)

#Down_sum <- DataDownAll %>% group_by(Year) %>% summarise(total=sum(avg))
#lines(Down_sum$Year,Down_sum$total,type='l',lty='dashed',col='Red')

Down_VH <- DataDownVH %>% group_by(Year) %>% summarise(total=sum(avg))
Down_H <- DataDownH %>% group_by(Year) %>% summarise(total=sum(avg))
Down_M <- DataDownM %>% group_by(Year) %>% summarise(total=sum(avg))
Down_L <- DataDownL %>% group_by(Year) %>% summarise(total=sum(avg))

lines(Down_VH$Year,Down_VH$total,type='l',lty='dashed',col='Red')


##----------------------------------------------------------------
##Required Plots
##----------------------------------------------------------------
scalevar <- 1000000000

options(scipen=999)
plot(Base_VH$Year,Base_VH$total/scalevar,type='l',col='Black',ylim=c(0,3.5),ylab="Projected Costs (billions)", xlab="Year",main="Sensitivity Analysis on Projected Costs under Very High Emissions Scenario")
lines(Up_VH$Year,Up_VH$total/scalevar,type='l',lty='dashed',col='Green')
lines(Down_VH$Year,Down_VH$total/scalevar,type='l',lty='dashed',col='Red')
guides(fill = guide_legend(title.position = "top", title.hjust=0.5))
legend(2100,3.5,
       legend = c(" -1% Acceptance Rate", "Base Acceptance Rate"," +1% Acceptance Rate"),
       col = c('Red','Black','Green'),
       lty = c(2,1,2),bty='n')
legend(2022,3.5,
       legend = c("*costs pre 2030 extend back linearly"),bty='n')


plot(Base_H$Year,Base_H$total/scalevar,type='l',col='Black',ylab="Projected Costs (millions)", xlab="Year",main="Sensitivity Analysis on Projected Costs H")
lines(Up_H$Year,Up_H$total/scalevar,type='l',lty='dashed',col='Green')
lines(Down_H$Year,Down_H$total/scalevar,type='l',lty='dashed',col='Red')

plot(Base_M$Year,Base_M$total/scalevar,type='l',col='Black',ylab="Projected Costs (millions)", xlab="Year",main="Sensitivity Analysis on Projected Costs M")
lines(Up_M$Year,Up_M$total/scalevar,type='l',lty='dashed',col='Green')
lines(Down_M$Year,Down_M$total/scalevar,type='l',lty='dashed',col='Red')

plot(Base_L$Year,Base_L$total/scalevar,type='l',col='Black',ylab="Projected Costs (millions)", xlab="Year",main="Sensitivity Analysis on Projected Costs L")
lines(Up_L$Year,Up_L$total/scalevar,type='l',lty='dashed',col='Green')
lines(Down_L$Year,Down_L$total/scalevar,type='l',lty='dashed',col='Red')

write.table(Down_VH,file="clipboard", sep = "\t", row.names = FALSE, col.names = TRUE)
write.table(Up_VH,file="clipboard", sep = "\t", row.names = FALSE, col.names = TRUE)
write.table(Base_VH,file="clipboard", sep = "\t", row.names = FALSE, col.names = TRUE)

write.table(Base_VH,file="clipboard", sep = "\t", row.names = FALSE, col.names = TRUE)
write.table(Base_L,file="clipboard", sep = "\t", row.names = FALSE, col.names = TRUE)

##second plot put all the policy costs in one table
plot(Base_VH$Year,Base_VH$total/scalevar,type='l',col='Black',ylab="Projected Costs (billions)",ylim=c(0,3.5), xlab="Year",main="Projected costs under different emissions scenarios")
lines(Base_H$Year,Base_H$total/scalevar,type='l',lty='dashed',col='Red')
lines(Base_M$Year,Base_M$total/scalevar,type='l',lty='dashed',col='Blue')
lines(Base_L$Year,Base_L$total/scalevar,type='l',lty='dashed',col='Green')

legend(2120,3.5,
       title = "Emission Scenario:",
       legend = c("Very High", "High","Medium","Low"),
       col = c('Black','Red','Blue','Green'),
       lty = c(1,2,2,2),bty='n')

legend(2022,3.5,
       legend = c("*costs pre 2030 extend back linearly"),bty='n')
