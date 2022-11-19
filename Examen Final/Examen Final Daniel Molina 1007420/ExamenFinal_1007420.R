##FINAL DANIEL MOLINA 1007420

##SERIE 2

library(caret)
library(rpart)
library(rpart.plot)
library(e1071)


file.choose()

#Cargar datos
datos <- read.csv("C:\\Users\\josda\\OneDrive\\Escritorio\\6to. Semestre\\Analisis de datos\\final.csv", sep = ';')

#Estad?stica general de los datos
summary(datos)

##Feature engineering
##estimacion 

library(dplyr)
library(ggplot2)

glimpse(datos)


library(naniar)
library(zoo)
library(dplyr)
library(VIM)
library(caret)
library(factoextra)
n_miss(datos)


library(tidyverse)


library(caret)

head(datos)
pairs(datos)


datos2 <- select(datos,-Population) # borrar columna
head(datos2, n=50)

##Regresiones
cor(datos)

##CORRELACION ENTRE VARIABLES
install.packages("PerformanceAnalytics")
library(PerformanceAnalytics)

dat1 <- data.frame(datos)
chart.Correlation(dat1)

