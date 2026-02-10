******************************************* STUDENT *************************************************************

***************************************************************************
****NON VI STUDENT Survey
***************************************************************************
**Setting the working directory
cls
clear all
cd "C:\Users\oyoo\OneDrive - Dalberg Global Development Advisors\QUALITY CONTROL\Projects\2026\Projects\UNICEF LBB\Main\Data\Raw\Student"

***import dataset

import delimited "Non VI\UNICEF_LBB-Non-Visually_Impaired_Learners_Only-1770646949101.csv", case(preserve)

*****************************************************************************************************************
****Formating date
*****************************************************************************************************************

**date
tostring INT_DATE, replace
gen INT_DATE1 = date(INT_DATE, "MDY")
format INT_DATE1 %td

drop INT_DATE
ren INT_DATE1 INT_DATE

order INT_DATE, after(_id)
lab var INT_DATE"Interview date"

*filter out older dates
drop if INT_DATE < td(06feb2026)

******************************************************************
cd "C:\Users\oyoo\OneDrive - Dalberg Global Development Advisors\QUALITY CONTROL\Projects\2026\Projects\UNICEF LBB\Main\Codes"

do "dropping irrelevant NON-VIs.do"

drop if inlist(_id,"f22db868-7262-48ce-93b1-569b8edd8d74","4057fb88-9fd9-4416-ad25-404a7e3c1577")

*Replacing UNDEFINED && SKIPPED
ds, has(type string)
foreach var in `r(varlist)'{
	replace `var' = "" if `var' == "SKIPPED"
	replace `var' = "." if `var' == "UNDEFINED"
	replace `var' = "." if `var' == "orphaned"
}

*id
ren _id interview_ID
lab var interview_ID"Interview Unique ID"

*************************************************************************

*Supervisor
label define enum ///
1  "Linet Wanja Nkatha" ///
2  "Brian Kipkoech" ///
3  "Abdi Shafi Mohammed" ///
4  "Vallary Ochieng" ///
5  "Muga Opondo Kennedy" ///
6  "Anne Nzisa Wambua" ///
7  "Clemensia Nyaboke Nyabuto" ///
8  "Veronicah Nthikwa Mbunga" ///
9  "Harriet Oroni" ///
10 "Justiner Mutanu Mawia" ///
11 "Lydia Omari" ///
12 "Salome Wamboi" ///
13 "Linet Narasha" ///
14 "Anthony Namasaka" ///
15 "Mary Nduku" ///
16 "Boru Mohammed" ///
17 "Sheryle Amondi" ///
18 "Caroline Juma" ///
19 "Tess Olwala" ///
20 "Sharon Amonde"

lab var ENUM_NAME"Enumerator Name"
lab values ENUM_NAME enum

*Time.
gen double INT_STARTTIME1 = clock(INT_STARTTIME, "hm")
gen double INT_ENDTIME1 = clock(INT_ENDTIME, "hm")
format INT_STARTTIME1 INT_ENDTIME1 %tcHH:MM

gen double time_diff = INT_ENDTIME1 - INT_STARTTIME1
gen double Duration_mins = time_diff/(1000*60)

drop INT_STARTTIME INT_ENDTIME time_diff
ren INT_ENDTIME1 INT_ENDTIME
ren INT_STARTTIME1 INT_STARTTIME

lab var INT_STARTTIME"Interview Start time"
lab var INT_ENDTIME"Interview End time"
lab var Duration_mins"Interview Duration (Minutes)"

order INT_STARTTIME INT_ENDTIME Duration_mins,after(INT_DATE)

*Consent
lab var CONSENT "Are you ready to start?"
replace CONSENT = "1" if CONSENT == "yes"
replace CONSENT = "0" if CONSENT == "no"

lab define yes_no 1 "Yes" 0 "No"
destring CONSENT,replace
lab values CONSENT yes_no

*Group
lab var GROUP "Type of School"
lab define grp 1 "Intervention" 2 "Control"
destring GROUP,replace
lab values GROUP grp

*Grade
lab var GRADE "GRADE"
lab define grd 1 "Grade 1" 2 "Grade 2"
destring GRADE,replace
lab values GRADE grd

*Age
destring RES_AGE,replace
lab var RES_AGE "Respondent age"

*Sex
destring RES_SEX,replace
lab var RES_SEX "Respondent sex"
lab define sx 1"Male" 2"Male" 3"Other"
lab values RES_SEX sx


*universal lab define
lab define cor_inc 1"Correct" 0"Incorrect"
lab define true_false 1"True" 0"False"

***Letter Knowledge
destring letter_sound_knowledge_1 - letter_sound_knowledgetime_remai letter_sound_knowledgeautoStop	- letter_sound_knowledgeitems_per_,replace

lab values letter_sound_knowledge_1 - letter_sound_knowledge_100 cor_inc

replace letter_sound_knowledgegridAutoSt = "1" if letter_sound_knowledgegridAutoSt == "true"
replace letter_sound_knowledgegridAutoSt = "0" if letter_sound_knowledgegridAutoSt == "false"
destring letter_sound_knowledgegridAutoSt,replace
lab values letter_sound_knowledgegridAutoSt true_false

ren v161 letter_sound_knowledgenum_att

bysort GRADE: summ letter_sound_knowledgenumber_of_

*Phonemic awareness
lab define phn 1"Correct" 2"Incorrect" 3"No response"

destring phonemic_awareness_q1 - phonemic_awareness_q10, replace
lab values phonemic_awareness_q1 - phonemic_awareness_q10 phn

***reading familiar
destring read_familiar_words_1 - read_familiar_wordstime_remainin read_familiar_wordsautoStop - read_familiar_wordsitems_per_min,replace
lab values read_familiar_words_1 - read_familiar_words_50 cor_inc

replace read_familiar_wordsgridAutoStopp = "1" if read_familiar_wordsgridAutoStopp == "true"
replace read_familiar_wordsgridAutoStopp = "0" if read_familiar_wordsgridAutoStopp == "false"

destring read_familiar_wordsgridAutoStopp,replace
lab values read_familiar_wordsgridAutoStopp true_false

ren v238 read_familiar_wordsnum_att

bysort GRADE:summ read_familiar_wordsnumber_of_ite

***Oral reading fluency
destring oral_reading_fluency_1	- oral_reading_fluencytime_remaini oral_reading_fluencyautoStop	- oral_reading_fluencyitems_per_mi,replace
lab values oral_reading_fluency_1 - oral_reading_fluency_66 cor_inc

replace oral_reading_fluencygridAutoStop = "1" if oral_reading_fluencygridAutoStop == "true"
replace oral_reading_fluencygridAutoStop = "0" if oral_reading_fluencygridAutoStop == "false"

destring oral_reading_fluencygridAutoStop,replace
lab values oral_reading_fluencygridAutoStop true_false

ren v315 oral_reading_fluencynum_att

***Reading comprehension
destring reading_comprehension_q1 - reading_comprehension_q5,replace
lab values reading_comprehension_q1 - reading_comprehension_q5 phn

bysort GRADE: summ oral_reading_fluencynumber_of_it

*Identifying numbers
destring identifying_numbers_grid_1 - identifying_numbers_grid_15 identifying_numbers_gridautoStop - identifying_numbers_griditems_pe,replace
lab values identifying_numbers_grid_1 - identifying_numbers_grid_15 cor_inc

replace identifying_numbers_gridgridAuto = "1" if identifying_numbers_gridgridAuto == "true"
replace identifying_numbers_gridgridAuto = "0" if identifying_numbers_gridgridAuto == "false"
destring identifying_numbers_gridgridAuto,replace
lab values identifying_numbers_gridgridAuto true_false

ren v350 identifying_numbers_gridnum_att
replace identifying_numbers_gridnum_att = 15 if identifying_numbers_gridnum_att == 0

*Discrimination
destring number_discrimination_gridautoSt number_discrimination_grid_1 - v365,replace
ren v365 number_discrimin_gridnum_att
replace number_discrimin_gridnum_att = 10 if number_discrimin_gridnum_att == 0
lab values number_discrimination_grid_1 - number_discrimination_grid_10 cor_inc

replace number_discrimination_gridgridAu = "1" if number_discrimination_gridgridAu == "true"
replace number_discrimination_gridgridAu = "0" if number_discrimination_gridgridAu == "false"
destring number_discrimination_gridgridAu,replace
lab values number_discrimination_gridgridAu true_false

*Number sequency
destring number_sequence_grid_1	- v378 number_sequence_gridautoStop,replace
lab values number_sequence_grid_1 - number_sequence_grid_7 cor_inc

ren v378 number_sequence_gridnum_att
replace number_sequence_gridnum_att = 7 if number_sequence_gridnum_att == 0

replace number_sequence_gridgridAutoStop = "1" if number_sequence_gridgridAutoStop == "true"
replace number_sequence_gridgridAutoStop = "0" if number_sequence_gridgridAutoStop == "false"
destring number_sequence_gridgridAutoStop,replace
lab values number_sequence_gridgridAutoStop true_false

*Addition
destring addition_grid_1 - addition_gridnumber_of_items_att addition_gridautoStop,replace
lab values addition_grid_1 - addition_grid_20 cor_inc

replace addition_gridgridAutoStopped = "1" if addition_gridgridAutoStopped == "true"
replace addition_gridgridAutoStopped = "0" if addition_gridgridAutoStopped == "false"
destring addition_gridgridAutoStopped,replace
lab values addition_gridgridAutoStopped true_false

*Subtraction
destring subtraction_grid_1 - v430 subtraction_gridautoStop,replace
ren v430 subtraction_gridnum_att
lab values subtraction_grid_1 - subtraction_grid_20 cor_inc

replace subtraction_gridgridAutoStopped = "1" if subtraction_gridgridAutoStopped == "true"
replace subtraction_gridgridAutoStopped = "0" if subtraction_gridgridAutoStopped == "false"
destring subtraction_gridgridAutoStopped,replace
lab values subtraction_gridgridAutoStopped true_false

replace subtraction_gridnum_att = 20 if subtraction_gridnum_att == 0

*PCI
destring PCI_Q1 - PCI_Q2_98 PCI_Q2a_1 - PCI_Q2a_98 PCI_Q3 PCI_Q4	PCI_Q5 PCI_Q6 - PCI_Q10_98 PCI_Q11 - S29,replace

*PCI_Q1
lab values PCI_Q1 yes_no
recode PCI_Q1(2=0)

*PCI_Q2
lab values PCI_Q2_1 - PCI_Q2_98 yes_no

lab values PCI_Q2a_1 - PCI_Q2a_98 yes_no

lab define pc3 1"Kiswahili" 2"English" 96"Other (specify others)" 98"Do not know/No response"

lab values PCI_Q3 pc3

*PC1_Q4
lab define ys_rs 1"Yes" 0"No" 98"Do not know/No response"
lab values PCI_Q4 ys_rs

*PCI_Q5
lab define pc5 1"PP2" 2"PP2" 3"Grade 1" 4"Grade 2" 96"Other (Specify others)" 98 "Do not know/No response"

lab values PCI_Q5 pc5
lab values PCI_Q6 PCI_Q7 PCI_Q8 PCI_Q9 PCI_Q11 PCI_Q12 ys_rs
lab values PCI_Q10_1 - PCI_Q10_98 yes_no

*PC_Q13
label define pc13 ///
1 "Alone" ///
2 "With another learner" ///
3 "In a small group" ///
4 "With the teacher" ///
5 "Not sure"

lab values PCI_Q13 pc13

*S1-24
label define sest ///
1 "Not True" ///
2 "Somewhat True" ///
3 "Certainly True" ///
98 "Do not know"

lab values S1 - S24 sest

*S25
label define s25 ///
0 "No" ///
1 "Yes, minor difficulties" ///
2 "Yes, definite difficulties" ///
3 "Yes, severe difficulties"

lab values S25 s25

*S26
label define s26 ///
1 "Less than a month" ///
2 "1-5 months" ///
3 "6-12 months" ///
4 "Over a year"
lab values S26 s26

*S27
label define s27 ///
1 "Not at all" ///
2 "Only a little" ///
3 "A medium amount" ///
4 "A great deal"
lab values S27 S28a	- S28d S29 s27

*D
label define dsec ///
1  "No difficulty" ///
2  "Some difficulty" ///
3  "A lot of difficulty" ///
4  "Cannot hear at all" ///
98 "Don't know/Refuse to answer"
destring D1 - D6,replace
lab values D1 - D6 dsec

*SCHOOL_DESCRIPTION
label define school_type 1 "Special School" 2 "Inclusive/Integrated School" 3 "Regular School with special unit"
destring SCHOOL_DESCRIPTION,replace
lab values SCHOOL_DESCRIPTION school_type

*Location
do "Location-NON VIs.do"


*****************************************************************************************************************
**Value labelling
*****************************************************************************************************************
do "Labelling_file.do"

*****************************************************************************************************************
**QC Checks
*************************************************************************
drop if Consent == 0

replace Student_Name = trim(strproper(Student_Name))
replace B6_S = trim(strproper(B6_S))

fsjb

********************************QC checks-Flaggings
***************************************************************************************
* QC files
cd "${gsdQChecks}"

* Create the date folders
****************************************************************************************************

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

* QC files
cd "${dates}"

* var_kept
global var_kept "interview_ID INT_DATE INT_STARTTIME INT_ENDTIME survey_language ENUM_NAME assessment_type interviewer_type IA IEF Arrondissement Commune Echantillon Ecole Groupe Language official_language teaching_language Student_Name B2 B3 B4"

** generate a Comment based on the issue raised
gen issue_comment = ""

***************************************************************************
**Duration of interview check
preserve
replace issue_comment ="interview duration is Longer or Shorter, kindly clarify"
keep if !inrange(Duration_mins,45,90)
cap export excel $var_kept Duration_mins issue_comment using "MOHEBS DQA issues ${dates} v01.xlsx", sheet(duration_issues,replace)firstrow(variables)
restore

