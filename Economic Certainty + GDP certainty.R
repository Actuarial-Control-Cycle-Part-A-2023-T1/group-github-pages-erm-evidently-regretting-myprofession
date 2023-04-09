library("readxl")
library("dplyr")
library("statmod")
library("gamlss")
library("gamlss.dist")
library("tweedie")

#Data Cleaning
SimL<-read.csv("SimL.csv") 
SimL_p<-read.csv("SimL_p.csv") 
SimM<-read.csv("SimM.csv") 
SimM_p<-read.csv("SimM_p.csv") 
SimH<-read.csv("SimH.csv") 
SimH_p<-read.csv("SimH_p.csv") 
SimVH<-read.csv("SimVH.csv") 
SimVH_p<-read.csv("SimVH_p.csv") 

SimL<-SimL[,-1:-2]
SimL_p<-SimL_p[,-1:-2]
SimM<-SimM[,-1:-2]
SimM_p<-SimM_p[,-1:-2]
SimH<-SimH[,-1:-2]
SimH_p<-SimH_p[,-1:-2]
SimVH<-SimVH[,-1:-2]
SimVH_p<-SimVH_p[,-1:-2]


##Degree of certainty that economic costs with the program > Economic costs without

# Assume short term is 10 years long term is 150?
shortSimL<-SimL%>%
  filter(Year<2030)

shortSimL_p<-SimL_p%>%
  filter(Year<2030)

shortSimM<-SimM%>%
  filter(Year<2030)

shortSimM_p<-SimM_p%>%
  filter(Year<2030)

shortSimH<-SimH%>%
  filter(Year<2030)

shortSimH_p<-SimH_p%>%
  filter(Year<2030)

shortSimVH<-SimVH%>%
  filter(Year<2030)

shortSimVH_p<-SimVH_p%>%
  filter(Year<2030)


kShorteconL<-0 #Number of times cost of policy < cost without policy Short term
kShorteconM<-0
kShorteconH<-0
kShorteconVH<-0
keconL<-0 #Number of times cost of policy < cost without policy Long term
keconM<-0
keconH<-0
keconVH<-0

for (i in 1:1000){
  if(sum(shortSimL_p[,3+i]) < sum(shortSimL[,3+i])){
   kShorteconL<-kShorteconL+1
  }
  if(sum(shortSimM_p[,3+i]) < sum(shortSimM[,3+i])){
    kShorteconM<-kShorteconM+1
  }
  if(sum(shortSimH_p[,3+i]) < sum(shortSimH[,3+i])){
    kShorteconH<-kShorteconH+1
  }
  if(sum(shortSimVH_p[,3+i]) < sum(shortSimVH[,3+i])){
    kShorteconVH<-kShorteconVH+1
  }
  if(sum(SimL_p[,3+i]) < sum(SimL[,3+i])){
    keconL<-keconL+1
  }
  if(sum(SimM_p[,3+i]) < sum(SimM[,3+i])){
    keconM<-keconM+1
  }
  if(sum(SimH_p[,3+i]) < sum(SimH[,3+i])){
    keconH<-keconH+1
  }
  if(sum(SimVH_p[,3+i]) < sum(SimVH[,3+i])){
    keconVH<-keconVH+1
  }
}
EconomicCertainty<-as.data.frame(NA)
EconomicCertainty$ShortL<-kShorteconL/1000 #short term certainty
EconomicCertainty$ShortM<-kShorteconM/1000
EconomicCertainty$ShortH<-kShorteconH/1000
EconomicCertainty$ShortVH<-kShorteconVH/1000
  
EconomicCertainty$L<-keconL/1000 #long term certainty
EconomicCertainty$M<-keconM/1000
EconomicCertainty$H<-keconH/1000
EconomicCertainty$VH<-keconVH/1000  

##Degree of certainty that economic costs per year are less than 10% GDP
GDPData<-read_excel("GDP.xlsx") 
GDPProj<-read_excel("GDPproj.xlsx") 

