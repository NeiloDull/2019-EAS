# EA SURVEY 2019 ANALYSIS TEMPLATE
setwd("~/Downloads")
rm(list=ls())
#### PACKAGES & Load Data#######
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
install.packages("ggthemes") # Install 
install.packages("qwraps2")
install.packages("magrittr") # package installations are only needed the first time you use it
install.packages("dplyr")    # alternative installation of the %>%
install.packages("pastecs")
install.packages("gmodels")
install.packages("ggthemes") # Install 
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
library(ggthemes) # Load
library(gmodels)
library(pastecs)
library(magrittr) # needs to be run every time you start R and want to use %>%
library(dplyr)    # alternatively, this also loads %>%
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
library(ggthemes) # Load
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

#Read in github or CSv data
#EAS<-read.csv("https://raw.githubusercontent.com/peterhurford/ea-data/master/data/2018/2018-ea-survey-anon-currencied-processed.csv",  stringsAsFactors=FALSE)
EAS<-read.csv("~/Downloads/2019-ea-survey-anon-currencied-processed.csv")
##OR preprocessed data
#library(readstata13)
#EAS <- read.dta13("~/Downloads/EAsurvey2019_cleaned.dta")

attach(EAS)
summary(EAS)

##### Demographics and Community#####################

#Total sample size
##Age: distribution (histogram), median, mean

#continous age
#EAS$age <- as.numeric(EAS$age)
#gghistogram(EAS, x = "age", bins = 50, 
            #add = "mean",main = "Distribution of Age")
attach(EAS)

table(age)
table2 <- table(age)
prop.table(table2)
EAS$agenum <- as.numeric(EAS$age)
attach(EAS)
mean(agenum, na.rm= T)
median(agenum, na.rm= T)
##Gender: descriptives
table(gender_b)
table2 <- table(gender_b)
prop.table(table2)
EAS2<- na.omit(subset(EAS, select = c(gender_b)))
EAS2$gender_ordered = factor(EAS2$gender_b,levels(EAS2$gender_b)[c(2,1,3)])
ggplot(EAS2, aes(x = gender_ordered, fill=gender_ordered)) +
  geom_bar(na.rm = TRUE,aes(y = (..count..)/sum(..count..))) +
  geom_text(aes(y = ((..count..)/sum(..count..)), label = scales::percent((..count..)/sum(..count..))), stat = "count", vjust = -0.25) +
  scale_y_continuous(labels = percent) + theme_tufte() +
  labs(title = "Distribution of Gender", y = "Percent", x = "")+ theme(legend.position = "none")
#Drop "other"


#Gender: comparison to 2018
#2018-  Male (1,592, 69.82% ) Female (688, 30.18%)
##Education: level (bar)
table(education)
table2 <- table(education)
prop.table(table2)
counts <- table(education)
barplot(prop.table(table2), main="Education Distribution",
        xlab="Level of Education",ylab = "Proportion")
#proportions
dev.off()
EAS2<- na.omit(subset(EAS, select = c(education)))
print(levels(education))
EAS2$education_ordered = factor(EAS2$education,levels(EAS2$education)[c(8,4,7,1,2,6,5,3)])
ggplot(EAS2, aes(x = education_ordered, fill=education_ordered)) +
  geom_bar(na.rm = TRUE,aes(y = (..count..)/sum(..count..))) +
  geom_text(aes(y = ((..count..)/sum(..count..)), label = scales::percent((..count..)/sum(..count..))), stat = "count", vjust = -0.25) +
  scale_y_continuous(labels = percent) + theme_tufte() +
  labs(title = "Distribution of Education", y = "Percent", x = "Type of Education")+ theme(legend.position = "none")
##Group education levels