*Lag time check

*Step 2: Sort by enumerator and time
bysort INT_DATE ENUM_NAME (INT_STARTTIME): gen gap_mins = (INT_STARTTIME - INT_ENDTIME[_n-1]) / 60000 if _n > 1

preserve
// replace issue_comment ="Time taken to the next interview is way wierd, seems the interview started earlier or overlapped the other interview, kindly clarify"
keep if !inrange(gap_mins,0,10)
cap export excel $var_kept INT_STARTTIME INT_ENDTIME gap_mins issue_comment using "LBB DQA issues v01.xlsx", sheet(lag_time_issues,replace)firstrow(variables)
restore

**GPS Accuracy
preserve
destring GPSaccuracy,replace
// replace issue_comment ="The GPS Accuracy captured is low"
keep if GPSaccuracy> 20
cap export excel $var_kept GPS* issue_comment using "LBB DQA issues v01.xlsx", sheet(GPSaccuracy_issues,replace)firstrow(variables)
restore

**Duplicates GPS
duplicates tag GPSlatitude GPSlongitude, gen (gps_dup)

preserve
// replace issue_comment ="The GPS captured are duplicated, kindly clarify"
keep if gps_dup> 0
cap export excel $var_kept GPS* issue_comment using "LBB DQA issues v01.xlsx", sheet(gps_duplicates_issues,replace)firstrow(variables)
restore

**Duplicates Interviews_General
duplicates tag, gen (Interview_gen_dup)

preserve
// replace issue_comment ="The interviews have duplicates, kindly clarify"
keep if Interview_gen_dup> 0
cap export excel $var_kept issue_comment using "LBB DQA issues v01.xlsx", sheet(Interv_dupl_gen_issues,replace)firstrow(variables)
restore

**Duplicates Interviews_Main
duplicates tag SCHOOL Student_Name B2 B3 B4,gen(int_dup)

preserve
replace issue_comment ="The interviews have duplicates, kindly clarify"
keep if int_dup>0
cap export excel $var_kept int_dup issue_comment using "MOHEBS DQA issues ${dates} v01.xlsx", sheet(Interv_dupl_main_issues,replace)firstrow(variables)
restore

////////

*Official language against Survey_language
*Grade 1 C1.
preserve
replace issue_comment ="The survey language is different from the official language yet it is grade 1 student, Kindly clarify"
keep if survey_language == 1 & B4 == 1
cap export excel $var_kept issue_comment using "MOHEBS DQA issues ${dates} v01.xlsx", sheet(Language_mismatch_gr1,replace)firstrow(variables)
restore 

*Grade 1 C3.
preserve
replace issue_comment ="The survey language is not French yet the student is grade 3, Kindly clarify"
keep if survey_language != 1 & B4 == 3
cap export excel $var_kept issue_comment using "MOHEBS DQA issues ${dates} v01.xlsx", sheet(Language_mismatch_gr3,replace)firstrow(variables)
restore 


/////////

*Semantic section
*Semantic 1
*Listen to the recordings
preserve
replace issue_comment ="Timer in the Semantic section 1 was not started or started and stopped immediately, kindly clarify"
keep if (semantic_language_timer1time_rem != 0 & word_count_language_1 <= 10 & semantic_language_timer1gridAuto == 0)| (semantic_language_timer1time_rem != 0 & semantic_language_timer1gridAuto == 1 & word_count_language_1 <= 10)
cap export excel $var_kept semantic_language_timer1duration	semantic_language_timer1time_rem semantic_language_timer1gridAuto word_count_language_1	interviewer_semantic_1 issue_comment using "MOHEBS DQA issues ${dates} v01.xlsx", sheet(semantic_1,replace)firstrow(variables)
restore 

*Semantic 2
*Listen to the recordings
preserve
replace issue_comment ="Timer in the Semantic section 2 was not started or started and stopped immediately, kindly clarify"
keep if (semantic_language_timer2time_rem != 0 & word_count_language_2 <= 10 & semantic_language_timer2gridAuto == 0)| (semantic_language_timer2time_rem != 0 & semantic_language_timer2gridAuto == 1 & word_count_language_2 <= 10)
cap export excel $var_kept semantic_language_timer2duration	semantic_language_timer2time_rem semantic_language_timer2gridAuto word_count_language_2	interviewer_semantic_2 issue_comment using "MOHEBS DQA issues ${dates} v01.xlsx", sheet(semantic_2,replace)firstrow(variables)
restore 

*Semantic 3
*Listen to the recordings
preserve
replace issue_comment ="Timer in the Semantic section 3 was not started or started and stopped immediately, kindly clarify"
keep if (semantic_language_timer3time_rem != 0 & word_count_language_3 <= 10 & semantic_language_timer3gridAuto == 0)| (semantic_language_timer3time_rem != 0 & semantic_language_timer3gridAuto == 1 & word_count_language_3 <= 10)
cap export excel $var_kept semantic_language_timer3duration	semantic_language_timer3time_rem semantic_language_timer3gridAuto word_count_language_3	interviewer_semantic_3 issue_comment using "MOHEBS DQA issues ${dates} v01.xlsx", sheet(semantic_3,replace)firstrow(variables)
restore 

*Letter_knowledge 
*listen to recordings
*fr
preserve
replace issue_comment ="Timer in the letter knowledge was not started or started and stopped immediately, kindly clarify"
keep if (letter_knowledge_frduration - letter_knowledge_frtime_remainin < 60 & letter_knowledge_frgridAutoStopp == 0) | letter_knowledge_frgridAutoStopp == 1 | letter_knowledge_frnum_att < 8
cap export excel $var_kept letter_knowledge_recording_fr -  letter_knowledge_reason_fr issue_comment using "MOHEBS DQA issues ${dates} v01.xlsx", sheet(Letter_knowledge_fr_time,replace)firstrow(variables)
restore

*wf
preserve
replace issue_comment ="Timer in the letter knowledge was not started or started and stopped immediately, kindly clarify"
keep if (letter_knowledge_wfduration - letter_knowledge_wftime_remainin < 60 & letter_knowledge_wfgridAutoStopp == 0) | letter_knowledge_wfgridAutoStopp == 1 | letter_knowledge_wfnum_att < 8
cap export excel $var_kept letter_knowledge_recording_wf -  letter_knowledge_reason_wf issue_comment using "MOHEBS DQA issues ${dates} v01.xlsx", sheet(Letter_knowledge_wf_time,replace)firstrow(variables)
restore

*sr
preserve
replace issue_comment ="Timer in the letter knowledge was not started or started and stopped immediately, kindly clarify"
keep if (letter_knowledge_srduration - letter_knowledge_srtime_remainin  < 60 & letter_knowledge_srgridAutoStopp == 0)| letter_knowledge_srgridAutoStopp == 1 | letter_knowledge_srnum_att < 8
cap export excel $var_kept letter_knowledge_recording_sr -  letter_knowledge_reason_sr issue_comment using "MOHEBS DQA issues ${dates} v01.xlsx", sheet(Letter_knowledge_sr_time,replace)firstrow(variables)
restore

*pr
preserve
replace issue_comment ="Timer in the letter knowledge was not started or started and stopped immediately, kindly clarify"
keep if (letter_knowledge_prduration - letter_knowledge_prtime_remainin  < 60 & letter_knowledge_prgridAutoStopp == 0)| letter_knowledge_prgridAutoStopp == 1 | letter_knowledge_prnum_att < 8
cap export excel $var_kept letter_knowledge_recording_pr -  letter_knowledge_reason_pr issue_comment using "MOHEBS DQA issues ${dates} v01.xlsx", sheet(Letter_knowledge_pr_time,replace)firstrow(variables)
restore

*stops
*fr
preserve
replace issue_comment ="The stop rule was activated or was not activated by the system however the stop rule question says it was/was not, kindly clarify"
keep if (letter_knowledge_stop_fr != letter_knowledge_frgridAutoStopp)
cap export excel $var_kept letter_knowledge_recording_fr -  letter_knowledge_stop_fr issue_comment using "MOHEBS DQA issues ${dates} v01.xlsx", sheet(letter_knowledge_fr_stop,replace)firstrow(variables)
restore

*wf
preserve
replace issue_comment ="The stop rule was activated or was not activated by the system however the stop rule question says it was/was not, kindly clarify"
keep if (letter_knowledge_stop_wf != letter_knowledge_wfgridAutoStopp)
cap export excel $var_kept letter_knowledge_recording_wf -  letter_knowledge_stop_wf issue_comment using "MOHEBS DQA issues ${dates} v01.xlsx", sheet(letter_knowledge_wf_stop,replace)firstrow(variables)
restore

*sr
preserve
replace issue_comment ="The stop rule was activated or was not activated by the system however the stop rule question says it was/was not, kindly clarify"
keep if (letter_knowledge_stop_sr != letter_knowledge_srgridAutoStopp)
cap export excel $var_kept letter_knowledge_recording_sr -  letter_knowledge_stop_sr issue_comment using "MOHEBS DQA issues ${dates} v01.xlsx", sheet(letter_knowledge_sr_stop,replace)firstrow(variables)
restore

*pr
preserve
replace issue_comment ="The stop rule was activated or was not activated by the system however the stop rule question says it was/was not, kindly clarify"
keep if (letter_knowledge_stop_pr != letter_knowledge_prgridAutoStopp)
cap export excel $var_kept letter_knowledge_recording_pr -  letter_knowledge_stop_pr issue_comment using "MOHEBS DQA issues ${dates} v01.xlsx", sheet(letter_knowledge_pr_stop,replace)firstrow(variables)
restore

*letter part B
*fr
preserve
replace issue_comment ="Timer in the letter knowledge in part B was not started or started and stopped immediately, kindly clarify"
keep if (letter_knowledge_fr_Bduration - letter_knowledge_fr_Btime_remain < 60 & letter_knowledge_fr_BgridAutoSto == 0)| letter_knowledge_fr_BgridAutoSto == 1 | letter_knowledge_fr_Bnum_att < 8
cap export excel $var_kept letter_knowledge_fr_B_1 -  letter_knowledge_fr_Bitems_per_m issue_comment using "MOHEBS DQA issues ${dates} v01.xlsx", sheet(Letter_knowledge_B_fr_time,replace)firstrow(variables)
restore

*wf
preserve
replace issue_comment ="Timer in the letter knowledge in part B was not started or started and stopped immediately, kindly clarify"
keep if (letter_knowledge_wf_Bduration - letter_knowledge_wf_Btime_remain < 60 & letter_knowledge_wf_BgridAutoSto == 0) | letter_knowledge_wf_BgridAutoSto == 1 | letter_knowledge_wf_Bnum_att < 8
cap export excel $var_kept letter_knowledge_wf_B_1 -  letter_knowledge_wf_Bitems_per_m issue_comment using "MOHEBS DQA issues ${dates} v01.xlsx", sheet(Letter_knowledge_B_wf_time,replace)firstrow(variables)
restore

*sr
preserve
replace issue_comment ="Timer in the letter knowledge in part B was not started or started and stopped immediately, kindly clarify"
keep if (letter_knowledge_sr_Bduration - letter_knowledge_sr_Btime_remain < 60 & letter_knowledge_sr_BgridAutoSto == 0)| letter_knowledge_sr_BgridAutoSto == 1 | letter_knowledge_sr_Bnum_att < 8
cap export excel $var_kept letter_knowledge_sr_B_1 -  letter_knowledge_sr_Bitems_per_m issue_comment using "MOHEBS DQA issues ${dates} v01.xlsx", sheet(Letter_knowledge_B_sr_time,replace)firstrow(variables)
restore

*pr
preserve
replace issue_comment ="Timer in the letter knowledge in part B was not started or started and stopped immediately, kindly clarify"
keep if (letter_knowledge_pr_Bduration - letter_knowledge_pr_Btime_remain < 60 & letter_knowledge_pr_BgridAutoSto == 0)| letter_knowledge_pr_BgridAutoSto == 1 | letter_knowledge_pr_Bnum_att < 8
cap export excel $var_kept letter_knowledge_pr_B_1 -  letter_knowledge_pr_Bitems_per_m issue_comment using "MOHEBS DQA issues ${dates} v01.xlsx", sheet(Letter_knowledge_B_pr_time,replace)firstrow(variables)
restore

* reading familiar 
*Listen to the recordings
*fr
preserve
replace issue_comment ="Timer in the Reading familiar words was not started or started and stopped immediately, kindly clarify"
keep if (read_familiar_words_frduration - read_familiar_words_frtime_remai < 60 & read_familiar_words_frgridAutoSt == 0) | read_familiar_words_frgridAutoSt == 1 | reading_familiar_words_frnum_att < 8
cap export excel $var_kept read_familiar_words_fr_1 - read_familiar_words_fritems_per_ issue_comment using "MOHEBS DQA issues ${dates} v01.xlsx", sheet(reading_familiar_fr_time,replace)firstrow(variables)
restore

*wf
preserve
replace issue_comment ="Timer in the Reading familiar words was not started or started and stopped immediately, kindly clarify"
keep if (read_familiar_words_wfduration - read_familiar_words_wftime_remai < 60 & read_familiar_words_wfgridAutoSt == 0) | read_familiar_words_wfgridAutoSt == 1 | reading_familiar_words_wfnum_att < 8
cap export excel $var_kept read_familiar_words_wf_1 - read_familiar_words_wfitems_per_ issue_comment using "MOHEBS DQA issues ${dates} v01.xlsx", sheet(reading_familiar_wf_time,replace)firstrow(variables)
restore

