coverage=read.table("A3_X_extra.depth", sep="\t", header=F)
colnames(coverage) <- c("Chr","locus","depth")

p <- ggplot(coverage) + geom_point(aes(x = locus, y = depth),size=0.01,alpha = 0.05) + labs(title = "A3 Newly Assembled X linked heterochromatic sequence") + theme(plot.title = element_text(hjust = 0.5)) + theme(aspect.ratio=0.3)
p <- p + scale_x_continuous(name="X chromosome",breaks=seq(23675610,28052005,500000)) + scale_y_continuous(name="Depth",limits=c(0,300))
p <- p + geom_vline(xintercept = 26995425, linetype="dotted",color = "red", size=0.5)

ggsave(filename="A3_x_extra.jpg",plot = print(p),dpi = 600)
dev.off()


#print(p)
