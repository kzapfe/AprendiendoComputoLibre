# t test para estos datos de sleep
tururu<-t.test(extra~group, data=sleep)
#y como plotearlos
plot(extra~group, data=sleep)
   # a ver, mas
   #Los datos sleep se parecen un poco a tu problema.

library(ggplot2)
library(wesanderson)



ggplot(sleep, aes(x=group, y=extra))+geom_boxplot()
#con puntitos locos
ggplot(sleep, aes(x=group, y=extra, fill=group))+geom_boxplot()+geom_jitter()+ggtitle("Cambio en la horas de sueño")+theme(axis.text.x=element_blank())+scale_x_discrete("")
         #o esta otra versión
figura <- ggplot(sleep, aes(x=group, y=extra, fill=group)) +geom_boxplot()+geom_jitter() +ggtitle("Cambio en la horas de sueño") +theme_linedraw() +theme(legend.position="none")+scale_fill_manual(values=wes_palette(name="GrandBudapest")))+scale_x_discrete(name="Grupo")+scale_y_continuous(name="sueño extra")+theme(plot.title=element_text(size=14, family="Times", face="bold", hjust=0.5))







