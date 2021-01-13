clear
set more off
use  "/Users/Neil/Downloads/FinalSurvey1.dta"

drop if donate_2017_c_n==.
drop if income_2017_individual_n==.

gen percent1= (donate_2017_c_n/income_2017_individual_n)*100
drop if percent1==.
replace percent1=100 if percent1>=100

*****
save "/Users/Neil/Downloads/GWWC2019.dta", replace
*****
use "/Users/Neil/Downloads/GWWC2019.dta", clear
  gen newbin=.
 replace newbin =1 if percent1>=10
 replace newbin=0 if percent1 <10
drop if student==1
pwcorr newbin income_2017_individual_n, print(0.05) star(0.01)

*Mean & Median Donations
tabstat donate_2017_c_n, by(gwwc) stat(n mean p50)
*non-students
drop if student==1
tabstat donate_2017_c_n, by(gwwc) stat(n mean p50)

tabstat donate_2017_c_n, by(gwwc) stat(mean p50 sd v)
swilk donate_2017_c_n
ttest donate_2017_c_n, by(gwwc) welch
ttest donate_2017_c_n, by(gwwc) unequal
gen dl=log(donate_2017_c_n)

ttest dl, by(gwwc) welch
drop if newbin==1
ttest dl, by(gwwc) welch
ttest percent1,by(gwwc) welch

*Mean & median %
 tabstat percent1, by(gwwc) stat(mean p50 v sd)
  ttest percent1, by(gwwc) welch
 ttest percent1, by(gwwc) unequal
   median percent1, by(gwwc) exact
   
   *exclude students and people earning $10K or under, no 2018 GWWC/EA
   *****
use "/Users/Neil/Downloads/GWWC2019.dta", clear
 gen new=.
replace new=1 if   gwwc_year_n==2018
drop if new==1
drop if student==1
drop new
 gen new=.
replace new=1 if  eayear==10
drop if new==1
 drop if income_2017_individual_n <10000
  gen newbin=.
 replace newbin =1 if percent1>=10
 replace newbin=0 if percent1 <10
 
  tab newbin gwwc, col
  
  ***Table 7: Pledge Adherence by Year Joined EA
  use "/Users/Neil/Downloads/GWWC2019.dta", clear
  drop if student==1
 gen newbin=.
 replace newbin =1 if percent1>=10
 replace newbin=0 if percent1 <10
 
keep if gwwc==1

 
. tab eayear newbin
, row
 tab eayear newbin, row chi2

 **Pledge Adherence by Year Joined GWWC
   use "/Users/Neil/Downloads/GWWC2019.dta", clear
 drop if student==1

 gen newbin=.
 replace newbin =1 if percent1>=10
 replace newbin=0 if percent1 <10

 keep if gwwc==1
tab gwwc_year newbin
, row chi2 noperc

*Table 9: Pledge Adherence by Income Bracket
   use "/Users/Neil/Downloads/GWWC2019.dta", clear
drop if student==1

 gen new=.
replace new=1 if   gwwc_year_n==2018
drop if new==1
keep if gwwc==1

egen incomebracket = cut(income_2017_individual_n), group(4) label
tab incomebracket 
 gen newbin=.
 replace newbin =1 if percent1>=10
 replace newbin=0 if percent1 <10

tab incomebracket newbin, row
tab incomebracket newbin, col chi2

gen p_l=log(percent1)
gen i_l=log(income_2017_individual_n)

   use "/Users/Neil/Downloads/GWWC2019.dta", clear
drop if student==1

 gen new=.
replace new=1 if   gwwc_year_n==2018
drop if new==1
   
 
gen bracket=.
*93 over
replace bracket=4 if income_2017_individual_n >93642.00
*Under 93
replace bracket=3 if income_2017_individual_n <=93642.00
*under 53
replace bracket=2 if income_2017_individual_n <=52012.24
*under 27
replace bracket=1 if income_2017_individual_n <=28539
recode bracket (1=1 "$0 to $28K") (2=2 "$28K to $52K") (3=3 "$52K to $93K") (4=4 "Over $93K") (else=.), gen(money)
tab money bracket
tab bracket

*Table 10: Pledge Adherence by Employment Status
   use "/Users/Neil/Downloads/GWWC2019.dta", clear
drop if student==1
 gen new=.
replace new=1 if   gwwc_year_n==2018
drop if new==1
 
  gen newbin=.
 replace newbin =1 if percent1>=10
 replace newbin=0 if percent1 <10

 **
 keep if gwwc==1
 tab eacareer newbin, row

 
 *Self-Employed 
     use "/Users/Neil/Downloads/GWWC2019.dta", clear
drop if student==1
 gen new=.
replace new=1 if   gwwc_year_n==2018
drop if new==1

tab employed_self
tab employed_self gwwc
keep if gwwc==1
keep if employed_self==7
  gen newbin=.
 replace newbin =1 if percent1>=10
 replace newbin=0 if percent1 <10
tab newbin

*Retired
     use "/Users/Neil/Downloads/GWWC2019.dta", clear
drop if student==1
 gen new=.
replace new=1 if   gwwc_year_n==2018
drop if new==1
tab employed_retired
tab employed_retired gwwc
keep if gwwc==1
keep if employed_retired==7
  gen newbin=.
 replace newbin =1 if percent1>=10
 replace newbin=0 if percent1 <10
tab newbin

*Homemakeremployed_homemaker

     use "/Users/Neil/Downloads/GWWC2019.dta", clear
drop if student==1
 gen new=.
