###R commands for factor analysis and related statistics of podcasts and
###computer-mediated registers as presented in Ehret, Katharina, Laurens
###Bosman, Aminat Babayode, Nicole Chan, Ivan Fong, Noelle Harris, Alissa
###Hewton, Danica Reid, Rebekah Wong, Maite Taboada. 2025. "Podcasts as an
###emerging register of computer-mediated communication". To appear in Register
###Studies.


#load packages
library(tidyverse)
library(psych)
library(reshape2)


##prepare frequency matrix

#read in matrix containing all normalised frequencies per feature as columns

data = read.csv("postag_counts_normalized_CORE.csv")

#set file names as rownames

rownames(data) = data$file_names

#remove first column containing non-numerical data

fa.data = data[,-(1)] 

#order features alphabetically

fa.data = fa.data[, order(names(fa.data))]

##test data for factorability

KMO(fa.data) 

##determine number of factors
#eigenvalues and scree plot

#calculate correlation matrix
fa.cor = cor(fa.data)

#calculate eigenvalues based on the correlation matrix

fa.eigen = eigen(fa.cor) #eigenvalues are the sum of squared factor loadings: sum(factorLoadings^2)

ev = fa.eigen$values

#create scree plot of eigenvalues equal or greater than 1.1

factor = c(1:12)
eigenvalue = ev[1:12]

df=data.frame(factor, eigenvalue)

p = ggplot(df, aes(reorder(factor, -eigenvalue), eigenvalue, group=1))
p <- p + geom_bar(stat="identity", fill= rgb(0.129,0.569,0.540))
p <- p + geom_line(color = rgb(0.992,0.906,0.145), linetype = "solid")+ geom_point(shape=19, color=rgb(0.992,0.906,0.145)) + xlab("Factor") + ylab("Eigenvalue") +
theme_bw()

p <- p + geom_text(label = round(eigenvalue, 2), vjust=-0.4, hjust = 0)


ggsave("screeplot_eigenvalues_CORE.pdf", dpi=300, units="mm", width=180)
ggsave("screeplot_eigenvalues_CORE.jpg", dpi=300, units="mm", width=180)

#write.csv(ev, "eigenvalues_CORE.csv", row.names =F)


#calculate percentage of variance explained

cumsum(ev) #calculate cumulative sum of eigenvalues

#calculate proportion of variance explained by each factor

var = ev/sum(ev)*100

#calculate cumulative proportion of variance explained in percent

cumVar = cumsum(ev)/sum(ev)*100

dimension =  c("1", "2", "3", "4", "5", "6", "7", "8", "9", "10", "11", "12")

variance = var[1:12]

df = data.frame(dimension, variance)

#plot
p2 =  ggplot(df, aes(reorder(dimension, -variance), variance, group=1))

p2 <- p2 + geom_bar(stat="identity", fill= rgb(0.129,0.569,0.540))

p2 <- p2 + geom_line(color = rgb(0.992,0.906,0.145), linetype = "solid")+ geom_point(shape=19,
color=rgb(0.992,0.906,0.145)) + xlab("Factors") + ylab("Percentage of variance explained") +
theme_bw()

p2 <- p2 + geom_text(label = round(variance, 1), vjust=-0.4, hjust = 0)


##factor analysis

fa3 = factanal(x = fa.data, factors = 3, rotation = "promax", method="mle")

fa2 = factanal(x = fa.data, factors = 2, rotation = "promax", method="mle")


#create data frame with loadings

loads = round(fa3$loadings, 3)
 
loadings = as.data.frame(unclass(loads))

#write.csv(loadings, "loadings_CORE.csv")


#calculate and extract factor scores

fa3 = factanal(x = fa.data, factors = 3, rotation = "promax", method="mle",
scores="regression")

factorScores = as.data.frame(fa3$scores)

#write.csv(factorScores, "factorScores_CORE.csv")


#add register information

registers = read.csv("texts_by_register_CORE.csv")
factorScores$register = registers$register


#calculate mean factor scores for each register 

#take column means

byRegister = factorScores %>% group_by(register) %>% summarise_if(is.numeric, mean, na.rm =T)

#write.csv(byRegister, "meanFactorScores_CORE.csv", row.names=F)


#calculate standard deviation for mean factor scores

sd_meanfactorScores = factorScores %>% group_by(register) %>%
summarise_if(is.numeric, list(mean = ~mean(., na.rm=T), sd = ~sd(., na.rm=T)))

#write.csv(sd_meanfactorScores, "sd_mean_meanFactorScores_CORE.csv", row.names=F)


