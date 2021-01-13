clear
clear
set more off
. cd "/Users/Neil/Downloads"
import delimited https://raw.githubusercontent.com/peterhurford/ea-data/master/data/2018/2018-ea-survey-anon-currencied-processed.csv


clear
set more off
. cd "/Users/Neil/Downloads"
import delimited https://raw.githubusercontent.com/peterhurford/ea-data/7662bc029cceaabb46a46b5507d5fc868c197bd8/data/2018/2018-ea-survey-anon-currencied-processed.csv

clear
set more off
. cd "/Users/Neil/Downloads"
import delimited https://raw.githubusercontent.com/peterhurford/ea-data/master/data/2018/2018-ea-survey-anon-currencied-processed.csv

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

gen donate_cause_far_future_2017_n= real(donate_cause_far_future_2017_c)
gen donate_cause_poverty_2017_n= real(donate_cause_poverty_2017_c)
gen donate_cause_animal_welfare_2017_n= real(donate_cause_animal_welfare_2017)
gen donate_cause_cause_pri_2017_n= real(donate_cause_cause_pri_2017_c)
gen donate_cause_meta_2017_n= real(donate_cause_meta_2017_c)

save "/Users/Neil/Downloads/EASurvey.dta", replace
clear 
use  "/Users/Neil/Downloads/EASurvey.dta"
set more off
******DATA GROOMING*********

foreach V of varlist heard_ea-pt_scale {
   encode `V', generate(aaa)         // provided variable aaa is not part of the dataset
   drop `V'
   rename aaa `V'
}
foreach V of varlist donate_cause_far_future_2017_c-pt_scale {
   encode `V', generate(bbb)         // provided variable aaa is not part of the dataset
   drop `V'
   rename bbb `V'
}
******
save "/Users/Neil/Downloads/EASurvey1.dta", replace
clear
set more off
use  "/Users/Neil/Downloads/EASurvey1.dta"

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


codebook education,tab(999)

recode gender ( 2573=1 "woman") (2574=0 "man") (else=.), gen(female)
 recode  member_ea_forum (23=0 "Non-member") ( 24=1 "Member"), gen(eaforum)
 
 recode member_lw (24=1 "LessWrong Member") (23=0 "non-member"), gen(lesswrong)
 recode member_ea_fb (24=1 " FB member") (23=0 "non-member"), gen(facebook)
 recode which_year_ea (1 12=.) (25=2009 "2009") (26=2010 "2010") (27=2011 "2011") (28=2012 "2012") (29=2013 "2013") (30=2014 "2014") (31=2015 "2015") (32=2016 "2016") (33=2017 "2017") (34=2018 "2018"), gen(eayear) 
 recode done_80k  (37=1 "80k Coached") (26 38 =0 "not coached") (else=.), gen(coach)
recode member_gwwc (24=1 "GWWC member") (23=0 "Not GWWC") (else=.), gen(gwwc)
recode member_local_group (24=1 "local member") (23=0 "not local"), gen(localmem)

 gen lessforum=.
 replace lessforum=1 if lesswrong==1 & eaforum==1
  replace lessforum=2 if lesswrong==1 & eaforum==0
    replace lessforum=3 if lesswrong==0 & eaforum==1
	  replace lessforum=4 if lesswrong==0 & eaforum==0
 
 recode lessforum (1=1 "LW+ Forum") (2=2 "LW only") (3=3 "Forum only") (4=4 "neither"), gen(engage)

 
gen xtop=.
replace xtop=1 if cause_import_animal_welfare==221
replace xtop=2 if cause_import_cause_prioritizatio==221
replace xtop=3 if cause_import_biosecurity==221
replace xtop=3 if cause_import_xrisk_other==221
replace xtop=3 if cause_import_nuclear_security==221
replace xtop=3 if cause_import_ai==221
replace xtop=4 if cause_import_climate_change==221
replace xtop=5 if cause_import_mental_health==221
replace xtop=6 if cause_import_poverty==221
replace xtop=7 if cause_import_rationality==221
replace xtop=8 if cause_import_meta==221


recode xtop (1=1 "animal_welfare") (2=2 "cause_prioritization") (3=3 "ltf") (4=4 "climate_change") (5=5 "mental health") (6=6 "poverty") (7=7 "rationality") (8=8 "meta") (else=.), gen(xtopp)
label variable xtopp "XTop Cause"

codebook xtopp
 
 
 gen neartop=.
