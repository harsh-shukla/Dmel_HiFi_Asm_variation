library(ggplot2)
library(magrittr)

dat <- read.csv(file = 'iso1_A4_distances.MOD.csv', header = TRUE)


dat$Comp <- paste(dat$Species1,dat$Species2,sep="_")

#iso1_iso1 <- dat[ which(dat$Species1=='ISO1' & dat$Species2=='ISO1'), ]
#A4_A4     <- dat[ which(dat$Species1=='A4' & dat$Species2=='A4'), ]
#iso1_A4   <- dat[ which(dat$Species1=='ISO1' & dat$Species2=='A4'), ]


p <- ggplot(dat,aes(x=Comp, y=Dist)) + geom_boxplot() + scale_y_continuous(breaks=c(0,0.001,0.002,0.003,0.004,0.005,0.006,0.007,0.008,0.009,0.010),labels=c(0,0.001,0.002,0.003,0.004,0.005,0.006,0.007,0.008,0.009,0.010),limits=c(0, 0.01))
p <- p + ylab('Molecular distance') + xlab('Comparsion')
p <- p + theme(axis.text.x = element_text(size = 12),axis.text.y = element_text(size = 12),axis.title.x = element_text(size = 16),axis.title.y = element_text(size = 16),legend.title = element_text(size = 18),legend.text = element_text(size = 16))



ggsave(file="iso1_A4_dist.boxplot.pdf",plot = p,width =8,height =8)
