# EA SURVEY 2019 ANALYSIS 
#Set working dirctory to whereever you have stored EAS data
setwd("~/Downloads")
#Clear R
rm(list=ls())
#### Packages: Install and load#######
require(foreign)
install.packages(c("clusterSEs", "corrplot", "descr", "DT", "Matching", "pander", "pastecs", "plotly", "stargazer", "survey", "WeightIt", "Zelig"))
install.packages('ggplot2', dep = TRUE) 
install.packages("proto")
install.packages("margins")
install.packages("ordinal")
devtools:::install_github("ngreifer/cobalt")
install.packages("readstata13")
install.packages("nnet")
install.packages("Ecdat")
install.packages("ggthemes")  
install.packages("qwraps2")
install.packages("magrittr")
install.packages("dplyr")    # alternative installation of the %>%
install.packages("pastecs")
install.packages("gmodels")
install.packages("ggthemes")
install.packages("tidyverse")
install.packages("leaps")
install.packages("caret")
install.packages('RStata')
install.packages("readstata13")
if (!require("devtools")) install.packages("devtools")
devtools::install_github("peterhurford/surveytools2")
library(reshape2)
library(plyr)
library(RColorBrewer)
library(PerformanceAnalytics)
library(tidyverse)
library(caret)
library(leaps)
library(ggthemes) 
library(gmodels)
library(pastecs)
library(magrittr) 
library(dplyr)    # this also loads %>%
library(ordinal)
require(ggplot2)
require(MASS)
require(Hmisc)
require(reshape2)
library(tidyr)
library(dplyr)
library(Hmisc)
library(haven)
library(cobalt)
library(Matching)
library(WeightIt)
library(survey)
library(margins)
library(foreign)
library(plotly)
library(aod)
library(data.table)
library(zoo)
library(ggplot2)
library(Rcpp)
library(boot)
library(pastecs)
library(dplyr)
library(knitr)
library(descr)
require(scales)
require(gridExtra)
library(DT)
library(xtable)
library(stargazer)
library(sandwich)
library(lmtest)
require(foreign)
library(texreg)
library(clusterSEs)
library(pander)
library(Zelig)
library(nlme)
require(margins)
library(margins)
require(datasets)
library(likert)
library(corrplot)
library(tibble)
library(broom)
library(margins)
library(Ecdat)
library(ggridges)
library(tidyverse)
library(ggthemes) 
require(nnet)
library(nnet)
library(ggpubr)
library(magrittr)
library(qwraps2)
library(readxl)
library(car)
library(surveytools2)
options("RStata.StataPath")
options("RStata.StataVersion")
devtools:::install_github("ngreifer/cobalt")
library(readstata13)

#### LOAD DATA ####

#Load public data
#Read in github or CSv data
EAS<-read.csv("~/Downloads/2019-ea-survey-INTERNAL-WITH-NONEA-draft10.csv")
EAS<-read.csv("https://raw.githubusercontent.com/peterhurford/ea-data/2019/data/2019/2019-ea-survey-PUBLIC-draft7.csv",  stringsAsFactors=FALSE)
EAS<-read.csv("~/Downloads/2019-ea-survey-PUBLIC-draft10.csv")
EAS<-read.csv("~/Downloads/2019-ea-survey-INTERNAL-draft10.csv")
##OR pre-processed data from STATA or elsewgere e.g.
#library(readstata13)
#EAS <- read.dta13("~/Downloads/EAsurvey2019_cleaned.dta")

#Attach main data
attach(EAS)
summary(EAS)

##### Demographics and Community#####################

#Total sample size: Given 2153
##Age: distribution (histogram), median, mean
#Load internal dataset to get continous age variable
EASinternal<-read.csv("~/Downloads/2019-ea-survey-INTERNAL-draft7.csv")
EASinternal$age1 <- as.numeric(EAS$age1)
gghistogram(EASinternal, x = "age1", bins = 50, 
            add = "mean",add.params = list(linetype = "dashed", color="red",label = "mean"),main = "Distribution of Age")+ scale_x_continuous(breaks=seq(13,100,5))+ xlab("Age of respondent") + ylab("Number of respondents")  
mean(EASinternal$age1, na.rm= T)
median(EASinternal$age1, na.rm= T)
#Get agegroup stats from Public dataset
print(levels(age))
table(age)
table2 <- table(age)
prop.table(table2)
#convert to numeric to get mean/median
EAS$agenum <- as.numeric(EAS$age)
mean(agenum, na.rm= T)
median(agenum, na.rm= T)
print(levels(age))
#plot agegroup distribution
EAS2<- na.omit(subset(EAS, select = c(age)))
ggplot(EAS2, aes(x = age, fill=age)) +
  geom_bar(na.rm = TRUE,aes(y = (..count..)/sum(..count..))) +
  geom_text(aes(y = ((..count..)/sum(..count..)), label = scales::percent((..count..)/sum(..count..))), stat = "count", vjust = -0.25) +
  labs(title = "Distribution of Age", y = "Percent", x = "")+ theme(legend.position = "none")+ 
  
  
  
  ##Gender: descriptives (Male, Female, Other)
  #if for some reason you need to load internal dataset as main data instead
  #EAS<-read.csv("~/Downloads/2019-ea-survey-INTERNAL-draft7.csv")
  #attach(EAS)
  
  #get gender stats
  table(gender_b)
table2 <- table(gender_b)
prop.table(table2)
#plot gender distribution
EAS2<- na.omit(subset(EAS, select = c(gender_b)))
EAS2$gender_ordered = factor(EAS2$gender_b,levels(EAS2$gender_b)[c(2,1,3)])
ggplot(EAS2, aes(x = gender_ordered, fill=gender_ordered)) +
  geom_bar(na.rm = TRUE,aes(y = (..count..)/sum(..count..))) +
  geom_text(aes(y = ((..count..)/sum(..count..)), label = scales::percent((..count..)/sum(..count..))), stat = "count", vjust = -0.25) +
  scale_y_continuous(labels = percent) + theme_classic(base_size = 22) +
  labs(title = "Distribution of Gender", y = "Percent", x = "")+ theme(legend.position = "none")
#Drop "other" from gender
EAS2$gender_mf[EAS2$gender_ordered== "Male"] <- "Male"
EAS2$gender_mf[EAS2$gender_ordered== "Female"] <- "Female"
EAS2$gender_mf <-as.factor(EAS2$gender_mf)
levels(EAS2$gender_mf)
#get gender stats
EAS3<- na.omit(subset(EAS2, select = c(gender_mf)))
EAS3$gender_mf = factor(EAS3$gender_mf,levels(EAS3$gender_mf)[c(2,1)])
table(EAS3$gender_mf)
table2 <- table(EAS3$gender_mf)
prop.table(table2)
#Gender: comparison to 2018: Male (1,592, 69.82% ) Female (688, 30.18%)
#Plot gender distribution
ggplot(EAS3, aes(x = gender_mf, fill=gender_mf)) +
  geom_bar(na.rm = TRUE,aes(y = (..count..)/sum(..count..))) +
  geom_text(aes(y = ((..count..)/sum(..count..)), label = scales::percent((..count..)/sum(..count..))), stat = "count", vjust = -0.25) +
  scale_y_continuous(labels = percent) + theme_classic() +
  labs(title = "Distribution of Gender", y = "Percent", x = "")+ theme(legend.position = "none")


