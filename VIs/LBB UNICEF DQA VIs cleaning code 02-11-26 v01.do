******************************************* STUDENT *************************************************************

***************************************************************************
****VI STUDENT Survey
***************************************************************************

**Setting the working directory
cls
clear all
cd "C:\Users\oyoo\OneDrive - Dalberg Global Development Advisors\QUALITY CONTROL\Projects\2026\Projects\UNICEF LBB\Main\Data\Raw\Student"

***import dataset

import delimited "VI\UNICEF_LBB-Visually_Impaired_Learners_Only_Field-1772990009198.csv", case(preserve)

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

replace ENUM_NAME = 12 if tabletUserName == "Linet"
replace SUP_NAME = 3 if tabletUserName == "Linet"

replace ENUM_NAME = 3 if tabletUserName == "shafiimoha97@gmail.com"
replace SUP_NAME = 1 if tabletUserName == "shafiimoha97@gmail.com"

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

replace read_familiar_wordsgridAutoStopp = "1" if read_familiar_wordsgridAutoStopp == "TRUE"
replace read_familiar_wordsgridAutoStopp = "0" if read_familiar_wordsgridAutoStopp == "FALSE"

destring read_familiar_wordsgridAutoStopp,replace
lab values read_familiar_wordsgridAutoStopp true_false

ren v359 read_familiar_wordsnum_att
ren read_familiar_wordsnumber_of_ite read_familiar_wordsnum_corr

// bysort GRADE:summ read_familiar_wordsnum_corr

***Oral reading fluency
destring oral_reading_fluency_1	- oral_reading_fluencytime_remaini oral_reading_fluencyautoStop	- oral_reading_fluencyitems_per_mi,replace
lab values oral_reading_fluency_1 - oral_reading_fluency_44 cor_inc

replace oral_reading_fluencygridAutoStop = "1" if oral_reading_fluencygridAutoStop == "TRUE"
replace oral_reading_fluencygridAutoStop = "0" if oral_reading_fluencygridAutoStop == "FALSE"

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

replace identifying_numbers_gridgridAuto = "1" if identifying_numbers_gridgridAuto == "TRUE"
replace identifying_numbers_gridgridAuto = "0" if identifying_numbers_gridgridAuto == "FALSE"
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

replace number_discrimination_gridgridAu = "1" if number_discrimination_gridgridAu == "TRUE"
replace number_discrimination_gridgridAu = "0" if number_discrimination_gridgridAu == "FALSE"
destring number_discrimination_gridgridAu,replace
lab values number_discrimination_gridgridAu true_false

*Number sequency
destring number_sequence_grid_1	- v457 number_sequence_gridautoStop,replace
lab values number_sequence_grid_1 - number_sequence_grid_4 cor_inc

ren v457 number_sequence_gridnum_att
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

replace addition_gridnumber_of_items_att = 10 if addition_gridnumber_of_items_att == 0

*Subtraction
destring subtraction_grid_1 - v485 subtraction_gridautoStop,replace
ren v485 subtraction_gridnum_att
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
replace SCHOOL_DESCRIPTION = "2" if SCHOOL_DESCRIPTION == "Inclusive/Integrated"
replace SCHOOL_DESCRIPTION = "1" if SCHOOL_DESCRIPTION == "Special School"
replace SCHOOL_DESCRIPTION = "3" if SCHOOL_DESCRIPTION == "Regular School with special unit"
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

drop UNIQUE_IDENTIFIER

gen Diability_Cat = "VI Learners"

*drop data with missing information
drop if interview_ID == "bd8d9c8e-733a-419d-97c3-9c22bb882cbc"

*drop Jaribu school
drop if interview_ID == "fe45c5f4-3484-400d-a68a-6c9cec92b01a"

*Corrections
*oral fluency
replace oral_reading_fluency_12 = . if interview_ID == "a9c6aab1-1c9a-4da5-9638-c1f45b294781"

*Addition section
foreach x in addition_grid_6	addition_grid_7	addition_grid_8	addition_grid_9	addition_grid_10{
    replace `x' = . if interview_ID == "6c4a3401-f058-4e5b-8edf-c714d8b31a77"
}
replace addition_gridnumber_of_items_att = 5 if interview_ID == "6c4a3401-f058-4e5b-8edf-c714d8b31a77"

*define disability category
lab define discat 1"VI Learners" 2"Non VI Learners"

replace Diability_Cat = "1" if Diability_Cat== "VI Learners"
replace Diability_Cat = "2" if Diability_Cat== "Non VI Learners"
destring Diability_Cat,replace
lab values Diability_Cat discat
lab var Diability_Cat"Disability Category"

*Phoemic total correct
foreach var of varlist phonemic_awareness_q1-phonemic_awareness_q10 {
    gen `var'_correct = (`var' == 1)
}

egen phonemic_awareness_score = rowtotal(phonemic_awareness_q1_correct-phonemic_awareness_q10_correct) if !missing(phonemic_awareness_q1)

drop phonemic_awareness_q1_correct-phonemic_awareness_q10_correct

	
order phonemic_awareness_score,after(phonemic_awareness_q10)

*Reading comprehension
foreach var of varlist reading_comprehension_q1-reading_comprehension_q5 {
    gen `var'_correct = (`var' == 1)
}