EAS2$educ <- EAS2$education
levels(EAS2$educ) <- list(No_Degree=c("Some high school","High school graduate","Some college, no degree"),
Bachelors= c("Bachelor's degree"),
Masters=c("Master's degree"),
PhD=c("Doctoral degree"),
Other_degree=c("Associate's degree","Professional degree"))
print(levels(EAS2$educ))
#get stats
table(EAS2$educ)
table2 <- table(EAS2$educ)
prop.table(table2)
counts <- table(EAS2$educ)
#plot
dev.off()
print(levels(EAS2$educ))
EAS3<- na.omit(subset(EAS2, select = c(educ)))
ggplot(EAS3, aes(x = educ, fill=educ)) +
  geom_bar(na.rm = TRUE,aes(y = (..count..)/sum(..count..))) +
  geom_text(aes(y = ((..count..)/sum(..count..)), label = scales::percent((..count..)/sum(..count..))), stat = "count", vjust = -0.25) +
  scale_y_continuous(labels = percent) + theme_tufte() +
  labs(title = "Distribution of Education", y = "Percent", x = "Type of Education")+ theme(legend.position = "none")
#Education: comparisons to 2018 42.6% BA, 30.4% MA, 14.4% PhD, 12% other college, 0.7% Non-College
#Education: disciplines (bar)
logical_vars <- lapply(EAS, class) == "logical"
EAS[, logical_vars] <- lapply(EAS[, logical_vars], as.factor)

table(EAS$studied_econ)
table2 <- table(EAS$studied_econ)
prop.table(table2)
counts <- table(EAS$studied_econ)

discipline <- table(EAS$studied_cs,EAS$studied_econ,
EAS$studied_engineering ,
EAS$studied_math ,
EAS$studied_medicine, 
EAS$studied_psych ,
EAS$studied_phil, 
EAS$studied_physics ,
EAS$studied_humanities ,
EAS$studied_social_science ,
EAS$studied_other_science ,
EAS$studied_vocational)
discipline
#create single discipline variable

print(levels(dat$welcome))
table(discipline)

barplot(table(discipline), main="Discipline Distribution",
        xlab="Discipline",ylab = "Frequency")
table2 <- table(discipline)
barplot(prop.table(discipline), main="College Distribution",
        xlab="Discipline",ylab = "Proportion")
#Education: comparisons to 2018
#Education: university of undergraduate, descriptives [if included]
table(university)
#Careers: employment status- descriptives (bar)
table(job)
barplot(table(job), main="Employment Status Distribution",
        xlab="Employment Status",ylab = "Frequency")
table2 <- table(job)
barplot(prop.table(job), main="Employment Status Distribution",
        xlab="Employment Status",ylab = "Proportion")
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

#Where first heard: descriptives: (bar chart)
#Where first heard: comparison to last year

#Where first heard: Other open comment breakdown
#Where first heard: Other open comment: (bar chart)

#Where first heard: year by year breakdown (Area Chart?)


EAS2<- na.omit(subset(EAS, select = c(eayear, firstheard)))
table(firstheard, eayear1)
heardyear <- table(firstheard, eayear1)
prop.table(heardyear,2) 

#Comparison of year by year (2019) to year by year (2018) 
#(Area chart), (line chart) etc (absolute and proportions)
#frequency
h<- barplot(table(eayear1), main="EAs first hearing of EA/ Total Eas",
            xlab="Year",ylab = "Frequnecy")

#% JOINED with % labels
EAS2<- na.omit(subset(EAS, select = c(eayear1)))
ggplot(EAS2, aes(x = as.factor(eayear1),)) +
  geom_bar(na.rm = TRUE,aes(y = (..count..)/sum(..count..))) +
  geom_text(aes(y = ((..count..)/sum(..count..)), label = scales::percent((..count..)/sum(..count..))), stat = "count", vjust = -0.25) +
  scale_y_continuous(labels = percent) + theme_tufte() +
  labs(title = "Distribution of Gender", y = "Percent", x = "")+ theme(legend.position = "none")

#cumulative (denisty)
counts <- table(eayear1)
plot(ecdf(eayear1))
#Cumulative Freq
ec<-ggplot(data = EAS2 %>% group_by(eayear1) %>% summarise(n = n()), 
           aes(x = eayear1, y = n)) + 
  ylab("Total EAs") +
  xlab("year Joined") +
  geom_line(aes(y = cumsum(n)))

