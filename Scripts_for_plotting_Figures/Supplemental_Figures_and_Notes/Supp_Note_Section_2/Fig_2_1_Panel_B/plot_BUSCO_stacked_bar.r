mytheme = theme(
	axis.ticks = element_line(color = "black", size = 0.75), 
	axis.ticks.length = unit(0.25, "cm"), 
	axis.line.x = element_line(color = "black", size = 1), 
	axis.line.y = element_line(color = "black", size = 1), 
	axis.text.x = element_text(color = 'black', size = 10, margin = margin(rep(4, 4))), 
	axis.text.y = element_text(color = 'black', size = 16, margin = margin(rep(2, 4))), 
	axis.title.x = element_text(color = "black", size = 26, margin = margin(rep(15, 4))), 
	axis.title.y = element_text(color = "black", size = 26,  margin = margin(rep(15, 4))), 
	plot.title = element_text(color = "black", hjust = 0.5, size = 20, margin = margin(rep(15, 4))),
	plot.margin = margin(t=0,r=0,b=0,l=0),
	legend.key = element_blank(),
	#legend.position= c(0.78, 0.9),
	legend.key.size = unit(0.4, "cm"),
	legend.title = element_text(color = "black",size=16),
	legend.text = element_text(color = "black", size = 14), 
	legend.background = element_rect(fill = 'white', color = "white"),
	strip.text = element_text(size = 20, color = "black"))
	

dat <- read.table("busoc_ggplot2.txt",sep="\t",header=TRUE)

strains_order    <- c("iso-1","A4","A3")
ASM_order        <- c("verkko_all","verkko_long60X","Hifiasm_all")
#Busco_Categories <- c("COMPLETE","DUPLICATED","MISSING","FRAGMENTED")
Busco_Categories <- c("FRAGMENTED","MISSING","DUPLICATED","COMPLETE")

#p <- ggplot(dat,aes(x=factor(ASM,ASM_order),y=NUM_GENES,fill=factor(BUSCO_CATGRY,Busco_Categories) ) ) + geom_bar(position="stack", stat="identity") + facet_grid(~ STRAIN) + scale_y_continuous(name="Number of BUSCO Genes", limits=c(3245,3285),breaks=seq(3245,3285,5),labels=seq(3245,3285,5))


p <- ggplot(dat,aes(x=factor(ASM,ASM_order),y=NUM_GENES,fill=factor(BUSCO_CATGRY,Busco_Categories) ) ) + geom_bar(position="stack", stat="identity") + facet_grid(~ factor(STRAIN,strains_order)) + scale_y_continuous(name="Number of BUSCO Genes") +  coord_cartesian(ylim = c(3245, 3285)) + xlab("Strains") +  guides(fill = guide_legend(title = "BUSCO Category")) +  mytheme


ggsave("Busco_Comp.pdf", plot = print(p),width = 12, height = 10)