egen reading_comprehension_score = rowtotal(reading_comprehension_q1_correct-reading_comprehension_q5_correct) if !missing(reading_comprehension_q1)

drop reading_comprehension_q1_correct-reading_comprehension_q5_correct

	
order reading_comprehension_score,after(reading_comprehension_q5)

*Labelling files
lab var  SUP_NAME"Supervisor name"

lab var  County"County"
// lab var  Sub_county"Sub county"
lab var  School"School"
// lab var  School_type"School_type"
lab var  SCHOOL_DESCRIPTION"SCHOOL_DESCRIPTION"
lab var  Group"Type of School"
lab var  GRADE"GRADE"
lab var  GRADE_S"Please specify: Other Grade"
lab var  STREAM_NAME"Stream name"
lab var  INT_SUP1"Was this interview supervised"
lab var  INT_SUP2"Supervisor name"
lab var  COMMENT"General Comments"
lab var  INTRO_Q1"INTRO_Q1"
lab var  ITNRO_Q2"ITNRO_Q2"
lab var  RES_NAME_F"First name"
lab var  RES_NAME_L"Last name"
lab var  D1"Do you have difficulty seeing, even if wearing glasses? Would you say…"
lab var  D2"Do you have difficulty hearing, even if using a hearing aid(s)? Would you say…"
lab var  D3"Do you have difficulty walking or climbing steps? Would you say…"
lab var  D4"Do you have difficulty remembering or concentrating? Would you say…"
lab var  D5"Using your usual language, do you have difficulty communicating, for example understanding or being understood? Would you say…"
lab var  D6"Do you have difficulty with self-care, such as washing all over or dressing? Would you say…"
lab var  PB1"Uses both hands to explore an object"
lab var  PB1_Notes"Notes (Write in)"
lab var  PB2"Uses fingertips (not whole palm only) to explore objects"
lab var  PB2_Notes"Notes (Write in)"
lab var  PB3"Explores an object carefully without rushing"
lab var  PB3_Notes"Notes (Write in)"
lab var  PB4"Give learner the piece of soft fabric and piece of sandpaper then ask, what is the difference between these two objects based on texture Can tell when two objects feel different"
lab var  PB4_Notes"Notes (Write in)"
lab var  PB5"Give learner two pieces of soft fabric then ask, what is the difference between these two objects based on texture Can tell when two objects feel the same"
lab var  PB5_Notes"Notes (Write in)"
lab var  PB6"Give learner the small ball and piece of wood then ask, what is the difference between these two objects based on shape Can identify differences in shape (circle, square) by touch"
lab var  PB6_Notes"Notes (Write in)"
lab var  PB7"Place a card with a single raised line Here is a raised shape. Use your fingers to go around it and show me where it starts and ends. Observe if: Fingers stay on the raised boundary Traces in a continuous, deliberate manner Uses pads of fingers rather than tapping"
lab var  PB7_Notes"Notes (Write in)"
lab var  PB8"Can the learner move fingers independently (not stiff or clenched)"
lab var  PB8_Notes"Notes (Write in)"
lab var  PB9"Can trace a raised line or shape with fingers"
lab var  PB9_Notes"Notes (Write in)"
lab var  PB10"Follows a tactile path from start to end using finger"
lab var  PB10_Notes"Notes (Write in)"
lab var  PB11"Maintains finger contact while exploring (does not lift excessively)"
lab var  PB11_Notes"Notes (Write in)"
lab var  PB12"Place few beads in a cup front of a learner then ask them to pick up one bead Can the learner pick up small objects using a pincer grasp (thumb and index finger)?"
lab var  PB12_Notes"Notes (Write in)"
lab var  PB13"The learner use the same (dominant) hand consistently during tactile exploration tasks?"
lab var  PB13_Notes"Notes (Write in)"
lab var  PB14"Place two identical tactile symbols (circles) in front of the learner, then ask, feel these two. Are they the same? Can match two identical raised shapes by touch"
lab var  PB14_Notes"Notes (Write in)"
lab var  PB15"Place two different tactile symbols (circle and rectangle) in front of the learner, then ask, feel these two. Are they the different? Can tell when two raised shapes are different"
lab var  PB15_Notes"Notes (Write in)"
lab var  PB16"Let the learner explore one tactile symbol (rectangle) for 5–10 seconds. Remove it. After a short pause, present (circle and rectangle) symbols, including the original (rectangle), then ask, Can you find the shape you felt before? Observe recognition and memory. Can identify a familiar tactile shape when presented again"
lab var  PB16_Notes"Notes (Write in)"
lab var  PB17"Place circle and rectangle tactile symbols. Name or demonstrate the rectangle once, then say find (rectangle), then observe accuracy. Can locate a specific tactile symbol among other"
lab var  PB17_Notes"Notes (Write in)"
lab var  PB18"Do you like listening to stories?"
lab var  PB19"Do you enjoy playing with words or sounds? This includes words that sound the same like songs and rhymes"
lab var  PB20"Listen to these two words. Do they start with the same sound? Cat and cup"
lab var  PB21"Do you know that dots can stand for letters and numbers?"
lab var  PB22"Do you want to learn how to read using dots?"
lab var  PB_COMMENT"Additional Enumerator Comments on the Pre-braille preparedness activity?1.	Hand dominance: Left, right or both 2. Any avoidance of tactile exploration 3. Learner fatigue 4. Any other observations"
lab var  letter_sound_knowledge_1"e"
lab var  letter_sound_knowledge_2"b"
lab var  letter_sound_knowledge_3"m"
lab var  letter_sound_knowledge_4"n"
lab var  letter_sound_knowledge_5"o"
lab var  letter_sound_knowledge_6"f"
lab var  letter_sound_knowledge_7"s"
lab var  letter_sound_knowledge_8"t"
lab var  letter_sound_knowledge_9"g"
lab var  letter_sound_knowledge_10"l"
lab var  letter_sound_knowledge_11"p"
lab var  letter_sound_knowledge_12"o"
lab var  letter_sound_knowledge_13"h"
lab var  letter_sound_knowledge_14"i"
lab var  letter_sound_knowledge_15"k"
lab var  letter_sound_knowledge_16"t"
lab var  letter_sound_knowledge_17"i"
lab var  letter_sound_knowledge_18"h"
lab var  letter_sound_knowledge_19"l"
lab var  letter_sound_knowledge_20"u"
lab var  letter_sound_knowledge_21"l"
lab var  letter_sound_knowledge_22"e"
lab var  letter_sound_knowledge_23"t"
lab var  letter_sound_knowledge_24"e"
lab var  letter_sound_knowledge_25"g"
lab var  letter_sound_knowledge_26"l"
lab var  letter_sound_knowledge_27"x"
lab var  letter_sound_knowledge_28"o"
lab var  letter_sound_knowledge_29"r"
lab var  letter_sound_knowledge_30"m"
lab var  letter_sound_knowledge_31"a"
lab var  letter_sound_knowledge_32"h"
lab var  letter_sound_knowledge_33"v"
lab var  letter_sound_knowledge_34"p"
lab var  letter_sound_knowledge_35"s"
lab var  letter_sound_knowledge_36"f"
lab var  letter_sound_knowledge_37"z"
lab var  letter_sound_knowledge_38"i"
lab var  letter_sound_knowledge_39"s"
lab var  letter_sound_knowledge_40"r"
lab var  letter_sound_knowledge_41"n"
lab var  letter_sound_knowledge_42"t"
lab var  letter_sound_knowledge_43"h"
lab var  letter_sound_knowledge_44"e"
lab var  letter_sound_knowledge_45"v"
lab var  letter_sound_knowledge_46"s"
lab var  letter_sound_knowledge_47"r"
lab var  letter_sound_knowledge_48"e"
lab var  letter_sound_knowledge_49"j"
lab var  letter_sound_knowledge_50"z"
lab var  letter_sound_knowledge_51"t"
lab var  letter_sound_knowledge_52"i"
lab var  letter_sound_knowledge_53"d"
lab var  letter_sound_knowledge_54"a"
lab var  letter_sound_knowledge_55"n"
lab var  letter_sound_knowledge_56"o"
lab var  letter_sound_knowledge_57"h"
lab var  letter_sound_knowledge_58"a"
lab var  letter_sound_knowledge_59"g"
lab var  letter_sound_knowledge_60"e"
lab var  letter_sound_knowledge_61"s"
lab var  letter_sound_knowledge_62"a"
lab var  letter_sound_knowledge_63"u"
lab var  letter_sound_knowledge_64"b"
lab var  letter_sound_knowledge_65"e"
lab var  letter_sound_knowledge_66"u"
lab var  letter_sound_knowledge_67"d"
lab var  letter_sound_knowledge_68"o"
lab var  letter_sound_knowledge_69"r"
lab var  letter_sound_knowledge_70"w"
lab var  letter_sound_knowledge_71"a"
lab var  letter_sound_knowledge_72"s"
lab var  letter_sound_knowledge_73"w"
lab var  letter_sound_knowledge_74"o"
lab var  letter_sound_knowledge_75"m"
lab var  letter_sound_knowledge_76"n"
lab var  letter_sound_knowledge_77"c"
lab var  letter_sound_knowledge_78"b"
lab var  letter_sound_knowledge_79"w"
lab var  letter_sound_knowledge_80"r"
lab var  letter_sound_knowledge_81"e"
lab var  letter_sound_knowledge_82"i"
lab var  letter_sound_knowledge_83"a"
lab var  letter_sound_knowledge_84"d"
lab var  letter_sound_knowledge_85"s"
lab var  letter_sound_knowledge_86"y"
lab var  letter_sound_knowledge_87"a"
lab var  letter_sound_knowledge_88"o"
lab var  letter_sound_knowledge_89"e"
lab var  letter_sound_knowledge_90"k"
lab var  letter_sound_knowledge_91"q"
lab var  letter_sound_knowledge_92"n"
lab var  letter_sound_knowledge_93"y"
lab var  letter_sound_knowledge_94"k"
lab var  letter_sound_knowledge_95"i"
lab var  letter_sound_knowledge_96"c"
lab var  letter_sound_knowledge_97"r"
lab var  letter_sound_knowledge_98"t"
lab var  letter_sound_knowledge_99"a"
lab var  letter_sound_knowledge_100"z"
lab var  phonemic_awareness_q1"if /i/"
lab var  phonemic_awareness_q2"too /t/"
lab var  phonemic_awareness_q3"up /u/"
lab var  phonemic_awareness_q4"me /m/"
lab var  phonemic_awareness_q5"say /s/"
lab var  phonemic_awareness_q6"dog /d/"
lab var  phonemic_awareness_q7"map /m/"
lab var  phonemic_awareness_q8"bet /b/"
lab var  phonemic_awareness_q9"fish /f/"
lab var  phonemic_awareness_q10"lick /l/"
lab var  read_familiar_words_1"has"
lab var  read_familiar_words_2"bag"
lab var  read_familiar_words_3"eat"
lab var  read_familiar_words_4"pen"
lab var  read_familiar_words_5"big"
lab var  read_familiar_words_6"come"
lab var  read_familiar_words_7"home"
lab var  read_familiar_words_8"not"
lab var  read_familiar_words_9"top"
lab var  read_familiar_words_10"boy"
lab var  read_familiar_words_11"cat"
lab var  read_familiar_words_12"leg"
lab var  read_familiar_words_13"egg"
lab var  read_familiar_words_14"neck"
lab var  read_familiar_words_15"man"
lab var  read_familiar_words_16"dog"
lab var  read_familiar_words_17"run"
lab var  read_familiar_words_18"bus"
lab var  read_familiar_words_19"red"
lab var  read_familiar_words_20"day"
lab var  read_familiar_words_21"pig"
lab var  read_familiar_words_22"now"
lab var  read_familiar_words_23"key"
lab var  read_familiar_words_24"lid"
lab var  read_familiar_words_25"cow"
lab var  read_familiar_words_26"far"
lab var  read_familiar_words_27"rat"
lab var  read_familiar_words_28"have"
lab var  read_familiar_words_29"girl"
lab var  read_familiar_words_30"hen"
lab var  read_familiar_words_31"hot"
lab var  read_familiar_words_32"sit"
lab var  read_familiar_words_33"joy"
lab var  read_familiar_words_34"yes"
lab var  read_familiar_words_35"baby"
lab var  read_familiar_words_36"eye"
lab var  read_familiar_words_37"cup"
lab var  read_familiar_words_38"goat"
lab var  read_familiar_words_39"tap"
lab var  read_familiar_words_40"take"
lab var  read_familiar_words_41"pot"
lab var  read_familiar_words_42"ear"
lab var  read_familiar_words_43"car"
lab var  read_familiar_words_44"bed"
lab var  read_familiar_words_45"beg"
lab var  read_familiar_words_46"zip"
lab var  read_familiar_words_47"get"
lab var  read_familiar_words_48"pen"
lab var  read_familiar_words_49"small"
lab var  read_familiar_words_50"bad"
lab var  oral_reading_fluency_1"This"
lab var  oral_reading_fluency_2"is"
lab var  oral_reading_fluency_3"Tom."
lab var  oral_reading_fluency_4"Tom"
lab var  oral_reading_fluency_5"has"
lab var  oral_reading_fluency_6"a"
lab var  oral_reading_fluency_7"pet."
lab var  oral_reading_fluency_8"The"
lab var  oral_reading_fluency_9"pet"
lab var  oral_reading_fluency_10"is"
lab var  oral_reading_fluency_11"Sisi."
lab var  oral_reading_fluency_12"Sisi"
lab var  oral_reading_fluency_13"is"
lab var  oral_reading_fluency_14"a"
lab var  oral_reading_fluency_15"big"
lab var  oral_reading_fluency_16"cat."
lab var  oral_reading_fluency_17"Tom"
lab var  oral_reading_fluency_18"plays"
lab var  oral_reading_fluency_19"with"
lab var  oral_reading_fluency_20"Sisi."
lab var  oral_reading_fluency_21"Sisi"
lab var  oral_reading_fluency_22"has"
lab var  oral_reading_fluency_23"a"
lab var  oral_reading_fluency_24"cut"
lab var  oral_reading_fluency_25"on"
lab var  oral_reading_fluency_26"his"
lab var  oral_reading_fluency_27"left"
lab var  oral_reading_fluency_28"leg."
lab var  oral_reading_fluency_29"Tom"
lab var  oral_reading_fluency_30"and"
lab var  oral_reading_fluency_31"Sisi"
lab var  oral_reading_fluency_32"are"
lab var  oral_reading_fluency_33"sad."
lab var  oral_reading_fluency_34"The"
lab var  oral_reading_fluency_35"animal"
lab var  oral_reading_fluency_36"doctor"
lab var  oral_reading_fluency_37"treats"
lab var  oral_reading_fluency_38"the"
lab var  oral_reading_fluency_39"cat."
lab var  oral_reading_fluency_40"Tom"
lab var  oral_reading_fluency_41"and"
lab var  oral_reading_fluency_42"Sisi"
lab var  oral_reading_fluency_43"are"
lab var  oral_reading_fluency_44"happy."
lab var  reading_comprehension_q1"What is the name of Tom's Pet? [The pet is Sisi]"
lab var  reading_comprehension_q2"What kind of animal is Sisi? [Sisi is a big cat]"
lab var  reading_comprehension_q3"What problem did Sisi have? [Sisi has a cut on his left leg]"
lab var  reading_comprehension_q4"Who helped Sisi get better? [The animal doctor treats the cat]"
lab var  reading_comprehension_q5"How did Tom and Sisi feel at the end of the story? [Tom and Sisi are happy]"
lab var  identifying_numbers_grid_1"1"
lab var  identifying_numbers_grid_2"3"
lab var  identifying_numbers_grid_3"5"
lab var  identifying_numbers_grid_4"7"
lab var  identifying_numbers_grid_5"9"
lab var  identifying_numbers_grid_6"11"
lab var  identifying_numbers_grid_7"14"
lab var  identifying_numbers_grid_8"18"
lab var  identifying_numbers_grid_9"19"
lab var  identifying_numbers_grid_10"22"
lab var  identifying_numbers_grid_11"27"
lab var  identifying_numbers_grid_12"28"
lab var  identifying_numbers_grid_13"31"
lab var  identifying_numbers_grid_14"34"
lab var  identifying_numbers_grid_15"36"
lab var  identifying_numbers_grid_16"39"
lab var  identifying_numbers_grid_17"42"
lab var  identifying_numbers_grid_18"45"
lab var  identifying_numbers_grid_19"47"
lab var  identifying_numbers_grid_20"50"
lab var  number_discrimination_grid_1"[9]"
lab var  number_discrimination_grid_2"[18]"
lab var  number_discrimination_grid_3"[25]"
lab var  number_discrimination_grid_4"[35]"
lab var  number_discrimination_grid_5"[47]"
lab var  number_sequence_grid_1"[6]"
lab var  number_sequence_grid_2"[17]"
lab var  number_sequence_grid_3"[16]"
lab var  number_sequence_grid_4"[12]"
lab var  addition_grid_1"2+1=[3]"
lab var  addition_grid_2"9+6=[15]"
lab var  addition_grid_3"4+2=[6]"
lab var  addition_grid_4"8+9=[17]"
lab var  addition_grid_5"3+4=[7]"
lab var  addition_grid_6"7+5=[12]"
lab var  addition_grid_7"5+3=[8]"
lab var  addition_grid_8"9+9=[18]"
lab var  addition_grid_9"3+6=[9]"
lab var  addition_grid_10"10+3=[13]"
lab var  subtraction_grid_1"3-1=[2]"
lab var  subtraction_grid_2"15-9=[6]"
lab var  subtraction_grid_3"6-2=[4]"
lab var  subtraction_grid_4"17-8=[9]"
lab var  subtraction_grid_5"7-3=[4]"
lab var  subtraction_grid_6"12-5=[7]"
lab var  subtraction_grid_7"8-4=[4]"
lab var  subtraction_grid_8"18-9=[9]"
lab var  subtraction_grid_9"9-2=[7]"
lab var  subtraction_grid_10"13-3=[10]"
lab var  PCI_Q1"Were you attending this school in January 2025?"
lab var  PCI_Q2_1"1. Kiswahili "
lab var  PCI_Q2_2"2. English"
lab var  PCI_Q2_96"3. Other (Specify others)"
lab var  PCI_Q2_98"4. Do not know/No response"
lab var  PCI_Q2_S"What language(s) do you speak at school? Other specify?"
lab var  PCI_Q2a_1"1. Kiswahili "
lab var  PCI_Q2a_2"2. English"
lab var  PCI_Q2a_96"3. Other (Specify others)"
lab var  PCI_Q2a_98"4. Do not know/No response"
lab var  PCI_Q2a_S"What languages does your teacher usually use when teaching? Other specify?"
lab var  PCI_Q3"What is the main language you speak at home?"
lab var  PCI_Q3_S"What is the main language you speak at home? Other specify?"
lab var  PCI_Q4"Did you go to any school before Grade 1/2? (PP1 or PP2)"
lab var  PCI_Q5"What grade/class were you in last year?"
lab var  PCI_Q5_S"What grade/class were you in last year? Other specify?"
lab var  PCI_Q5a"Why has the learner repeated this grade?"
lab var  PCI_Q6"Last year, have you been absent from school for more than one week?"
lab var  PCI_Q7"Do you have an English reading textbook at home?"
lab var  PCI_Q7a"Is an English textbook in braille?"
lab var  PCI_Q8"Do you have a Kiswahili reading textbook at home?"
lab var  PCI_Q8a"Is the Kiswahili textbook in braille?"
lab var  PCI_Q9"Do you have other books or reading materials at home?"
lab var  PCI_Q9a"Are these other books or reading materials in braille?"
lab var  PCI_Q10_1"1. Kiswahili "
lab var  PCI_Q10_2"2. English"
lab var  PCI_Q10_3"3. Mother Tongue"
lab var  PCI_Q10_96"4. Other (Specify others)"
lab var  PCI_Q10_98"5. Do not know/No response"
lab var  PCI_Q10_S"What language(s) are these other books or other materials in? Other specify?"
lab var  PCI_Q11"Can your parent/caregiver read and write?"
lab var  PCI_Q11a"Can your parent/caregiver read braille?"
lab var  PCI_Q12"Before today, have you ever learned using blocks, objects, or games in class?"
lab var  PCI_Q13_1"1.   Alone"
lab var  PCI_Q13_2"2. With another learner"
lab var  PCI_Q13_3"3. In a small group"
lab var  PCI_Q13_4"4. With the teacher"
lab var  PCI_Q13_5"5. Not sure"
lab var  S1"I try to be nice to other people, I care about their feelings"
lab var  S2"I am restless, I cannot stay still for long"
lab var  S3"I get a lot of headaches, stomach-aches and sickness"
lab var  S4"I usually share with others, for example, food, games"
lab var  S5"I get very angry and often lose my temper"
lab var  S6"I would rather be alone than with people of my age"
lab var  S7"I usually do as I am told"
lab var  S8"I worry a lot"
lab var  S9"I am helpful if someone is hurt, upset or feeling ill"
lab var  S10"I have one good friend or more"
lab var  S11"I fight a lot. I can make other people do what I want"
lab var  S12"I am often unhappy, or tearful"
lab var  S13"Other people my age generally like me"
lab var  S14"I am easily distracted, I find it difficult to concentrate"
lab var  S15"I am nervous in new situations. I easily lose confidence"
lab var  S16"I am kind to younger children"
lab var  S17"I am often accused of lying or cheating"
lab var  S18"Other children or young people pick on me or bully me"
lab var  S19"I often offer to help others (parents, teachers, children)"
lab var  S20"I think before I do things"
lab var  S21"I take things that are not mine from home, school or elsewhere"
lab var  S22"I get along better with adults than with people my own age"
lab var  S23"I have many fears, I am easily scared"
lab var  S24"I finish the work I'm doing. My attention is good"
lab var  S25"Overall, do you think that you have difficulties in any of the following areas: emotions, concentration, behavior or being able to get on with other people?"
lab var  S26"How long have these difficulties been present?"
lab var  S27"Do the difficulties upset or distress you?"
lab var  S28a"Do the difficulties interfere with your everyday life in the following areas? [Home life]"
lab var  S28b"Do the difficulties interfere with your everyday life in the following areas? [Friendships]"
lab var  S28c"Do the difficulties interfere with your everyday life in the following areas? [Classroom learning]"
lab var  S28d"Do the difficulties interfere with your everyday life in the following areas? [Leisure Activities]"
lab var  S29"Do the difficulties make it harder for those around you (family, friends, teachers, etc.)?"

