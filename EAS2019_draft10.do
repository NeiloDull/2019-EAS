***EA DRAFt 10

**INTERNAL

foreach V of varlist is_ea1-member_gwwc{
   encode `V', generate(aaa)         // provided variable aaa is not part of the dataset
   drop `V'
   rename aaa `V'
}
gen gwwcyear=real(gwwc_year)
gen engaged_scale=real(ea_engaged_scale)
foreach V of varlist activity_applied_eag-top_case {
   encode `V', generate(bbb)         // provided variable aaa is not part of the dataset
   drop `V'
   rename bbb `V'
}
gen income=real(income_2018)
gen income_c=real(income_2018_c)
foreach V of varlist ea_career_type_ea_org-studied_other {
   encode `V', generate(ccc)         // provided variable aaa is not part of the dataset
   drop `V'
   rename ccc `V'
}

foreach V of varlist experience_generalist_research-dpe {
   encode `V', generate(ddd)         // provided variable aaa is not part of the dataset
   drop `V'
   rename ddd `V'
}
gen donation=real(donate_2018_c)
gen percent=real(p_donate_2018)

foreach V of varlist cause_import_animal_welfare_b-veg_b {
   encode `V', generate(eee)         // provided variable aaa is not part of the dataset
   drop `V'
   rename eee `V'
}
encode student, gen(stud)
gen age1=real(age)
recode veg (1211 1210=1 "veg") (1207/2019=0 "meat") (else=.), gen(veg_c)
save "/Users/neildullaghan/Downloads/EAS_draft10.dta",replace


use "/Users/neildullaghan/Downloads/EAS_draft10.dta",clear



gen eajob=0
replace eajob=1 if ea_org_employed==4|activity_employed_ea_org==3

gen candidate=0
replace candidate=1 if activity_applied_ea_org_job==3|ea_career_type_ea_org==3
replace candidate=0 if activity_employed_ea_or ==3| ea_org_employed ==4

gen nopath=0
replace nopath=1 if ea_org_employed==4|activity_employed_ea_org==3|activity_applied_ea_org_job==3|ea_career_type_ea_org==2


gen canexp=0
replace canexp=1 if experience_generalist_research ==2|experience_management ==2|experience_economics ==2|experience_philosophy ==2|experience_government ==2|experience_operations ==2|experience_ml ==2|experience_ai_safety ==2|experience_movement_building ==2|experience_admin ==2|experience_pa ==2|experience_life_sciences ==2|experiences_marketing ==2|experience_math ==2|experience_comms ==2|experience_webdev ==2|experience_international_dev ==2|experience_software ==2|experience_asset_management ==2|experience_law ==2|experience_consulting ==2| experience_accounting ==2
gen cc=0
replace cc=1 if candidate==1 & canexp==1


gen softexp=0
replace softexp=1 if experience_generalist_research ==2|experience_management ==2|experience_economics ==2|experience_philosophy ==2|experience_government ==2|experience_operations ==2|experience_ml ==2|experience_ai_safety ==2|experience_movement_building ==2|experience_admin ==2|experience_pa ==2|experience_life_sciences ==2|experiences_marketing ==2|experience_math ==2|experience_comms ==2|experience_webdev ==2|experience_international_dev ==2|experience_software ==2|experience_asset_management ==2|experience_law ==2|experience_consulting ==2| experience_accounting ==2
gen soft=.
replace soft=0 if  canexp==1
replace soft=1 if experience_software==2 & canexp==1

gen planapply=0
replace planapply=1 if ea_org_employed==4|activity_applied_eag==3| activity_attended_eag ==3| activity_read_ea_book ==3| activity_ea_forum_posted ==3| activity_ea_forum_commented ==3| activity_wrote_not_ea_forum==3| activity_ea_fb==3| activity_organized_ea_event ==3| activity_ea_local_leader ==3| activity_applied_ea_org_job ==3| activity_employed_ea_org ==3| activity_volunteer_ea_org ==3|activity_ea_plan_change==3|activity_ea_donate==3|ea_career_type_ea_org==2|ea_career_type_non_profit==2| ea_career_type_etg==2| ea_career_type_non_etg_for_profi==2| ea_career_type_non_academia_rese==2| ea_career_type_academia==2| ea_career_type_government==2| ea_career_type_advocacy==2


gen nopathexp=0
replace nopathexp=1 if experience_generalist_research ==2|experience_management ==2|experience_economics ==2|experience_philosophy ==2|experience_government ==2|experience_operations ==2|experience_ml ==2|experience_ai_safety ==2|experience_movement_building ==2|experience_admin ==2|experience_pa ==2|experience_life_sciences ==2|experiences_marketing ==2|experience_math ==2|experience_comms ==2|experience_webdev ==2|experience_international_dev ==2|experience_software ==2|experience_asset_management ==2|experience_law ==2|experience_consulting ==2| experience_accounting ==2

gen pc=0
replace pc=1 if nopath==0 & nopathexp==1
tab pc



gen eajobexp=0
replace eajobexp=1 if experience_generalist_research ==2|experience_management ==2|experience_economics ==2|experience_philosophy ==2|experience_government ==2|experience_operations ==2|experience_ml ==2|experience_ai_safety ==2|experience_movement_building ==2|experience_admin ==2|experience_pa ==2|experience_life_sciences ==2|experiences_marketing ==2|experience_math ==2|experience_comms ==2|experience_webdev ==2|experience_international_dev ==2|experience_software ==2|experience_asset_management ==2|experience_law ==2|experience_consulting ==2| experience_accounting ==2
gen ec=0
replace ec=1 if eajob==1 & eajobexp==1
tab ec


gen activity=0
replace activity=1 if ea_org_employed==4|activity_applied_eag==2| activity_attended_eag ==2| activity_read_ea_book ==2| activity_ea_forum_posted ==2| activity_ea_forum_commented ==2| activity_wrote_not_ea_forum==2| activity_ea_fb==2| activity_organized_ea_event ==2| activity_ea_local_leader ==2| activity_applied_ea_org_job ==2| activity_employed_ea_org ==2| activity_volunteer_ea_org ==2|activity_ea_plan_change==2|activity_ea_donate==2|done_80k==2| k_coach_applied==2

gen eajob1=.
replace eajob1=0 if activity==1
replace eajob1=1 if ea_org_employed==4|activity_employed_ea_org==2



gen barrier=0
replace barrier=1 if ea_barrier_too_demanding==2| ea_barrier_limited_advice==2| ea_barrier_too_few_jobs==2| ea_barrier_job_too_hard==2| ea_barrier_unclear_where_donate==2| ea_barrier_unclear_how_movement_==2|  ea_barrier_lack_mentor==2|  ea_barrier_not_diverse==2|ea_barrier_not_welcoming==2|ea_barrier_elitist==2|ea_barrier_unsocial==2|ea_barrier_no_ea_friends==2|	 ea_barrier_no_group==2|	 	  ea_barrier_no_ea_content==2|		  ea_barrier_no_barrier==2


         
if ea_org_employed==4|activity_applied_eag==2| activity_attended_eag ==2| activity_read_ea_book ==2| activity_ea_forum_posted ==2| activity_ea_forum_commented ==2| activity_wrote_not_ea_forum==2| activity_ea_fb==2| activity_organized_ea_event ==2| activity_ea_local_leader ==2| activity_applied_ea_org_job ==2| activity_employed_ea_org ==2| activity_volunteer_ea_org ==2|activity_ea_plan_change==2|activity_ea_donate==2|done_80k==2| k_coach_applied==2


ttest age1, by(eajob1) welch
median age1, by(eajob1) 

recode gender_b (342=0 "female") (343=1 "male") (else=.), gen(male1)
tab eajob1 male1, chi2


 tab eajob1 male1, chi2 row nofreq

gen race_answer=.
replace race_answer=1 if race_white==2| race_black==2|  race_hispanic==2|  race_native_american==2|  race_pacific_islander==2|  race_asian==2|  race_other==2
gen nonwhite2=.
replace nonwhite2=0 if race_answer==1
replace nonwhite2=1 if race_white==2
replace nonwhite2=2 if race_white!=2 &  race_answer==1

gen newwhite=.
replace newwhite=1 if race_white==2
replace newwhite=0 if race_black==2|  race_hispanic==2|  race_native_american==2|  race_pacific_islander==2|  race_asian==2|  race_other==2
replace newwhite=0 if race_black==2|  race_hispanic==2|  race_native_american==2|  race_pacific_islander==2|  race_asian==2|  race_other==2

gen poc=.
replace poc=0 if race_white==2
replace poc=1 if race_black==2|  race_hispanic==2|  race_native_american==2|  race_pacific_islander==2|  race_asian==2|  race_other==2
tab poc

gen poc1=race_answer
replace poc1=0 if race_white==2
replace poc1=1 if race_black==2|  race_hispanic==2|  race_native_american==2|  race_pacific_islander==2|  race_asian==2|  race_other==2
tab poc1 poc



gen eajob1=.
replace eajob1=0 if activity==1
replace eajob1=1 if ea_org_employed==4|activity_employed_ea_org==2


gen eajob2=. 
replace eajob2=0 if activity==1
replace eajob2=1 if ea_org_employed==4


rename eajob1 eajobever
rename eajob2 eajobnow

rename poc xx
recode xx (0=0 "Entirely White") (1=1 "POC"), gen(poc)


tab eajobever poc, chi2 row nofreq
tab eajobnow poc, chi2 row nofreq

gen white=.
replace white=0 if racist==1
replace white=1 if race_white==2


recode ea_career_type_other (3/97 99/176=1 "other") (98=.) (else=.), gen(career_other)
gen career_type=.

replace career_type=1 if ea_career_type_ea_org==2|ea_career_type_non_profit==2| ea_career_type_etg==2| ea_career_type_non_etg_for_profi==2| ea_career_type_non_academia_rese==2| ea_career_type_academia==2| ea_career_type_government==2| ea_career_type_advocacy==2 |career_other==1
*EA
gen career_type_ea_org=.
replace career_type_ea_org=0 if career_type==1
replace career_type_ea_org=1 if ea_career_type_ea_org==2

*Non prof
gen career_type_non_profit=.
replace career_type_non_profit=0 if career_type==1
replace career_type_non_profit=1 if ea_career_type_non_profit==2

*Prof
gen career_type_non_etg_for_profi=.
replace career_type_non_etg_for_profi=0 if career_type==1
replace career_type_non_etg_for_profi=1 if ea_career_type_non_etg_for_profi==2

*Acamde
gen career_type_academia=.
replace career_type_academia=0 if career_type==1
replace career_type_academia=1 if ea_career_type_academia==2

*Gov
gen career_type_government=.
replace career_type_government=0 if career_type==1
replace career_type_government=1 if ea_career_type_government==2

*Lobby
gen career_type_advocacy=.
replace career_type_advocacy=0 if career_type==1
replace career_type_advocacy=1 if ea_career_type_advocacy==2


*E2g
gen career_type_etg=.
replace career_type_etg=0 if career_type==1
replace career_type_etg=1 if ea_career_type_etg==2
tab career_type_etg
ttest age1 ,by( career_type_etg) welch

    

ttest age1, by(facebook) welch*
ttest age1, by(forum) welch*
ttest age1, by(lesswrong) welch
ttest age1, by(local) welch*
ttest age1, by(gwwc_member) welch



ttest income, by(facebook) welch
ttest income, by(forum) welch
ttest income, by(lesswrong) welch
ttest income, by(local) welch
ttest income, by(gwwc_member) welch

keep if fulltimenonstudent==1
median income_new  if fulltimenonstudent==1,by(engaged_scale) 

median income_new if fulltimenonstudent==1,by(engaged_scale) exact

median income_log10 if fulltimenonstudent==1,by(engaged_scale)
median income_log10 if fulltimenonstudent==1,by(engaged_scale) exact




**MEMBERSHIP

gen membership=.
replace membership=0 if forum==1| facebook==1| lesswrong==1| local==1| gwwc_member==1
replace membership
tab



tab career_type_ea_org
tab career_type_etg  white, chi2 row
tab career_type_etg male1, chi2


gen employed=.
replace employed=1 if employed_full_time==2| employed_homemaker==2| employed_looking==2| employed_not_looking==2| employed_part_time==2| employed_retired==2| employed_self==2| employed_student_full==2| employed_student_part==2
gen retired=.
replace retired=0 if employed==1
replace retired=1 if employed_retired==2

gen fulltime=.
replace fulltime=0 if employed==1
replace fulltime=1 if employed_full_time==2

gen fulltimenonstudent=.
replace fulltimenonstudent=0 if employed==1
replace fulltimenonstudent=1 if fulltime==1 & student==1
replace fulltimenonstudent=1 if fulltime==1 & student==1




gen a=0
replace a=1 if ea_career_type_ea_org==2
gen b=0
replace b=1 if ea_career_type_non_profit==2
gen c=0
replace c=1 if ea_career_type_etg==2
gen d=0
replace d=1 if ea_career_type_non_etg_for_profi==2
gen e=0
replace e=1 if ea_career_type_non_academia_rese==2
gen f=0
replace f=1 if ea_career_type_academia==2
gen g=0
replace g=1 if ea_career_type_government==2
gen h=0
replace h=1 if ea_career_type_advocacy==2
gen i=0
replace i=1 if career_other==1

gen plans=a+b+c+d+e+f+g+h+i

tab plans if ea_career_type_ea_org==2

tab plans if ea_career_type_etg==2




gen mix=.
replace mix=1 if ea_career_type_etg==2|ea_career_type_ea_org==2

foreach V of varlist member_ea_fb-member_gwwc{
   encode `V', generate(ddd)         // provided variable aaa is not part of the dataset
   drop `V'
   rename ddd `V'
}
encode ea_engaged_scale, gen(x)
codebook x
replace x=. if x==6
rename x engaged_scale
replace  member_gwwc=. if  member_gwwc==15
 logit eajob1 member_lw member_ea_forum member_ea_fb member_local_group  member_gwwc engaged_scale male1 white ,or robust
 
 gen member=0
