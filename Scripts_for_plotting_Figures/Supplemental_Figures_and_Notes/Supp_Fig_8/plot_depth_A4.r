coverage=read.table("A4_X_extra.depth", sep="\t", header=F)
colnames(coverage) <- c("Chr","locus","depth")

p <- ggplot(coverage) + geom_point(aes(x = locus, y = depth),size=0.01,alpha = 0.05) + labs(title = "A4 Newly Assembled X linked heterochromatic sequence") + theme(plot.title = element_text(hjust = 0.5)) + theme(aspect.ratio=0.3)
p <- p + scale_x_continuous(name="X chromosome",breaks=seq(23447832,27727683,500000)) + scale_y_continuous(name="Depth",limits=c(0,350))
p <- p + geom_vline(xintercept = 27217285, linetype="dotted",color = "red", size=0.5)

ggsave(filename="A4_x_extra.jpg",plot = print(p),dpi = 600)
dev.off()

#print(p)