*sr
preserve
replace issue_comment ="Timer in the Reading familiar words was not started or started and stopped immediately, kindly clarify"
keep if (read_familiar_words_srduration - read_familiar_words_srtime_remai < 60 & read_familiar_words_srgridAutoSt == 0)| read_familiar_words_srgridAutoSt == 1 | reading_familiar_words_srnum_att < 8
cap export excel $var_kept read_familiar_words_sr_1 - read_familiar_words_sritems_per_ issue_comment using "MOHEBS DQA issues ${dates} v01.xlsx", sheet(reading_familiar_sr_time,replace)firstrow(variables)
restore

*pr
preserve
replace issue_comment ="Timer in the Reading familiar words was not started or started and stopped immediately, kindly clarify"
keep if (read_familiar_words_prduration - read_familiar_words_prtime_remai < 60 & read_familiar_words_prgridAutoSt == 0)| read_familiar_words_prgridAutoSt == 1 | reading_familiar_words_prnum_att < 8
cap export excel $var_kept read_familiar_words_pr_1 - read_familiar_words_pritems_per_ issue_comment using "MOHEBS DQA issues ${dates} v01.xlsx", sheet(reading_familiar_pr_time,replace)firstrow(variables)
restore

*stops
*fr
preserve
replace issue_comment ="The stop rule was activated or was not activated by the system however the stop rule question says it was/was not, kindly clarify"
keep if (read_familiar_stop_fr != read_familiar_words_frgridAutoSt)
cap export excel $var_kept read_familiar_words_fr_1 - read_familiar_stop_fr issue_comment using "MOHEBS DQA issues ${dates} v01.xlsx", sheet(reading_familiar_fr_stop,replace)firstrow(variables)
restore

*wf
preserve
replace issue_comment ="The stop rule was activated or was not activated by the system however the stop rule question says it was/was not, kindly clarify"
keep if (read_familiar_stop_wf != read_familiar_words_wfgridAutoSt)
cap export excel $var_kept read_familiar_words_wf_1 - read_familiar_stop_wf issue_comment using "MOHEBS DQA issues ${dates} v01.xlsx", sheet(reading_familiar_fr_stop,replace)firstrow(variables)
restore

*sr
preserve
replace issue_comment ="The stop rule was activated or was not activated by the system however the stop rule question says it was/was not, kindly clarify"
keep if (read_familiar_stop_sr != read_familiar_words_srgridAutoSt)
cap export excel $var_kept read_familiar_words_sr_1 - read_familiar_stop_sr issue_comment using "MOHEBS DQA issues ${dates} v01.xlsx", sheet(reading_familiar_fr_stop,replace)firstrow(variables)
restore

*pr
preserve
replace issue_comment ="The stop rule was activated or was not activated by the system however the stop rule question says it was/was not, kindly clarify"
keep if (read_familiar_stop_pr != read_familiar_words_prgridAutoSt)
cap export excel $var_kept read_familiar_words_pr_1 - read_familiar_stop_pr issue_comment using "MOHEBS DQA issues ${dates} v01.xlsx", sheet(reading_familiar_fr_stop,replace)firstrow(variables)
restore

*Familiar part B
*fr
preserve
replace issue_comment ="Timer in the Reading familiar words was not started or started and stopped immediately, kindly clarify"
keep if (read_familiar_words_fr_Bduration - read_familiar_words_fr_Btime_rem < 60 & read_familiar_words_fr_BgridAuto == 0)| read_familiar_words_fr_BgridAuto == 1 | reading_famila_word_fr_Bnum_att < 8
cap export excel $var_kept read_familiar_words_fr_B_1 - read_familiar_words_fr_Bitems_pe issue_comment using "MOHEBS DQA issues ${dates} v01.xlsx", sheet(reading_familiar_B_fr_time,replace)firstrow(variables)
restore

*wf
preserve
replace issue_comment ="Timer in the Reading familiar words was not started or started and stopped immediately, kindly clarify"
keep if (read_familiar_words_wf_Bduration - read_familiar_words_wf_Btime_rem < 60 & read_familiar_words_wf_BgridAuto == 0) | read_familiar_words_fr_BgridAuto == 1 | reading_famila_word_fr_Bnum_att < 8
cap export excel $var_kept read_familiar_words_wf_B_1 - read_familiar_words_wf_Bitems_pe issue_comment using "MOHEBS DQA issues ${dates} v01.xlsx", sheet(reading_familiar_B_wf_time,replace)firstrow(variables)
restore

*sr
preserve
replace issue_comment ="Timer in the Reading familiar words was not started or started and stopped immediately, kindly clarify"
keep if (read_familiar_words_sr_Bduration - read_familiar_words_sr_Btime_rem < 60 & read_familiar_words_sr_BgridAuto == 0) | read_familiar_words_sr_BgridAuto == 1 | reading_famila_word_sr_Bnum_att < 8
cap export excel $var_kept read_familiar_words_sr_B_1 - read_familiar_words_sr_Bitems_pe issue_comment using "MOHEBS DQA issues ${dates} v01.xlsx", sheet(reading_familiar_B_sr_time,replace)firstrow(variables)
restore

*pr
preserve
replace issue_comment ="Timer in the Reading familiar words was not started or started and stopped immediately, kindly clarify"
keep if (read_familiar_words_pr_Bduration - read_familiar_words_pr_Btime_rem < 60 & read_familiar_words_pr_Btime_rem == 0)| read_familiar_words_pr_BgridAuto == 1 | reading_famila_word_pr_Bnum_att < 8
cap export excel $var_kept read_familiar_words_pr_B_1 - read_familiar_words_pr_Bitems_pe issue_comment using "MOHEBS DQA issues ${dates} v01.xlsx", sheet(reading_familiar_B_pr_time,replace)firstrow(variables)
restore

* reading Invented
*Listen to recordings 
*fr
preserve
replace issue_comment ="Timer in the Reading invented words was not started or started and stopped immediately, kindly clarify"
keep if (read_invented_words_frduration - read_invented_words_frtime_remai < 60 & read_invented_words_frgridAutoSt == 0)| read_invented_words_frgridAutoSt == 1 | read_invented_words_frnum_att < 8
cap export excel $var_kept read_invented_words_fr_1 - read_invented_words_fritems_per_ issue_comment using "MOHEBS DQA issues ${dates} v01.xlsx", sheet(read_invented_fr_time,replace)firstrow(variables)
restore

*wf
preserve
replace issue_comment ="Timer in the Reading invented words was not started or started and stopped immediately, kindly clarify"
keep if (read_invented_words_wfduration - read_invented_words_wftime_remai < 60 & read_invented_words_wfgridAutoSt == 0) | read_invented_words_wfgridAutoSt == 1 | read_invented_words_wfnum_att < 8
cap export excel $var_kept read_invented_words_wf_1 - read_invented_words_wfitems_per_ issue_comment using "MOHEBS DQA issues ${dates} v01.xlsx", sheet(read_invented_wf_time,replace)firstrow(variables)
restore

*sr
preserve
replace issue_comment ="Timer in the Reading invented words was not started or started and stopped immediately, kindly clarify"
keep if (read_invented_words_srduration - read_invented_words_srtime_remai < 60 & read_invented_words_srgridAutoSt == 0)| read_invented_words_srgridAutoSt == 1 | read_invented_words_srnum_att < 8
cap export excel $var_kept read_invented_words_sr_1 - read_invented_words_sritems_per_ issue_comment using "MOHEBS DQA issues ${dates} v01.xlsx", sheet(read_invented_sr_time,replace)firstrow(variables)
restore

*pr
preserve
replace issue_comment ="Timer in the Reading invented words was not started or started and stopped immediately, kindly clarify"
keep if (read_invented_words_prduration - read_invented_words_prtime_remai < 60 & read_invented_words_prgridAutoSt == 0)| read_invented_words_prgridAutoSt == 1 | read_invented_words_prnum_att < 8
cap export excel $var_kept read_invented_words_pr_1 - read_invented_words_pritems_per_ issue_comment using "MOHEBS DQA issues ${dates} v01.xlsx", sheet(read_invented_pr_time,replace)firstrow(variables)
restore

*stops
*fr
preserve
replace issue_comment ="The stop rule was activated or was not activated by the system however the stop rule question says it was/was not, kindly clarify"
keep if (read_invented_stop_fr != read_invented_words_frgridAutoSt)
cap export excel $var_kept read_invented_words_fr_1 - read_invented_stop_fr issue_comment using "MOHEBS DQA issues ${dates} v01.xlsx", sheet(read_invented_fr_stop,replace)firstrow(variables)
restore

*wf
preserve
replace issue_comment ="The stop rule was activated or was not activated by the system however the stop rule question says it was/was not, kindly clarify"
keep if (read_invented_stop_wf != read_invented_words_wfgridAutoSt)
cap export excel $var_kept read_invented_words_wf_1 - read_invented_stop_wf issue_comment using "MOHEBS DQA issues ${dates} v01.xlsx", sheet(read_invented_wf_stop,replace)firstrow(variables)
restore

*sr
preserve
replace issue_comment ="The stop rule was activated or was not activated by the system however the stop rule question says it was/was not, kindly clarify"
keep if (read_invented_stop_sr != read_invented_words_srgridAutoSt)
cap export excel $var_kept read_invented_words_sr_1 - read_invented_stop_sr issue_comment using "MOHEBS DQA issues ${dates} v01.xlsx", sheet(read_invented_sr_stop,replace)firstrow(variables)
restore

*pr
preserve
replace issue_comment ="The stop rule was activated or was not activated by the system however the stop rule question says it was/was not, kindly clarify"
keep if (read_invented_stop_pr != read_invented_words_prgridAutoSt)
cap export excel $var_kept read_invented_words_pr_1 - read_invented_stop_pr issue_comment using "MOHEBS DQA issues ${dates} v01.xlsx", sheet(read_invented_pr_stop,replace)firstrow(variables)
restore

*Invented part B
*fr
preserve
replace issue_comment ="Timer in the Reading invented words was not started or started and stopped immediately, kindly clarify"
keep if (read_invented_words_fr_Bduration - read_invented_words_fr_Btime_rem < 60 & read_invented_words_fr_BgridAuto == 0)| read_invented_words_fr_BgridAuto == 1 | read_invented_word_fr_Bnum_att < 8
cap export excel $var_kept read_invented_words_fr_B_1 - read_invented_words_fr_Bitems_pe issue_comment using "MOHEBS DQA issues ${dates} v01.xlsx", sheet(read_invented_B_fr_time,replace)firstrow(variables)
restore

*wf
preserve
replace issue_comment ="Timer in the Reading invented words was not started or started and stopped immediately, kindly clarify"
keep if (read_invented_words_wf_Bduration - read_invented_words_wf_Btime_rem < 60 & read_invented_words_wf_BgridAuto == 0) | read_invented_words_wf_BgridAuto == 1 | read_invented_word_wf_Bnum_att < 8
cap export excel $var_kept read_invented_words_wf_B_1 - read_invented_words_wf_Bitems_pe issue_comment using "MOHEBS DQA issues ${dates} v01.xlsx", sheet(read_invented_B_wf_time,replace)firstrow(variables)
restore

*sr
preserve
replace issue_comment ="Timer in the Reading invented words was not started or started and stopped immediately, kindly clarify"
keep if (read_invented_words_sr_Bduration - read_invented_words_sr_Btime_rem < 60 & read_invented_words_sr_BgridAuto == 0)| read_invented_words_sr_BgridAuto == 1 | read_invented_word_sr_Bnum_att < 8
cap export excel $var_kept read_invented_words_sr_B_1 - read_invented_words_sr_Bitems_pe issue_comment using "MOHEBS DQA issues ${dates} v01.xlsx", sheet(read_invented_B_sr_time,replace)firstrow(variables)
restore

*pr
preserve
replace issue_comment ="Timer in the Reading invented words was not started or started and stopped immediately, kindly clarify"
keep if (read_invented_words_pr_Bduration - read_invented_words_pr_Btime_rem < 60 & read_invented_words_pr_BgridAuto == 0) | read_invented_words_pr_BgridAuto == 1 | read_invented_word_pr_Bnum_att < 8
cap export excel $var_kept read_invented_words_pr_B_1 - read_invented_words_pr_Bitems_pe issue_comment using "MOHEBS DQA issues ${dates} v01.xlsx", sheet(read_invented_B_pr_time,replace)firstrow(variables)
restore

// * Oral fluency 
*fr
preserve
replace issue_comment ="Timer in the oral reading fluency statements was not started or started and stopped immediately, kindly clarify"
keep if (oral_reading_fluency_frtime_rema >30 & oral_reading_fluency_frnum_att < 20)
cap export excel $var_kept oral_reading_fluency_fr_1 - oral_reading_fluency_stop_fr issue_comment using "MOHEBS DQA issues ${dates} v01.xlsx", sheet(oral_fluency_fr_time,replace)firstrow(variables)
restore

*wf
preserve
replace issue_comment ="Timer in the oral reading fluency statements was not started or started and stopped immediately, kindly clarify"
keep if (oral_reading_fluency_wftime_rema >30 & oral_reading_fluency_wfnum_att < 20)
cap export excel $var_kept oral_reading_fluency_wf_1 - oral_reading_fluency_stop_wf issue_comment using "MOHEBS DQA issues ${dates} v01.xlsx", sheet(oral_fluency_wf_time,replace)firstrow(variables)
restore

// *sr
// preserve
// replace issue_comment ="Timer in the oral reading fluency statements was not started or started and stopped immediately, kindly clarify"
// keep if (oral_reading_fluency_srtime_rema >30 & oral_reading_fluency_srnum_att < 20)
// cap export excel $var_kept oral_reading_fluency_sr_1 - oral_reading_fluency_stop_sr issue_comment using "MOHEBS DQA issues ${dates} v01.xlsx", sheet(oral_fluency_sr_time,replace)firstrow(variables)
// restore