replace member=1 if member_ea_fb =1|member_ea_forum =1|member_lw =1|member_local_group=1| member_none_of_the_above=1|member_other=1
 
gen lesswrong1=.
replace lesswrong1=0 if activity==1
replace lesswrong1=1 if member_lw ==1

 gen membership=0
replace membership=1 if member_ea_fb ==1|member_ea_forum ==1|member_lw ==1|member_local_group==1| member_none_of_the_above==1|member_other==1 |gwwc_member==1| gwwc_member==0
 
*LW
gen member_lw1=.
replace member_lw1=0 if membership==1
replace member_lw1=1 if member_lw ==1


*FORUM
gen member_forum1=.
replace member_forum1=0 if membership==1
replace member_forum1=1 if member_ea_forum==1
*LOCAL
gen member_local_group1=.
replace member_local_group1=0 if membership==1
replace member_local_group1=1 if member_local_group ==1
*FB
gen member_ea_fb1=.
replace member_ea_fb1=0 if membership==1
replace member_ea_fb1=1 if member_ea_fb ==1
*GWWC
gen gwwc_member1=.
replace gwwc_member1=0 if membership==1
replace gwwc_member1=1 if gwwc_member ==1
*NONE
 gen member_none1=.
replace member_none1=0 if membership==1
replace member_none1=1 if member_none_of_the_above ==1 & gwwc_member ==0

