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
library(reshape2)
library(plyr)
library(RColorBrewer)
library("PerformanceAnalytics")
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
library("Hmisc")
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
library("nlme")
require("margins")
library("margins")
require('datasets')
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
if (!require("devtools")) install.packages("devtools")
devtools::install_github("peterhurford/surveytools2")
library(surveytools2)
options("RStata.StataPath")
options("RStata.StataVersion")
devtools:::install_github("ngreifer/cobalt")
install.packages("readstata13")
library(readstata13)

#### LOAD DATA ####

#Load public data
#Read in github or CSv data
#EAS<-read.csv("https://raw.githubusercontent.com/peterhurford/ea-data/master/data/2018/2018-ea-survey-anon-currencied-processed.csv",  stringsAsFactors=FALSE)
EAS<-read.csv("~/Downloads/2019-ea-survey-PUBLIC-draft7.csv")
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
  labs(title = "Distribution of Age", y = "Percent", x = "")+ theme(legend.position = "none")



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
  scale_y_continuous(labels = percent) + theme_classic() +
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
  scale_y_continuous(labels = percent) + theme_classic() +
  labs(title = "Distribution of Education", y = "Percent", x = "Type of Education")+ theme(legend.position = "none")
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
#? how to plot the "TRUE' of each altogether?

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
#employed_full_time employed_part_time employed_self employed_looking employed_not_looking employed_homemaker employed_retired employed_student_part employed_student_full

table(job)
barplot(table(job), main="Employment Status Distribution",
        xlab="Employment Status",ylab = "Frequency")
table2 <- table(job)
barplot(prop.table(job), main="Employment Status Distribution",
        xlab="Employment Status",ylab = "Proportion")

##UNFINISHED Graphics: Have added descriptives to shared G-Sheet

#Careers: field of employment- descriptives (bar)

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
#Religion: descriptives
table(religion)
#Religion: comparison to 2018
#Diet: descriptives
table(diet)
#Diet: comparison to 2018
#Relationship: descriptives
#Relationship: descriptives
#Relationship: possible age/country crosstab + proportion test
#Politics: descriptives
table(politics)
#Politics: comparison to 2018
#Morality: normative ethics: descriptives
table(normative)
#Morality: metaethics: descriptives
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
dat <- read.dta13("~/Downloads/EAS2019_firstheard.dta")
dat$firstheardofeafrom <- as.factor(dat$firstheardofeafrom)
p=ggplot(data=dat)  
p+geom_bar(stat="identity")+  #
  aes(x=reorder(dat$firstheardofeafrom,percent,sum),y=percent,label=percent,fill=dat$firstheardofeafrom)+geom_text(aes(label=scales::percent(percent), vjust=5))+scale_y_continuous(labels = percent) + theme_classic() +
  labs(title = "Where first heard of EA", y = "Percent", x = "")+ theme(legend.position = "none")+ coord_flip()


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
dat <- read.dta13("~/Downloads/EAS2019_involved.dta")
dat$involved <- as.factor(dat$involved)
p=ggplot(data=dat)  
p+geom_bar(stat="identity")+  #
  aes(x=reorder(dat$involved,percent,sum),y=percent,label=percent,fill=dat$involved)+geom_text(aes(label=scales::percent(percent), vjust=5))+scale_y_continuous(labels = percent) + theme_classic() +
  labs(title = "Which factors were important in 'getting you into' effective altruism? ", y = "Percent", x = "")+ theme(legend.position = "none")+ coord_flip()

#Getting involved: comparison to last year
https://forum.effectivealtruism.org/posts/uPFx462NAamBo5Eqq/ea-survey-series-2018-how-do-people-get-involved-in-ea
#? Getting involved:  year by year breakdown
#? Comparison of 2019’s 2018 yby breakdown to 2018



#### Donations: Use Kim's Script! The script below needs updating ####
EAS2<- na.omit(subset(EAS, select = c(donate_2017_c_n, eayear)))
#look for outliers
outinc=max(EAnew$income_2018_individual_c,na.rm=TRUE)
outinc
#remove the 90M(?) point
EAS=EAnew[(EAnew$income_2018_individual_c<5000000),]
summary(EAS)

