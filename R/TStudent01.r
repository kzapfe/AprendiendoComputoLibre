datos<-sleep

tstudent <- t.test(extra~group, data=datos)

### Y ora que es eso?


for (i in 1:100){
    print(paste(" soy el i = ", i))
}

### Hagamos la estadistica por fuerza bruta
### primero, una funcion que nos genere lineas aleatoreas de un dataframe

rengloneslocos=function(df,n){
    ##sample(N,n) n elementos al azar de N enteros
    return(df[sample(nrow(df),n),])
}

## Cuantos hay
choose(20,10)
#
###muchisimos.
###empezemos
mean(rengloneslocos(datos,10)$extra)
## Ora queremos UN montonal

muchos <- replicate(5000,mean(rengloneslocos(datos,10)$extra))
hist(muchos,breaks=10)

library(ggplot2)
library(wesanderson)

ggplot(datos,aes(x=group,y=extra))+geom_boxplot()
