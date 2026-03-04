******************************************* STUDENT *************************************************************

***************************************************************************
****NON VI STUDENT Survey
***************************************************************************
**Setting the working directory
cls
clear all
cd "C:\Users\oyoo\OneDrive - Dalberg Global Development Advisors\QUALITY CONTROL\Projects\2026\Projects\UNICEF LBB\Main\Data\Raw\Student"

***import dataset

import delimited "Non VI\UNICEF_LBB-Non-Visually_Impaired_Learners_Only_Field-1772653996040.csv", case(preserve)

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
drop if INT_DATE < td(02Mar2026)

******************************************************************
cd "C:\Users\oyoo\OneDrive - Dalberg Global Development Advisors\QUALITY CONTROL\Projects\2026\Projects\UNICEF LBB\Main\Codes\LBB-Main-Baseline-Survey\NON-VIs"

do "dropping irrelevant NON-VIs.do"

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

*INT_LANGUAGE
lab var INT_LANGUAGE"Enumerator: Record the language used to administer this interview"

lab define int_lang 1"English" 2 "Swahili"

lab values INT_LANGUAGE int_lang

*supervisor
label define sup ///
1  "Boru Mohammed" ///
2  "Sheryle Amondi" ///
3  "Mary Nduku"

destring SUP_NAME,replace
lab values SUP_NAME sup

*Enumerator
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
11 "Salome Wamboi" ///
12 "Linet Narasha" ///
13 "Anthony Namasaka" ///
14 "Mary Nduku" ///
15 "Boru Mohammed" ///
16 "Sheryle Amondi" ///
17 "Caroline Juma" ///
18 "Sharon Amonde"
 
lab var ENUM_NAME"Enumerator Name"

foreach x in ENUM_NAME ENUM_NAME_1 ENUM_NAME_2 ENUM_NAME_3{
	replace `x' = "" if `x' == "."
}

replace ENUM_NAME = ENUM_NAME_1 + ENUM_NAME_2 + ENUM_NAME_3
destring  ENUM_NAME,replace
lab values ENUM_NAME enum
drop ENUM_NAME_1 ENUM_NAME_2 ENUM_NAME_3

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
replace Group = "2" if Group == "Control"
destring Group,replace
lab values Group grp

drop School_informationGroup School_informationGroup_level

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

replace letter_sound_knowledgegridAutoSt = "1" if letter_sound_knowledgegridAutoSt == "TRUE"
replace letter_sound_knowledgegridAutoSt = "0" if letter_sound_knowledgegridAutoSt == "FALSE"
destring letter_sound_knowledgegridAutoSt,replace
lab values letter_sound_knowledgegridAutoSt true_false

ren v233 letter_sound_knowledgenum_att
ren letter_sound_knowledgenumber_of_ letter_sound_knowledgenum_corr

bysort GRADE: summ letter_sound_knowledgenum_corr

*Phonemic awareness
lab define phn 1"Correct" 2"Incorrect" 3"No response"

destring phonemic_awareness_q1 - phonemic_awareness_q10, replace
lab values phonemic_awareness_q1 - phonemic_awareness_q10 phn

***reading familiar
destring read_familiar_words_1 - read_familiar_wordstime_remainin read_familiar_wordsautoStop - read_familiar_wordsitems_per_min,replace
lab values read_familiar_words_1 - read_familiar_words_50 cor_inc

replace read_familiar_wordsgridAutoStopp = "1" if read_familiar_wordsgridAutoStopp == "TRUE"
replace read_familiar_wordsgridAutoStopp = "0" if read_familiar_wordsgridAutoStopp == "FALSE"

destring read_familiar_wordsgridAutoStopp,replace
lab values read_familiar_wordsgridAutoStopp true_false

ren v302 read_familiar_wordsnum_att
ren read_familiar_wordsnumber_of_ite read_familiar_wordsnum_corr

bysort GRADE:summ read_familiar_wordsnum_corr

***Oral reading fluency
destring oral_reading_fluency_1	- oral_reading_fluencytime_remaini oral_reading_fluencyautoStop	- oral_reading_fluencyitems_per_mi,replace
lab values oral_reading_fluency_1 - oral_reading_fluency_44 cor_inc

replace oral_reading_fluencygridAutoStop = "1" if oral_reading_fluencygridAutoStop == "TRUE"
replace oral_reading_fluencygridAutoStop = "0" if oral_reading_fluencygridAutoStop == "FALSE"

destring oral_reading_fluencygridAutoStop,replace
lab values oral_reading_fluencygridAutoStop true_false

ren v355 oral_reading_fluencynum_att
ren oral_reading_fluencynumber_of_it oral_reading_fluencynum_corr

***Reading comprehension
destring reading_comprehension_q1 - reading_comprehension_q5,replace
lab values reading_comprehension_q1 - reading_comprehension_q5 phn

bysort GRADE: summ oral_reading_fluencynum_corr

*Identifying numbers
destring identifying_numbers_grid_1 - v383 identifying_numbers_gridautoStop,replace
lab values identifying_numbers_grid_1 - identifying_numbers_grid_20 cor_inc