gen groups=forum+local+gwwc_member+lesswrong+facebook

replace groups=0 if member_none_of_the_above ==1 & gwwc_member ==0 & membership==1

tab member_lw1
tab member_forum1
tab member_local_group1
tab member_ea_fb1
tab gwwc_member1
tab member_none1
tab
 
drop nonmember
gen nonmember=.
replace nonmember=0 if membership==1
replace nonmember=1 if forum==0 &   facebook==0 &  lesswrong==0 &  local==0 & gwwc_member==0
tab nonmember
tabstat age1, by(nonmember) stat(mean median)
tab female nonmember, row nofreq
tab white nonmember, row nofreq
tab female nonmember, row nofreq

tabstat income_new, by(nonmember) stat(mean median)
tabstat income_new, by(facebook) stat(mean median)
tabstat income_new, by(forum) stat(mean median)
tabstat income_new, by(lesswrong) stat(mean median)
tabstat income_new, by(gwwc_member) stat(mean median)
tabstat income_new, by(local) stat(mean median)


replace lesswrong1=1 if member_lw ==1

tab female nonmember
 
. quietly fitstat, save

recode  member_ea_fb (2086=0 "no") (1=1 "Member"), gen(facebook)

recode member_ea_forum (2086=0 "no") (1=1 "Member"), gen(forum)

recode member_lw (2086=0 "no") (1=1 "Member"), gen(lesswrong)

recode member_local_group (2086=0 "no") (1=1 "Member"), gen(local)

recode member_gwwc (2086=0 "no") (1=1 "Member"), gen(gwwc_member)


recode veg (1210/1211=1 "vegan") (98 185=.) (.=.) (1207/1209=0 "meat"), gen(veg_c)

 logit eajobever engaged_scale lesswrong facebook forum local gwwc_member    age1 male1 poc  veg_c  ,or robust

 outreg2 using career.doc, addstat(Pseudo R2, e(r2_p))  word replace ctitle(Model 1.)

recode male1 (0=1 "female") (1=0 "male"), gen(female)
recode local (0=1 "non") (1=0 "member"), gen(nonlocal)
  logit eajob1 engaged_scale lesswrong facebook forum nonlocal gwwc_member    age1 female white  veg_c  ,or robust

 . fitstat, dif force

 
 logit eajob2 member_lw member_ea_forum member_ea_fb member_local_group  member_gwwc engaged_scale male race_white ,or robust

 
reg  member_lw member_ea_forum member_ea_fb member_local_group  member_gwwc  male1 white
USA, UK, Germ, AUs, Cana
 
recode country ( 730=1 "USA") ( 728=2 "UK") ( 693=3 "Germany") ( 675=4 "Australia") ( 681=5 "Canada") (98=.) (.=.) ( else=6 "Rest of the World") , gen(topcountry)

tab country experience_generalist_research, row nofreq
tab country  experience_management, row nofreq
tab country experience_government, row nofreq
tab country experience_operations, row nofreq
tab country experience_ml, row nofreq
tab country experience_ai_safety, row nofreq


tab topcountry experience_generalist_research
tab topcountry  experience_management 
tab topcountry experience_government
tab topcountry experience_operations
tab topcountry experience_ml
tab topcountry experience_ai_safety


codebook which_year_ea, tab(999)
recode which_year_ea (12 15=.) (2306=2009) (2307=2010) (2308=2011) (2309=2012) (2310=2013) (2311=2014) (2312=2015) (2313=2016) (2314=2017) (2315=2018) (2316=2019) (else=.) ,gen(yearjoined)




tab yearjoined experience_generalist_research if age1>=24, col nofreq
tab yearjoined  experience_management if age1>=24, col nofreq
tab yearjoined experience_government if age1>=24, col nofreq
tab yearjoined experience_operations if age1>=24, col nofreq
tab yearjoined experience_ml if age1>=24, col nofreq
tab yearjoined experience_ai_safety if age1>=24, col nofreq



tab yearjoined experience_generalist_research if age1>=24, row nofreq
tab yearjoined  experience_management if age1>=24, row nofreq
tab yearjoined experience_government if age1>=24, row nofreq
tab yearjoined experience_operations if age1>=24, row nofreq
tab yearjoined experience_ml if age1>=24, row nofreq
tab yearjoined experience_ai_safety if age1>=24, row nofreq


tab yearjoined experience_generalist_research if age1>=24
tab yearjoined  experience_management if age1>=24
tab yearjoined experience_government if age1>=24
tab yearjoined experience_operations if age1>=24
tab yearjoined experience_ml if age1>=24
tab yearjoined experience_ai_safety if age1>=24

gen applied=.
replace applied=0 if activity==1
replace applied=1 if activity_applied_ea_org_job==2


recode education (1325=1 "BA")  (1328=2 "MA")  (1326=3 "PhD")  (1324 1329=4 "Associate/Professional")  (1327 1331 1330=0 "No degree") (else=.)  ,gen(educ)
 
replace activity_applied_eag=. if activity_applied_eag==2
replace activity_applied_eag=2 if activity_applied_eag==3

replace activity_attended_eag=. if activity_attended_eag==2
replace activity_attended_eag=2 if activity_attended_eag==3

replace activity_read_ea_book=. if activity_read_ea_book==2
replace activity_read_ea_book=2 if activity_read_ea_book==3

replace activity_ea_forum_posted=. if activity_ea_forum_posted==2
replace activity_ea_forum_posted=2 if activity_ea_forum_posted==3

replace activity_ea_forum_commented=. if activity_ea_forum_commented==2
replace activity_ea_forum_commented=2 if activity_ea_forum_commented==3