*save dataset
cd "C:\Users\oyoo\OneDrive - Dalberg Global Development Advisors\QUALITY CONTROL\Projects\2026\Projects\UNICEF LBB\Main\Data\Raw\Student\VI"

save "LBB Baseline Survey Processed data VIs.dta",replace
export excel using "LBB Baseline Survey Processed data VIs.xlsx", sheetreplace firstrow(variables)
***************************************************************************
*QC checks
********************************QC checks-Flaggings
*************************************************************************
* QC files
cd "C:\Users\oyoo\OneDrive - Dalberg Global Development Advisors\QUALITY CONTROL\Projects\2026\Projects\UNICEF LBB\Main\Quality Control Sheets"

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
global var_kept "interview_ID INT_DATE INT_STARTTIME INT_ENDTIME SUP_NAME ENUM_NAME County School Diability_Cat GRADE RES_NAME_F RES_NAME_L RES_AGE RES_SEX"

** generate a Comment based on the issue raised
gen issue_comment = ""

***************************************************************************
**Duration of interview check
preserve
replace issue_comment ="interview duration is Longer or Shorter, kindly clarify"
keep if !inrange(Duration_mins,45,120)
cap export excel $var_kept Duration_mins issue_comment using "LBB UNICEF issues VIs ${dates} v01.xlsx", sheet(duration_issues,replace)firstrow(variables)
restore