replace identifying_numbers_gridgridAuto = "1" if identifying_numbers_gridgridAuto == "TRUE"
replace identifying_numbers_gridgridAuto = "0" if identifying_numbers_gridgridAuto == "FALSE"
destring identifying_numbers_gridgridAuto,replace
lab values identifying_numbers_gridgridAuto true_false

ren v383 identifying_numbers_gridnum_att
ren identifying_numbers_gridnumber_o identifying_numbers_gridnum_corr
replace identifying_numbers_gridnum_att = 20 if identifying_numbers_gridnum_att == 0

*Discrimination
destring number_discrimination_gridautoSt number_discrimination_grid_1 - v392,replace
ren v392 number_discrimin_gridnum_att
ren number_discrimination_gridnumber number_discrimine_gridnum_corr
replace number_discrimin_gridnum_att = 5 if number_discrimin_gridnum_att == 0
lab values number_discrimination_grid_1 - number_discrimination_grid_5 cor_inc

replace number_discrimination_gridgridAu = "1" if number_discrimination_gridgridAu == "TRUE"
replace number_discrimination_gridgridAu = "0" if number_discrimination_gridgridAu == "FALSE"
destring number_discrimination_gridgridAu,replace
lab values number_discrimination_gridgridAu true_false

*Number sequency
destring number_sequence_grid_1	- v400 number_sequence_gridautoStop,replace
lab values number_sequence_grid_1 - number_sequence_grid_4 cor_inc

ren v400 number_sequence_gridnum_att
ren number_sequence_gridnumber_of_it number_sequence_gridnum_corr
replace number_sequence_gridnum_att = 4 if number_sequence_gridnum_att == 0

replace number_sequence_gridgridAutoStop = "1" if number_sequence_gridgridAutoStop == "TRUE"
replace number_sequence_gridgridAutoStop = "0" if number_sequence_gridgridAutoStop == "FALSE"
destring number_sequence_gridgridAutoStop,replace
lab values number_sequence_gridgridAutoStop true_false

*Addition
destring addition_grid_1 - addition_gridnumber_of_items_att addition_gridautoStop,replace
lab values addition_grid_1 - addition_grid_10 cor_inc

replace addition_gridgridAutoStopped = "1" if addition_gridgridAutoStopped == "TRUE"
replace addition_gridgridAutoStopped = "0" if addition_gridgridAutoStopped == "FALSE"
destring addition_gridgridAutoStopped,replace
lab values addition_gridgridAutoStopped true_false
ren addition_gridnumber_of_items_cor addition_gridnum_corr

*Subtraction
destring subtraction_grid_1 - v428 subtraction_gridautoStop,replace
ren v428 subtraction_gridnum_att
ren subtraction_gridnumber_of_items_ subtraction_gridnum_corr
lab values subtraction_grid_1 - subtraction_grid_10 cor_inc

replace subtraction_gridgridAutoStopped = "1" if subtraction_gridgridAutoStopped == "TRUE"
replace subtraction_gridgridAutoStopped = "0" if subtraction_gridgridAutoStopped == "FALSE"
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
replace SCHOOL_DESCRIPTION = trim(SCHOOL_DESCRIPTION)
replace SCHOOL_DESCRIPTION = "2" if SCHOOL_DESCRIPTION == "Inclusive/Integrated"
replace SCHOOL_DESCRIPTION = "1" if SCHOOL_DESCRIPTION == "Special School"
replace SCHOOL_DESCRIPTION = "3" if SCHOOL_DESCRIPTION == "Regular School with special unit" | SCHOOL_DESCRIPTION == "Regular with Special Unit"

destring SCHOOL_DESCRIPTION,replace
lab values SCHOOL_DESCRIPTION school_type

*COUNTY
label define cnty_lbl ///
1 "Garissa" ///
2 "Kajiado" ///
3 "Kakuma" ///
4 "Kilifi" ///
5 "Mandera" ///
6 "Marsabit" ///
7 "Samburu" ///
8 "Turkana" ///
9 "Wajir" ///
10 "Bungoma"

ren School_informationCounty_label County

replace County = "1" if School_informationCounty == "018XOV5G"
replace County = "2" if School_informationCounty == "AtFqd80d"
replace County = "3" if School_informationCounty == "8lhf2mIQ"
replace County = "4" if School_informationCounty == "AK4EOXpt"
replace County = "5" if School_informationCounty == "ZOevAP1r"
replace County = "6" if School_informationCounty == "A1usQB2j"
replace County = "7" if School_informationCounty == "ILQOObXU"
replace County = "8" if School_informationCounty == "DFpLsLZh"
replace County = "9" if School_informationCounty == "EcahmYrs"
replace County = "10" if School_informationCounty == "xifIldOf"

destring County,replace
lab values County cnty_lbl
drop School_informationCounty_level	School_informationSub_county School_informationCounty

