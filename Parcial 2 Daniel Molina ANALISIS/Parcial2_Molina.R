
##Daniel Molina 1007420
install.packages("readr")
library(readr)
file.choose()


##Cueenta los datos nulos 
sapply(data1, function(x) sum(is.na(x)))
##Generamos los datos que se nos presentan
segmentacion1<-"C:\\Users\\josda\\OneDrive\\Escritorio\\6to. Semestre\\Analisis de datos\\Mall_Customers 5.csv"

data1<- read.csv(segmentacion1)

##Muestra los datos
head(data1)
summary(data1)

##Eliminar los datos nulos
nulos<-na.omit(data1)
head(nulos, n=10)



##LIMPIEZA DE EXAMEN


datos_limpios <- data1
datos_limpios <- Filter(function(x)!all(is.na(x)), datos_limpios)
datos_limpios<- datos_limpios[complete.cases(datos_limpios), ]
datos_limpios




#eliminar nulos
datos_limpios1<- datos_limpios[complete.cases(datos_limpios), ]
datos_limpios1<- datos_limpios[complete.cases(datos_limpios), ]
#Saber la cantidad de clusters ideales para people


fviz_nbclust(datos_limpios, kmeans, method = "wss") +
  geom_vline(xintercept = 5, linetype = 2)+
  labs(subtitle = "Elbow method")


#ley del codo pruebas que no me estaba saliendo xD

install.packages("factoextra")
library(ggplot2)
install.packages("ggplot2")
install.packages("userfull")
library(NbClust)
library(useful)
install.packages("dplyr")
library(dplyr)
library(factoextra)

fviz_nbclust(datos_limpios1, kmeans, method = "wss") +
  geom_vline(xintercept = 6, linetype = 2)+
  labs(subtitle = "Elbow method")

##ley del codo


install.packages("devtools")
library(devtools)
set.seed(123)
wcss <- vector()
for(i in 1:20){
  wcss[i] <- sum(kmeans(datos_limpios1, i)$withinss)
}

library(ggplot2)
ggplot() + geom_point(aes(x = 1:20, y = wcss), color = 'blue') + 
  geom_line(aes(x = 1:20, y = wcss), color = 'black') + 
  ggtitle("Método del Codo") + 
  xlab('Cantidad de Centroides k') + 
  ylab('WCSS')



##SE PUEDE DEMOSTRAR EL NUMERO IDEAL ES DE 2


n_miss(data1)


prop_miss(data1)
miss_var_summary(data1)
miss_case_summary(data1)

##HACEMOS EL CLUSTER CON EL NUMERO IDEAL EN EL QUE SE MUESTRA EN LA GRAFICA

d2f=data.frame(datos_limpios)
require(cluster)
pam.res <- pam(d2f, 2)
# Visualización
fviz_cluster(pam.res, geom = "point", ellipse.type = "norm",
             show.clust.cent = TRUE,star.plot = TRUE)+
  labs(title = "Resultados clustering K-means")+ theme_bw()

kmedias <- kmeans(nulos,3, nstart = 50)
fviz_cluster(kmedias, data = datos_limpios)