#Total respondents who gave donation data, proportion of total respondents
sum(is.na(EAS$donate_2017_c_n))
stat.desc(EAS$donate_2017_c_n)
stat.desc(EAS[,c("donate_2017_c_n","income_2017_household_n","income_2017_individual_n")],
          basic=TRUE, desc=TRUE, norm=TRUE, p=0.95)

#Totals donated: descriptives, year by year comparison(table)
tapply(EAS2$donate_2017_c_n, EAS2$eayear, FUN=sum)
barplot(tapply(EAS2$donate_2017_c_n, format(EAS2$eayear), FUN=sum))
#Individual donation size: distribution chart, 
title <- "2018 Individual donation size: distribution chart"
sp<-ggplot(EAS, aes(donate_2017_log)) + geom_density(alpha = 0.2)+ xlab("2018 Donations (log) ") +labs(fill="") + ggtitle(title)
sp + theme_classic()
sp + theme_classic() + theme( legend.position=c(0.2, 0.9)) 

#log histogram
p <- ggplot(EAS, aes(x=donate_2017_c_n)) +
  geom_histogram(fill="white", color="black")+
  geom_vline(aes(xintercept=mean(donate_2017_c_n)), color="blue",
             linetype="dashed")+
  labs(title="Histogram of 2018 Donations",x="2018 Donations", y = "Count")+
  theme_classic()
require(scales)
p + scale_x_continuous( trans = log10_trans(),
                        breaks = trans_breaks("log10", function(x) 10^x),
                        label = comma)
#Cumulative frequency chart (breakdown proportions of donations from different percentages of total donors)
#cumulative (denisty)

plot(ecdf(donate_2017_c_n))
#Cumulative Freq
ec<-ggplot(data = EAS2 %>% group_by(donate_2017_c_n) %>% summarise(n = n()), 
           aes(x = donate_2017_c_n, y = n)) + 
  ylab("Donors") +
  xlab("Donations") +
  geom_line(aes(y = cumsum(n)))
ec

#Totals individual donation percentiles (table)
quantile(EAS2$donate_2017_c_n, c(.1,.2,.30,.4, .5, .6, .7, .8, .9,.95,.98, .99)) 

#Percentages of income: (histogram)
EAS$percent1 <- as.numeric(EAS$percent1)
attach(EAS)
x<-gghistogram(EAS, x = "percent1", bins = 50,fill = "lightgray", 
               add = "median",main = "Distribution of % of Income donated", xlab= "Percent") + (breaks=seq(0, 100, by = 20))

barfill <- "#4271AE"
barlines <- "#1F3552"
p7 <- ggplot(EAS, aes(x = percent1)) +
  geom_histogram(aes(y = ..count..), binwidth = 2,colour = barlines, fill = barfill) +
  scale_x_continuous(name = "Percent",
                     breaks = seq(0, 100, 10),
                     limits=c(0, 100)) +
  scale_y_continuous(name = "Count")+
  ggtitle("Percentages of income donated") +
  geom_vline(xintercept = median(percent1), size = 1, colour = "#FF3721",
             linetype = "dashed")
p7 + theme_bw()
#Percentages of income: percentiles (table)
quantile(EAS$percent1, c(.1,.2,.30,.4, .5, .6, .7, .8, .9,.95,.98, .99)) 

#Percentages of income: non-students, employed non-students, not low income employed non-students (chart for each: respondents, median and mean)

#Income and donations correlation: scatterplot 
my_data <- EAS[, c( "income_2017_individual_n","donate_2017_c_n")]
chart.Correlation(my_data, histogram=TRUE, pch=19, Title="Correlation Matrix")

my_data <- EAS[, c( "income_2017_log", "don_lg")]
chart.Correlation(my_data, histogram=TRUE, pch=19, Title="Correlation Matrix")

#Self-reported reasons for donating less [possibly dropped]: )bar chart) 
#Self-reported reasons for donating less: categorisation of qualitative data (table, bar chart)

Other influences on giving: career path descriptives (table) 
Other influences on giving: descriptives Pledge (table)
Other influences on giving: year first heard EA descriptives (table) (line chart?)

#Regression: see 2018 predictors (link off to table; include graph split by types; consider non-linear relationship)

#Which charities donated to: #donors, total donated, mean donation size (table)
#Causes donated to: #donors, total donated, mean donation size (table)

#### Cause Selection ####

