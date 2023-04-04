library("readxl")
library("dplyr")
library("statmod")
library("gamlss")
library("gamlss.dist")
library("tweedie")
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


###Creating general test/training sets###
set.seed(34125)
sample <- sort(sample(nrow(HistoricalData), nrow(HistoricalData)*.8))

train<-HistoricalData[sample,]
test<-HistoricalData[-sample,]

##Applying GLM models (Maj/med/min as a variable)

#Gamma
model_gam <- glm(log(`2021Cost`) ~  Region + Quarter + HazardCategory + MajMedMin 
                 , family = Gamma(link=identity), data = train)
summary(model_gam)

pred_gam <- data.frame(pred = exp(predict(model_gam, test)), obs = test$`2021Cost`)
RMSE_gam <- sqrt(mean((pred_gam$obs - pred_gam$pred)^2))

#Tweedie
model_twe <- glm(log(`2021Cost`) ~ Region + Quarter + HazardCategory + MajMedMin 
                 , family = tweedie(var.power=2,link.power=1), data = train)
summary(model_twe)

pred_twe <- data.frame(pred = exp(predict(model_twe, test)), obs = test$`2021Cost`)
RMSE_twe <- sqrt(mean((pred_twe$obs - pred_twe$pred)^2))


#ZAIG https://thescipub.com/pdf/jmssp.2013.186.192.pdf
model_ZAIG <- gamlss(log(`2021Cost`) ~ Region + Quarter + HazardCategory + MajMedMin  
                     , family = ZAIG, data = train)
summary(model_ZAIG)

pred_ZAIG <- data.frame(pred = exp(predict(model_ZAIG, newdata=test, type = "response")), obs = test$`2021Cost`)
RMSE_ZAIG <- sqrt(mean((pred_ZAIG$obs - pred_ZAIG$pred)^2))

#ZAGA
model_ZAGA <- gamlss(log(`2021Cost`)~ Region + Quarter + HazardCategory + MajMedMin  
                     , family = ZAGA, data = train)
summary(model_ZAGA)

pred_ZAGA <- data.frame(pred = exp(predict(model_ZAGA, newdata=test, type = "response")), obs = test$`2021Cost`)
RMSE_ZAGA <- sqrt(mean((pred_ZAGA$obs - pred_ZAIG$pred)^2))

#Model Comparison

Comparison <- data.frame(matrix(NA,nrow = 3,ncol = 6))
colnames(Comparison)<-c("Gaussian","Poisson","Gamma","Tweedie","ZAGA","ZAIG")
rownames(Comparison)<-c("RMSE","AIC","BIC")

Comparison$Gaussian<-c(RMSE_gau,AIC(model_gau),BIC(model_gau))
Comparison$Poisson<-c(RMSE_poi,AIC(model_poi),BIC(model_poi))
Comparison$Gamma<-c(RMSE_gam,AIC(model_gam),BIC(model_gam))
Comparison$Tweedie<-c(RMSE_twe,AICtweedie(model_twe),NA)
Comparison$ZAGA<-c(RMSE_ZAGA,AIC(model_ZAGA),BIC(model_ZAGA))
Comparison$ZAIG<-c(RMSE_ZAGA,AIC(model_ZAIG),BIC(model_ZAIG))

