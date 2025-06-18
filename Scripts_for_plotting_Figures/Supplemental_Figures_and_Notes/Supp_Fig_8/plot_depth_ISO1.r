coverage=read.table("ISO1_X_extra.1.depth", sep="\t", header=F)
colnames(coverage) <- c("Chr","locus","depth")

p <- ggplot(coverage) + geom_point(aes(x = locus, y = depth)) + labs(title = "ISO1 Newly Assembled X linked heterochromatic sequence")
p <- p + scale_x_continuous(breaks=seq(24064288,27447821,100000))

p <- p + geom_vline(xintercept = 26977921, linetype="dotted",color = "red", size=1)

print(p)