replace new=1 if   gwwc_year_n==2018
drop if new==1
tab employed_homemaker
tab employed_homemaker gwwc
keep if gwwc==1
keep if employed_homemaker==7
  gen newbin=.
 replace newbin =1 if percent1>=10
 replace newbin=0 if percent1 <10
tab newbin
 
  *unemployed
     use "/Users/Neil/Downloads/GWWC2019.dta", clear
drop if student==1
 gen new=.
replace new=1 if   gwwc_year_n==2018
drop if new==1
 gen unemployed=.
 replace unemployed=1 if employed_full_time==6
  replace unemployed=1 if employed_part_time==6
    replace unemployed=0 if employed_part_time==7
	 replace unemployed=0 if employed_full_time==7
 
 tab unemployed
tab unemployed gwwc
keep if gwwc==1
keep if unemployed==1
  gen newbin=.
 replace newbin =1 if percent1>=10
 replace newbin=0 if percent1 <10

tab newbin


***AGE

 clear
 import delimited "~/2018-ea-survey-edited-currencied.csv", encoding(ISO-8859-1)

gen donate_lifetime_n = real(donate_lifetime_c) 

gen donate_2017_c_n = real(donate_2017_c) 
gen year=real(birth_year)
gen gwwc_year_n=real(gwwc_year)
gen income_2017_household_n= real(income_2017_household_c)
gen income_2017_individual_n= real(income_2017_individual_c)

gen age=2018-year

foreach V of varlist first_heard_ea-income_2017_individual_c {
   encode `V', generate(aaa)         // provided variable aaa is not part of the dataset
   drop `V'
   rename aaa `V'
}
recode member_gwwc (858 =1 "GWWC member") (857=0 "Not GWWC") (else=.), gen(gwwc)

gen student=0
replace student=1 if employed_student_full== 6049
replace student=1 if employed_student_part==6048


replace gwwc_year_n=. if gwwc_year_n==17|gwwc_year_n==206
replace age=. if age==0

drop if donate_2017_c_n==.
drop if income_2017_individual_n==.

gen percent1= (donate_2017_c_n/income_2017_individual_n)*100
drop if percent1==.
replace percent1=100 if percent1>=100

 gen new=.
replace new=1 if   gwwc_year_n==2018
drop if new==1
drop if student==1
*****
save "/Users/Neil/Downloads/gwwc_2019.dta", replace

******
clear
set more off
use  "/Users/Neil/Downloads/gwwc_2019.dta"

keep if gwwc==1

 egen agegroup = cut(age), group(5) label
 tab agegroup gwwc
 
   gen newbin=.
 replace newbin =1 if percent1>=10
 replace newbin=0 if percent1 <10
tab agegroup  newbin,row chi2

tab agegroup  newbin

******

clear
set more off
use  "/Users/Neil/Downloads/gwwc_2019.dta"
   gen newbin=.
 replace newbin =1 if percent1>=10
 replace newbin=0 if percent1 <10
drop if student==1
keep if gwwc==1
pwcorr newbin income_2017_individual_n, print(0.028) star(0.01)
polychoric newbin income_2017_individual_n
esize twosample income_2017_individual_n,by(newbin ) pbc
recode age (18/25=1 "18-25") (26/27=2 "26-27") (28/30=3 "28-30") (31/36=4 "31-36") (37/81=5 "37+") (else=.), gen(agegroup1)
tab agegroup1
tab agegroup1 gwwc
   gen newbin=.
 replace newbin =1 if percent1>=10
 replace newbin=0 if percent1 <10

gen p_l=log(percent1)
gen i_l=log(income_2017_individual_n)
 
gen bracket=.
*93 over
replace bracket=4 if income_2017_individual_n >93642.00
*Under 93
replace bracket=3 if income_2017_individual_n <=93642.00
*under 53
replace bracket=2 if income_2017_individual_n <=52012.24
*under 27
replace bracket=1 if income_2017_individual_n <=28539
recode bracket (1=1 "$0 to $28K") (2=2 "$28K to $52K") (3=3 "$52K to $93K") (4=4 "Over $93K") (else=.), gen(money)


logit newbin agegroup1 i.ea_career_type which_year_ea gwwc_year_n income_2017_individual_n

keep if gwwc==1
tab ea_career_type, gen(job)
rename job1 otherjob
rename job2 earningtogive
rename job3 direct_charity
rename job4 research
label variable newbin "Donating 10% or More"
label variable earningtogive "Earning to Give"
label variable direct_charity "Direct/Charity Work"
label variable research "Research"
recode which_year_ea ( 704=2009 )  ( 705=2010 )  ( 706=2011 )  ( 707=2012 )  ( 708=2013 )  ( 709=2014 )  ( 7110=2015 )  ( 711=2016 ) ( 712=2017 ) (else=.) , gen(eayear)
label variable eayear "Year Joined EA"
 
label variable gwwc_year_n "Year Joined GWWC"
label variable income_2017_individual_n "Individual Income 2017"

keep newbin student age earningtogive direct_charity research eayear gwwc_year_n income_2017_individual_n
        
drop if newbin=. | age==. | earningtogive==. | direct_charity==. | research==. | eayear==. | gwwc_year_n==. | income_2017_individual_n==. 

*****
save "/Users/Neil/Downloads/gwwc_2019_x.dta", replace

logit newbin age earningtogive direct_charity research eayear gwwc_year_n income_2017_individual_n
 outreg2 using gwwc.doc, word replace ctitle(Model 1.)

margins, at(income_2017_individual_n=(1000(5000)500000)) post
marginsplot