##Education: level (bar)
table(education)
table2 <- table(education)
prop.table(table2)
dev.off()
EAS2<- na.omit(subset(EAS, select = c(education)))
print(levels(education))
#Re-order education levels
EAS2$education_ordered = factor(EAS2$education,levels(EAS2$education)[c(8,4,7,1,2,6,5,3)])
ggplot(EAS2, aes(x = education_ordered, fill=education_ordered)) +
  geom_bar(na.rm = TRUE,aes(y = (..count..)/sum(..count..))) +
  geom_text(aes(y = ((..count..)/sum(..count..)), label = scales::percent((..count..)/sum(..count..))), stat = "count", vjust = -0.25) +
  scale_y_continuous(labels = percent) + theme_classic(base_size = 12) +
  labs(title = "Education level of EAs", y = "Percent", x = "Type of Education")+ theme(legend.position = "none")
##Group education levels
EAS2$educ <- EAS2$education
levels(EAS2$educ) <- list(Non_college=c("Some high school","High school graduate"),
                          Bachelors= c("Bachelor's degree"),
                          Masters=c("Master's degree"),
                          PhD=c("Doctoral degree"),
                          Other_college=c("Associate's degree","Professional degree","Some college, no degree"))
print(levels(EAS2$educ))
#get stats
table(EAS2$educ)
table2 <- table(EAS2$educ)
prop.table(table2)
#plot
dev.off()
print(levels(EAS2$educ))
EAS3<- na.omit(subset(EAS2, select = c(educ)))
ggplot(EAS3, aes(x = educ, fill=educ)) +
  geom_bar(na.rm = TRUE,aes(y = (..count..)/sum(..count..))) +
  geom_text(aes(y = ((..count..)/sum(..count..)), label = scales::percent((..count..)/sum(..count..))), stat = "count", vjust = -0.25) +
  scale_y_continuous(labels = percent) + theme_classic() +
  labs(title = "Distribution of Education", y = "Percent", x = "Type of Education")+ theme(legend.position = "none")
#Education: comparisons to 2018 42.6% BA, 30.4% MA, 14.4% PhD, 12% other college, 0.7% Non-College

#Education: disciplines (bar)
#Need to load pre-processed data
dat <- read.dta13("~/Downloads/EAS_subject.dta")
p=ggplot(data=dat)  
p+geom_bar(stat="identity")+  #
  aes(x=reorder(dat$subjectstudied,percent,sum),y=percent,label=percent,fill=dat$subjectstudied)+geom_text(aes(label=scales::percent(percent), hjust=1))+scale_y_continuous(labels = percent) + theme_classic(base_size = 22) +
  labs(title = "Subjects studied by EAs", y = "Percent", x = "")+ theme(legend.position = "none")+ coord_flip()

#All disciplines are in logic class, convert to factor?
logical_vars <- lapply(EAS, class) == "logical"
EAS[, logical_vars] <- lapply(EAS[, logical_vars], as.factor)
#Stats
table(EAS$studied_econ)
table(EAS$studied_engineering)
table(EAS$studied_math)
table(EAS$studied_medicine)
table(EAS$studied_psych)
table(EAS$studied_phil)
table(EAS$studied_physics)
table(EAS$studied_humanities)
table(EAS$studied_social_science)
table(EAS$studied_other_science)
table(EAS$studied_vocational)



#Education: university of undergraduate, descriptives [if included]
#? not included in datasets
table(university)
#Careers: employment status- descriptives (bar)
dat <- read.dta13("~/Downloads/EAS_job.dta")
p=ggplot(data=dat)  
p+geom_bar(stat="identity")+  #
  aes(x=reorder(dat$employmenttype,percent,sum),y=percent,label=percent,fill=dat$employmenttype)+geom_text(aes(label=scales::percent(percent), hjust=1))+scale_y_continuous(labels = percent) + theme_classic(base_size = 18) +
  labs(title = "Employment/Student status of EAs", y = "Percent", x = "")+ theme(legend.position = "none")+ coord_flip()

#employed_full_time employed_part_time employed_self employed_looking employed_not_looking employed_homemaker employed_retired employed_student_part employed_student_full

table(job)
barplot(table(job), main="Employment Status Distribution",
        xlab="Employment Status",ylab = "Frequency")
table2 <- table(job)
barplot(prop.table(job), main="Employment Status Distribution",
        xlab="Employment Status",ylab = "Proportion")

##UNFINISHED Graphics: Have added descriptives to shared G-Sheet

#Careers: field of employment- descriptives (bar)
dat <- read.dta13("~/Downloads/EAS_experience.dta")
p=ggplot(data=dat)  
p+geom_bar(stat="identity")+  #
  aes(x=reorder(dat$workexperience,percent,sum),y=percent,label=percent,fill=dat$workexperience)+geom_text(aes(label=scales::percent(percent), vjust=0))+scale_y_continuous(labels = percent) + theme_classic() +
  labs(title = "3 years work or graduate", y = "Percent", x = "")+ theme(legend.position = "none")+ coord_flip()

dat <- read.dta13("~/Downloads/EAS_careerpath.dta")
p=ggplot(data=dat)  
p+geom_bar(stat="identity")+  #
  aes(x=reorder(dat$careerpath,percent,sum),y=percent,label=percent,fill=dat$careerpath)+geom_text(aes(label=scales::percent(percent), hjust=1))+scale_y_continuous(labels = percent) + theme_classic() +
  labs(title = "Expected career paths of EAs", y = "Percent", x = "")+ theme(legend.position = "none")+ coord_flip()


table(field)
barplot(table(field), main="Field of employment Distribution",
        xlab="Field of employment ",ylab = "Frequency")
table2 <- table(field)
barplot(prop.table(field), main="Field of employment Distribution",
        xlab="Field of employment ",ylab = "Proportion")
#Geography: country- descriptives (bar or map)
table(country)
barplot(table(country), main="Geographic Distribution",
        xlab="Country",ylab = "Frequency")
table2 <- table(country)
barplot(prop.table(country), main="Geographic Distribution",
        xlab="Country",ylab = "Proportion")
#Geography: city- descriptives (bar) 
table(city)
barplot(table(city), main="Geographic Distribution",
        xlab="city",ylab = "Frequency")
table2 <- table(city)
barplot(prop.table(city), main="Geographic Distribution",
        xlab="city",ylab = "Proportion")
##[defer mostly to Geography post]
#Race: descriptives
table(race)
#Race: comparison to 2018/2017
dat <- read.dta13("~/Downloads/EAS_race1.dta")
p=ggplot(data=dat)  
p+geom_bar(stat="identity")+  #
  aes(x=reorder(dat$raceethnicity,percent,sum),y=percent,label=percent,fill=dat$raceethnicity)+geom_text(aes(label=scales::percent(percent), hjust=1))+scale_y_continuous(labels = percent) + theme_classic(base_size = 15) +
  labs(title = "Race/Ethnicity distribution of EAs", y = "Percent", x = "")+ theme(legend.position = "none")+ coord_flip()

#Religion: descriptives
table(religion)
#Religion: comparison to 2018
#Diet: descriptives
table(diet)
#Diet: comparison to 2018

