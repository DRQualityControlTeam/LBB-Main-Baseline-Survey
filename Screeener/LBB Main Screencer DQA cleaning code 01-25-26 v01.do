******************************************* LBB  SCREENER SURVEY*************************************************************
*************************************************************************
*************************************************************************
cls
clear all
cd "C:\Users\oyoo\OneDrive - Dalberg Global Development Advisors\QUALITY CONTROL\Projects\2026\Projects\UNICEF LBB\Screener\Data\Raw"

***import dataset

import spss using "UNICEF LBB School Screening Tool_WIDE.sav", clear

*************************************************************************
*dropping irrelevant variables
drop SubmissionDate	starttime	endtime	deviceid	devicephonenum	username	device_info	duration	caseid	password formdef_version Enum_calc instanceID

*Order
order KEY

*************************************************************************
*Formating date
gen INT_DATE1 = dofc(INT_DATE)
format INT_DATE1 %td

drop INT_DATE
ren INT_DATE1 INT_DATE

order INT_DATE, after(KEY)
lab var INT_DATE"Date of interview"

*filter out test data
drop if inlist(KEY,"uuid:0b2582be-85ae-42f3-af21-51e40e7b6a80","uuid:c5cb315b-300c-49e2-b2fe-642efccd2364","uuid:954a1ec5-87e3-41cc-ae04-ab8c95c99cd9","uuid:e791814c-f33b-425b-b644-ea49d22d59c7","uuid:178f1ffe-094a-4dbe-984f-c8d8ebc5cf0b","uuid:0f891142-3e72-48b6-acd6-04b3036d90ab","uuid:7118bd91-018a-4f4f-9d48-57cc6cea9a89")

drop if inlist(KEY,"uuid:f562efe3-a63a-4526-bfc8-39f85606b4a3","uuid:8b54d892-a569-4b0f-a260-f9ffe04f6085")

*Success - Attrion rate
gen call_trials = !missing(Q_1) + !missing(Q_3) + !missing(Q_5)

gen success_rate = 1

replace success_rate = 0 if call_trials == 0 | (call_trials == 3 & Q_5 == 0)

replace success_rate = 0 if Q_1 == 0 & Q_3 == .

replace success_rate = 2 if success_rate == 1 & Consent == 0

order call_trials success_rate, after(Q_6s)

lab var success_rate"Did the respondent accept the call"
lab var call_trials"How many round of calls were made"

lab define succ 1"Call accepted" 0 "Declined" 2"Call accepted but declined to be interviewed"

lab values success_rate succ

*B2_dropp calc
egen B2_screener = rowtotal(B2_1 B2_2 B2_3 B2_4)
order B2_screener,after(B2_4)

lab define labels9 286"Joy Primary",modify
replace A2 = 286 if KEY == "uuid:f6c59d98-1ec9-4c5c-a390-3c56c18acd01"
lab values A2 labels9

replace A2 = 21 if KEY == "uuid:baa17416-1ccf-4a51-a61d-9769c580d1f1"
replace A2_S = "" if KEY == "uuid:baa17416-1ccf-4a51-a61d-9769c580d1f1"

lab define labels12 286"0792649023" 287"0710246705" 288"0725426919" 289"0719583515" 290"0725503700" 291"0720004017" 292"0729612435" 293"0711572941" 294"0724432326" 295"0727856531",modify
replace RESP_PHONE = 286 if KEY == "uuid:f6c59d98-1ec9-4c5c-a390-3c56c18acd01"
replace RESP_PHONE = 287 if KEY == "uuid:baa17416-1ccf-4a51-a61d-9769c580d1f1"
replace RESP_PHONE = 288 if KEY == "uuid:41588f5f-1462-4aba-9de8-718b8b29472c"
replace RESP_PHONE = 289 if KEY == "uuid:2b9c0ab6-3161-4dd2-8c26-25c90cec0a36"
replace RESP_PHONE = 290 if KEY == "uuid:d3246c2a-5f89-45b6-8ce8-ddca3e9a3aa7"
replace RESP_PHONE = 291 if KEY == "uuid:e4d77f83-eabf-47a9-a0c2-6f7d8d298092"
replace RESP_PHONE = 292 if KEY == "uuid:29bab29e-f16d-418d-a1a0-39b5928b2060"
replace RESP_PHONE = 293 if KEY == "uuid:261f64c3-8632-43ec-9425-bd5afce952bb"
replace RESP_PHONE = 294 if KEY == "uuid:7d59cc2d-0160-498f-a8bc-fbdcb88c40d5"
replace RESP_PHONE = 295 if KEY == "uuid:5adbdf0d-67a7-4ec5-9f47-bb549bf84349"

lab values RESP_PHONE labels12

lab define labels11 286"Wycliffe nyaundi" 287"Peter Taraiya Koisikir" 288"Agnes Nzomo" 289"Mr Michael Charo" 290"Patience Mnengwa" 291"Veronica lokidongi" 292"kelvin kakai wasike" 293 "Madam Zeinab Mohamud" 294"Caroline wanjiru" 295"Madam Nuria Mbarak",modify
replace A3 = 286 if KEY == "uuid:f6c59d98-1ec9-4c5c-a390-3c56c18acd01"
replace A3 = 287 if KEY == "uuid:baa17416-1ccf-4a51-a61d-9769c580d1f1"
replace A3 = 288 if KEY == "uuid:41588f5f-1462-4aba-9de8-718b8b29472c"
replace A3 = 289 if KEY == "uuid:2b9c0ab6-3161-4dd2-8c26-25c90cec0a36"
replace A3 = 290 if KEY == "uuid:d3246c2a-5f89-45b6-8ce8-ddca3e9a3aa7"
replace A3 = 291 if KEY == "uuid:e4d77f83-eabf-47a9-a0c2-6f7d8d298092"
replace A3 = 292 if KEY == "uuid:29bab29e-f16d-418d-a1a0-39b5928b2060"
replace A3 = 293 if KEY == "uuid:261f64c3-8632-43ec-9425-bd5afce952bb"
replace A3 = 294 if KEY == "uuid:7d59cc2d-0160-498f-a8bc-fbdcb88c40d5"
replace A3 = 295 if KEY == "uuid:5adbdf0d-67a7-4ec5-9f47-bb549bf84349"
lab values A3 labels11

drop if KEY == "uuid:f5a283cf-b7a3-4afe-aa3e-323a485d525e"
drop if KEY == "uuid:6fab0f2a-a96e-4fe7-8f51-5d9a506c3ea4"

*correction
replace A1 = "Mandera North" if A1 == "20"
replace A1 = "Wajir South" if A1 == "27"
replace A1 = "Tarbaj" if A1 == "28"

*save date before dropping
save "UNICEF LBB School Screening Tool_Unfiltered.dta",replace

*Drop interviews who Did not pick calls completely
drop if Q_2 == 6

*Drop interviews who No === consent
drop if Consent == 0

*Drop School that have never enrolled learners with VI
drop if A6 == 2

*Drop B2 == 0
drop if B2_screener == 0

*Lab files
lab var B1_1"B1.1.What is the total number of pupils currently enrolled:PP2"
lab var B1_2"B1.2.What is the total number of pupils currently enrolled:Grade 1"
lab var B1_3"B1.3.What is the total number of pupils currently enrolled:Grade 3"
lab var B1_4"B1.4.What is the total number of pupils currently enrolled:Grade 4"

lab var B2_1"B2.1.Out of these, how many have visual impairments:PP2"
lab var B2_2"B2.2.Out of these, how many have visual impairments:Grade 1"
lab var B2_3"B2.3.Out of these, how many have visual impairments:Grade 3"
lab var B2_4"B2.4.Out of these, how many have visual impairments:Grade 4"

lab var B5_1"B5.1.Number of teachers who teach in each of these classes:PP2"
lab var B5_2"B5.2.Number of teachers who teach in each of these classes:Grade 1"
lab var B5_3"B5.3.Number of teachers who teach in each of these classes:Grade 3"
lab var B5_4"B5.4.Number of teachers who teach in each of these classes:Grade 4"

lab var C1_1a"C1.1a.In the most recent 2025 Grade 3 assessment,how many learners did the end of year assessment:English"
lab var C1_1b"C1.1b.In the most recent 2025 Grade 3 assessment,how many learners did the end of year assessment:Kiswahili"
lab var C1_1c"C1.1c.In the most recent 2025 Grade 3 assessment,how many learners did the end of year assessment:Mathematics"