replace neartop=1 if cause_import_animal_welfare==221| cause_import_animal_welfare==220
replace neartop=2 if cause_import_cause_prioritizatio==221 | cause_import_cause_prioritizatio==220
replace neartop=3 if cause_import_biosecurity==221| cause_import_biosecurity==220
replace neartop=4 if cause_import_climate_change==221|  cause_import_climate_change==220
replace neartop=5 if cause_import_nuclear_security==221|  cause_import_nuclear_security==220
replace neartop=6 if cause_import_ai==221 |  cause_import_ai==220
replace neartop=7 if cause_import_mental_health==221|  cause_import_mental_health==220
replace neartop=8 if cause_import_poverty==221|  cause_import_poverty==220
replace neartop=9 if cause_import_rationality==221|  cause_import_rationality==220
replace neartop=10 if cause_import_meta==221|  cause_import_meta==220
replace neartop=11 if cause_import_xrisk_other==221|  cause_import_xrisk_other==220

recode neartop (1=1 "animal_welfare") (2=2 "cause_prioritization") (3=3 "biosecurity") (4=4 "climate_change") (5=5 "nuclear_security") (6=6 "ai") (7=7 "mental_health")(8=8 "poverty") (9=9 "rationality") (10=10 "meta") (11=11 "xrisk_other") (else=.), gen(neartopp)
label variable neartopp "Top/Near Cause"
 
 clear 
use  "/Users/Neil/Downloads/EASurvey2.dta"
set more off
 
 

 recode veg (2584=1 "Eat meat" ) (2585=2 "reductionist")  (2586 =3 "pescetarian") (2588=4 "vegetarian") (2587=5 "vegan") (else=.), gen(vegan)
 recode veg (2584 2585 2586 =1 "eat some meat") (2588=2 "vegetarian") (2587=3 "vegan") (else=.), gen(veggie)

  recode first_heard_ea (5=11 "80k") (13=2 "LW") (19=3 "SSC") (14=4 "group") (15=5 "book") (16=6 "contact") (127=7 "TED") (7=8 "DGB") (10=9 "Givewell") (11=10 "GWWC") (1=.) (else=1 "other"), gen(firstheard)
 rename veggie diet
   
 recode lessforum (1=4 "LW & EA Forum") (2=2 "LW only") (3=3 "EA Forum only") (4=1 "neither"), gen(lwea)
 

recode ea_career_shifted_path (24=1 "shifted") (23=0 "didn't shift"), gen(ea_career_shifted)

recode ea_career_type (208=0 "Other") (206=1 "Non-Profit") (207=2 "Earning to Give") (209=3 "Research") (else=.), gen(eacareer)
 *politics
 
 codebook  involved_other,tab(999)
 

recode involved_personal_contact (23=0 "no") (24=1 "Personal contact") (else=.), gen(personalcontact)
 recode want_local_group (44=2 "want to") (43=1 "don't want to") (42=0 "unsure") (41=3 "involved"), gen(localgroup)
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

recode (24=1 "") (23=0 "no") (else=.), gen()


recode studied_cs (24=1 "CS") (23=0 "no") (else=.), gen(compsci)
recode studied_econ (24=1 "econ") (23=0 "no") (else=.), gen(econ)
recode studied_phil (24=1 "philos") (23=0 "no") (else=.), gen(phil)
recode studied_physics (24=1 "phys") (23=0 "no") (else=.), gen(phys)
recode studied_social_science (24=1 "socsci") (23=0 "no") (else=.), gen(socsci)
recode studied_humanities (24=1 "hum") (23=0 "no") (else=.), gen(hum)
recode studied_math (24=1 "math") (23=0 "no") (else=.), gen(math)
recode studied_psych (24=1 "psych") (23=0 "no") (else=.), gen(psych)
recode studied_engineering (24=1 "eng") (23=0 "no") (else=.), gen(eng)

gen subject=.
replace subject =1 if compsci==1
replace subject =2 if math==1
replace subject =3 if phil==1
replace subject =4 if hum==1
replace subject =5 if socsci==1
replace subject =6 if psych==1
replace subject =7 if econ==1
replace subject =8 if phys==1
replace subject =9 if eng==1

recode subject (1=1 "compsci") (2=2 "math") (3=3 "philosphy") (4=4 "humanities") (5=5 "social_science") (6=6 "psych") (7=7 "econ") (8=8 "physics") (9=9 "engineering"), gen(sub)


mlogit topp female coach i.lwea i.diet ea_career_shifted pledge hum, nolog
p





 tab(eacareer), gen(job)
 rename job1 otherjob
 rename job2 nonprofjob
 rename job3 etog
 rename job4 research
 recode  member_gwwc (1=.) (23=0 "no") (24=1 " GWWC Pledge"),gen(pledge)
 
 label variable female "Woman"
 label variable coach "80K Coached"
 label variable facebook "EA Facebook"
 label variable ea_career_shifted "EA shifted career"
 label variable pledge "GWWC Pledge"
 
 label variable state "country name"
 label variable state "country name"
 label variable state "country name"
 label variable state "country name"
 
i.diet ea_career_shifted pledge facebook
 
save "/Users/Neil/Downloads/EASurvey3.dta", replace
clear 
use  "/Users/Neil/Downloads/EASurvey3.dta"
set more off