replace activity_wrote_not_ea_forum=. if activity_wrote_not_ea_forum==2
replace activity_wrote_not_ea_forum=2 if activity_wrote_not_ea_forum==3

replace  activity_ea_fb=. if  activity_ea_fb==2
replace  activity_ea_fb=2 if  activity_ea_fb==3

replace activity_organized_ea_event=. if activity_organized_ea_event==2
replace activity_organized_ea_event=2 if activity_organized_ea_event==3

replace activity_ea_local_leader=. if activity_ea_local_leader==2
replace activity_ea_local_leader=2 if activity_ea_local_leader==3

replace  activity_applied_ea_org_job=. if  activity_applied_ea_org_job==2
replace  activity_applied_ea_org_job=2 if  activity_applied_ea_org_job==3

replace  activity_employed_ea_org =. if  activity_employed_ea_org ==2
replace  activity_employed_ea_org =2 if  activity_employed_ea_org ==3

replace activity_volunteer_ea_org=. if activity_volunteer_ea_org==2
replace activity_volunteer_ea_org=2 if activity_volunteer_ea_org==3

replace  activity_ea_plan_change=. if  activity_ea_plan_change==2
replace  activity_ea_plan_change=2 if  activity_ea_plan_change==3

replace  activity_ea_donate=. if  activity_ea_donate==2
replace  activity_ea_donate=2 if  activity_ea_donate==3

replace =. if ==
replace done_80k=2 if done_80k==3
replace k_coach_applied=2 if k_coach_applied==3



 recode top_case ( 920=1  "Animal")  ( 989=2  "poverty")  ( 1229=3  "LTF")  ( 1127=4  "Meta")  ( 1230=5  "Other")  (else=.) , gen(top_cause)
 tab top_cause, gen(forcedcause)
 rename forcedcause1 animalforce
 rename forcedcause2 povertyforce
 rename forcedcause3 ltfforce
  rename forcedcause4 metaforce
  
replace cause_import_climate_change_b=. if cause_import_climate_change_b==3 | cause_import_climate_change_b==4
replace cause_import_ai_b=. if cause_import_ai_b==3 | cause_import_ai_b==4
replace cause_import_poverty_b=. if cause_import_poverty_b==3 | cause_import_poverty_b==4

recode  cause_import_animal_welfare_b  (1=1) (2=2)(5=3)(6=4)(7=5) (else=.) ,gen(animal )
recode  v325  (1=1) (2=2)(5=3)(6=4)(7=5) (else=.) ,gen( prior)
recode   cause_import_biosecurity_b (1=1) (2=2)(5=3)(6=4)(7=5) (else=.) ,gen( bio)
recode  cause_import_climate_change_b  (1=1) (2=2)(5=3)(6=4)(7=5) (else=.) ,gen( climate)
recode  cause_import_nuclear_security_b (1=1) (2=2)(5=3)(6=4)(7=5) (else=.) ,gen( nuke)
recode cause_import_ai_b  (1=1) (2=2)(5=3)(6=4)(7=5) (else=.) ,gen(airisk )
recode  cause_import_mental_health_b  (1=1) (2=2)(5=3)(6=4)(7=5) (else=.) ,gen(mental )
recode cause_import_poverty_b  (1=1) (2=2)(5=3)(6=4)(7=5) (else=.) ,gen( poverty)
recode cause_import_rationality_b (1=1) (2=2)(5=3)(6=4)(7=5) (else=.) ,gen( rat)
recode   cause_import_meta_b (1=1) (2=2)(5=3)(6=4)(7=5) (else=.) ,gen(meta )
recode  cause_import_xrisk_other_b (1=1) (2=2)(5=3)(6=4)(7=5) (else=.) ,gen(xrisk )

 
  
  
 gen age12=age1^2
save "/Users/neildullaghan/Downloads/EAS_draft15.dta",replace
encode city2, gen(cx)
codebook cx, tab(999)
recode cx ( 23=1 "SF Bay Area") ( 9=2 "London") ( 16=3 "New York City") ( 4=4 "Boston") ( 20=5 "Oxford") ( 31=6 "Washington, DC") ( 26=7 "Sydney")  (.=.) (else=8 "other"),gen(cityx)

codebook politics, tab(999)

recode politics (1215=1 "Left") (1213=2 "Center Left") (1212=3 "Center") (1214=4 "Center Right") (1218=5 "Right") (1216=6 "Libertarian") (else=.), gen(pol)






use "/Users/neildullaghan/Downloads/EAS_draft15.dta",clear

gen city2=city_other

***Predicting Apply
gen income_lg=log(income_c)
tab topcountry,gen(state)
rename state1 usa
rename state2 uk
 
gen income2=income_c
replace income2=. if income_c==0
gen income2_lg=log(income2)
egen agebracket = cut(age1), group(5) label

egen incomebracket = cut(income_c), group(7) label
tab incomebracket applied, row chi2
gen income_c2=income_c^2
gen income_lg2=log(income_c2)

drop usa
gen usa=.
replace usa=0 if topcountry==2|topcountry==3|topcountry==4|topcountry==5|topcountry==6
replace usa=1 if topcountry==1

logit applied activity_attended_eag activity_ea_forum_posted activity_organized_ea_event activity_ea_local_leader  done_80k canexp income_lg usa lesswrong facebook forum local gwwc_member  female age1  poc BA MA PhD veg_c stud yearjoined fulltime retired , or robust
fitstat
outreg2 using eacareer.doc, addstat(Pseudo R2, e(r2_p) ,Log-Likelihood Full Model, e(ll)) word replace ctitle(Model 1)

logit jobapply activity_attended_eag activity_ea_forum_posted activity_organized_ea_event activity_ea_local_leader  done_80k canexp income_lg usa lesswrong facebook forum local gwwc_member  female age1  white BA MA PhD veg_c stud yearjoined fulltime retired , or robust
fitstat
outreg2 using eacareer.doc, addstat(Pseudo R2, e(r2_p) ,Log-Likelihood Full Model, e(ll)) word append ctitle(Model 2)

tab educ, gen(x)
rename x2 BA
rename x3 MA
rename x4 PhD



*******
share of EAs with experience
non-student?

************************************************************************************************************************************************
********


 ologit nps interest poverty airisk climate animal prior  female age1  white BA MA PhD veg_c stud yearsinea USA UK Europe , robust or

 ologit nps interest poverty airisk climate animal prior  female age1  white BA MA PhD veg_c stud yearsinea USA UK Europe , robust or


logit applied  female c.age1#c.age1  white educ veg_c stud yearjoined fulltime retired  canexp activity_attended_eag activity_ea_forum_posted activity_organized_ea_event activity_ea_local_leader  done_80k  income_lg usa, or robust





logit applied lesswrong facebook forum nonlocal gwwc_member     female c.age1#c.age1  white educ veg_c stud yearjoined fulltime retired  canexp activity_attended_eag activity_ea_forum_posted activity_organized_ea_event activity_ea_local_leader  done_80k  income_lg usa, or robust




