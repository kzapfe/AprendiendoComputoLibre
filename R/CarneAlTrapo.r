### Super tabla de fines de semana.
### checa que si usas el operador : para cortocircuito de from, to, la riegas
### porque esa madre convierte en numeros otra vez los argumentos "as.Date".


##solucion normalita
sabados<- seq(as.Date("2017-05-13"),as.Date("2017-06-11"), by="week")
domingos <- seq(as.Date("2017-05-14"),as.Date("2017-06-11"), by="week")
fechas  <- as.Date(c(rbind(sabados,domingos)),origin="1970-01-01")



## solucion guru
finde <- seq(as.Date('2017-05-13'),as.Date('2017-06-11'),by = 1)
finde <- finde[weekdays(finde) %in% c('sábado','domingo')]

mau <- c(1,2,0,0,3,3,3,3,3,3)
carlos <- c(1,2,0,0,2,3,4,4,4,3)
karel <- c(1,3,0,0,4,3,3,4,2,2)

#esta mugre de cbind te destruye las fechas.
valores<-as.matrix(rbind(carlos,mau,karel))

png("CarneAlTrapo.png")
culores<-c(rgb(0.62,0.1,0.24),rgb(0.231,0.029,0),rgb(0,0.23,0.1))
par(family="serif")
barplot(valores, names.arg=finde,beside=TRUE, las=2, col=culores)
legend("topleft", c("carlos","mau","karel"), cex=1.3, bty="n", fill=culores)

#dev.print(pdf, "CarneAlTrapo.pdf", height=10, width=10)
dev.off()
