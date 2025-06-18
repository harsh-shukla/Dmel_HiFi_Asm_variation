library(ggplot2)
coverage=read.table("iso1_HiFi_2L_coverage.bedgraph", sep="\t", header=F)
colnames(coverage) <- c("Chr","locus1","locus2","depth")
#coverage$locus <- coverage$locus - coverage$locus[1]

#p <- ggplot(coverage) + geom_point(aes(x = locus, y = depth),size=0.01)  + labs(title = "A3 Histone Default") + xlab("Histone Locus")  +  ylim(0, 600) + theme(aspect.ratio=0.3)
p <- ggplot(coverage,aes(x = locus1, y = depth)) + geom_point(size=0.01,color="coral2",alpha = 0.05) + geom_smooth(method="gam")  + labs(title = "Depth") + xlab("iso1-2L")  +  ylim(0, 200) + theme(aspect.ratio=0.3)
#p <- ggplot(coverage,aes(x = locus1, y = depth)) + geom_point(size=0.01,color="coral2",alpha = 0.05) + geom_smooth(method="gam")  + labs(title = "Depth") + xlab("iso1-2L")  +  ylim(0, 200) + xlim(20000000,24256214) + theme(aspect.ratio=0.3)

#p <- p + geom_vline(xintercept = 21551706, linetype="dotted",color = "red", size=0.5) + geom_vline(xintercept = 22132853, linetype="dotted",color = "red", size=0.5)

#p <- p + scale_x_continuous(breaks=seq(0,650000,50000),labels = c(0,"50","100","150","200","250","300","350","400","450","500","550","600","650"))

#print(p)

#ggsave(filename="iso1_adults.2L.jpg",plot = print(p))
ggsave(filename="iso1_adults.withoutHis.jpg",plot = print(p),dpi = 600)

dev.off()