lab var C1_a"C1.a.Of those learners, how many met the expected competency level:English"
lab var C1_b"C1.b.Of those learners, how many met the expected competency level:Kiswahili"
lab var C1_c"C1.c.Of those learners, how many met the expected competency level:Mathematics"

*Correction for school respondent detail
recode A5 (3=1) // recorder Regular special unit to Special school

gen sum_G1_G2 = B2_2 + B2_3
gen sum_PP2_G1_G2 = B2_1 + B2_2 + B2_3
replace sum_G1_G2 = 0 if sum_G1_G2 == .
replace sum_PP2_G1_G2 = 0 if sum_PP2_G1_G2 == .
lab var sum_G1_G2"Sum of VIs in the G1 + G2"
lab var sum_PP2_G1_G2"Sum of VIs in the PP2 + G1 + G2"

gen plus_7_VIs_G1_G2 = .
lab var plus_7_VIs_G1_G2"7+ VIs in the G1 + G2"
replace plus_7_VIs_G1_G2 = 1 if sum_G1_G2 >=7 & !missing(sum_G1_G2)
replace plus_7_VIs_G1_G2 = 0 if sum_G1_G2 < 7 & !missing(sum_G1_G2)

gen plus_6_VIs_G1_G2 = .
lab var plus_6_VIs_G1_G2"6+ VIs in the G1 + G2"
replace plus_6_VIs_G1_G2 = 1 if sum_G1_G2 >=6 & !missing(sum_G1_G2)
replace plus_6_VIs_G1_G2 = 0 if sum_G1_G2 < 6 & !missing(sum_G1_G2)

gen plus_5_VIs_G1_G2 = .
lab var plus_5_VIs_G1_G2"6+ VIs in the G1 + G2"
replace plus_5_VIs_G1_G2 = 1 if sum_G1_G2 >=5 & !missing(sum_G1_G2)
replace plus_5_VIs_G1_G2 = 0 if sum_G1_G2 < 5 & !missing(sum_G1_G2)

*Treatment breakdown
fre A2 if A5_1 == 1 & sum_G1_G2 >= 7 & !missing(sum_G1_G2) //7+ VI students in G1+G2

fre A2 if A5_1 == 1 & sum_G1_G2 < 7 //Schools with less than 7 VI IN G1+G2

fre A2 if A5_1 == 1 & sum_G1_G2 < 7 & sum_PP2_G1_G2 >= 7 //Schools with less than 7 VI IN G1+G2 but 7+ In PP2+G1+G2

fre A2 if A5_1 == 1 & sum_G1_G2 < 7 & sum_G1_G2 >= 6 //Schools with less than 7 VI IN G1+G2 but 6+ VI's in G1+G2

fre A2 if A5_1 == 1 & sum_G1_G2 < 7 & sum_PP2_G1_G2 >= 6 //Schools with less than 7 VI IN G1+G2 but 6+ VI's in PP2+G1+G2

fre A2 if A5_1 == 1 & sum_G1_G2 < 7 & sum_G1_G2 >= 5 //Schools with less than 7 VI IN G1+G2 but 5+ VI's in G1+G2

fre A2 if A5_1 == 1 & sum_G1_G2 < 7 & sum_PP2_G1_G2 >= 5 //Schools with less than 7 VI IN G1+G2 but 5+ VI's in PP2+G1+G2

//Valid treatment schools breakdown by the school type
fre A5 if A5_1 == 1 & sum_G1_G2 >= 7 & !missing(sum_G1_G2) //7+ VI students in G1+G2

fre A5 if A5_1 == 1 & sum_G1_G2 >= 6 & !missing(sum_G1_G2) //7+ VI students in G1+G2

fre A5 if A5_1 == 1 & sum_G1_G2 >= 5 & !missing(sum_G1_G2) //7+ VI students in G1+G2

*Control breakdown
fre A2 if A5_1 == 2 & sum_G1_G2 >= 7 & !missing(sum_G1_G2) //7+ VI students in G1+G2

fre A2 if A5_1 == 2 & sum_G1_G2 < 7 //Schools with less than 7 VI IN G1+G2

fre A2 if A5_1 == 2 & sum_G1_G2 < 7 & sum_PP2_G1_G2 >= 7 //Schools with less than 7 VI IN G1+G2 but 7+ In PP2+G1+G2

fre A2 if A5_1 == 2 & sum_G1_G2 < 7 & sum_G1_G2 >= 6 //Schools with less than 7 VI IN G1+G2 but 6+ VI's in G1+G2

fre A2 if A5_1 == 2 & sum_G1_G2 < 7 & sum_PP2_G1_G2 >= 6 //Schools with less than 7 VI IN G1+G2 but 6+ VI's in PP2+G1+G2

fre A2 if A5_1 == 2 & sum_G1_G2 < 7 & sum_G1_G2 >= 5 //Schools with less than 7 VI IN G1+G2 but 5+ VI's in G1+G2

fre A2 if A5_1 == 2 & sum_G1_G2 < 7 & sum_PP2_G1_G2 >= 5 //Schools with less than 7 VI IN G1+G2 but 5+ VI's in PP2+G1+G2

//Valid treatment schools breakdown by the school type
fre A5 if A5_1 == 2 & sum_G1_G2 >= 7 & !missing(sum_G1_G2) //7+ VI students in G1+G2

fre A5 if A5_1 == 2 & sum_G1_G2 >= 6 & !missing(sum_G1_G2) //7+ VI students in G1+G2

fre A5 if A5_1 == 2 & sum_G1_G2 >= 5 & !missing(sum_G1_G2) //7+ VI students in G1+G2

// global var_kept "KEY A0	A1 A2 A5_1 RESP_PHONE A5 B2_1 B2_2 B2_3"
//
// export excel $var_kept using "LBB Screener Control schools.xlsx", sheet(data,replace)firstrow(variables)

save "UNICEF LBB School Screening processed.dta",replace

**Keep if C2_1 Is Yes
keep if C2_1 == 1

save "UNICEF LBB School Screening processed 36 Braille schools.dta",replace

*Remain with the 6+ schools
keep if sum_G1_G2 >= 6 //Schools with less than 7 VI IN G1+G2 but 6+ VI's in G1+G2

// drop if A0 == 3 // dropping Mandera schools

save "UNICEF LBB School Screening processed schools 6 plus VIs.dta",replace

*import list with cordinates
cls
import excel "C:\Users\oyoo\OneDrive - Dalberg Global Development Advisors\QUALITY CONTROL\Projects\2026\Projects\UNICEF LBB\Screener\Progress\School.xlsx", firstrow clear

save using_file.dta, replace

// use "UNICEF LBB School Screening processed schools 6 plus VIs.dta",clear
use "UNICEF LBB School Screening processed 36 Braille schools.dta",clear
merge 1:1 KEY using using_file.dta,force

drop if _merge == 2
drop County Subcounty Schooltype Group VIlearnersinG1 VIlearnersinG2 VIlearnersinG1G2 _merge

replace GPS_Lat = trim(GPS_Lat)
destring GPS_Lat,replace

replace GPS_Lat = 2.352426 if KEY == "uuid:355ef603-56a9-428f-8011-3b095a3064d8"
replace GPS_Lon = 37.992191 if KEY == "uuid:355ef603-56a9-428f-8011-3b095a3064d8"

// save "UNICEF LBB School Screening processed schools 6 plus VIs inclusive of Mandera.dta",replace
save "UNICEF LBB School Screening processed 36 braille schools.dta",replace
***Matching

*****Here are observable characteristics that we can consider for matching schools:
 
*School Classification - A5_1 (0 control 1 intervention/ treatment)
*Locality - A2_1 (1 Urban 2 Rural)
 
*County performance by Grade 2: Baseline literacy/numeracy performance of Grade 1–2 (school-level average)
 
*Distance to the District Education Office 
//
// *Age of the school ---- years_with_vi 
gen years_with_vi = 2026 - A6_1
replace years_with_vi = . if A6_1==.

// *Average population size in Grades 1–2 ---- g1_g2_avg
gen g1_g2_sum=B1_2+B1_3
gen vi_g1_g2_sum=B2_2+B2_3

gen g1_g2_avg=(B1_2+B1_3)/2


// *Proportion of learners with Visual Impairment (VI) in the school ---- prop_vi_g1_g2
gen prop_vi_g1_g2=(vi_g1_g2_sum)/g1_g2_sum
//
// // *Teacher–pupil ratio (especially in lower primary G1-2) ---- teacher_pupil_ratio
gen teacher_g1_g2_sum=B5_2+B5_3
gen teacher_pupil_ratio=(g1_g2_sum) / teacher_g1_g2_sum

