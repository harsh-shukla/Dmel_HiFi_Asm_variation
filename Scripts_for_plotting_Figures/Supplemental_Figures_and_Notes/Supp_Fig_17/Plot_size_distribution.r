library(ggplot2)
data <- read.table("GDL_histone_CP.NEW.2.txt", sep = "\t",stringsAsFactors = FALSE)
col_name <- c("Strain","Length")
colnames(data) <- col_name

quantls <- unname(quantile(data$Length, probs = c(.25, .5, .75)))
q25 <- quantls[1]
q50 <- quantls[2]
q75 <- quantls[3]

#tiff(filename="size_distribution.png")
sp <- ggplot(data) + geom_histogram(mapping = aes(x = Length),bins = 30) + geom_vline(xintercept=q50,color="red") + geom_vline(xintercept=q25,color="blue") + geom_vline(xintercept=q75,color="blue")
sp <- sp + scale_x_continuous(name="Number of Histone Repeat Units", limits=c(0,180),breaks=seq(0,180,10))
ggsave(filename="size_distribution.NEW.jpg",plot = print(sp),,dpi = 600)
#print(sp)
#dev.off()

