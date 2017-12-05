
                                        # Codigo de Stephane Keil - 18/11/2017

#Curso de R para emergencias- sesion 1



install.packages("readr")            # for importing data
install.packages("dplyr")
install.packages("ggplot2")
install.packages("stringr")
install.packages("lubridate")
install.packages("tidyr")

library(dplyr)
?storms


2+3
2+3 * 2
(2+3)*2

x <- 4
x*2
x <- x * 2
xtemp <- x*2
xoriginal <- x
x <- xtemp
rm(xtemp)

vec <- c(1,3,6,4,23,12)
vec
vec[1]
vec[5]
vec[c(1,3,5)]
?c
??length
?length
length(vec)
nombres <- c("Stephane","Elias","Mayela","Adrian","Mirtha","Juan")
unvector <- c(1,23.1,TRUE)
TRUE
FALSE
tabla <- data.frame(cbind(nombres,vec))
class(tabla)
summary(tabla)
str(tabla)
tabla[1,]
tabla[,1]
tabla[5,2]
class(tabla$vec)
tabla$vec <- as.numeric(as.character(tabla$vec))
tabla[5,2] <- 22
tabla$vec[5] <- 18

?iris
iris
plot(iris)
str(iris)
plot(iris[c(1,2,3,4)], col = iris$Species)
plot(iris[c(1,2,3,4)], col = "red")

s <- storms
names(storms)
?storms
vector_unicos <- unique(s$name)

vector_unicos[order(vector_unicos)]
?order
unique(s$name)[order(unique(s$name))]

storms_katrina <- s[which(s$name == "Katrina" & s$category >=4 ),]
names(s)
class(s$category)
storms_katrina <- s[which(s$name == "Katrina" & s$category >=4),]

browseVignettes(package = c("dplyr"))  
?dplyr

s %>% filter(name == "Katrina" & category>=4)
summarize(storms_katrina, promedio = mean(pressure))

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


ls()
rm(list =ls()) #Truco para borrar todo


getwd()
setwd("/home/stuka/Desktop/SismoCDMX/R para emergencias/Datos/")
dir()

transporte <- read.csv("Transporte_Otros_21_09_2017.csv")

head(transporte,10)
names(transporte)

summary(transporte)
View(transporte)
glimpse(transporte)

class(transporte$Tipo.de.ayuda)
transporte$tipo_ayuda_limpio <- as.character(transporte$Tipo.de.ayuda)
transporte$tipo_ayuda_limpio %>% unique
transporte$tipo_ayuda_limpio %>% table