// // *Presence of a trained special needs / resource teacher -  ---- presence_of_spe_teacher
// //
gen presence_of_spe_teacher =.
replace presence_of_spe_teacher = 1 if B6 ==1
replace presence_of_spe_teacher = 0 if B6 ==2
//
// // * of teachers trained can be a good one as well ---- B7
// //
// // *Availability of inclusive infrastructure and assistive materials -
// //
// // *Braille materials present (Yes/No), ---- braille_available
gen braille_available=.
replace braille_available = 1 if C2_1 ==1
replace braille_available = 0 if C2_1 ==0
// //
// // *Adaptive furniture (Yes/No), ---- adaptive_furniture_available
// //
gen adaptive_furniture_available=.
replace adaptive_furniture_available = 1 if C2_2 ==1
replace adaptive_furniture_available = 0 if C2_2 ==0
// //
// // *Accessible classrooms/paths (Yes/No), Handrails/tactile markings (Yes/No) ---- accessible_paths_available 
// //
gen accessible_paths_available=.
replace accessible_paths_available = 1 if C2_3 ==1
replace accessible_paths_available = 0 if C2_3 ==0
// //
// // * Handrails/tactile markings (Yes/No) ---- handrails_available
// //
gen handrails_available=.
replace handrails_available = 1 if C2_4 ==1
replace handrails_available = 0 if C2_4 ==0
// //
// // *A5_1 -- School Classification ---- treat
// // *Recode Control from 2 to 1
gen treat =.
replace treat = 1 if A5_1 ==1
replace treat = 0 if treat ==.

********************************************Matching variables

**************************Creating County Clusters
decode A0, gen(county)
 
gen cluster_pair = ""
 
// drop cluster_pair
 
replace cluster_pair = "Kilifi–Taita Taveta" ///
    if inlist(county, "Kilifi", "Taita Taveta")
 
replace cluster_pair = "Mandera" ///
    if county == "Mandera"
 
replace cluster_pair = "Marsabit–Isiolo-Samburu" ///
    if inlist(county, "Marsabit", "Isiolo", "Samburu")
//
// replace cluster_pair = "Samburu–Isiolo" ///
//     if inlist(county, "Samburu", "Isiolo")
 
replace cluster_pair = "Wajir" ///
    if county == "Wajir"
 
replace cluster_pair = "Nairobi–Kiambu-Machakos" ///
    if inlist(county, "Nairobi", "Kiambu","Machakos")
 
// replace cluster_pair = "Nairobi–Machakos" ///
//     if inlist(county, "Nairobi", "Machakos")
 
replace cluster_pair = "Kajiado-Narok" ///
    if inlist(county, "Kajiado","Narok")
 
replace cluster_pair = "Garissa–Tana River" ///
    if inlist(county, "Garissa", "Garissa (Kakuma/Dadaab)", "Tana River")
 
replace cluster_pair = "Turkana–West Pokot" ///
    if inlist(county, "Turkana", "West pokot")
replace cluster_pair = "Bungoma-Kakamega" ///
    if inlist(county, "Bungoma", "Kakamega")
// drop cluster_pair
 
tab cluster_pair A5_1
tab county A5_1
 
encode cluster_pair, gen (cluster)
tab cluster

 
* 1:1 nearest neighbor with caliper and no replacement
 
psmatch2 treat (i.cluster i.A2_1 i.A5 g1_g2_sum i.B6), ///
	neighbor(1) ///
	caliper(0.1) ///
	noreplacement
tab _treated _support
 
psmatch2 treat (i.cluster i.A2_1 i.A5 i.B6), ///
	neighbor(1) ///
	caliper(0.1) ///
	noreplacement
tab _treated _support
 
psmatch2 treat (i.cluster i.A5 i.B6), ///
	neighbor(1) ///
	caliper(0.1) ///
	noreplacement
tab _treated _support
 
psmatch2 treat (i.cluster i.A5), ///
	neighbor(1) ///
	caliper(0.1) ///
	noreplacement
tab _treated _support

// global var_kept "KEY A5_1 A0 A0_S A1 A2 A2_S A2_1 A3 A3_S RESP_PHONE RESP_PHONE_S A4 A5 A5_S A5_1 B2_1 B2_2	B2_3 B2_4 General_Comments"

export excel using "C:\Users\oyoo\OneDrive - Dalberg Global Development Advisors\QUALITY CONTROL\Projects\2026\Projects\UNICEF LBB\Screener\Data\Processed\schools v02.xls", sheetreplace firstrow(variables)

* Create the date folders
****************************************************************************************************
cd "C:\Users\oyoo\OneDrive - Dalberg Global Development Advisors\QUALITY CONTROL\Projects\2026\Projects\UNICEF LBB\Screener\Quality control sheets"

// --- Step 1: Get today's date ---
local td = date(c(current_date), "DMY")

