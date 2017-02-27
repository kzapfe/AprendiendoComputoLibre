###Empexemos por leer los datos
datos <-  read.csv("DatosIvette.csv", header=TRUE)
###Pongamos los datos bien por si no estan bien
datos <-  as.data.frame(datos)
### Los Expedientes que no son expedientes los quitamos
datos <- datos[!is.na(datos$Expediente),]
datos<-datos[!is.na(datos$Total),]

### Cuantos pacientes tomaron cada cosa
colSums(datos[,4:15])

datos$OXC<-as.factor(datos$OXC)

#veamos las diferencias.
attach(datos)
plot(OXC, Total)


###Que tan normal es ver esa desviación?


## Pos hagamos la estadística
randomRows = function(df,n){
   return(df[sample(nrow(df),n),])
}

##Cuantos grupos asi podriamos separar
choose(20,11)

muchos<-200000

promedios<-c()
for (i in 1:muchos){
 promedios[i]=mean(randomRows(datos,11)$Total)
}
promOXC<-89.63

tantos<-length(promedios[promedios<promOXC])

nuestrap=1.0-tantos/muchos