print(levels(EAS$veg))
EAS3<- na.omit(subset(EAS, select = c(veg)))
EAS3$veg_c = factor(EAS3$veg,levels(EAS3$veg)[c(4,3,1,6,5,2)])
print(levels(EAS3$veg_c))
p<-ggplot(EAS3, aes(x = veg_c, fill=veg_c)) +
  geom_bar(na.rm = TRUE,aes(y = (..count..)/sum(..count..))) +
  geom_text(aes(y = ((..count..)/sum(..count..)), label = scales::percent((..count..)/sum(..count..))), stat = "count", hjust = 1) +
  scale_y_continuous(labels = percent) + theme_classic(base_size = 18) +
  labs(title = "Diets of EAs", y = "Percent", x = "")+ theme(legend.position = "none")
p + coord_flip()

#Education: comparisons to 2018 42.6% BA, 30.4% MA, 14.4% PhD, 12% other college, 0.7% Non-College
#religion
dat <- read.dta13("~/Downloads/EAS_religion.dta")
p=ggplot(data=dat)  
p+geom_bar(stat="identity")+  #
  aes(x=reorder(dat$religion,percent,sum),y=percent,label=percent,fill=dat$religion)+geom_text(aes(label=scales::percent(percent), hjust=1))+scale_y_continuous(labels = percent) + theme_classic(base_size = 18) +
  labs(title = "Religious Affiliations of EAs", y = "Percent", x = "")+ theme(legend.position = "none")+ coord_flip()


#Politics: descriptives

dat <- read.dta13("~/Downloads/EAS_politics.dta")
p=ggplot(data=dat)  
p+geom_bar(stat="identity")+  #
  aes(x=reorder(dat$politicalbelief,percent,sum),y=percent,label=percent,fill=dat$politicalbelief)+geom_text(aes(label=scales::percent(percent), vjust=0))+scale_y_continuous(labels = percent) + theme_classic() +
  labs(title = "Political Beliefs", y = "Percent", x = "")+ theme(legend.position = "none")+ coord_flip()

table(politics)
#Politics: comparison to 2018
#Morality: normative ethics: descriptives
dat <- read.dta13("~/Downloads/EAS_morals.dta")
p=ggplot(data=dat)  
p+geom_bar(stat="identity")+  #
  aes(x=reorder(dat$moralview,percent,sum),y=percent,label=percent,fill=dat$moralview)+geom_text(aes(label=scales::percent(percent), vjust=0))+scale_y_continuous(labels = percent) + theme_classic() +
  labs(title = "Moral View", y = "Percent", x = "")+ theme(legend.position = "none")+ coord_flip()

table(normative)
#Morality: metaethics: descriptives
dat <- read.dta13("~/Downloads/EAS_ethics.dta")
p=ggplot(data=dat)  
p+geom_bar(stat="identity")+  #
  aes(x=reorder(dat$leantowards,percent,sum),y=percent,label=percent,fill=dat$leantowards)+geom_text(aes(label=scales::percent(percent), vjust=0))+scale_y_continuous(labels = percent) + theme_classic() +
  labs(title = "Ethical View", y = "Percent", x = "")+ theme(legend.position = "none")+ coord_flip()

table(metaethics)
##### Where First Heard and Get Involved######################
#get stats
table(first_heard_EA)
table2 <- table(first_heard_EA)
prop.table(table2)
#Where first heard: descriptives: (bar chart)
#? Unsure how to re-order "(..count..)/sum(..count..)"
EAS2<- na.omit(subset(EAS, select = c(first_heard_EA)))
p<-ggplot(EAS2, aes(x = first_heard_EA, fill=first_heard_EA)) +
  geom_bar(na.rm = TRUE,aes(y = (..count..)/sum(..count..))) +
  geom_text(aes(y = ((..count..)/sum(..count..)), label = scales::percent((..count..)/sum(..count..))), stat = "count", vjust = -0.25) +
  scale_y_continuous(labels = percent) + theme_classic() +
  labs(title = "Where first heard of EA", y = "Percent", x = "")+ theme(legend.position = "none")
p + coord_flip()

##Or load descriptives from table into a separate dataset e.g. Excel or STATA
library(haven)
dat <- read_dta("Downloads/EAS2019_firstheard.dta")
dat <- read_dta("Downloads/EAS2019_involved.dta")

#dat <- read.dta13("~/Users/neildullaghan/Downloads/Downloads/EAS2019_firstheard.dta")
dat$firstheardofea <- as.factor(dat$firstheardofea)
p=ggplot(data=dat)  
p+geom_bar(stat="identity")+  #
  aes(x=reorder(dat$firstheardofea,percent,sum),y=percent,label=percent,fill=dat$firstheardofea)+geom_text(aes(label=scales::percent(percent), hjust=1))+scale_y_continuous(labels = percent) + theme_classic() +
  labs(title = "Where first heard of EA (2019 Survey)", y = "Percent", x = "")+ theme(legend.position = "none")+ coord_flip()


#Where first heard: comparison to last year
https://forum.effectivealtruism.org/posts/S4WmbHJr32WcmwFD7/ea-survey-series-2018-where-people-first-hear-about-ea-and
#? Excel/G-Sheet:Where first heard: Other open comment breakdown 
#? Excel/G-Sheet:Where first heard: Other open comment: (bar chart)
#? Excel/G-Sheet:Where first heard: year by year breakdown (Area Chart?)
#? Comparison of year by year (2019) to year by year (2018) 
#? (Area chart), (line chart) etc (absolute and proportions)
#? Excel/G-Sheet:Frequency per first year

#Getting involved: descriptives: (bar chart)
table(EAS$involved_tlycs)	
table(EAS$involved_local_EA)	
table(EAS$involved_lesswrong)
table(EAS$involved_givewell)
table(EAS$involved_ace	)
table(EAS$involved_ssc)	
table(EAS$involved_online_ea)	
table(EAS$involved_personal_contact)	
table(EAS$involved_80K)	
table(EAS$involved_GWWC	)
table(EAS$involved_ea_global)	
table(EAS$involved_ea_global_x)	
table(EAS$involved_book_blog)	
table(EAS$involved_podcast)	
table(EAS$involved_swiss)	
table(EAS$involved_none_of_the_above)	
table(EAS$involved_other)
#? Unsure how to group the involved_ variables & re-order "(..count..)/sum(..count..)"
EAS2<- na.omit(subset(EAS, select = c(?)))
p<-ggplot(EAS2, aes(x = ?, fill=?)) +
  geom_bar(na.rm = TRUE,aes(y = (..count..)/sum(..count..))) +
  geom_text(aes(y = ((..count..)/sum(..count..)), label = scales::percent((..count..)/sum(..count..))), stat = "count", vjust = -0.25) +
  scale_y_continuous(labels = percent) + theme_classic() +
  labs(title = "Which factors were important in 'getting you into' effective altruism, or altering your actions in its direction? ", y = "Percent", x = "")+ theme(legend.position = "none")
p + coord_flip()

