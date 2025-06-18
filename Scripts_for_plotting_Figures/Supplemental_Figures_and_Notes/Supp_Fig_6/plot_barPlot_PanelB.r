library(ggplot2)
library(cowplot)

mytheme = theme(
	axis.ticks = element_line(color = "black", size = 0.75), 
	axis.ticks.length = unit(0.25, "cm"), 
	axis.line.x = element_line(color = "black", size = 1), 
	axis.line.y = element_line(color = "black", size = 1), 
	axis.text.x = element_text(color = 'black', size = 20, margin = margin(rep(4, 4))), 
	axis.text.y = element_text(color = 'black', size = 20, margin = margin(rep(2, 4))), 
	axis.title.x = element_text(color = "black", size = 20, margin = margin(rep(15, 4))), 
	axis.title.y = element_text(color = "black", size = 26,  margin = margin(rep(15, 4))), 
	plot.title = element_text(color = "black", hjust = 0.5, size = 28, margin = margin(rep(15, 4))),
	plot.margin = margin(t=0,r=0,b=0,l=0),
	legend.key = element_blank(),
	legend.position= c(0.78, 0.9),
	legend.key.size = unit(0.5, "cm"),
	legend.title = element_text(color = "white",size=2),
	legend.text = element_text(color = "black", size = 20), 
	legend.background = element_rect(fill = 'white', color = "white"))


data1 <- read.table("ISO1_HiFi.txt",header=TRUE)
data2 <- read.table("ISO1_HetEnr.txt",header=TRUE)

c1 <- c("iso1_HiFi         - 15.70 Mb","iso1_HiFi         - 15.70 Mb","iso1_HiFi         - 15.70 Mb","iso1_HiFi         - 15.70 Mb","iso1_HiFi         - 15.70 Mb","iso1_HiFi         - 15.70 Mb","iso1_HiFi         - 15.70 Mb")
c2 <- c("iso1_Genetics - 14.57 Mb","iso1_Genetics - 14.57 Mb","iso1_Genetics - 14.57 Mb","iso1_Genetics - 14.57 Mb","iso1_Genetics - 14.57 Mb","iso1_Genetics - 14.57 Mb","iso1_Genetics - 14.57 Mb")


## Y ##

Hifi_Y <- subset(data1, CHR=='Y', select=c("LINEs","LTRs","DNA","rRNA","Su_Ste","Satellites","SSRs"))
Gen_Y <- subset(data2, CHR=='Y', select=c("LINEs","LTRs","DNA","rRNA","Su_Ste","Satellites","SSRs"))

df_Hifi_Y <- data.frame(strain=c1,Repeat_Categories=colnames(Hifi_Y),bpcovered=as.numeric(as.vector(Hifi_Y[1,])))
df_Gen_Y <- data.frame(strain=c2,Repeat_Categories=colnames(Gen_Y),bpcovered=as.numeric(as.vector(Gen_Y[1,])))
df_Y <- rbind(df_Hifi_Y,df_Gen_Y)

g1 <- ggplot(data=df_Y,aes(x=Repeat_Categories,y=bpcovered,fill=strain)) + geom_bar(stat="identity",position=position_dodge()) + scale_y_continuous(name="Total (Mb)",breaks=seq(0,6000000,1000000),labels=seq(0,6,1)) + xlab("") + ggtitle("Y") + scale_fill_manual(values=c("#d993bc","#56B4E9")) + mytheme


#pp <-  plot_grid(g1,g2,g3,g4,g5,g6,labels = "",ncol=3)
pp <-  plot_grid(g1,labels = "",ncol=1)

save_plot("iso1_hifi_ChingHio_comaprison.pdf",pp,base_asp=1.5,base_height=10)
