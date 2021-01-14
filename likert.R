install.packages("readstata13")
rm(list=ls())

library(readstata13)
dat <- read.dta13("~/Downloads/rEA1.dta")
###2018 Welcoming analysis
dat$wel = factor(dat$welcome,
                 levels = c("Very unwelcoming", "Unwelcoming", "Neither", "Welcoming", "Very welcoming"),
                 ordered = TRUE)

dat <- read.dta13("~/Downloads/birth1.dta")

dat$topp[dat$topp==1] <- "Animal welfare"
dat$topp[dat$topp==2] <- "Cause prioritisation"
dat$topp[dat$topp==3] <- "Biosecurity"
dat$topp[dat$topp==4] <- "Climate change"
dat$topp[dat$topp==5] <- "Nuclear security"
dat$topp[dat$topp==6] <- "AI Risk"
dat$topp[dat$topp==7] <- "Mental health"
dat$topp[dat$topp==8] <- "Global poverty"
dat$topp[dat$topp==9] <- "Improving rationality"
dat$topp[dat$topp==10] <- "Meta charities"
dat$topp[dat$topp==11] <- "Other X-Risk"
dat$topp<-as.factor(dat$topp)
dat <- read.dta13("~/Downloads/rEA4.dta")
dat <- read.dta13("~/Downloads/rEA5.dta")

dat$agegroup1[dat$agegroup1==0] <- "18-22"
dat$agegroup1[dat$agegroup1==1] <- "23-25"
dat$agegroup1[dat$agegroup1==2] <- "26-29"
dat$agegroup1[dat$agegroup1==3] <- "30-34"
dat$agegroup1[dat$agegroup1==4] <- "35+"
dat$agegroup1<-as.factor(dat$agegroup1)

dat <- read.dta13("~/Downloads/rEA6.dta")
dat$first_heard_ea<- as.factor(dat$first_heard_ea)
dat <- read.dta13("~/Downloads/rEA7.dta")

dat$wel = factor(dat$welcome,
                 levels = c("Very unwelcoming", "Unwelcoming", "Neither", "Welcoming", "Very welcoming"),
                 ordered = TRUE)
dat$first_heard_ea <-as.factor(dat$first_heard_ea)
require(likert)
attach(dat)

mylevels <- dat$wel

# Create a dummy data frame. Note that "Item 1" has only four levels
items <- data.frame(dat$wel)
str(items)
groups <- dat$first_heard_ea

sapply(items, class) #Verify that all the columns are indeed factors
sapply(items, function(x) { length(levels(x)) } ) # The number of levels in each factor
for(i in seq_along(items)) {
  items[,i] <- factor(items[,i], levels=mylevels)
}

rm(list=ls())
library(readstata13)
dat <- read.dta13("~/Downloads/rEA1.dta")
dat$wel = factor(dat$welcome,
                 levels = c("Very unwelcoming", "Unwelcoming", "Neither", "Welcoming", "Very welcoming"),
                 ordered = TRUE)
dat$wel = factor(dat$welcome,
                 levels = c("Very unwelcoming", "Unwelcoming", "Neither", "Welcoming", "Very welcoming"),
                 ordered = TRUE)
dat$first_heard_ea <-as.factor(dat$first_heard_ea)
require(likert)
attach(dat)
mylevels <- dat$wel
# Create a dummy data frame. Note that "Item 1" has only four levels
items <- data.frame(dat$wel)
str(items)
lgood <- likert(items)
lgood
summary(lgood)
title <- "EA Welcomeness"
plot(lgood, ylab="")+ ggtitle(title)


dat$topprioritycause<-as.factor(dat$topprioritycause)
dat$topprioritycause = factor(dat$topprioritycause,
                  levels = c("Other","Unemployed","Direct Charity/Non-profit Work","Self-Employed", "Retired", "Research", "Earning to Give", "Homemaker"),
                  ordered = TRUE)
# Plot the bar chart 
title <- "How Welcoming is EA, by Top Priority Cause"
ggplot(data=dat, aes(x=topprioritycause, y=meanwelcoming, fill=topprioritycause)) +
  geom_bar(colour="black", stat="identity") + xlab("Top Priority Cause") + ylab("Mean Welcomeness")+ ggtitle(title)+
  guides(fill=FALSE) + theme_tufte()+ylim(3, 4.5)



###
install.packages("ggthemes") # Install 
library(ggthemes) # Load
require(likert)
lgr <- likert(items)
summary(lgr)

tp=as.data.frame(lgr$results)
tp=tp[,-2]
names(tp)[1]="Item"
lgr2=(likert(summary=tp))
title <- "EA Welcomingness by Top Priority Cause"
plot(lgr2) + ggtitle(title)
##

plot(lgood) +ggtitle(title)
lgr <- likert(items, grouping=groups)
summary(lgr)
scale_height = knitr::opts_chunk$get('fig.height')*0.5
scale_width = knitr::opts_chunk$get('fig.width')*1.25
knitr::opts_chunk$set(fig.height = scale_height, fig.width = scale_width)

theme_update(legend.text = element_text(size = rel(0.7)))
title <- "EA Welcomingness by Country"
plot(lgr,  ordered=TRUE) + ggtitle(title)
plot(lgr, ordered=FALSE, group.order=names(first_heard_ea))
plot(lgr, ordered = TRUE) 

desired.order <- c("Very unwelcoming", "Unwelcoming", "Neither", "Welcoming", "Very welcoming")
install.packages("Epi")
require(Epi)
require(likert)
for (i in seq_along(dat)) {
  dat[,i] = Relevel(dat[,i],mylevels)   # desired.order must be specified beforehand
}

# Now it plots. 
lgr <- likert(items, grouping=groups)
plot(lgr)
