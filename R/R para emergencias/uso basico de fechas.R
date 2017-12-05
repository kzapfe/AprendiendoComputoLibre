#### Stephane Keil
# Mini tutorial para uso de fechas

library(lubridate)

Sys.getlocale()
Sys.getlocale("LC_TIME")

today()

now()

transporte$timestamp <- mdy_hms(transporte$Timestamp)

transporte$fecha <- date(transporte$timestamp)

hist(transporte$fecha,breaks="days")

hist(transporte$fecha,breaks="months")

hist(transporte$fecha,breaks="weeks")

hist(transporte$timestamp,breaks="hours")

transporte$diasem <- factor(weekdays(transporte$timestamp))

plot(transporte$diasem)

hist(hour(transporte$timestamp))

### Reordenar levels

transporte$diasem <- factor(weekdays(transporte$timestamp),levels=c("lunes","martes","miércoles","jueves","viernes","sábado","domingo"))

plot(transporte$diasem)

hist(hour(transporte$timestamp))

### Volvamos a ggplot2
transporte_solo$timestamp <- mdy_hms(transporte_solo$Timestamp)

transporte_solo$fecha <- date(transporte_solo$timestamp)
ggplot(transporte_solo, aes(date(transporte_solo$fecha),fill = transporte_solo$Tipo.de.Transporte)) + geom_bar()