*pr
preserve
replace issue_comment ="Timer in the oral reading fluency statements was not started or started and stopped immediately, kindly clarify"
keep if (oral_reading_fluency_prtime_rema >30 & oral_reading_fluency_prnum_att < 20)
cap export excel $var_kept oral_reading_fluency_pr_1 - oral_reading_fluency_stop_pr issue_comment using "MOHEBS DQA issues ${dates} v01.xlsx", sheet(oral_fluency_pr_time,replace)firstrow(variables)
restore


**Languages spoken and used home by kid is different from the interview survey language

****Baseline data Quick descriptive analysis of the scores fareness.
*Letter_knowledge part a
summ letter_knowledge_frnum_att letter_knowledge_frnumber_of_ite 

*Letter_knowledge part b
summ letter_knowledge_fr_Bnum_att letter_knowledge_fr_Bnumber_of_i 

*reading familiar part a
summ reading_familiar_words_frnum_att read_familiar_words_frnumber_of_ reading_familiar_words_srnum_att read_familiar_words_srnumber_of_ reading_familiar_words_prnum_att read_familiar_words_prnumber_of_ reading_familiar_words_wfnum_att read_familiar_words_wfnumber_of_ 

*reading familiar part b
summ reading_famila_word_fr_Bnum_att read_familiar_words_fr_Bnumber_o 

*reading invented part a
summ read_invented_words_frnum_att read_invented_words_frnumber_of_ 

*reading invented part b
summ read_invented_word_fr_Bnum_att read_invented_words_fr_Bnumber_o 

*phonological_awareness
*view manually
*compute average scores/descriptive
summ phonological_awareness_prnumber_ phonological_awareness_srnumber_ phonological_awareness_wfnumber_ phonological_awareness_frnumber_

*oral reading
summ oral_reading_fluency_frnum_att oral_reading_fluency_frnumber_of oral_reading_fluency_prnum_att oral_reading_fluency_prnumber_of oral_reading_fluency_wfnum_att oral_reading_fluency_wfnumber_of

****END********************************************************************

***************************************************************************
****TEACHERS Survey
***************************************************************************


**Setting the working directory
cls
clear all
cd ""

***import dataset
import spss using "Main\Teachers\MOHEBS Teachers' Survey_WIDE.sav"

**Converting date to stata format calender
// *sort time and date
replace INT_DATE = dofc(INT_DATE)
format INT_DATE %td

lab var INT_DATE"Interview Date"

*Time.
gen str8 START_TIME_str = string(START_TIME, "%tcHH:MM:SS")
gen str8 END_TIME_str   = string(END_TIME,   "%tcHH:MM:SS")


*dropping irrelevant variables
drop SubmissionDate username starttime endtime deviceid devicephonenum device_info duration caseid Enum_calc instanceID formdef_version

*Dropping unconsented interviews.
drop if Consent == 0

*Respondent Name
replace Firstname = strproper(Firstname)
replace Lastname = strproper(Lastname)

gen RES_NAME = Firstname + " " + Lastname
order RES_NAME, before(female)
lab var RES_NAME"Respondent names"

*lab variables.
lab var Policy_1"Policy_1. What is/are the language(s) of instruction of this school?"


*Location
cd "${gsdCode}\MOHEBS\cleaning do file"
do "Location_Teachers.do"

*Grade
lab var Grade_1"CI (first grade)"
lab var Grade_2"CP (second grade)"
lab var Grade_3"CE1 (third grade)"
lab var Grade_96"Other, specify"

*correction
replace Policy_2b_4 = 60 if inlist(KEY,"uuid:114000bf-25ef-4e9f-a3de-406820fcc4f9", "uuid:4a06c160-0357-40e9-bbed-2e9b6386c823","uuid:13be05b0-67d9-4d59-8bbb-949c71ab1323","uuid:01be1d22-0d4e-42dd-a612-d4d75454a3ac","uuid:0f2e41b2-e374-41c7-b1ac-0e8eceb227b0")

replace Policy_2b_4 = 300 if KEY == "uuid:5aabf678-237e-4fb0-8c56-71c2eecbf136"

replace Policy_2b_2 = 60 if inlist(KEY,"uuid:3eb84e41-41a8-4401-b592-2e4f79d54ba6", "uuid:1088507b-fb7b-404f-9015-0d717f279931","uuid:5d6da021-050f-4c5b-b735-c843bb904eeb","uuid:1e228b04-6d08-4cbd-a1d1-5aac081dfab1")

replace Policy_3b_1 = 120 if inlist(KEY,"uuid:1e228b04-6d08-4cbd-a1d1-5aac081dfab1")

replace Policy_3b_1 = 60 if inlist(KEY,"uuid:3eb84e41-41a8-4401-b592-2e4f79d54ba6","uuid:3eb84e41-41a8-4401-b592-2e4f79d54ba6")

replace Policy_3b_1 = 300 if inlist(KEY,"uuid:9fcc85e0-1322-4600-85cd-7aba28b13daa","uuid:af5363f0-58c7-4414-b79c-fc98944a650e")

replace Policy_3b_1 = 120 if KEY == "uuid:1e228b04-6d08-4cbd-a1d1-5aac081dfab1"

replace Policy_3b_2 = 60 if inlist(KEY,"uuid:5d6da021-050f-4c5b-b735-c843bb904eeb","uuid:3eb84e41-41a8-4401-b592-2e4f79d54ba6")

replace Policy_3b_2 = 180 if inlist(KEY,"uuid:1088507b-fb7b-404f-9015-0d717f279931")

replace Policy_3b_2 = 240 if inlist(KEY,"uuid:1e228b04-6d08-4cbd-a1d1-5aac081dfab1")

replace Policy_3b_2 = 300 if inlist(KEY,"uuid:3143c533-280b-4b21-9ffc-75f848b08269")

replace Policy_3b_3 = 300 if inlist(KEY,"uuid:9fcc85e0-1322-4600-85cd-7aba28b13daa")
replace Policy_3b_4 = 180 if inlist(KEY,"uuid:114000bf-25ef-4e9f-a3de-406820fcc4f9")

replace Policy_3b_4=Policy_3b_4*60 if inlist(KEY,"uuid:13be05b0-67d9-4d59-8bbb-949c71ab1323","uuid:0f2e41b2-e374-41c7-b1ac-0e8eceb227b0","uuid:5aabf678-237e-4fb0-8c56-71c2eecbf136","uuid:01be1d22-0d4e-42dd-a612-d4d75454a3ac")


//////
replace Policy_4b_1 = Policy_4b_1 * 60 if inlist(KEY,"uuid:9a19fdf5-aff8-4906-831f-16eb3ac4eb78","uuid:c9b81b90-20ae-4cb4-b7f1-686b0c6c54fb","uuid:def5b794-0023-4a0e-b709-7ac768d28d19","uuid:145784b4-fad8-4fd3-95b6-41792ea4ee4b","uuid:e9762f7c-acc9-4723-b6c0-8092f5c4796a","uuid:0643e63e-745d-4163-8d74-2811197ae644","uuid:9fcc85e0-1322-4600-85cd-7aba28b13daa")

replace Policy_4b_1 = Policy_4b_1 * 60 if inlist(KEY,"uuid:13be05b0-67d9-4d59-8bbb-949c71ab1323","uuid:e5dcdb6f-11c5-4e96-8e93-d7c6dcfe1d7e","uuid:12dcd295-5e99-430e-a7b9-6af729fda951","uuid:a9c4b952-e16f-4509-b0d0-bc3c5eee44fe","uuid:10b9c100-ca7b-42de-aa6e-9450e3ea00f2")

replace Policy_4b_2 = Policy_4b_2*60 if inlist(KEY, "uuid:9a19fdf5-aff8-4906-831f-16eb3ac4eb78","uuid:c9b81b90-20ae-4cb4-b7f1-686b0c6c54fb","uuid:145784b4-fad8-4fd3-95b6-41792ea4ee4b","uuid:7e5596b4-082b-4935-b293-72556ebd2347","uuid:0d35b9d9-f50f-4a27-b640-784fb9f87360")

replace Policy_4b_3 = Policy_4b_3*60 if inlist(KEY, "uuid:9fcc85e0-1322-4600-85cd-7aba28b13daa","uuid:d1de3d83-1eab-4d23-8dcb-6b7b053a0743")

replace Policy_5b_1 = Policy_5b_1*60 if inlist(KEY, "uuid:9a19fdf5-aff8-4906-831f-16eb3ac4eb78","uuid:0643e63e-745d-4163-8d74-2811197ae644","uuid:def5b794-0023-4a0e-b709-7ac768d28d19","uuid:145784b4-fad8-4fd3-95b6-41792ea4ee4b","uuid:7e5596b4-082b-4935-b293-72556ebd2347","uuid:e9762f7c-acc9-4723-b6c0-8092f5c4796a","uuid:13be05b0-67d9-4d59-8bbb-949c71ab1323","uuid:e5dcdb6f-11c5-4e96-8e93-d7c6dcfe1d7e")

replace Policy_5b_2 = Policy_5b_2*60 if inlist(KEY, "uuid:9a19fdf5-aff8-4906-831f-16eb3ac4eb78","uuid:c9b81b90-20ae-4cb4-b7f1-686b0c6c54fb","uuid:def5b794-0023-4a0e-b709-7ac768d28d19","uuid:145784b4-fad8-4fd3-95b6-41792ea4ee4b")


replace Policy_5b_3 = Policy_5b_3*60 if inlist(KEY, "uuid:9fcc85e0-1322-4600-85cd-7aba28b13daa","uuid:d1de3d83-1eab-4d23-8dcb-6b7b053a0743")


replace Policy_5b_4 = Policy_5b_4*60 if inlist(KEY, "uuid:0643e63e-745d-4163-8d74-2811197ae644","uuid:7e5596b4-082b-4935-b293-72556ebd2347","uuid:13be05b0-67d9-4d59-8bbb-949c71ab1323","uuid:12dcd295-5e99-430e-a7b9-6af729fda951","uuid:10b9c100-ca7b-42de-aa6e-9450e3ea00f2","uuid:e5dcdb6f-11c5-4e96-8e93-d7c6dcfe1d7e")


order KEY

lab var Firstname"What is your first name"
lab var Lastname"What is your last name"
lab var  female"female. Is the respondent a man or a woman?"
lab var  RH_past_a"RH_past_a. Did you practice Remédiation Harmonisée during the 2024 – 2025 school year?"
lab var  RH_past_b"RH_past_b. Which grade did you practice Remédiation Harmonisée during the 2024 – 2025 school year"
lab var  Age"Age. How old are you?"
lab var  Edu"Edu. What is your highest educational qualification?"
lab var  Grade"Grade. What grade do you currently teach in the 2025 – 2026 school year?"
lab var  Grade_S"Grade. Please specify other"
lab var  RH_hoursa"RH_hoursa. How many hours per week do you teach math in Remédiation Harmonisée to CI students in your classroom?"
lab var  RH_hoursb"RH_hoursb. How many hours per week do you teach reading in Remédiation Harmonisée to CI students in your classroom?"
lab var  RH_hoursc"RH_hoursc. How many hours per week do you teach math in Remédiation Harmonisée to CP students in your classroom?"
lab var  RH_hoursd"RH_hoursd. How many hours per week do you teach reading in Remédiation Harmonisée to CP students in your classroom?"
lab var  MM_hoursa"MM_hoursa. How many hours per week do you teach MOHEBS math/math in national languages to CI students in your classroom?"
lab var  Lang_1a"Lang_1a. What languages do the CP students in this classroom speak as their national language?"
lab var  Lang_1a_1"Wolof"
lab var  Lang_1a_2"Pulaar"
lab var  Lang_1a_3"Serer"
lab var  Lang_1a_96"Other, specify"
lab var  Lang_1a_S"Lang_1a_S. Please specify Other specify?"
lab var  Lang_1b"Lang_1b. What languages do the CI students in this classroom speak as their  national language?"
lab var  Lang_1b_1"French"
lab var  Lang_1b_2"Wolof"
lab var  Lang_1b_3"Pulaar"
lab var  Lang_1b_4"Serer"
lab var  Lang_1b_96"Other, specify"
lab var  Lang_1b_S"Lang_1b_S. Please specify Other specify?"

lab var  Lang_2"Lang_2. What is your own mother tongue? "
lab var  Lang_2_S"Lang_2_S. What is your own mother tongue? Other specify?"
lab var  Lang_3"Lang_3. How comfortable are you speaking the students' national language?"
lab var  Lang_4"Lang_4. How comfortable are you reading in the students' national language?"
lab var  Lang_5"Lang_5. How comfortable are you speaking French?"
lab var  Lang_6"Lang_6. How comfortable are you reading in French?"
lab var  Policy_2a"Policy_2a. In the CI classroom you teach, which language(s) do you use to teach math in class?"
lab var  Policy_2a_1"French"
lab var  Policy_2a_2"Wolof"
lab var  Policy_2a_3"Pulaar"
lab var  Policy_2a_4"Serer"
gen Policy_2b = .
order Policy_2b,before(Policy_2b_1)
lab var  Policy_2b"Policy_2b. In the CI classroom you teach, how much time do you spend teaching math in each language on a daily basis?"
lab var  Policy_2b_1"Policy_2b_1. French"

lab var  Policy_2b_2"Policy_2b_2. Wolof"

lab var  Policy_2b_3"Policy_2b_3. Pulaar"

lab var  Policy_2b_4"Policy_2b_4. Serer"

lab var  Policy_2c"Policy_2c. While teaching math in the CI classroom, at what point do you switch languages?"
lab var  Policy_2c_0"I do not switch languages"
lab var  Policy_2c_1"When a student asks a question in a different language"
lab var  Policy_2c_2"When students appear confused or disengaged "
lab var  Policy_2c_3"When introducing a new concept"
lab var  Policy_2c_4"When giving instructions for activities"
lab var  Policy_2c_5"When addressing individuals during one-on-one support"
lab var  Policy_2c_6"When translating key vocabulary terms"
lab var  Policy_2c_7"I alternate languages with every instruction"
lab var  Policy_2c_8"I spend half of the class speaking one language and then switch to the other"
lab var  Policy_3a"Policy_3a. In the CI classroom you teach, which language(s) do you use to teach reading in class?"
lab var  Policy_3a_1"French"
lab var  Policy_3a_2"Wolof"
lab var  Policy_3a_3"Pulaar"
lab var  Policy_3a_4"Serer"

