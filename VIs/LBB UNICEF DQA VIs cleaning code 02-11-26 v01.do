******************************************* STUDENT *************************************************************

***************************************************************************
****VI STUDENT Survey
***************************************************************************

**Setting the working directory
cls
clear all
cd "C:\Users\oyoo\OneDrive - Dalberg Global Development Advisors\QUALITY CONTROL\Projects\2026\Projects\UNICEF LBB\Main\Data\Raw\Student"

***import dataset

import delimited "VI\UNICEF_LBB-Visually_Impaired_Learners_Only_Field-1771449611603.csv", case(preserve)

*****************************************************************************************************************
****Formating date
*****************************************************************************************************************

**date
tostring INT_DATE, replace
gen INT_DATE1 = date(INT_DATE, "YMD")
format INT_DATE1 %td

drop INT_DATE
ren INT_DATE1 INT_DATE

order INT_DATE, after(_id)
lab var INT_DATE"Interview date"

*filter out older dates
drop if INT_DATE < td(06feb2026)

*****************************************************************************************************************
**dropping irrelevant variables
*****************************************************************************************************************
cd "C:\Users\oyoo\OneDrive - Dalberg Global Development Advisors\QUALITY CONTROL\Projects\2026\Projects\UNICEF LBB\Main\Codes\LBB-Main-Baseline-Survey\VIs"

do "dropping_irrelevant_vars_VIs.do"

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
ren School_informationGroup_label Group
lab var Group "Type of School"
lab define grp 1 "Intervention" 2 "Control"
replace Group = "1" if Group == "Intervention"
replace Group = "1" if Group == "Control"
destring Group,replace
lab values Group grp

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
lab define true_false 1"TRUE" 0"FALSE"

***Letter Knowledge
destring letter_sound_knowledge_1 - letter_sound_knowledgetime_remai letter_sound_knowledgeautoStop	- letter_sound_knowledgeitems_per_,replace

lab values letter_sound_knowledge_1 - letter_sound_knowledge_100 cor_inc

replace letter_sound_knowledgegridAutoSt = "1" if letter_sound_knowledgegridAutoSt == "true"
replace letter_sound_knowledgegridAutoSt = "0" if letter_sound_knowledgegridAutoSt == "false"
destring letter_sound_knowledgegridAutoSt,replace
lab values letter_sound_knowledgegridAutoSt true_false

ren v290 letter_sound_knowledgenum_att
ren letter_sound_knowledgenumber_of_ letter_sound_knowledgenum_corr

// bysort GRADE: summ letter_sound_knowledgenum_corr

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

ren v359 read_familiar_wordsnum_att
ren read_familiar_wordsnumber_of_ite read_familiar_wordsnum_corr

// bysort GRADE:summ read_familiar_wordsnum_corr

***Oral reading fluency
destring oral_reading_fluency_1	- oral_reading_fluencytime_remaini oral_reading_fluencyautoStop	- oral_reading_fluencyitems_per_mi,replace
lab values oral_reading_fluency_1 - oral_reading_fluency_44 cor_inc

replace oral_reading_fluencygridAutoStop = "1" if oral_reading_fluencygridAutoStop == "true"
replace oral_reading_fluencygridAutoStop = "0" if oral_reading_fluencygridAutoStop == "false"

destring oral_reading_fluencygridAutoStop,replace
lab values oral_reading_fluencygridAutoStop true_false

ren v412 oral_reading_fluencynum_att
ren oral_reading_fluencynumber_of_it oral_reading_fluencynum_corr

***Reading comprehension
destring reading_comprehension_q1 - reading_comprehension_q5,replace
lab values reading_comprehension_q1 - reading_comprehension_q5 phn

bysort GRADE: summ oral_reading_fluencynum_corr

*Identifying numbers
destring identifying_numbers_grid_1 - v440 identifying_numbers_gridautoStop,replace
lab values identifying_numbers_grid_1 - identifying_numbers_grid_20 cor_inc

replace identifying_numbers_gridgridAuto = "1" if identifying_numbers_gridgridAuto == "true"
replace identifying_numbers_gridgridAuto = "0" if identifying_numbers_gridgridAuto == "false"
destring identifying_numbers_gridgridAuto,replace
lab values identifying_numbers_gridgridAuto true_false