mlogit topp female coach lesswrong eaforum diet firstheard age eayear, nolog
listcoef 1.female, help
listcoef , help pvalue(.01) positive
 mlogtest, lr
 mlogtest, wald
 mlogtest, lrcomb
 
 
quietly mlogit topp i.female i.coach i.lesswrong eaforum diet firstheard age eayear, nolog
estimates store raw
quietly margins, dydx(female coach lesswrong ) post
estimates store ame
coefplot (raw) || (ame), xline(0) keep(1.*) byopts(xrescale)



mlogit topp female i.coach i.lesswrong eaforum diet firstheard age eayear, nolog

estimates store marstat
coefplot (marstat, eq(ai)) (marstat, eq(climate_change)) (marstat, eq(cause_prioritization))  (marstat, eq(poverty)),  xline(0)

**
. quietly margins, dydx(*) predict(outcome(ai)) post
. estimates store ai
. estimates restore marstat

. quietly margins, dydx(*) predict(outcome(poverty)) post
. estimates store poverty
. estimates restore marstat

. quietly margins, dydx(*) predict(outcome(climate_change)) post
. estimates store climate_change
. estimates restore marstat

. quietly margins, dydx(*) predict(outcome(cause_prioritization)) post
. estimates store cause_prioritization
coefplot ai poverty climate_change cause_prioritization, legend(row(1)) xline(0) title(AMEs with 95% CIs)

************************************************************************************************************************
****************************************************************************************************
********************v********************************************************************************

clear 
use  "/Users/Neil/Downloads/EASurvey3.dta"
set more off
estimates clear

mlogit topp female coach i.lwea i.diet ea_career_shifted facebook pledge i.eacareer, nolog

estimates store marstat

**
. quietly margins, dydx(*) predict(outcome(ai)) post
. estimates store ai
. estimates restore marstat

. quietly margins, dydx(*) predict(outcome(poverty)) post
. estimates store poverty
. estimates restore marstat

. quietly margins, dydx(*) predict(outcome(climate_change)) post
. estimates store climate_change
. estimates restore marstat

. quietly margins, dydx(*) predict(outcome(animal_welfare)) post
. estimates store animal_welfare

coefplot ai poverty climate_change animal_welfare, legend(row(1)) xline(0) title(AMEs with 95% CIs)


clear 
use  "/Users/Neil/Downloads/EASurvey3.dta"
set more off
estimates clear

mlogit topp female coach i.lwea i.diet ea_career_shifted facebook pledge i.eacareer, nolog

estimates store marstat

**
. quietly margins, dydx(*) predict(outcome(ai)) post
. estimates store ai
. estimates restore marstat

. quietly margins, dydx(*) predict(outcome(poverty)) post
. estimates store poverty
. estimates restore marstat

. quietly margins, dydx(*) predict(outcome(climate_change)) post
. estimates store climate_change
. estimates restore marstat

. quietly margins, dydx(*) predict(outcome(animal_welfare)) post
. estimates store animal_welfare

coefplot ai poverty climate_change animal_welfare, legend(row(1)) xline(0) title(AMEs with 95% CIs)


. quietly margins, dydx(firstheard) predict(outcome(cause_prioritization)) post
. estimates store cause_prioritization
********************************************************************************
clear 
use  "/Users/Neil/Downloads/EASurvey3.dta"
set more off
estimates clear

mlogit xtopp i.female i.coach i.lwea i.diet i.ea_career_shifted i.facebook i.pledge i.eacareer, nolog

estimates store marstat

**
. quietly margins, dydx(*) predict(outcome(ltf)) post
. estimates store ltf
. estimates restore marstat

. quietly margins, dydx(*) predict(outcome(poverty)) post
. estimates store poverty
. estimates restore marstat

. quietly margins, dydx(*) predict(outcome(climate_change)) post
. estimates store climate_change
. estimates restore marstat

. quietly margins, dydx(*) predict(outcome(animal_welfare)) post
. estimates store animal_welfare

coefplot ltf poverty climate_change animal_welfare, legend(row(1)) xline(0) title(AMEs with 95% CIs)

********************************************************************************
************************************************************v
********************************************************************************
tab lwea, gen(mem)
mlogit topp female coach i.lwea i.diet ea_career_shifted student eayear gwc personalcontact localg age1, nolog
estimates store marstat
outreg2 using mlogitEA.doc, word replace ctitle(Model 1.) 



clear 
use  "/Users/Neil/Downloads/EASurvey3.dta"
set more off
estimates clear
ssc install outreg2
mlogit topp female coach i.lwea i.diet ea_career_shifted pledge facebook i.eacareer, nolog
outreg2 using mlogitEA.doc, word replace ctitle(Model 1.)
estimates store marstat

**
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

coefplot poverty || ai || climate_change || animal_welfare, xline(0) byopt(rows(1) title(AMEs with 95% CIs))


