
mav <- read.csv("Mercado Activo (OfertaDemanda) #Verificado19S - Voluntarios.csv", header=TRUE, skip=1)

colnames(mav)

rownames(mav)

colnames(mav) <- as.character(unlist(mav[6,]))

str(mav)

mav <- edit(mav)

mav <- mav[2:1034,]
mav <- tail(mav,-1)

mav <- mav[-5,]

levels(mav[,"Delegación/Municipio"])
delmu <- mav[,"Delegación/Municipio"]


library(lubridate)

Sys.getlocale()

Sys.getlocale("LC_TIME")

today()

now()


coches <- read.csv("Transporte_MedioLimpio.csv")


coches$timestamp <- mdy_hms(coches$Timestamp, tz="Mexico/General")

coches$fecha <- date(coches$timestamp)

hist(coches$fecha,breaks="days",freq=TRUE)

hist(coches$fecha,breaks="months")

hist(coches$fecha,breaks="weeks")

hist(coches$timestamp,breaks="hours")

coches$diasem <- factor(weekdays(coches$timestamp))

plot(coches$diasem)

hist(hour(coches$timestamp))

### Reordenar levels

coches$diasem <- factor(weekdays(coches$timestamp),levels=c("lunes","martes","miércoles","jueves","viernes","sábado","domingo"))

plot(coche$diasem)

hist(hour(coche$timestamp))

### Volvamos a ggplot2
##coches$timestamp <- mdy_hms(coche_solo$Timestamp)
library("ggplot2")
library("wesanderson")

pal <- wes_palette("Darjeeling", 24, type="continuous")

ggplot(coches, aes(date(coches$fecha),fill = coches$Tipo.de.Transporte)) + geom_bar()+scale_fill_manual(values=pal)