#Top cause: totals (bar): ??FIX LABELS??

#Rename LTF for better visualization
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
EAS2$top_case = factor(EAS2$top_case,levels(EAS2$top_case)[c(3,2,4,1,5)])
ggplot(EAS2, aes(x = top_case, fill=top_case)) +
  geom_bar(na.rm = TRUE,aes(y = (..count..)/sum(..count..))) +
  geom_text(aes(y = ((..count..)/sum(..count..)), label = scales::percent((..count..)/sum(..count..))), stat = "count", vjust = -0.25) +
  scale_y_continuous(labels = percent) + theme_classic() +
  labs(title = "Top Cause if forced to choose only one", y = "Percent", x = "")+ theme(legend.position = "none")

#Top cause: totals (comparison to 2018: bar)
#NEED 2018 DATA
#Top cause: totals (broader longditudinal optional)
#NEED 2018 DATA
#Cause selection: full scale: (likert graph) (table) (“near top” table): : ??FIX LABELS??
EAS2<- na.omit(subset(EAS, select = c(cause_import_animal_welfare,	cause_import_cause_prioritization,	cause_import_biosecurity,	cause_import_climate_change,	cause_import_nuclear_security,	cause_import_ai,	cause_import_mental_health,	cause_import_poverty,	cause_import_rationality,	cause_import_meta,	cause_import_xrisk_other,	cause_import_other)))
##Fix labels
EAS2[] <- lapply(EAS2, factor, 
               levels=c("I do not think any resources should be devoted to this cause",
                        "I do not think this is a priority, but should receive some resources",
                        "Not considered / Not sure",
                        "This cause deserves significant resources, but less than the top priorities",
                        "This cause should be a near-top priority",
                        "This cause should be the top priority (Please choose one)"), 
               labels = c("No Resources", "Some Resources","Not Sure",  "Significant Resources", "Near-Top Priority", "Top Priority"))
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
                cause_import_xrisk_other ="Other x-risk",
                cause_import_other ="Other")
#Plot Likert
library(likert)
likert(EAS2)
summary(EAS2)
Result = likert(EAS2)
title <- "Cause Selections"
plot(Result,
     type="bar") +ggtitle(title)

#Mean score: table, bar?
#NEED TO CREATE NUMERIC e.g. povnum<-as.numer
#Recode variable to numeric
EAS2<- na.omit(subset(EAS, select = c(cause_import_animal_welfare,	cause_import_cause_prioritization,	cause_import_biosecurity,	cause_import_climate_change,	cause_import_nuclear_security,	cause_import_ai,	cause_import_mental_health,	cause_import_poverty,	cause_import_rationality,	cause_import_meta,	cause_import_xrisk_other,	cause_import_other)))
EAS2 <- data.frame(lapply(EAS2, function(x) as.numeric(as.factor(x))))
meancause<-colMeans(EAS2[sapply(EAS2, is.numeric)])
meancause
#Mean score: longditudinal (line)


#Descriptives: top cause (mean?): Forum, LW, other membership groups? (bar)
table(top_case,member_ea_fb)
table(top_case,member_ea_forum)	
table(top_case,member_lw	)
table(top_case,member_local_group)	
table(top_case,member_none_of_the_above)	
table(top_case,member_other)	
table(top_case,member_gwwc)
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
EAS$animal <-as.numeric(EAS$cause_import_animal_welfare )
EAS$causeprior <-as.numeric(EAS$cause_import_cause_prioritizatio )
EAS$climate <-as.numeric(EAS$cause_import_climate_change )
EAS$bio <-as.numeric(EAS$cause_import_biosecurity )
EAS$nuke <-as.numeric(EAS$cause_import_nuclear_security )
EAS$ai <-as.numeric(EAS$cause_import_ai )
EAS$mental <-as.numeric(EAS$cause_import_mental_health )
EAS$poverty <-as.numeric(EAS$cause_import_poverty )
EAS$decision <-as.numeric(EAS$cause_import_rationality )
EAS$meta <-as.numeric(EAS$cause_import_meta )
EAS$xrisk <-as.numeric(EAS$cause_import_xrisk_other )
attach(EAS)
aggregate(EAS$animal, list(nationality = EAS$geog1), mean)
iris %>% comparison_table(cause_import_ai, geog1)

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

             
              
               
