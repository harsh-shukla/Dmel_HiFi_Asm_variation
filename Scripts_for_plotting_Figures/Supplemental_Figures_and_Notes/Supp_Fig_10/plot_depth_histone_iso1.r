library(ggplot2)

coverage1=read.table("ISO1_default.depth", sep="\t", header=F)
colnames(coverage1) <- c("Chr","locus","depth")
coverage1$locus <- coverage1$locus - coverage1$locus[1]

coverage2=read.table("ISO1_targeted.depth", sep="\t", header=F)
colnames(coverage2) <- c("Chr","locus","depth")
coverage2$locus <- coverage2$locus - coverage2$locus[1]

p <- ggplot() + geom_point(data=coverage1,aes(x = locus, y = depth),size=0.01,color="coral2",alpha = 0.05) 
p <- p        + geom_point(data=coverage2,aes(x = locus, y = depth),size=0.01,color="steelblue",alpha = 0.05)
p <- p +  labs(title = "iso-1 Histone") + xlab("Histone Locus (kb)")  +  ylim(0, 130) + theme(aspect.ratio=0.3) 

p <- p + scale_x_continuous(breaks=seq(0,650000,50000),labels = c(0,"50","100","150","200","250","300","350","400","450","500","550","600","650"))
#print(p)

ggsave(filename="ISO1_together.F.jpg",plot = print(p),dpi = 600)
dev.off()
