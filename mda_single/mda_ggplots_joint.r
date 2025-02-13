###R commands for creating plots for the single MDA of podcasts,
###computer-mediated registers, and traditional spoken registers as presented
###in Ehret, Katharina, Laurens Bosman, Aminat Babayode, Nicole Chan, Ivan
###Fong, Noelle Harris, Alissa Hewton, Danica Reid, Rebekah Wong, Maite
###Taboada. 2025. "Podcasts as an emerging register of computer-mediated
###communication". To appear in Register Studies.


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

loadings = read.csv("stats/loadings_joint.csv") #change path(s) if applicable throughout script to read in data!

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


ggsave("loadingsPlot_joint.pdf", dpi=300, unit="mm", width=180)
ggsave("loadingsPlot_joint.jpg", dpi=300, unit="mm", width=180)


##create facetted bar chart of register distribution
#(not in published article)

#load data with factor scores per register

df = read.csv("stats/meanFactorScores_joint.csv")

#add nice column names

colnames(df) = c("Register", "Factor 1", "Factor 2", "Factor 3")


#create nice register labels

df$Register <- case_match(df$Register,
  "brdcast_discussn" ~ "Broadcast discussion",
  "brdcast_documentary" ~ "Broadcast documentary",
  "brdcast_news" ~ "Broadcast news",
  "conversation" ~ "Conversation BNC",
  "interview" ~ "Interview",
  "podcasts" ~ "Podcasts",
  "santabarbara" ~ "Conversation SBCSAE",
  "speech_scripted" ~ "Scripted speech",
  "speech_unscripted" ~ "Speech", 
  "sportslive" ~ "Sports live",
  "pearStories" ~ "Oral narrative",
  "formalSpeech" ~ "Formal speech",
  "interview_online" ~ "Online interview",
  "narratives" ~ "Narratives",
  "spoken" ~ "Spoken",
  "tvScripts" ~ "TV scripts",
  "interactive_discn" ~ "Interactive discussion",
  "personal_blog" ~ "Personal blog",
  "sports_blog" ~ "Sports blog",
  "news_blog" ~ "News blog", 
  "informational_blog" ~ "Informational blog",
 .default = df$Register)

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


ggsave("registerDistribution_joint.pdf", dpi=300, unit="mm", width=180)
ggsave("registerDistribution_joint.jpg", dpi=300, unit="mm", width=180)


##create boxplots

#load factor scores

scores = read.csv("stats/factorScores_joint.csv")

#add mode
scores <- scores |> mutate(mode = register)

scores$mode <- case_match(
  scores$mode,
  "brdcast_discussn" ~ "traditional",
  "brdcast_documentary" ~ "traditional",
  "brdcast_news" ~ "traditional",
  "conversation" ~ "traditional",
  "interview" ~ "traditional",
  "podcasts" ~ "podcasts",
  "santabarbara" ~ "traditional",
  "speech_scripted" ~ "traditional",
  "speech_unscripted" ~ "traditional", 
  "sportslive" ~ "traditional",
  "pearStories" ~ "traditional",
  "formalSpeech" ~ "CMC",
  "interview_online" ~ "CMC",
  "narratives" ~ "CMC",
  "spoken" ~ "CMC",
  "tvScripts" ~ "CMC",
  "interactive_discn" ~ "CMC",
  "personal_blog" ~ "CMC",
  "sports_blog" ~ "CMC",
  "news_blog" ~ "CMC", 
  "informational_blog" ~ "CMC",
 .default = scores$mode)


#create nice register labels

scores$register <- case_match(scores$register,
  "brdcast_discussn" ~ "Broadcast discussion",
  "brdcast_documentary" ~ "Broadcast documentary",
  "brdcast_news" ~ "Broadcast news",
  "conversation" ~ "Conversation BNC",
  "interview" ~ "Interview",
  "podcasts" ~ "Podcasts",
  "santabarbara" ~ "Conversation SBCSAE",
  "speech_scripted" ~ "Scripted speech",
  "speech_unscripted" ~ "Speech", 
  "sportslive" ~ "Sports live",
  "pearStories" ~ "Oral narrative",
  "formalSpeech" ~ "Formal speech",
  "interview_online" ~ "Online interview",
  "narratives" ~ "Narratives",
  "spoken" ~ "Spoken",
  "tvScripts" ~ "TV scripts",
  "interactive_discn" ~ "Interactive discussion",
  "personal_blog" ~ "Personal blog",
  "sports_blog" ~ "Sports blog",
  "news_blog" ~ "News blog", 
  "informational_blog" ~ "Informational blog",
 .default = scores$register)


#create simple boxplot Factor 1

p <- ggplot(scores, aes(x= register, y = Factor1, fill=mode)) + 
	scale_x_discrete(guide = guide_axis(angle=90)) +
	scale_fill_manual(values=c("#FDE725", "#440154","#21918A")) + 
	ylab("Involved vs. informational discourse") +
	xlab("Register") +
	theme_bw()

#plot and add mean factor scores

p <- p + geom_boxplot() + stat_summary(fun=mean, colour="black", size=.5, shape=23, fill="black")


ggsave("boxplot_D1_joint.pdf", dpi=300, unit="mm", width=180)
ggsave("boxplot_D1_joint.jpg", dpi=300, unit="mm", width=180)


#adding the mean results in an error about 21 data points being removed:
#extract the means calculated by stat_summary() to compare against the mean
#factor scores calculated previously. There are no differences

meansDim1_statSum <- ggplot_build(p)$data[[2]]$y

#add register information in correct order

register_sorted <- sort(unique(scores$register))

#store as dataframe and save

meansDim1 <- data.frame(register_sorted, meansDim1_statSum)

colnames(meansDim1) <- c("register", "meansDim1_statSummary")

#write.csv(meansDim1, "stats/statSummary_Dim1_means_joint.csv", row.names=F)


#create simple boxplot Factor 2

p2 <- ggplot(scores, aes(x= register, y = Factor2, fill=mode)) + 
	scale_x_discrete(guide = guide_axis(angle=90)) +
	scale_fill_manual(values=c("#FDE725", "#440154","#21918A")) + 
	ylab("Abstract elaboration vs. involved narration") +
	xlab("Register") +
	theme_bw() 

#plot and add mean factor scores

p2 <- p2 + geom_boxplot() + stat_summary(fun=mean, colour="black", size=.5, shape=23, fill="black")


ggsave("boxplot_D2_joint.pdf", dpi=300, unit="mm", width=180)
ggsave("boxplot_D2_joint.jpg", dpi=300, unit="mm", width=180)

#adding the mean results in an error about 21 data points being removed:
#extract the means calculated by stat_summary() to compare against the mean
#factor scores calculated previously. There are no differences

meansDim2_statSum <- ggplot_build(p2)$data[[2]]$y

#add register information in correct order

register_sorted <- sort(unique(scores$register))

#store as dataframe and save

meansDim2 <- data.frame(register_sorted, meansDim2_statSum)

colnames(meansDim2) <- c("register", "meansDim2_statSummary")

#write.csv(meansDim2, "stats/statSummary_Dim2_means_joint.csv", row.names=F)