. quietly margins, dydx(*) predict(outcome(cause_prioritization)) post
. estimates store cause_prioritization
. estimates restore marstat

. quietly margins, dydx(*) predict(outcome(rationality)) post
. estimates store rationality
. estimates restore marstat

. quietly margins, dydx(*) predict(outcome(meta)) post
. estimates store meta
. estimates restore marstat

. quietly margins, dydx(*) predict(outcome(xrisk_other)) post
. estimates store xrisk_other

coefplot cause_prioritization rationality meta xrisk_other, legend(row(1)) xline(0) title(AMEs with 95% CIs)





********************************************************************************
mlogit topp female coach i.lwea i.diet ea_career_shifted facebook pledge i.eacareer, nolog
mlogit topp female coach i.lwea i.diet ea_career_shifted facebook pledge i.eacareer ace eighty gwc personalcontact  localgroup localea localmem eayear firstheard, nolog




********************DATA ROBOT MODEL*******************************

clear 
use  "/Users/Neil/Downloads/EASurvey3.dta"
set more off
estimates clear

mlogit topp female coach i.lwea diet ea_career_shifted facebook i.age , nolog

estimates store marstat

**
. quietly margins, dydx(firstheard) predict(outcome(ai)) post
. estimates store ai
. estimates restore marstat

. quietly margins, dydx(firstheard) predict(outcome(poverty)) post
. estimates store poverty
. estimates restore marstat

. quietly margins, dydx(firstheard) predict(outcome(climate_change)) post
. estimates store climate_change
. estimates restore marstat

. quietly margins, dydx(firstheard) predict(outcome(animal_welfare)) post
. estimates store animal_welfare

. quietly margins, dydx(firstheard) predict(outcome(cause_prioritization)) post
. estimates store cause_prioritization
coefplot ai poverty climate_change animal_welfare cause_prioritization, legend(row(1)) xline(0) title(AMEs with 95% CIs)






mlogit topp female coach lesswrong eaforum diet firstheard age eayear, nolog
quietly fitstat, save
* Now drop least significant vars
mlogit topp female coach lesswrong eaforum diet , nolog
fitstat, dif force
 
 

 gen byte nonfemalehold=female
 replace female=0
 predict manpov, outcome(8)
 predict manai, outcome(6)
 predict mancc, outcome(4)
 replace female=1
 predict wmpov, outcome(8)
  predict wmai, outcome(6)
   predict wmcc, outcome(4)
   replace female=nonfemalehold
   
   summarize man* wm*, sep(3)
 margins female, predict(outcome(6)) noesample
  margins female, predict(outcome(8)) noesample
   margins female, predict(outcome(4)) noesample
   
   
 margins, dydx(*) predict(outcome(8))

*******GENDER***
 -1.4493 *Coach
 -1.213 *fem only
 -1.205 *FB
 -1.180 *Year
 -1.126*EAF
 -1.010 *LW


 recode education (6088=5 "PhD") (6087=3 "BA") (6090=4 "MA") (6093 6089=1 "No college") (6086 6091 6092=2 "other college"), gen(college)
 recode education (6088 6087 6090=1 "Graduate") (6093 6089=2 "No college") (6086 6091 6092=3 "other college"), gen(grad)

 drop if aiscale==.
 reg aiscale i.female i.coach i.lwea i.diet ea_career_shifted pledge facebook i.eacareer
 
 
. rvfplot, yline(0)

   **********************************************************************************
 *****************************************SCALE**********************************************************
 ******************************************************************************
 clear 