*Lag time check

*Step 2: Sort by enumerator and time
bysort INT_DATE ENUM_NAME (INT_STARTTIME): gen gap_mins = (INT_STARTTIME - INT_ENDTIME[_n-1]) / 60000 if _n > 1

preserve
replace issue_comment ="Time taken to the next interview is way wierd, seems the interview started earlier or overlapped the other interview, kindly clarify"
keep if !inrange(gap_mins,0,10)
cap export excel $var_kept INT_STARTTIME INT_ENDTIME gap_mins issue_comment using "LBB UNICEF issues VIs ${dates} v01.xlsx", sheet(lag_time_issues,replace)firstrow(variables)
restore

**GPS Accuracy
preserve
destring GPSaccuracy,replace
replace issue_comment ="The GPS Accuracy captured is low"
keep if GPSaccuracy> 20
cap export excel $var_kept GPS* issue_comment using "LBB UNICEF issues VIs ${dates} v01.xlsx", sheet(GPSaccuracy_issues,replace)firstrow(variables)
restore

**Duplicates GPS
duplicates tag GPSlatitude GPSlongitude, gen (gps_dup)

preserve
// replace issue_comment ="The GPS captured are duplicated, kindly clarify"
keep if gps_dup> 0
cap export excel $var_kept GPS* issue_comment using "LBB UNICEF issues VIs ${dates} v01.xlsx", sheet(gps_duplicates_issues,replace)firstrow(variables)
restore

