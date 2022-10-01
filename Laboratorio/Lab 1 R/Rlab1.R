##DANIEL MOLINA 1007420

gatos <- data.frame(color = c("blanco", "negro", "gris"), peso = c(1,2,3), propietario = c(1,0,1))
View (gatos)
gatos$color
gatos$peso
gatos$peso+2
View(gatos)

paste("el color del gato es",gatos$color)

class(gatos$color)
class(gatos$peso)

class(gatos)
View(gatos)

str(gatos$color)

mi_vector<- c(2,6,3)

mi_vector

vector_caracteres<-c(2,6,"3")


vector_caracteres

num_a<- as.logical(vector_caracteres)
num_a

num_a_num<- as.numeric(vector_caracteres)
num_a_num

gatos$propietario
class(gatos$propietario)
gatos$propietario <- as.logical(gatos$propietario)
gatos$propietario
class(gatos$propietario)

ab <- c("a","b")
ab
abc<-c("ab","c")
abc
myserie<1:10
myserie
str(myserie)


class(myserie)
myserie<-1:5
names(myserie)<-c("a","b","c","d","e")
names(myserie)
myserie


##LISTAS
lista <- list(1,"AB",TRUE,1+4i)
lista
otra_lista<- list(tittle="numbers",numbers=1:10,data=TRUE)
otra_lista

#matrices
matrix <- matrix(0,ncol=6,nrow=3)
matrix

matrix <- matrix("a",ncol=6,nrow=3)
matrix

##Dimensions


class(matrix)
typeod(matrix)

dim(matrix)

players_15<-read.csv("players_15.csv")
players_15
View(otra_lista)
View(lista)
View(matrix)