##Or load descriptives from table into a separate dataset e.g. Excel or STATA
library(haven)
dat <- read_dta("Downloads/EAS2019_firstheard.dta")
#dat <- read.dta13("~/Downloads/EAS2019_involved.dta")
dat$whichfactorswereimportantingetti <- as.factor(dat$whichfactorswereimportantingetti)
p=ggplot(data=dat)  
p+geom_bar(stat="identity")+  #
  aes(x=reorder(dat$whichfactorswereimportantingetti,percent,sum),y=percent,label=percent,fill=dat$whichfactorswereimportantingetti)+geom_text(aes(label=scales::percent(percent), hjust=1))+scale_y_continuous(labels = percent) + theme_classic() +
  labs(title = "Which factors were important in 'getting you into' effective altruism? ", y = "Percent EAs who selected as important for 'getting into' EA", x = "")+ theme(legend.position = "none")+ coord_flip()

#Getting involved: comparison to last year
https://forum.effectivealtruism.org/posts/uPFx462NAamBo5Eqq/ea-survey-series-2018-how-do-people-get-involved-in-ea
#? Getting involved:  year by year breakdown
#? Comparison of 2019’s 2018 yby breakdown to 2018

##FISCHER's exact
if(!require(rcompanion)){install.packages("rcompanion")}
dat <- read_dta("/Users/neildullaghan/Downloads/first.dta")


##Redo gender as in demogrpahics section
EAS2<- (subset(EAS, select = c(gender_b, first_heard_EA)))
EAS2$gender_ordered = factor(EAS2$gender_b,levels(EAS2$gender_b)[c(2,1,3)])
ggplot(EAS2, aes(x = gender_ordered, fill=gender_ordered)) +
  geom_bar(na.rm = TRUE,aes(y = (..count..)/sum(..count..))) +
  geom_text(aes(y = ((..count..)/sum(..count..)), label = scales::percent((..count..)/sum(..count..))), stat = "count", vjust = -0.25) +
  scale_y_continuous(labels = percent) + theme_classic(base_size = 22) +
  labs(title = "Distribution of Gender", y = "Percent", x = "")+ theme(legend.position = "none")
#Drop "other" from gender
EAS2$gender_mf[EAS2$gender_ordered== "Male"] <- "Male"
EAS2$gender_mf[EAS2$gender_ordered== "Female"] <- "Female"
EAS2$gender_mf <-as.factor(EAS2$gender_mf)
levels(EAS2$gender_mf)

##

#### Donations: Use Kim's Script! The script below needs updating ####
EAS <- read_dta("Downloads/EAS_draft18.dta")
attach(EAS)

EAS$donate_new <-as.numeric(EAS$donate_new)
EAS$donate_log10<-as.numeric(EAS$donate_log10)
attach(EAS)
str(donate_new )
EAS2<- na.omit(subset(EAS, select = c(donate_new)))
mean(EAS$donate_new, na.rm= T)
median(EAS$donate_new, na.rm= T)
library(scales)
#log histogram
p <- ggplot(EAS2, aes(x=donate_new)) +
  geom_histogram(fill="white", color="black")+
  labs(title="Histogram of 2018 Donations",x="2018 Donations", y = "Number of EAs")+
  theme_classic()
require(scales)
p + scale_x_continuous( trans = log10_trans(),
                        breaks = trans_breaks("log10", function(x) 10^x),
                        label = comma)
###PERCENT
EAS <- read_dta("Downloads/EAS_draft20.dta")
attach(EAS)
EAS$percent1 <-as.numeric(EAS$percent1,add = "median" )
EAS2<- na.omit(subset(EAS, select = c(percent1)))
p <- ggplot(EAS2, aes(x=percent1)) +
  geom_histogram(fill="white", color="black")+
  labs(title="Histogram of % donated",x="% donated", y = "Number of EAs")+
  theme_classic()
p
p +geom_vline(aes(xintercept=median(percent1)), color="blue",
              linetype="dashed")+geom_text(aes(x=.50, label="Median", y=600), colour="blue", text=element_text(size=11))+ 

  gghistogram(EAS2, x = "percent1", bins = 70, 
              add = "median",add.params = list(linetype = "dashed", color="red",label = "median"),main = "Histogram of percent of income donated")+ xlab("% donated") + ylab("Number of EAs")+geom_text(aes(x=7, label="Median", y=330), colour="red", text=element_text(size=11))  + scale_x_continuous(breaks=seq(0,100,10), limits=c(0, 100)) + scale_y_continuous(breaks=seq(0,350,50), limits=c(0, 350))
mean(EAS2$percent1, na.rm= T)
median(EAS2$percent1, na.rm= T)
#log histogram
p <- ggplot(EAS2, aes(x=donate_new,add = "median")) +
  geom_histogram(fill="white", color="black")+
  geom_vline(aes(xintercept=median(donate_new)), color="blue",
             linetype="dashed")+geom_text(aes(x=600, label="Median", y=180), colour="blue", text=element_text(size=11))+ 
  labs(title="Histogram of 2018 Donations",x="2018 Donations", y = "Number of EAs")+
  theme_classic()
require(scales)
p + scale_x_continuous( trans = log10_trans(),
                        breaks = trans_breaks("log10", function(x) 10^x),
                        label = comma)

p<-gghistogram(EAS, x = "donate_log10", bins = 50, 
               add = "median",main = "Distribution of donations")+ scale_x_continuous("donate_new") + xlab("Donations") + ylab("Number of respondents")  
p+ theme_classic() 

##INCOME

EAS <- read_dta("Downloads/EAS_draft20.dta")
attach(EAS)

EAS$donate_new <-as.numeric(EAS$donate_new)
EAS$donate_log10<-as.numeric(EAS$donate_log10)
EAS$income_log10<-as.numeric(EAS$income_log10)
EAS$income_new<-as.numeric(EAS$income_new)
library(ggpubr)
library(tibble)
library(tidyverse)
EASnew <- EAS[,c("donate_new","income_new","income_log10","donate_log10")]

title <- "Income versus donations"
sp <- ggscatter(EASnew, x = "income_log10", y = "donate_log10",
                repel = TRUE, palette = "jco",
                add = "loess", add.params = list(color = "blue", fill = "lightgray"),conf.int = FALSE)
sp + stat_cor(aes(label = paste(..rr.label.., ..p.label.., sep = "~`,`~")), label.x.npc = "center", label.y.npc = "bottom",) + ggtitle(title)  + xlab("Income(log)") + ylab("Donations (log)")  
##INCOME DONATIONS CORRELATION
library(haven)
EAS <- read_dta("EAS_dropped1dta.dta")

EAS$donate_new <-as.numeric(EAS$donate_new)
EAS$donate_log10<-as.numeric(EAS$donate_log10)
EAS$income_log10<-as.numeric(EAS$income_log10)
EAS$income_new<-as.numeric(EAS$income_new)
library(ggpubr)
library(tibble)
library(tidyverse)
EASnew <- EAS[,c("donate_new","income_new","income_log10","donate_log10")]


title <- "Donations against Income in 2018"
sp <- ggscatter(EASnew, x = "income_new", y = "donate_new",
                repel = TRUE, palette = "jco",
                add = "loess", add.params = list(color = "blue", fill = "lightgray"),conf.int = FALSE)+ scale_x_continuous( trans = log10_trans(),
                                                                                                                            breaks = trans_breaks("log10", function(x) 10^x),
                                                                                                                            label = comma)+ scale_y_continuous( trans = log10_trans(),
                                                                                                                                                                breaks = trans_breaks("log10", function(y) 10^y),
                                                                                                                                                                label = comma)
