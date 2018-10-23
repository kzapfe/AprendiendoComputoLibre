# Codigo de Stephane Keil - 18/11/2017
### Modificado Por wpkzz


#Curso de R para emergencias- sesion 1.5



ls() #Lista de Objetos Creados
rm(list =ls()) #Truco para borrar todo

library(dplyr)
library(stringr)
library(ggplot2)

getwd()
setwd("/home/stuka/Desktop/SismoCDMX/R para emergencias/Datos/")
dir()

transporte <- read.csv("Transporte_Otros_21_09_2017.csv")

head(transporte,5)
names(transporte)

summary(transporte) #Resumen express
View(transporte)

glimpse(transporte) #Pequeño ojaso a los titulares.

class(transporte$Tipo.de.ayuda)

 #Editamos esto
transporte$tipo_ayuda_limpio <- as.character(transporte$Tipo.de.ayuda)

transporte$tipo_ayuda_limpio %>% unique
transporte$tipo_ayuda_limpio %>% table

df <- data.frame(hola=integer())

df$hola <- c(1,2,3,4)
df$adios <- df$hola

# ?gsub
transporte$tipo_ayuda_limpio[which(grepl(".*transporte.*",ignore.case = TRUE,transporte$tipo_ayuda_limpio))] <- 1

transporte$tipo_ayuda_limpio[which(transporte$tipo_ayuda_limpio != 1)] <- 0

transporte_solo <- transporte %>% filter(tipo_ayuda_limpio == 1)

summary(transporte_solo)

transporte_solo %>% select(Tipo.de.Transporte) %>% unique

which(transporte_solo$Tipo.de.Transporte == "Motocicleta, Camión de Carga, Trailer, Aviones")

transporte_solo[147,]

transporte_solo$Tipo.de.Transporte <- gsub(".*Aviones.*","avion",ignore.case = TRUE,transporte_solo$Tipo.de.Transporte)

transporte_solo$Tipo.de.Transporte <- gsub("Automóvil","automovil",ignore.case = TRUE,transporte_solo$Tipo.de.Transporte)
transporte_solo$Tipo.de.Transporte <- gsub(".*Trailer.*","trailer",ignore.case = TRUE,transporte_solo$Tipo.de.Transporte)
transporte_solo$Tipo.de.Transporte <- gsub(".*Grúa.*","grua",ignore.case = TRUE,transporte_solo$Tipo.de.Transporte)
transporte_solo$Tipo.de.Transporte <- gsub("Autobús","autobus",ignore.case = TRUE,transporte_solo$Tipo.de.Transporte)
transporte_solo$Tipo.de.Transporte <- gsub(".*Remolques.*","remolques",ignore.case = TRUE,transporte_solo$Tipo.de.Transporte)
transporte_solo$Tipo.de.Transporte <- gsub(".*retroexcavadora.*","maquinaria pesada",ignore.case = TRUE,transporte_solo$Tipo.de.Transporte)
transporte_solo$Tipo.de.Transporte <- gsub("Camión de Redilas","camion",ignore.case = TRUE,transporte_solo$Tipo.de.Transporte)
transporte_solo$Tipo.de.Transporte <- gsub("Camión de Carga","camion",ignore.case = TRUE,transporte_solo$Tipo.de.Transporte)
transporte_solo$Tipo.de.Transporte <- gsub("Camión de Carga","camion",ignore.case = TRUE,transporte_solo$Tipo.de.Transporte)
transporte_solo$Tipo.de.Transporte <- gsub("Camión","camion",ignore.case = TRUE,transporte_solo$Tipo.de.Transporte)

transporte_solo$Tipo.de.Transporte <- gsub("automovil, camioneta","camioneta",ignore.case = TRUE,transporte_solo$Tipo.de.Transporte)

transporte_solo %>% select(Tipo.de.Transporte) %>% unique

transporte_solo %>% select(Tipo.de.Transporte) %>% table

class(transporte_solo$Tipo.de.Transporte)

transporte_solo$Tipo.de.Transporte <- factor(transporte_solo$Tipo.de.Transporte)

transporte_solo$Tipo.de.Transporte
transporte_solo$Tipo.de.Transporte %>% summary
plot(transporte_solo$Tipo.de.Transporte)

edit(transporte_solo) #aaa no pasa nada... Que hicimos mal??

transporte_solo <- edit(transporte_solo) #ajajaja


glimpse(transporte_solo)
View(transporte_solo)

transporte_solo$Tipo.de.Transporte[agrep("autobus", transporte_solo$Tipo.de.Transporte)]<-"camion"
transporte_solo$Tipo.de.Transporte[agrep("auto", transporte_solo$Tipo.de.Transporte)]<-"automovil"
transporte_solo$Tipo.de.Transporte[agrep("Motocicleta", transporte_solo$Tipo.de.Transporte)]<-"Motocicleta"
transporte_solo$Tipo.de.Transporte[transporte_solo$Tipo.de.Transporte==""]<-NA


transporte_solo <- droplevels(transporte_solo)

write.csv(transporte_solo, "Transporte_MedioLimpio.csv")


ggplot(transporte_solo,aes(x=Tipo.de.Transporte, fill = Tipo.de.Transporte)) + geom_bar()+guides(fill=FALSE)

?ggplot

###ahora vamos a divertirnos un poco con el diseño
# install.packages("wesanderson")

library("wesanderson")

names(wes_palettes)

wes_palette("Moonrise3")

pal <- wes_palette("Moonrise3",22, type="continuous")

dev.new(width=15, height=12)

grafo1 <- ggplot(transporte_solo,aes(x=reorder(transporte_solo[[17]],-table(transporte_solo[[17]])[transporte_solo[[17]]]),
                           fill = factor(transporte_solo[[17]])
                           )) + geom_bar(na.rm=FALSE) +
    scale_fill_manual(values=pal)+
  ggtitle("Histograma de tipos de transporte ofrecidos del 21/09 a 16/11 para respuesta al sismo") +
  labs(x="Tipo de Vehiculo",y="Número de ofrecimmientos") +
    theme(axis.text.x = element_text(angle=90,size=8),
          plot.title=element_text(size=12),
          axis.title=element_text(size=10),
          legend.position="none")

ggsave("Tipodetransporte.png", plot=grafo1, width=50,height=32,units="cm",dpi=300)