**Duplicates Interviews_General
duplicates tag, gen (Interview_gen_dup)

preserve
// replace issue_comment ="The interviews have duplicates, kindly clarify"
keep if Interview_gen_dup> 0
cap export excel $var_kept issue_comment using "LBB UNICEF issues VIs ${dates} v01.xlsx", sheet(Interv_dupl_gen_issues,replace)firstrow(variables)
restore

**Duplicates Interviews_Main
duplicates tag SCHOOL RES_NAME_F RES_NAME_L RES_SEX RES_AGE,gen(int_dup)

preserve
replace issue_comment ="The interviews have duplicates, kindly clarify"
keep if int_dup>0
cap export excel $var_kept int_dup issue_comment using "LBB UNICEF issues VIs ${dates} v01.xlsx", sheet(Interv_dupl_main_issues,replace)firstrow(variables)
restore

*Age
preserve
replace issue_comment ="Age provided is way high or lower for the student, kindly clarify"
keep if !inrange(gap_mins,6,12)
cap export excel $var_kept issue_comment using "LBB UNICEF issues VIs ${dates} v01.xlsx", sheet(Age_issues,replace)firstrow(variables)
restore

*Stream
///check manually

*Letter_knowledge 
*not started
preserve
replace issue_comment ="Timer in the letter knowledge was not started, kindly clarify"
keep if letter_sound_knowledgetime_remai == letter_sound_knowledgeduration
cap export excel $var_kept letter_sound_knowledge_1 -  letter_sound_knowledgenum_att issue_comment using "LBB UNICEF issues VIs ${dates} v01.xlsx", sheet(Letter_knowledge_time_1,replace)firstrow(variables)
restore