gen Policy_3b = .
order Policy_3b,before(Policy_3b_1)
lab var  Policy_3b"Policy_3b. In the CI classroom you teach, how much time do you spend teaching reading in each language, on a daily basis?"
lab var  Policy_3b_1"French"
lab var  Policy_3b_2"Wolof"
lab var  Policy_3b_3"Pulaar"
lab var  Policy_3b_4"Serer"

lab var  Policy_3c"Policy_3c. While teaching reading in the CI classroom, at what point do you switch languages?"

lab var  Policy_3c_0"I do not switch languages"
lab var  Policy_3c_1"When a student asks a question in a different language"
lab var  Policy_3c_2"When students appear confused or disengaged "
lab var  Policy_3c_3"When introducing a new concept"
lab var  Policy_3c_4"When giving instructions for activities"
lab var  Policy_3c_5"When addressing individuals during one-on-one support"
lab var  Policy_3c_6"When translating key vocabulary terms"
lab var  Policy_3c_7"I alternate languages with every instruction"
lab var  Policy_3c_8"I spend half of the class speaking one language and then switch to the other"
lab var  Policy_4a"Policy_4a. In the CP classroom you teach, which language(s) do you use to teach math in class?"
lab var  Policy_4a_1"French"
lab var  Policy_4a_2"Wolof"
lab var  Policy_4a_3"Pulaar"
lab var  Policy_4a_4"Serer"

gen Policy_4b = .
order Policy_4b,before(Policy_4b_1)
lab var  Policy_4b"Policy_4b. In the CP classroom you teach, how much time do you spend teaching math in each language, on a daily basis?"

lab var  Policy_4b_1"French"
lab var  Policy_4b_2"Wolof"
lab var  Policy_4b_3"Pulaar"
lab var  Policy_4b_4"Serer"

lab var  Policy_4c"Policy_4c. While teaching math in the CP classroom, at what point do you switch languages?"
lab var  Policy_4c_0"I do not switch languages"
lab var  Policy_4c_1"When a student asks a question in a different language"
lab var  Policy_4c_2"When students appear confused or disengaged "
lab var  Policy_4c_3"When introducing a new concept"
lab var  Policy_4c_4"When giving instructions for activities"
lab var  Policy_4c_5"When addressing individuals during one-on-one support"
lab var  Policy_4c_6"When translating key vocabulary terms"
lab var  Policy_4c_7"I alternate languages with every instruction"
lab var  Policy_4c_8"I spend half of the class speaking one language and then switch to the other"

lab var  Policy_5a"Policy_5a. In the CP classroom you teach, which language(s) do you use to teach reading in class?"
lab var  Policy_5a_1"French"
lab var  Policy_5a_2"Wolof"
lab var  Policy_5a_3"Pulaar"
lab var  Policy_5a_4"Serer"
gen Policy_5b = .
order Policy_5b,before(Policy_5b_1)
lab var  Policy_5b"Policy_5b. In the CP classroom you teach, how much time do you spend teaching reading in each language,on a daily basis?"
lab var  Policy_5b_1"French"
lab var  Policy_5b_2"Wolof"
lab var  Policy_5b_3"Pulaar"
lab var  Policy_5b_4"Serer"

lab var  Policy_5c"Policy_5c. While teaching reading in the CP classroom, at what point do you switch languages?"

lab var  Policy_5c_0"I do not switch languages"
lab var  Policy_5c_1"When a student asks a question in a different language"
lab var  Policy_5c_2"When students appear confused or disengaged "
lab var  Policy_5c_3"When introducing a new concept"
lab var  Policy_5c_4"When giving instructions for activities"
lab var  Policy_5c_5"When addressing individuals during one-on-one support"
lab var  Policy_5c_6"When translating key vocabulary terms"
lab var  Policy_5c_7"I alternate languages with every instruction"
lab var  Policy_5c_8"I spend half of the class speaking one language and then switch to the other"

lab var  Lang_7"Lang_7. Do any of your CI students NOT speak the school language of instruction in this classroom? "
lab var  Lang_7a"Lang_7a. How many students is that?"
lab var  Lang_7b"Lang_7b. Out of how many students in the CI class? "
lab var  Lang_8"Lang_8. Do any of your CP students NOT speak ${Policy_calc} in this classroom? "
lab var  Lang_8a"Lang_8a. How many students is that for ${Policy_calc} ? "
lab var  Lang_8b"Lang_8b. Out of how many students in the CP class?  ${Policy_calc}"
lab var  Lang_9"Lang_9. How do you manage teaching in a multilingual classroom?"
lab var  nl_1a"nl_1a. Did you participate in the CI MOHEBS math training (formation de base) at the start of the school year?"
lab var  nl_1b"nl_1b. Was this training sufficient? "
lab var  nl_1c"nl_1c. How many days did you attend in total?"
lab var  nl_2a"nl_2a. Did you participate in the Remédiation Harmonisée training at the start of the school year?"
lab var  nl_2b"nl_2b. Was this training sufficient? "
lab var  nl_2c"nl_2c. How many days did you attend in total?"
lab var  nl_3a"nl_3a. Did you participate in the training related to teaching reading in the national languages at the start of the school year?"
lab var  nl_3b"nl_3b. Was this training sufficient? "
lab var  nl_3c"nl_3c. How many days did you attend in total?"
lab var  exp_1"exp_1. How many service years do you have as a teacher?"

lab var  Mat_1"Mat_1. Do you have the student math textbooks in national language for the CI classroom you teach?"
lab var  Mat_2"Mat_2. Do you have the teacher's math guide in national language for the CI classroom you teach?"
lab var  Mat_3"Mat_3. Do students in your classroom have their own national language math textbooks?"
lab var  Mat_4"Mat_4. What is the math textbook/student ratio in your CI classroom?"
lab var  Mat_5"Mat_5. Are there national language supplementary math materials available for you to support your lesson in this classroom?"
lab var  Mat_6"Mat_6. Are these national language supplementary math materials accessible to the students you teach?"
lab var  Mat_7"Mat_7. Does the school provide you with the necessary support in your effort to teach students how to do math in their national language?"
lab var  Mat_8"Mat_8. Do you have the student math textbooks in national language for the Remédiation Harmonisée classroom you teach?"
lab var  Mat_9"Mat_9. Do you have the teacher's math guide in national language for the Remédiation Harmonisée classroom you teach?"
lab var  Mat_10"Mat_10. Do students in your Remédiation Harmonisée classroom have their own national language math textbooks?"
lab var  Mat_11"Mat_11. What is the math textbook/student ratio in your Remédiation Harmonisée classroom? "
lab var  Mat_12"Mat_12. Are there national language supplementary math materials available for you to support your lesson in this Remédiation Harmonisée classroom?"
lab var  Mat_13"Mat_13. Are these national language supplementary math materials accessible to the students you teach in this Remédiation Harmonisée classroom?"
lab var  Mat_14"Mat_14. Do you have  student reading textbooks in the national language for the Remédiation Harmonisée classroom you teach?"
lab var  Mat_15"Mat_15. Do you have the teacher's reading guide in national language for the Remédiation Harmonisée classroom you teach?"
lab var  Mat_16"Mat_16. Do students in your Remédiation Harmonisée classroom have their own national language reading textbooks?"
lab var  Mat_17"Mat_17. What is the reading textbook/student ratio in your Remédiation Harmonisée classroom? "
lab var  Mat_18"Mat_18. Are there national language supplementary reading materials available for you to support your lesson in this Remédiation Harmonisée classroom?"
lab var  Mat_19"Mat_19. Are these national language supplementary reading materials accessible to the students you teach in this Remédiation Harmonisée classroom?"
lab var  E1"Enumerator Question: How confident are you that the teacher understood all your questions in the ${lang_calc1}?"
lab var  Lang_9_1"I only teach in one language"
lab var  Lang_9_2"I repeat every instruction and lecture line-by-line in each language"
lab var  Lang_9_3"I teach in the majority language first and then repeat in the second language"
lab var  Lang_9_4"I lecture in the majority language and give instructions in all languages"

*correction
drop if KEY == "uuid:1c4905eb-47ba-4a42-b1be-3025b87a791d"

*correction school
replace School = 21 if KEY == "uuid:b2fb7271-d881-4991-b183-34112d05e4f5"
replace School = 35 if inlist(KEY,"uuid:4cb3de4f-a249-40a4-9328-4ef0599449e5","uuid:232da800-f169-45ac-9abf-a05c1cd4e259")

*6-12
replace Policy_2c_7 = 0 if inlist(KEY,"uuid:4a079558-5dad-4c9a-bad7-b855dd6888ac","uuid:5d6da021-050f-4c5b-b735-c843bb904eeb","uuid:8ea4c161-60fd-4438-91f4-72a2578e48fe")
replace Policy_2c_0 = 1 if inlist(KEY,"uuid:4a079558-5dad-4c9a-bad7-b855dd6888ac","uuid:5d6da021-050f-4c5b-b735-c843bb904eeb","uuid:8ea4c161-60fd-4438-91f4-72a2578e48fe")
replace Policy_2c = "0" if inlist(KEY,"uuid:4a079558-5dad-4c9a-bad7-b855dd6888ac","uuid:5d6da021-050f-4c5b-b735-c843bb904eeb","uuid:8ea4c161-60fd-4438-91f4-72a2578e48fe")

replace Policy_2c_2 = 0 if inlist(KEY,"uuid:114000bf-25ef-4e9f-a3de-406820fcc4f9","uuid:821df7ab-67ff-437a-8ae3-8fc29415d968")
replace Policy_2c_0 = 1 if inlist(KEY,"uuid:114000bf-25ef-4e9f-a3de-406820fcc4f9","uuid:821df7ab-67ff-437a-8ae3-8fc29415d968")
replace Policy_2c = "0" if inlist(KEY,"uuid:114000bf-25ef-4e9f-a3de-406820fcc4f9","uuid:821df7ab-67ff-437a-8ae3-8fc29415d968")

replace Policy_2c_3 = 0 if inlist(KEY,"uuid:f8541d27-5e55-4799-8914-4feb81647cff")
replace Policy_2c_0 = 1 if inlist(KEY,"uuid:f8541d27-5e55-4799-8914-4feb81647cff")
replace Policy_2c = "0" if inlist(KEY,"uuid:f8541d27-5e55-4799-8914-4feb81647cff")

replace Policy_4c_2 = 0 if inlist(KEY,"uuid:114000bf-25ef-4e9f-a3de-406820fcc4f9","uuid:821df7ab-67ff-437a-8ae3-8fc29415d968")
replace Policy_4c_0 = 1 if inlist(KEY,"uuid:4e5c8c66-8fef-4357-b7ed-c05c0283e5f1","uuid:c127f20c-c009-4c82-8e38-df6a8318b1e7","uuid:0643e63e-745d-4163-8d74-2811197ae644")
replace Policy_4c = "0" if inlist(KEY,"uuid:4e5c8c66-8fef-4357-b7ed-c05c0283e5f1","uuid:c127f20c-c009-4c82-8e38-df6a8318b1e7","uuid:0643e63e-745d-4163-8d74-2811197ae644")

*9-12
replace Policy_4b_1 = 120 if KEY == "uuid:54b234c2-1262-42d6-8319-3fee863498bc"

replace Policy_4b_4 = 120 if KEY == "uuid:54b234c2-1262-42d6-8319-3fee863498bc"

replace Policy_5b_1 = 120 if KEY == "uuid:54b234c2-1262-42d6-8319-3fee863498bc"
replace Policy_5b_2 = 120 if KEY == "uuid:54b234c2-1262-42d6-8319-3fee863498bc"

replace Policy_4c_2 = 0 if inlist(KEY,"uuid:6534acef-d634-4f96-817f-2f09a8f71a03","uuid:54b234c2-1262-42d6-8319-3fee863498bc")
replace Policy_4c_0 = 1 if inlist(KEY,"uuid:6534acef-d634-4f96-817f-2f09a8f71a03","uuid:54b234c2-1262-42d6-8319-3fee863498bc")
replace Policy_4c = "0" if inlist(KEY,"uuid:6534acef-d634-4f96-817f-2f09a8f71a03","uuid:54b234c2-1262-42d6-8319-3fee863498bc")

replace Policy_4c_7 = 0 if KEY == "uuid:56324526-16fb-4629-8476-4c83651f6c89"
replace Policy_4c_0 = 1 if KEY == "uuid:56324526-16fb-4629-8476-4c83651f6c89"
replace Policy_4c = "0" if KEY == "uuid:56324526-16fb-4629-8476-4c83651f6c89"

replace Policy_2c_7 = 0 if KEY == "uuid:397f2d5a-75d7-4a89-a4e3-13a64fda34f9"
replace Policy_2c_0 = 1 if KEY == "uuid:397f2d5a-75d7-4a89-a4e3-13a64fda34f9"
replace Policy_2c = "0" if KEY == "uuid:397f2d5a-75d7-4a89-a4e3-13a64fda34f9"

*10-12
replace Policy_2c_7 = 0 if KEY == "uuid:909ffbd4-1771-4958-81a6-7c9c05b86d0c"
replace Policy_2c_0 = 1 if KEY == "uuid:909ffbd4-1771-4958-81a6-7c9c05b86d0c"
replace Policy_2c = "0" if KEY == "uuid:909ffbd4-1771-4958-81a6-7c9c05b86d0c"

