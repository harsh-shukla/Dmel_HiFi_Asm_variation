library(reshape2)
library(ggplot2)
library(plotly)

df <- read.table("plink.ld",header=FALSE)

snp_names <- read.table("snp_postions.txt",header=FALSE)
colnames(df) <- snp_names$V1
rownames(df) <- snp_names$V1

arr1 <- seq(4314,4690)
arr2 <- seq(10882,11216)
arr3 <- seq(11217,11357)
arr4 <- seq(17104,17482)
arr <- c(arr1,arr2,arr3,arr4)


df2_main <- df[arr,arr]
mat <- as.matrix(df2_main)
data <- melt(mat)

l1 <- 4690 - 4314 + 1
l2 <- l1 + (11216-10882+1)
l3 <- l2 + (11357-11217+1)

#p <- ggplot(data, aes(x = factor(Var1) ,y = factor(Var2), fill = value)) + geom_tile() + coord_fixed() +  geom_vline(xintercept = l1,color="red",size=0.2) + geom_hline(yintercept = l1,color="red",size=0.2) + geom_vline(xintercept = l2,color="red",size=0.2) + geom_hline(yintercept = l2,color="red",size=0.2) + geom_vline(xintercept = l3,color="red",size=0.2) + geom_hline(yintercept = l3,color="red",size=0.2) + labs(x = "", y = "",fill="Pairwise (r2)")


#p <- ggplot(data, aes(x = factor(Var1) ,y = factor(Var2), fill = value)) + geom_tile() + coord_fixed() + scale_fill_gradient(low = "white", high = "red") +  geom_vline(xintercept = l1,color="blue",size=0.2) + geom_hline(yintercept = l1,color="blue",size=0.2) + geom_vline(xintercept = l2,color="blue",size=0.2) + geom_hline(yintercept = l2,color="blue",size=0.2) + geom_vline(xintercept = l3,color="blue",size=0.2) + geom_hline(yintercept = l3,color="blue",size=0.2) + labs(x = "", y = "",fill="Pairwise (r2)") +   theme(axis.title.x=element_blank(),axis.text.x=element_blank(),axis.ticks.x=element_blank(),axis.title.y=element_blank(),axis.text.y=element_blank(),axis.ticks.y=element_blank())


p <- ggplot(data, aes(x = factor(Var1) ,y = factor(Var2), fill = value)) + geom_raster() + coord_fixed() + scale_fill_gradient(low = "white", high = "red") +  geom_vline(xintercept = l1,color="blue",size=0.2) + geom_hline(yintercept = l1,color="blue",size=0.2) + geom_vline(xintercept = l2,color="blue",size=0.2) + geom_hline(yintercept = l2,color="blue",size=0.2) + geom_vline(xintercept = l3,color="blue",size=0.2) + geom_hline(yintercept = l3,color="blue",size=0.2) + labs(x = "", y = "",fill="Pairwise (r2)") +   theme(axis.title.x=element_blank(),axis.text.x=element_blank(),axis.ticks.x=element_blank(),axis.title.y=element_blank(),axis.text.y=element_blank(),axis.ticks.y=element_blank())



#ggsave(filename="linkage.50kb.tiff",plot = print(p))

#ggsave(filename="linkage.50kb.try.pdf",plot = print(p),width=10,height=10)
ggsave(filename="linkage.50kb.1200DPI.png",plot = print(p),width=10,height=10,dpi=1200)
