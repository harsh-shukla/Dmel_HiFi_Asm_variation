library(ggplot2)

coverage=read.table("A3_EU_Stellate.depth", sep="\t", header=F)
colnames(coverage) <- c("Chr","Stellate_EU_locus","depth")

p <- ggplot(coverage) + geom_point(aes(x = Stellate_EU_locus, y = depth),size=0.01,alpha = 0.05) + labs(title = "A3 X Euchromatin stellate region") + ylim(0,200) + theme(aspect.ratio=0.3)
p <- p + scale_x_continuous(breaks=seq(13918061,13963921,5000))
p <- p + geom_vline(xintercept = 13954796, linetype="dotted",color = "red", size=0.5) + geom_vline(xintercept = 13955688, linetype="dotted",color = "red", size=0.5)

ggsave(filename="A3_Default.jpg",plot = print(p),dpi = 600)
dev.off()
