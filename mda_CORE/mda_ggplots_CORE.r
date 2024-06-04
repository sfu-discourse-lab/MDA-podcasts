####R commands for creating plots of podcasts and other online registers as presented in Aminat Babayode, Laurens Bosman, Nicole Chan, Katharina Ehret, Ivan Fong, Noelle Harris, Alissa Hewton, Danica Reid, Maite Taboada, Rebekah Wong "Podcasts as an emerging register of computer-mediated communication" (submitted to: Register Studies)


#load packages
library(tidyverse)
library(ggrepel)
library(reshape2)
library(scales)
library(Hmisc)
library(hrbrthemes)


##plot factor loadings by feature 
#(not in published article)

#load loadings.csv

loadings = read.csv("stats/loadings_CORE.csv")

#use nice column labels

colnames(loadings) = c("Feature", "Factor 1", "Factor 2", "Factor 3")

#create long data format

loadings.m = melt(loadings, id="Feature")
names(loadings.m) = c("Feature", "Factor", "Loading")

#plot feature loadings

load.plot = ggplot(loadings.m, aes(reorder(Feature, Loading), abs(Loading), fill=Loading)) +
  
  facet_wrap(~ Factor, nrow=1) + 
  geom_bar(stat="identity") +
  coord_flip() + 
  scale_fill_viridis_c(name ="Loading", alpha = 1,
  		begin = 0,
  		end = 1,
  		direction = 1,
  		option = "D",
  		values = NULL,
  		space = "Lab",
  		na.value = "grey50",
  		guide = "colourbar",
  		aesthetics = "fill"
		) +
   ylab("Loading strength") + 
   theme_bw() +
   theme(axis.title.y = element_blank(), axis.ticks.y = element_blank()) 

ggsave("loadingsPlot_CORE.pdf", dpi=300, unit="mm", width=180)
ggsave("loadingsPlot_CORE.jpg", dpi=300, unit="mm", width=180)


##create facetted bar chart of register distribution

#load data with mean factor scores per register

df = read.csv("stats/meanFactorScores_CORE.csv")

#add nice column names

colnames(df) = c("Register", "Factor 1", "Factor 2", "Factor 3") 

#add nice register labels

df$Register = c("Formal speech", "Informational blog", "Interactive discussion", "Interview", "Narratives", "News blog", "Personal blog", "Podcasts", "Spoken", "Sports blog", "TV scripts")

#create long data format

df.m = melt(df, id=c("Register")) 

#make bar plot

scoresPlot = ggplot(df.m, aes(Register, value, fill=value)) + 
  facet_wrap(~ variable, nrow=1) + #place the factors in separate facets
  geom_bar(stat="identity") + #make the bars
  coord_flip() +
  scale_fill_gradient2(
  name = waiver(), low = rgb(0.992,0.906,0.145) , mid =rgb(1,1,1), high =rgb(0.266,0.004 ,0.329), #use viridis palette
  
  #rgb(0.266,0.004 ,0.329) dark purple
  #rgb(0.992,0.906,0.145) yellow
  #rgb(0.741,0.875,0.149) pale green
  #rgb(0.129,0.569,0.540) dark green
  
  midpoint = 0,
  space = "Lab",
  na.value = "grey50",
  transform = "identity",
  guide = "none",
  aesthetics = "fill"
  ) +
  ylab("Mean factor score") + #improve y-axis label
  theme_bw(base_size=12) + 
  theme(axis.title.y = element_blank(), 
	axis.ticks.y = element_blank()
  ) 

ggsave("registerDistribution_CORE.pdf", dpi=300, unit="mm", width=180)
ggsave("registerDistribution_CORE.jpg", dpi=300, unit="mm", width=180)


##create boxplots

#load factor scores

scores = read.csv("stats/factorScores_CORE.csv")

#add mode 

scores$mode <- scores$Register

scores$mode <- case_match(
  scores$mode,
  "formalSpeech" ~ "spoken",
  "interview" ~ "spoken",
  "narrative" ~ "written",
  "podcasts" ~ "Podcasts",
  "spoken" ~ "spoken",
  "tvScripts" ~ "written",
  "interactive_discussion" ~ "spoken",
  "personal_blog" ~ "written",
  "sports_blog" ~ "written",
  "news_blog" ~ "written", 
  "informational_blog" ~ "written",
 .default = scores$mode)

			
#create nice register labels

scores$Register <- case_match(
  scores$Register,
  "formalSpeech" ~ "Formal speech",
  "interview" ~ "Interview",
  "narrative" ~ "Narratives",
  "podcasts" ~ "Podcasts",
  "spoken" ~ "Spoken",
  "tvScripts" ~ "TV scripts",
  "interactive_discussion" ~ "Interactive discussion",
  "personal_blog" ~ "Personal blog",
  "sports_blog" ~ "Sports blog",
  "news_blog" ~ "News blog", 
  "informational_blog" ~ "Informational blog",
 .default = scores$Register)


##boxplots

#create simple boxplot Factor 1

p <- ggplot(scores, aes(Register, Factor1, fill=mode)) + 
	scale_x_discrete(guide = guide_axis(angle=90)) +
	scale_fill_viridis_d(option="viridis") + 
	ylab("Involved vs. informational discourse") +
	xlab("Register") +
	theme_bw()

#plot and add mean factor scores

p + geom_boxplot() + stat_summary(fun=mean, colour="black", size=.5, shape=23, fill="black") #we can ignore the warning about missing data points; the plots with the data points look the same

ggsave("boxplot_D1_CORE.pdf", dpi=300, unit="mm", width=180)
ggsave("boxplot_D1_CORE.jpg", dpi=300, unit="mm", width=180)


#create boxplot with jitter 

#p + geom_boxplot(outlier.shape=NA) + geom_jitter(width=0.2) # to overlay with original data points


#create simple boxplot Factor 2

p2 <- ggplot(scores, aes(Register, Factor2, fill=mode)) + 
	scale_x_discrete(guide = guide_axis(angle=90)) +
	scale_fill_viridis_d() +
	ylab("Abstract elaboration vs. involved narration") +
	xlab("Register") +
	theme_bw()

#plot and add mean factor scores

p2 + geom_boxplot() + stat_summary(fun=mean, colour="black", size=.5, shape=23, fill="black")

ggsave("boxplot_D2_CORE.pdf", dpi=300, unit="mm", width=180)
ggsave("boxplot_D2_CORE.jpg", dpi=300, unit="mm", width=180)


#create boxplot with jitter

#p2 + geom_boxplot(outlier.shape=NA) + geom_jitter(width=0.2) # to overlay with original data points


#create simple boxplot Factor 3

p3 <- ggplot(scores, aes(Register, Factor3, fill=mode)) + 
	scale_x_discrete(guide = guide_axis(angle=90)) +
	scale_fill_viridis_d() +
	ylab("Public narrative vs. non-narrative") +
	xlab("Register") +
	theme_bw()

#plot and add mean factor scores

p3 + geom_boxplot() + stat_summary(fun=mean, colour="black", size=.5, shape=23, fill="black")

ggsave("boxplot_D3_CORE.pdf", dpi=300, unit="mm", width=180)
ggsave("boxplot_D3_CORE.jpg", dpi=300, unit="mm", width=180)


#create boxplot with data points

#p3 + geom_boxplot(outlier.shape=NA) + geom_jitter(width=0.2) # to overlay with original data points




