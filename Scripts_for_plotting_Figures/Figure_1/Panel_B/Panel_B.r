library(ggplot2)
library(cowplot)

mytheme = theme(
	axis.ticks = element_line(color = "black", size = 0.75), 
	axis.ticks.length = unit(0.25, "cm"), 
	axis.line.x = element_line(color = "black", size = 1), 
	axis.line.y = element_line(color = "black", size = 1), 
	axis.text.x = element_text(color = 'black', size = 12, margin = margin(rep(4, 4))), 
	axis.text.y = element_text(color = 'black', size = 12, margin = margin(rep(2, 4))), 
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


data1 <- read.table("ISo1_hifi.txt",header=TRUE)
data2 <- read.table("ISO1_rel6.txt",header=TRUE)

c1 <- c("iso1_HiFi","iso1_HiFi","iso1_HiFi","iso1_HiFi","iso1_HiFi","iso1_HiFi")
c2 <- c("iso1_Rel6","iso1_Rel6","iso1_Rel6","iso1_Rel6","iso1_Rel6","iso1_Rel6")


## 2L ##

Hifi_2L <- subset(data1, CHR=='2L', select=c("LINEs","LTRs","DNA","sRNA","Satellites","SSRs"))
Rel6_2L <- subset(data2, CHR=='2L', select=c("LINEs","LTRs","DNA","sRNA","Satellites","SSRs"))

df_Hifi_2L <- data.frame(strain=c1,Repeat_Categories=colnames(Hifi_2L),bpcovered=as.numeric(as.vector(Hifi_2L[1,])))
df_Rel6_2L <- data.frame(strain=c2,Repeat_Categories=colnames(Rel6_2L),bpcovered=as.numeric(as.vector(Rel6_2L[1,])))
df_2L <- rbind(df_Hifi_2L,df_Rel6_2L)

g1 <- ggplot(data=df_2L,aes(x=Repeat_Categories,y=bpcovered,fill=strain)) + geom_bar(stat="identity",position=position_dodge()) + scale_y_continuous(name="Total (Mb)",breaks=seq(0,1300000,100000),labels=seq(0,1.3,0.1)) + xlab("") + ggtitle("2L") + scale_fill_manual(values=c("#009E73","#56B4E9")) + mytheme

## 2R ##

Hifi_2R <- subset(data1, CHR=='2R', select=c("LINEs","LTRs","DNA","sRNA","Satellites","SSRs"))
Rel6_2R <- subset(data2, CHR=='2R', select=c("LINEs","LTRs","DNA","sRNA","Satellites","SSRs"))

df_Hifi_2R <- data.frame(strain=c1,Repeat_Categories=colnames(Hifi_2R),bpcovered=as.numeric(as.vector(Hifi_2R[1,])))
df_Rel6_2R <- data.frame(strain=c2,Repeat_Categories=colnames(Rel6_2R),bpcovered=as.numeric(as.vector(Rel6_2R[1,])))
df_2R <- rbind(df_Hifi_2R,df_Rel6_2R)

g2 <- ggplot(data=df_2R,aes(x=Repeat_Categories,y=bpcovered,fill=strain)) + geom_bar(stat="identity",position=position_dodge()) + scale_y_continuous(name="Total (Mb)",breaks=seq(0,3200000,200000),labels=seq(0,3.2,0.2)) + xlab("") + ggtitle("2R") + scale_fill_manual(values=c("#009E73","#56B4E9")) + mytheme


## 3L ##

Hifi_3L <- subset(data1, CHR=='3L', select=c("LINEs","LTRs","DNA","sRNA","Satellites","SSRs"))
Rel6_3L <- subset(data2, CHR=='3L', select=c("LINEs","LTRs","DNA","sRNA","Satellites","SSRs"))

df_Hifi_3L <- data.frame(strain=c1,Repeat_Categories=colnames(Hifi_3L),bpcovered=as.numeric(as.vector(Hifi_3L[1,])))
df_Rel6_3L <- data.frame(strain=c2,Repeat_Categories=colnames(Rel6_3L),bpcovered=as.numeric(as.vector(Rel6_3L[1,])))
df_3L <- rbind(df_Hifi_3L,df_Rel6_3L)

g3 <- ggplot(data=df_3L,aes(x=Repeat_Categories,y=bpcovered,fill=strain)) + geom_bar(stat="identity",position=position_dodge()) + scale_y_continuous(name="Total (Mb)",breaks=seq(0,3000000,200000),labels=seq(0,3,0.2)) + xlab("") + ggtitle("3L") + scale_fill_manual(values=c("#009E73","#56B4E9")) + mytheme

## 3R ##

Hifi_3R <- subset(data1, CHR=='3R', select=c("LINEs","LTRs","DNA","sRNA","Satellites","SSRs"))
Rel6_3R <- subset(data2, CHR=='3R', select=c("LINEs","LTRs","DNA","sRNA","Satellites","SSRs"))

df_Hifi_3R <- data.frame(strain=c1,Repeat_Categories=colnames(Hifi_3R),bpcovered=as.numeric(as.vector(Hifi_3R[1,])))
df_Rel6_3R <- data.frame(strain=c2,Repeat_Categories=colnames(Rel6_3R),bpcovered=as.numeric(as.vector(Rel6_3R[1,])))
df_3R <- rbind(df_Hifi_3R,df_Rel6_3R)

g4 <- ggplot(data=df_3R,aes(x=Repeat_Categories,y=bpcovered,fill=strain)) + geom_bar(stat="identity",position=position_dodge()) + scale_y_continuous(name="Total (Mb)",breaks=seq(0,3000000,200000),labels=seq(0,3,0.2)) + xlab("") + ggtitle("3R") + scale_fill_manual(values=c("#009E73","#56B4E9")) + mytheme


## 4 ##

Hifi_4 <- subset(data1, CHR=='4', select=c("LINEs","LTRs","DNA","sRNA","Satellites","SSRs"))
Rel6_4 <- subset(data2, CHR=='4', select=c("LINEs","LTRs","DNA","sRNA","Satellites","SSRs"))

df_Hifi_4 <- data.frame(strain=c1,Repeat_Categories=colnames(Hifi_4),bpcovered=as.numeric(as.vector(Hifi_4[1,])))
df_Rel6_4 <- data.frame(strain=c2,Repeat_Categories=colnames(Rel6_4),bpcovered=as.numeric(as.vector(Rel6_4[1,])))
df_4 <- rbind(df_Hifi_4,df_Rel6_4)

g5 <- ggplot(data=df_4,aes(x=Repeat_Categories,y=bpcovered,fill=strain)) + geom_bar(stat="identity",position=position_dodge()) + scale_y_continuous(name="Total (Mb)",breaks=seq(0,120000,20000),labels=seq(0,0.12,0.02)) + xlab("") + ggtitle("4") + scale_fill_manual(values=c("#009E73","#56B4E9")) + mytheme

## X ##

Hifi_X <- subset(data1, CHR=='X', select=c("LINEs","LTRs","DNA","sRNA","Satellites","SSRs"))
Rel6_X <- subset(data2, CHR=='X', select=c("LINEs","LTRs","DNA","sRNA","Satellites","SSRs"))

df_Hifi_X <- data.frame(strain=c1,Repeat_Categories=colnames(Hifi_X),bpcovered=as.numeric(as.vector(Hifi_X[1,])))
df_Rel6_X <- data.frame(strain=c2,Repeat_Categories=colnames(Rel6_X),bpcovered=as.numeric(as.vector(Rel6_X[1,])))
df_X <- rbind(df_Hifi_X,df_Rel6_X)

g6 <- ggplot(data=df_X,aes(x=Repeat_Categories,y=bpcovered,fill=strain)) + geom_bar(stat="identity",position=position_dodge()) + scale_y_continuous(name="Total (Mb)",breaks=seq(0,2600000,200000),labels=seq(0,2.6,0.2)) + xlab("") + ggtitle("X") + scale_fill_manual(values=c("#009E73","#56B4E9")) + mytheme


#pp <-  plot_grid(g1,g2,g3,g4,g5,g6,labels = "",ncol=3)
pp <-  plot_grid(g1,g2,g3,g4,g5,g6,labels = "",ncol=3)

save_plot("iso1_Hifi_Rel6_comp.pdf",pp,base_asp=1.5,base_height=10)
