setwd("~/Downloads")
rm(list=ls())
dat <- read.dta13("~/Downloads/EASage.dta")
attach(dat)
dat$age<-as.numeric(dat$age)
dat$survey<-as.factor(dat$survey)
dat1<- na.omit(subset(dat, select = c(age, survey)))
library(ggplot2)
library(ggridges)
#RIDGE PLOT
title <- "Distribution of age in EA Surveys 2015-2019 "
library(ggthemes) # Load
mv<- ggplot(dat1, aes(x = age, y =survey, fill=survey)) + geom_density_ridges()+ xlab("age") 
mv+ ggtitle(title) + theme_tufte() + theme(legend.position = "none") + scale_x_continuous(breaks=seq(13,83,5), limits=c(13, 83))+ xlab("Age of respondent") + ylab("Survey Year")
#OVERLAPPING DENS
library(ggplot2)
title <- "Distribution of age in EA Surveys 2015-2019 "
sp<-ggplot(dat1, aes(age, fill = survey)) + geom_density(alpha = 0.4)+ xlab("Age of respondent ") +labs(fill="") + ggtitle(title)
sp + theme_tufte()
sp + theme_tufte() + theme( legend.position=c(0.9, 0.9)) + scale_x_continuous(breaks=seq(13,100,5), limits=c(13, 100))
##OVERLAPPING HIST
library(ggplot2)
x<-ggplot(dat1, aes(age, fill = survey)) + 
  geom_histogram(alpha = 0.5, aes(y = ..count..), position = 'identity')+ xlab("Age of respondent")+ ylab("Number of respondents") +labs(fill="") + ggtitle(title)
x +geom_text(aes(x=27, label="Median Ages", y=-10), colour="blue", text=element_text(size=11))+  geom_vline(xintercept = c(a <- c(26,  28,  29)), linetype = "dashed", colour = c("orange","turquoise","purple"))  + theme_tufte() + theme( legend.position=c(0.9, 0.9)) + scale_x_continuous(breaks=seq(13,85,5), limits=c(13, 85))

library(ggplot2)
df <- data.frame(x1 = 26, x2 = 28, x3 =29, y1 = 0, y2 = 400)
x<-ggplot(dat1, aes(age, fill = survey)) + 
  geom_histogram(alpha = 0.5, aes(y = ..count..), position = 'identity')+ xlab("Age of respondent")+ ylab("Number of respondents") +labs(fill="") + ggtitle(title)

x +geom_text(aes(x=27, label="Median Ages", y=-10), colour="blue", text=element_text(size=11))+ geom_segment(aes(x =c(x1,x2,x3), y = y1, xend = c(x1,x2,x3), yend = y2, colour = "segment"), data = df)  + theme_tufte() + theme( legend.position=c(0.9, 0.9)) + scale_x_continuous(breaks=seq(13,85,5), limits=c(13, 85))