*time spent is unrealistic yet the trigger did not happen
preserve
replace issue_comment ="Timer in the letter knowledge was very short than expected, kindly clarify"
keep if (letter_sound_knowledgeduration - letter_sound_knowledgetime_remai) < 30 & letter_sound_knowledgegridAutoSt == 0
cap export excel $var_kept letter_sound_knowledge_1 -  letter_sound_knowledgenum_att issue_comment using "LBB UNICEF issues VIs ${dates} v01.xlsx", sheet(Letter_knowledge_time_2,replace)firstrow(variables)
restore

*time spent is unrealistic yet even with trigger
preserve
replace issue_comment ="Timer in the letter knowledge was very short than expected even when the trigger happen, kindly clarify"
keep if (letter_sound_knowledgeduration - letter_sound_knowledgetime_remai) < 10 & letter_sound_knowledgegridAutoSt == 1
cap export excel $var_kept letter_sound_knowledge_1 -  letter_sound_knowledgenum_att issue_comment using "LBB UNICEF issues VIs ${dates} v01.xlsx", sheet(Letter_knowledge_time_3,replace)firstrow(variables)
restore

*Attempted items were less than expected yet there was no trigger
preserve
replace issue_comment ="Attempted items were less than expected yet there was no trigger and the time was not over, kindly clarify"
keep if letter_sound_knowledgenum_att < 100 & letter_sound_knowledgegridAutoSt == 0 & letter_sound_knowledgetime_remai != 0
cap export excel $var_kept letter_sound_knowledge_1 -  letter_sound_knowledgenum_att issue_comment using "LBB UNICEF issues VIs ${dates} v01.xlsx", sheet(Letter_knowledge_time_4,replace)firstrow(variables)
restore

