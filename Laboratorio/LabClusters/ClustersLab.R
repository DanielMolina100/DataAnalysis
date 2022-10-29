##JOSE DANIEL MOLINA GALINDO 
##LABORATORIO 3 
##CLUSTERING

install.packages("readr")
library(readr)
file.choose()

segmentacion1<-"C:\\Users\\josda\\OneDrive\\Escritorio\\6to. Semestre\\Analisis de datos\\segmentation_data.csv"

data1<- read.csv(segmentacion1)

head(data1)

##Eliminando los datos nulos de la BD que no son utilizados en el programa

nulos<-na.omit(data1)
head(nulos, n=10)

##Determinar el numero ideal de clusters, de acuerdo a la ley codo, justificando de 
##manera Graficas su decision
library(tidyverse)  
library(cluster)    
library(factoextra) 

install.packages("devtools")
library(devtools)
set.seed(123)
wcss <- vector()
for(i in 1:20){
  wcss[i] <- sum(kmeans(nulos, i)$withinss)
}

library(ggplot2)
ggplot() + geom_point(aes(x = 1:20, y = wcss), color = 'red') + 
  geom_line(aes(x = 1:20, y = wcss), color = 'skyblue') + 
  ggtitle("Método del Codo") + 
  xlab('Cantidad de Centroides k') + 
  ylab('WCSS')


##OTRA FORMA PARA SABER EL NÚMERO DE CLUSTERS
avg_sil <- function(k) {
  km.res <- kmeans(nulos, centers = k, nstart = 25)
  ss <- silhouette(km.res$cluster, dist(data1))
  mean(ss[, 3])
}

k.values <- 2:15


avg_sil_values <- map_dbl(k.values, avg_sil)

plot(k.values, avg_sil_values,
     type = "b", pch = 19, frame = FALSE, 
     xlab = "Número de clusters K",
     ylab = "promedio")

##Hacer un clustering con el número ideal de cluster en este caso el número
##ideal es el 3 porque es el que muestra más cambio.

d2f=data.frame(nulos)
require(cluster)
pam.res <- pam(d2f, 3)
# Visualización
fviz_cluster(pam.res, geom = "point", ellipse.type = "norm",
             show.clust.cent = TRUE,star.plot = TRUE)+
  labs(title = "Resultados clustering K-means")+ theme_bw()

kmedias <- kmeans(nulos,3, nstart = 50)
fviz_cluster(kmedias, data = nulos)

##EJERCICIO 2 feature engineering 
file.choose()


segmentacion2<-"C:\\Users\\josda\\OneDrive\\Escritorio\\6to. Semestre\\Analisis de datos\\marketing_campaign.csv"
data2<- read.csv(segmentacion2)

head(data2)

##Valores NA
install.packages("naniar")
library(naniar)
install.packages("zoo")
library(zoo)
install.packages("dplyr")
library(dplyr)
install.packages("VIM")
library(VIM)
install.packages("caret")
library(caret)
install.packages("factoextra")
library(factoextra)

##Este comando sirve para determinar cuantos valores faltan
n_miss(data2)


prop_miss(data2)
miss_var_summary(data2)
miss_case_summary(data2)

##Con este comando podemos saber los números de los datos NA que hay en cada columna
colSums(is.na(data2))
eliminar_NA<-na.omit(data2)
eliminar_NA

##ELIMINAR TABLAS QUE NO SIRVEN X1-X11 EN LAS COLUMUNAS NA 
base<-data2[,-27]
base2<-base[,-26]
base3<-base2[,-25]
base4<-base3[,-24]
base5<-base4[,-23]
base6<-base5[,-22]
base7<-base6[,-21]
base8<-base7[,-20]
base9<-base8[,-19]
base10<-base9[,-18]
base11<-base10[,-17]
base12<-base11[,-16]
base12


n_miss(base12)

##ELIMINAR DATOS EN LAS FILAS
prop_miss(base12)
miss_var_summary(base12)
miss_case_summary(base12)

base13<-na.omit(base12)
base13


Sk2  <-kmeans(base13,centers = 2,nstart = 25) 
fviz_cluster(k2,data=base13)

##NUMERO IDEAL DE CLUSTER

library(devtools)
set.seed(123)
wcss <- vector()
for(i in 1:20){
  wcss[i] <- sum(kmeans(base13, i)$withinss)
}

library(ggplot2)
ggplot() + geom_point(aes(x = 1:20, y = wcss), color = 'red') + 
  geom_line(aes(x = 1:20, y = wcss), color = 'skyblue') + 
  ggtitle("Método del Codo") + 
  xlab('Cantidad de Centroides k') + 
  ylab('WCSS')


##OTRA FORMA PARA SABER EL NÚMERO DE CLUSTERS