replace Policy_4c_2 = 0 if KEY == "uuid:c0153de4-6d99-4f05-8deb-c9f34ec00b66"
replace Policy_4c_0 = 1 if KEY == "uuid:c0153de4-6d99-4f05-8deb-c9f34ec00b66"
replace Policy_4c = "0" if KEY == "uuid:c0153de4-6d99-4f05-8deb-c9f34ec00b66"

*11-12
replace Policy_3b_4 = 240 if KEY == "uuid:1d248b04-b7b5-44e1-b1eb-cbb985a2602c"

*12-12
replace Policy_4b_1 = 60 if KEY == "uuid:e6415062-657e-47f4-98cc-b67fd5c15ba1"
replace Policy_3b_2 = 120 if KEY == "uuid:868ebc27-e83b-4c04-beee-df1ff11885ce"
replace Policy_2b_2 = 60 if KEY == "uuid:868ebc27-e83b-4c04-beee-df1ff11885ce"

*13-12
replace Policy_4c_3 = 0 if KEY == "uuid:ee853fdd-1c1a-42d5-8f93-8b03c7f788a2"
replace Policy_4c_0 = 1 if KEY == "uuid:ee853fdd-1c1a-42d5-8f93-8b03c7f788a2"
replace Policy_4c = "0" if KEY == "uuid:ee853fdd-1c1a-42d5-8f93-8b03c7f788a2"

*15-12
replace Policy_2c_5 = 0 if KEY == "uuid:0ab3b0f1-b3f9-4b99-b152-ea1d1a748ef0"
replace Policy_2c_0 = 1 if KEY == "uuid:0ab3b0f1-b3f9-4b99-b152-ea1d1a748ef0"
replace Policy_2c = "0" if KEY == "uuid:0ab3b0f1-b3f9-4b99-b152-ea1d1a748ef0"

replace Policy_4b_1 = 60 if KEY == "uuid:f4c9fda5-00c5-4ee9-a3df-28a2eb28f27a"


replace Policy_4c_3 = 0 if KEY == "uuid:ee853fdd-1c1a-42d5-8f93-8b03c7f788a2"
replace Policy_4c_0 = 1 if KEY == "uuid:ee853fdd-1c1a-42d5-8f93-8b03c7f788a2"
replace Policy_4c = "0" if KEY == "uuid:ee853fdd-1c1a-42d5-8f93-8b03c7f788a2"

replace Policy_4c_1 = 0 if KEY == "uuid:f4c9fda5-00c5-4ee9-a3df-28a2eb28f27a"
replace Policy_4c_0 = 1 if KEY == "uuid:f4c9fda5-00c5-4ee9-a3df-28a2eb28f27a"
replace Policy_4c = "0" if KEY == "uuid:f4c9fda5-00c5-4ee9-a3df-28a2eb28f27a"

replace Policy_4c_2 = 0 if KEY == "uuid:b917086a-00ec-4b5d-b51e-e3c66eb9152f"
replace Policy_4c_0 = 1 if KEY == "uuid:b917086a-00ec-4b5d-b51e-e3c66eb9152f"
replace Policy_4c = "0" if KEY == "uuid:b917086a-00ec-4b5d-b51e-e3c66eb9152f"

*17-12
replace Policy_2b_4 = 60 if KEY == "uuid:f8ffd9ab-ee6a-487a-812c-ae6f7e3622ef"

replace Policy_2c_2 = 0 if KEY == "uuid:65e1cde4-b869-420c-8fce-14dd5ab2fb19"
replace Policy_2c_0 = 1 if KEY == "uuid:65e1cde4-b869-420c-8fce-14dd5ab2fb19"
replace Policy_2c = "0" if KEY == "uuid:65e1cde4-b869-420c-8fce-14dd5ab2fb19"

replace Policy_2c_7 = 0 if KEY == "uuid:f8ffd9ab-ee6a-487a-812c-ae6f7e3622ef"
replace Policy_2c_0 = 1 if KEY == "uuid:f8ffd9ab-ee6a-487a-812c-ae6f7e3622ef"
replace Policy_2c = "0" if KEY == "uuid:f8ffd9ab-ee6a-487a-812c-ae6f7e3622ef"

replace Policy_3b_4 = 60 if KEY == "uuid:f8ffd9ab-ee6a-487a-812c-ae6f7e3622ef"

replace nl_3a = 1 if KEY == "uuid:ba063100-5b26-4d24-a1f1-bf998da8de2e"
replace nl_3a = 1 if KEY == "uuid:64b1fcd7-d356-4ff7-9959-8c818807f32e"
replace nl_3c = 3 if KEY == "uuid:ba063100-5b26-4d24-a1f1-bf998da8de2e"
replace nl_3c = 5 if KEY == "uuid:64b1fcd7-d356-4ff7-9959-8c818807f32e"

replace Policy_4b_1 = 45 if KEY == "uuid:31fc0c3f-e55c-414c-82a3-70dcbac095f6"

replace Policy_4c_2 = 0 if KEY == "uuid:65e1cde4-b869-420c-8fce-14dd5ab2fb19"
replace Policy_4c_0 = 1 if KEY == "uuid:65e1cde4-b869-420c-8fce-14dd5ab2fb19"
replace Policy_4c = "0" if KEY == "uuid:65e1cde4-b869-420c-8fce-14dd5ab2fb19"

*16-12
replace START_TIME = clock("11:30:57", "hms") if KEY == "uuid:d5e6fee4-148b-4fda-a182-f56707099642"
replace END_TIME   = clock("12:00:20", "hms") if KEY == "uuid:d5e6fee4-148b-4fda-a182-f56707099642"
format START_TIME END_TIME %tcHH:MM:SS

replace Policy_2c_2 = 0 if KEY == "uuid:391d28e4-1de7-430b-99c3-9b7f0fd2fa73"
replace Policy_2c_0 = 1 if KEY == "uuid:391d28e4-1de7-430b-99c3-9b7f0fd2fa73"
replace Policy_2c = "0" if KEY == "uuid:391d28e4-1de7-430b-99c3-9b7f0fd2fa73"

replace Policy_3b_2 = 60 if KEY == "uuid:391d28e4-1de7-430b-99c3-9b7f0fd2fa73"

replace nl_3a = 1 if KEY == "uuid:d5e6fee4-148b-4fda-a182-f56707099642"
replace nl_3c = 3 if KEY == "uuid:d5e6fee4-148b-4fda-a182-f56707099642"

replace Policy_4c_6 = 0 if KEY == "uuid:eb3e1b99-aa15-48be-a1c8-37d98bab492c"
replace Policy_4c_0 = 1 if KEY == "uuid:eb3e1b99-aa15-48be-a1c8-37d98bab492c"
replace Policy_4c = "0" if KEY == "uuid:eb3e1b99-aa15-48be-a1c8-37d98bab492c"

replace Policy_4c_2 = 0 if KEY == "uuid:16cc6da5-f990-4469-9438-11e2b1a5cbaf"
replace Policy_4c_0 = 1 if KEY == "uuid:16cc6da5-f990-4469-9438-11e2b1a5cbaf"
replace Policy_4c = "0" if KEY == "uuid:16cc6da5-f990-4469-9438-11e2b1a5cbaf"

*18-12
replace nl_3a = 1 if KEY == "uuid:c8085662-7c0e-48a7-93c2-426eb32a2fc0"
replace nl_3c = 3 if KEY == "uuid:c8085662-7c0e-48a7-93c2-426eb32a2fc0"

replace Policy_5b_1 = 60 if KEY == "uuid:20ff5447-c6f2-4d7e-9c0a-aeeb34a79637"
replace Policy_5b_4 = 60 if KEY == "uuid:20ff5447-c6f2-4d7e-9c0a-aeeb34a79637"

*19-12
replace Policy_2c_2 = 0 if KEY == "uuid:d0e5db85-dbf1-4af2-9e01-391642b971c7"
replace Policy_2c_0 = 1 if KEY == "uuid:d0e5db85-dbf1-4af2-9e01-391642b971c7"
replace Policy_2c = "0" if KEY == "uuid:d0e5db85-dbf1-4af2-9e01-391642b971c7"

replace Policy_4c_6 = 0 if KEY == "uuid:525f5d2e-11a4-4b0f-8a7c-79fca2b672ad"
replace Policy_4c_0 = 1 if KEY == "uuid:525f5d2e-11a4-4b0f-8a7c-79fca2b672ad"
replace Policy_4c = "0" if KEY == "uuid:525f5d2e-11a4-4b0f-8a7c-79fca2b672ad"