*Attempted items were less than expected yet the time ellapsed
preserve
replace issue_comment ="Attempted items were less than expected yet the time elapsed, kindly clarify"
keep if letter_sound_knowledgenum_att < 10
cap export excel $var_kept letter_sound_knowledge_1 -  letter_sound_knowledgenum_att issue_comment using "LBB UNICEF issues VIs ${dates} v01.xlsx", sheet(Letter_knowledge_time_5,replace)firstrow(variables)
restore

* reading familiar 
*not started
preserve
replace issue_comment ="Timer in the reading familiar was not started, kindly clarify"
keep if read_familiar_wordstime_remainin == read_familiar_wordsduration
cap export excel $var_kept read_familiar_words_1 -  read_familiar_wordsnum_att issue_comment using "LBB UNICEF issues VIs ${dates} v01.xlsx", sheet(read_familiar_time_1,replace)firstrow(variables)
restore

*time spent is unrealistic yet the trigger did not happen
preserve
replace issue_comment ="Timer in the reading familiar was very short than expected, kindly clarify"
keep if (read_familiar_wordsduration - read_familiar_wordstime_remainin) < 30 & read_familiar_wordsgridAutoStopp == 0
cap export excel $var_kept read_familiar_words_1 -  read_familiar_wordsnum_att issue_comment using "LBB UNICEF issues VIs ${dates} v01.xlsx", sheet(read_familiar_time_2,replace)firstrow(variables)
restore

*time spent is unrealistic yet even with trigger
preserve
replace issue_comment ="Timer in the reading familiar was very short than expected even when the trigger happen, kindly clarify"
keep if (read_familiar_wordsduration - read_familiar_wordstime_remainin) < 10 & read_familiar_wordsgridAutoStopp == 1
cap export excel $var_kept read_familiar_words_1 -  read_familiar_wordsnum_att issue_comment using "LBB UNICEF issues VIs ${dates} v01.xlsx", sheet(read_familiar_time_3,replace)firstrow(variables)
restore