use  "/Users/Neil/Downloads/EASurvey3.dta"
set more off
estimates clear
  recode cause_import_poverty (216=2 "none") (217=3 "some") (218=1 "unsure") (219=4 "significant") (220=5 "near-top") (221=6 "top")  (else=.), gen(povscale)
      recode cause_import_ai (216=2 "none") (217=3 "some") (218=1 "unsure") (219=4 "significant") (220=5 "near-top") (221=6 "top")  (else=.), gen(aiscale)
	      recode cause_import_biosecurity (216=2 "none") (217=3 "some") (218=1 "unsure") (219=4 "significant") (220=5 "near-top") (221=6 "top")  (else=.), gen(bioscale)
		      recode cause_import_climate_change (216=2 "none") (217=3 "some") (218=1 "unsure") (219=4 "significant") (220=5 "near-top") (221=6 "top")  (else=.), gen(climscale)
			      recode cause_import_nuclear_security (216=2 "none") (217=3 "some") (218=1 "unsure") (219=4 "significant") (220=5 "near-top") (221=6 "top")  (else=.), gen(nukescale)
				      recode cause_import_mental_health (216=2 "none") (217=3 "some") (218=1 "unsure") (219=4 "significant") (220=5 "near-top") (221=6 "top")  (else=.), gen(mentalscale)
					      recode cause_import_rationality (216=2 "none") (217=3 "some") (218=1 "unsure") (219=4 "significant") (220=5 "near-top") (221=6 "top")  (else=.), gen(ratscale)
						      recode cause_import_meta (216=2 "none") (217=3 "some") (218=1 "unsure") (219=4 "significant") (220=5 "near-top") (221=6 "top")  (else=.), gen(metascale)
							      recode cause_import_xrisk_other (216=2 "none") (217=3 "some") (218=1 "unsure") (219=4 "significant") (220=5 "near-top") (221=6 "top")  (else=.), gen(xriskscale)
								   recode cause_import_animal_welfare (216=2 "none") (217=3 "some") (218=1 "unsure") (219=4 "significant") (220=5 "near-top") (221=6 "top")  (else=.), gen(animalscale)
				  recode cause_import_cause_prioritizatio (216=2 "none") (217=3 "some") (218=1 "unsure") (219=4 "significant") (220=5 "near-top") (221=6 "top")  (else=.), gen(causescale)
				
  
   hist povscale, by(engage female) discret percent xla(1/6, valuelabel noticks angle(vertical))
   hist aiscale, by(engage female) discret percent xla(1/6, valuelabel noticks angle(vertical))
     hist bioscale, by(engage female) discret percent xla(1/6, valuelabel noticks angle(vertical))
     hist climscale, by(lwea) discret percent xla(1/6, valuelabel noticks angle(vertical))
     hist nukescale, by(engage female) discret percent xla(1/6, valuelabel noticks angle(vertical))
     hist mentalscale, by(female) discret percent xla(1/6, valuelabel noticks angle(vertical))
     hist ratscale, by(female) discret percent xla(1/6, valuelabel noticks angle(vertical))
     hist metascale, by(female) discret percent xla(1/6, valuelabel noticks angle(vertical))
     hist xriskscale, by(female) discret percent xla(1/6, valuelabel noticks angle(vertical))
	 hist animalscale, by(female) discret percent xla(1/6, valuelabel noticks angle(vertical))

reg povscale i.female i.coach i.lwea i.diet ea_career_shifted pledge facebook i.eacareer
margins, dydx(*) post
estimates store pov
marginsplot, horizontal recast(scatter) recastci(rspike) xline(0) xlabel(, grid) ylabel(,nogrid)

reg povscale i.female i.coach i.lwea i.diet ea_career_shifted pledge facebook i.eacareer phil
estimates store pov
outreg2 using redEA.doc, word replace ctitle(Poverty.)
reg aiscale i.female i.coach i.lwea i.diet ea_career_shifted pledge facebook i.eacareer math
margins, dydx(*) post
estimates store ai
outreg2 using redEA.doc, word append ctitle(AI.)
reg bioscale i.female i.coach i.lwea i.diet ea_career_shifted pledge facebook i.eacareer
margins, dydx(*) post
estimates store bio
outreg2 using redEA.doc, word append ctitle(Biosecurity.)
reg climscale i.female i.coach i.lwea i.diet ea_career_shifted pledge facebook i.eacareer
margins, dydx(*) post
estimates store climate
outreg2 using redEA.doc, word append ctitle(Climate Change.)
reg nukescale i.female i.coach i.lwea i.diet ea_career_shifted pledge facebook i.eacareer
margins, dydx(*) post
estimates store nuke
outreg2 using redEA.doc, word append ctitle(Nuclear Security.)
reg mentalscale i.female i.coach i.lwea i.diet ea_career_shifted pledge facebook i.eacareer
margins, dydx(*) post
estimates store mental
outreg2 using redEA.doc, word append ctitle(Mental Health.)
reg ratscale i.female i.coach i.lwea i.diet ea_career_shifted pledge facebook i.eacareer
margins, dydx(*) post
estimates store rat
outreg2 using redEA.doc, word append ctitle(Rationality.)
reg metascale i.female i.coach i.lwea i.diet ea_career_shifted pledge facebook i.eacareer
margins, dydx(*) post
estimates store meta
outreg2 using redEA.doc, word append ctitle(Meta)
reg xriskscale i.female i.coach i.lwea i.diet ea_career_shifted pledge facebook i.eacareer
margins, dydx(*) post
estimates store xrisk
outreg2 using redEA.doc, word append ctitle(Other Xrisk.)
reg animalscale i.female i.coach i.lwea i.diet ea_career_shifted pledge facebook i.eacareer
margins, dydx(*) post
estimates store animal
outreg2 using redEA.doc, word append ctitle(Animal Welfare.)
reg causescale i.female i.coach i.lwea i.diet ea_career_shifted pledge facebook i.eacareer
margins, dydx(*) post
estimates store cause
outreg2 using redEA.doc, word append ctitle(Cause Prioritisation.)





