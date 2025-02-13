###R commands for factor analysis and related statistics of podcasts,
###computer-mediated and traditional spoken registers as presented in Ehret, Katharina, Laurens
###Bosman, Aminat Babayode, Nicole Chan, Ivan Fong, Noelle Harris, Alissa
###Hewton, Danica Reid, Rebekah Wong, Maite Taboada. 2025. "Podcasts as an
###emerging register of computer-mediated communication". To appear in Register
###Studies.


#load libraries
library(tidyverse)
library(psych)
library(reshape2)

##prepare joint dataset of podcasts, traditional spoken and CMC registers for the single MDA

#read in matrices containing all normalised frequencies per feature as columns; read in as data.frame. The feature matrices can be found in the respective directories on Github.

trad <- read.csv("postag_counts_normalized_traditional.csv")

core <- read.csv("postag_counts_normalized_CORE.csv") 

#merge data keeping only unique file_names

data <- rbind(trad, core) %>% distinct(file_names, .keep_all = T)

##prepare frequency matrix 

#set file names as rownames

rownames(data) = data$file_names

#remove first column containing non-numerical data

fa.data = data[,-(1)] 

#order features alphabetically

fa.data = fa.data[, order(names(fa.data))]

##test data for factorability

KMO(fa.data) 

#potentially remove variables with low MSA (below .5)
#fa.data = subset(fa.data, select = -c(ANDC, NEMD, PRMD, TTP3, VBD))

##determine number of factors
#eigenvalues and scree plot

#calculate correlation matrix

fa.cor = cor(fa.data)

#calculate eigenvalues based on the correlation matrix

fa.eigen = eigen(fa.cor) #eigenvalues are the sum of squared factor loadings: sum(factorLoadings^2)

ev = fa.eigen$values

#write.csv(ev, "eigenvalues_joint.csv", row.names =F)


#create scree plot of eigenvalues equal or greater than 1.1

factor = c(1:12)
eigenvalue = ev[1:12]

df=data.frame(factor, eigenvalue)

p = ggplot(df, aes(reorder(factor, -eigenvalue), eigenvalue, group=1))
p <- p + geom_bar(stat="identity", fill= rgb(0.129,0.569,0.540))
p <- p + geom_line(color = rgb(0.992,0.906,0.145), linetype = "solid")+ geom_point(shape=19, color=rgb(0.992,0.906,0.145)) + xlab("Factor") + ylab("Eigenvalue") +
theme_bw()

p <- p + geom_text(label = round(eigenvalue, 2), vjust=-0.4, hjust = 0)


ggsave("screeplot_eigenvalues_joint.pdf", dpi=300, units="mm", width=180)
ggsave("screeplot_eigenvalues_joint.jpg", dpi=300, units="mm", width=180)


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

#fa2 = factanal(x = fa.data, factors = 2, rotation = "promax", method="mle")

#fa5 = factanal(x = fa.data, factors = 5, rotation = "promax", method="mle")

#fa4 = factanal(x = fa.data, factors = 4, rotation = "promax", method="mle")

fa3 = factanal(x = fa.data, factors = 3, rotation = "promax", method="mle")

#create data frame with loadings

loads = round(fa3$loadings, 3)
 
loadings = as.data.frame(unclass(loads))

write.csv(loadings, "loadings_joint.csv")


#calculate and extract factor scores

fa3 = factanal(x = fa.data, factors = 3, rotation = "promax", method="mle",
scores="regression")

factorScores = as.data.frame(fa3$scores)

#write.csv(factorScores, "factorScores_joint.csv") 


#create register information for joint data

#the register by texts can be found in the respective folders for the CORE and traditional spoken analysis

registers_trad = read.csv("texts_by_register_traditional.csv")

registers_core = read.csv("texts_by_register_CORE.csv")

registers <- rbind(registers_trad, registers_core)  %>% distinct(file_names, .keep_all = T)

#add 

factorScores$register = registers$register

#write.csv(factorScores, "factorScores_joint.csv")  #including register information

#calculate mean factor scores for each register 

#take column means

byRegister = factorScores %>% group_by(register) %>% summarise_if(is.numeric, mean, na.rm =T)

#write.csv(byRegister, "meanFactorScores_joint.csv", row.names=F)


#calculate standard deviation for mean factor scores

sd_meanfactorScores = factorScores %>% group_by(register) %>%
summarise_if(is.numeric, list(mean = ~mean(., na.rm=T), sd = ~sd(., na.rm=T)))

#write.csv(sd_meanfactorScores, "sd_mean_meanFactorScores_joint.csv", row.names=F)