sp + stat_cor(aes(label = paste(..rr.label.., ..p.label.., sep = "~`,`~")), label.x.npc = "left", label.y.npc = "top",) + ggtitle(title)  + xlab("Income ($)") + ylab("Donations ($)")  


bubble <- read_dta("Downloads/bubble19.dta")
attach(bubble)

title <- "Median donations by years in EA"
ggplot(bubble, aes(x=yearsinea, y=median, size=n, color=yearsinea)) +
  geom_point(alpha=0.4) +
  scale_size_continuous(range=c(1, 15)) +
  scale_colour_continuous(guide = FALSE) +
  xlab("Years in EA") +
  ylab("Median Donation")+
  labs( size = "Total Number of EAs" ) +
  theme_bw()  + ggtitle(title) + 
  scale_x_continuous(breaks=seq(0, 10, 1))

rm(list=ls())
library(nlme)
library(corrplot)
EAS <- read.dta13("~/Downloads/EAS_currency.dta")


#predictors of donate_new
EAnew <- EAS[,c("donate_new","income_new", "yearsinea","age1", "student", "gwwc_member")]

summary(EAnew)
#look for outliers
outinc=max(EAnew$income_new,na.rm=TRUE)
outinc
#remove the 70M point
EAS=EAnew[(EAnew$income_new<7000000),]
summary(EAS)


#log transform
EASl=EAS
EASl[,1:2]=log(EASl[,1:2])
summary(EASl)

#remove all the infs from logging
EASt=EASl
EASt=EASt[(!is.infinite(EASt[,1])),]
EASt=EASt[(!is.infinite(EASt[,2])),]

#scale logged data
scars=scale((EASt[,1:2]))
EASt[,1:2]=scale(EASt[,1:2])
summary(EASt)

# Save scaled attibutes:

scaleList <- list(scale = attr(scars, "scaled:scale"),
                  center = attr(scars, "scaled:center"))

#check for correlations among numerical explanatory variables
sub=data.frame(ldonate=(EASt[,1]),lincome_ind=(EASt[,2]),
               year=EASt[,3], age=EASt[,4],student=EASt$student, member_gwwc=EASt$gwwc_member)
M<-cor(sub[,1:4], use="complete.obs")
head(round(M,2))
corrplot(M, type="upper")

#first model with multiple non-iteracting factors (exclude household which correlates with ind_income)

dlm<-lm((donate_new)~(income_new)+yearsinea++age1+factor(student)+factor(gwwc_member), data=EASt, na.action=na.exclude)

#check for regression assumptions
layout(matrix(1:4,2,2))
plot(dlm)

#access regression
summary(dlm)
AIC(dlm)


# model with JUST income
dlmbas<-lm(donate_new~income_new,data=EASt, na.action=na.exclude)
summary(dlmbas)

AIC(dlmbas)
#remove all NAs in order to run backwards elimination
EAStn = na.omit(EASt)
summary(EAStn)


#set up only intercept model
null=lm(donate_new~1, data=EAStn, na.action=na.exclude)

#set up all pairwise interactions model
full=lm(donate_new~(.)^2, data=EAStn, na.action=na.exclude)
step(null, scope=list(lower=null, upper=full), direction="forward",na.action=na.exclude)


#step back thu full model
sback<-step(full, data=EAStn, direction="backward", trace=0)
sback$anova
summary(sback)



#step forward and back between null and full
sboth<-step(null, scope = list(upper=full), data=EAStn, direction="both",trace=0)
sboth$anova
summary(sboth)


#plot the model rescaling back to original data

#colour-code the interactions

for (i in 1:nrow(EAStn)){
  if (!is.na(EAStn$student[i]) & !is.na(EAStn$gwwc_member[i])){
    
    if(EAStn$student[i]=="TRUE" & EAStn$gwwc_member[i]=="Member") {EAStn$fact[i]="green"}
    else if(EAStn$student[i]=="FALSE" & EAStn$gwwc_member[i]=="Member") {EAStn$fact[i]="blue"}
    else if(EAStn$student[i]=="FALSE" & EAStn$gwwc_member[i]=="no") {EAStn$fact[i]="orange"}
    else if(EAStn$student[i]=="TRUE" & EAStn$gwwc_member[i]=="no") {EAStn$fact[i]="red"}
    
    
  }else {EAStn$fact[i]="gray"}
  
  
}
cscal=as.data.frame(scaleList)
options(scipen=999)
layout(matrix(1:1,1,1))
dlm=sback
reEA=EAStn
reEA[,1]=(reEA[,1])*cscal$`scale`[1]+cscal$center[1]
reEA[,2]=(reEA[,2])*cscal$`scale`[2]+cscal$center[2]


reEA[,1:2]=exp(reEA[,1:2])
plot(reEA$donate_new~reEA$income_new, log="xy",col=reEA$fact, cex.lab=1.5,pch=20,xlab="$ individual income", ylab=("$ donations"))


#plot(EASt$donate_new~EASt$income_new, col=EASt$fact, pch=20,xlab="log individual income", ylab=("log donations"))

mEA=mean(reEA$yearsinea, na.rm=TRUE)
mage=mean(reEA$age1, na.rm=TRUE)

pdat=data.frame(income_new=seq(from=-5.75, to=2.5, by=0.1), yearsinea=mEA, age1=mage, student="FALSE", gwwc_member="Member")
outp=predict(dlm, pdat, type="response")

outp=outp*cscal$`scale`[1]+cscal$center[1]
pdat$income_new=pdat$income_new*cscal$`scale`[2]+cscal$center[2]
lines(exp(outp)~exp(pdat$income_new), col="blue", lwd=2)


pdat1=data.frame(income_new=seq(from=-5.75, to=2.5, by=0.1), yearsinea=mEA, age1=mage, student="TRUE", gwwc_member="Member")
outp1=predict(dlm, pdat1, type="response")
outp1=outp1*cscal$`scale`[1]+cscal$center[1]
pdat1$income_new=pdat1$income_new*cscal$`scale`[2]+cscal$center[2]
lines(exp(outp1)~exp(pdat$income_new), col="green", lwd=2)


pdat1=data.frame(income_new=seq(from=-5.75, to=2.5, by=0.1), yearsinea=mEA, age1=mage, student="TRUE", gwwc_member="no")
outp1=predict(dlm, pdat1, type="response")
outp1=outp1*cscal$`scale`[1]+cscal$center[1]
pdat1$income_new=pdat1$income_new*cscal$`scale`[2]+cscal$center[2]
lines(exp(outp1)~exp(pdat$income_new), col="red", lwd=2)

pdat1=data.frame(income_new=seq(from=-5.75, to=2.5, by=0.1), yearsinea=mEA, age1=mage, student="FALSE", gwwc_member="no")
outp1=predict(dlm, pdat1, type="response")
outp1=outp1*cscal$`scale`[1]+cscal$center[1]
pdat1$income_new=pdat1$income_new*cscal$`scale`[2]+cscal$center[2]
lines(exp(outp1)~exp(pdat$income_new), col="orange", lwd=2)

legend("topleft", c("nonstudent member GWWC", "student member GWWC", "not student, not member", "student, not member", "NA" ),
       pch=20, lty=1, col=c("blue","green","orange", "red", "gray"), bty="n")




