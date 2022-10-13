##LABORATORIO 2 USANDO DPLYR Y GGPLOT
##DANIEL MOLINA 1007420
title:"Laboratorio de bicicletas"
output: html_notebook

##buscamos el archivo de las bicicletas
file.choose()
library(readxl)
##PREFERIBLE TRABAJAR CON ARCHIVO XLS Y NO CON CSV ES MÁS FACIL GENERAR DATOS
ruta_excel <- "C:\\Users\\josda\\OneDrive\\Documentos\\Lab2\\hour - copia.xls"
excel_sheets(ruta_excel)
caso <-read_excel(ruta_excel)

##con esto se muestra el csv
head(caso)

##1
##Que mes tiene mayor demanda

mayor_demanda<-caso$mnth
mayor_demanda<- summary(factor(mayor_demanda))
mayor_demanda
barplot(mayor_demanda, xlab="Mes", ylab="Mayor demanda", main="Numero de mes con mayor demanda")
maxXmes<-which(mayor_demanda == max(mayor_demanda)) 
result1<-c(maxXmes)

##que número de mes tiene mayor demanda
result1[[1]]

##2
##Que hora tiene mas demanda
horamax<-caso$hr
horamax<-summary(factor(horamax))
horamax
barplot(horamax, xlab="Hora", ylab="Mayor demanda", main="Numero de hora con mayor demanda")

maxHora<-which(horamax == max(horamax)) 
Result2<-c(maxHora)
Result2
Result2[[1]]


##3
##QUE TEMPORADA ES MÁS ALTA
Temp_demanda<-caso$season
Temp_demanda<-summary(factor(Temp_demanda))
Temp_demanda

##1 primavera 2 verano 3 otoño 4 invierno
names(Temp_demanda)<-c("Primavera", "Verano", "Otoño", "Invierno")
barplot(Temp_demanda, xlab="Temporada", ylab="Mayor Demanda", main="Total de demandas por temporadas", las=1)
TempXMax<-which(Temp_demanda == max(Temp_demanda)) 
resultado3<-TempXMax
resultado3

##4
## a que temperatura es más baja
temperatura_baja<-caso$temp
temperatura_baja<-summary(factor(temperatura_baja))
temperatura_baja

resultado4<-which(temperatura_baja == min(temperatura_baja))
result4<-resultado4
result4[[1]]

##5
## A que humedad baja la demanda
humedad_baja<-caso$hum
humedad_baja<-summary(factor(humedad_baja))
humedad_baja

humedad_bajisima<-which(humedad_baja==min(humedad_baja))
result5<-humedad_bajisima
result5
result5[[1]]

##6
##Que condiciones climaticas serian ideales para la demanda
##humedad
ideal_condicion<-humedad_baja>=500
ideal_condicion<-subset(ideal_condicion, ideal_condicion==1) 
names(ideal_condicion)
##temporada
idea_condicion2<-Temp_demanda>=500
idea_condicion2<-subset(idea_condicion2, idea_condicion2==1)
names(idea_condicion2)


##7
##Muestre una gráfica con la densidad de rentas
library(ggplot2)

dim(caso)

densidad_rentas<-ggplot(data=caso) + aes(x=cnt, y=..density..)+geom_histogram()+geom_density()
densidad_rentas+labs(title="Grafico de densidad de rentas",
                     subtitle="Datos de bicicletas",
                     x="densidad",
                     y="rentas totales")+
  theme(plot.title=element_text(color="blue",hjust=0.5))
  
##8
##PROMEDIO DE PERSONAS QUE RENTAN BICICLETAS Y ESTAN REGISTRADAS
##USAMOS LA LIBRERIA dplyr
promedio_rentas<-caso$registered
promedio_rentas<- summary(factor(promedio_rentas))
promedio_rentas
arithmetic.mean <- function(x) {sum(x)/length(x)}
arithmetic.mean(promedio_rentas)

library(tidyverse)  
caso
attach(caso) 
mean(registered)  

##9
##Mediana de los que no estan registradas
median(casual)

##10
##Determine la renta total, renta promedio por cada tipo de condición climatica
condicion_promedio <- caso%>%
  group_by(weathersit)%>%
  summarise(promedio_condicion=sum(cnt),renta=mean(cnt))%>%
  arrange(desc(promedio_condicion))
condicion_promedio


##11
##Determine y muestre una gráfica de barras de cada renta por tipo de temporada. 
library(tidyverse)
attach(caso)
library(ggplot2)
library(data.table) 

ggplot(caso, aes(x=season,y=cnt, fill=season))+geom_bar(stat="identity")+
  theme_classic()
            

##12
##Muestre una gráfica de la densidad por hora. 
library(ggplot2)

dim(caso)

densidad_rentas<-ggplot(data=caso) + aes(x=hr, y=..density..)+geom_histogram()+geom_density()
densidad_rentas+labs(title="Grafico de densidad por hora",
                     subtitle="Datos de bicicletas",
                     x="Horas",
                     y="Rentas")+
  theme(plot.title=element_text(color="SKYBLUE",hjust=0.5))


##13
##Muestre una gráfica de barras por día del mes como eje x y la cantidad total de alquileres como el eje Y.


ggplot(caso, aes(x=dteday,y=cnt, fill=dteday))+geom_bar(stat="identity")+
  theme_classic()
















