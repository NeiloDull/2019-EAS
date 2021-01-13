clear
set more off
use  "/Users/Neil/Downloads/FinalSurvey1.dta"

set more off

**DROP MISSING VALUES
drop if donate_2017_c_n==.
drop if income_2017_individual_n==.
drop if income_2017_household_n==.
drop income
gen income=(income_2017_individual_n+income_2017_household_n)/2

gen percent= (donate_2017_c_n/income)*100
drop if percent==.
drop if percent==0

gen percent1= (donate_2017_c_n/income_2017_individual_n)*100
drop if percent1==.
drop if percent1==0

*********DONATION PDATE 2:**
clear
set more off
use  "/Users/Neil/Downloads/FinalSurvey1.dta"

drop if donate_2017_c_n==.
drop if income_2017_individual_n==.
drop if income_2017_household_n==.
gen percent= (donate_2017_c_n/income)*100
drop if percent==.
save "/Users/Neil/Downloads/donateupdate.dta", replace

****
clear
set more off
use  "/Users/Neil/Downloads/donateupdate.dta"




**
drop x
gen x=.
replace x=1 if employed_retired ==7
replace x=2 if employed_homemaker ==7
replace x=3 if employed_self ==7
replace x= if employed_ ==
replace x= if employed_ ==
replace x= if employed_ ==
replace x= if employed_ ==
replace x= if employed_ ==
replace x= if employed_ ==
replace x= if employed_ ==
replace x= if employed_ ==

recode x (1=1 "Retired") (2=2 "Homemaker") (3=3 "Self-Employed") ,gen(job)


For-Profit
Non-profit
Academics
Self-Employed
Unemployed
Government
Retired
*Homemaker
tabstat percent
drop if student==1
drop if eayear ==10
drop if eayear ==9
drop if eayear ==8
drop if eayear ==7
keep if gwwc==1
keep if percent >=10
*Excludes Students. Excludes 2015+ ea year, includes GWWC members only. Includes >= 10%
 tabstat  percent,by(employed_homemaker) stat(n p50)


*Total Respondents
*Total GWWC Members
*% Members Donating >= 10% in 2016
*% Members Donating >= 10% in 2017

*% Members Donating >= 10%, averaged over 2016 and 2017

**Excludes people who were students at the time of taking the EA Survey and people who hadn’t heard of EA by 2015.
clear
set more off
use  "/Users/Neil/Downloads/donateupdate.dta"

 tabstat  donate_2017_c_n,by(gwwc) stat(n mean p50)
 drop if gwwc==.
 
 gen dona_lg=log(donate_2017_c_n)
 save "/Users/Neil/Downloads/gwwc_new.dta", replace

use "/Users/Neil/Downloads/gwwc_new.dta", clear
drop if student==1

recode gwwc (0=1 "Non-Member") (1=0 "GWWC member"), gen(gwwc1)
 tabstat percent,by(gwwc) stat(n p50)
 gen dona_lg=log(donate_2017_c_n)
 drop if gwwc==.
 save "/Users/Neil/Downloads/gwwc_new2.dta", replace

 
use "/Users/Neil/Downloads/gwwc_new2.dta", clear 
drop p_2 p_g
gen p_2=percent1
replace p_2=15 if percent1 >=15
hist p_2 if gwwc==1
gen p_g=.
replace p_g=p_2 if gwwc==1

centile ( percent1), centile (10 20 30 40 50 60 70 80 90 91 92 93 94 95 96 97 98 99)

 centile ( percent), centile (10 20 30 40 50 60 70 80 90 91 92 93 94 95 96 97 98 99)
tabstat percent, by(fullstud)
 
replace percent=101 if percent>=101
histogram percent, percent xaxis(1 2) xlabel( 2.86 "Median", axis(2) grid gmax) xtitle("", axis(2)) subtitle("EAs donating certain %s of income") scheme(s1mono)(bin=101) 
histogram percent, bin(101) percent xaxis(1 2) xlabel( 2.86 "Median", axis(2) grid gmax) xtitle("", axis(2)) subtitle("EAs donating certain %s of income") scheme(s1mono)
tabstat percent, stat(n p10 p20 p30 p40 p50 p60 p70 p80 p90)

###median  donated
tabstat donate_2017_c_n, stat(n  p50)
tabstat percent, stat(n  p50)

##median Student
tabstat donate_2017_c_n, by(student) stat(n sum mean p50)
tabstat percent1, by(student) stat(n sum mean p50)

##median Fulltime-Non student
gen fullstud=.
replace fullstud=1 if fulltime1==1 & student==0
keep if fullstud==1
replace fullstud=0 if fulltime1==1 & student==1
replace fullstud=0 if fulltime1==0 & student==0
replace fullstud=0 if fulltime1==0 & student==1

tabstat donate_2017_c_n, by(fullstud) stat(n  p50)
tabstat percent1, by(fullstud) stat(n  p50)

##Median fulltim-non student >20k

gen fullstud1=.
replace fullstud1=1 if fulltime1==1 & student==0 & income>20000
replace fullstud1=0 if fulltime1==1 & student==1
replace fullstud1=0 if fulltime1==0 & student==0
replace fullstud1=0 if fulltime1==0 & student==1


tabstat donate_2017_c_n, by(fullstud1) stat(n sum mean p50)
tabstat percent1, by(fullstud1) stat(n p50)