library(stringr)
?gsub
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
transporte_solo$Tipo.de.Transporte <- gsub("camion, camion, Vans de 1-3.5 Camiones 8 T","camion" ,ignore.case = TRUE,transporte_solo$Tipo.de.Transporte)
transporte_solo$Tipo.de.Transporte <- gsub("Motocicleta, MOTOS DE REPARTO PARA MOVILIZACION DE RECURSOS SOLO EN CD MX  4 MOTOS ","moto" ,ignore.case = TRUE,transporte_solo$Tipo.de.Transporte)
transporte_solo$Tipo.de.Transporte <- gsub("Van de carga","van",ignore.case = TRUE,transporte_solo$Tipo.de.Transporte)
transporte_solo$Tipo.de.Transporte <- gsub("Voyager","camioneta",ignore.case = TRUE,transporte_solo$Tipo.de.Transporte)
transporte_solo$Tipo.de.Transporte <- gsub("Estaquitas ","pickup",ignore.case = TRUE,transporte_solo$Tipo.de.Transporte)
transporte_solo$Tipo.de.Transporte <- gsub("automovil, SUV XTRAIL","camioneta",ignore.case = TRUE,transporte_solo$Tipo.de.Transporte)
transporte_solo$Tipo.de.Transporte <- gsub("Bicicleta, automovil","automovil",ignore.case = TRUE,transporte_solo$Tipo.de.Transporte)
transporte_solo$Tipo.de.Transporte <- gsub("Bicicleta, Motocicleta","moto",ignore.case = TRUE,transporte_solo$Tipo.de.Transporte)
transporte_solo$Tipo.de.Transporte <- gsub("camioneta, autobus","autobus",ignore.case = TRUE,transporte_solo$Tipo.de.Transporte)
transporte_solo$Tipo.de.Transporte <- gsub("Camioneta, camion","camion",ignore.case = TRUE,transporte_solo$Tipo.de.Transporte)
transporte_solo$Tipo.de.Transporte <- gsub("camioneta, 4 vANS Y 7 PICK UPS","pickup",ignore.case = TRUE,transporte_solo$Tipo.de.Transporte)
transporte_solo$Tipo.de.Transporte <- gsub("Camioneta","camioneta",ignore.case = TRUE,transporte_solo$Tipo.de.Transporte)
transporte_solo$Tipo.de.Transporte <- gsub("automovil, 2 autos","automovil",ignore.case = TRUE,transporte_solo$Tipo.de.Transporte)
transporte_solo$Tipo.de.Transporte <- gsub("Jeep Liberty","camioneta",ignore.case = TRUE,transporte_solo$Tipo.de.Transporte)
transporte_solo$Tipo.de.Transporte <- gsub("Sentra y Versa","automovil",ignore.case = TRUE,transporte_solo$Tipo.de.Transporte)
transporte_solo$Tipo.de.Transporte <- gsub("Motocicleta, automovil","automovil",ignore.case = TRUE,transporte_solo$Tipo.de.Transporte)
transporte_solo$Tipo.de.Transporte <- gsub("Jeep","camioneta",ignore.case = TRUE,transporte_solo$Tipo.de.Transporte)
transporte_solo$Tipo.de.Transporte <- gsub("Bicicleta","bici",ignore.case = TRUE,transporte_solo$Tipo.de.Transporte)
transporte_solo$Tipo.de.Transporte <- gsub("Motocicleta, 2 alforjas","moto",ignore.case = TRUE,transporte_solo$Tipo.de.Transporte)
transporte_solo$Tipo.de.Transporte <- gsub("camioneta, tres y media","camion",ignore.case = TRUE,transporte_solo$Tipo.de.Transporte)
transporte_solo$Tipo.de.Transporte <- gsub("Motocicleta","moto",ignore.case = TRUE,transporte_solo$Tipo.de.Transporte)
transporte_solo$Tipo.de.Transporte <- gsub("Pick Up doble cabina","pickup",ignore.case = TRUE,transporte_solo$Tipo.de.Transporte)
transporte_solo$Tipo.de.Transporte <- gsub("camion de 3 1/2 toneladas","camion",ignore.case = TRUE,transporte_solo$Tipo.de.Transporte)
transporte_solo$Tipo.de.Transporte <- gsub("camion, Vehiculos UPS","camion",ignore.case = TRUE,transporte_solo$Tipo.de.Transporte)


transporte_solo$Tipo.de.Transporte[which(transporte_solo$Tipo.de.Transporte == "")] <- "no especificado"
transporte_solo$Tipo.de.Transporte <- as.character(transporte_solo$Tipo.de.Transporte)
transporte_solo$Tipo.de.Transporte %>% unique

?gsub

transporte_solo %>% select(Tipo.de.Transporte) %>% table
class(transporte_solo$Tipo.de.Transporte)
transporte_solo$Tipo.de.Transporte <- factor(transporte_solo$Tipo.de.Transporte)
transporte_solo$Tipo.de.Transporte
transporte_solo$Tipo.de.Transporte %>% summary
plot(transporte_solo$Tipo.de.Transporte)

library(ggplot2)

ggplot(transporte_solo,aes(x=Tipo.de.Transporte, fill = Tipo.de.Transporte)) + geom_bar()

?ggplot

transporte_solo

ggplot(transporte_solo,aes(x=reorder(transporte_solo[[17]],-table(transporte_solo[[17]])[transporte_solo[[17]]]), fill = transporte_solo[[17]])) + geom_bar() +
  ggtitle("Histograma de tipos de transporte ofrecidos del 21/09 a 16/11 para respuesta al sismo") +
  labs(x="Tipo de Vehiculo",y="Número de ofrecimientos") +
  theme(axis.text.x = element_text(angle=90,size=16), legend.position="none")
ggsave("Tipodetransporte.png")

################################ Utilerias

