clear
set more off
. cd "/Users/Neil/Downloads"
import delimited https://raw.githubusercontent.com/peterhurford/ea-data/master/data/2018/2018-ea-survey-anon-currencied-processed.csv

encode gender_b, gen(gender1)

gen donate_lifetime_n = real(donate_lifetime_c) 
gen p_donate_2017_n = real(p_donate_2017) 
gen plan_donate_2018_c_n = real(plan_donate_2018_c) 
gen donate_2017_c_n = real(donate_2017_c) 
gen percentdonate=(p_donate_2017_n*100)
gen volunteer_hours= real(ea_volunteer_hours)
gen gwwc_year_n=real(gwwc_year)
gen income_2017_household_n= real(income_2017_household_c)
gen income_2017_individual_n= real(income_2017_individual_c)
gen maximizing_scalen= real(maximizing_scale)
gen maximizing_subscalen = real(maximizing_subscale)
gen nfc_2_n= real(nfc_2_r)
gen big_five_extraverted_2_n= real(big_five_extraverted_2_r)
gen nfc_scale_n= real(nfc_scale)
gen big_five_extraverted_scale_n = real(big_five_extraverted_scale)
gen big_five_conscientious_2_r_n= real(big_five_conscientious_2_r)
gen big_five_conscientious_scale_n= real(big_five_conscientious_scale)
gen big_five_agreeable_1_n= real(big_five_agreeable_1_r)
gen big_five_agreeable_scale_n= real(big_five_agreeable_scale)
gen big_five_emotionally_stable_2_n= real(big_five_emotionally_stable_2_r)
gen big_five_emotionally_stable_scal_n= real(big_five_emotionally_stable_scal)
gen big_five_open_2_r_n= real(big_five_open_2_r)
gen pt_scale_n= real(pt_scale)
gen pd_scale_n= real(pd_scale)
gen percentd =(donate_2017_c_n/income_2017_individual_n)*100

gen donate_cause_far_future_2017_n=real(donate_cause_far_future_2017_c)
gen donate_cfar_2017_n= real(donate_cfar_2017_c)
gen donate_rc_2017_n= real(donate_rc_2017_c)
gen donate_80K_2017_n= real(donate_80k_2017_c)
gen donate_gf_2017_n= real(donate_gf_2017_c)
gen donate_miri_2017_n= real(donate_miri_2017_c)
gen donate_ace_2017_n= real(donate_ace_2017_c)
gen donate_mfa_2017_n= real(donate_mfa_2017_c)
gen donate_cea_2017_n= real(donate_cea_2017_c)
gen donate_dtw_2017_n= real(donate_dtw_2017_c)
gen donate_gw_2017_n= real(donate_gw_2017_c)
gen donate_sci_2017_n= real(donate_sci_2017_c)
gen donate_gd_2017_n= real(donate_gd_2017_c)
gen donate_ef_2017_n= real(donate_ef_2017_c)
gen donate_amf_2017_n= real(donate_amf_2017_c)
gen donate_thl_2017_n= real(donate_thl_2017_c)
gen plan_donate_2018_n= real(plan_donate_2018_c)
gen donate_RC_2017_n= real(donate_rc_2017_c)
gen pledge_year= real(gwwc_year)

tabstat donate_cfar_2017_n, stat(n sum mean q)
tabstat donate_rc_2017_n, stat(n sum mean q)
tabstat donate_80K_2017_n, stat(n sum mean q)
tabstat donate_gf_2017_n, stat(n sum mean q)
tabstat donate_miri_2017_n, stat(n sum mean q)
tabstat donate_ace_2017_n, stat(n sum mean q)
tabstat donate_mfa_2017_n, stat(n sum mean q)
tabstat donate_cea_2017_n, stat(n sum mean q)
tabstat donate_dtw_2017_n, stat(n sum mean q)
tabstat donate_gw_2017_n, stat(n sum mean q)
tabstat donate_sci_2017_n, stat(n sum mean q)
tabstat donate_gd_2017_n, stat(n sum mean q)
tabstat donate_ef_2017_n, stat(n sum mean q)
tabstat donate_amf_2017_n, stat(n sum mean q)
tabstat donate_thl_2017_n, stat(n sum mean q)






