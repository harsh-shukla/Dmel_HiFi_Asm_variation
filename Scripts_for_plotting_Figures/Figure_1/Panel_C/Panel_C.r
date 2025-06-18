library(ggplot2)
library(cowplot)

mytheme = theme(
	axis.ticks = element_line(color = "black", size = 0.75), 
	axis.ticks.length = unit(0.25, "cm"), 
	axis.line.x = element_line(color = "black", size = 1), 
	axis.line.y = element_line(color = "black", size = 1), 
	axis.text.x = element_text(color = 'black', size = 12, margin = margin(rep(4, 4))), 
	axis.text.y = element_text(color = 'black', size = 12, margin = margin(rep(2, 4))), 
	axis.title.x = element_text(color = "black", size = 17, margin = margin(rep(15, 4))), 
	axis.title.y = element_text(color = "black", size = 17,  margin = margin(rep(15, 4))), 
	plot.title = element_text(color = "black", hjust = 0.5, size = 20, margin = margin(rep(15, 4))),
	plot.margin = margin(t=0,r=0,b=0,l=0),
	legend.key = element_blank(),
	legend.position= c(0.78, 0.9),
	legend.key.size = unit(0.4, "cm"),
	legend.title = element_text(color = "white",size=2),
	legend.text = element_text(color = "black", size = 12), 
	legend.background = element_rect(fill = 'white', color = "white"))

dat1 <-  read.table("ISO1Rel6_Rep.txt",header=TRUE)
dat2 <- read.table("ISO1Hifi_Rep.txt",header=TRUE)

c1 <- c("iso1_Rel6","iso1_Rel6","iso1_Hifi","iso1_Hifi")
c2 <- c("EU_C","HET_C","EU_C","HET_C")

chr2_EU_rel6  <- (dat1$EU_END[1]   - dat1$EU_START[1])  +  (dat1$EU_END[2]   - dat1$EU_START[2])
chr2_HET_rel6 <- (dat1$CHR_SIZE[1] - dat1$EU_END[1])    +  (dat1$EU_START[2])
chr2_EU_hifi  <- (dat2$EU_END[1]   - dat2$EU_START[1])  +  (dat2$EU_END[2]   - dat2$EU_START[2])
chr2_HET_hifi <- (dat2$CHR_SIZE[1] - dat2$EU_END[1])    +  (dat2$EU_START[2])
chr_2 <- c(chr2_EU_rel6,chr2_HET_rel6,chr2_EU_hifi,chr2_HET_hifi)

df_2 <- data.frame(strain=c1,compartment=c2,totalbp=chr_2)

chr3_EU_rel6  <- (dat1$EU_END[3]   - dat1$EU_START[3])  +  (dat1$EU_END[4]   - dat1$EU_START[4])
chr3_HET_rel6 <- (dat1$CHR_SIZE[3] - dat1$EU_END[3])    +  (dat1$EU_START[4])
chr3_EU_hifi  <- (dat2$EU_END[3]   - dat2$EU_START[3])  +  (dat2$EU_END[4]   - dat2$EU_START[4])
chr3_HET_hifi <- (dat2$CHR_SIZE[3] - dat2$EU_END[3])    +  (dat2$EU_START[4])
chr_3 <- c(chr3_EU_rel6,chr3_HET_rel6,chr3_EU_hifi,chr3_HET_hifi)

df_3 <- data.frame(strain=c1,compartment=c2,totalbp=chr_3)

g1 <- ggplot(data=df_2,aes(x=compartment,y=totalbp,fill=strain)) + geom_bar(stat="identity",position=position_dodge()) + scale_y_continuous(name="Total bp (Mb)",breaks=seq(0,42000000,5000000),labels=seq(0,42,5)) + ggtitle("2 chromosome") + theme(plot.title = element_text(hjust = 0.5)) + scale_fill_manual(values=c("#009E73","#56B4E9")) + mytheme
g2 <- ggplot(data=df_3,aes(x=compartment,y=totalbp,fill=strain)) + geom_bar(stat="identity",position=position_dodge()) + scale_y_continuous(name="Total bp (Mb)",breaks=seq(0,51000000,5000000),labels=seq(0,51,5)) + ggtitle("3 chromosome") + theme(plot.title = element_text(hjust = 0.5)) + scale_fill_manual(values=c("#009E73","#56B4E9")) + mytheme
#plot_grid(g1,g2, labels = "AUTO")

pp <-  plot_grid(g1,g2, labels = "AUTO")
save_plot("iso1_total_Mb.pdf",pp, ncol = 1)
