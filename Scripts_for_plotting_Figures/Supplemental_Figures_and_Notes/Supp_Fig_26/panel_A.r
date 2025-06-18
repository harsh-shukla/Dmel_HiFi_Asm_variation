library(ggplot2)

#data  <- read.csv(file='A4_intra.distances.csv')
data <- read.csv(file='A4_intra.distances.Nov15_23.csv')


lendata <- nrow(data)
for (i in 1:lendata) {
 
  c1 <- strsplit(data[i,1], " ")
  c2 <- strsplit(data[i,2], " ")
  
  diff <- as.integer(c2[[1]][5]) - as.integer(c1[[1]][5])
  data[i,4] <- diff

}



p <- ggplot(data, aes(x=V4, y=Dist)) + geom_point(color = 'lightgray', size = 1/2) + geom_smooth(method = 'loess',span=1) + theme_bw() 
p <- p + xlab('Physical distance (Integral repeat units)') + ylab('Molecular distance') + scale_x_continuous(breaks=c(0,10,20,30,40,50,60,70,80,90,100,110,120,130,140,150,160,170,180,190,200),labels=c(0,10,20,30,40,50,60,70,80,90,100,110,120,130,140,150,160,170,180,190,200)) + theme(axis.text.x = element_text(size = 12),axis.text.y = element_text(size = 12),axis.title.x = element_text(size = 16),axis.title.y = element_text(size = 16),legend.title = element_text(size = 18),legend.text = element_text(size = 16)) + ylim(0, 0.012)

ggsave(file="A4_curvefitplot.pdf",plot = p,width =8,height =8)


