cls
clear all
cd "C:\Users\oyoo\OneDrive - Dalberg Global Development Advisors\QUALITY CONTROL\Projects\2026\Projects\UNICEF LBB\Main\Data\Raw\Student"

use "VI\LBB Baseline Survey Processed data VIs.dta",clear

append using "Non VI\LBB Baseline Survey Processed data NON-VIs.dta",force

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

// ren School_informationCounty_label County
// ren School_informationSub_county_lab Sub_county
// ren School_informationSchool_label School
// ren School_informationSchool_type School_type

*Labelling files
lab var  SUP_NAME"Supervisor name"

lab var  County"County"
lab var  Sub_county"Sub county"
lab var  School"School"
lab var  School_type"School_type"
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


*QC checks
********************************QC checks-Flaggings
***************************************************************************************
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
global var_kept "interview_ID INT_DATE INT_STARTTIME INT_ENDTIME SUP_NAME ENUM_NAME County Group SCHOOL_DESCRIPTION Diability_Cat GRADE RES_NAME_F RES_NAME_L RES_AGE RES_SEX"

** generate a Comment based on the issue raised
gen issue_comment = ""

***************************************************************************
**Duration of interview check
preserve
replace issue_comment ="interview duration is Longer or Shorter, kindly clarify"
keep if !inrange(Duration_mins,45,120)
cap export excel $var_kept Duration_mins issue_comment using "LBB UNICEF issues ${dates} v01.xlsx", sheet(duration_issues,replace)firstrow(variables)
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
cap export excel $var_kept int_dup issue_comment using "LBB UNICEF issues ${dates} v01.xlsx", sheet(Interv_dupl_main_issues,replace)firstrow(variables)
restore

*Letter_knowledge 
*not started
preserve
replace issue_comment ="Timer in the letter knowledge was not started, kindly clarify"
keep if letter_sound_knowledgetime_remai == letter_sound_knowledgeduration
cap export excel $var_kept letter_sound_knowledge_1 -  letter_sound_knowledgenum_att issue_comment using "LBB UNICEF issues ${dates} v01.xlsx", sheet(Letter_knowledge_time_1,replace)firstrow(variables)
restore

*time spent is unrealistic yet the trigger did not happen
preserve
replace issue_comment ="Timer in the letter knowledge was very short than expected, kindly clarify"
keep if (letter_sound_knowledgeduration - letter_sound_knowledgetime_remai) < 30 & letter_sound_knowledgegridAutoSt == 0
cap export excel $var_kept letter_sound_knowledge_1 -  letter_sound_knowledgenum_att issue_comment using "LBB UNICEF issues ${dates} v01.xlsx", sheet(Letter_knowledge_time_2,replace)firstrow(variables)
restore

*time spent is unrealistic yet even with trigger
preserve
replace issue_comment ="Timer in the letter knowledge was very short than expected even when the trigger happen, kindly clarify"
keep if (letter_sound_knowledgeduration - letter_sound_knowledgetime_remai) < 10 & letter_sound_knowledgegridAutoSt == 1
cap export excel $var_kept letter_sound_knowledge_1 -  letter_sound_knowledgenum_att issue_comment using "LBB UNICEF issues ${dates} v01.xlsx", sheet(Letter_knowledge_time_3,replace)firstrow(variables)
restore

*Attempted items were less than expected yet there was no trigger
preserve
replace issue_comment ="Attempted items were less than expected yet there was no trigger and the time was not over, kindly clarify"
keep if letter_sound_knowledgenum_att < 100 & letter_sound_knowledgegridAutoSt == 0 & letter_sound_knowledgetime_remai != 0
cap export excel $var_kept letter_sound_knowledge_1 -  letter_sound_knowledgenum_att issue_comment using "LBB UNICEF issues ${dates} v01.xlsx", sheet(Letter_knowledge_time_3,replace)firstrow(variables)
restore

* reading familiar 
*not started
preserve
replace issue_comment ="Timer in the reading familiar was not started, kindly clarify"
keep if read_familiar_wordstime_remainin == read_familiar_wordsduration
cap export excel $var_kept read_familiar_words_1 -  read_familiar_wordsnum_att issue_comment using "LBB UNICEF issues ${dates} v01.xlsx", sheet(read_familiar_time_1,replace)firstrow(variables)
restore