p_R1shortSimL<-shortSimL_p %>% 
  filter(Region==1) %>%
  group_by(Year) %>%
  summarise(across(everything(), sum),
            .groups = 'drop')  %>%
  as.data.frame()


p_R2shortSimL<-shortSimL_p %>% 
  filter(Region==2) %>%
  group_by(Year) %>%
  summarise(across(everything(), sum),
            .groups = 'drop')  %>%
  as.data.frame()


p_R3shortSimL<-shortSimL_p %>% 
  filter(Region==3) %>%
  group_by(Year) %>%
  summarise(across(everything(), sum),
            .groups = 'drop')  %>%
  as.data.frame()


p_R4shortSimL<-shortSimL_p %>% 
  filter(Region==4) %>%
  group_by(Year) %>%
  summarise(across(everything(), sum),
            .groups = 'drop')  %>%
  as.data.frame()

  
p_R5shortSimL<-shortSimL_p %>% 
  filter(Region==5) %>%
  group_by(Year) %>%
  summarise(across(everything(), sum),
            .groups = 'drop')  %>%
  as.data.frame()

p_R6shortSimL<-shortSimL_p %>% 
  filter(Region==6) %>%
  group_by(Year) %>%
  summarise(across(everything(), sum),
            .groups = 'drop')  %>%
  as.data.frame()


p_R1shortSimM<-shortSimM_p%>% 
  filter(Region==1) %>%
  group_by(Year) %>%
  summarise(across(everything(), sum),
            .groups = 'drop')  %>%
  as.data.frame()


p_R2shortSimM<-shortSimM_p%>% 
  filter(Region==2) %>%
  group_by(Year) %>%
  summarise(across(everything(), sum),
            .groups = 'drop')  %>%
  as.data.frame()


p_R3shortSimM<-shortSimM_p%>% 
  filter(Region==3) %>%
  group_by(Year) %>%
  summarise(across(everything(), sum),
            .groups = 'drop')  %>%
  as.data.frame()


p_R4shortSimM<-shortSimM_p%>% 
  filter(Region==4) %>%
  group_by(Year) %>%
  summarise(across(everything(), sum),
            .groups = 'drop')  %>%
  as.data.frame()
 

p_R5shortSimM<-shortSimM_p%>% 
  filter(Region==5) %>%
  group_by(Year) %>%
  summarise(across(everything(), sum),
            .groups = 'drop')  %>%
  as.data.frame()


p_R6shortSimM<-shortSimM_p%>% 
  filter(Region==6) %>%
  group_by(Year) %>%
  summarise(across(everything(), sum),
            .groups = 'drop')  %>%
  as.data.frame()

p_R1shortSimH<-shortSimH_p%>% 
  filter(Region==1) %>%
  group_by(Year) %>%
  summarise(across(everything(), sum),
            .groups = 'drop')  %>%
  as.data.frame()


p_R2shortSimH<-shortSimH_p%>% 
  filter(Region==2) %>%
  group_by(Year) %>%
  summarise(across(everything(), sum),
            .groups = 'drop')  %>%
  as.data.frame()


p_R3shortSimH<-shortSimH_p%>% 
  filter(Region==3) %>%
  group_by(Year) %>%
  summarise(across(everything(), sum),
            .groups = 'drop')  %>%
  as.data.frame()
 

p_R4shortSimH<-shortSimH_p%>% 
  filter(Region==4) %>%
  group_by(Year) %>%
  summarise(across(everything(), sum),
            .groups = 'drop')  %>%
  as.data.frame()


p_R5shortSimH<-shortSimH_p%>% 
  filter(Region==5) %>%
  group_by(Year) %>%
  summarise(across(everything(), sum),
            .groups = 'drop')  %>%
  as.data.frame()


p_R6shortSimH<-shortSimH_p%>% 
  filter(Region==6) %>%
  group_by(Year) %>%
  summarise(across(everything(), sum),
            .groups = 'drop')  %>%
  as.data.frame()


