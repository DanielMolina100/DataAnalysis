library(tidyverse)
library(tidyr) 
library(tidyselect)
library(plotly)
library(dplyr)
library(corrplot)
library(caTools)
library(ade4)
library(data.table)
library(ggplot2)
library(readr)
library(lubridate)
#----------------------------------------------------------------------------
df_all1<-read.csv("C:/Users/benja/Downloads/house_rent_result10.csv")

df_all1$Area.Locality <- as.numeric(factor(df_all1$Area.Locality))
df_all1$Floor <- as.numeric(factor(df_all1$Floor))

ohe_feats1 = c('City', 'Furnishing.Status', 'Area.Type',
              'Tenant.Preferred', 'Point.of.Contact')
for (f in ohe_feats1){
  print(f)
  df_all_dummy1 = acm.disjonctif(df_all1[f])
  df_all1[f] = NULL
  df_all1 = cbind(df_all1, df_all_dummy1)
}
glimpse(df_all1)
names(df_all1)
df_all1$Area.Type.BuiltArea <- 0
df_all1$Point.of.Contact.ContactBuilder <- 0
colnames(df_all1)[16]  <- "Furnishing.Status.SemiFurnished"
colnames(df_all1)[18]  <- "Area.Type.CarpetArea"
colnames(df_all1)[19]  <- "Area.Type.SuperArea"
colnames(df_all1)[21]  <- "Tenant.Preferred.BachelorsFamily"
colnames(df_all1)[23]  <- "Point.of.Contact.ContactAgent"
colnames(df_all1)[24]  <- "Point.of.Contact.ContactOwner"

#----------------------------------------------------------------------------
Mes1=format(as.Date(df_all1$Posted.On, format="%Y-%m-%d"),"%m")
Mes1
dfmes1 <- c(Mes1)
dfmes1
df_all1['mes'] <- dfmes1
df_all1$mes <- as.integer(df_all1$mes) 
Dia1=format(as.Date(df_all1$Posted.On, format="%Y-%m-%d"),"%d")
Dia1
dfdia1 <- c(Dia1)
dfdia1
df_all1['dia'] <- dfdia1
df_all1$dia <- as.integer(df_all1$dia) 
#----------------------------------------------------------------------------
df_all<-read.csv("C:/Users/benja/Downloads/house_rent_result90 (2).csv")

df_all$Area.Locality <- as.numeric(factor(df_all$Area.Locality))
df_all$Floor <- as.numeric(factor(df_all$Floor))
ohe_feats = c('City', 'Furnishing.Status', 'Area.Type',
              'Tenant.Preferred', 'Point.of.Contact')
for (f in ohe_feats){
  print(f)
  df_all_dummy = acm.disjonctif(df_all[f])
  df_all[f] = NULL
  df_all = cbind(df_all, df_all_dummy)
}
names(df_all)
colnames(df_all)[16]  <- "Furnishing.Status.SemiFurnished"
colnames(df_all)[18]  <- "Area.Type.BuiltArea"
colnames(df_all)[19]  <- "Area.Type.CarpetArea"
colnames(df_all)[20]  <- "Area.Type.SuperArea"
colnames(df_all)[22]  <- "Tenant.Preferred.BachelorsFamily"
colnames(df_all)[24]  <- "Point.of.Contact.ContactAgent"
colnames(df_all)[25]  <- "Point.of.Contact.ContactBuilder"
colnames(df_all)[26]  <- "Point.of.Contact.ContactOwner"
#--------------------------------------------------------------------------
Mes=format(as.Date(df_all$Posted.On, format="%Y-%m-%d"),"%m")
Mes
dfmes <- c(Mes)
dfmes
df_all['mes'] <- dfmes
df_all$mes <- as.integer(df_all$mes) 
Dia=format(as.Date(df_all$Posted.On, format="%Y-%m-%d"),"%d")
Dia
dfdia <- c(Dia)
dfdia
df_all['dia'] <- dfdia
df_all$dia <- as.integer(df_all$dia) 
#--------------------------------------------------------------------------
cor_matrix<-cor(df_all[,c(3,4,5,8, 27, 28)])

cor_matrix

corrplot(cor_matrix, addCoef.col = TRUE)
#--------------------------------------------------------------------------
set.seed(2022)
train <- df_all
test <- df_all1
head(train)
names(train)
head(test)

model<-lm(Rent~ BHK + Size + Bathroom + City.Bangalore + City.Chennai + City.Delhi + City.Hyderabad 
          + City.Kolkata + City.Mumbai + Furnishing.Status.Furnished + Furnishing.Status.SemiFurnished + 
            Furnishing.Status.Unfurnished + Area.Type.BuiltArea + Area.Type.CarpetArea + 
            Area.Type.SuperArea + Tenant.Preferred.Bachelors + Tenant.Preferred.BachelorsFamily + 
            Tenant.Preferred.Family + Point.of.Contact.ContactAgent + Point.of.Contact.ContactBuilder + 
            Point.of.Contact.ContactOwner + mes + dia + Area.Locality, data=train)
summary(model)


#-------------------------------------------------------------------------

test$Rent<-predict(model,test)
head(test)

write.csv(test[,c("rownum","Rent")], file="C:/Users/benja/Downloads/diames6.csv",row.names=FALSE)
write.csv(test,"C:/Users/benja/Downloads/Paramoy3.csv", row.names = FALSE)