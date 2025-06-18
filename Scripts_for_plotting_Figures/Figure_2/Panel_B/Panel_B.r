library(ggplot2)


mytheme = theme(
	axis.ticks = element_line(color = "black", size = 0.75), 
	axis.ticks.length = unit(0.25, "cm"), 
	axis.line.x = element_line(color = "black", size = 1), 
	axis.line.y = element_line(color = "black", size = 1), 
	axis.text.x = element_text(color = 'black', size = 28, margin = margin(rep(4, 4))), 
	axis.text.y = element_text(color = 'black', size = 16, margin = margin(rep(2, 4))), 
	axis.title.x = element_text(color = "black", size = 24, margin = margin(rep(15, 4))), 
	axis.title.y = element_text(color = "black", size = 28,  margin = margin(rep(15, 4))), 
	plot.title = element_text(color = "black", hjust = 0.5, size = 20, margin = margin(rep(15, 4))),
	plot.margin = margin(t=0,r=0,b=0,l=0),
	legend.key = element_blank(),
	#legend.position= c(0.78, 0.9),
	legend.key.size = unit(0.4, "cm"),
	legend.title = element_text(color = "black",size=18),
	legend.text = element_text(color = "black", size = 14), 
	legend.background = element_rect(fill = 'white', color = "white"))

iso1_t <- read.table("./X_extra/ISO1_percentages.txt",sep="\t",header=FALSE)
a4_t <- read.table("../A4/X_extra/A4_percentages.txt",sep="\t",header=FALSE)
a3_t <- read.table("../A3/X_extra/A3_percentages.txt",sep="\t",header=FALSE)

n1 <- length(iso1_t$V1)
iso1_c <- c(rep("iso-1" , n1))
iso1_t$V3 <- iso1_c

n2 <- length(a4_t$V1)
a4_c <- c(rep("A4" , n2))
a4_t$V3 <- a4_c

n3 <- length(a3_t$V1)
a3_c <- c(rep("A3" , n3))
a3_t$V3 <- a3_c

df <- rbind(iso1_t,a4_t,a3_t)
colnames(df) <- c('Repeat_Cat','Percentage','Strain')

#Repeat_Categories <- df$Repeat_Cat[1:10]
#ggplot(df,aes(x=Strain,y=Percentage,fill=factor(Repeat_Cat,Repeat_Categories) ) ) + geom_bar(position="stack", stat="identity") + scale_fill_manual(values=c("#fdaa48","#f97306","#6b8ba4","#02ab2e","#8f1402","#75bbfd","#0343df","#380282","#ffdf22","#ffffe4"))

Repeat_Categories <- c("Non Repetitive ","Low Complexity, Simple Repeats ","rRNA associated Satellites(92,330,240) ","rRNA ","DNA transposons ","LINE (excluding R1,R2) ","LTRs ","Stellate ","R2 ","R1 ")
strains_order = c("A4","iso-1","A3")
p <- ggplot(df,aes(x=factor(Strain,strains_order),y=Percentage,fill=factor(Repeat_Cat,Repeat_Categories) ) ) + geom_bar(position="stack", stat="identity") + scale_fill_manual(values=c("#ffffe4","#ffdf22","#6b8ba4","#02ab2e","#380282","#0343df","#75bbfd","#8f1402","#f97306","#fdaa48")) + guides(fill = guide_legend(title = "Repeat Category")) + scale_y_continuous(name="Proportion (%)",,breaks=seq(0,100,10),labels=seq(0,100,10)) + xlab("Strains") + mytheme

ggsave("Repeat_Percentages.pdf", plot = print(p),width = 10, height = 10)

#factor(weekday, days_of_the_week)