p_R1shortSimVH<-shortSimVH_p%>% 
  filter(Region==1) %>%
  group_by(Year) %>%
  summarise(across(everything(), sum),
            .groups = 'drop')  %>%
  as.data.frame()


p_R2shortSimVH<-shortSimVH_p%>% 
  filter(Region==2) %>%
  group_by(Year) %>%
  summarise(across(everything(), sum),
            .groups = 'drop')  %>%
  as.data.frame()


p_R3shortSimVH<-shortSimVH_p%>% 
  filter(Region==3) %>%
  group_by(Year) %>%
  summarise(across(everything(), sum),
            .groups = 'drop')  %>%
  as.data.frame()
  

p_R4shortSimVH<-shortSimVH_p%>% 
  filter(Region==4) %>%
  group_by(Year) %>%
  summarise(across(everything(), sum),
            .groups = 'drop')  %>%
  as.data.frame()


p_R5shortSimVH<-shortSimVH_p%>% 
  filter(Region==5) %>%
  group_by(Year) %>%
  summarise(across(everything(), sum),
            .groups = 'drop')  %>%
  as.data.frame()


p_R6shortSimVH<-shortSimVH_p%>% 
  filter(Region==6) %>%
  group_by(Year) %>%
  summarise(across(everything(), sum),
            .groups = 'drop')  %>%
  as.data.frame()


#long term  
p_R1SimL<-SimL_p %>% 
  filter(Region==1) %>%
  group_by(Year) %>%
  summarise(across(everything(), sum),
            .groups = 'drop')  %>%
  as.data.frame()


p_R2SimL<-SimL_p %>% 
  filter(Region==2) %>%
  group_by(Year) %>%
  summarise(across(everything(), sum),
            .groups = 'drop')  %>%
  as.data.frame()


p_R3SimL<-SimL_p %>% 
  filter(Region==3) %>%
  group_by(Year) %>%
  summarise(across(everything(), sum),
            .groups = 'drop')  %>%
  as.data.frame()


p_R4SimL<-SimL_p %>% 
  filter(Region==4) %>%
  group_by(Year) %>%
  summarise(across(everything(), sum),
            .groups = 'drop')  %>%
  as.data.frame()
 

p_R5SimL<-SimL_p %>% 
  filter(Region==5) %>%
  group_by(Year) %>%
  summarise(across(everything(), sum),
            .groups = 'drop')  %>%
  as.data.frame()
  

p_R6SimL<-SimL_p %>% 
  filter(Region==6) %>%
  group_by(Year) %>%
  summarise(across(everything(), sum),
            .groups = 'drop')  %>%
  as.data.frame()


p_R1SimM<-SimM_p %>% 
  filter(Region==1) %>%
  group_by(Year) %>%
  summarise(across(everything(), sum),
            .groups = 'drop')  %>%
  as.data.frame()


p_R2SimM<-SimM_p %>% 
  filter(Region==2) %>%
  group_by(Year) %>%
  summarise(across(everything(), sum),
            .groups = 'drop')  %>%
  as.data.frame()
 

p_R3SimM<-SimM_p %>% 
  filter(Region==3) %>%
  group_by(Year) %>%
  summarise(across(everything(), sum),
            .groups = 'drop')  %>%
  as.data.frame()


p_R4SimM<-SimM_p %>% 
  filter(Region==4) %>%
  group_by(Year) %>%
  summarise(across(everything(), sum),
            .groups = 'drop')  %>%
  as.data.frame()
 

p_R5SimM<-SimM_p %>% 
  filter(Region==5) %>%
  group_by(Year) %>%
  summarise(across(everything(), sum),
            .groups = 'drop')  %>%
  as.data.frame()
 

p_R6SimM<-SimM_p %>% 
  filter(Region==6) %>%
  group_by(Year) %>%
  summarise(across(everything(), sum),
            .groups = 'drop')  %>%
  as.data.frame()