head(d$Listadet)
names(nacimientos)
nacimientos$dias.alta.cert %>% unique
nacimientos$ %>% summary
nacimientos$dias.alta.cert %>% table
nacimientos$dias.alta.cert %>% hist
nacimientos$fech.cert %>% plot
quantile(nacimientos$edad.madre,na.rm=T)
plot(density(nacimientos$edad.madre,na.rm=T))
class(nacimientos$num.nacmto)
nacimientos$edad.madre %>% table %>% prop.table*100
nrow(nacimientos)
nacimientos$ent.res %>% summary
nacimientos$ent.res %>% table
nacimientos$edocivil %>% table %>% prop.table %>% plot
plot(prop.table(table(nacimientos$cual.lengm)))


d$CATCLUES %>% tail
$MPO %>% head
nacimientos$mpo.nacm
summary(nacimientos$DESCRIP)
?inner_join
?recode_factor
summary(nacimientos$fech.nacm)
prop.table(table(nacimientos$cedocve_desc))
?factor
class()

plot <- nacimientos %>% filter(!is.na(edad.madre_cut2))
ggplot(plot, aes(edad.madre_cut2, tot.cons,fill=edad.madre_cut2)) + 
  geom_boxplot() +
  ggtitle(str_wrap("Nùmero de consultas recibidas por rango de edad")) +
  xlab("Rango de edad de la madre") +
  ylab("Nùmero de consultas recibidas") +
  ylim(c(0,15)) +
  theme(legend.position = "none")

ggplot(plot, aes(edad.madre_cut2,tallah,fill=edad.madre_cut2)) + 
  geom_boxplot() +
  ggtitle(str_wrap("Talla del recièn nacido (en ) por rango de edad")) +
  xlab("Rango de edad de la madre") +
  ylab("Talla del recièn nacido (en cm)") +
  ylim(c(45,55)) +
  theme(legend.position = "none")

ggplot(plot, aes(edad.madre_cut2,pesoh,fill=edad.madre_cut2)) + 
  geom_boxplot() +
  ggtitle(str_wrap("Peso del recièn nacido (en gramos) por rango de edad")) +
  xlab("Rango de edad de la madre") +
  ylab("Peso del recièn nacido (en gramos)") +
  ylim(c(2000,4000)) +
  theme(legend.position = "none")
nacimientos$cve.cie_dsc

ggplot(plot, aes(edad.madre_cut2,gestach,fill=edad.madre_cut2)) + 
  geom_boxplot() +
  ggtitle(str_wrap("Semanas de gestación por rango de edad")) +
  xlab("Rango de edad de la madre") +
  ylab("Semanas de gestación") +
  #ylim(c(2000,4000)) +
  theme(legend.position = "none")


nacimientos_aux <-  nacimientos
nacimientos <-  nacimientos_aux

################################# Graficas Univariadas
unique(sapply(sapply(nacimientos,class),first))

for(i in 1:ncol(nacimientos)){
  print(names(nacimientos)[i])
  clase <- class(nacimientos[[i]])
  if(clase %in% c("factor","ordered")){
    ggplot(nacimientos,aes(x=reorder(nacimientos[[i]],-table(nacimientos[[i]])[nacimientos[[i]]]))) + geom_bar() +
      ggtitle(names(nacimientos)[i]) +
      labs(x=names(nacimientos)[i],y="COnteo") +
      theme(axis.text.x = element_text(angle=90,size=8))
    ggsave(paste0("./Graph/",names(nacimientos)[i],".png"))
  }
  else{
    if(clase %in% c("Date","numeric","integer")){
      ggplot(nacimientos,aes(x=nacimientos[[i]])) + geom_bar() +
        ggtitle(names(nacimientos)[i]) +
        labs(x=names(nacimientos)[i],y="COnteo") +
        theme(axis.text.x = element_text(angle=90,size=8))
      ggsave(paste0("./Graph/",names(nacimientos)[i],".png"))
    }
    else{
      if(clase %in% c("Duration")){
        ggplot(nacimientos,aes(x=nacimientos[[i]]@.Data)) + geom_bar() +
          ggtitle(names(nacimientos)[i]) +
          labs(x=names(nacimientos)[i],y="COnteo") +
          theme(axis.text.x = element_text(angle=90,size=8))
        ggsave(paste0("./Graph/",names(nacimientos)[i],".png"))
      }
      else{
        print(paste0("No se grafico la variable ",names(nacimientos)[i]))
      }
    }
    
  }
}