foreach V of varlist heard_ea-member_gwwc {
   encode `V', generate(aaa)         // provided variable aaa is not part of the dataset
   drop `V'
   rename aaa `V'
}
foreach V of varlist done_80k-currency_donate_2 {
   encode `V', generate(bbb)         // provided variable aaa is not part of the dataset
   drop `V'
   rename bbb `V'
}
foreach V of varlist gender-can_share_profile_location {
   encode `V', generate(bbb)         // provided variable aaa is not part of the dataset
   drop `V'
   rename bbb `V'
}
****
encode(student), gen(stud)
drop student
recode stud (2=1 "student") (1=0 "not"), gen(student)
encode age, gen(age1)
encode left, gen(left1)

save "/Users/Neil/Downloads/EAdonationX.dta", replace
clear
set more off
use  "/Users/Neil/Downloads/EAdonationX.dta"



gen top=.
replace top=1 if cause_import_animal_welfare==221
replace top=2 if cause_import_cause_prioritizatio==221
replace top=3 if cause_import_biosecurity==221
replace top=4 if cause_import_climate_change==221
replace top=5 if cause_import_nuclear_security==221
replace top=6 if cause_import_ai==221
replace top=7 if cause_import_mental_health==221
replace top=8 if cause_import_poverty==221
replace top=9 if cause_import_rationality==221
replace top=10 if cause_import_meta==221
replace top=11 if cause_import_xrisk_other==221

recode top (1=1 "animal_welfare") (2=2 "cause_prioritization") (3=3 "biosecurity") (4=4 "climate_change") (5=5 "nuclear_security") (6=6 "ai") (7=7 "mental_health")(8=8 "poverty") (9=9 "rationality") (10=10 "meta") (11=11 "xrisk_other") (else=.), gen(topp)
label variable topp "Top Cause"


gen top1=.
replace top1=1 if cause_import_animal_welfare==221
replace top1=2 if cause_import_cause_prioritizatio==221
replace top1=3 if cause_import_biosecurity==221
replace top1=4 if cause_import_climate_change==221
replace top1=5 if cause_import_nuclear_security==221
replace top1=6 if cause_import_ai==221
replace top1=7 if cause_import_mental_health==221
replace top1=8 if cause_import_poverty==221
replace top1=9 if cause_import_rationality==221
replace top1=10 if cause_import_meta==221
replace top1=11 if cause_import_xrisk_other==221

recode top1 (1=1 "animal_welfare") (2=2 "cause_prioritization") (3=3 "biosecurity") (4=4 "climate_change") (5=5 "nuclear_security") (6=6 "ai") (7=7 "mental_health")(8=8 "poverty") (9=9 "rationality") (10=10 "meta") (11=11 "xrisk_other") (else=.), gen(topp1)
label variable topp1 "Top Cause"







recode gender (2573=1 "woman") (2574 =0 "man") (else=.), gen(female)
 recode  member_ea_forum (23=0 "Non-member") ( 24=1 "Member"), gen(eaforum)
 
 recode member_lw (24=1 "LessWrong Member") (23=0 "non-member"), gen(lesswrong)
 recode member_ea_fb (24=1 " FB member") (23=0 "non-member"), gen(facebook)
 recode which_year_ea (1 12=.) (25=1 "2009 or before") (26=2 "2010") (27=3 "2011") (28=4 "2012") (29=5 "2013") (30=6 "2014") (31=7 "2015") (32=8 "2016") (33=9 "2017") (34=10 "2018"), gen(eayear) 
 recode done_80k  (2=1 "80k Coached") (1 4=0 "not coached") (else=.), gen(coach)
  recode done_80k  (37 36=1 "80k Coach")  (38 =0 "not coached") (else=.), gen(coach1)
recode member_gwwc (24=1 "GWWC member") (23=0 "Not GWWC") (else=.), gen(gwwc)
recode member_local_group (24=1 "local member") (23=0 "not local"), gen(localmem)
recode ea_career_shifted_path (24=1 "shifted") (23=0 "didn't shift"), gen(ea_career_shifted)

 gen lessforum=.
 replace lessforum=1 if lesswrong==1 & eaforum==1
  replace lessforum=2 if lesswrong==1 & eaforum==0
    replace lessforum=3 if lesswrong==0 & eaforum==1
	  replace lessforum=4 if lesswrong==0 & eaforum==0
 
 recode lessforum (1=1 "LW & EA Forum") (2=2 "LW only") (3=3 "Forum only") (4=4 "neither"), gen(engage)
   
 recode lessforum (1=4 "LW & EA Forum") (2=2 "LW only") (3=3 "EA Forum only") (4=1 "neither"), gen(lwea)
 

 
 recode veg ( 16 17 19  =1 "eat some meat") (21=2 "vegetarian")(20=3 "vegan") (else=.), gen(diet)

  recode first_heard_ea (5=11 "80k") (13=2 "LW") (19=3 "SSC") (14=4 "group") (15=5 "book") (16=6 "contact") (21=7 "TED") (7=8 "DGB") (10=9 "Givewell") (11=10 "GWWC") (1=.) (else=1 "other"), gen(firstheard)

 


recode ea_career_type (176=0 "Other") (174=1 "Direct_Non-Profit") (175=2 "Earning to Give") (177=3 "Research") (else=.), gen(eacareer)
 *politics
 

recode involved_personal_contact (23=0 "no") (24=1 "Personal contact") (else=.), gen(personalcontact)
 recode want_local_group (44=2 "want to") (43=1 "don't want to") (42=0 "unsure") (41=3 "involved"), gen(localgroup)
 recode want_local_group (41=1 "member") (42 43 41 =0 "not") (else=.), gen(localg)
recode involved_tlycs (24=1 "yes") (23=0 "no"), gen(tlycs)
recode involved_local_ea  (24=1 "yes") (23=0 "no"), gen(localea)
recode involved_university_ea (24=1 "yes") (23=0 "no"), gen(uniea)
recode involved_ace (24=1 "yes") (23=0 "no"), gen(ace)
recode involved_ssc (24=1 "yes") (23=0 "no"), gen(ssc)
recode involved_80k (24=1 "yes") (23=0 "no"), gen(eighty)
recode involved_online_ea (24=1 "yes") (23=0 "no"), gen(onlineea)
recode involved_gwwc (24=1 "yes") (23=0 "no"), gen(gwc)
recode involved_ea_global (24=1 "yes") (23=0 "no"), gen(eaglobal)
recode involved_book_blog (24=1 "yes") (23=0 "no"), gen(book)
recode involved_swiss (24=1 "yes") (23=0 "no"), gen(swiss)
recode involved_other (24=1 "yes") (23=0 "no"), gen(otherinvole)

 recode  member_gwwc (1=.) (23=0 "no") (24=1 " GWWC Pledge"),gen(pledge)
 
 label variable female "Woman"
 label variable coach "80K Coached"
 label variable facebook "EA Facebook"
 label variable ea_career_shifted "EA shifted career"
 label variable pledge "GWWC Pledge"
 label variable gwc "GWWC involved"
 label variable gwwc_year_n "Year Joined GWWC"
 
   recode cause_import_poverty (216=1 "none") (217=2 "some")  (219=3 "significant") (220=4 "near_top") (221=5 "top")  (else=.), gen(povscale)
      recode cause_import_ai  (216=1 "None") (217=2 "Some")  (219=3 "Significant") (220=4 "Near Top") (221=5 "Top")  (else=.), gen(aiscale)
	      recode cause_import_biosecurity  (216=1 "None") (217=2 "Some")  (219=3 "Significant") (220=4 "Near Top") (221=5 "Top")  (else=.), gen(bioscale)
		      recode cause_import_climate_change  (216=1 "none") (217=2 "some")  (219=3 "significant") (220=4 "near_top") (221=5 "top")   (else=.), gen(climscale)
			      recode cause_import_nuclear_security  (216=1 "None") (217=2 "Some")  (219=3 "Significant") (220=4 "Near Top") (221=5 "Top")   (else=.), gen(nukescale)
				      recode cause_import_mental_health  (216=1 "none") (217=2 "some")  (219=3 "significant") (220=4 "near_top") (221=5 "top")  (else=.), gen(mentalscale)
					      recode cause_import_rationality  (216=1 "none") (217=2 "some")  (219=3 "significant") (220=4 "near_top") (221=5 "top")  (else=.), gen(ratscale)
						      recode cause_import_meta  (216=1 "none") (217=2 "some")  (219=3 "significant") (220=4 "near_top") (221=5 "top")   (else=.), gen(metascale)
							      recode cause_import_xrisk_other  (216=1 "None") (217=2 "Some")  (219=3 "Significant") (220=4 "Near Top") (221=5 "Top")   (else=.), gen(xriskscale)
								   recode cause_import_animal_welfare  (216=1 "none") (217=2 "some")  (219=3 "significant") (220=4 "near_top") (221=5 "top")   (else=.), gen(animalscale)
				  recode cause_import_cause_prioritizatio  (216=1 "none") (217=2 "some")  (219=3 "significant") (220=4 "near_top") (221=5 "top")    (else=.), gen(causescale)
				
				

recode studied_cs (6=1 "CS") (7=0 "no") (else=.), gen(compsci)
recode studied_econ (6=1 "econ") (7=0 "no") (else=.), gen(econ)
recode studied_phil (6=1 "philos") (7=0 "no") (else=.), gen(phil)
recode studied_physics (6=1 "phys") (7=0 "no") (else=.), gen(phys)
recode studied_social_science (6=1 "socsci") (7=0 "no") (else=.), gen(socsci)
recode studied_humanities (6=1 "hum") (7=0 "no") (else=.), gen(hum)
recode studied_math (6=1 "math") (7=0 "no") (else=.), gen(math)
recode studied_psych (6=1 "psych") (7=0 "no") (else=.), gen(psych)
recode studied_engineering (6=1 "eng") (7=0 "no") (else=.), gen(eng)

replace age1=. if age1==7

save "/Users/Neil/Downloads/EAdonationX2.dta", replace
clear 
use  "/Users/Neil/Downloads/EAdonationX2.dta"

set more off


gen weird=.
. replace weird=1 if eayear==2 & income_2017_individual_n==15000000
 drop if weird==1
 gen rich=.
replace rich=1 if income_2017_individual_n>=126000
 replace rich=0 if income_2017_individual_n <126000
 
 tabstat donate_2017_c_n, by(eayear) stat(n sum p50)
 
clear 
use  "/Users/Neil/Downloads/EAdonationX2.dta",clear

set more off

gen rich=.
replace rich=1 if income_2017_individual_n>=126000
 replace rich=0 if income_2017_individual_n <126000
 
 gen med=.
replace med=1 if income_2017_individual_n>=31207.34
 replace med=0 if income_2017_individual_n <31207.34


donate_cause_meta_2017_c 
gen metadon=donate_cause_meta_2017_c 
replace metadon=. if donate_cause_meta_2017_c ==0

gen causedon=donate_cause_cause_pri_2017_c 
replace causedon=. if donate_cause_cause_pri_2017_c ==0


gen povdon=donate_cause_poverty_2017_c 
replace povdon=. if donate_cause_poverty_2017_c ==0

gen animaldon=donate_cause_animal_welfare_2017 
replace animaldon=. if donate_cause_animal_welfare_2017 ==0

gen aidon=donate_cause_far_future_2017_n
replace aidon=. if donate_cause_far_future_2017_n==0



rename donate_2017_c_n money


gen money=donate_2017_c_n
replace money=. if donate_2017_c_n==0
tabstat money, stats(n mean sum)
sum donate_2017_c_n,detail

 gen income= (income_2017_individual_n + income_2017_household_n)/2
gen perdon =(donate_2017_c_n/income)*100
gen perdon1 =(donate_2017_c_n/income_2017_individual_n)*100

gen donate_log =ln(donate_2017_c_n)
gen in_income_log=ln(income_2017_individual_n)
gen income_log =ln(income)
gen donate_2017_log=log(donate_2017_c_n)
gen income_2017_log=log(income_2017_individual_n)
egen donate_2017_std=std(donate_2017_c_n)
egen income_2017_individual_std=std(income_2017_individual_n)
egen income_std=std(income)

gen donate_2017_lognorm=exp(rnormal(donate_2017_c_n))
recode employed_full_time (6=0 "not full-time") (7=1 "full-time"), gen(fulltime1)
recode eacareer (2=1 "earning to give") (0 1 3=0 "other") (else=.), gen(etog)



. cumul donate_2017_c_n, gen(cum)
. sort cum
. line cum donate_2017_c_n, ylab(, grid) ytitle("") xlab(, grid)title("Cumulative of Donations")

. line donate_2017_c_n  cum , ylab(, grid) ytitle("") xlab(, grid)title("Cumulative of Donations")


gen new1=.
replace new1=1 if student==0 & fulltime1==1  

gen new=.
*Non student, full time*
replace new=1 if student==0 & fulltime1==1
*non student, non fulltime*
replace new=0 if student==0 & fulltime1==0
*student, full time*
replace new=0 if student==1 & fulltime1==1
*student, non-full time*
replace new=0 if student==1 & fulltime1==0

replace new=2 if student==0 & fulltime1==1 & income>20000 & income !=.
replace new=3 if student==0 & fulltime1==1 & income>20000 & donate_2017_c_n !=.  & income !=.

keep if new==2
tabstat donate_2017_c_n, stat(n sum mean q)

*****************************************************
****CORRELATIONS******
*****************************************************

pwcorr  donate_2017_c_n income_2017_individual_n, print(.05) star(.01)
pwcorr  donate_2017_c_n income_2017_individual_n, obs sig

*****************************************************
******Bayesian Regressions*******
*****************************************************



*****************************************************
******OLS Regressions*******
*****************************************************

**Standardised, indie income**
reg donate_2017_std income_2017_individual_std i.pledge i.etog i.student eayear
outreg2 using donation.doc,  word replace ctitle(Standardised Individual Income.) 

margins pledge,  at(income_2017_individual_std=(-.053673(0.5) 42.18149)) vsquish
marginsplot,  recast(line) recastci(rarea) scheme(s1mono)

reg donate_2017_std income_std i.pledge i.etog i.student eayear
outreg2 using donation.doc,  word append ctitle(Standardised Average Income.) 

******Negative Binomial Regressions*******
*****************************************************
nbreg donate_2017_c_n income_2017_individual_n i.pledge i.etog i.student eayear
outreg2 using donation.doc, addstat(Pseudo R2, e(r2_p)) word append ctitle(Negative Binomial Individual Income.) 
margins etog,  at(income_2017_individual_n=(0(10000)1300000)) vsquish
marginsplot,  recast(line) recastci(rarea) scheme(s1mono)


nbreg donate_2017_c_n income_2017_individual_n i.pledge i.etog i.student eayear
margins pledge,  at(income_2017_individual_n=(0(10000)1300000)) vsquish
marginsplot,  recast(line) recastci(rarea) scheme(s1mono)
******Negative Binomial Regressions*******
*****************************************************
nbreg donate_2017_c_n income i.pledge i.etog i.student i.eayear
outreg2 using donation.doc, addstat(Pseudo R2, e(r2_p)) word append ctitle(Negative Binomial Average Income.) 
nbreg donate_2017_c_n income pledge etog student i.eayear
margins eayear,  at(income=(0(10000)206337)) vsquish
marginsplot,  recast(line) recastci(rarea) scheme(s1mono)

nbreg donate_2017_c_n income i.pledge i.eacareer i.student i.eayear
margins pledge,  at(eayear=( 1(1)10)) vsquish
marginsplot,  recast(line) recastci(rarea) scheme(s1mono)
predict c
sort eacareer
twoway (line c donate_2017_c_n if eacareer==0)(line c donate_2017_c_n if eacareer==1)(line c donate_2017_c_n if eacareer==2) 
       ytitle("Predicted Mean Value of Donation") ) ///
       xtitle("$ Donations ") legend(order(0 "other Career" 1 "Direct work" 2 "Earning to Give" 3 "Research")) scheme(s1mono)
      


nbreg donate_2017_c_n income i.pledge i.etog i.student i.fulltime eayear
outreg2 using donation.doc, addstat(Pseudo R2, e(r2_p)) word append ctitle(Negative Binomial Average Income.) 

margins etog,  at(income_2017_individual_n=(0(10000)1300000)) vsquish
marginsplot,  recast(line) recastci(rarea) scheme(s1mono)


**non-standardised**

**log***

reg donate_log income_log student i.lwea female coach diet pledge


margins, dydx(*) vsquish



reg donate_2017_std income_2017_individual_std i.pledge i.student i.etog i.fulltime eayear
margins fulltime,  at(income_2017_individual_std=(-.053673(0.5) 42.18149)) vsquish
marginsplot,  recast(line) recastci(rarea) scheme(s1mono)


reg donate_2017_std income_std i.pledge i.student i.etog i.fulltime i.eayear
margins fulltime,  at(eayear=( 1(1)10)) vsquish
marginsplot,  recast(line) recastci(rarea) scheme(s1mono)


nbreg donate_2017_c_n income i.pledge i.student i.etog i.fulltime eayear
margins pledge,  at(income=(0(5000)206337)) vsquish
marginsplot,  recast(line) recastci(rarea) scheme(s1mono)

nbreg donate_2017_c_n income i.pledge i.student i.etog i.fulltime i.eayear
margins,  at(eayear=( 1(1)10)) vsquish
marginsplot,  recast(line) recastci(rarea) scheme(s1mono)


. histogram perdon, freq xaxis(1 2) xlabel(16.5355 "mean" 4.999977 "Median", axis(2) grid gmax) xtitle("", axis(2)) subtitle("EAs donating certain %s of income")(bin=101)


corr donate_2017_c_n income_2017_individual_n, print(.05) star(.01)
pwcorr  donate_2017_c_n income_2017_individual_n, print(.05) star(.01)
pwcorr  donate_2017_c_n income_2017_individual_n, obs sig



reg donate_2017_std income_2017_individual_std i.student i.lwea i.female i.coach i.pledge i.eayear
margins,  at(income_2017_individual_std=(-.053673(0.5) 42.18149)) vsquish
marginsplot,  recast(line) recastci(rarea) scheme(s1mono)


** %of income donated among full-time employed non-students earning >$20,000?
gen new=0

replace new=1 if student==0 & fulltime1==1 & income>20000
replace new=. if student==. | fulltime==. |income==.
keep if new==2
tabstat perdon, stat(n mean p50)
tabstat perdon1, stat(n mean p50)
tabstat donate_2017_c_n, stat(n mean p50)


egen



**Pther***
egen aisum=sum(aiscale)
egen povsum=sum(povscale)
egen ratsum=sum(ratscale)
egen ainmalsum=sum(animalscale)
egen biosum=sum(bioscale)
egen nukesum=sum(nukescale)
egen metasum=sum(metascale)
egen causesum=sum(causescale)
egen climbsum=sum(climscale)
egen mentalsum=sum(mentalscale)
egen xrisksum=sum(xriskscale)

drop if female==1 & lesswrong==0
egen aimean=mean(aiscale)
egen povmean=mean(povscale)
egen ratmean=mean(ratscale)
egen animalmean=mean(animalscale)
egen biomean=mean(bioscale)
egen nukemean=mean(nukescale)
egen metamean=mean(metascale)
egen causemean=mean(causescale)
egen climmean=mean(climscale)
egen mentalmean=mean(mentalscale)
egen xriskmean=mean(xriskscale)



***************
 gen num=1
bysort topp: egen yes=sum(num)

egen tot=sum(num)
gen rank =yes/tot
 graph bar rank,over(topp, sort(1) descending )

 bysort engage: egen totea=sum(num)
bysort engage topp: egen totea1=sum(num)
gen rankea=totea1/totea
 graph bar rankea,over(topp, sort(1) descending )
 
 bysort topp: egen enlf=sum(num) if engage==1
  bysort topp: egen enlw=sum(num) if engage==2
   bysort topp: egen enf=sum(num) if engage==3
  bysort topp: egen enn=sum(num) if engage==4
  gen enlftot= (enlf/totea)*100
  gen enlwtot=(enlw/totea)*100
    gen enftot= (enf/totea)*100
  gen enntot=(enn/totea)*100
  
  graph bar enlftot enlwtot enftot enntot, over(topp)
 graph save eaforum, replace






*******************************************************
**************MLOGIT TOP PRIORITY CAUSE**********************
******************************************************************
clear 
use  "/Users/Neil/Downloads/EAdonationX1.dta"
set more off
estimates clear




*******

 ologit povscale i.female i.coach i.lwea i.diet ea_career_shifted student eayear tlycs gwc personalcontact localgroup uniea phil  

outreg2 using ailogit.doc, addstat(Pseudo R2, e(r2_p)) word replace ctitle(Global Poverty.) 
estimates store marstat

quietly margins, dydx(female coach lwea ea_career_shifted gwc) predict(outcome(3)) post
estimates store Significant
estimates restore marstat

quietly margins, dydx(female coach lwea ea_career_shifted gwc) predict(outcome(4)) post
estimates store Near_Top_Priority
estimates restore marstat

quietly margins, dydx(female coach lwea ea_career_shifted gwc) predict(outcome(5)) post
estimates store Top_Priority

coefplot Significant Near_Top_Priority Top_Priority, legend(row(1)) xline(0) title(Resources for AI: AMEs with 95% CIs)
centile ( percentdonate), centile (10 20 30 40 50 60 70 80 90 91 92 93 94 95 96 97 98 99)





bysort lwea female: egen meanpov=mean(povscale)
bysort lwea female : egen meanai=mean(aiscale)
bysort lwea female: egen meanan=mean(animalscale)
bysort lwea female: egen meancli=mean(climscale)
bysort lwea female: egen meancause=mean(causescale)
bysort lwea female: egen meanmeta=mean(metascale)
bysort lwea female: egen meanxrisk=mean(xriskscale)
bysort lwea female: egen meanbio=mean(bioscale)
bysort lwea female: egen meannuke=mean(nukescale)
bysort lwea female: egen meanrat=mean(ratscale)
bysort lwea female: egen meanmental=mean(mentalscale)




bysort female: egen meanpovf=mean(povscale)
bysort female: egen meanaif=mean(aiscale)
bysort female: egen meananf=mean(animalscale)
bysort female: egen meanclif=mean(climscale)
bysort female: egen meancausef=mean(causescale)
bysort female: egen meanmetaf=mean(metascale)
bysort female: egen meanxriskf=mean(xriskscale)
bysort female: egen meanbiof=mean(bioscale)
bysort female: egen meannukef=mean(nukescale)
bysort female: egen meanratf=mean(ratscale)
bysort female: egen meanmentalf=mean(mentalscale)




egen meanpov1=mean(povscale)
egen meanai1=mean(aiscale)
egen meanan1=mean(animalscale)
egen meancli1=mean(climscale)
egen meancause1=mean(causescale)
egen meanmeta1=mean(metascale)
egen meanxrisk1=mean(xriskscale)
egen meanbio1=mean(bioscale)
egen meannuke1=mean(nukescale)
egen meanrat1=mean(ratscale)
egen meanmental1=mean(mentalscale)


 
 
  ***** ***** ***** *****  ***** ***** ***** *****  ***** ***** ***** *****  ***** ***** ***** *****
    ***** ***** ***** *****  ***** ***** ***** *****  ***** ***** ***** *****  ***** ***** ***** *****
	  ***** ***** ***** *****  ***** ***** ***** *****  ***** ***** ***** *****  ***** ***** ***** *****
	    ***** ***** ***** *****  ***** ***** ***** *****  ***** ***** ***** *****  ***** ***** ***** *****  ***** ***** ***** *****  ***** ***** ***** *****  ***** ***** ***** *****
 *****MLOGIT***
 
gen an=0
gen ai=0
gen risk=0
gen cause=0
gen mental=0
gen bio=0
gen nuke=0
gen rat=0
gen meta=0
gen clim=0
gen pov=0


replace an=1 if cause_import_animal_welfare==221
replace cause=1 if cause_import_cause_prioritizatio==221
replace bio=1 if cause_import_biosecurity==221
replace clim=1 if cause_import_climate_change==221
replace nuke=1 if cause_import_nuclear_security==221
replace ai=1 if cause_import_ai==221
replace mental=1 if cause_import_mental_health==221
replace pov=1 if cause_import_poverty==221
replace rat=1 if cause_import_rationality==221
replace meta=1 if cause_import_meta==221
replace risk=1 if cause_import_xrisk_other==221

gen refuse = an+cause+bio+clim+nuke+ai+mental+pov+rat+meta+risk

drop if refuse>1
save "/Users/Neil/Downloads/EAdonationX3.dta", replace
clear 
use  "/Users/Neil/Downloads/EAdonationX3.dta"
set more off


 estimates clear
 mlogit topp female coach i.lwea i.diet ea_career_shifted age1 student eayear gwc personalcontact localg eighty, nolog
estimates store marstat

ssc install outreg2
outreg2 using mlogitEA.doc, word replace ctitle(Model 1.) 

. quietly margins, dydx(*) predict(outcome(poverty)) post
. estimates store poverty
. estimates restore marstat

. quietly margins, dydx(*) predict(outcome(ai)) post
. estimates store ai
. estimates restore marstat

. quietly margins, dydx(*) predict(outcome(climate_change)) post
. estimates store climate_change
. estimates restore marstat

. quietly margins, dydx(*) predict(outcome(animal_welfare)) post
. estimates store animal_welfare


coefplot poverty ai climate_change animal_welfare, legend(row(1)) xline(0) title(AMEs with 95% CIs)
****ONLY SUBSTANTIVE PREDICTORS****
 estimates clear
 mlogit topp female coach1 i.lwea i.diet ea_career_shifted student age1 eayear gwc personalcontact localg , nolog
estimates store marstat

ssc install outreg2
outreg2 using mlogitEA.doc, word replace ctitle(Model 1.) 


**
. quietly margins, dydx(female coach lwea diet ea_career_shifted gwc) predict(outcome(poverty)) post
. estimates store poverty
. estimates restore marstat

. quietly margins, dydx(female coach lwea diet ea_career_shifted gwc) predict(outcome(ai)) post
. estimates store ai
. estimates restore marstat

. quietly margins, dydx(female coach lwea diet ea_career_shifted gwc) predict(outcome(climate_change)) post
. estimates store climate_change
. estimates restore marstat

. quietly margins, dydx(female coach lwea diet ea_career_shifted gwc) predict(outcome(animal_welfare)) post
. estimates store animal_welfare


coefplot poverty ai climate_change animal_welfare, legend(row(1)) xline(0) title(AMEs with 95% CIs)


***OLOGIT****
estimates clear
set more off
*POV*
 
 ologit povscale i.female i.coach1 i.lwea i.diet ea_career_shifted student eayear tlycs gwc personalcontact localgroup uniea phil  
 estimates store marstat

quietly margins, dydx(female coach1 lwea diet ea_career_shifted tlycs gwc) predict(outcome(3)) post
estimates store Significant
estimates restore marstat

quietly margins, dydx(female coach1 lwea diet ea_career_shifted tlycs gwc) predict(outcome(4)) post
estimates store Near_Top_Priority
estimates restore marstat

quietly margins, dydx(female coach1 lwea diet ea_career_shifted tlycs gwc) predict(outcome(5)) post
estimates store Top_Priority

coefplot Significant Near_Top_Priority Top_Priority, legend(row(1)) xline(0) title(Resources for AI: AMEs with 95% CIs)

 *AI*
 estimates clear
set more off
 ologit aiscale i.female i.coach i.lwea i.diet ea_career_shifted student eayear tlycs gwc  personalcontact localgroup eighty math compsci
 estimates store marstat

quietly margins, dydx(female coach lwea ea_career_shifted eighty) predict(outcome(3)) post
estimates store Significant
estimates restore marstat

quietly margins, dydx(female coach lwea ea_career_shifted eighty) predict(outcome(4)) post
estimates store Near_Top_Priority
estimates restore marstat

quietly margins, dydx(female coach lwea ea_career_shifted eighty) predict(outcome(5)) post
estimates store Top_Priority

coefplot Significant Near_Top_Priority Top_Priority, legend(row(1)) xline(0) title(AI Risks AMEs with 95% CIs)

 *Climate*
 estimates clear
set more off
 ologit climscale i.female i.coach i.lwea i.diet ea_career_shifted student  eayear tlycs gwc personalcontact localgroup  hum  socsci
 estimates store marstat

quietly margins, dydx(female lwea ea_career_shifted tlycs hum ) predict(outcome(3)) post
estimates store Significant
estimates restore marstat

quietly margins, dydx (female lwea ea_career_shifted tlycs hum ) predict(outcome(4)) post
estimates store Near_Top_Priority
estimates restore marstat

quietly margins,dydx(female lwea ea_career_shifted tlycs hum ) predict(outcome(5)) post
estimates store Top_Priority

coefplot Significant Near_Top_Priority Top_Priority, legend(row(1)) xline(0) title(Climate Change AMEs with 95% CIs)

 *animal*
 estimates clear
set more off
ologit animalscale i.female i.coach i.lwea i.diet ea_career_shifted student eayear tlycs gwc personalcontact localgroup  ace phil socsci
estimates store marstat

quietly margins, dydx(diet ace) predict(outcome(3)) post
estimates store Significant
estimates restore marstat

quietly margins, dydx (diet ace) predict(outcome(4)) post
estimates store Near_Top_Priority
estimates restore marstat

quietly margins,dydx(diet ace) predict(outcome(5)) post
estimates store Top_Priority

coefplot Significant Near_Top_Priority Top_Priority, legend(row(1)) xline(0) title(Animal Welfare AMEs with 95% CIs)

**Cause**
 estimates clear
set more off
 ologit causescale i.female i.coach i.lwea i.diet ea_career_shifted student eayear tlycs gwc personalcontact localgroup  eighty ssc hum

estimates store marstat

quietly margins, dydx(coach lwea ea_career_shifted eighty) predict(outcome(3)) post
estimates store Significant
estimates restore marstat

quietly margins, dydx (coach lwea ea_career_shifted eighty) predict(outcome(4)) post
estimates store Near_Top_Priority
estimates restore marstat

quietly margins,dydx(coach lwea ea_career_shifted eighty) predict(outcome(5)) post
estimates store Top_Priority

coefplot Significant Near_Top_Priority Top_Priority, legend(row(1)) xline(0) title(Cause Prioritisation AMEs with 95% CIs)

