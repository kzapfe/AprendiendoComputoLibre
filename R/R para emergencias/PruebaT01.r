library(magrittr)
library(stringr)

datos <- read.csv("VoluntariosEstados01.csv")
quitar <- c("Apellido.Paterno", "Apellido.Materno", "Correo", "Telefono")
datos <- datos[,!(names(datos) %in% quitar)]
write.csv(datos, "VoluntariosSanitizados.csv")

datos <- read.csv("VoluntariosSanitizados01.csv")

str_sub("tuabuela", -1,-1)

posiblegenero <- function(nombre) {
    if (str_sub(nombre, -1,-1) =="a"){
        resultado <- "Fem"}
else{
    resultado <- "Mas"}
return(resultado)
}


posiblegenero2 <- function(nombre) {
    if (str_sub(nombre, -1,-1) =="a"){
        resultado <- 2}
else{
    resultado <- 1}
return(resultado)
}

###aplicamos la funcion a cada elemento de la columna y la hacemos nueva col

datos["PosGen"] <- apply( datos["Nombre"], 1,posiblegenero)

nfems <- length(which(datos["PosGen"]=="Fem"))

datos$Secuencia <- as.numeric(rownames(datos))
plot(x=datos$Secuencia, y=datos$PosGen2)
plot(datos$Secuencia~datos$PosGen)

attach(datos)

## Pos hagamos la estadística
randomRows = function(df,n){
   return(df[sample(nrow(df),n),])
}

##Cuantos grupos asi podriamos separar
choose(20,11)

muchos<-5000

promedios<-c()
for (i in 1:muchos){
 promedios[i]=mean(randomRows(datos,nfems)$Secuencia)
}

promfem <- 101.1522

tantos<-length(promedios[promedios<promfem])

nuestrap=1.0-tantos/muchos
