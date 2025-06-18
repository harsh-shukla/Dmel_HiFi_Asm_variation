library(ggplot2)

coverage=read.table("ISO1_EUStellate.depth", sep="\t", header=F)
colnames(coverage) <- c("Chr","Stellate_EU_locus","depth")

p <- ggplot(coverage) + geom_point(aes(x = Stellate_EU_locus, y = depth),size=0.01,alpha = 0.05) + labs(title = "ISO1 X Euchromatin stellate region") + ylim(0,200) + theme(aspect.ratio=0.3)
p <- p + scale_x_continuous(breaks=seq(14013816,14088866,10000))
p <- p + geom_vline(xintercept = 14067071, linetype="dotted",color = "red", size=0.5) + geom_vline(xintercept = 14080623, linetype="dotted",color = "red", size=0.5)


ggsave(filename="ISO1_Default.jpg",plot = print(p),dpi = 600)
dev.off()