#Overlap cumulative (density) plor and year-by-year histogram
EAS2<- na.omit(subset(EAS, select = c(eayear1)))
attach(EAS2)
par(mar = c(5,5,2,5))
h <- hist(
  eayear1,xlim = c(2009,2019))

par(new = T)

ec <- ecdf(eayear1)
plot(x = h$mids, y=ec(h$mids)*max(h$counts), col = rgb(0,0,0,alpha=0), axes=F, xlab=NA, ylab=NA)
lines(x = h$mids, y=ec(h$mids)*max(h$counts), col ='red')
axis(4, at=seq(from = 0, to = max(h$counts), length.out = 11), labels=seq(0, 1, 0.1), col = 'red', col.axis = 'red')
mtext(side = 4, line = 3, 'Cumulative Density', col = 'red')

##CUMULATIVE FREQ
##### Make some sample data
x <- EAS2$eayear1

## Calculate and plot the two histograms
hcum <- h <- hist(x, plot=FALSE)

hcum$counts <- cumsum(hcum$counts)
plot(hcum, main="EAs first hearing of EA/Total EAs", xlab="Year First heard of EA",plot=FALSE)
plot(h, add=T, col="blue")

## Plot the density and cumulative density
d <- density(x)
lines(x = d$x, y = d$y * length(x) * diff(h$breaks)[1], lwd = 2)
lines(x = d$x, y = cumsum(d$y)/max(cumsum(d$y)) * length(x), lwd = 2)


#Getting involved: descriptives: (bar chart)
#Getting involved: comparison to last year
#Getting involved:  year by year breakdown
#Comparison of 2019’s 2018 yby breakdown to 2018



#### Donations ####
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
sp + theme_tufte()
sp + theme_tufte() + theme( legend.position=c(0.2, 0.9)) 

#log histogram
p <- ggplot(EAS, aes(x=donate_2017_c_n)) +
  geom_histogram(fill="white", color="black")+
  geom_vline(aes(xintercept=mean(donate_2017_c_n)), color="blue",
             linetype="dashed")+
  labs(title="Histogram of 2018 Donations",x="2018 Donations", y = "Count")+
  theme_tufte()
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

#Top cause: totals (bar)
counts <- table(topcause)
barplot(counts, main="Top Cause Area",
        xlab="Cause Area",ylab = "Frequency")

table2 <- table(topcause)
prop.table(table2)
barplot(prop.table(table2), main="Top Cause Area",
        xlab="Cause Area",ylab = "Proportion")

#Top cause: totals (comparison to 2018: bar) 
#Top cause: totals (broader longditudinal optional)

#Cause selection: full scale: (likert graph) (table) (“near top” table)
library(likert)
likert(dat)
summary(dat)
Result = likert(dat)
title <- "Cause Selections"
plot(Result,
     type="bar") +ggtitle(title)

#Mean score: table, bar?
#Recode variable to numeric
EAS$povnum <- as.numeric(povscale)
EAS$ainum <- as.numeric(aiscale)
attach(EAS)
mean(EAS$povnum, na.rm=T) 

library(magrittr)
library(qwraps2)
EAS2<- na.omit(subset(EAS, select = c(povnum, ainum))
               our_summary1 <-
                 list("Global Poverty" =
                        list(
                          "mean (sd)" = ~ qwraps2::mean(EAS2$povnum)),
                      "AI Risk" =
                        list(
                          "mean (sd)" = ~ qwraps2::mean(EAS2$ainum))))
### Overall
whole <- summary_table(EAS2, our_summary1)
whole



table(mean)
Mean score: longditudinal (line)

Descriptives: top cause (mean?): Forum, LW, other membership groups? (bar)
Descriptives: top cause (mean?): gender, gender gap (bar)
Descriptives: top cause (mean?): diet proportion of supporters with diet (bar) proportion of diet supporting cause (bar)

Logistic regression (top cause): link off to table (AMEs)
Ordinal regression: link off to table, (ordinal regression graphs)
MCA: MCA plots

#### Geography ####

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
  scale_y_continuous(labels = percent) + theme_tufte() +
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

             
              
               
