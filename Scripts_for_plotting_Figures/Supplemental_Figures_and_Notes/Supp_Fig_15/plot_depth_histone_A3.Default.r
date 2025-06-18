library(ggplot2)
coverage=read.table("A3_default.depth", sep="\t", header=F)
colnames(coverage) <- c("Chr","locus","depth")
coverage$locus <- coverage$locus - coverage$locus[1]

#p <- ggplot(coverage) + geom_point(aes(x = locus, y = depth),size=0.01)  + labs(title = "A3 Histone Default") + xlab("Histone Locus")  +  ylim(0, 600) + theme(aspect.ratio=0.3)
p <- ggplot() + geom_point(data=coverage,aes(x = locus, y = depth),size=0.01,color="coral2",alpha = 0.05)  + labs(title = "A3 Histone Default") + xlab("Histone Locus (kb)")  +  ylim(0, 600) + theme(aspect.ratio=0.3)

p <- p + scale_x_continuous(breaks=seq(0,650000,50000),labels = c(0,"50","100","150","200","250","300","350","400","450","500","550","600","650"))

#print(p)

#ggsave(filename="A3_Default.tiff",plot = print(p))
ggsave(filename="A3_Default.jpg",plot = print(p),dpi = 600)

dev.off()