p_R1SimH<-SimH_p %>% 
  filter(Region==1) %>%
  group_by(Year) %>%
  summarise(across(everything(), sum),
            .groups = 'drop')  %>%
  as.data.frame()
  

p_R2SimH<-SimH_p %>% 
  filter(Region==2) %>%
  group_by(Year) %>%
  summarise(across(everything(), sum),
            .groups = 'drop')  %>%
  as.data.frame()


p_R3SimH<-SimH_p %>% 
  filter(Region==3) %>%
  group_by(Year) %>%
  summarise(across(everything(), sum),
            .groups = 'drop')  %>%
  as.data.frame()


p_R4SimH<-SimH_p %>% 
  filter(Region==4) %>%
  group_by(Year) %>%
  summarise(across(everything(), sum),
            .groups = 'drop')  %>%
  as.data.frame()


p_R5SimH<-SimH_p %>% 
  filter(Region==5) %>%
  group_by(Year) %>%
  summarise(across(everything(), sum),
            .groups = 'drop')  %>%
  as.data.frame()
 

p_R6SimH<-SimH_p %>% 
  filter(Region==6) %>%
  group_by(Year) %>%
  summarise(across(everything(), sum),
            .groups = 'drop')  %>%
  as.data.frame()
 

p_R1SimVH<-SimVH_p %>% 
  filter(Region==1) %>%
  group_by(Year) %>%
  summarise(across(everything(), sum),
            .groups = 'drop')  %>%
  as.data.frame()


p_R2SimVH<-SimVH_p %>% 
  filter(Region==2) %>%
  group_by(Year) %>%
  summarise(across(everything(), sum),
            .groups = 'drop')  %>%
  as.data.frame()
 

p_R3SimVH<-SimVH_p %>% 
  filter(Region==3) %>%
  group_by(Year) %>%
  summarise(across(everything(), sum),
            .groups = 'drop')  %>%
  as.data.frame()


p_R4SimVH<-SimVH_p %>% 
  filter(Region==4) %>%
  group_by(Year) %>%
  summarise(across(everything(), sum),
            .groups = 'drop')  %>%
  as.data.frame()


p_R5SimVH<-SimVH_p %>% 
  filter(Region==5) %>%
  group_by(Year) %>%
  summarise(across(everything(), sum),
            .groups = 'drop')  %>%
  as.data.frame()


p_R6SimVH<-SimVH_p %>% 
  filter(Region==6) %>%
  group_by(Year) %>%
  summarise(across(everything(), sum),
            .groups = 'drop')  %>%
  as.data.frame()
  
 
#Certainty calculation
i<-0
kGDPL<-0
kGDPM<-0
kGDPH<-0
kGDPVH<-0

kshortGDPL<-0
kshortGDPM<-0
kshortGDPH<-0
kshortGDPVH<-0