coefplot  ai || bio || nuke  || xrisk , xline(0) byopt(rows(1) title(AMEs with 95% CIs))
coefplot pov || climate || mental ||  animal   , xline(0) byopt(rows(1) title(AMEs with 95% CIs))
coefplot  cause || meta || rat , xline(0) byopt(rows(1) title(AMEs with 95% CIs))
   **********************************************************************************
 *****************************************SCALE**********************************************************
 ******************************************************************************
 
  clear 
use  "/Users/Neil/Downloads/EASurvey3.dta"
set more off
estimates clear
  recode cause_import_poverty (216=1 "none") (217=2 "some")  (219=3 "significant") (220=4 "near_top") (221=5 "top")  (else=.), gen(povscale)
      recode cause_import_ai  (216=1 "none") (217=2 "some")  (219=3 "significant") (220=4 "near_top") (221=5 "top")  (else=.), gen(aiscale)
	      recode cause_import_biosecurity  (216=1 "none") (217=2 "some")  (219=3 "significant") (220=4 "near_top") (221=5 "top")  (else=.), gen(bioscale)
		      recode cause_import_climate_change  (216=1 "none") (217=2 "some")  (219=3 "significant") (220=4 "near_top") (221=5 "top")   (else=.), gen(climscale)
			      recode cause_import_nuclear_security  (216=1 "none") (217=2 "some")  (219=3 "significant") (220=4 "near_top") (221=5 "top")   (else=.), gen(nukescale)
				      recode cause_import_mental_health  (216=1 "none") (217=2 "some")  (219=3 "significant") (220=4 "near_top") (221=5 "top")  (else=.), gen(mentalscale)
					      recode cause_import_rationality  (216=1 "none") (217=2 "some")  (219=3 "significant") (220=4 "near_top") (221=5 "top")  (else=.), gen(ratscale)
						      recode cause_import_meta  (216=1 "none") (217=2 "some")  (219=3 "significant") (220=4 "near_top") (221=5 "top")   (else=.), gen(metascale)
							      recode cause_import_xrisk_other  (216=1 "none") (217=2 "some")  (219=3 "significant") (220=4 "near_top") (221=5 "top")   (else=.), gen(xriskscale)
								   recode cause_import_animal_welfare  (216=1 "none") (217=2 "some")  (219=3 "significant") (220=4 "near_top") (221=5 "top")   (else=.), gen(animalscale)
				  recode cause_import_cause_prioritizatio  (216=1 "none") (217=2 "some")  (219=3 "significant") (220=4 "near_top") (221=5 "top")    (else=.), gen(causescale)
				


reg povscale i.female i.coach i.lwea i.diet ea_career_shifted pledge facebook i.eacareer
 margins, dydx(*) post
estimates store pov
reg aiscale i.female i.coach i.lwea i.diet ea_career_shifted pledge facebook i.eacareer eayear
margins, dydx(*) post
estimates store ai
reg bioscale i.female i.coach i.lwea i.diet ea_career_shifted pledge facebook i.eacareer
margins, dydx(*) post
estimates store bio
reg climscale i.female i.coach i.lwea i.diet ea_career_shifted pledge facebook i.eacareer
margins, dydx(*) post
estimates store climate
reg nukescale i.female i.coach i.lwea i.diet ea_career_shifted pledge facebook i.eacareer
margins, dydx(*) post
estimates store nuke
reg mentalscale i.female i.coach i.lwea i.diet ea_career_shifted pledge facebook i.eacareer
margins, dydx(*) post
estimates store mental
reg ratscale i.female i.coach i.lwea i.diet ea_career_shifted pledge facebook i.eacareer
margins, dydx(*) post
estimates store rat
reg metascale i.female i.coach i.lwea i.diet ea_career_shifted pledge facebook i.eacareer
margins, dydx(*) post
estimates store meta
reg xriskscale i.female i.coach i.lwea i.diet ea_career_shifted pledge facebook i.eacareer
margins, dydx(*) post
estimates store xrisk
reg animalscale i.female i.coach i.lwea i.diet ea_career_shifted pledge facebook i.eacareer
margins, dydx(*) post
estimates store animal
reg causescale i.female i.coach i.lwea i.diet ea_career_shifted pledge facebook i.eacareer
margins, dydx(*) post
estimates store cause





coefplot  ai || bio || nuke  || xrisk , xline(0) byopt(rows(1) title(AMEs with 95% CIs))
coefplot pov ||  animal   , xline(0) byopt(rows(1) title(AMEs with 95% CIs))
coefplot climate || mental    , xline(0) byopt(rows(1) title(AMEs with 95% CIs))
coefplot  cause || meta || rat , xline(0) byopt(rows(1) title(AMEs with 95% CIs))
 
    **********************************************************************************
 *****************************************SCALE**********************************************************
 ******************************************************************************
 


