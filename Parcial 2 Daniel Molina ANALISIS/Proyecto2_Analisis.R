install.packages("readr")
library(readr)
file.choose()


##Mostramos los datos del dataset número 1
dataset1<-"C:\\Users\\josda\\OneDrive\\Escritorio\\6to. Semestre\\Analisis de datos\\house_rent_result90.csv"

csv1<- read.csv(dataset1)

csv1

library(tidyverse)   
library(tidyr) 
library(tidyselect)
install.packages('plotly')
library(plotly)
library(dplyr)
install.packages('corrplot')
library(corrplot)
install.packages('caTools')
library(caTools)
library(htmlwidgets)
install.packages('IRdisplay')
library('IRdisplay')

house_data<-drop_na(csv1)
head(house_data)

dim(house_data)
summary(house_data)
str(house_data)
names(house_data)
sum(is.na(house_data))


cor_matrix<-cor(house_data[,c(2,3,4,11)])

cor_matrix

corrplot(cor_matrix, addCoef.col = TRUE)