logit applied1  female c.age1#c.age1  white educ veg_c stud yearjoined fulltime retired  canexp activity_attended_eag activity_ea_forum_posted activity_organized_ea_event activity_ea_local_leader  done_80k  income_lg usa, or robust

logit eajob1  female age1 white educ veg_c stud canexp activity_attended_eag activity_ea_forum_posted activity_organized_ea_event activity_ea_local_leader  done_80k  income_lg usa, or robust


margins, at(age1=(15(5)80)) atmeans
marginsplot

margins, dydx(female age1 white educ veg_c stud yearjoined fulltime retired canexp activity_attended_eag activity_ea_forum_posted activity_organized_ea_event activity_ea_local_leader  done_80k  income_c usa) post
marginsplot, horizontal recast(scatter) recastci(rspike) xline(0) xlabel(, grid) ylabel(, nogrid)

gen applied1=.
replace applied1=0 if applied==1
replace applied1=1 if applied==0
logit applied1  female c.age1#c.age1  white educ veg_c stud yearjoined fulltime retired  canexp activity_attended_eag activity_ea_forum_posted activity_organized_ea_event activity_ea_local_leader  done_80k  c.income_c#c.income_c usa, or robust


***Predicting work(ed) [if applied]
 prefer two models — one predicting “applied to EA job” and 
logit eajob1  female c.age1#c.age1  white educ veg_c stud yearjoined fulltime retired  canexp activity_attended_eag activity_ea_forum_posted activity_organized_ea_event activity_ea_local_leader  done_80k  income_lg usa, or robust
logit eajob1  applied female c.age1#c.age1  white educ veg_c stud yearjoined fulltime retired  canexp activity_attended_eag activity_ea_forum_posted activity_organized_ea_event activity_ea_local_leader  done_80k  income_lg usa, or robust

 gen jobapply=.
  replace jobapply=0 if applied==1
 replace jobapply=1 if eajob1==1 & applied==1
 
logit jobapply  female c.age1#c.age1  white educ veg_c stud yearjoined fulltime retired  canexp activity_attended_eag activity_ea_forum_posted activity_organized_ea_event activity_ea_local_leader  done_80k  income_lg usa, or robust



logit applied lesswrong facebook forum nonlocal gwwc_member     female c.age1#c.age1  white educ veg_c stud yearjoined fulltime retired  canexp activity_attended_eag activity_ea_forum_posted activity_organized_ea_event activity_ea_local_leader  done_80k  income_lg usa, or robust
logit applied1 lesswrong facebook forum nonlocal gwwc_member     female c.age1#c.age1  white educ veg_c stud yearjoined fulltime retired  canexp activity_attended_eag activity_ea_forum_posted activity_organized_ea_event activity_ea_local_leader  done_80k  income_lg usa, or robust

margins, at(age1=(15(5)80)) atmeans
marginsplot
logit jobapply lesswrong facebook forum nonlocal gwwc_member     female c.age1#c.age1  white educ veg_c stud yearjoined fulltime retired  canexp activity_attended_eag activity_ea_forum_posted activity_organized_ea_event activity_ea_local_leader  done_80k  income_lg usa, or robust
margins, at(yearjoined=(2009(1)2019)) atmeans
marginsplot


margins, at(age1=(15(5)80)) atmeans
marginsplot
gen  jobapply1=.
replace  jobapply1=0 if  jobapply==1
replace  jobapply1=1 if  jobapply==0

logit jobapply1 lesswrong facebook forum nonlocal gwwc_member     female c.age1#c.age1  white educ veg_c stud yearjoined fulltime retired  canexp activity_attended_eag activity_ea_forum_posted activity_organized_ea_event activity_ea_local_leader  done_80k  income_lg usa, or robust

 
 
 one predicting “have or had an EA job conditional on having applied”>own section

    
***COUNTRY

YEAR 

tab yearjoined topcountry 

tab top_cause topcountry, col nofreq

tab veg_c topcountry, col nofreq


tab topcountry female , row nofreq

tab topcountry local , row nofreq

tab topcountry forum , row nofreq

tab topcountry lesswrong , row nofreq

tab topcountry facebook , row nofreq

tab topcountry gwwc_member , row nofreq
***

tab topcountry career_type_ea_org , row nofreq

tab topcountry  career_type_etg , row nofreq

tab topcountry eajob1 , row nofreq

tab topcountry engaged_scale , row nofreq

tab engaged_scale topcountry , row nofreq

***REGION
tab yearjoined regions , row nofreq

tab top_cause regions, col nofreq

tab veg_c regions, col nofreq

tab veg_b regions, col nofreq

codebook veg
recode veg (1211=1 "vegetarian") (1210=2 "vegan")  (1207=3 "meat") (1208=4 "reduce") (1209 =5 "pescatarian") (else=.), gen(veg_d)
tab veg_d regions, col nofreq

tab regions female , chi2

tab regions local , row nofreq

tab regions forum , row nofreq

tab regions lesswrong , row nofreq

tab regions facebook , row nofreq

tab regions gwwc_member , row nofreq
***

tab regions career_type_ea_org , row nofreq

tab regions  career_type_etg , row nofreq

tab regions eajob1 , row nofreq

tab regions engaged_scale , row nofreq

tab engaged_scale regions , row nofreq
tab engaged_scale regions , col nofreq

****CITY



***REGION
tab yearjoined cityx , row nofreq

tab top_cause cityx, col nofreq

tab veg_c cityx, col nofreq

tab veg_b cityx, col nofreq

codebook veg
recode veg (1211=1 "vegetarian") (1210=2 "vegan")  (1207=3 "meat") (1208=4 "reduce") (1209 =5 "pescatarian") (else=.), gen(veg_d)
tab veg_d cityx, col nofreq

tab cityx female , chi2

tab cityx local , row nofreq

tab cityx forum , row nofreq

tab cityx lesswrong , row nofreq

tab cityx facebook , row nofreq

tab cityx gwwc_member , row nofreq
***

tab cityx career_type_ea_org , row nofreq

tab cityx  career_type_etg , row nofreq

tab cityx eajob1 , row nofreq

tab cityx engaged_scale , row nofreq

tab engaged_scale cityx , row nofreq


tab yearjoined cityx

tab yearjoined regions 

gen xc=regions
recode xc (1/3=1 "West") (4=0 "other"), gen(west)
replace west=1 if country==681
replace west=1 if country==675
replace west=1 if country==254
     
tab regions career_type_non_profit, row nofreq
tab regions career_type_non_etg_for_profi, row nofreq
tab regions  career_type_academia, row nofreq
tab regions career_type_government, row nofreq
tab regions career_type_advocacy, row nofreq


tab regions career_type_non_profit, col nofreq
tab regions career_type_non_etg_for_profi, col nofreq
tab regions  career_type_academia, col nofreq
tab regions career_type_government, col nofreq
tab regions career_type_advocacy, col nofreq


tab cityx career_type_etg, row nofreq
tab cityx career_type_ea_org, row nofreq
tab cityx career_type_non_profit, row nofreq
tab cityx career_type_non_etg_for_profi, row nofreq
tab cityx  career_type_academia, row nofreq
tab cityx career_type_government, row nofreq
tab cityx career_type_advocacy, row nofreq

