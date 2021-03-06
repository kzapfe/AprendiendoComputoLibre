library(magrittr) # para usar el operador %in%
library(stringr) # para usar str_sub

### Primero le quitamos a los datos la info privada
datos <- read.csv("VoluntariosEstados19s.csv")

### Vamos a inventar una funcion que nos deje la lada pero que quite el telefono

sacalada <- function(telnumer){
    result <- str_sub(telnumer, 1,3)
    return(result)
}

###aplicamos la funcion a cada elemento de la columna y la hacemos nueva col
datos["Lada"] <- apply(datos["Teléfono"], 1, sacalada)
    
quitar <- c("Apellido.Paterno", "Apellido.Materno", "Correo", "Teléfono", "Nombre.Completo")
datos <- datos[ ,!( names(datos) %in% quitar ) ] #Observen como negamos las columnas con !

write.csv(datos, "VoluntariosSanitizados.csv") #Y hacemos un cvs mas privado

#datos <- read.csv("VoluntariosSanitizados01.csv") #y lo volvemos a cargar


str_sub("tuabuela", -1,-1) #Esto nos da el último caracter de "tuabuela"
                                   

posiblegenero <- function(nombre) {
    ## esta función le pone "Fem" o "Mas" dependiendo de la ultima letra del nombre
    if (str_sub(nombre, -1,-1) =="a"){
        resultado <- "Fem"}
else{
    resultado <- "Mas"}
return(resultado)
} 


posiblegenero2 <- function(nombre) {
    ## esta función le pone 2 o 1 dependiendo de la ultima letra del nombre
    if (str_sub(nombre, -1,-1) =="a"){
        resultado <- 2}
else{
    resultado <- 1}
return(resultado)
}

###aplicamos la funcion a cada elemento de la columna y la hacemos nueva col
datos["PosGen"] <- apply( datos["Nombre"], 1,posiblegenero)
datos["PosGen2"] <- apply( datos["Nombre"], 1,posiblegenero2)

#Cunatas hay que cumplan con la condición dentro del which
nfems <- length(which(datos["PosGen"]=="Fem"))

#Ponemos el numero de renglon (su "nombre") como un número
datos$Secuencia <- as.numeric(rownames(datos))

#Dibujamos los puntitos.
plot(x=datos$Secuencia, y=datos$PosGen2)

#Ponemos todo en el espacio de trabajo que esta contenido en dados
attach(datos)

#cha chan,menos letras
plot(x=Secuencia, y=PosGen2)

#Le decimos a R que PosGen es una categoria
datos$PosGen <- as.factor(datos$PosGen)

###Una prueba de T para ver si hay alguna "significancia" en que si los datos son
## o no diferentes
tururu<-t.test(Secuencia~PosGen, data=datos)

#Una grafica
plot(datos$Secuencia~datos$PosGen, data=datos)


#Otra grafica mas bonita
library(ggplot2)
library(wesanderson)


###o esta otra versión

figura <- ggplot(datos, aes(x=PosGen, y=Secuencia, fill=PosGen))+
    geom_boxplot()+
    geom_jitter(width=0.04)+
    ggtitle("Dispersión de Voluntariado por Género")+
    theme_linedraw() +
    theme(legend.position="none")+
    scale_fill_manual(values=wes_palette(name="Darjeeling"))+
    scale_x_discrete(name="Posible Género")+
    scale_y_continuous(name="Secuencia de Aparición")+
    theme(text=element_text(size=14, family="Times", hjust=0.5), axis.text.x=element_text(size=12, family="Times"),
          axis.text.y=element_text(size=12, family="Times")
          )+coord_flip()+annotate("140", x=100, y=10, label="140")


figura
ggsave("DispersionPorGenero.png", plot=figura, dpi=92)



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