*20-12
foreach x in RH_hoursa	RH_hoursb	RH_hoursc	RH_hoursd	MM_hoursa{
	replace `x' = 1 if KEY == "uuid:fcb4baf3-15bd-4dab-8c79-2c64d58fa4ae"
}

replace Policy_2c_3 = 0 if KEY == "uuid:cb472298-3ad8-4fe1-a880-35d8580822b3"
replace Policy_2c_0 = 1 if KEY == "uuid:cb472298-3ad8-4fe1-a880-35d8580822b3"
replace Policy_2c = "0" if KEY == "uuid:cb472298-3ad8-4fe1-a880-35d8580822b3"

*23-12
replace MM_hoursa = 4 if KEY == "uuid:621374a0-6b27-47db-9588-74d124efeaf6"

replace Policy_2c_2 = 0 if KEY == "uuid:6cbf0cf9-e4c7-4f2a-8b04-2a10b9644085"
replace Policy_2c_0 = 1 if KEY == "uuid:6cbf0cf9-e4c7-4f2a-8b04-2a10b9644085"
replace Policy_2c = "0" if KEY == "uuid:6cbf0cf9-e4c7-4f2a-8b04-2a10b9644085"

replace Policy_4c_2 = 0 if KEY == "uuid:621374a0-6b27-47db-9588-74d124efeaf6"
replace Policy_4c_0 = 1 if KEY == "uuid:621374a0-6b27-47db-9588-74d124efeaf6"
replace Policy_4c = "0" if KEY == "uuid:621374a0-6b27-47db-9588-74d124efeaf6"

*general
replace Policy_2b_4 = 60 if KEY == "uuid:dc0d09f9-c5c2-4cf7-a30f-9c5422081631"
replace Policy_2b_3 = 180 if KEY == "uuid:51022752-d484-45ce-a11b-633e68c45f88"
replace Policy_2b_3 = 300 if KEY =="uuid:9fcc85e0-1322-4600-85cd-7aba28b13daa"

replace Policy_2c_1 = 0 if KEY == "uuid:01be1d22-0d4e-42dd-a612-d4d75454a3ac"
replace Policy_2c_0 = 1 if KEY == "uuid:01be1d22-0d4e-42dd-a612-d4d75454a3ac"
replace Policy_2c = "0" if KEY == "uuid:01be1d22-0d4e-42dd-a612-d4d75454a3ac"

replace Policy_3b_4 = 60 if KEY == "uuid:dc0d09f9-c5c2-4cf7-a30f-9c5422081631"

replace Policy_4b_1 = 240 if KEY == "uuid:40f2e097-ca90-4e5f-8252-2e7b9823149a"
replace Policy_4b_1 = 300 if KEY =="uuid:5d90c82e-b655-4c75-b6b4-e49622f7905e"

replace Policy_4c_2 = 0 if inlist(KEY,"uuid:10b9c100-ca7b-42de-aa6e-9450e3ea00f2","uuid:e5dcdb6f-11c5-4e96-8e93-d7c6dcfe1d7e","uuid:a9c4b952-e16f-4509-b0d0-bc3c5eee44fe","uuid:e9fae69d-09e1-462e-9420-0a26758b0040","uuid:53c588e1-500d-4c5d-a070-f64d67e2e297","uuid:5d90c82e-b655-4c75-b6b4-e49622f7905e","uuid:15989193-894e-46d8-9e95-d10d8dfcb7e0","uuid:62a8f297-1dbe-4ee0-b0de-6336ce624e6c")

replace Policy_4c_0 = 1 if inlist(KEY,"uuid:10b9c100-ca7b-42de-aa6e-9450e3ea00f2","uuid:e5dcdb6f-11c5-4e96-8e93-d7c6dcfe1d7e","uuid:a9c4b952-e16f-4509-b0d0-bc3c5eee44fe","uuid:e9fae69d-09e1-462e-9420-0a26758b0040","uuid:53c588e1-500d-4c5d-a070-f64d67e2e297","uuid:5d90c82e-b655-4c75-b6b4-e49622f7905e","uuid:15989193-894e-46d8-9e95-d10d8dfcb7e0","uuid:62a8f297-1dbe-4ee0-b0de-6336ce624e6c")

replace Policy_4c = "0" if inlist(KEY,"uuid:10b9c100-ca7b-42de-aa6e-9450e3ea00f2","uuid:e5dcdb6f-11c5-4e96-8e93-d7c6dcfe1d7e","uuid:a9c4b952-e16f-4509-b0d0-bc3c5eee44fe","uuid:e9fae69d-09e1-462e-9420-0a26758b0040","uuid:53c588e1-500d-4c5d-a070-f64d67e2e297","uuid:5d90c82e-b655-4c75-b6b4-e49622f7905e","uuid:15989193-894e-46d8-9e95-d10d8dfcb7e0","uuid:62a8f297-1dbe-4ee0-b0de-6336ce624e6c")

replace Policy_5b_1 = 60 if KEY == "uuid:40f2e097-ca90-4e5f-8252-2e7b9823149a"

replace Policy_5b_4 = 60 if KEY == "uuid:40f2e097-ca90-4e5f-8252-2e7b9823149a"

replace Policy_5c_2 = 0 if KEY == "uuid:10b9c100-ca7b-42de-aa6e-9450e3ea00f2"
replace Policy_5c_0 = 1 if KEY == "uuid:10b9c100-ca7b-42de-aa6e-9450e3ea00f2"
replace Policy_5c = "0" if KEY == "uuid:10b9c100-ca7b-42de-aa6e-9450e3ea00f2"

replace Grade_S = "CM1" if inlist(KEY,"uuid:be04941f-40f5-4464-bcc5-cde707a25306","uuid:f1b15091-e512-4aa6-bb8c-af836ead7421")
replace Grade_S = "CE2" if inlist(KEY,"uuid:19a8a5fc-702c-4238-bb23-1ddf8845c847","uuid:5a2c4f91-c2e7-47b5-a193-5552514c23fb","uuid:5d90c82e-b655-4c75-b6b4-e49622f7905e")
replace Grade_S = "" if inlist(KEY,"uuid:6becb33a-3322-4c9b-936b-633a76834ae2")
replace Grade = "3" if inlist(KEY,"uuid:6becb33a-3322-4c9b-936b-633a76834ae2")
replace Grade_3 = 1 if inlist(KEY,"uuid:6becb33a-3322-4c9b-936b-633a76834ae2")
replace Grade_96 = 0 if inlist(KEY,"uuid:6becb33a-3322-4c9b-936b-633a76834ae2")

*correct RH questions
replace RH_hoursa = . if RH_school != 1 & Grade_1 != 1
replace RH_hoursb = . if RH_school != 1 & Grade_1 != 1
replace RH_hoursc = . if RH_school != 1 & (Grade_2 != 1 | Grade_2 == 1)
replace RH_hoursd = . if RH_school != 1 & (Grade_2 != 1 | Grade_2 == 1)
replace MM_hoursa = . if Grade_1 != 1

replace Lang_1a_S = trim(strproper(Lang_1a_S))

replace Policy_4b_4 = . if Grade_2 == 1 & Policy_4a_4 == 0

replace nl_3b = 1 if inlist(KEY,"uuid:64b1fcd7-d356-4ff7-9959-8c818807f32e","uuid:c8085662-7c0e-48a7-93c2-426eb32a2fc0","uuid:d5e6fee4-148b-4fda-a182-f56707099642","uuid:ba063100-5b26-4d24-a1f1-bf998da8de2e")

replace Lang_8b = 64 if KEY == "uuid:3d113855-3d00-44ba-819e-270dea1b95e8"
replace Lang_7b = 69 if KEY == "uuid:7895a853-c1ad-4085-802e-e46cec5fb867"
replace Lang_7b = 61 if KEY == "uuid:aa99b9e2-e6bf-4eb1-b87d-778468a20d4d"

replace GPS_Latitude = 14.1123520 if KEY == "uuid:2c4d5374-a3b0-476f-8c5f-28f24c25a781"
replace GPS_Longitude = -15.5389999 if KEY == "uuid:2c4d5374-a3b0-476f-8c5f-28f24c25a781"
replace GPS_Accuracy = 3.1000000 if KEY == "uuid:2c4d5374-a3b0-476f-8c5f-28f24c25a781"

drop START_TIME_str END_TIME_str grppp1 lan1 Calc1 Calc2 Calc3 Calc4 Calc5 Calc6 Calc7 Calc8 Calc9 Calc10 Calc11 Calc12 lang_calc1 Policy_calc Firstname Lastname RES_NAME   GPS_Altitude General_Comments INT_SUP1 INT_SUP2 START_TIME_str END_TIME_str grppp1 lan1

*calculate duration in minutes.
gen Duration_mins = round((END_TIME - START_TIME)/(1000*60))
lab var Duration_mins"Duration of interview in minutes"
order Duration_mins,after(START_TIME)

replace Policy_4c_2 = . if inlist(KEY,"uuid:821df7ab-67ff-437a-8ae3-8fc29415d968","uuid:114000bf-25ef-4e9f-a3de-406820fcc4f9")

// global var_kept "KEY INT_DATE START_TIME END_TIME  SUP_NAME ENUM_NAME Region School RH_school female Age GPS_Latitude GPS_Longitude GPS_Accuracy"
// export excel $var_kept using "MOHEBS GPS Teachers v01.xlsx", sheet(data,replace)firstrow(variables)

*save dataset
cd "${gsdData}\Raw"
save "Main\Teachers\MOHEBS Teachers Baseline Processed Dataset 03-02 v01.dta",replace

*save dataset
cd "${gsdData}\Processed"
save "Main\Teachers\MOHEBS Teachers Baseline Processed Dataset 03-02 v01.dta",replace

***************************************************************************************QC checks-Flaggings
***************************************************************************************

cd "${gsdQChecks}"

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

*QC files
cd "${dates}"

* var_kept

global var_kept "KEY INT_DATE START_TIME END_TIME  SUP_NAME ENUM_NAME Region School RH_school RES_NAME female Age Grade Grade_1 Grade_2 Grade_3 Grade_96 Grade_S"

** generate a Comment based on the issue raised
gen issue_comment = ""


*Duration chcek

*calculate duration in minutes.
// gen Duration_mins = round((END_TIME - START_TIME)/(1000*60))

preserve
drop END_TIME START_TIME
ren (START_TIME_str END_TIME_str) (START_TIME END_TIME)

replace issue_comment ="interview duration is *Longer* or *Shorter*, kindly clarify"
keep if !inrange(Duration_mins,25,45)
cap export excel $var_kept Duration_mins issue_comment using "MOHEBS DQA Teachers ${dates} v01.xlsx", sheet(duration_issues,replace)firstrow(variables)
restore

*Lag time check

*Step 2: Sort by enumerator and time
bysort INT_DATE ENUM_NAME (START_TIME): gen gap_mins = (START_TIME - END_TIME[_n-1]) / 60000 if _n > 1

preserve
drop END_TIME START_TIME
ren (START_TIME_str END_TIME_str) (START_TIME END_TIME)
replace issue_comment ="Time taken to the next interview is way wierd, seems the interview started earlier or overlapped the other interview, kindly clarify"
keep if !inrange(gap_mins,0,10)
cap export excel $var_kept gap_mins issue_comment using "MOHEBS DQA Teachers ${dates} v01.xlsx", sheet(lag_time_issues,replace)firstrow(variables)
restore

*GPS Accuracy
preserve
replace issue_comment = "The GPS Accuracy is way low, kindly clarify"
keep if GPS_Accuracy > 20
cap export excel $var_kept GPS_Accuracy issue_comment using "MOHEBS DQA Teachers ${dates} v01.xlsx",sheet(GPS_issues,replace)firstrow(variables)
restore

*Duplicate GPS
duplicates tag GPS_Latitude GPS_Longitude GPS_Altitude,gen(dup1)

preserve
replace issue_comment = "The interview is done on the same point of location, kindly clarify"
keep if dup1 > 0
cap export excel $var_kept GPS_Latitude GPS_Longitude GPS_Altitude issue_comment using "MOHEBS DQA Teachers ${dates} v01.xlsx",sheet(GPS_Dups_issues,replace)firstrow(variables)
restore

**Respondent Name
preserve
replace issue_comment = "The Respondent name seems invalid, kindly clarify"
keep if strlen(RES_NAME)<2
cap export excel $var_kept RES_NAME issue_comment using "MOHEBS DQA Teachers ${dates} v01.xlsx",sheet(RES_NAME_issues,replace)firstrow(variables)
restore

**Duplicate interviews Respondent Name
duplicates tag Region School,gen (dup)

preserve
replace issue_comment = "The interviews are a duplicates, kindly clarify"
keep if dup > 0
cap export excel $var_kept Region School RES_NAME dup issue_comment using "MOHEBS DQA Teachers ${dates} v01.xlsx",sheet(Interview_dup_issues,replace)firstrow(variables)
restore

*Age
preserve
replace issue_comment ="Age provided is way high or low, kindly clarify"
keep if !inrange(Age,18,45)
cap export excel $var_kept Age issue_comment using "MOHEBS DQA Teachers ${dates} v01.xlsx", sheet(Age_issues,replace)firstrow(variables)
restore

*Minutes
*RH_hoursa
preserve
replace issue_comment ="The hours per week taught in math Remédiation Harmonisée for CI students in classroom provided is way high or low, kindly clarify"
keep if !inrange(RH_hoursa,1,40)
cap export excel $var_kept RH_hoursa issue_comment using "MOHEBS DQA Teachers ${dates} v01.xlsx", sheet(RH_hoursa_issues,replace)firstrow(variables)
restore

*RH_hoursb
preserve
replace issue_comment ="The hours per week taught in reading Remédiation Harmonisée for CI students in classroom provided is way high or low, kindly clarify"
keep if !inrange(RH_hoursb,1,40)
cap export excel $var_kept RH_hoursb issue_comment using "MOHEBS DQA Teachers ${dates} v01.xlsx", sheet(RH_hoursb_issues,replace)firstrow(variables)
restore

*RH_hoursc
preserve
replace issue_comment ="The hours per week taught in math Remédiation Harmonisée for CP students in classroom provided is way high or low, kindly clarify"
keep if !inrange(RH_hoursc,1,40)
cap export excel $var_kept RH_hoursc issue_comment using "MOHEBS DQA Teachers ${dates} v01.xlsx", sheet(RH_hoursc_issues,replace)firstrow(variables)
restore

*RH_hoursd
preserve
replace issue_comment ="The hours per week taught in reading Remédiation Harmonisée for CP students in classroom provided is way high or low, kindly clarify"
keep if !inrange(RH_hoursd,1,40)
cap export excel $var_kept RH_hoursd issue_comment using "MOHEBS DQA Teachers ${dates} v01.xlsx", sheet(RH_hoursd_issues,replace)firstrow(variables)
restore

*MM_hoursa
preserve
replace issue_comment ="The hours per week taught MOHEBS math/math in national languages for CI students in classroom provided is way high or low, kindly clarify"
keep if !inrange(MM_hoursa,1,40)
cap export excel $var_kept MM_hoursa issue_comment using "MOHEBS DQA Teachers ${dates} v01.xlsx", sheet(MM_hoursa_issues,replace)firstrow(variables)
restore

*total hours
egen tot_hrs_taught = rowtotal(RH_hoursa RH_hoursb	RH_hoursc RH_hoursd	MM_hoursa)

preserve
replace issue_comment ="The hours per week taught by the teacher is way high or low, kindly clarify"
keep if !inrange(tot_hrs_taught,10,40)
cap export excel $var_kept RH_hoursa RH_hoursb	RH_hoursc RH_hoursd	MM_hoursa tot_hrs_taught issue_comment using "MOHEBS DQA Teachers ${dates} v01.xlsx", sheet(total_hours_issues,replace)firstrow(variables)
restore

*Age_experience issues
preserve
replace issue_comment = "Age versus experience do not match, kindly clarify"
gen age_exp = exp_1
replace age_exp = 1 if exp_1 == 1
replace age_exp = 3 if exp_1 == 2
replace age_exp = 5 if exp_1 == 3
replace age_exp = 10 if exp_1 == 4
replace age_exp = 11 if exp_1 == 5

keep if Age - age_exp < 18
cap export excel $var_kept Age exp_1 issue_comment using "`MOHEBS DQA Teachers ${dates} v01.xlsx'", sheet(age_experience_issues,replace)firstrow(variables)
restore

*Language as intergers check
preserve
replace issue_comment = " The language seems to be integers, kindly clarify"
keep if strlen(Lang_2_S)< 2
cap export excel $var_kept Lang_2_S issue_comment using "MOHEBS DQA Teachers ${dates} v01.xlsx", sheet(Mother_tongue_issues,replace)firstrow(variables)
restore

*French Speaking Consisitency
preserve
replace issue_comment = "Inconsistencies in French language spoken by the teacher, kindly clarify"
keep if Lang_1b_1 == 1 & (Lang_3 != Lang_5)
cap export excel $var_kept Lang_1b* Lang_3 Lang_5 issue_comment using "MOHEBS DQA Teachers ${dates} v01.xlsx", sheet(French_speak_issues,replace)firstrow(variables)
restore

*French Reading Consisitency
preserve
replace issue_comment = "Inconsistencies in French language read by the teacher, kindly clarify"
keep if Lang_1b_1 == 1 & (Lang_4 != Lang_6)
cap export excel $var_kept Lang_1b* Lang_4 Lang_6 issue_comment using "`MOHEBS DQA Teachers ${dates} v01.xlsx'", sheet(French_read_issues,replace)firstrow(variables)
restore


*Time spent teaching maths in languages

*policy_2b_1 // French
preserve
replace issue_comment = "Time spent using French to teach maths is more than 1 hour or less that 10 minutes,kindly clarify"
keep if !inrange(Policy_2b_1, 10, 60)
cap export excel $var_kept Policy_2b_1 issue_comment using "`MOHEBS DQA Teachers ${dates} v01.xlsx'", sheet(Maths_french_issues,replace)firstrow(variables)
restore

*policy_2b_2 // Wolof
preserve
replace issue_comment = "Time spent using Wolof to teach maths is more than 1 hour or less that 10 minutes,kindly clarify"
keep if !inrange(Policy_2b_2,10,60)
cap export excel $var_kept Policy_2b_2 issue_comment using "`MOHEBS DQA Teachers ${dates} v01.xlsx'", sheet(Maths_wolof_issues,replace)firstrow(variables)
restore

*policy_2b_3 // Pulaar
preserve
replace issue_comment = "Time spent using Pulaar to teach maths is more than 1 hour or less that 10 minutes, kindly clarify"
keep if !inrange(Policy_2b_3,10,60)
cap export excel $var_kept Policy_2b_3 issue_comment using "MOHEBS DQA Teachers ${dates} v01.xlsx", sheet(Maths_pulaar_issues, replace)firstrow(variables)
restore

*policy_2b_4 // Serer
preserve
replace issue_comment = "Time spent using Serer to teach maths is more than 1 hour or less that 10 minutes,kindly clarify"
keep if !inrange(Policy_2b_4, 10, 60)
cap export excel $var_kept Policy_2b_4 issue_comment using "MOHEBS DQA Teachers ${dates} v01.xlsx", sheet(Maths_serer_issues,replace)firstrow(variables)
restore 


*total time spent teaching maths in all languages
preserve
replace issue_comment = "The time spent teaching maths is more than 1 hour or less than 30 minutes, kindly clarify"
egen total_time_maths = rowtotal(Policy_2b_1 Policy_2b_2 Policy_2b_3 Policy_2b_4)
keep if !inrange(total_time_maths,30,60)
cap export excel $var_kept Policy_2b_1 Policy_2b_2 Policy_2b_3 Policy_2b_4 issue_comment using "MOHEBS DQA Teachers ${dates} v01.xlsx",sheet(mathematics_total_time_issues,replace)firstrow(variables)
restore

*checking if language count matches response "I do not switch" for maths
preserve
replace issue_comment = "More than 1 language and 'I do not switch languages' response, kindly clarify"
gen lang_count  = wordcount(Policy_2a)
keep if lang_count > 1 & Policy_2c_0 == 1
cap export excel $var_kept Policy_2a* Policy_2c_0 issue_comment using "MOHEBS DQA Teachers ${dates} v01.xlsx", sheet(maths_lang_switch_mis,replace)firstrow(variables)
restore

*checking if one language matches response "I do not switch languages" for maths
preserve
replace issue_comment = "Chose only one language in Policy_2a on languages used to teach, however in switching language during teaching they did not mention the donot sitch, kindly clarify"
gen lang_count  = wordcount(Policy_2a)
keep if lang_count == 1 & Policy_2c_0 != 1
cap export excel $var_kept Policy_2a* Policy_2c* issue_comment using "MOHEBS DQA Teachers ${dates} v01.xlsx", sheet(maths_1_lang_switch_mis,replace)firstrow(variables)
restore

*Time spent reading in languages
*policy_3b_1 * //French
preserve 
replace issue_comment = "Time using French is more than 1 hour or less that 10 minutes, kindly clarify"
keep if !inrange(Policy_3b_1,10,60)
cap export excel $var_kept Policy_3b_1 issue_comment using "MOHEBS DQA Teachers ${dates} v01.xlsx", sheet(Lang_teach_time_issues_fr,replace)firstrow(variables)
restore

*policy_3b_2 //Wolof
preserve
replace issue_comment = "Time using Wolof is more than 1 hour or less that 10 minutes, kindly clarify"
keep if !inrange(Policy_3b_2,10,60)
cap export excel $var_kept Policy_3b_2 issue_comment using "MOHEBS DQA Teachers ${dates} v01.xlsx", sheet(Lang_teach_time_issues_wf,replace)firstrow(variables)
restore

*policy_3b_3 //Pulaar
preserve
replace issue_comment = "Time using Pulaar is more than 1 hour or less that 10 minutes, kindly clarify"
keep if !inrange(Policy_3b_3,10,60)
cap export excel $var_kept Policy_3b_3 issue_comment using "MOHEBS DQA Teachers ${dates} v01.xlsx", sheet(Lang_teach_time_issues_pulaar,replace)firstrow(variables)
restore

*policy_3b_4 //Serer
preserve
replace issue_comment = "Time using Serer is more than 1 hour or less that 10 minutes, kindly clarify"
keep if !inrange(Policy_3b_4,10,60)
cap export excel $var_kept Policy_3b_4 issue_comment using "MOHEBS DQA Teachers ${dates} v01.xlsx", sheet(Lang_teach_time_issues_serer,replace)firstrow(variables)
restore

*total time spent teaching in all languages
preserve 
replace issue_comment = "Time spent in all is more or less than a lesson or double lesson, kindly clarify"
egen total_time = rowtotal(Policy_3b_1 Policy_3b_2 Policy_3b_3 Policy_3b_4)
keep if !inrange(total_time,30,60)
cap export excel $var_kept Policy_3b_1 Policy_3b_2 Policy_3b_3 Policy_3b_4 total_time issue_comment using "MOHEBS DQA Teachers ${dates} v01.xlsx",sheet(Tot_time_lang_issues,replace)firstrow(variables)
restore

*checking if language count matches response I do not switch for reading
preserve
replace issue_comment = "Chose only one language in Policy_2a on languages used to teach, however in switching language during teaching they did not mention the donot sitch, kindly clarify"
*check no of languages selected
gen lang_count  = wordcount(Policy_3a)
keep if lang_count > 1 & Policy_3c_0 == 1
cap export excel $var_kept Policy_3a* policy_3c* lang_count issue_comment using "MOHEBS DQA Teachers ${dates} v01.xlsx", sheet(read_lang_swit_mismatch,replace)firstrow(variables)
restore


*checking if only 1  language count matches response "I do not switch" for reading
preserve
replace issue_comment = "Chose only one language in Policy_2a on languages used to teach, however in switching language during teaching they did not mention the donot sitch, kindly clarify"
*check no of languages selected
gen lang_count  = wordcount(Policy_3a)
keep if lang_count == 1 & Policy_3c_0 != 1
cap export excel $var_kept Policy_3a* policy_3c* issue_comment using "MOHEBS DQA Teachers ${dates} v01.xlsx", sheet(reading_one_lang_swit_mis,replace)firstrow(variables)
restore

*checking if non_school instructions language speakers are equal to the whole classroom
preserve
replace issue_comment = "The non-school instructions language speakers can't be the whole class, kindly clarify"
keep if Lang_7 == 1 & (Lang_7a == Lang_7b)
cap export excel $var_kept Lang_7 Lang_7a Lang_7b issue_comment using "MOHEBS DQA Teachers ${dates} v01.xlsx", sheet(Non_school_intru_speakers,replace)firstrow(variables)
restore

*Checking no of training Moheb maths
preserve
replace issue_comment = "More than 30 days or 0 days training, kindly clarify"
keep if !inrange(nl_1c, 1, 30) | (nl_1a == 1 & nl_1c != - 999)
cap export excel $var_kept nl_1a nl_1c issue_comment using "MOHEBS DQA Teachers ${dates} v01.xlsx",sheet(mohebmath_train_issues,replace)firstrow(variables)
restore

*Checking no of training reading
preserve
replace issue_comment = "More than 30 days or 0 days training, kindly clarify"
keep if !inrange(nl_3c, 1, 30) | (nl_3a == 1 & nl_3c != -999)
cap export excel $var_kept nl_3a nl_3c issue_comment using "MOHEBS DQA Teachers ${dates} v01.xlsx",sheet(read_train_days_issues,replace)firstrow(variables)
restore

*Time spent teaching maths in languages for grade 2

*policy_4b_1 // French
preserve
replace issue_comment = "Time spent using French to teach maths is more than 1 hour or less that 10 minutes,kindly clarify"
keep if !inrange(Policy_4b_1, 10, 60)
cap export excel $var_kept Policy_4b_1 issue_comment using "MOHEBS DQA Teachers ${dates} v01.xlsx", sheet(Maths_french_issues_grade2,replace)firstrow(variables)
restore

*policy_4b_2 // Wolof
preserve
replace issue_comment = "Time spent using Wolof to teach maths is more than 1 hour or less that 10 minutes,kindly clarify"
keep if !inrange(Policy_4b_2,10,60)
cap export excel $var_kept Policy_4b_2 issue_comment using "MOHEBS DQA Teachers ${dates} v01.xlsx", sheet(Maths_wolof_issues_grade2,replace)firstrow(variables)
restore

*policy_4b_3 // Pulaar
preserve
replace issue_comment = "Time spent using Pulaar to teach maths is more than 1 hour or less that 10 minutes, kindly clarify"
keep if !inrange(Policy_4b_3,10,60)
cap export excel $var_kept Policy_4b_3 issue_comment using "MOHEBS DQA Teachers ${dates} v01.xlsx", sheet(Maths_pulaar_issues_grade2, replace)firstrow(variables)
restore

*policy_4b_4 // Serer
preserve
replace issue_comment = "Time spent using Serer to teach maths is more than 1 hour or less that 10 minutes,kindly clarify"
keep if !inrange(Policy_4b_4, 10, 60)
cap export excel $var_kept Policy_4b_4 issue_comment using "MOHEBS DQA Teachers ${dates} v01.xlsx", sheet(Maths_serer_grade2,replace)firstrow(variables)
restore

*total time spent teaching maths in all languages grade 2
preserve
replace issue_comment = "The time spent teaching maths is more than 1 hour or less than 30 minutes, kindly clarify"
egen total_time_maths = rowtotal(Policy_4b_1 Policy_4b_2 Policy_4b_3 Policy_4b_4)
keep if !inrange(total_time_maths,30,60)
cap export excel $var_kept Policy_4b_1 Policy_4b_2 Policy_4b_3 Policy_4b_4 issue_comment using "MOHEBS DQA Teachers ${dates} v01.xlsx",sheet(maths_tot_time_grade2,replace)firstrow(variables)
restore

*checking if language count matches response "I do not switch" for maths grade 2
preserve
replace issue_comment = "Chose only one language in Policy_2a on languages used to teach, however in switching language during teaching they did not mention the donot sitch, kindly clarify"
gen lang_count  = wordcount(Policy_4a)
keep if lang_count > 1 & Policy_4c_0 == 1
cap export excel $var_kept Policy_4a* Policy_4c* issue_comment using "MOHEBS DQA Teachers ${dates} v01.xlsx", sheet(maths_lang_swit_mismat_grade2,replace)firstrow(variables)
restore

*checking if one language matches response "I do not switch languages" for maths grade 2
preserve
replace issue_comment = "Chose only one language in Policy_2a on languages used to teach, however in switching language during teaching they did not mention the donot sitch, kindly clarify"
gen lang_count  = wordcount(Policy_4a)
keep if lang_count == 1 & Policy_4c_0 != 1
cap export excel $var_kept Policy_4a* Policy_4c* issue_comment using "MOHEBS DQA Teachers ${dates} v01.xlsx", sheet(maths_1_lang_swit_mis_grade2,replace)firstrow(variables)
restore

*Time spent reading in languages in grade 2
*policy_5b_1 * //French
preserve 
replace issue_comment = "Time using French is more than 1 hour or less that 10 minutes, kindly clarify"
keep if !inrange(Policy_5b_1,10,60)
cap export excel $var_kept Policy_5b_1 issue_comment using "MOHEBS DQA Teachers ${dates} v01.xlsx", sheet(Lang_teach_time_french_grade2,replace)firstrow(variables)
restore

*policy_5b_2 //Wolof
preserve
replace issue_comment = "Time using Wolof is more than 1 hour or less that 10 minutes, kindly clarify"
keep if !inrange(Policy_5b_2,10,60)
cap export excel $var_kept Policy_5b_2 issue_comment using "MOHEBS DQA Teachers ${dates} v01.xlsx", sheet(Lang_teach_time_wolof_grade2,replace)firstrow(variables)
restore

*policy_5b_3 //Pulaar
preserve
replace issue_comment = "Time using Pulaar is more than 1 hour or less that 10 minutes, kindly clarify"
keep if !inrange(Policy_5b_3,10,60)
cap export excel $var_kept Policy_5b_3 issue_comment using "MOHEBS DQA Teachers ${dates} v01.xlsx", sheet(Lang_teach_time_pulaar_grade2,replace)firstrow(variables)
restore

*policy_5b_4 //Serer
preserve
replace issue_comment = "Time using Serer is more than 1 hour or less that 10 minutes, kindly clarify"
keep if !inrange(Policy_5b_4,10,60)
cap export excel $var_kept Policy_5b_4 issue_comment using "MOHEBS DQA Teachers ${dates} v01.xlsx", sheet(Lang_teach_time_serer_grade2,replace)firstrow(variables)
restore

*total time spent teaching in all languages for grade 2
preserve 
replace issue_comment = "Time spent in all is more or less than a lesson or double lesson, kindly clarify"
egen total_time = rowtotal(Policy_5b_1 Policy_5b_2 Policy_5b_3 Policy_5b_4)
keep if !inrange(total_time,30,60)
cap export excel $var_kept Policy_5b_1 Policy_5b_2 Policy_5b_3 Policy_5b_4 total_time issue_comment using "MOHEBS DQA Teachers ${dates} v01.xlsx",sheet(Tot_time_spent_lang_grade2,replace)firstrow(variables)
restore

*checking if language count matches response I do not switch for reading for grade 2
preserve
replace issue_comment = "Chose only one language in Policy_2a on languages used to teach, however in switching language during teaching they did not mention the donot sitch, kindly clarify"
*check no of languages selected
gen lang_count  = wordcount(Policy_5a)
keep if lang_count > 1 & Policy_5c_0 == 1
cap export excel $var_kept Policy_5a* Policy_5c* issue_comment using "MOHEBS DQA Teachers ${dates} v01.xlsx",sheet(read_lang_swit_mis_grade2,replace)firstrow(variables)
restore

*checking if only 1  language count matches response "I do not switch" for reading for grade 2
preserve
replace issue_comment = "Chose only one language in Policy_2a on languages used to teach, however in switching language during teaching they did not mention the donot sitch, kindly clarify"
*check no of languages selected
gen lang_count  = wordcount(Policy_5a)
keep if lang_count == 1 & Policy_5c_0 != 1
cap export excel $var_kept Policy_5a* Policy_5c* issue_comment using "MOHEBS DQA Teachers ${dates} v01.xlsx", sheet(read_1_lang_swit_mis_grade2,replace)firstrow(variables)
restore

*checking if non_school instructions language speakers are equal to the whole classroom for grade 2
preserve
replace issue_comment = "The non-school instructions language speakers can't be the whole class, kindly clarify"
keep if Lang_8 == 1 & (Lang_8a == Lang_8b)
cap export excel $var_kept Lang_8 Lang_8a Lang_8b issue_comment using "MOHEBS DQA Teachers ${dates} v01.xlsx", sheet(Non_schl_intru_speak_grade2, replace)firstrow(variables)
restore