for (i in 1:1000){
  if(sum((p_R1SimL[3+i]+p_R2SimL[3+i]+p_R3SimL[3+i]+p_R4SimL[3+i]+p_R5SimL[3+i]+p_R6SimL[3+i])<sum(GDPData$GDP[1]*0.1+GDPData$GDP[2]*0.1+GDPData$GDP[3]*0.1+GDPData$GDP[4]*0.1+GDPData$GDP[5]*0.1+GDPData$GDP[6]*0.1))==(2150-2020+1)){
    kGDPL<-kGDPL+1
  }
  
  if(sum((p_R1SimM[3+i]+p_R2SimM[3+i]+p_R3SimM[3+i]+p_R4SimM[3+i]+p_R5SimM[3+i]+p_R6SimM[3+i])<sum(GDPData$GDP[1]*0.1+GDPData$GDP[2]*0.1+GDPData$GDP[3]*0.1+GDPData$GDP[4]*0.1+GDPData$GDP[5]*0.1+GDPData$GDP[6]*0.1))==(2150-2020+1)){
    kGDPM<-kGDPM+1
  }  
  
  
  if(sum((p_R1SimH[3+i]+p_R2SimH[3+i]+p_R3SimH[3+i]+p_R4SimH[3+i]+p_R5SimH[3+i]+p_R6SimH[3+i])<sum(GDPData$GDP[1]*0.1+GDPData$GDP[2]*0.1+GDPData$GDP[3]*0.1+GDPData$GDP[4]*0.1+GDPData$GDP[5]*0.1+GDPData$GDP[6]*0.1))==(2150-2020+1)){
    kGDPH<-kGDPH+1
  }  
  
  
  if(sum((p_R1SimVH[3+i]+p_R2SimVH[3+i]+p_R3SimVH[3+i]+p_R4SimVH[3+i]+p_R5SimVH[3+i]+p_R6SimVH[3+i])<sum(GDPData$GDP[1]*0.1+GDPData$GDP[2]*0.1+GDPData$GDP[3]*0.1+GDPData$GDP[4]*0.1+GDPData$GDP[5]*0.1+GDPData$GDP[6]*0.1))==(2150-2020+1)){
    kGDPVH<-kGDPVH+1
  } 
  
  if(sum((p_R1shortSimL[3+i]+p_R2shortSimL[3+i]+p_R3shortSimL[3+i]+p_R4shortSimL[3+i]+p_R5shortSimL[3+i]+p_R6shortSimL[3+i])<sum(GDPData$GDP[1]*0.1+GDPData$GDP[2]*0.1+GDPData$GDP[3]*0.1+GDPData$GDP[4]*0.1+GDPData$GDP[5]*0.1+GDPData$GDP[6]*0.1))==(2029-2020+1)){
    kshortGDPL<-kshortGDPL+1
  }
  
  if(sum((p_R1shortSimM[3+i]+p_R2shortSimM[3+i]+p_R3shortSimM[3+i]+p_R4shortSimM[3+i]+p_R5shortSimM[3+i]+p_R6shortSimM[3+i])<sum(GDPData$GDP[1]*0.1+GDPData$GDP[2]*0.1+GDPData$GDP[3]*0.1+GDPData$GDP[4]*0.1+GDPData$GDP[5]*0.1+GDPData$GDP[6]*0.1))==(2029-2020+1)){
    kshortGDPM<-kshortGDPM+1
  }  
  
  
  if(sum((p_R1shortSimH[3+i]+p_R2shortSimH[3+i]+p_R3shortSimH[3+i]+p_R4shortSimH[3+i]+p_R5shortSimH[3+i]+p_R6shortSimH[3+i])<sum(GDPData$GDP[1]*0.1+GDPData$GDP[2]*0.1+GDPData$GDP[3]*0.1+GDPData$GDP[4]*0.1+GDPData$GDP[5]*0.1+GDPData$GDP[6]*0.1))==(2029-2020+1)){
    kshortGDPH<-kshortGDPH+1
  }  
  
  
  if(sum((p_R1shortSimVH[3+i]+p_R2shortSimVH[3+i]+p_R3shortSimVH[3+i]+p_R4shortSimVH[3+i]+p_R5shortSimVH[3+i]+p_R6shortSimVH[3+i])<sum(GDPData$GDP[1]*0.1+GDPData$GDP[2]*0.1+GDPData$GDP[3]*0.1+GDPData$GDP[4]*0.1+GDPData$GDP[5]*0.1+GDPData$GDP[6]*0.1))==(2029-2020+1)){
    kshortGDPVH<-kshortGDPVH+1
  }  
}

GDPCertainty<-as.data.frame(NA)
GDPCertainty$ShortL<-kshortGDPL/1000 #short term certainty
GDPCertainty$ShortM<-kshortGDPM/1000
GDPCertainty$ShortH<-kshortGDPH/1000
GDPCertainty$ShortVH<-kshortGDPVH/1000

GDPCertainty$L<-kGDPL/1000 #long term certainty
GDPCertainty$M<-kGDPM/1000
GDPCertainty$H<-kGDPH/1000
GDPCertainty$VH<-kGDPVH/1000  



