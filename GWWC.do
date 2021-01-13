clear
set more off
use  "/Users/Neil/Downloads/FinalSurvey1.dta"
*********DONATION PDATE 2:**
clear
set more off
use  "/Users/Neil/Downloads/FinalSurvey1.dta"

drop if donate_2017_c_n==.
drop if income_2017_individual_n==.
drop if income_2017_household_n==.
gen percent= (donate_2017_c_n/income)*100
drop if percent==.
replace percent=100 if percent>=100

gen percent1= (donate_2017_c_n/income_2017_individual_n)*100
drop if percent1==.
replace percent1=100 if percent1>=100

encode id
*****
save "/Users/Neil/Downloads/donateupdate.dta", replace

 do Fishers exact test on the tables






ologit gwcar involved_tlycs involved_local_ea involved_80k involved_gwwc member_ea_fb member_ea_forum member_tlycs studied_econ employed_retired first_heard_ea student veg_b
tab first_heard_ea x


codebook ea_welcoming, tab(999)
recode ea_welcoming (181=1 "Very unwelcoming") (180=2 "Unwelcoming") (179=3 "Neither") (183=4 "Welcoming") (182=5 "Very welcoming") (else=.), gen(welcome)

reg gwcar country
clear
set more off
use  "/Users/Neil/Downloads/donateupdate.dta"

****KIM REPLICATIOn



*remove the 90M point
keep if income_2017_individual_n<5000000
								 


**GWWC members in our sample report donating an average of $14847.77 and a median of $2890.56 during 2017, whereas non-members report donating an average of $9162.144 and a median of $520.12

tabstat donate_2017_c_n, by(gwwc) stat(mean p50)

**non-students only, 
drop if student==1
*self-identified GWWC members in our sample report donating 
drop if percent1==.
*an average of $23,397.74 and a median of $4075.19 in 2016, 
*whereas non-members report donating 
*an average of $8120.35 and a median of $1000.00 (Details are in Table 1).
tabstat donate_2017_c_n, by(gwwc) stat(mean p50 sd v)
swilk donate_2017_c_n
ttest donate_2017_c_n, by(gwwc) welch

(excluding students)
 donated a mean of 13.635% 
 and a median of exactly what the pledge requires (10.000%) in 2016,
 
 compared to a mean of 5.454% and a median of 2.380% among non-members
 
 tabstat percent1, by(gwwc) stat(mean p50 v sd)
 ttest percent1, by(gwwc) welch
 ttest percent, by(gwwc) unequal
  ttest percent1, by(gwwc) unequal
swilk percent
  ttest percent, by(gwwc) welch
  ranksum percent, by(gwwc)
  median percent1, by(gwwc) exact
  tabstat percent1, by(gwwc) stat(mean p50)
 keep if employed_full_time==7
 
 *a Shapiro–Wilk normality test showed that the percent % is not normally distributed. 
 therefore we used a The Wilcoxon-Mann-Whitney test, a non-parametric analog to the independent samples t-test used when you do not assume that the dependent variable is a normally distributed interval variable
 
 
 **Non student, <10%s
 clear
set more off
use  "/Users/Neil/Downloads/donateupdate.dta"
 gen new=.
replace new=1 if   gwwc_year_n==2018
drop if new==1
drop if student==1


keep if gwwc==1
 replace percent1=100 if percent1>=100
 
 gen newbin=.
 replace newbin =1 if percent>=10
 replace newbin=0 if percent <10
 drop if newbin==0
 tabstat percent
 
 
 
 
 **Drop those with less than $10K income
 drop if income_2017_individual_n <10000

 gen new=.
replace new=1 if  eayear==10
drop if new==1
drop new
 gen new=.
replace new=1 if   gwwc_year_n==2018
drop if new==1
 gen newbin=.
 replace newbin =1 if percent1>=10
 replace newbin=0 if percent1 <10
 tab newbin gwwc, row
  tab newbin gwwc, col
***Table 7: Pledge Adherence by Year Joined EA

clear
set more off
use  "/Users/Neil/Downloads/donateupdate.dta"
drop if student==1
replace percent=100 if percent>=100
 gen newbin=.
 replace newbin =1 if percent1>=10
 replace newbin=0 if percent1 <10
 
keep if gwwc==1
  drop if newbin==0
 
. tab eayear newbin, row
 
 **Pledge Adherence by Year Joined GWWC
 clear
set more off
use  "/Users/Neil/Downloads/donateupdate.dta"
drop if student==1
gen percent1= (donate_2017_c_n/income_2017_individual_n)*100
replace percent1=100 if percent1>=100
 gen newbin=.
 replace newbin =1 if percent1>=10
 replace newbin=0 if percent1 <10

 keep if gwwc==1
tab gwwc_year newbin, row

 **Pledge Adherence by Year Joined GWWC
 clear
set more off
use  "/Users/Neil/Downloads/donateupdate.dta"
drop if student==1

replace percent=100 if percent>=100
 gen newbin=.
 replace newbin =1 if percent>=10
 replace newbin=0 if percent <10

 keep if gwwc==1
tab gwwc_year newbin, row
 
*Table 9: Pledge Adherence by Income Bracket

clear
set more off
use  "/Users/Neil/Downloads/donateupdate.dta"
drop if student==1

 gen new=.
replace new=1 if   gwwc_year_n==2018
drop if new==1
keep if gwwc==1

egen incomebracket = cut(income_2017_individual_n), group(4) label
tab incomebracket
 gen percent2= (donate_2017_c_n/income_2017_individual_n)*100
 drop if percent2==.
replace percent2=100 if percent2>=100
 gen newbin=.
 replace newbin =1 if percent2>=10
 replace newbin=0 if percent2 <10

tab incomebracket newbin, row
tab incomebracket newbin, col chi2