*Attempted items were less than expected yet there was no trigger
preserve
replace issue_comment ="Attempted items were less than expected yet there was no trigger and the time was not over, kindly clarify"
keep if read_familiar_wordsnum_att < 50 & read_familiar_wordsgridAutoStopp == 0 & read_familiar_wordstime_remainin != 0
cap export excel $var_kept read_familiar_words_1 -  read_familiar_wordsnum_att issue_comment using "LBB UNICEF issues VIs ${dates} v01.xlsx", sheet(read_familiar_time_4,replace)firstrow(variables)
restore

*Attempted items were less than expected yet time elapsed
preserve
replace issue_comment ="Attempted items were less than expected yet time elapsed, kindly clarify"
keep if read_familiar_wordsnum_att < 5
cap export excel $var_kept read_familiar_words_1 -  read_familiar_wordsnum_att issue_comment using "LBB UNICEF issues VIs ${dates} v01.xlsx", sheet(read_familiar_time_5,replace)firstrow(variables)
restore

* Oral fluency 
*not started
preserve
replace issue_comment ="Timer in the Oral fluency was not started, kindly clarify"
keep if oral_reading_fluencytime_remaini == oral_reading_fluencyduration
cap export excel $var_kept oral_reading_fluency_1 -  oral_reading_fluencynum_att issue_comment using "LBB UNICEF issues VIs ${dates} v01.xlsx", sheet(oral_reading_time_1,replace)firstrow(variables)
restore

*time spent is unrealistic yet the trigger did not happen
preserve
replace issue_comment ="Timer in the Oral fluency was very short than expected, kindly clarify"
keep if (oral_reading_fluencyduration - oral_reading_fluencytime_remaini) < 30 & oral_reading_fluencygridAutoStop == 0
cap export excel $var_kept oral_reading_fluency_1 -  oral_reading_fluencynum_att issue_comment using "LBB UNICEF issues VIs ${dates} v01.xlsx", sheet(oral_reading_time_2,replace)firstrow(variables)
restore

*time spent is unrealistic yet even with trigger
preserve
replace issue_comment ="Timer in the Oral fluency was very short than expected even when the trigger happen, kindly clarify"
keep if (oral_reading_fluencyduration - oral_reading_fluencytime_remaini) < 10 & oral_reading_fluencygridAutoStop == 1
cap export excel $var_kept oral_reading_fluency_1 -  oral_reading_fluencynum_att issue_comment using "LBB UNICEF issues VIs ${dates} v01.xlsx", sheet(oral_reading_time_3,replace)firstrow(variables)
restore

*Attempted items were less than expected yet there was no trigger
preserve
replace issue_comment ="Attempted items were less than expected yet there was no trigger and the time was not over, kindly clarify"
keep if oral_reading_fluencynum_att < 50 & oral_reading_fluencygridAutoStop == 0 & oral_reading_fluencytime_remaini != 0
cap export excel $var_kept oral_reading_fluency_1 -  oral_reading_fluencynum_att issue_comment using "LBB UNICEF issues VIs ${dates} v01.xlsx", sheet(oral_reading_time_4,replace)firstrow(variables)
restore

*Attempted items were less than expected yet time elapsed
preserve
replace issue_comment ="Attempted items were less than expected yet time elapsed, kindly clarify"
keep if oral_reading_fluencynum_att < 11
cap export excel $var_kept oral_reading_fluency_1 -  oral_reading_fluencynum_att issue_comment using "LBB UNICEF issues VIs ${dates} v01.xlsx", sheet(oral_reading_time_5,replace)firstrow(variables)
restore

* Addition
*Attempted items were less than expected yet there was no trigger
preserve
replace issue_comment ="Attempted items were less than expected yet there was no trigger and the time was not over, kindly clarify"
keep if addition_gridnumber_of_items_att < 5 & addition_gridgridAutoStopped == 0
cap export excel $var_kept addition_grid_1 -  addition_gridautoStop issue_comment using "LBB UNICEF issues VIs ${dates} v01.xlsx", sheet(addition_issue,replace)firstrow(variables)
restore

* Subtraction
*Attempted items were less than expected yet there was no trigger
preserve
replace issue_comment ="Attempted items were less than expected yet there was no trigger and the time was not over, kindly clarify"
keep if subtraction_gridnum_att < 5 & subtraction_gridgridAutoStopped == 0
cap export excel $var_kept subtraction_grid_1 -  subtraction_gridgridAutoStopped issue_comment using "LBB UNICEF issues VIs ${dates} v01.xlsx", sheet(subtraction_issue,replace)firstrow(variables)
restore

****Baseline data Quick descriptive analysis of the scores fareness.
*Letter_knowledge
summ letter_sound_knowledgenum_corr letter_sound_knowledgenum_att

*reading familiar
summ read_familiar_wordsnum_corr read_familiar_wordsnum_att

*phonological_awareness
*compute average scores/descriptive
summ phonemic_awareness_score

*oral reading
summ oral_reading_fluencynum_corr oral_reading_fluencynum_att

summ identifying_numbers_gridnum_corr number_discrimine_gridnum_corr number_sequence_gridnum_corr addition_gridnum_corr

*save dat for updating dashboard
keep interview_ID School CONSENT
drop if CONSENT == 0

export excel using "LBB Baseline for screener data VIs.xlsx", sheetreplace firstrow(variables)






