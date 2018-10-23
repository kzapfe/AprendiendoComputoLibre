
                                        # Codigo de Stephane Keil - 18/11/2017

#Curso de R para emergencias- sesion 1



library(dplyr)
library(ggplot2)
library(lubridate)
library(stringr) # no se si la usemos.

########## Empieza limpieza de datos de transporte

# Nombre de la tabla: "Transporte_Otros_21_09_2017.csv"
# Diccionario de datos 
#[1] "Timestamp" - Hora a la que se lleno la encuesta                                                    
# [2] "Estado" - Donde se ofrece la ayuda                                                             
# [3] "Delegación" - Que delegacion                                                         
# [4] "Municipio"                                                          
# [5] "Colonia"                                                            
# [6] "Calle"                                                              
# [7] "Describe.lo.que.tienes.y.cuánto" - Que ofrezco                                    
# [8] "X.Cuándo.está.disponible."                                          
# [9] "Día.de.Salida"                                                      
# [10] "Hora.Aproximada.de.Salida"                                          
# [11] "Estado.de.Destino"                                                  
# [12] "Ciudad.o.Municipio.de.Destino"                                      
# [13] "Redes.Sociales.del.Acopio.de.Destino..en.caso.de.que.exista...Fb.Tw"
# [14] "Tipo.de.ayuda"                                                      
# [15] "Tiempo.de.Salida"                                                   
# [16] "Disponibilidad.de.Horario..transporte.flexible."                    
# [17] "Tipo.de.Transporte"                                                 
# [18] "Cupo.Adicional..número.de.personas."                                
# [19] "Cupo.Adicional..aproximado.en.kg."                                  
# [20] "Comentarios"   





transporte <- read.csv("Datos/Transporte_Otros_21_09_2017.csv")

transporte$timestamp <- mdy_hms(transporte$Timestamp, tz="Mexico/General")
transporte$fecha <- date(transporte$timestamp)

verdefeo="#38541A" #especificamos un color en rgb hex
violetachido=rgb(0.9,0.2,0.9) #otra forma de especificar como funcion

tiempos <- transporte$timestamp

hdia<-hist(tiempos, freq=FALSE
         , breaks="days") #calcula el histograma, normalizado
hhora<-hist(tiempos, freq=FALSE
           , breaks="hour") #calcula el histograma, normalizado

densidad<-density(as.numeric(tiempos), bw=100000) #estima una funcion de probabilidad de

###densidad <- densidad$y*612

layout(matrix(c(1,2),2,1,byrow=TRUE),heights=c(2,1)) #preparamos un #marco para dos graficas, una arriba y una abajo, en columna, la de arriba del doble de alto
par(mar=c(1,4,1,1)) #margenes: un renglon abajo, cuatro izq, 1 arriba, 1 derecha
plot(hdia,main="Ofertas Diarias",
     col=verdefeo, border="white", xlab=NULL,
     ylab="Densidad de Ofertas", axes=FALSE, freq=FALSE)#dibujamos el histograma
##box(hhora,main="Ofertas Diarias",
    3  col="#282912", border="white", xlab=NULL,
  #   ylab="Densidad de Ofertas", axes=FALSE, freq=FALSE)#dibujamos el histograma
lineasd<-lines(densidad, lw=3, col="blueviolet") #le superponemos la
axis(1) #eje de la prob. de disparo nada mas

                                        #nuevo comando plot, nueva grafica: debajo ponemos los disparos neuronales
par(mar=c(4,4,1,0))
plot(tiempos, frame.plot=FALSE, pch="|", xlab="Tiempos por oferta", main=NULL)