#### Cause Selection ####

#Top cause: totals (bar): ??FIX LABELS??

#Rename LTF for better visualization
EAS$top_case<-as.factor(EAS$top_case)
print(levels(EAS$top_case))
levels(EAS$top_case)[levels(EAS$top_case)=="Long Term Future / Catastrophic and Existential Risk Reduction"]<-"Long Term Future"
#attach new label
attach(EAS)
#stats
table(EAS$top_case)
table2 <- table(top_case)
prop.table(table2)
EAS2<- na.omit(subset(EAS, select = c(top_case)))
print(levels(EAS2$top_case))

#plot
library(scales)
EAS2$top_case = factor(EAS2$top_case,levels(EAS2$top_case)[c(3,2,4,1,5)])
ggplot(EAS2, aes(x = top_case, fill=top_case)) +
  geom_bar(na.rm = TRUE,aes(y = (..count..)/sum(..count..))) +
  geom_text(aes(y = ((..count..)/sum(..count..)), label = scales::percent((..count..)/sum(..count..))), stat = "count", vjust = -0.25) +
  scale_y_continuous(labels = percent) + theme_classic(base_size = 15) +
  labs(title = "Top cause area if forced to choose only one", y = "Percent", x = "")+ theme(legend.position = "none")

##BY GROUP
table(EAS2$top_case,EAS2$member_ea_fb)
table(EAS2$top_case,EAS2$member_ea_forum)	
table(EAS2$top_case,EAS2$member_lw	)
table(EAS2$top_case,EAS2$member_local_group)

table2 <- table(EAS2$top_case,EAS2$member_gwwc)
prop.table(table2)
table(EAS2$top_case,EAS2$member_none_of_the_above)	
table(EAS2$top_case,EAS2$member_other)	


#EAS<- na.omit(subset(EAS2, select = c(gender_mf)))
EAS$gender_mf[EAS$gender_b== "Male"] <- "Male"
EAS$gender_mf[EAS$gender_b== "Female"] <- "Female"
EAS$gender_mf <-as.factor(EAS$gender_mf)
levels(EAS$gender_mf)
EAS$gender_mf = factor(EAS$gender_mf,levels(EAS$gender_mf)[c(2,1)])
table(top_case,gender_mf)


#### Full Range #### 
#Cause selection: full scale: (likert graph) (table) (“near top” table): : ??FIX LABELS??
#EAS2<- na.omit(subset(EAS, select = c(cause_import_animal_welfare,	cause_import_cause_prioritization,	cause_import_biosecurity,	cause_import_climate_change,	cause_import_nuclear_security,	cause_import_ai,	cause_import_mental_health,	cause_import_poverty,	cause_import_rationality,	cause_import_meta,	cause_import_xrisk_other,	cause_import_other)))
newdata <- [ which(EAS$ea_engaged_scale==5 )]
newdata <- EAS[ which(activity_employed_ea_org==TRUE,ea_org_employed==1),]
EAS2<- (subset(newdata, select = c(cause_import_animal_welfare,	
                               cause_import_cause_prioritization,	
                               cause_import_biosecurity,	
                               cause_import_climate_change,
                               cause_import_nuclear_security,
                               cause_import_ai,	
                               cause_import_mental_health,
                               cause_import_poverty,	
                               cause_import_rationality,
                               cause_import_meta,	
                               cause_import_xrisk_other
)))

levels(EAS2$cause_import_animal_welfare)<-c("I do not think any resources should be devoted to this cause", 
                                            "I do not think this is a priority, but should receive some resources",
                                            NA,  
                                            "This cause deserves significant resources, but less than the top priorities", 
                                            "This cause should be a near-top priority", 
                                            "This cause should be the top priority (Please choose one)")
levels(EAS2$cause_import_cause_prioritization)<-c("I do not think any resources should be devoted to this cause", 
                                                  "I do not think this is a priority, but should receive some resources",
                                                  NA,  
                                                  "This cause deserves significant resources, but less than the top priorities", 
                                                  "This cause should be a near-top priority", 
                                                  "This cause should be the top priority (Please choose one)")
levels(EAS2$cause_import_biosecurity)<-c("I do not think any resources should be devoted to this cause", 
                                         "I do not think this is a priority, but should receive some resources",
                                         NA,  
                                         "This cause deserves significant resources, but less than the top priorities", 
                                         "This cause should be a near-top priority", 
                                         "This cause should be the top priority (Please choose one)")
levels(EAS2$cause_import_climate_change)<-c("I do not think any resources should be devoted to this cause", 
                                            "I do not think this is a priority, but should receive some resources",
                                            NA,  
                                            "This cause deserves significant resources, but less than the top priorities", 
                                            "This cause should be a near-top priority", 
                                            "This cause should be the top priority (Please choose one)")
levels(EAS2$cause_import_nuclear_security)<-c("I do not think any resources should be devoted to this cause", 
                                              "I do not think this is a priority, but should receive some resources",
                                              NA,  
                                              "This cause deserves significant resources, but less than the top priorities", 
                                              "This cause should be a near-top priority", 
                                              "This cause should be the top priority (Please choose one)")
levels(EAS2$cause_import_ai)<-c("I do not think any resources should be devoted to this cause", 
                                "I do not think this is a priority, but should receive some resources",
                                NA,  
                                "This cause deserves significant resources, but less than the top priorities", 
                                "This cause should be a near-top priority", 
                                "This cause should be the top priority (Please choose one)")
levels(EAS2$cause_import_mental_health)<-c("I do not think any resources should be devoted to this cause", 
                                           "I do not think this is a priority, but should receive some resources",
                                           NA,  
                                           "This cause deserves significant resources, but less than the top priorities", 
                                           "This cause should be a near-top priority", 
                                           "This cause should be the top priority (Please choose one)")
levels(EAS2$cause_import_poverty)<-c("I do not think any resources should be devoted to this cause", 
                                     "I do not think this is a priority, but should receive some resources",
                                     NA,  
                                     "This cause deserves significant resources, but less than the top priorities", 
                                     "This cause should be a near-top priority", 
                                     "This cause should be the top priority (Please choose one)")

levels(EAS2$cause_import_rationality)<-c("I do not think any resources should be devoted to this cause", 
                                         "I do not think this is a priority, but should receive some resources",
                                         NA,  
                                         "This cause deserves significant resources, but less than the top priorities", 
                                         "This cause should be a near-top priority", 
                                         "This cause should be the top priority (Please choose one)")
levels(EAS2$cause_import_meta)<-c("I do not think any resources should be devoted to this cause", 
                                  "I do not think this is a priority, but should receive some resources",
                                  NA,  
                                  "This cause deserves significant resources, but less than the top priorities", 
                                  "This cause should be a near-top priority", 
                                  "This cause should be the top priority (Please choose one)")
levels(EAS2$cause_import_xrisk_other)<-c("I do not think any resources should be devoted to this cause", 
                                         "I do not think this is a priority, but should receive some resources",
                                         NA,  
                                         "This cause deserves significant resources, but less than the top priorities", 
                                         "This cause should be a near-top priority", 
                                         "This cause should be the top priority (Please choose one)")