gen bracket=.
*93 over
replace bracket=4 if income_2017_individual_n >93500
*Under 93
replace bracket=3 if income_2017_individual_n <=93500
*under 53
replace bracket=2 if income_2017_individual_n <=52012.24
*under 27
replace bracket=1 if income_2017_individual_n <27365.84
recode bracket (1=1 "$0 to $27K") (2=2 "$27K to $52K") (3=3 "$52K to $93K") (4=4 "Over $93K"), gen(money)
tab money gwwc
tab bracket
tab money newbin, row
tab money newbin, col chi2


gen bracket=.
replace bracket=4 if income_2017_individual_n >100000
replace bracket=3 if income_2017_individual_n <=100000
replace bracket=2 if income_2017_individual_n <=50000
replace bracket=1 if income_2017_individual_n <=30000


recode bracket (1=1 "$0 to $30K") (2=2 "$30K to $50K") (3=3 "$50K to $100K") (4=4 "Over $100K"), gen(money)


codebook money, tab(999)


tab money gwwc

 gen percent1= (donate_2017_c_n/income_2017_individual_n)*100
 keep if gwwc==1
 keep if money==4
 replace percent1=100 if percent1>=100
 gen newbin=.
 replace newbin =1 if percent1>=10
 replace newbin=0 if percent1 <10
 
 tab newbin 
 
 
*Table 10: Pledge Adherence by Employment Status

clear
set more off
use  "/Users/Neil/Downloads/donateupdate.dta"
 gen new=.
replace new=1 if   gwwc_year_n==2018
drop if new==1
drop if student==1
gen percent1= (donate_2017_c_n/income_2017_individual_n)*100
 replace percent=100 if percent>=100
 gen newbin=.
 replace newbin =1 if percent1>=10
 replace newbin=0 if percent1 <10

 **
 keep if gwwc==1
 tab eacareer newbin
 *unemployed
 gen unemployed=.
 replace unemployed=1 if employed_full_time==6
  replace unemployed=1 if employed_part_time==6
    replace unemployed=0 if employed_part_time==7
	 replace unemployed=0 if employed_full_time==7
 
 tab unemployed
tab unemployed gwwc
keep if gwwc==1
keep if unemployed==1

tab newbin

 
For-Profit
Non-profit
Academics
*Self-Employed 

tab employed_self
tab employed_self gwwc
keep if gwwc==1
keep if employed_self==7

tab newbin

Government
*Retired
tab employed_retired
tab employed_retired gwwc
keep if gwwc==1
keep if employed_retired==7

tab newbin


*Homemakeremployed_homemaker
sort employed_homemaker income

tab employed_homemaker
tab employed_homemaker gwwc
keep if gwwc==1
keep if employed_homemaker==7

tab newbin
 
 
 ***A*GE
 
 clear
set more off
use  "/Users/Neil/Downloads/donateupdate1.dta"

gen student1=0
replace student1=1 if employed_student_full==7
replace student1=1 if employed_student_part==7
replace student1=0 if employed_student_full==6
replace student1=0 if employed_student_part==6


merge m:1 ea_id using birth1.dta, force
 eacareer
 
 
 tab age gwwc
 recode age
 egen agegroup1 = cut(age), group(5) label
table age agegroup1

 clear
 import delimited "/Users/Neil/Downloads/2018-ea-survey-edited-currencied.csv", encoding(ISO-8859-1)

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
*****
save "/Users/Neil/Downloads/gwwc.dta", replace

******
clear
set more off
use  "/Users/Neil/Downloads/gwwc.dta"

recode ea_welcoming (1305 =1 "Very unwelcoming")( 1304 =2 "Unwelcoming")( 1303 =3 "Neither")(  1307=4 "Welcoming")( 1306=5 "Very welcoming")( else=. ), gen(welcome)

drop if income_2017_individual_n==.
gen bracket=.
*93 over
replace bracket=4 if income_2017_individual_n >93500
*Under 93
replace bracket=3 if income_2017_individual_n <=93500
*under 53
replace bracket=2 if income_2017_individual_n <=52012.24
*under 27
replace bracket=1 if income_2017_individual_n <27365.84
recode bracket (1=1 "$0 to $27K") (2=2 "$27K to $52K") (3=3 "$52K to $93K") (4=4 "Over $93K"), gen(money)
tab money




 gen new=.
replace new=1 if   gwwc_year_n==2018
drop if new==1
drop if student==1

recode age (18/25=1 "18-25") (26/29=2 "26-29") (30/33=3 "30-33") (34/81=4 "34 and older") (else=.), gen(agegroup)
tab agegroup
tab agegroup gwwc
keep if gwwc==1

 egen agegroup = cut(age), group(5) label
 tab agegroup1 gwwc

gen percent1= (donate_2017_c_n/income_2017_individual_n)*100

 replace percent1=100 if percent1>=100
gen ten=.
replace ten=percent1
 replace ten=100 if ten>=100
 replace ten=. if percent1==.
  
 tabstat ten, by(gwwc) stat(mean p50 v sd)
 tabstat ten, by(agegroup) stat(mean p50 v sd)
 
  
 
 
 replace percent1=100 if percent1>=100
 gen newbin=.
 replace newbin =1 if percent1>=10
 replace newbin=0 if percent1<10
tab agegroup newbin, row nofreq
tab agegroup newbin, col nofreq

replace which_year_ea=. if which_year_ea==8|which_year_ea==11

logit newbin student agegroup ea_career_type which_year_ea gwwc_year_n
margins, at(age=(

keep if gwwc==1
 egen incomebracket = cut(income_2017_individual_n), group(4) label
 tab incomebracket gwwc





*****
save "/Users/Neil/Downloads/rwwcR1.dta", replace






 
