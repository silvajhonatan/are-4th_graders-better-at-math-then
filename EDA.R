library(dplyr)
library(ggplot2)
library(ggthemes)
library(tidyr)
library(gridExtra)

math4 <- read.csv("data/mathScore4.csv", header=TRUE,stringsAsFactors = FALSE) %>%
  select('geo','X2007')
colnames(math4) <- c('countries','fourth_grade')

math8 <- read.csv("data/mathScore8.csv", header=TRUE,stringsAsFactors = FALSE) %>%
  select('geo','X2007')
colnames(math8) <- c('countries','eighth_grade')

mathScores <- inner_join(math4,math8,by="countries")

mathScores <- gather(mathScores,Grades,score,-countries)
mathScores %>% group_by(Grades) %>% ggplot(aes(score,fill=Grades)) + 
  geom_density(alpha=.5)  +
  ylab('') + xlab('') + 
  ggtitle('Math Score on Standardized Test') +theme_economist()

ggsave('figs/final_result.png')

## Auxiliar

png(filename = "outputs/mathScores_head.png", width=400,height=180,bg = "white")
grid.table(head(mathScores))
dev.off()