tab top_cause cityx, col nofreq


tabstat animal, by(regions) stat(mean)
tabstat prior, by(regions) stat(mean)
tabstat bio, by(regions) stat(mean )
tabstat nuke, by(regions) stat(mean )
tabstat climate, by(regions) stat(mean )
tabstat airisk, by(regions) stat(mean )
tabstat mental, by(regions) stat(mean )
tabstat poverty, by(regions) stat(mean )
tabstat rat, by(regions) stat(mean )
tabstat meta, by(regions) stat(mean )
tabstat xrisk, by(regions) stat(mean )


tabstat animal, by(cityx) stat(mean)
tabstat prior, by(cityx) stat(mean)
tabstat bio, by(cityx) stat(mean )
tabstat nuke, by(cityx) stat(mean )
tabstat climate, by(cityx) stat(mean )
tabstat airisk, by(cityx) stat(mean )
tabstat mental, by(cityx) stat(mean )
tabstat poverty, by(cityx) stat(mean )
tabstat rat, by(cityx) stat(mean )
tabstat meta, by(cityx) stat(mean )
tabstat xrisk, by(cityx) stat(mean )


tabstat poverty climate airisk prior animal rat xrisk meta bio mental nuke, by(anzac) stat(mean )

tabstat climate, by(anzac) stat(mean )
tabstat airisk, by(anzac) stat(mean )
tabstat prior, by(anzac) stat(mean)
tabstat animal, by(anzac) stat(mean)
tabstat rat, by(anzac) stat(mean )
tabstat xrisk, by(anzac) stat(mean )
tabstat meta, by(anzac) stat(mean )
tabstat bio, by(anzac) stat(mean )
tabstat mental, by(anzac) stat(mean )
tabstat nuke, by(anzac) stat(mean )









. use "/Users/neildullaghan/Downloads/FinalSurvey1.dta", clear
codebook country, tab(999)
recode country (15=1 "USA") (14=2 "UK") (10=3 "Germany") (9=4 "Canadaa") (8=5 "Australia") (4 11/13=6 "Other") (else=.), gen(topcountry)
tab eayear topcountry

use "/Users/neildullaghan/Downloads/EAS_draft15.dta",clear

tab regions, gen(i)
rename i1 USA
rename i2 UK
rename i3 Europe

save "/Users/neildullaghan/Downloads/EAS_draft16.dta",replace

use "/Users/neildullaghan/Downloads/EAS_draft16.dta",clear
gen rdon=realdonation
replace rdon=. if realdonation==0
tabstat donate_new, stat(mean median)


codebook country, tab(999)
recode country (730=1 "USA") (728=2 "UK") (676/678 685 686 689 691/695 697 699 702 704 705 708 710 715 716 718 719 721 723 724 725= 3 "other Europe") (98=.) (else=4 "other"), gen(regions)
tab regions
UK, USA, Other Europe, Rest
London/Oxbridge, Bay Area, Other Europe, Rest

***COMMUNTIY

**RECODE
recode ea_community_excitement  (194=1) (196=2) (197=3) (198=4) (199=5) (200=6) (201=7) (202=8) (203=9) (195=10) (else=.),gen(nps)
recode ea_interest_change (187=1) (188=2) (189=3) (190=4) (191=5) (192=6) (193=7) (else=.)    ,gen(interest)

replace animal=0 if animal==.
replace prior=0 if prior==.
replace bio=0 if bio==.
replace climate=0 if climate==.
replace nuke=0 if nuke==.
replace airisk=0 if airisk==.
replace mental=0 if mental==.
replace poverty=0 if poverty==.
replace rat=0 if rat==.
replace meta=0 if meta==.
replace xrisk=0 if xrisk==.
         
gen c1=0
gen c2=0	
gen c3=0
gen c4=0
gen c5=0
gen c6=0
gen c7=0
gen c8=0
gen c9=0
gen c10=0
gen c11=0
		 
		  
replace c1=1 if animal>=1
replace c2=1 if  prior>=1		
replace  c3=1 if bio>=1		
replace  c4=1 if climate>=1		
replace  c5=1 if nuke>=1		
replace  c6=1 if airisk >=1		
replace  c7=1 if mental>=1		
replace  c8=1 if poverty>=1		
replace  c9=1 if rat >=1		
replace  c10=1 if meta >=1		
replace  c11=1 if xrisk      >=1		  
		  
gen totcause= (c1 + c2 + c3 + c4 + c5 + c6 + c7 + c8 + c9 + c10 + c11)
		  
		  
gen meancause=(animal + prior + bio + climate + nuke + airisk + mental + poverty + rat + meta + xrisk)/totcause

**MODELS FOR NET PROMOTER SCORE
 ologit nps animal prior bio climate nuke airisk mental poverty rat meta xrisk engaged_scale  lesswrong facebook forum local gwwc_member    female age1  white BA MA PhD veg_c stud yearsinea USA UK Europe , robust or
 outreg2 using nps.doc, addstat(Pseudo R2, e(r2_p))  word replace ctitle(Net Promoter Score.)
 
  ologit nps  meancause engaged_scale  lesswrong facebook forum local gwwc_member   female age1  white BA MA PhD veg_c stud yearsinea USA UK Europe , robust or
 outreg2 using nps.doc, addstat(Pseudo R2, e(r2_p))  word append ctitle(Net Promoter Score.)
 
  ologit interest animal prior bio climate nuke airisk mental poverty rat meta xrisk engaged_scale  lesswrong facebook forum local gwwc_member    female age1  white BA MA PhD veg_c stud yearsinea USA UK Europe , robust or
 outreg2 using nps.doc, addstat(Pseudo R2, e(r2_p))  word append ctitle(Interest Change in EA.)
 
  ologit interest  meancause engaged_scale  lesswrong facebook forum local gwwc_member  female age1  white BA MA PhD veg_c stud yearsinea USA UK Europe , robust or
 outreg2 using nps.doc, addstat(Pseudo R2, e(r2_p))  word append ctitle(Interest Change in EA.)
 
*reverse years, UK, Age

 
 


ologit nps interest  lesswrong facebook forum local gwwc_member     female age1  white BA MA PhD veg_c stud yearsinea, robust or

 outreg2 using nps.doc, addstat(Pseudo R2, e(r2_p))  word replace ctitle(Model 1.)
 
 ologit nps  lesswrong facebook forum local gwwc_member     female age1  white i.educ veg_c stud yearsinea, robust or
 outreg2 using nps.doc, addstat(Pseudo R2, e(r2_p))  word append ctitle(Model 2.)
 
 ologit nps engaged_scale  lesswrong facebook forum local gwwc_member     female age1  white i.educ veg_c stud yearsinea, robust or
 outreg2 using nps.doc, addstat(Pseudo R2, e(r2_p))  word append ctitle(Model 3.)
 

 