ologit povscale i.female i.coach i.lwea i.diet ea_career_shifted pledge facebook i.eacareer eayear age
estimates store pov
outreg2 using redEA.doc, word replace ctitle(Poverty.)
ologit aiscale i.female i.coach i.lwea i.diet ea_career_shifted pledge facebook i.eacareer eayear age
margins, dydx(*) post
estimates store ai
outreg2 using redEA.doc, word append ctitle(AI.)
ologit bioscale i.female i.coach i.lwea i.diet ea_career_shifted pledge facebook i.eacareer  eayear age
margins, dydx(*) post
estimates store bio
outreg2 using redEA.doc, word append ctitle(Biosecurity.)
ologit climscale i.female i.coach i.lwea i.diet ea_career_shifted pledge facebook i.eacareer eayear age
margins, dydx(*) post
estimates store climate
outreg2 using redEA.doc, word append ctitle(Climate Change.)
ologit nukescale i.female i.coach i.lwea i.diet ea_career_shifted pledge facebook i.eacareer eayear age
margins, dydx(*) post
estimates store nuke
outreg2 using redEA.doc, word append ctitle(Nuclear Security.)
ologit mentalscale i.female i.coach i.lwea i.diet ea_career_shifted pledge facebook i.eacareer eayear age
margins, dydx(*) post
estimates store mental
outreg2 using redEA.doc, word append ctitle(Mental Health.)
ologit ratscale i.female i.coach i.lwea i.diet ea_career_shifted pledge facebook i.eacareer eayear age
margins, dydx(*) post
estimates store rat
outreg2 using redEA.doc, word append ctitle(Rationality.)
ologit metascale i.female i.coach i.lwea i.diet ea_career_shifted pledge facebook i.eacareer eayear age
margins, dydx(*) post
estimates store meta
outreg2 using redEA.doc, word append ctitle(Meta)
ologit xriskscale i.female i.coach i.lwea i.diet ea_career_shifted pledge facebook i.eacareer eayear age
margins, dydx(*) post
estimates store xrisk
outreg2 using redEA.doc, word append ctitle(Other Xrisk.)
ologit animalscale i.female i.coach i.lwea i.diet ea_career_shifted pledge facebook i.eacareer eayear age
margins, dydx(*) post
estimates store animal
outreg2 using redEA.doc, word append ctitle(Animal Welfare.)
ologit causescale i.female i.coach i.lwea i.diet ea_career_shifted pledge facebook i.eacareer eayear age
margins, dydx(*) post
estimates store cause
outreg2 using redEA.doc, word append ctitle(Cause Prioritisation.)

  predict non som sig ntop ttop 
  list ntop ttop female coach pledge if povscale>=., sep(4) divider

  hist nukescale, discrete percent by(eayear) 
 
  
  clear 
use  "/Users/Neil/Downloads/EASurvey3.dta", clear
set more off
estimates clear
  
quietly ologit aiscale i.female i.coach i.lwea i.diet ea_career_shifted pledge facebook i.eacareer eayear age
estimates store marstat

quietly margins, dydx(*) predict(outcome(1)) post
estimates store None
estimates restore marstat

quietly margins, dydx(*) predict(outcome(4)) post
estimates store Near_Top_Priority
estimates restore marstat

quietly margins, dydx(*) predict(outcome(5)) post
estimates store Top_Priority

coefplot None Near_Top_Priority Top_Priority, legend(row(1)) xline(0) title(Resources for AI: AMEs with 95% CIs)


***POV**
  estimates clear
quietly  ologit povscale i.female i.coach i.lwea i.diet ea_career_shifted student eayear tlycs gwc personalcontact localgroup uniea phil  age1
estimates store marstat

quietly margins, dydx(female coach lwea diet ea_career_shifted tlycs gwc) predict(outcome(3)) post
estimates store Significant
estimates restore marstat

quietly margins, dydx(female coach lwea diet ea_career_shifted tlycs gwc) predict(outcome(4)) post
estimates store Near_Top_Priority
estimates restore marstat

quietly margins, dydx(female coach lwea diet ea_career_shifted tlycs gwc) predict(outcome(5)) post
estimates store Top_Priority

coefplot Significant Near_Top_Priority Top_Priority, legend(row(1)) xline(0) title(Poverty Ranking: AMEs with 95% CIs)


***Ai**
  estimates clear
quietly ologit aiscale i.female i.coach i.lwea i.diet ea_career_shifted student eayear tlycs gwc  personalcontact localgroup eighty math compsci age1
estimates store marstat

quietly margins, dydx(*) predict(outcome(3)) post
estimates store Significant
estimates restore marstat

quietly margins, dydx(*) predict(outcome(4)) post
estimates store Near_Top_Priority
estimates restore marstat

quietly margins, dydx(*) predict(outcome(5)) post
estimates store Top_Priority

coefplot Significant Near_Top_Priority Top_Priority, legend(row(1)) xline(0) title(Poverty Ranking: AMEs with 95% CIs)

***Climate**
codebook eayear, tab(999)


  estimates clear
quietly ologit climscale i.female i.coach i.lwea i.diet ea_career_shifted pledge facebook i.eacareer  eayear age1 hum socsci
estimates store marstat