ren v440 identifying_numbers_gridnum_att
ren identifying_numbers_gridnumber_o identifying_numbers_gridnum_corr
replace identifying_numbers_gridnum_att = 20 if identifying_numbers_gridnum_att == 0

*Discrimination
destring number_discrimination_gridautoSt number_discrimination_grid_1 - v449,replace
ren v449 number_discrimin_gridnum_att
ren number_discrimination_gridnumber number_discrimine_gridnum_corr
replace number_discrimin_gridnum_att = 5 if number_discrimin_gridnum_att == 0
lab values number_discrimination_grid_1 - number_discrimination_grid_5 cor_inc

replace number_discrimination_gridgridAu = "1" if number_discrimination_gridgridAu == "true"
replace number_discrimination_gridgridAu = "0" if number_discrimination_gridgridAu == "false"
destring number_discrimination_gridgridAu,replace
lab values number_discrimination_gridgridAu true_false

*Number sequency
destring number_sequence_grid_1	- v457 number_sequence_gridautoStop,replace
lab values number_sequence_grid_1 - number_sequence_grid_4 cor_inc

ren v457 number_sequence_gridnum_att
ren number_sequence_gridnumber_of_it number_sequence_gridnum_corr
replace number_sequence_gridnum_att = 4 if number_sequence_gridnum_att == 0

replace number_sequence_gridgridAutoStop = "1" if number_sequence_gridgridAutoStop == "true"
replace number_sequence_gridgridAutoStop = "0" if number_sequence_gridgridAutoStop == "false"
destring number_sequence_gridgridAutoStop,replace
lab values number_sequence_gridgridAutoStop true_false

*Addition
destring addition_grid_1 - addition_gridnumber_of_items_att addition_gridautoStop,replace
lab values addition_grid_1 - addition_grid_10 cor_inc

replace addition_gridgridAutoStopped = "1" if addition_gridgridAutoStopped == "true"
replace addition_gridgridAutoStopped = "0" if addition_gridgridAutoStopped == "false"
destring addition_gridgridAutoStopped,replace
lab values addition_gridgridAutoStopped true_false
ren addition_gridnumber_of_items_cor addition_gridnum_corr

*Subtraction
destring subtraction_grid_1 - v485 subtraction_gridautoStop,replace
ren v485 subtraction_gridnum_att
ren subtraction_gridnumber_of_items_ subtraction_gridnum_corr
lab values subtraction_grid_1 - subtraction_grid_10 cor_inc

replace subtraction_gridgridAutoStopped = "1" if subtraction_gridgridAutoStopped == "true"
replace subtraction_gridgridAutoStopped = "0" if subtraction_gridgridAutoStopped == "false"
destring subtraction_gridgridAutoStopped,replace
lab values subtraction_gridgridAutoStopped true_false

replace subtraction_gridnum_att = 10 if subtraction_gridnum_att == 0

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
// label define pc13 ///
// 1 "Alone" ///
// 2 "With another learner" ///
// 3 "In a small group" ///
// 4 "With the teacher" ///
// 5 "Not sure"

lab values PCI_Q13* yes_no

*S1-24
label define sest ///
1 "Not true" ///
2 "Somewhat true" ///
3 "Certainly true" ///
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
ren School_informationSchool_type_la SCHOOL_DESCRIPTION
replace SCHOOL_DESCRIPTION = "2" if SCHOOL_DESCRIPTION == "Inclusive/Integrated"
replace SCHOOL_DESCRIPTION = "1" if SCHOOL_DESCRIPTION == "Special School"
replace SCHOOL_DESCRIPTION = "3" if SCHOOL_DESCRIPTION == "Regular School with special unit"
destring SCHOOL_DESCRIPTION,replace
lab values SCHOOL_DESCRIPTION school_type

gen Diability_Cat = "VI Learners"

*save dataset
cd "C:\Users\oyoo\OneDrive - Dalberg Global Development Advisors\QUALITY CONTROL\Projects\2026\Projects\UNICEF LBB\Main\Data\Raw\Student\VI"

save "LBB Baseline Survey Processed data VIs.dta",replace


*QC Checks.