*School
label define school_lbl 1 "Iftin Integrated Primary" 2 "Jaribu Primary" 3 "Chief Muturi Integrated Primary" 4 "Enchurrai" 5 "Kikelelwa Integrated Primary" 6 "Lokitang Primary" 7 "Kakuma Placeholder School" 8 "Kibarani Integrated" 9 "Mtsara wa Tsatsu Pri School" 10 "Sahajanad Special School" 11 "Timboni Special School" 12 "Vilakwe Pri School" 13 "Daua Integrated Primary" 14 "Kamor Integrated Primary" 15 "Mandera DEB Primary" 16 "Mandera Special School for the Blind" 17 "Shashafey Integrated Primary" 18 "Al-Hidaya Muslim Primary" 19 "Kiwanja Ndege Primary School" 20 "Logologo Integrated Primary School" 21 "St. Johns Primary" 22 "St. Theresa Girls Primary" 23 "Lkurroto Primary School" 24 "Maralal DEB Primary" 25 "Ntepes Primary School" 26 "Seneya Special Primary School" 27 "St. Pauls Integrated Primary School" 28 "Kakuma Arid Zone" 29 "Kakuma Mixed Primary" 30 "Nationokar Primary" 31 "Barwaqo Girls Integrated Primary" 32 "Catholic Integrated Primary and Junior School" 33 "Got-Ade Primary School" 34 "ICF Integrated Primary School" 35 "Kalkacha Primary School" 36 "Volunteer Primary and Junior School" 37 "Wajir Township Primary" 38 "Misanga FYM Primary" 39 "Mukhuyu FYM Primary" 40 "Mupeli DEB Primary" 41 "Musikoma RC Primary" 42 "Sacred Heart Misikhu RC Boys Primary"

ren School_informationSchool_label School
replace School = "1" if School_informationSchool == "07Qbvxdq"
replace School = "2" if School_informationSchool == "4n4G6loI"
replace School = "3" if School_informationSchool == "Z3dToq9T"
replace School = "4" if School_informationSchool == "tnh4Wect"
replace School = "5" if School_informationSchool == "Uz9605mJ"
replace School = "6" if School_informationSchool == "84eDf5UM"
replace School = "7" if School_informationSchool == "N67hzJXn"
replace School = "8" if School_informationSchool == "AiU3CpZq"
replace School = "9" if School_informationSchool == "hjDVyJlD"
replace School = "10" if School_informationSchool == "nmZZ8dXs"
replace School = "11" if School_informationSchool == "ViZPnYn7"
replace School = "12" if School_informationSchool == "pGWS4Xm5"
replace School = "13" if School_informationSchool == "L8p0RNQV"
replace School = "14" if School_informationSchool == "Vp5h1q1c"
replace School = "15" if School_informationSchool == "7Jc3I17r"
replace School = "16" if School_informationSchool == "Ep6v4DPH"
replace School = "17" if School_informationSchool == "MzzoENLf"
replace School = "18" if School_informationSchool == "ZwdkniC8"
replace School = "19" if School_informationSchool == "8IvHIcAQ"
replace School = "20" if School_informationSchool == "LIQCxt68"
replace School = "21" if School_informationSchool == "5G8kDjhg"
replace School = "22" if School_informationSchool == "t0xS2IMR"
replace School = "23" if School_informationSchool == "P4u06aGn"
replace School = "24" if School_informationSchool == "lhFIRjH4"
replace School = "25" if School_informationSchool == "z4F1GUDb"
replace School = "26" if School_informationSchool == "PA0VQSVk"
replace School = "27" if School_informationSchool == "NfSvMFc5"
replace School = "28" if School_informationSchool == "KTDwY9HQ"
replace School = "29" if School_informationSchool == "mum1exkQ"
replace School = "30" if School_informationSchool == "kFvXg234"
replace School = "31" if School_informationSchool == "ENNGSs1A"
replace School = "32" if School_informationSchool == "AIdkFrXQ"
replace School = "33" if School_informationSchool == "vkKQn8Eg"
replace School = "34" if School_informationSchool == "OUZQOHYm"
replace School = "35" if School_informationSchool == "QUb9OWwF"
replace School = "36" if School_informationSchool == "CyP4KZeZ"
replace School = "37" if School_informationSchool == "Xi1pqx10"
replace School = "38" if School_informationSchool == "28lwRgrz"
replace School = "39" if School_informationSchool == "k7dc2KaM"
replace School = "40" if School_informationSchool == "Fij8HLLX"
replace School = "41" if School_informationSchool == "0b2fstCa"
replace School = "42" if School_informationSchool == "73KMGNBJ"

destring School,replace
lab values School school_lbl

drop School_informationSchool_type School_informationSchool_level School_informationSub_county_lab School_informationSub_county_lev School_informationSchool School_informationSchool_type_le

destring GPSlatitude	GPSlongitude	GPSaccuracy,replace

drop UNIQUE_IDENTIFIER

gen Diability_Cat = "Non VI Learners"

*save dataset
cd "C:\Users\oyoo\OneDrive - Dalberg Global Development Advisors\QUALITY CONTROL\Projects\2026\Projects\UNICEF LBB\Main\Data\Raw\Student\Non VI"

save "LBB Baseline Survey Processed data NON-VIs.dta",replace

****END********************************************************************