quietly margins, dydx(*) predict(outcome(3)) post
estimates store Significant
estimates restore marstat

quietly margins, dydx(*) predict(outcome(4)) post
estimates store Near_Top_Priority
estimates restore marstat

quietly margins, dydx(*) predict(outcome(5)) post
estimates store Top_Priority

coefplot Significant Near_Top_Priority Top_Priority, legend(row(1)) xline(0) title(Climate Change Ranking: AMEs with 95% CIs)


***Cause**
  estimates clear
quietly ologit causescale i.female i.coach i.lwea i.diet ea_career_shifted pledge facebook i.eacareer
estimates store marstat

quietly margins, dydx(*) predict(outcome(3)) post
estimates store Significant
estimates restore marstat

quietly margins, dydx(*) predict(outcome(4)) post
estimates store Near_Top_Priority
estimates restore marstat

quietly margins, dydx(*) predict(outcome(5)) post
estimates store Top_Priority

coefplot Significant Near_Top_Priority Top_Priority, legend(row(1)) xline(0) title(Cause Prioritisation Ranking: AMEs with 95% CIs)



***xrisk**
  estimates clear
quietly ologit xriskscale i.female i.coach i.lwea i.diet ea_career_shifted pledge facebook i.eacareer
estimates store marstat

quietly margins, dydx(*) predict(outcome(3)) post
estimates store Significant
estimates restore marstat

quietly margins, dydx(*) predict(outcome(4)) post
estimates store Near_Top_Priority
estimates restore marstat

quietly margins, dydx(*) predict(outcome(5)) post
estimates store Top_Priority

coefplot Significant Near_Top_Priority Top_Priority, legend(row(1)) xline(0) title(Other X-Risk Ranking: AMEs with 95% CIs)




marginsplot, horizontal recast(scatter) recastci(rspike) xline(0) 

estimates store ai 
  ********************************************************************************************************
  ****************************DONATIONS******************************************
  **************************v****************************************************
  hist donate_2017_c_n, by(gender) discret percent 
ttest percentdonate, by(female)
ttest donate_2017_c_n, by(coach)

sum donate_2017_c_n if coach==1, detail
sum donate_2017_c_n if coach==0, detail


reg donate_2017_c_n female i.lwea coach, vce(robust)

********
gen unsure=.
replace unsure=1 if cause_import_animal_welfare==218
replace unsure=2 if cause_import_cause_prioritizatio==218
replace unsure=3 if cause_import_biosecurity==218
replace unsure=4 if cause_import_climate_change==218
replace unsure=5 if cause_import_nuclear_security==218
replace unsure=6 if cause_import_ai==218
replace unsure=7 if cause_import_mental_health==218
replace unsure=8 if cause_import_poverty==218
replace unsure=9 if cause_import_rationality==218
replace unsure=10 if cause_import_meta==218
replace unsure=11 if cause_import_xrisk_other==218

recode unsure (1=1 "animal_welfare") (2=2 "cause_prioritization") (3=3 "biosecurity") (4=4 "climate_change") (5=5 "nuclear_security") (6=6 "ai") (7=7 "mental_health")(8=8 "poverty") (9=9 "rationality") (10=10 "meta") (11=11 "xrisk_other") (else=.), gen(unsurep)
label variable unsurep "Unsure Cause"



bysort 
  **************************v****************************************************
  Women & far future,
  poverty
  
  Donations by Cause Area
  
gen causeprio= sum(donate_cause_cause_pri_2017_c)
gen glopov= sum(donate_cause_poverty_2017_c)
sum glopov
gen anwel= sum(donate_cause_animal_welfare_2017)
sum anwel
gen met= sum(donate_cause_meta_2017_c)
sum met
gen farfu= sum(donate_cause_far_future_2017_n)
sum farfu
  
    hist aiscale, discrete percent by(lwea) xla(1/5, valuelabels angle(45)) scheme(s1mono)
  
  
  hist aiscale, discrete percent by(eighty) xla(1/5, valuelabels angle(45)) scheme(s1mono)
graph save aicoach2, replace
  hist xriskscale, discrete percent by(eighty) xla(1/5, valuelabels angle(45)) scheme(s1mono)
graph save xriskcoach2, replace
  hist bioscale, discrete percent by(eighty) xla(1/5, valuelabels angle(45)) scheme(s1mono)
graph save biocoach2, replace
  hist nukescale, discrete percent by(eighty) xla(1/5, valuelabels angle(45)) scheme(s1mono)
graph save nukecoach2, replace

graph combine aicoach2.gph xriskcoach2.gph biocoach2.gph nukecoach2.gph

  **************************v****************************************************
 clear 
use  "/Users/Neil/Downloads/EASurvey3.dta"
set more off
estimates clear

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
 
 
 
 *****
 
 tab first_heard_ea  pledge

 
