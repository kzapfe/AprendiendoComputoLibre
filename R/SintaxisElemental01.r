### Una lista de comandos elementales de R para tener presente la sintáxis básica del lenguaje
### Recordad que R es de Alto Nivel (muchas funciones ya vienen listas para usarse)
### y es orientado a objetos, es decir, una funcion cambia de efecto dependiendo del objeto al cual se aplique.

### Para comentar una linea (como esta) se usa el gato o hash, o crunch.
### La convención tradicional dice que tres gatos alinean el comentario a la izquierda, dos a la ultima linea indentada, y uno a la derecha.

### Comenzamos.

### R se puede usar como calculadora de escritorio: solo ingresa lo que quieres calcular.

2+5
3*6
log(2)
sin(0.5) #Radianes
### R tira a la basura todo lo que ya no se esta usando, si quieres guardarlo asignalo a una variable
### existen dos asignaciones. Flecha <- (y al reves también) y =. Flecha es el de uso más general
x <- 0.5121
y <- 67*12.5
log(8+sin(2)) -> z
### para "imprimir" el valor de una variable simplemente ingresarla en el intérprete de comandos
z
### Otro tipo importante de variable aparte de "numeric" es "char" (carácter)
texto <- "Tralala"
### Y un primer tipo compuesto son los vectores, aqui construidos con la función c(), (concatenar).
pesos <- c(88,72,80,68,59,92)
alturas <- c(168,177,172,156,160,162)
### los objetos tienen "tipo" (fundamental) y "modo" (de alto nivel)
typeof(pesos)
mode(pesos)
### a veces tambien tienen longitud
length(pesos)
length(x)
length(texto)
### cuando tienen longitud podemos checar elementos indexados del objeto
pesos[2]
pesos[2:4]
### los dos puntos indican una secuencia, por ejemplo
1:10
### la podemos asignar tambien
secuencia <- 23:40
### a esto se le llama "azucar sintáctica", es una forma de usar la función seq(), que produce secuencias mas generales
otra <- seq(1,10) #lo mismo que 1:10
otra <- seq(1,10, 0.5) # en pasos de 0.5
otra <- seq(from=-5, length=100, by=0.2) #hasta donde llegue pero que mida 100 elementos.
### Uno puede pasar calculos con vectores. Por omisión, se hacen elemento por elemento
imc <- pesos/((alturas/100)^2)
### funciones "estadisticas básicas)
mean(pesos)
var(alturas)
### podemos hacer un objeto mas complejo, como una matriz de datos, con cbind() ("column bind") o rbind ("row bind")
datos <- cbind(pesos, alturas, imc)
typeof(datos)
class(datos) # la clase es mas alto nivel que el tipo o el modo
is.vector(datos) #funcion que checa si es de alguna clase
dim(datos)  # los tamaños de la matriz, renglones primero, columnas despues, meta columnas, etc es posible.
###  R incluye muchas herramientas para graficar. El comando básico es plot
plot(alturas,pesos,ylab="pesos", xlab="altura", main="Indice de gordura")
### un objeto mas complejo es una "tabla de datos" o "marco de datos" (dataframe)
tablita <- data.frame(datos) #tambien podemos coercer datos a ser un dataframe con as.data.frame()
### las tablitas pueden tener nombres de renglon y columna
names(tablita) ## y se pueden reasignar
str(tablita) # la estructura básica de la tabla
View(tablita)
summary(tablita) #estadistica elemental
edit(tablita) ## editor
### Un factor en R es una variable que permite agrupar otras variables, tipicamente observaciones.
### ejemplo: datos de la vel. de la luz (vienen incluidos)
datosluz <- morley
datosluz$Expt <- factor(datosluz$Expt) # el experimento
datosluz$Run <- factor(datosluz$Run) #la tirada
attach(datosluz) #poner en la mesa de trabajo, lugar 3.
levels(Expt) ##cuantos grupos define el factor Expt
##aplicar una funcion por grupo de factor
tapply(Speed, Expt, mean)
plot(Expt, Speed, main="Velocidad de la Luz", xlab="Experimento" ) ## por omision, R usa cajas para graficar cosas con factores

ls() #Los objetos definidos en el area de trabajo
rm() # borrar objetos definidos
rm(list=ls()) #pos todo
detach() # sacar variables de data frames o similares del area de trabajo.

## read.algo son funciones para cargar datos.


## Guardar una sesion sin salir
save.image(file="probando01.rda")
## o cargar una ad hoc
load("probando01.rda")
## Palabras especiales
NA #no asignado
NaN # "not a number"
Inf # que crees
q() # Salir de R interactivo

q("no")#salir sin preguntar y sin guardar.


