library(ggplot2)
library(magrittr)
#dat <- read.csv(file = 'ISO1_A4_all.FILT.csv', header = TRUE)
dat <- read.csv(file = 'ISO1_A4_NEW.dist.csv', header = TRUE)


dat$Comparison <- with(dat, 
  apply(X = cbind(Species1, Species2), MARGIN = 1, FUN = function(x) paste(sort(x), collapse='x')) %>%
  as.factor
)

dat$Type <- with(dat,
  ifelse(test = Species1 == Species2, yes = 'Within', no = 'Between') %>%
  as.factor
)

dat$Unit_dist <- with(dat, abs(n1-n2))

p <- ggplot(
  data = subset(dat, Unit_dist > 0),
  mapping = aes(x = Unit_dist, y = Dist)
)

p <- p +
  geom_point(color = 'lightgray', size = 1/2) +
  geom_smooth(
    mapping = aes(color = Comparison, linetype = Type),
    se = FALSE, method = 'loess', 
    span = 1
  ) +
  theme_bw() + #coord_cartesian(ylim = c(0, 10e-3)) +
  xlab('Physical distance (Integral repeat units)') +
  ylab('Molecular distance') + scale_x_continuous(breaks=c(0,10,20,30,40,50,60,70,80,90,100,110,120,130,140,150,160,170,180,190),labels=c(0,10,20,30,40,50,60,70,80,90,100,110,120,130,140,150,160,170,180,190)) + 
  theme(axis.text.x = element_text(size = 15),axis.text.y = element_text(size = 15),axis.title.x = element_text(size = 24),axis.title.y = element_text(size = 24),legend.title = element_text(size = 24),legend.text = element_text(size = 22)) +
  ylim(0, 0.01) + geom_hline(yintercept=0.0054, linetype="dotted", color = "black", size=1)
  
  
#pdf("histone_distance.ISO1_A4.pdf",width=8,height=9)
#pdf("histone_distance.ISO1_A4.NEWH..pdf",width=8,height=9)
#pdf("histone_distance.ISO1_A4.FINAL.pdf",width=8,height=9)
ggsave("histone_distance.ISO1_A4.FINAL.png", plot = p, width = 8, height = 9, units = "in", bg = "white")

print(p)
dev.off()