ologit  interest  lesswrong facebook forum local gwwc_member     female age1  white i.educ veg_c stud yearsinea, robust or
 outreg2 using interest.doc, addstat(Pseudo R2, e(r2_p))  word replace ctitle(Model 1.)
 
 ologit nps  lesswrong facebook forum local gwwc_member     female age1  white i.educ veg_c stud yearsinea, robust or
 
 outreg2 using nps.doc, addstat(Pseudo R2, e(r2_p))  word append ctitle(Model 2.)
 
 ologit interest  engaged_scale  lesswrong facebook forum local gwwc_member     female age1  white i.educ veg_c stud yearsinea, robust or
 outreg2 using interest.doc, addstat(Pseudo R2, e(r2_p))  word append ctitle(Model 3.)
 
 
  ologit interest  engaged_scale  lesswrong facebook forum local gwwc_member     female age1  white i.educ veg_c stud yearsinea, robust or
 


. quietly fitstat, save
ologit  interest  lesswrong facebook forum local gwwc_member     female age1  white i.educ veg_c stud yearsinea, robust or
 
. fitstat, dif force

 
gen yearsinea = 2019-yearjoined


drop if yearsinea==0
tabstat donate_new, stat(sum mean median min max)

sum donate_new, detail

gen donate_log=log(donate_new)

save "/Users/neildullaghan/Downloads/EAS_draft17.dta",replace

use "/Users/neildullaghan/Downloads/EAS_draft17.dta",clear

replace donate_new=0 if donation==0

centile (donate_new), centile (10 20 30 40 50 60 70 80 90 91 92 93 94 95 96 97 98 99)
gen levels=.
. replace levels=1 if donate_new<=1000
replace levels=2 if donate_new>1000
 replace levels=3 if donate_new>10000
  replace levels=4 if donate_new>=100000
 replace levels=. if donate_new==.
 tab levels

  tabstat donate_new, by(levels) stat(sum)
  dis 227578.4/1.61e+07
  dis  2257913/1.61e+07
  dis 4475384/1.61e+07
  dis 9136155/1.61e+07
  
gen donate_log10=log10(donate_new)

save "/Users/neildullaghan/Downloads/EAS_draft19.dta",replace


use "/Users/neildullaghan/Downloads/EAS_draft19.dta",clear

rename student xx
rename stud student
rename xx student_string


encode city_all, gen(cx)
codebook cx, tab(999)
recode cx ( 265=1 "SF Bay Area") (172=2 "London") ( 210=3 "New York City") ( 44=4 "Boston") ( 231=5 "Oxford") ( 335=6 "Washington, DC") ( 301=7 "Sydney")  (.=.) (else=8 "other"),gen(cityx)


**save "/Users/neildullaghan/Downloads/EAS_currency1.dta",replace


use "/Users/neildullaghan/Downloads/EAS_currency1.dta",clear

tab first_heard_ea if engaged_scale==4|engaged_scale==5
tab forum cityx

tab forum
tab facebook
tab lesswrong
tab gwwc_member
tab local
tab TLYCS
tab facebook

tab forum facebook

tab facebook local

tab forum female
tab lesswrong female
tab gwwc_member female
tab local female
tab TLYCS female
tab facebook female









tabstat income_new, by(engaged_scale) stat(median)
tabstat age1, by(engaged_scale) stat(median)
 tab engaged_scale student , row nofreq 

tabstat income_new if donate_new!=., by(engaged_scale) stat(median)
tabstat age1 if donate_new!=., by(engaged_scale) stat(median)
 tab engaged_scale student if donate_new!=., row nofreq 


tabstat donate_new, by(regions) stat(median sum mean n)
tabstat plandote_new,  stat(min max mean median sum n)


tabstat plandote_new if fullst==1,   stat(min max mean median sum n)



**ANZAC
254  New Zealand
675  Australia
 720  Singapore
 
recode country (254=1 "NZ") (675=2 "Australia") (720=3 "Singapore") (else=.), gen(anzac)
 
tab yearsinea anzac

tab engaged_scale anzac

tab lesswrong anzac

tab forum anzac

tab facebook anzac

tab local anzac

tab gwwc_member anzac

       


tab career_type_ea_org anzac

tab career_type_ea_org anzac

tab career_type_etg anzac

tab career_type_non_profit anzac

tab career_type_non_etg_for_profi anzac

tab career_type_academia anzac

tab career_type_government anzac

tab career_type_advocacy anzac

tab eajobexp anzac

tab politics anzac

tab female anzac

tab veg anzac

tab top_cause anzac

tab anzac

***Engagement by groups
activity_applied_eag 
activity_attended_eag 
activity_read_ea_book 
activity_ea_forum_posted 
activity_ea_forum_commented 
activity_wrote_not_ea_forum 
activity_ea_fb 
activity_organized_ea_event 
activity_ea_local_leader 
activity_applied_ea_org_job 
activity_employed_ea_org 
activity_volunteer_ea_org 
activity_ea_plan_change 
activity_ea_donate




tab yearsinea ac


*gen biinary donate
gen donate=.
replace donate=1 if donate_new>0
replace donate=0 if donate_new<=0


logit donate income_new gwwc_member student yearsinea engaged_scale female age1 career_type_etg, robust or

tabstat donate_new, by(regions) stat(mean p50 sum n var)

tabstat income_new, by(regions) stat(mean p50 sum n var)

tabstat donate_new, by(cx) stat(mean p50 sum n var)

tabstat income_new, by(cx) stat(mean p50 sum n var)

tabstat donate_new, by(cityx) stat(mean p50 sum var)

tabstat income_new, by(cityx) stat(mean p50 sum var)

tabstat donate_new, by(city2)


tabstat donate_new if student==1, by(engaged_scale) stat(mean p50 sum n var)

tabstat income_new, by(eajobexp) stat(mean p50 sum n var)
***REGRESSION
reg donate_new income_new student gwwc_member yearsinea age1, robust
reg donate_log10 c.income_log10##i.gwwc_member student  yearsinea, robust




          
replace rc_2018_c=. if rc_2018_c==0

replace  ea_fund_meta_2018_c=. if ea_fund_meta_2018_c==0

replace ea_fund_animal_welfare_2018_c=. if ea_fund_animal_welfare_2018_c==0

replace   ea_fund_ltf_2018_c=. if  ea_fund_ltf_2018_c ==0

replace ea_fund_global_health_2018_c =. if ea_fund_global_health_2018_c ==0

replace k_2018_c cfar_2018_c =. if k_2018_c cfar_2018_c==0

replace miri_2018_c=. if miri_2018_c==0
replace  gf_2018_c=. if  gf_2018_c==0
replace ace_2018_c=. if ace_2018_c==0
replace mfa_2018_c =. if mfa_2018_c==0
replace cea_2018_c=. if cea_2018_c==0
replace dtw_2018_c=. if dtw_2018_c==0
replace gw_2018_c=. if gw_2018_c==0
replace sci_2018_c=. if sci_2018_c==0
replace gd_2018_c=. if gd_2018_c==0
replace ef_2018_c=. if ef_2018_c==0
replace thl_2018_c=. if thl_2018_c==0
replace amf_2018_c=. if amf_2018_c==0
replace =. if ==0