##Fix labels
EAS2[] <- lapply(EAS2, factor, 
                 levels=c("I do not think any resources should be devoted to this cause",
                          "I do not think this is a priority, but should receive some resources",
                          "This cause deserves significant resources, but less than the top priorities",
                          "This cause should be a near-top priority",
                          "This cause should be the top priority (Please choose one)"), 
                 labels = c("No Resources", "Some Resources", "Significant Resources", "Near-Top Priority", "Top Priority"))
str(EAS2)

names(EAS2) = c(cause_import_animal_welfare = "Animal welfare",	
                cause_import_cause_prioritization= "Cause prioritization",	
                cause_import_biosecurity= "Biosecurity",	
                cause_import_climate_change= "Climate change",
                cause_import_nuclear_security ="Nuclear security",
                cause_import_ai ="AI risk",
                cause_import_mental_health ="Mental health",
                cause_import_poverty ="Global poverty",	
                cause_import_rationality ="Improving rationality",
                cause_import_meta ="Meta charities",	
                cause_import_xrisk_other ="Other x-risk"
)

#Plot Likert
library(likert)
likert(EAS2)
summary(EAS2)
Result = likert(EAS2)
title <- "Work(ed) at an EA Organization Cause Prioritization "
plot(Result,
     type="bar") +ggtitle(title)
plot(Result,
     type="bar", ordered=FALSE,
     group.order=c("AI risk",
                   "Cause prioritization",
                   "Biosecurity",
                   "Meta charities",
                   "Other x-risk",
                   "Animal welfare",
                   "Global poverty",
                   "Improving rationality",
                   "Nuclear security",
                   "Climate change",
                   "Mental health"
                    )) +ggtitle(title)

require(likert)
lgr <- likert(EAS2)
summary(lgr)
tp=as.data.frame(lgr$results)
tp=tp[,-2]
names(tp)[1]="Item"
lgr2=(likert(summary=tp))
title <- "Cause Selections"
plot(lgr2) + ggtitle(title)
plot(lgr2, ordered=FALSE,
     group.order=lgr2$results$Item[order(lgr2$results['mean'],decreasing = TRUE)])


##DROP NOT SURE LEVEL
EAS2$gender_mf[EAS2$gender_ordered== "Male"] <- "Male"
EAS2$gender_mf[EAS2$gender_ordered== "Female"] <- "Female"
EAS2$gender_mf <-as.factor(EAS2$gender_mf)
levels(EAS2$gender_mf)
#Mean score: table, bar?


#NEED TO CREATE NUMERIC e.g. povnum<-as.numer
#Recode variable to numeric
EAS2<- na.omit(subset(EAS, select = c(cause_import_animal_welfare,	cause_import_cause_prioritization,	cause_import_biosecurity,	cause_import_climate_change,	cause_import_nuclear_security,	cause_import_ai,	cause_import_mental_health,	cause_import_poverty,	cause_import_rationality,	cause_import_meta,	cause_import_xrisk_other,	cause_import_other)))
EAS2 <- data.frame(lapply(EAS2, function(x) as.numeric(as.factor(x))))
meancause<-colMeans(EAS2[sapply(EAS2, is.numeric)])
meancause
#


#Descriptives: top cause (mean?): Forum, LW, other membership groups? (bar)
table(top_case,member_ea_fb)
table(top_case,member_ea_forum)	
table(top_case,member_lw	)
table(top_case,member_local_group)	
table(top_case,member_none_of_the_above)	
table(top_case,member_other)	
table(top_case,member_gwwc)

EAS2<- na.omit(subset(EAS, select = c(cause_import_animal_welfare_b, ea_engaged_scale)))
table(EAS2$ea_engaged_scale, EAS2$cause_import_animal_welfare_b)
table2 <- table(EAS2$ea_engaged_scale, EAS2$cause_import_animal_welfare_b)
prop.table(table2)

#? How to create bar for all the above?

#Descriptives: top cause (mean?): gender, gender gap (bar)
#EAS<- na.omit(subset(EAS2, select = c(gender_mf)))
EAS$gender_mf[EAS$gender_b== "Male"] <- "Male"
EAS$gender_mf[EAS$gender_b== "Female"] <- "Female"
EAS$gender_mf <-as.factor(EAS$gender_mf)
levels(EAS$gender_mf)
EAS$gender_mf = factor(EAS$gender_mf,levels(EAS$gender_mf)[c(2,1)])
table(top_case,gender_mf)
#Cause scale
EAS2<- na.omit(subset(EAS, select = c(gender_mf, cause_import_animal_welfare,	cause_import_cause_prioritization,	cause_import_biosecurity,	cause_import_climate_change,	cause_import_nuclear_security,	cause_import_ai,	cause_import_mental_health,	cause_import_poverty,	cause_import_rationality,	cause_import_meta,	cause_import_xrisk_other,	cause_import_other)))
EAS2 <- data.frame(lapply(EAS2, function(x) as.numeric(as.factor(x))))
meancause<-colMeans(EAS2[sapply(EAS2, is.numeric)])

##UNFINISHED
#Descriptives: top cause (mean?): diet proportion of supporters with diet (bar) proportion of diet supporting cause (bar)
#Logistic regression (top cause): link off to table (AMEs)
#Ordinal regression: link off to table, (ordinal regression graphs)
#MCA: MCA plots

#### Ribbon Plot ####
install.packages("alluvial")
library(alluvial)
rm(list=ls())

tit <- read.dta13("~/Downloads/EAS2019_sankey.dta")
head(tit)
tit$onecause<- as.factor(tit$onecause)
print(levels(tit$onecause))
tit$onecause = factor(tit$onecause,levels(tit$onecause)[c(2,4,1,5,3)])
print(levels(tit$onecause))

tit$toppriority<- as.factor(tit$toppriority)
print(levels(tit$toppriority))
tit$toppriority = factor(tit$toppriority,levels(tit$toppriority)[c(6,7,8,4,2,5,11,10,3,9,12,1)])
print(levels(tit$toppriority))

alluvial(tit[,1:2], freq=tit$realfreq,
         col = ifelse(tit$plural == 1, "orange", "grey"),
         border = ifelse(tit$plural == 1, "orange", "grey"),
         hide = tit$realfreq == 0,
         layer = tit$plural == 0,
         alpha = 0.7,
         cex = 0.7)
####

install.packages("alluvial")
library(alluvial)
rm(list=ls())

tit <- read.dta13("~/Downloads/EASchange.dta")
head(tit)
tit$onecause<- as.factor(tit$onecause)
print(levels(tit$onecause))
tit$onecause = factor(tit$onecause,levels(tit$onecause)[c(2,4,1,5,3)])
print(levels(tit$onecause))

tit$toppriority<- as.factor(tit$toppriority)
print(levels(tit$toppriority))
tit$toppriority = factor(tit$toppriority,levels(tit$toppriority)[c(6,7,8,4,2,5,11,10,3,9,12,1)])
print(levels(tit$toppriority))

tit$before<- as.factor(tit$before)
print(levels(tit$before))
tit$before = factor(tit$before,levels(tit$before)[c(5,3,2,4,1,7,6)])
print(levels(tit$before))
library(alluvial)
rm(list=ls())
tit <- read.dta13("~/Downloads/EASchange_mul.dta")
tit <- read.dta13("~/Downloads/EASchange.dta")