local d = day(`td')
local m = month(`td')
local foldername : display %02.0f `d' "-" %02.0f `m'
global dates : display %02.0f `d' "-" %02.0f `m'
display "`foldername'"

local folder "${dates}"
capture rmdir /s /q "`folder'"
capture mkdir "`folder'"

*QC CHECKS

* QC files 
cd "${dates}"

* var_kept
global var_kept "KEY INT_DATE START_TIME ENUM_NAME A5_1 A0 A0_S A1 A2 A2_S A2_1 A3 A3_S RESP_PHONE RESP_PHONE_S A4 A5 A5_S"

** generate a Comment based on the issue raised
gen issue_comment = ""

***************************************************************************
**Duration of interview check
gen Duration_mins = round((END_TIME - START_TIME)/(60*1000))

preserve
replace issue_comment ="interview duration is Longer or Shorter, kindly clarify"
keep if !inrange(Duration_mins,25,50)
cap export excel $var_kept Duration_mins issue_comment using "LBB Screener DQA issues ${dates} v01.xlsx", sheet(duration_issues,replace)firstrow(variables)
restore

*Lag time check

*Step 2: Sort by enumerator and time
bysort INT_DATE ENUM_NAME (START_TIME): gen gap_mins = (START_TIME - END_TIME[_n-1]) / 60000 if _n > 1

preserve
replace issue_comment ="Time taken to the next interview is way wierd, seems the interview started earlier or overlapped the other interview, kindly clarify"
keep if !inrange(gap_mins,0,10)
cap export excel $var_kept START_TIME END_TIME gap_mins issue_comment using "LBB Screener DQA issues ${dates} v01.xlsx", sheet(lag_time_issues,replace)firstrow(variables)
restore

**Duplicates Interviews_General
duplicates tag, gen (Interview_gen_dup)

preserve
replace issue_comment ="The interviews have duplicates, kindly clarify"
keep if Interview_gen_dup> 0
cap export excel $var_kept issue_comment using "LBB Screener DQA issues ${dates} v01.xlsx", sheet(Interv_dupl_gen_issues,replace)firstrow(variables)
restore

**Duplicates Interviews_Main
duplicates tag RESP_PHONE,gen(int_dup)

preserve
replace issue_comment ="The value provided is extreme, kindly clarify"
keep if int_dup>0
cap export excel $var_kept int_dup issue_comment using "LBB Screener DQA issues ${dates} v01.xlsx", sheet(Dup_phone_issues,replace)firstrow(variables)
restore

*B1_1
preserve

summarize B1_1, detail
gen lower = r(p25) - 1.5*(r(p75)-r(p25))
gen upper = r(p75) + 1.5*(r(p75)-r(p25))
replace issue_comment ="The value provided is extreme, kindly clarify"
keep if B1_1 < lower | B1_1 > upper
cap export excel $var_kept B1_* issue_comment using "LBB Screener DQA issues ${dates} v01.xlsx", sheet(B1_1_issues,replace)firstrow(variables)
restore

*B1_2
preserve
summarize B1_2, detail
gen lower = r(p25) - 1.5*(r(p75)-r(p25))
gen upper = r(p75) + 1.5*(r(p75)-r(p25))

replace issue_comment ="The value provided is extreme, kindly clarify"
keep if B1_2 < lower | B1_2 > upper
cap export excel $var_kept B1_* issue_comment using "LBB Screener DQA issues ${dates} v01.xlsx", sheet(B1_2_issues,replace)firstrow(variables)
restore

*B1_3
preserve
summarize B1_3, detail
gen lower = r(p25) - 1.5*(r(p75)-r(p25))
gen upper = r(p75) + 1.5*(r(p75)-r(p25))

replace issue_comment ="The value provided is extreme, kindly clarify"
keep if B1_3 < lower | B1_3 > upper
cap export excel $var_kept B1_* issue_comment using "LBB Screener DQA issues ${dates} v01.xlsx", sheet(B1_3_issues,replace)firstrow(variables)
restore

*B1_4
preserve
summarize B1_4, detail
gen lower = r(p25) - 1.5*(r(p75)-r(p25))
gen upper = r(p75) + 1.5*(r(p75)-r(p25))

replace issue_comment ="The value provided is extreme, kindly clarify"
keep if B1_4 < lower | B1_4 > upper
cap export excel $var_kept B1_* issue_comment using "LBB Screener DQA issues ${dates} v01.xlsx", sheet(B1_4_issues,replace)firstrow(variables)
restore

*B2_1
preserve
summarize B2_1, detail
gen lower = r(p25) - 1.5*(r(p75)-r(p25))
gen upper = r(p75) + 1.5*(r(p75)-r(p25))

replace issue_comment ="The value provided is extreme, kindly clarify"
keep if B2_1 < lower | B2_1 > upper
cap export excel $var_kept B2_* issue_comment using "LBB Screener DQA issues ${dates} v01.xlsx", sheet(B2_1_issues,replace)firstrow(variables)
restore

*B2_2
preserve
summarize B2_2, detail
gen lower = r(p25) - 1.5*(r(p75)-r(p25))
gen upper = r(p75) + 1.5*(r(p75)-r(p25))

replace issue_comment ="The value provided is extreme, kindly clarify"
keep if B2_2 < lower | B2_2 > upper
cap export excel $var_kept B2_* issue_comment using "LBB Screener DQA issues ${dates} v01.xlsx", sheet(B2_2_issues,replace)firstrow(variables)
restore

*B2_3
preserve
summarize B2_3, detail
gen lower = r(p25) - 1.5*(r(p75)-r(p25))
gen upper = r(p75) + 1.5*(r(p75)-r(p25))

replace issue_comment ="The value provided is extreme, kindly clarify"
keep if B2_3 < lower | B2_3 > upper
cap export excel $var_kept B2_* issue_comment using "LBB Screener DQA issues ${dates} v01.xlsx", sheet(B2_3_issues,replace)firstrow(variables)
restore

*B2_4
preserve
summarize B2_4, detail
gen lower = r(p25) - 1.5*(r(p75)-r(p25))
gen upper = r(p75) + 1.5*(r(p75)-r(p25))

replace issue_comment ="The value provided is extreme, kindly clarify"
keep if B2_4 < lower | B2_4 > upper
cap export excel $var_kept B2_* issue_comment using "LBB Screener DQA issues ${dates} v01.xlsx", sheet(B2_4_issues,replace)firstrow(variables)
restore

*B5_1
preserve
summarize B5_1, detail
gen lower = r(p25) - 1.5*(r(p75)-r(p25))
gen upper = r(p75) + 1.5*(r(p75)-r(p25))

replace issue_comment ="The value provided is extreme, kindly clarify"
keep if B5_1 < lower | B5_1 > upper
cap export excel $var_kept B5_* issue_comment using "LBB Screener DQA issues ${dates} v01.xlsx", sheet(B5_1_issues,replace)firstrow(variables)
restore

*B5_2
preserve
summarize B5_2, detail
gen lower = r(p25) - 1.5*(r(p75)-r(p25))
gen upper = r(p75) + 1.5*(r(p75)-r(p25))

replace issue_comment ="The value provided is extreme, kindly clarify"
keep if B5_2 < lower | B5_2 > upper
cap export excel $var_kept B5_* issue_comment using "LBB Screener DQA issues ${dates} v01.xlsx", sheet(B5_2_issues,replace)firstrow(variables)
restore

*B5_3
preserve
summarize B5_3, detail
gen lower = r(p25) - 1.5*(r(p75)-r(p25))
gen upper = r(p75) + 1.5*(r(p75)-r(p25))

replace issue_comment ="The value provided is extreme, kindly clarify"
keep if B5_3 < lower | B5_3 > upper
cap export excel $var_kept B5_* issue_comment using "LBB Screener DQA issues ${dates} v01.xlsx", sheet(B5_3_issues,replace)firstrow(variables)
restore

*B5_4
preserve
summarize B5_4, detail
gen lower = r(p25) - 1.5*(r(p75)-r(p25))
gen upper = r(p75) + 1.5*(r(p75)-r(p25))

replace issue_comment ="The value provided is extreme, kindly clarify"
keep if B5_4 < lower | B5_4 > upper
cap export excel $var_kept B5_* issue_comment using "LBB Screener DQA issues ${dates} v01.xlsx", sheet(B5_4_issues,replace)firstrow(variables)
restore

*B7
preserve
summarize B7, detail
gen lower = r(p25) - 1.5*(r(p75)-r(p25))
gen upper = r(p75) + 1.5*(r(p75)-r(p25))

replace issue_comment ="The value provided is extreme, kindly clarify"
keep if B7 < lower | B7 > upper
cap export excel $var_kept B6 B7 issue_comment using "LBB Screener DQA issues ${dates} v01.xlsx", sheet(B5_4_issues,replace)firstrow(variables)
restore

*C1_1a
preserve
summarize C1_1a, detail
gen lower = r(p25) - 1.5*(r(p75)-r(p25))
gen upper = r(p75) + 1.5*(r(p75)-r(p25))

replace issue_comment ="The value provided is extreme, kindly clarify"
keep if C1_1a < lower | C1_1a > upper
cap export excel $var_kept C1_1* issue_comment using "LBB Screener DQA issues ${dates} v01.xlsx", sheet(C1_1a_issues,replace)firstrow(variables)
restore

*C1_1b
preserve
summarize C1_1b, detail
gen lower = r(p25) - 1.5*(r(p75)-r(p25))
gen upper = r(p75) + 1.5*(r(p75)-r(p25))

replace issue_comment ="The value provided is extreme, kindly clarify"
keep if C1_1b < lower | C1_1b > upper
cap export excel $var_kept C1_1* issue_comment using "LBB Screener DQA issues ${dates} v01.xlsx", sheet(C1_1b_issues,replace)firstrow(variables)
restore

*C1_1c
preserve
summarize C1_1c, detail
gen lower = r(p25) - 1.5*(r(p75)-r(p25))
gen upper = r(p75) + 1.5*(r(p75)-r(p25))

replace issue_comment ="The value provided is extreme, kindly clarify"
keep if C1_1c < lower | C1_1c > upper
cap export excel $var_kept C1_1* issue_comment using "LBB Screener DQA issues ${dates} v01.xlsx", sheet(C1_1c_issues,replace)firstrow(variables)
restore

*C1_a
preserve
summarize C1_a, detail
gen lower = r(p25) - 1.5*(r(p75)-r(p25))
gen upper = r(p75) + 1.5*(r(p75)-r(p25))

replace issue_comment ="The value provided is extreme, kindly clarify"
keep if C1_a < lower | C1_a > upper
cap export excel $var_kept C1_1* issue_comment using "LBB Screener DQA issues ${dates} v01.xlsx", sheet(C1_a_issues,replace)firstrow(variables)
restore

*C1_b
preserve
summarize C1_b, detail
gen lower = r(p25) - 1.5*(r(p75)-r(p25))
gen upper = r(p75) + 1.5*(r(p75)-r(p25))

replace issue_comment ="The value provided is extreme, kindly clarify"
keep if C1_b < lower | C1_b > upper
cap export excel $var_kept C1_1* issue_comment using "LBB Screener DQA issues ${dates} v01.xlsx", sheet(C1_b_issues,replace)firstrow(variables)
restore

*C1_c
preserve
summarize C1_c, detail
gen lower = r(p25) - 1.5*(r(p75)-r(p25))
gen upper = r(p75) + 1.5*(r(p75)-r(p25))

replace issue_comment ="The value provided is extreme, kindly clarify"
keep if C1_c < lower | C1_c > upper
cap export excel $var_kept C1_1* issue_comment using "LBB Screener DQA issues ${dates} v01.xlsx", sheet(C1_c_issues,replace)firstrow(variables)
restore


****END********************************************************************




*************************************************************************
*LBB Braille Checker

*************************************************************************
cls
clear all
cd "C:\Users\oyoo\OneDrive - Dalberg Global Development Advisors\QUALITY CONTROL\Projects\2026\Projects\UNICEF LBB\Braille Survey\Data\Raw"

***import dataset

import spss using "Unsighted Vs Low Vision Disagregation Tool_WIDE.sav", clear

*************************************************************************
*dropping irrelevant variables
drop SubmissionDate	starttime	endtime	deviceid	devicephonenum	username	device_info	duration	caseid	password formdef_version instanceID

*Order
order KEY

*Formating date
gen INT_DATE1 = dofc(INT_DATE)
format INT_DATE1 %td

drop INT_DATE
ren INT_DATE1 INT_DATE

order INT_DATE, after(KEY)
lab var INT_DATE"Date of interview"

*drop test data
drop if inlist(KEY,"uuid:314c7b3e-ae57-4fea-9a28-d2f377ac43fd","uuid:c5b0a232-01af-4d0c-9b53-fe4a6e5b82dd","uuid:2a22c763-4855-4f52-9fd1-3c09f2beb1c3")

*County  
label define cnty 1 "Bungoma" 2 "Kilifi" 3 "Mandera" 4 "Marsabit" 5 "Samburu" 6 "Wajir" 7 "Nairobi" 8 "Kajiado" 9 "Garissa (Kakuma/Dadaab)" 10 "Turkana" 11 "Kakamega" 13 "Isiolo" 15 "Narok" 16 "Tana River" 17 "West pokot" 18 "Garissa" 19 "Kitui" 20 "Elgeyo Marakwet" 21 "Kisumu" 23 "Baringo" 25 "Siaya" 26 "Mandera East" 27 "Kericho" 28 "Kisii" 29 "Bomet" 30 "Nakuru" 31 "Trans Nzoia" 34 "Mombasa" 35 "Meru" 36 "Kwale" 37 "Taveta" 39 "Matunda" 40 "Kitale",modify

lab values County cnty

*Subcounty
label define sb_cty 1 "Tana River" 2 "Wajir West" 3 "Lafey" 4 "Navakholo" 5 "Lugari" 6 "West Pokot" 7 "Gem" 8 "Kitui Central" 9 "Marsabit Central" 10 "Wajir East" 11 "Laisamis" 12 "Loitoktok" 13 "Samburu Central" 14 "Webuye West" 15 "Bungoma South" 16 "Turkana West" 17 "Samburu" 18 "Marigat" 19 "Muhoroni" 20 "Kasarani" 21 "Kilifi North" 22 "Turkana East" 23 "Keiyo South" 24 "Kilifi South" 25 "Tongaren" 26 "Kakuma" 27 "Oloitoktok" 28 "Garba Tulla" 29 "Kitui South" 30 "Kajiado Central" 31 "Arabia" 32 "Bura East" 33 "Hulugho" 34 "Wajir South" 35 "Garbatulla" 36 "Tana Delta" 37 "Mbalambala" 38 "Tana North" 39 "Kakamega Central" 40 "Kaloleni" 41 "Mumias West" 42 "Sankuri" 43 "Transmara South" 44 "Central" 45 "Tarbaj" 46 "Embakasi" 47 "Balambala" 48 "Mandera North" 49 "Fafi" 50 "Garissa" 51 "Dadaab" 52 "Webuye West" 53 "Mandera East" 999 "N"

label define sb_cty ///
54 "Masaba South" ///
55 "Narok" ///
56 "Baringo" ///
57 "" ///
58 "Kericho" ///
59 "Likuyani" ///
60 "Kinango" ///
61 "Taveta" ///
62 "Matungu" ///
63 "Mwingi North", add

replace Sub_county = 54 if KEY == "uuid:b964301d-7efb-438a-b569-d5f5aa65f755"
replace Sub_county = 55 if KEY == "uuid:ba10e4ad-8ece-4053-9eac-e8d29ad3e5c7"
replace Sub_county = 56 if KEY == "uuid:76bedcd8-512b-490f-b230-1df494825882"
replace Sub_county = 57 if KEY == "uuid:41dafcfb-ae93-4e4c-80c4-3d006847083a"
replace Sub_county = 58 if KEY == "uuid:c0acc927-1995-4915-a9cb-a8bb277a73a2"
replace Sub_county = 59 if KEY == "uuid:f51f84c9-b58e-4a81-b427-6278479b2549"
replace Sub_county = 60 if KEY == "uuid:3b1a4d89-684d-41d5-9e84-e740d927ebcd"
replace Sub_county = 61 if KEY == "uuid:c834efa0-1332-47a3-9bd6-daf2d3958b31"
replace Sub_county = 62 if KEY == "uuid:dc78ba7d-2323-42ae-bebb-bb1c5fae14f1"
replace Sub_county = 63 if KEY == "uuid:da856ab2-80e4-468c-80dd-0abb189940cd"


lab values Sub_county sb_cty

*Schools
label define Sch 1 "Chewani Primary And Junior School" 2 "Griftu Primary School" 3 "Lafey Primary School" 4 "Nambacha Primary" 5 "Savala Deb Primary" 6 "St. Brendan Chelombai Boarding And Junior Schoool" 7 "St. Oda Aluor School For The VI" 8 "Kitui Comprehensive School For VI" 9 "Al-Hidaya Pry School" 10 "Catholic Integrated" 11 "Got-Ade Integrated" 12 "Kamor Pr School(Int)" 13 "Kikelwa Integrated Primary" 14 "Logologo Pri Integrated" 15 "Mandera Spe School For VI" 16 "Maralal Pry Unit For VI" 17 "Misanga Primary" 18 "Musikoma Primary" 19 "Nationakar Primary" 20 "Seneya Special" 21 "St Pauls Integrated Primary" 22 "Marigat Special Primary School" 23 "S.A Kibos Special Primary School" 24 "Muthaiga School" 25 "Kibarani Integrated" 26 "Lomunyenakwan Primary School" 27 "Kacheliba Mixed Primary And Junior School" 28 "Chepsigot Special Unit For The VI" 29 "Sahajanand Special Schools" 30 "Ngundeng Primary" 31 "Sikulu Friends Special Unit Primary" 32 "Fuji Primary" 33 "Enchurrai Primary" 34 "Matagari Primary/Juniour School" 35 "Ikanga Special Unit" 36 "Kumpa Holy Mothers School" 37 "Arabia Mixed Boarding Primary School" 38 "Bura Boarding Primary And Junior" 39 "Cheron Primary School" 40 "Hubsoy Mixed Day/Boarding/Special School" 41 "Kinna Primary School" 42 "Kipini Primary School" 43 "Koranhindi Pry And Js" 44 "Libahlow Primary And Junior School" 45 "Magura Primary Schhol" 46 "Mahiakalo Primary School" 47 "Migundini Primary N Junior School" 48 "Mumias Township Primary School" 49 "Nunow Primary School" 50 "Oldonyo-Orok Primary" 51 "Shimanyiro Primary School" 52 "St.Comboni Kacheliba Girls" 53 "St.Peters Boys Mumias" 54 "Tarbaj Primary And Junior School" 55 "Thawabu Comprehensive School" 56 "Tula Primary And Junior School" 57 "Makutano S.A Primary &Junior School" 58 "Yabicho Junior School" 59 "Chief Muturi Integrated Primary" 60 "Icf Integrated Primar & Junior School" 61 "Iftin Integrated Primary" 62 "Jaribu Primary" 63 "Kakuma Arid" 64 "Kakuma Mixed" 65 "Kiwanja Ndege" 66 "Lkurroto Primary" 67 "Lokitaung Primary (Inclusive School)" 68 "Misikhu Primary" 69 "Mukhuyu Primary (Mukuyuni Primary School)" 70 "Mupeli Primary" 71 "Shashafey Int Pry School" 72 "St. Johns Primary" 73 "St. Teresa" 74 "Township Pry School(Regular)" 75 "Agai Primary School" 76 "Dawa Integrated Primary School" 77 "Emining Special Primary School for VI" 78 "Kaboloin Primary School" 79 "Kambi ya Juu Integrated Primary School" 80 "St. Joseph Kiomiti Special school for the Blind" 81 "Kitui School for the Deaf/Blind" 82 "Korara Special Primary School" 83 "Koyonzo Special Primary school for V.I" 84 "Menengai Primary School & V.I Unit" 85 "Mitoto Special Primary School" 86 "Mlimani Primary & Special Unit" 87 "Moi Kabaratonjo Special Primary school for VI" 88 "Ole Sankale Primary school" 89 "Ngaaie Special School for M.H/V.I" 90 "S.A Likoni Primary School for the Blind" 91 "St. Lucy's Primary School" 92 "St. Luke's Integrated Primary School" 93 "Taveta Special Primary School" 94 "Kilgoris DEB Primary School" 95 "Matunda Special Primary school" 96 "Trans Nzoia Integrated Program"

lab values School_name Sch

*RES_NAME
label define Rspt 1 "Omar Maro Doyo" 2 "Ali Garat Saney" 3 "Khalif Ali Ahmed" 4 "Emmanuel Luyo" 5 "Michael" 6 "Julius Kipsang Murei" 7 "Sr. Esther Midge" 8 "Caroline M. Njagi" 9 "Hirbo Barisso Hirbo" 10 "Hassan Mohamed Gaalow" 11 "Muhamed Idow Ahmed" 12 "Muktar Mulo Kike" 13 "Ann Wamboi Njoroge" 14 "Meshack Labarakwe" 15 "Bare Ali Adan" 16 "Boniface Lonyait" 17 "Tom John Masibo" 18 "Mwelu Hastings Wasilwa" 19 "Lobuin Namuya Edward" 20 "Regina Lekisolish" 21 "Veronica Lokidongi" 22 "Mr. Tirok" 23 "Caroline Templer" 24 "Lydia Ruguru Gilbert" 25 "Wilbroda Sami Netia" 26 "Dominic Mwariri Kamunya" 27 "Dinah C Lonyang'Apoi" 28 "Deputy Wilberforce Nyukuri" 29 "Patrick Koba Muzungu" 30 "Linet Boyani" 31 "Daud Aminga Nyachio" 32 "Magozwa Erickson Amuyunzu" 33 "Samuel Njenga Gachema" 34 "Isaak Bika Gamba" 35 "Joseph mutune" 36 "Michael Kipngetich Ngeny" 37 "Aftin Muktar Ali" 38 "Yussuf Omar Kuno" 39 "Ares Hassan Abdi" 40 "Abdinasir Hillow" 41 "Hussein Galgalo Sora" 42 "Mr Michael Charo" 43 "Abdullahi Abdi Kuno" 44 "Hassan Yarow Salat" 45 "Fredrick Thoya Mwamure" 46 "Nelson Wanjala Khaemba" 47 "Abraham Njau Kariuki" 48 "Josephat Kweyu" 49 "Ismail Omar Hassan" 50 "Kevine Onyango Akuku" 51 "Jacquelyne Agitsa" 52 "Natao Leonora" 53 "Sr.Praxidis N.Odero" 54 "Nasir Bashir Abdi" 55 "Monica Muriith" 56 "Hamisi Musa" 57 "Chrispine Barasa Wamboko" 58 "Lul Adan Osman" 59 "Peris Yiapaso Minik" 60 "Rashid Abey Yussuf" 61 "Caroline Wanjiru" 62 "Hussein Dubat Yussuf" 63 "Edukon Eripon Joseph" 64 "Akolom Amuron David" 65 "James Diid Guyo" 66 "Joseph Lelekoitien" 67 "Nicodemus Edapal Emoru" 68 "Evans Sikuku Wanyama" 69 "Irene Sikhoya Kikechi" 70 "Everlyne Wambaya" 71 "Hassan A Hollow" 72 "Boru Dabasso Guyo" 73 "Alberta Ewoi" 74 "Abdi Maow Abdille" 75 "Sir" 76 "Adan Muhumed" 77 "Md. Caroline Kiptoo" 78 "John Kikwai" 79 "Md. Rebecca Mwonjiro" 80 "George Manyange" 81 "Betty Kiraithe" 82 "Mr. Sigei" 83 "Catherine washiali" 84 "Lady Milka" 85 "John Edambo" 86 "Roselyne Chebor" 87 "Md. Leah Yatich" 88 "Nicholas kimurgo" 89 "Peter Syanda" 90 "Elizabeth Ngare" 91 "Sr. Judith" 92 "Mr. Paul Mapi" 93 "Mary W Maghanga" 94 "Mr. Atieno Joel" 95 "Amisi Nelly" 96 "Sir"

lab values RES_NAME Rspt

*RESP_PHONE
label define RESP_PHONE_id 1 "724040913" 2 "725011177" 3 "720827881" 4 "723276206" 5 "720860931" 6 "725282869" 7 "727688292" 8 "722399178" 9 "725757092" 10 "725292843" 11 "723929312" 12 "720881336" 13 "723332445" 14 "725420587" 15 "722107638" 16 "728491300" 17 "721332032" 18 "721522867" 19 "724564261" 20 "711685628" 21 "713498359" 22 "729860879" 23 "722633389" 24 "723420473" 25 "721254082" 26 "722868801" 27 "711457956" 28 "726425142" 29 "717459915" 30 "712591785" 31 "721417419" 32 "706151851" 33 "728982692" 34 "721105236" 35 "721416193" 36 "726217907" 37 "722300202" 38 "723375338" 39 "721657435" 40 "724598399" 41 "713496745" 42 "719583515" 43 "721869821" 44 "725660139" 45 "759155104" 46 "714257448" 47 "722692973" 48 "721469885" 49 "722777123" 50 "721446005" 51 "723511405" 52 "701281094" 53 "722328962" 54 "720336808" 55 "720900211" 56 "724667441" 57 "723490994" 58 "713355157" 59 "723308888" 60 "723903014" 61 "726210678" 62 "711609215" 63 "710118297" 64 "711565610" 65 "721308611" 66 "720321590" 67 "719652374" 68 "728955290" 69 "727597630" 70 "715298842" 71 "724373366" 72 "727915671" 73 "726820519" 74 "729002838" 75 "720207977" 76 "724353282" 77 "722937127" 78 "725794482" 79 "721725692" 80 "720398806" 81 "720985651" 82 "721859256" 83 "798908491" 84 "726969395" 85 "723520698" 86 "725570151" 87 "721917912" 88 "721439066" 89 "728067206" 90 "723760651" 91 "722933283" 92 "759087109" 93 "726473432" 94 "728729341" 95 "717782322" 96 "724158242"

lab values RES_PHONE RESP_PHONE_id

*Occupation
label define Occupation_id 1 "Headteacher" 2 "Deputy headteacher" 3 "Senior Teacher" 4 "Special needs/resource teacher" 5"Hoi" 999 "NA"

replace Occupation = 1 if inlist(KEY,"uuid:76bedcd8-512b-490f-b230-1df494825882","uuid:c0acc927-1995-4915-a9cb-a8bb277a73a2","uuid:3b1a4d89-684d-41d5-9e84-e740d927ebcd","uuid:da856ab2-80e4-468c-80dd-0abb189940cd","uuid:f51f84c9-b58e-4a81-b427-6278479b2549","uuid:b964301d-7efb-438a-b569-d5f5aa65f755","uuid:dc78ba7d-2323-42ae-bebb-bb1c5fae14f1") | inlist(KEY,"uuid:ba10e4ad-8ece-4053-9eac-e8d29ad3e5c7","uuid:c834efa0-1332-47a3-9bd6-daf2d3958b31")

replace Occupation = 5 if KEY == "uuid:768ac925-c079-493e-b4a2-f1b7279328eb"

lab values Occupation Occupation_id

*School_type
label define School_type_id 1 "Special School" 2 "Inclusive/Integrated" 3 "Regular with Special Unit" 999 "NA"

replace School_type = 1 if inlist(KEY, "uuid:76bedcd8-512b-490f-b230-1df494825882","uuid:da856ab2-80e4-468c-80dd-0abb189940cd","uuid:f51f84c9-b58e-4a81-b427-6278479b2549","uuid:b964301d-7efb-438a-b569-d5f5aa65f755","uuid:dc78ba7d-2323-42ae-bebb-bb1c5fae14f1","uuid:c834efa0-1332-47a3-9bd6-daf2d3958b31","uuid:768ac925-c079-493e-b4a2-f1b7279328eb")

replace School_type = 3 if KEY == "uuid:c0acc927-1995-4915-a9cb-a8bb277a73a2"
replace School_type = 2 if inlist(KEY,"uuid:3b1a4d89-684d-41d5-9e84-e740d927ebcd","uuid:ba10e4ad-8ece-4053-9eac-e8d29ad3e5c7")

lab values School_type School_type_id

*Group
label define Group_id 1 "Intervention" 2 "Control"
lab values Group Group_id

*destring
gen G2 = Q2a + Q2b + Q2c
gen G3 = Q1a + Q1b + Q1c
gen G1 = Q3a + Q3b + Q3c
gen PP2 = Q4a + Q4b + Q4c

destring G3 G2 G1 PP2,replace
lab var G3"Screener tallies of Grade 3"
lab var G2"Screener tallies of Grade 2"
lab var G1"Screener tallies of Grade 1"
lab var PP2"Screener tallies of PP2"

*Correction
replace Q2a = 2 if KEY == "uuid:44217142-5f19-4280-a631-884346969d2a"
replace G2 = G2 + Q2a if KEY == "uuid:44217142-5f19-4280-a631-884346969d2a"

replace Q3a = 3 if KEY == "uuid:1a12f175-4d41-4092-899a-86fe81f2be37"
replace Q3c = 1 if KEY == "uuid:1a12f175-4d41-4092-899a-86fe81f2be37"
replace G1 = G1+ 4 if KEY == "uuid:1a12f175-4d41-4092-899a-86fe81f2be37"

replace Q3b = 2 if KEY == "uuid:2d2557d2-9b49-4415-bfee-f31d827437fc"
replace G1 = 5 if KEY == "uuid:2d2557d2-9b49-4415-bfee-f31d827437fc"
replace Q2b = 2 if KEY == "uuid:2d2557d2-9b49-4415-bfee-f31d827437fc"
replace G2 = 5 if KEY == "uuid:2d2557d2-9b49-4415-bfee-f31d827437fc"

replace Q2a = 2 if KEY == "uuid:44217142-5f19-4280-a631-884346969d2a"
replace G2 = 2 if KEY == "uuid:44217142-5f19-4280-a631-884346969d2a"

replace G1 = 12 if KEY == "uuid:966a4b2d-5a04-4785-baef-1cce058be180"
replace Q3a = 10 if KEY == "uuid:966a4b2d-5a04-4785-baef-1cce058be180"
replace Q3b = 2 if KEY == "uuid:966a4b2d-5a04-4785-baef-1cce058be180"
replace Q3c = 0 if KEY == "uuid:966a4b2d-5a04-4785-baef-1cce058be180"

replace Q2c = 3 if KEY == "uuid:c16ba9d3-71d1-4caa-b45c-97d5d5504b38"
replace G2 = 4 if KEY == "uuid:c16ba9d3-71d1-4caa-b45c-97d5d5504b38"
replace PP2 = 4 if KEY == "uuid:c16ba9d3-71d1-4caa-b45c-97d5d5504b38"
replace Q4a = 4 if KEY == "uuid:c16ba9d3-71d1-4caa-b45c-97d5d5504b38"
replace G1 = 6 if KEY == "uuid:c16ba9d3-71d1-4caa-b45c-97d5d5504b38"
replace Q3a = 6 if KEY == "uuid:c16ba9d3-71d1-4caa-b45c-97d5d5504b38"

replace Q2b = 0 if KEY == "uuid:e1779720-950a-4689-925c-47ada2ad0b09"
replace Q2c = 0 if KEY == "uuid:e1779720-950a-4689-925c-47ada2ad0b09"
replace Q2a = 4 if KEY == "uuid:e1779720-950a-4689-925c-47ada2ad0b09"
replace G2 = 4 if KEY == "uuid:e1779720-950a-4689-925c-47ada2ad0b09"

replace G1 = 10 if KEY == "uuid:e3df56bf-4a37-4717-acc1-9b86e9d58184"
replace Q3a = 7 if KEY == "uuid:e3df56bf-4a37-4717-acc1-9b86e9d58184"
replace Q3b = 0 if KEY == "uuid:e3df56bf-4a37-4717-acc1-9b86e9d58184"
replace Q3c = 3 if KEY == "uuid:e3df56bf-4a37-4717-acc1-9b86e9d58184"

replace G1 = 10 if KEY == "uuid:e3df56bf-4a37-4717-acc1-9b86e9d58184"
replace Q3a = 7 if KEY == "uuid:e3df56bf-4a37-4717-acc1-9b86e9d58184"
replace Q3b = 0 if KEY == "uuid:e3df56bf-4a37-4717-acc1-9b86e9d58184"
replace Q3c = 3 if KEY == "uuid:e3df56bf-4a37-4717-acc1-9b86e9d58184"

replace G3 = 20 if KEY == "uuid:e3df56bf-4a37-4717-acc1-9b86e9d58184"
replace Q1a = 11 if KEY == "uuid:e3df56bf-4a37-4717-acc1-9b86e9d58184"
replace Q1b = 0 if KEY == "uuid:e3df56bf-4a37-4717-acc1-9b86e9d58184"
replace Q1c = 9 if KEY == "uuid:e3df56bf-4a37-4717-acc1-9b86e9d58184"

replace G2 = 11 if KEY == "uuid:e3df56bf-4a37-4717-acc1-9b86e9d58184"
replace Q2a = 6 if KEY == "uuid:e3df56bf-4a37-4717-acc1-9b86e9d58184"
replace Q2b = 0 if KEY == "uuid:e3df56bf-4a37-4717-acc1-9b86e9d58184"
replace Q2c = 5 if KEY == "uuid:e3df56bf-4a37-4717-acc1-9b86e9d58184"

replace G1 = 4 if KEY == "uuid:1a12f175-4d41-4092-899a-86fe81f2be37"

drop if KEY == "uuid:7df9aa04-66f8-45a5-bdd9-a5dfaf24ae22"

*dup school
drop if KEY == "uuid:732dbf13-3559-4367-bb2a-68fa33baaaf4"

replace Q3c = 1 if KEY == "uuid:ebde8f01-3181-41bc-b760-b31c6f22f0e3"
replace G1 = 1 if KEY == "uuid:ebde8f01-3181-41bc-b760-b31c6f22f0e3"

gen Braille_G3 = Q1a + Q1b
gen Braille_G2 = Q2a + Q2b
gen Braille_G1 = Q3a + Q3b
gen Braille_PP2 = Q4a + Q4b
gen Braille_PP1 = Q5a + Q5b
egen Braille_Students = rowtotal(Braille_G3 Braille_G2 Braille_G1 Braille_PP1 Braille_PP2)
replace Braille_Students = . if missing(Braille_G3) & missing(Braille_G2) & missing(Braille_G1) & missing(Braille_PP2) & missing(Braille_PP1)

gen Braille_Students_VI = .
replace Braille_Students_VI = 1 if Braille_Students>0 & !missing(Braille_Students)
replace Braille_Students_VI = 0 if Braille_Students == 0 & !missing(Braille_Students)

lab define yes_no 1"Yes" 0"No"
lab values Braille_Students_VI yes_no
lab var Braille_Students_VI"Does this school have students using Braille"
lab var Braille_Students"Actual number of students using Braille"
lab var Braille_G3"Actual number of students using Braille in G3"
lab var Braille_G2"Actual number of students using Braille in G2"
lab var Braille_G1"Actual number of students using Braille in G1"
lab var Braille_PP1"Actual number of students using Braille in PP1"
lab var Braille_PP2"Actual number of students using Braille in PP2"

*updating schools with no VIs

foreach x in Q1a Q1b Q1c Q2a Q2b Q2c Q3a Q3b Q3c Q4a Q4b Q4c PP1 Q5a Q5b Q5c G2 G3 G1 PP2{
    replace `x' = 0 if inlist(KEY,"uuid:732dbf13-3559-4367-bb2a-68fa33baaaf4", "uuid:b8a26634-c9b7-4873-a71a-c0150fcd6ccf","uuid:27e226dd-2f33-43cc-8505-70cc5aeae8de","uuid:de2dbbe2-8be7-4a64-83db-96fc5b8bc889","uuid:495593b6-cd85-4b72-9223-cdbb80890dcc","uuid:e5868f22-ecc5-401a-a999-073227c19f33","uuid:7f4c3adc-d12f-49e4-b8be-c5a095e8321b","uuid:1e60921b-e563-419b-b904-3218ec1ac0ee")| inlist(KEY,"uuid:af6931a9-63f7-4867-bbe1-3648deb8913f","uuid:9343e6b2-31a2-4c97-9ba9-783c37f16f2a","uuid:a42d3203-6a2c-46f7-a4c4-19405ad6a078","uuid:ebde8f01-3181-41bc-b760-b31c6f22f0e3","uuid:1ee79473-d983-45a0-a01e-c8c29ad1da2a","uuid:bf88e806-5c95-4ddb-982a-ee5d0715c9ab","uuid:3daf18d7-39d3-4bf1-9b1f-144a424bc93d","uuid:18aeed3d-7b8d-44f6-a0e4-6ab2808cccf9","uuid:38194e80-b093-4fa9-9c4b-e832f93c4926") | inlist(KEY,"uuid:ee1f0cad-f1a0-42a5-bcbe-b9a023a12ce5","uuid:d891925e-5716-4aa7-89ee-abe8353179ba","uuid:efc690e4-a887-48d1-9b3a-15c1138f4c88","uuid:fdc0691d-bd74-41f3-808a-df3fe835469a")
}

replace Q2c = 2 if KEY == "uuid:1ee79473-d983-45a0-a01e-c8c29ad1da2a"
replace Q3c = 2 if KEY == "uuid:1ee79473-d983-45a0-a01e-c8c29ad1da2a"
replace Q4c = 2 if KEY == "uuid:1ee79473-d983-45a0-a01e-c8c29ad1da2a"
replace G2 = 2 if KEY == "uuid:1ee79473-d983-45a0-a01e-c8c29ad1da2a"
replace G1 = 2 if KEY == "uuid:1ee79473-d983-45a0-a01e-c8c29ad1da2a"
replace PP2 = 2 if KEY == "uuid:1ee79473-d983-45a0-a01e-c8c29ad1da2a"

replace Q1c = 12 if KEY == "uuid:bf88e806-5c95-4ddb-982a-ee5d0715c9ab"
replace Q2c = 25 if KEY == "uuid:bf88e806-5c95-4ddb-982a-ee5d0715c9ab"
replace Q3c = 8 if KEY == "uuid:bf88e806-5c95-4ddb-982a-ee5d0715c9ab"
replace Q4c = 5 if KEY == "uuid:bf88e806-5c95-4ddb-982a-ee5d0715c9ab"
replace G3 = 12 if KEY == "uuid:bf88e806-5c95-4ddb-982a-ee5d0715c9ab"
replace G2 = 25 if KEY == "uuid:bf88e806-5c95-4ddb-982a-ee5d0715c9ab"
replace G1 = 8 if KEY == "uuid:bf88e806-5c95-4ddb-982a-ee5d0715c9ab"
replace PP2 = 5 if KEY == "uuid:bf88e806-5c95-4ddb-982a-ee5d0715c9ab"

replace PP2 = 1 if KEY == "uuid:3daf18d7-39d3-4bf1-9b1f-144a424bc93d"
replace Q4c = 2 if KEY == "uuid:3daf18d7-39d3-4bf1-9b1f-144a424bc93d"
replace G2 = 2 if KEY == "uuid:3daf18d7-39d3-4bf1-9b1f-144a424bc93d"
replace Q2c = 2 if KEY == "uuid:3daf18d7-39d3-4bf1-9b1f-144a424bc93d"


replace Q1c = 5 if KEY == "uuid:ee1f0cad-f1a0-42a5-bcbe-b9a023a12ce5"
replace G3 = 5 if KEY == "uuid:ee1f0cad-f1a0-42a5-bcbe-b9a023a12ce5"
replace Q3c = 5 if KEY == "uuid:ee1f0cad-f1a0-42a5-bcbe-b9a023a12ce5"
replace G1 = 5 if KEY == "uuid:ee1f0cad-f1a0-42a5-bcbe-b9a023a12ce5"

*Kakuma schools
*natiokomor
replace PP1 = 5 if KEY == "uuid:2fdd25fd-9c74-448c-b5fb-66b8b420364c"
replace Q5c = 5 if KEY == "uuid:2fdd25fd-9c74-448c-b5fb-66b8b420364c"

replace PP2 = 2 if KEY == "uuid:2fdd25fd-9c74-448c-b5fb-66b8b420364c"
replace Q4c = 2 if KEY == "uuid:2fdd25fd-9c74-448c-b5fb-66b8b420364c"

replace G1 = 4 if KEY == "uuid:2fdd25fd-9c74-448c-b5fb-66b8b420364c"
replace Q3c = 2 if KEY == "uuid:2fdd25fd-9c74-448c-b5fb-66b8b420364c"

replace G2 = 5 if KEY == "uuid:2fdd25fd-9c74-448c-b5fb-66b8b420364c"
replace Q2c = 4 if KEY == "uuid:2fdd25fd-9c74-448c-b5fb-66b8b420364c"

replace G3 = 2 if KEY == "uuid:2fdd25fd-9c74-448c-b5fb-66b8b420364c"
replace Q1c = 2 if KEY == "uuid:2fdd25fd-9c74-448c-b5fb-66b8b420364c"

*Kakuma arid
replace PP1 = 12 if KEY == "uuid:bf88e806-5c95-4ddb-982a-ee5d0715c9ab"
replace Q5c = 12 if KEY == "uuid:bf88e806-5c95-4ddb-982a-ee5d0715c9ab"

replace PP2 = 12 if KEY == "uuid:bf88e806-5c95-4ddb-982a-ee5d0715c9ab"
replace Q4c = 12 if KEY == "uuid:bf88e806-5c95-4ddb-982a-ee5d0715c9ab"

replace G1 = 20 if KEY == "uuid:bf88e806-5c95-4ddb-982a-ee5d0715c9ab"
replace Q3c = 20 if KEY == "uuid:bf88e806-5c95-4ddb-982a-ee5d0715c9ab"

replace G2 = 57 if KEY == "uuid:bf88e806-5c95-4ddb-982a-ee5d0715c9ab"
replace Q2c = 57 if KEY == "uuid:bf88e806-5c95-4ddb-982a-ee5d0715c9ab"

replace G3 = 51 if KEY == "uuid:bf88e806-5c95-4ddb-982a-ee5d0715c9ab"
replace Q1c = 51 if KEY == "uuid:bf88e806-5c95-4ddb-982a-ee5d0715c9ab"

*Kakuma mixed
replace PP1 = 2 if KEY == "uuid:e104f8a0-c3fa-42e8-8a26-e87e632d7ec9"
replace Q5a = 0 if KEY == "uuid:e104f8a0-c3fa-42e8-8a26-e87e632d7ec9"
replace Q5b = 0 if KEY == "uuid:e104f8a0-c3fa-42e8-8a26-e87e632d7ec9"
replace Q5c = 2 if KEY == "uuid:e104f8a0-c3fa-42e8-8a26-e87e632d7ec9"

replace PP2 = 3 if KEY == "uuid:e104f8a0-c3fa-42e8-8a26-e87e632d7ec9"
replace Q4c = 3 if KEY == "uuid:e104f8a0-c3fa-42e8-8a26-e87e632d7ec9"

replace G1 = 5 if KEY == "uuid:e104f8a0-c3fa-42e8-8a26-e87e632d7ec9"
replace Q3c = 5 if KEY == "uuid:e104f8a0-c3fa-42e8-8a26-e87e632d7ec9"

replace G2 = 7 if KEY == "uuid:e104f8a0-c3fa-42e8-8a26-e87e632d7ec9"
replace Q2c = 7 if KEY == "uuid:e104f8a0-c3fa-42e8-8a26-e87e632d7ec9"

replace G3 = 13 if KEY == "uuid:e104f8a0-c3fa-42e8-8a26-e87e632d7ec9"
replace Q1c = 13 if KEY == "uuid:e104f8a0-c3fa-42e8-8a26-e87e632d7ec9"

order G1,before(Q3a)
order G2,before(Q2a)
order G3,before(Q1a)
order PP1,before(Q5a)
order PP2,before(Q4a)

*Tab Group against schools with Braille
tab Braille_Students_VI Group

*Tab Group against schools with Braille with county
tab Braille_Students_VI Group if County == 3 &  Braille_Students_VI == 1

*Tab Group by county for Braille aided schools
tab County Group if Braille_Students_VI == 1

drop Braille_G3 Braille_G2 Braille_G1 Braille_PP2 Braille_PP1 Braille_Students Braille_Students_VI

save "Unsighted Vs Low Vision Disagregation datasets.dta",replace

// export excel using "Comments v05.xlsx", sheet(data,replace)firstrow(variables)

*Tabulations
tab Group Consent

tab Group Q6

*************************************************************************
*LBB Braille Checker Screener

*************************************************************************