replace donate_cause_meta_2018_c=. if donate_cause_meta_2018_c==0
replace donate_cause_cause_pri_2018_c=. if donate_cause_cause_pri_2018_c==0
replace donate_cause_poverty_2018_c=. if donate_cause_poverty_2018_c==0
replace donate_cause_animal_welfare_2018 =. if donate_cause_animal_welfare_2018 ==0
replace donate_cause_far_future_2018_c=. if donate_cause_far_future_2018_c==0

tabstat rc_2018_c ea_fund_meta_2018_c ea_fund_animal_welfare_2018_c ea_fund_ltf_2018_c ea_fund_global_health_2018_c k_2018_c cfar_2018_c miri_2018_c gf_2018_c ace_2018_c mfa_2018_c cea_2018_c dtw_2018_c gw_2018_c sci_2018_c gd_2018_c ef_2018_c thl_2018_c amf_2018_c, stat(sum mean p50 n)

tabstat donate_cause_meta_2018_c donate_cause_cause_pri_2018_c donate_cause_poverty_2018_c donate_cause_animal_welfare_2018 donate_cause_far_future_2018_c, stat(sum mean median)


gen income_log10=log10(income_new)
gen percent1= (donate_new/income_new)*100
replace percent1=100 if percent1>=100

tabstat donate_new, by(stud) stat(mean median sum)
tabstat percent1, by(stud) stat(mean media)

gen fullst=0
replace fullst=1 if fulltime==1 & student==1
tabstat donate_new, by(fullst) stat(mean median sum n)

tabstat donate_new, by(gwwc_member) stat(mean p50 sum)


tabstat donate_new, by(yearsinea) stat(mean p50 sum)

reg donate_new income_new stud gwwc_member yearsinea age1, robust
reg donate_log10 income_log10 stud gwwc_member yearsinea age1, robust
reg donate_new income_new  engaged_scale  lesswrong facebook forum local gwwc_member  female age1  white BA MA PhD veg_c stud yearsinea USA UK Europe , robust 
 
tab career_type_etg engaged_scale if student==1, col nofreq chi2

tab student engaged_scale if student==1, col nofreq


gen firstheard=.
tab first_heard_ea, gen(heard)
rename heard1 heard_eighty
rename heard2 heard_ace
rename heard3 heard_blog
rename heard4 heard_book
rename heard5 heard_eag
rename heard6 heard_eagx
rename heard7 heard_edu
rename heard8 heard_fb
rename heard9 heard_gw
rename heard10 heard_gwwc
rename heard11 heard_remember
rename heard12 heard_lw
rename heard13 heard_local
rename heard15 heard_oftw
rename heard16 heard_other
rename heard17 heard_personal
rename heard18 heard_podcast
rename heard19 heard_swiss
rename heard20 heard_search
rename heard21 heard_ssc
rename heard22 heard_ted
rename heard23 heard_tlycs
rename heard24 heard_vox

ologit engaged_scale yearsinea heard_eighty heard_ace heard_gw  heard_tlycs heard_oftw   heard_swiss   heard_ssc    heard_ted heard_blog heard_book   heard_vox heard_podcast  heard_fb   heard_gwwc    heard_lw     heard_local  heard_eag  heard_eagx heard_edu heard_search heard_personal heard_other , or

outreg2 using firstheard.doc, addstat(Pseudo R2, e(r2_p))  word replace ctitle(Engaged Scale.)
 
tab first_heard_ea, gen(heard)


 
 
use "/Users/neildullaghan/Downloads/EAS_currency1.dta",clear

gen tri=0
**E2G non students 
replace tri=1 if student==1 & career_type_etg==1 & employed_full_time==2
**GWWC non E2G  
replace tri=2 if gwwc_member==1  & career_type_etg==0
**Other

recode tri (1=1 "FT E2G non students") (2=2 "non E2G GWWC") (0=0 "other"), gen(givers)

tabstat donate_new, by(givers) stat(sum  n)
membership & age

tabstat age1, by( forum ) stat(mean median)
tabstat age1, by( lesswrong ) stat(mean median)
tabstat age1, by( facebook ) stat(mean median)
tabstat age1, by(  local ) stat(mean median)
tabstat age1, by(  gwwc_member) stat(mean median)
tabstat age1, by( forum lesswrong facebook local gwwc_member) stat(mean median)


membership & white
membership & income


activity & age
activity & white
activity  & income

m(formula = donate_new ~ income_new + yearsinea + age1 + student + 
    gwwc_member + income_new:age1 + income_new:student + income_new:gwwc_member + 
    yearsinea:age1 + yearsinea:gwwc_member, data = EAStn, na.action = na.exclude)
	
reg donate_new  income_new yearsinea  age1  student  gwwc_member c.income_new#c.age1 c.income_new#i.student c.income_new#i.gwwc_member  i.yearsinea#c.age1 i.yearsinea#i.gwwc_member


*****************
drop if donate_new==.
drop if income_new==.

gen percent1= (donate_new/income_new)*100
drop if percent1==.
replace percent1=100 if percent1>=100

tabstat percent1, by(cityx) stat(mean p50 n)
tabstat percent1, by(cx) stat(mean p50 n)
tabstat percent1, by(engaged_scale) stat(mean p50 sum n var)
tabstat percent1, by(student) stat(p50)

drop if income_new <10000
 tabstat percent1,  stat(mean p50 sum n var)
 tabstat percent1, by(fullst) stat(mean median sum n)
 tabstat percent1, by(fullst) stat(median)
save "/Users/neildullaghan/Downloads/EAS_percent.dta",replace
use "/Users/neildullaghan/Downloads/EAS_percent.dta",clear



tabstat percent1, by(fullst) stat(mean median sum n)
centile (percent1) if fullst==1, centile (10 20 30 40 50 60 70 75 76 77 78 79 80 90 91 92 93 94 95 96 97 98 99)

tabstat percent1, by(gwwc_member) stat(mean median sum n)

drop if donate_new<1
drop if income_new<1



save "/Users/neildullaghan/Downloads/EAS_dropped1.dta",replace
use "/Users/neildullaghan/Downloads/EAS_dropped1.dta",clear



gen income_log10=log10(income_new)

tabstat percent1, stat(mean median min max)
centile (percent1), centile (10 20 30 40 50 60 70 80 90 91 92 93 94 95 96 97 98 99)

sort donate_new
gen cum=sum(donate_new)
. line cum donate_log10, connect(stepstair ) ylab(, grid) ytitle("Cumulative sum") xtitle("$ donated") xlab(, grid)title("Cumulative of Donations") graphregion(color(white)) bgcolor(white)

tabstat percent1, by(yearsinea) stat(mean p50 n)

use "/Users/neildullaghan/Downloads/EAS_draft17.dta",clear
replace  donate_log10=. if  donate_new<=1
replace  donate_new=. if  donate_new<=.5
save "/Users/neildullaghan/Downloads/EAS_draft18.dta",replace


save "/Users/neildullaghan/Downloads/bubble19.dta",replace



u