alluvial(tit[,1:2], freq=tit$realfreq,
         col = ifelse(tit$plural2 == 1, "orange", "grey"),
         border = ifelse(tit$plural2 == 1, "orange", "grey"),
         hide = tit$realfreq == 0,
         layer = tit$plural2 == 0,
         alpha = 0.7,
         cex = 0.7)

#### Geography: UNFINISHED####

#Country: frequencies (table) (bar chart) (map)
EAS$country1 <-as.factor(EAS$country)
attach(EAS)
table(country1)
barplot(table(country1), main="Geographic Distribution",
        xlab="Country",ylab = "Frequency")

EAS2<- na.omit(subset(EAS, select = c(age, country)))
EAS2 %>% comparison_table(EAS2$age, EAS2$country)


table2 <- table(geog)
barplot(prop.table(geog), main="Geographic Distribution",
        xlab="Country",ylab = "Proportion")
dev.off()
EAS2<- na.omit(subset(EAS, select = c(geog)))
ggplot(EAS2, aes(x = as.factor(geog), fill=geog)) +
  geom_bar(na.rm = TRUE,aes(y = (..count..)/sum(..count..))) +
  geom_text(aes(y = ((..count..)/sum(..count..)), label = scales::percent((..count..)/sum(..count..))), stat = "count", vjust = -0.25) +
  scale_y_continuous(labels = percent) + theme_classic() +
  labs(title = "Distribution of Education", y = "Percent", x = "Type of Education")+ theme(legend.position = "none")

#Country: Proportion/Density: (table) (bar chart) (map)

#City: frequencies: (bar chart) (map)
#City: Proportion/Density: (bar chart) (map)
#Close to major city analysis (possible)
#North America (map), Europe (map)

#Country: Growth over time: total (line), proportion (area), absolute growth per year (line), relative growth per year (line) 
#City growth/change: line, top changes (possible)

#Cause preference: country breakdown (100% bar)

EAS2$animal <-as.numeric(EAS2$cause_import_animal_welfare )
EAS2$causeprior <-as.numeric(EAS2$cause_import_cause_prioritizatio )
EAS2$climate <-as.numeric(EAS2$cause_import_climate_change )
EAS2$bio <-as.numeric(EAS2$cause_import_biosecurity )
EAS2$nuke <-as.numeric(EAS2$cause_import_nuclear_security )
EAS2$ai <-as.numeric(EAS2$cause_import_ai )
EAS2$mental <-as.numeric(EAS2$cause_import_mental_health )
EAS2$poverty <-as.numeric(EAS2$cause_import_poverty )
EAS2$decision <-as.numeric(EAS2$cause_import_rationality )
EAS2$meta <-as.numeric(EAS2$cause_import_meta )
EAS2$xrisk <-as.numeric(EAS2$cause_import_xrisk_other )
names(EAS2) = c(cause_import_animal_welfare = "Animal welfare",	
                cause_import_cause_prioritization= "Cause prioritization",	
                cause_import_biosecurity= "Biosecurity",	
                cause_import_climate_change= "Climate change",
                cause_import_nuclear_security ="Nuclear security",
                cause_import_ai ="AI risk",
                cause_import_mental_health ="Mental health",
                cause_import_poverty ="Global poverty",	
                cause_import_rationality ="Improving rationality",
                cause_import_meta ="Meta charities",	
                cause_import_xrisk_other ="Other x-risk"
attach(EAS)
aggregate(EAS$animal, list(nationality = EAS$geog1), mean)
iris %>% comparison_table(cause_import_ai, geog1)

EAS3<- na.omit(subset(EAS2, select = c(cause_import_animal_welfare,	cause_import_cause_prioritization,	cause_import_biosecurity,	cause_import_climate_change,	cause_import_nuclear_security,	cause_import_ai,	cause_import_mental_health,	cause_import_poverty,	cause_import_rationality,	cause_import_meta,	cause_import_xrisk_other,	cause_import_other)))

EAS3 <- data.frame(lapply(EAS3, function(x) as.numeric(as.factor(x))))
meancause<-colMeans(EAS3[sapply(EAS3, is.numeric)])
meancause

tabstat(EAS2, c(gender_mf, cause_import_animal_welfare,	cause_import_cause_prioritization,	cause_import_biosecurity,	cause_import_climate_change,	cause_import_nuclear_security,	cause_import_ai,	cause_import_mental_health,	cause_import_poverty,	cause_import_rationality,	cause_import_meta,	cause_import_xrisk_other,	cause_import_other)))

#Gender: country: proportion (bar)
#Diet: country: proportion (bar)

#Local EA group membership: country: proportion (bar) (map)
#Local EA group membership: city: proportions, top cities, (bar)

#GWWC membership: country: proportion: (bar) (map)
#GWWC membership: city: proportion: (bar) 

#Online group membership: country: proportion: (bar) (map)
#Online group membership: city: proportion: (bar)

#Career type: country: proportion: (bar) (map)
#Career type: city: proportion: (bar)





#### Careers Supplement ####

install.packages("VennDiagram")
library(VennDiagram)
dev.off()
source("http://www.bioconductor.org/biocLite.R")
class(biocLite)
biocLite("limma")
library(limma)
install.packages("eulerr")
library(eulerr)
source("https://bioconductor.org/biocLite.R"); biocLite(c("RBGL","graph"))
install.packages("devtools"); library(devtools);
install_github("js229/Vennerable"); library(Vennerable);
install.packages("Vennerable")
library(Vennerable)

EAS2<- (subset(EAS, select = c(activity_applied_ea_org_job, activity_employed_ea_org, ea_org_employed, ea_career_type_ea_org)))

EAS2$eajob<- FALSE
EAS2$eajob[EAS2$activity_employed_ea_org== FALSE] <- FALSE
EAS2$eajob[EAS2$ea_org_employed== FALSE] <- FALSE
EAS2$eajob[EAS2$activity_employed_ea_org== TRUE] <- TRUE
EAS2$eajob[EAS2$ea_org_employed== TRUE] <- TRUE
EAS2$eajob <-as.logical(EAS2$eajob)
str(EAS2$eajob)
attach(EAS2)
EAS3<- (subset(EAS2, select = c(activity_applied_ea_org_job,  ea_career_type_ea_org, eajob)))

str(EAS3)
plot(venn(EAS3),main="Working at an EA organization",labels=c("Applied for a job" ,"Expected career","Work(ed) at an EA org"))

###OR
library(eulerr)
fit <- euler(c(EAS3))
plot(fit)



#Logisitc regression of EA apply
dat <- read.dta13("~/Downloads/EAS_draft14.dta")

require(foreign)
require(nnet)
library(aod)
require(ggplot2)
require(reshape2)


ylogit <- glm(applied ~ female +
                age1 +
                white+
                educ +
                veg_c +
                stud +
                yearjoined +
                employed_full_time +
                employed_retired +
                canexp +
                activity_attended_eag +
                activity_ea_forum_posted +
                activity_organized_ea_event+
                activity_ea_local_leader +
                done_80k +
                income_lg +
                usa, data = dat, family = "binomial")
summary(ylogit)
z <- summary(ylogit)$coefficients/summary(ylogit)$standard.errors
print(z)
exp(coef(ylogit))
library("margins")
(m <- margins(ylogit))
summary(m)