*time spent is unrealistic yet the trigger did not happen
preserve
replace issue_comment ="Timer in the reading familiar was very short than expected, kindly clarify"
keep if (read_familiar_wordsduration - read_familiar_wordstime_remainin) < 30 & read_familiar_wordsgridAutoStopp == 0
cap export excel $var_kept read_familiar_words_1 -  read_familiar_wordsnum_att issue_comment using "LBB UNICEF issues ${dates} v01.xlsx", sheet(read_familiar_time_2,replace)firstrow(variables)
restore

*time spent is unrealistic yet even with trigger
preserve
replace issue_comment ="Timer in the reading familiar was very short than expected even when the trigger happen, kindly clarify"
keep if (read_familiar_wordsduration - read_familiar_wordstime_remainin) < 10 & read_familiar_wordsgridAutoStopp == 1
cap export excel $var_kept read_familiar_words_1 -  read_familiar_wordsnum_att issue_comment using "LBB UNICEF issues ${dates} v01.xlsx", sheet(read_familiar_time_3,replace)firstrow(variables)
restore

*Attempted items were less than expected yet there was no trigger
preserve
replace issue_comment ="Attempted items were less than expected yet there was no trigger and the time was not over, kindly clarify"
keep if read_familiar_wordsnum_att < 50 & read_familiar_wordsgridAutoStopp == 0 & read_familiar_wordstime_remainin != 0
cap export excel $var_kept read_familiar_words_1 -  read_familiar_wordsnum_att issue_comment using "LBB UNICEF issues ${dates} v01.xlsx", sheet(read_familiar_time_3,replace)firstrow(variables)
restore

* Oral fluency 
*not started
preserve
replace issue_comment ="Timer in the Oral fluency was not started, kindly clarify"
keep if oral_reading_fluencytime_remaini == oral_reading_fluencyduration
cap export excel $var_kept oral_reading_fluency_1 -  oral_reading_fluencynum_att issue_comment using "LBB UNICEF issues ${dates} v01.xlsx", sheet(oral_reading_time_1,replace)firstrow(variables)
restore

*time spent is unrealistic yet the trigger did not happen
preserve
replace issue_comment ="Timer in the Oral fluency was very short than expected, kindly clarify"
keep if (oral_reading_fluencyduration - oral_reading_fluencytime_remaini) < 30 & oral_reading_fluencygridAutoStop == 0
cap export excel $var_kept oral_reading_fluency_1 -  oral_reading_fluencynum_att issue_comment using "LBB UNICEF issues ${dates} v01.xlsx", sheet(oral_reading_time_2,replace)firstrow(variables)
restore

*time spent is unrealistic yet even with trigger
preserve
replace issue_comment ="Timer in the Oral fluency was very short than expected even when the trigger happen, kindly clarify"
keep if (oral_reading_fluencyduration - oral_reading_fluencytime_remaini) < 10 & oral_reading_fluencygridAutoStop == 1
cap export excel $var_kept oral_reading_fluency_1 -  oral_reading_fluencynum_att issue_comment using "LBB UNICEF issues ${dates} v01.xlsx", sheet(oral_reading_time_3,replace)firstrow(variables)
restore

*Attempted items were less than expected yet there was no trigger
preserve
replace issue_comment ="Attempted items were less than expected yet there was no trigger and the time was not over, kindly clarify"
keep if read_familiar_wordsnum_att < 50 & oral_reading_fluencygridAutoStop == 0 & oral_reading_fluencytime_remaini != 0
cap export excel $var_kept oral_reading_fluency_1 -  oral_reading_fluencynum_att issue_comment using "LBB UNICEF issues ${dates} v01.xlsx", sheet(oral_reading_time_3,replace)firstrow(variables)
restore

* Addition
*Attempted items were less than expected yet there was no trigger
preserve
replace issue_comment ="Attempted items were less than expected yet there was no trigger and the time was not over, kindly clarify"
keep if addition_gridnumber_of_items_att < 5 & addition_gridgridAutoStopped == 0
cap export excel $var_kept addition_grid_1 -  addition_gridautoStop issue_comment using "LBB UNICEF issues ${dates} v01.xlsx", sheet(addition_issue,replace)firstrow(variables)
restore

* Subtraction
*Attempted items were less than expected yet there was no trigger
preserve
replace issue_comment ="Attempted items were less than expected yet there was no trigger and the time was not over, kindly clarify"
keep if subtraction_gridnum_att < 5 & subtraction_gridgridAutoStopped == 0
cap export excel $var_kept subtraction_grid_1 -  subtraction_gridgridAutoStopped issue_comment using "LBB UNICEF issues ${dates} v01.xlsx", sheet(subtraction_issue,replace)firstrow(variables)
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






