library(ggplot2)


datos <- read.csv("Transporte_MedioLimpio.csv")

datos$datum <- mdy_hms(datos$Timestamp, tz="Mexico/General")


datos$fecha <- date(datos$datum)

grafo1 <- ggplot(datos, aes(date(datos$fecha),fill = datos$Tipo.de.Transporte)) + geom_bar()+scale_fill_manual(values=pal, na.value="black")
