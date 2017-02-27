# aprendiendo a usar R en emacs

datos<-read.csv("PPB\ 500.csv") #cargar el archivo
tiempos<-datos[5]/60000 #Tiempos en minutos,
verdefeo="#38541A" #especificamos un color en rgb hex
violetachido=rgb(0.9,0.2,0.9) #otra forma de especificar como funcion
hgdisp<-hist(tiempos[,1],200, freq=FALSE) #calcula el histograma, normalizado
densidad<-density(tiempos[,1], bw=1./3.) #estima una funcion de probabilidad de arriba.


layout(matrix(c(1,2),2,1,byrow=TRUE),heights=c(2,1)) #preparamos un #marco para dos graficas, una arriba y una abajo, en columna, la de arriba del doble de alto
par(mar=c(1,4,1,1)) #margenes: un renglon abajo, cuatro izq, 1 arriba, 1 derecha
plot(hgdisp,main="Disparos neuronales exp. Leo",
     col=verdefeo, border="white", xlab=NULL,
     ylab="freq.", axes=FALSE, freq=FALSE)#dibujamos el histograma

lineasd<-lines(densidad, lw=3, col="blueviolet") #le superponemos la
axis(2) #eje de la prob. de disparo nada mas

                                        #nuevo comando plot, nueva grafica: debajo ponemos los disparos neuronales
par(mar=c(4,4,1,0))
plot(tiempos, frame.plot=FALSE, pch="|", xlab="tiempo en minutos", main=NULL)


dev.print(pdf, "DensidadDisparos02.pdf", height=3.5, width=10)
                                        # impre a archivo. Son pulgadas




