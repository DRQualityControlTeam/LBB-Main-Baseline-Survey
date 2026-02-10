******************************************* STUDENT *************************************************************

***************************************************************************
****VI STUDENT Survey
***************************************************************************

**Setting the working directory
cls
clear all
cd "C:\Users\oyoo\OneDrive - Dalberg Global Development Advisors\QUALITY CONTROL\Projects\2026\Projects\UNICEF LBB\Main\Data\Raw\Student"

***import dataset

import delimited "VI\UNICEF_LBB-Visually_Impaired_Learners_Only-1770447881528.csv", case(preserve)

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

*****************************************************************************************************************
**dropping irrelevant variables
*****************************************************************************************************************
do "dropping_irrelevant_vars.do"

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
label define sup 1 "Moustapha Diamé" 2 "Alkhayri Diawara" 3 "Ismaila Lo" 4 "Mouhamed Habib So" 5 "Amath Niang" 6 "Mouhamet Diop"

destring SUP_NAME,replace
lab var SUP_NAME"Supervisor Name"
lab values SUP_NAME sup

replace SUP_NAME = 1 if !missing(ENUM_NAME_1)
replace SUP_NAME = 2 if !missing(ENUM_NAME_2)
replace SUP_NAME = 3 if !missing(ENUM_NAME_3)
replace SUP_NAME = 4 if !missing(ENUM_NAME_4)
replace SUP_NAME = 5 if !missing(ENUM_NAME_5)
replace SUP_NAME = 6 if !missing(ENUM_NAME_6)

*Enumerator
label define enum 1  "Abdou Aziz Diallo"  2  "Seydou Diallo" 3 "Jeanne Bernadette Ndour" 4  "Victorine Therese Sarr" 5 "Marie Noel Sène" 6  "Ibrahima Ndiaye" 7 "Ndiambale Sarr" 8 "Elhadji Malick Diouf"  9  "Aissatou Diam" 10 "Mamadou Basse" 11  "Aissatou Dieng" 12 "Diegou Diouf" 13 "Bineta Gningue" 14 "Abdou Khadre Diaby" 15 "Nogaye Dieng" 16  "Ousmane Mbengue" 17 "Thiara Diene" 18 "Sackou Mbaye" 19 "Ndeye Fatou Diop" 20 "Boubacar Soumano" 21 "Souleymane Sène" 22 "Baye Mor Mbaye" 23  "Rabia Sy" 24 "Sette Niang" 25 "Abdou Aziz Diagne" 26 "Ngoné Mbodj" 27 "Mariama Diakhaté" 28 "Astou Kane" 29 "Salla Diara" 30 "Marieme Fall" 31 "Baba Adama Ndiaye" 32 "Souhaibou Diop" 33 "Robert Armand Thiaré"  34 "Oumar Thioye" 35 "Adama Ba" 36 "Ramatoulaye Dramé"    

replace ENUM_NAME_4 = "22" if inlist(interview_ID, "687b58cd-3781-4864-8956-3254c912f3dc","80f5c997-81f6-4501-b289-0acbe647690f","38bdc126-72b7-4df0-8444-c471ca2a87e4")

replace ENUM_NAME_4 = "20" if inlist(interview_ID, "cdacae65-f165-42ee-8668-d30927fa89b4","a83d057f-42b8-4ce6-a7e3-c2fb4f1e9cf4","64f00d50-e875-4e77-92c1-f4d53ba1a922")

replace ENUM_NAME_4 = "19" if inlist(interview_ID, "34240a67-95fe-48e6-9dc3-481a5eb995f8","d0273b2f-d376-49d6-b1dc-82fc45816d0d","fc083b06-21a2-4665-8228-d741d3d22d15","33af1dd8-7b97-40ca-90a3-ff9bf5cc78b9")

replace ENUM_NAME_3 = "18" if interview_ID == "ae1ce825-0716-42b8-8df0-f4c03de0b574"

replace ENUM_NAME_4 = "24" if inlist(interview_ID,"18e148e8-0d56-481d-addc-401cd8a79600","6f2c99cb-779a-47ef-ba75-450073085f94","4aad058f-af72-471c-95cb-20e762b2f6d8")

replace ENUM_NAME_4 = "21" if inlist(interview_ID, "2fbdb190-ce6b-4db3-bd3d-86eeb77f4c2f","f472aa19-e4ee-4e09-b6ab-8bd600de957d","7a7ca376-9da9-4ba4-a445-802999b1d569")

replace ENUM_NAME_3 = "14" if interview_ID == "e1d5d06e-04d1-488f-9f20-0be1971b0b14"

replace ENUM_NAME_1 = "2" if interview_ID == "af0783a4-3262-428e-9f9e-0c2146ff5078"

replace ENUM_NAME_3 = "16" if interview_ID == "27ff1a9b-b5d9-4ed0-9fc5-a3dcc1e64519"


replace ENUM_NAME = "" if inlist(interview_ID,"687b58cd-3781-4864-8956-3254c912f3dc","18e148e8-0d56-481d-addc-401cd8a79600","2fbdb190-ce6b-4db3-bd3d-86eeb77f4c2f","af0783a4-3262-428e-9f9e-0c2146ff5078","27ff1a9b-b5d9-4ed0-9fc5-a3dcc1e64519","e1d5d06e-04d1-488f-9f20-0be1971b0b14","f472aa19-e4ee-4e09-b6ab-8bd600de957d","7a7ca376-9da9-4ba4-a445-802999b1d569")

replace ENUM_NAME = "" if inlist(interview_ID,"7a7ca376-9da9-4ba4-a445-802999b1d569","6f2c99cb-779a-47ef-ba75-450073085f94","4aad058f-af72-471c-95cb-20e762b2f6d8","ae1ce825-0716-42b8-8df0-f4c03de0b574", "34240a67-95fe-48e6-9dc3-481a5eb995f8","d0273b2f-d376-49d6-b1dc-82fc45816d0d","fc083b06-21a2-4665-8228-d741d3d22d15","33af1dd8-7b97-40ca-90a3-ff9bf5cc78b9")

replace ENUM_NAME = "" if inlist(interview_ID,"cdacae65-f165-42ee-8668-d30927fa89b4","a83d057f-42b8-4ce6-a7e3-c2fb4f1e9cf4","64f00d50-e875-4e77-92c1-f4d53ba1a922","687b58cd-3781-4864-8956-3254c912f3dc","80f5c997-81f6-4501-b289-0acbe647690f","38bdc126-72b7-4df0-8444-c471ca2a87e4")

foreach x in ENUM_NAME ENUM_NAME_1 ENUM_NAME_2 ENUM_NAME_3 ENUM_NAME_4 ENUM_NAME_5 ENUM_NAME_6{
	replace `x' = "" if `x' == "."
}

replace ENUM_NAME = ENUM_NAME_1 + ENUM_NAME_2 + ENUM_NAME_3 + ENUM_NAME_4 + ENUM_NAME_5 + ENUM_NAME_6

destring ENUM_NAME,replace
drop ENUM_NAME_1 ENUM_NAME_2 ENUM_NAME_3 ENUM_NAME_4 ENUM_NAME_5 ENUM_NAME_6

lab var ENUM_NAME"Enumerator Name"
lab values ENUM_NAME enum

replace SUP_NAME = 6 if interview_ID =="d2c71a15-324b-4908-880c-cd2a37b9ae46"
replace ENUM_NAME = 36 if interview_ID =="d2c71a15-324b-4908-880c-cd2a37b9ae46"

**Survey Language
lab var survey_language"Enumerator: Record the language of instruction being used to administer the survey"
lab define sur_lan 1"French" 2 "Wolof" 3 "Serer" 4 "Pulaar"
destring survey_language, replace
lab values survey_language sur_lan

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

*assessment_type
lab var assessment_type"Is this an individual or pair assessment?"
lab define asse_ty 1"Individual assessment" 2 "Assessment in pair"
lab values assessment_type asse_ty

*interview_type
lab define int_type 1"Observing" 2"Speaking"
destring interviewer_type,replace
lab var interviewer_type"Are you the census taker observing or speaking?"
lab values interviewer_type int_type

*Location
do "Location.do"

drop SampleIA	SampleIEF	SampleArrondissement	SampleCommune	SampleEchantillon	SampleEcole	SampleGroupe SampleLangue 

*Official language
lab var official_language"What is the Senegalese language in this school?"
recode official_language (3=4)(2=3)(1=2)

lab values official_language lan

replace official_language = 2 if Ecole == 44

*teaching_language
lab var teaching_language"What is the language teachers actually use to actually teach in the school?"
lab values teaching_language lan

*enumerator_langugae
gen enumerator_langugae =""
order enumerator_langugae,before(enumerator_langugae_1)
lab var enumerator_langugae"What languages are you most comfortable speaking and reading in? (Select all that apply)"
lab var enumerator_langugae_1 "French"
lab var enumerator_langugae_2 "Wolof"
lab var enumerator_langugae_3 "Serere"
lab var enumerator_langugae_4 "Pulaar"

lab define yes_no 1 "Yes" 0 "No"

destring enumerator_langugae_1	enumerator_langugae_2	enumerator_langugae_3	enumerator_langugae_4,replace

lab values enumerator_langugae_1 enumerator_langugae_2	enumerator_langugae_3 enumerator_langugae_4 yes_no

order enumerator_langugae enumerator_langugae_1 enumerator_langugae_2	enumerator_langugae_3 enumerator_langugae_4, after(teaching_language)

*consent
lab var Consent "Are you ready to start?"
replace Consent = "1" if Consent == "yes"
replace Consent = "0" if Consent == "no"

destring Consent,replace
lab values Consent yes_no

*B1a and B1b
lab var B1a"First name"
lab var B1b"Last name"
gen Student_Name = B1a + " " + B1b
order Student_Name,after(B1b)
lab var Student_Name"Student's Full names"

*B2
lab var B2"B2. What is your gender?:"
lab define gend 1"Boy" 2"Girl" 96"Other"

destring B2,replace
lab values B2 gend

*B3
lab var B3"B3. How old are you?"

*B4
lab var B4"B4. What grade are you in now ?"
lab define b4 1"CI" 2"CP" 3"CE1"
destring B4,replace
lab values B4 b4

*B5
lab var B5"B5. Did you attend a learning program (preschool/ Ecole maternelle ou préscolaire) before grade 1?"
lab define b5 1"Yes" 0"No" 98"Don't know/no answer"

destring B5,replace
lab values B5 b5

*B6
gen B6=""
order B6, before(B6_1)
lab var B6 "B6.	What language(s) do you speak at home? Tell me all the languages you speak at home."
lab var B6_1 "French"
lab var B6_2 "Wolof"
lab var B6_3 "Serere"
lab var B6_4 "Pulaar"
lab var B6_96 "Otherspecify"
lab var B6_S "Please specify Other"
destring B6_1	B6_2 B6_3 B6_4 B6_96,replace
lab values B6_1	B6_2 B6_3 B6_4 B6_96 yes_no

*B7
gen B7=""
order B7, before(B7_1)
lab var B7 "B7.	What language do you use when you play with your friends at school? Tell me about all the languages  you use when playing with your friends at school."
lab var B7_1 "French"
lab var B7_2 "Wolof"
lab var B7_3 "Serere"
lab var B7_4 "Pulaar"
lab var B7_96 "Otherspecify"
lab var B7_S "Please specify Other"
destring B7_1	B7_2 B7_3 B7_4 B7_96,replace
lab values B7_1	B7_2 B7_3 B7_4 B7_96 yes_no

*B8
lab var B8"B8. How many days of school did you miss in the last week?"
label define b8 1 "0 days, I attended school every day." 2 "1 day" 3 "2 days" 4 "3 days" 5 "4 days" 6 "5 days, I missed every day of school last week." 98 "Didn't Know/No Response"

destring B8,replace
lab values B8 b8

*B9
gen B9 = ""
lab var B9"B9. Why did you miss school? (Only ask if the student has missed days. Do not read the answer choices."
order B9,after(B8)

lab var B9_1"B9_1. I was sick."
lab var B9_2"B9_2. It was raining/The weather was bad."
lab var B9_3"B9_3. The teacher was not coming."
lab var B9_4"B9_4. I didn't want to go to school."
lab var B9_5"B9_5. I couldn't afford the course materials or pay my tuition."
lab var B9_6"B9_6.  I should have helped my mom or someone else with the housework."
lab var B9_7"B9_7. We need to help our parents find gainful employment or the earning potential of their parents."
lab var B9_8"B9_8. Transportation issues/or lack of transportation facilities"
lab var B9_9"B9_9.  Take care of your siblings."
lab var B9_10"B9_10.  No one helps me to go to school."
lab var B9_96"B9_96. Other, specify"
lab var B9_S"Please specify other"

destring B9_1	B9_2	B9_3	B9_4	B9_5	B9_6	B9_7	B9_8	B9_9	B9_10	B9_96,replace
lab values B9_1	B9_2	B9_3	B9_4	B9_5	B9_6	B9_7	B9_8	B9_9	B9_10	B9_96 yes_no

*B10
lab var B10"B10. Have you eaten today?"
lab define b10 1"Yes" 0"No" 99 "No response"
destring B10,replace
lab values B10 b10

*B12
lab var B12"B12. During this school year, are you taking any extra tutoring outside of the school day?"
destring B12,replace
lab values B12 b10


*************************************************************************
**Semantic section
*************************************************************************
gen languages_spoken = ""
order languages_spoken, before(languages_spoken_1)
lab var languages_spoken "Enumerator: Select all the languages mentioned by the student in B6 and B7"
lab var languages_spoken_1 "French"
lab var languages_spoken_2 "Wolof"
lab var languages_spoken_3 "Serere"
lab var languages_spoken_4 "Pulaar"
lab var languages_spoken_96 "Otherspecify - 1" 
lab var languages_spoken_996 "Otherspecify - 2" 
lab var languages_spoken_9996 "Otherspecify - 3" 
lab var languages_spoken_S1 "Please specify Other - 1"
lab var languages_spoken_S2 "Please specify Other - 2"
lab var languages_spoken_S3 "Please specify Other - 3"
foreach x in languages_spoken_1 languages_spoken_2 languages_spoken_3	languages_spoken_4 languages_spoken_96 languages_spoken_996	languages_spoken_9996{
	destring `x',replace
	lab values `x' yes_no
}

*semantic_test_language1
foreach x in semantic_test_language1 semantic_test_language2 semantic_test_language3 semantic_test_language4{
	lab var `x'"Which language are you testing in?"
}

lab define sema_lan 1"French" 2"Wolof" 3"Serer" 4"Pulaar" 96"Other 1" 996"Other 2" 9996"Other 3"
destring semantic_test_language1 semantic_test_language2 semantic_test_language3 semantic_test_language3 semantic_recording_3 semantic_language_timer3_1 semantic_language_timer3duration semantic_language_timer3time_rem semantic_language_timer3gridAuto semantic_language_timer3number_o semantic_language_timer3items_pe interviewer_semantic_3 word_count_language_1 word_count_language_2 word_count_language_3 word_count_language_4 semantic_test_language4,replace

lab values semantic_test_language1 semantic_test_language2 semantic_test_language3 semantic_test_language4 sema_lan

foreach x in semantic_language_timer1gridAuto semantic_language_timer2gridAuto semantic_language_timer3gridAuto{
	replace `x' = "1" if `x' == "TRUE"
	replace `x' = "0" if `x' == "FALSE"
	destring `x',replace
}

lab values semantic_language_timer1gridAuto semantic_language_timer2gridAuto semantic_language_timer3gridAuto true_false


order semantic_test_language2 interviewer_semantic_2 semantic_recording_2 semantic_language_timer2duration semantic_language_timer2time_rem semantic_language_timer2gridAuto  word_count_language_2,after(word_count_language_1)

order semantic_test_language3 interviewer_semantic_3 semantic_recording_3 semantic_language_timer3duration semantic_language_timer3time_rem semantic_language_timer3gridAuto word_count_language_3,after(word_count_language_2)

*update 4
order semantic_test_language4 interviewer_semantic_4	semantic_recording_4 semantic_language_timer4duration semantic_language_timer4time_rem	semantic_language_timer4gridAuto semantic_language_timer4items_pe word_count_language_4,after(word_count_language_3)

drop semantic_language_timer4_1 semantic_language_timer4item_at_	semantic_language_timer4time_int semantic_language_timer4number_o v2173 semantic_language_timer4items_pe semantic_language_timer4autoStop semantic_language_timer3number_o  semantic_language_timer4item_at_ semantic_language_timer2number_o semantic_language_timer2items_pe semantic_language_timer3items_pe semantic_language_timer1number_o semantic_language_timer1items_pe semantic_language_timer1_1 semantic_language_timer2_1 semantic_language_timer3_1 semantic_language_timer4_1 semantic_language_timer3time_int

*************************************************************************
**Phonological section
*************************************************************************
ren v1071 phonological_awareness_srnum_att
ren v176 phonological_awareness_wfnum_att
ren v1430 phonological_awareness_frnum_att
ren v1809 phonological_awareness_prnum_att
ren(interviewer_phonological_stop_fr interviewer_phonological_stop_wf interviewer_phonological_stop_sr interviewer_phonological_stop_pr) (phonological_stop_fr phonological_stop_wf phonological_stop_sr phonological_stop_pr)

destring phonological_stop_sr phonological_awareness_srautoSto phonological_awareness_srnum_att phonological_awareness_srnumber_ phonological_awareness_sr_* phonological_awareness_wf_* phonological_awareness_wfnum_att phonological_awareness_wfnumber_ phonological_stop_wf phonological_awareness_wfautoSto phonological_awareness_fr_*  phonological_awareness_frnum_att phonological_awareness_frnumber_ phonological_awareness_frautoSto  phonological_stop_fr phonological_awareness_prnum_att phonological_awareness_prautoSto phonological_awareness_prnumber_ phonological_stop_pr phonological_awareness_pr_*,replace

*interviewer_phonological_stop_sr
lab values phonological_stop_fr phonological_stop_wf phonological_stop_sr phonological_stop_pr yes_no

order phonological_awareness_fr_* phonological_awareness_frnumber_ phonological_awareness_frnum_att phonological_awareness_frgridAut phonological_awareness_frautoSto phonological_stop_fr  phonological_awareness_wf_* phonological_awareness_wfnumber_ phonological_awareness_wfnum_att phonological_awareness_wfgridAut phonological_awareness_wfautoSto phonological_stop_wf phonological_awareness_sr_* phonological_awareness_srnumber_ phonological_awareness_srnum_att phonological_awareness_srgridAut phonological_awareness_srautoSto phonological_stop_sr phonological_awareness_pr_*  phonological_awareness_prnumber_ phonological_awareness_prnum_att phonological_awareness_prgridAut phonological_awareness_prautoSto phonological_stop_pr,after(word_count_language_4)

lab define cor_inc 1"Correct" 0"Incorrect"

lab values phonological_awareness_fr_1 - phonological_awareness_fr_10 phonological_awareness_wf_1 - phonological_awareness_wf_10 phonological_awareness_sr_1 - phonological_awareness_sr_10 phonological_awareness_pr_1 - phonological_awareness_pr_10 cor_inc

foreach x in phonological_awareness_frgridAut phonological_awareness_wfgridAut phonological_awareness_srgridAut phonological_awareness_prgridAut{
	replace `x' = "1" if `x' == "TRUE"
	replace `x' = "0" if `x' == "FALSE"
	destring `x',replace
}

lab define true_false 1"True" 0"False"
lab values phonological_awareness_frgridAut phonological_awareness_wfgridAut phonological_awareness_srgridAut phonological_awareness_prgridAut true_false

*Update correction
*fr
foreach x in phonological_awareness_fr_6 phonological_awareness_fr_7	phonological_awareness_fr_8	phonological_awareness_fr_9 phonological_awareness_fr_10 {
	replace `x'= . if phonological_awareness_fr_1 == 0 & phonological_awareness_fr_2 == 0 & phonological_awareness_fr_3 == 0 & phonological_awareness_fr_4 == 0 & phonological_awareness_fr_5 == 0
}

replace phonological_awareness_frnumber_ = 0 if phonological_awareness_fr_1 == 0 & phonological_awareness_fr_2 == 0 & phonological_awareness_fr_3 == 0 & phonological_awareness_fr_4 == 0 & phonological_awareness_fr_5 == 0 | interview_ID == "10e18a5d-a3d3-418c-a172-aa94b5e7a891"

replace phonological_awareness_frnum_att = 5 if phonological_awareness_fr_1 == 0 & phonological_awareness_fr_2 == 0 & phonological_awareness_fr_3 == 0 & phonological_awareness_fr_4 == 0 & phonological_awareness_fr_5 == 0 | interview_ID == "10e18a5d-a3d3-418c-a172-aa94b5e7a891"

replace phonological_awareness_frgridAut = 1 if phonological_awareness_fr_1 == 0 & phonological_awareness_fr_2 == 0 & phonological_awareness_fr_3 == 0 & phonological_awareness_fr_4 == 0 & phonological_awareness_fr_5 == 0 | interview_ID == "10e18a5d-a3d3-418c-a172-aa94b5e7a891"

foreach x in phonological_awareness_fr_2 phonological_awareness_fr_3	phonological_awareness_fr_4	phonological_awareness_fr_5 {
	replace `x'= 0 if interview_ID == "10e18a5d-a3d3-418c-a172-aa94b5e7a891"
}

replace phonological_awareness_frgridAut = 0 if phonological_awareness_frnum_att == 0

replace phonological_stop_fr = 1 if phonological_awareness_frgridAut == 1
replace phonological_stop_fr = 0 if phonological_awareness_frgridAut == 0

*wf
foreach x in phonological_awareness_wf_6 phonological_awareness_wf_7	phonological_awareness_wf_8	phonological_awareness_wf_9 phonological_awareness_wf_10 {
	replace `x'= . if phonological_awareness_wf_1 == 0 & phonological_awareness_wf_2 == 0 & phonological_awareness_wf_3 == 0 & phonological_awareness_wf_4 == 0 & phonological_awareness_wf_5 == 0
}

replace phonological_awareness_wfnumber_ = 0 if phonological_awareness_wf_1 == 0 & phonological_awareness_wf_2 == 0 & phonological_awareness_wf_3 == 0 & phonological_awareness_wf_4 == 0 & phonological_awareness_wf_5 == 0 | interview_ID == "b186bac0-cc7f-409d-853f-6e45b086c73d"

replace phonological_awareness_wfnum_att = 5 if phonological_awareness_wf_1 == 0 & phonological_awareness_wf_2 == 0 & phonological_awareness_wf_3 == 0 & phonological_awareness_wf_4 == 0 & phonological_awareness_wf_5 == 0 | interview_ID == "b186bac0-cc7f-409d-853f-6e45b086c73d"

replace phonological_awareness_wfgridAut = 1 if phonological_awareness_wf_1 == 0 & phonological_awareness_wf_2 == 0 & phonological_awareness_wf_3 == 0 & phonological_awareness_wf_4 == 0 & phonological_awareness_wf_5 == 0 | interview_ID == "b186bac0-cc7f-409d-853f-6e45b086c73d"

foreach x in phonological_awareness_wf_2 phonological_awareness_wf_3	phonological_awareness_wf_4	phonological_awareness_wf_5 {
	replace `x'= 0 if interview_ID == "b186bac0-cc7f-409d-853f-6e45b086c73d"
}

replace phonological_awareness_wfgridAut = 0 if phonological_awareness_wfnum_att == 0

replace phonological_stop_wf = 1 if phonological_awareness_wfgridAut == 1
replace phonological_stop_wf = 0 if phonological_awareness_wfgridAut == 0

*sr
foreach x in phonological_awareness_sr_6 phonological_awareness_sr_7	phonological_awareness_sr_8	phonological_awareness_sr_9 phonological_awareness_sr_10 {
	replace `x'= . if phonological_awareness_sr_1 == 0 & phonological_awareness_sr_2 == 0 & phonological_awareness_sr_3 == 0 & phonological_awareness_sr_4 == 0 & phonological_awareness_sr_5 == 0
}

replace phonological_awareness_srnumber_ = 0 if phonological_awareness_sr_1 == 0 & phonological_awareness_sr_2 == 0 & phonological_awareness_sr_3 == 0 & phonological_awareness_sr_4 == 0 & phonological_awareness_sr_5 == 0 | interview_ID == "fa7c730e-4e47-4e56-9adf-331a3dbce907"

replace phonological_awareness_srnum_att = 5 if phonological_awareness_sr_1 == 0 & phonological_awareness_sr_2 == 0 & phonological_awareness_sr_3 == 0 & phonological_awareness_sr_4 == 0 & phonological_awareness_sr_5 == 0 | interview_ID == "fa7c730e-4e47-4e56-9adf-331a3dbce907"

replace phonological_awareness_srgridAut = 1 if phonological_awareness_sr_1 == 0 & phonological_awareness_sr_2 == 0 & phonological_awareness_sr_3 == 0 & phonological_awareness_sr_4 == 0 & phonological_awareness_sr_5 == 0 | interview_ID == "fa7c730e-4e47-4e56-9adf-331a3dbce907"

foreach x in phonological_awareness_sr_2 phonological_awareness_sr_3	phonological_awareness_sr_4	phonological_awareness_sr_5 {
	replace `x'= 0 if interview_ID == "fa7c730e-4e47-4e56-9adf-331a3dbce907"
}

replace phonological_awareness_srgridAut = 0 if phonological_awareness_srnum_att == 0

replace phonological_stop_sr = 1 if phonological_awareness_srgridAut == 1
replace phonological_stop_sr = 0 if phonological_awareness_srgridAut == 0

*pr
foreach x in phonological_awareness_pr_6 phonological_awareness_pr_7	phonological_awareness_pr_8	phonological_awareness_pr_9 phonological_awareness_pr_10 {
	replace `x'= . if phonological_awareness_pr_1 == 0 & phonological_awareness_pr_2 == 0 & phonological_awareness_pr_3 == 0 & phonological_awareness_pr_4 == 0 & phonological_awareness_pr_5 == 0
}

replace phonological_awareness_prnumber_ = 0 if phonological_awareness_pr_1 == 0 & phonological_awareness_pr_2 == 0 & phonological_awareness_pr_3 == 0 & phonological_awareness_pr_4 == 0 & phonological_awareness_pr_5 == 0 | interview_ID == "7cd83584-fa4c-4ef4-8924-0de3a7a79144"

replace phonological_awareness_prnum_att = 5 if phonological_awareness_pr_1 == 0 & phonological_awareness_pr_2 == 0 & phonological_awareness_pr_3 == 0 & phonological_awareness_pr_4 == 0 & phonological_awareness_pr_5 == 0 | interview_ID == "7cd83584-fa4c-4ef4-8924-0de3a7a79144"

replace phonological_awareness_prgridAut = 1 if phonological_awareness_pr_1 == 0 & phonological_awareness_pr_2 == 0 & phonological_awareness_pr_3 == 0 & phonological_awareness_pr_4 == 0 & phonological_awareness_pr_5 == 0 | interview_ID == "7cd83584-fa4c-4ef4-8924-0de3a7a79144"

foreach x in phonological_awareness_pr_2 phonological_awareness_pr_3	phonological_awareness_pr_4	phonological_awareness_pr_5 {
	replace `x'= 0 if interview_ID == "7cd83584-fa4c-4ef4-8924-0de3a7a79144"
}

replace phonological_awareness_prgridAut = 0 if phonological_awareness_prnum_att == 0

replace phonological_stop_pr = 1 if phonological_awareness_prgridAut == 1
replace phonological_stop_pr = 0 if phonological_awareness_prgridAut == 0


*************************************************************************
**Oral Vocabulary section
*************************************************************************
ren (v1077 v1080 v1083 v1086 v1089 v1092 v1095 v1098 v1101 v1104 v1107	v1110 v1113 v1116 v1119 v1122 v1125 v1442 v1445 v1448 v1451 v1454 v1457 v1460 v1463 v1466 v1469 v1472 v1475 v1478 v1481 v1484 v222 v227 v232 v237 v242 v247 v252 v257 v262 v267 v272 v277 v282 v287 v292 v297 v302 v1815 v1818 v1821 v1824 v1827 v1830 v1833 v1836 v1839 v1842 v1845 v1848 v1851 v1854 v1857 v1860 v1863) (sr_oral_vocabulary_example_1  sr_oral_vocabulary_example_2 sr_ov_picture_matching_q1 sr_ov_picture_matching_q2 sr_ov_picture_matching_q3 sr_ov_picture_matching_q4 sr_ov_picture_matching_q5 sr_ov_picture_matching_q6 sr_ov_picture_matching_q7 sr_ov_picture_matching_q8 sr_ov_picture_matching_q9 sr_ov_picture_matching_q10 sr_ov_picture_matching_q11 sr_ov_picture_matching_q12 sr_ov_picture_matching_q13 sr_ov_picture_matching_q14 sr_ov_picture_matching_q15  fr_ov_picture_matching_q1 fr_ov_picture_matching_q2 fr_ov_picture_matching_q3 fr_ov_picture_matching_q4 fr_ov_picture_matching_q5 fr_ov_picture_matching_q6 fr_ov_picture_matching_q7 fr_ov_picture_matching_q8 fr_ov_picture_matching_q9 fr_ov_picture_matching_q10 fr_ov_picture_matching_q11 fr_ov_picture_matching_q12 fr_ov_picture_matching_q13 fr_ov_picture_matching_q14 fr_ov_picture_matching_q15 wf_oral_vocabulary_example_1  wf_oral_vocabulary_example_2 wf_ov_picture_matching_q1 wf_ov_picture_matching_q2 wf_ov_picture_matching_q3 wf_ov_picture_matching_q4 wf_ov_picture_matching_q5 wf_ov_picture_matching_q6 wf_ov_picture_matching_q7 wf_ov_picture_matching_q8 wf_ov_picture_matching_q9 wf_ov_picture_matching_q10 wf_ov_picture_matching_q11 wf_ov_picture_matching_q12 wf_ov_picture_matching_q13 wf_ov_picture_matching_q14 wf_ov_picture_matching_q15 pr_oral_vocabulary_example_1  pr_oral_vocabulary_example_2 pr_ov_picture_matching_q1 pr_ov_picture_matching_q2 pr_ov_picture_matching_q3 pr_ov_picture_matching_q4 pr_ov_picture_matching_q5 pr_ov_picture_matching_q6 pr_ov_picture_matching_q7 pr_ov_picture_matching_q8 pr_ov_picture_matching_q9 pr_ov_picture_matching_q10 pr_ov_picture_matching_q11 pr_ov_picture_matching_q12 pr_ov_picture_matching_q13 pr_ov_picture_matching_q14 pr_ov_picture_matching_q15)

ren (v1436 v1439)(fr_oral_vocabulary_example_1 fr_oral_vocabulary_example_2)


destring sr_oral_vocabulary_example_1 sr_oral_vocabulary_example_2 sr_ov_picture_matching_q1 sr_ov_picture_matching_q2 sr_ov_picture_matching_q3 sr_ov_picture_matching_q4 sr_ov_picture_matching_q5 sr_ov_picture_matching_q6 sr_ov_picture_matching_q7 sr_ov_picture_matching_q8 sr_ov_picture_matching_q9 sr_ov_picture_matching_q10 sr_ov_picture_matching_q11 sr_ov_picture_matching_q12 sr_ov_picture_matching_q13 sr_ov_picture_matching_q14 sr_ov_picture_matching_q15 fr_ov_picture_matching_q1 fr_ov_picture_matching_q2 fr_ov_picture_matching_q3 fr_ov_picture_matching_q4 fr_ov_picture_matching_q5 fr_ov_picture_matching_q6 fr_ov_picture_matching_q7 fr_ov_picture_matching_q8 fr_ov_picture_matching_q9 fr_ov_picture_matching_q10 fr_ov_picture_matching_q11 fr_ov_picture_matching_q12 fr_ov_picture_matching_q13 fr_ov_picture_matching_q14 fr_ov_picture_matching_q15 wf_oral_vocabulary_example_1  wf_oral_vocabulary_example_2 wf_ov_picture_matching_q1 wf_ov_picture_matching_q2 wf_ov_picture_matching_q3 wf_ov_picture_matching_q4 wf_ov_picture_matching_q5 wf_ov_picture_matching_q6 wf_ov_picture_matching_q7 wf_ov_picture_matching_q8 wf_ov_picture_matching_q9 wf_ov_picture_matching_q10 wf_ov_picture_matching_q11 wf_ov_picture_matching_q12 wf_ov_picture_matching_q13 wf_ov_picture_matching_q14 wf_ov_picture_matching_q15 pr_oral_vocabulary_example_1  pr_oral_vocabulary_example_2 pr_ov_picture_matching_q1 pr_ov_picture_matching_q2 pr_ov_picture_matching_q3 pr_ov_picture_matching_q4 pr_ov_picture_matching_q5 pr_ov_picture_matching_q6 pr_ov_picture_matching_q7 pr_ov_picture_matching_q8 pr_ov_picture_matching_q9 pr_ov_picture_matching_q10 pr_ov_picture_matching_q11 pr_ov_picture_matching_q12 pr_ov_picture_matching_q13 pr_ov_picture_matching_q14 pr_ov_picture_matching_q15 fr_oral_vocabulary_example_1 fr_oral_vocabulary_example_2, replace

order fr_oral_vocabulary_example_1 fr_oral_vocabulary_example_2 fr_ov_picture_matching_q1 fr_ov_picture_matching_q2 fr_ov_picture_matching_q3 fr_ov_picture_matching_q4 fr_ov_picture_matching_q5 fr_ov_picture_matching_q6 fr_ov_picture_matching_q7 fr_ov_picture_matching_q8 fr_ov_picture_matching_q9 fr_ov_picture_matching_q10 fr_ov_picture_matching_q11 fr_ov_picture_matching_q12 fr_ov_picture_matching_q13 fr_ov_picture_matching_q14 fr_ov_picture_matching_q15 wf_oral_vocabulary_example_1  wf_oral_vocabulary_example_2 wf_ov_picture_matching_q1 wf_ov_picture_matching_q2 wf_ov_picture_matching_q3 wf_ov_picture_matching_q4 wf_ov_picture_matching_q5 wf_ov_picture_matching_q6 wf_ov_picture_matching_q7 wf_ov_picture_matching_q8 wf_ov_picture_matching_q9 wf_ov_picture_matching_q10 wf_ov_picture_matching_q11 wf_ov_picture_matching_q12 wf_ov_picture_matching_q13 wf_ov_picture_matching_q14 wf_ov_picture_matching_q15 sr_oral_vocabulary_example_1 sr_oral_vocabulary_example_2 sr_ov_picture_matching_q1 sr_ov_picture_matching_q2 sr_ov_picture_matching_q3 sr_ov_picture_matching_q4 sr_ov_picture_matching_q5 sr_ov_picture_matching_q6 sr_ov_picture_matching_q7 sr_ov_picture_matching_q8 sr_ov_picture_matching_q9 sr_ov_picture_matching_q10 sr_ov_picture_matching_q11 sr_ov_picture_matching_q12 sr_ov_picture_matching_q13 sr_ov_picture_matching_q14 sr_ov_picture_matching_q15 pr_oral_vocabulary_example_1  pr_oral_vocabulary_example_2 pr_ov_picture_matching_q1 pr_ov_picture_matching_q2 pr_ov_picture_matching_q3 pr_ov_picture_matching_q4 pr_ov_picture_matching_q5 pr_ov_picture_matching_q6 pr_ov_picture_matching_q7 pr_ov_picture_matching_q8 pr_ov_picture_matching_q9 pr_ov_picture_matching_q10 pr_ov_picture_matching_q11 pr_ov_picture_matching_q12 pr_ov_picture_matching_q13 pr_ov_picture_matching_q14 pr_ov_picture_matching_q15,after(phonological_stop_pr)

*************************************************************************
**Letter Knowledge section
*************************************************************************
ren (v403 interviewer_letter_knowledge_rea interviewer_letter_knowledge_sto v448 v1513 v1560 v1561 v1558 v1154 v1201 v1202 v1199 v1892 v1939 v1940 v1937) (letter_knowledge_wfnum_att letter_knowledge_reason_wf letter_knowledge_stop_wf letter_knowledge_wf_Bnum_att letter_knowledge_frnum_att letter_knowledge_reason_fr letter_knowledge_stop_fr letter_knowledge_fr_Bnum_att letter_knowledge_srnum_att letter_knowledge_reason_sr letter_knowledge_stop_sr letter_knowledge_sr_Bnum_att letter_knowledge_prnum_att letter_knowledge_reason_pr letter_knowledge_stop_pr letter_knowledge_pr_Bnum_att)

*fr
order  letter_knowledge_recording_fr letter_knowledge_fr_*  letter_knowledge_frduration letter_knowledge_frtime_remainin letter_knowledge_frgridAutoStopp letter_knowledge_frautoStop letter_knowledge_fritem_at_time letter_knowledge_frtime_intermed letter_knowledge_frnumber_of_ite letter_knowledge_frnum_att letter_knowledge_fritems_per_min letter_knowledge_reason_fr letter_knowledge_stop_fr,after(pr_ov_picture_matching_q15)

order letter_knowledge_fr_B_* letter_knowledge_fr_B*,after(letter_knowledge_stop_fr)

drop letter_knowledge_frautoStop letter_knowledge_fritem_at_time letter_knowledge_frtime_intermed letter_knowledge_fr_BautoStop	letter_knowledge_fr_Bitem_at_tim letter_knowledge_fr_Btime_interm
		


*wf
order letter_knowledge_recording_wf  letter_knowledge_wf_*  letter_knowledge_wfduration letter_knowledge_wftime_remainin letter_knowledge_wfgridAutoStopp letter_knowledge_wfautoStop letter_knowledge_wfitem_at_time letter_knowledge_wftime_intermed letter_knowledge_wfnumber_of_ite letter_knowledge_wfnum_att letter_knowledge_wfitems_per_min letter_knowledge_reason_wf letter_knowledge_stop_wf,after(letter_knowledge_fr_Bitems_per_m)

order letter_knowledge_wf_B_* letter_knowledge_wf_B*,after(letter_knowledge_stop_wf)

drop letter_knowledge_wfautoStop	letter_knowledge_wfitem_at_time	letter_knowledge_wftime_intermed letter_knowledge_wf_BautoStop	letter_knowledge_wf_Bitem_at_tim letter_knowledge_wf_Btime_interm

*sr
order letter_knowledge_recording_sr letter_knowledge_sr_* letter_knowledge_srduration letter_knowledge_srtime_remainin letter_knowledge_srgridAutoStopp letter_knowledge_srautoStop letter_knowledge_sritem_at_time letter_knowledge_srtime_intermed letter_knowledge_srnumber_of_ite letter_knowledge_srnum_att letter_knowledge_sritems_per_min letter_knowledge_reason_sr  letter_knowledge_stop_sr,after(letter_knowledge_wf_Bitems_per_m)

order letter_knowledge_sr_B_*  letter_knowledge_sr_B*,after(letter_knowledge_stop_sr)

drop letter_knowledge_srautoStop	letter_knowledge_sritem_at_time	letter_knowledge_srtime_intermed letter_knowledge_sr_BautoStop	letter_knowledge_sr_Bitem_at_tim letter_knowledge_sr_Btime_interm

*pr
order letter_knowledge_recording_pr  letter_knowledge_pr_*  letter_knowledge_prduration letter_knowledge_prtime_remainin letter_knowledge_prgridAutoStopp letter_knowledge_prautoStop letter_knowledge_pritem_at_time letter_knowledge_prtime_intermed letter_knowledge_prnumber_of_ite letter_knowledge_prnum_att letter_knowledge_pritems_per_min letter_knowledge_pr_B_*  letter_knowledge_pr_B* letter_knowledge_reason_pr letter_knowledge_stop_pr, after(letter_knowledge_sr_Bitems_per_m)

order letter_knowledge_pr_B_*  letter_knowledge_pr_B*,after(letter_knowledge_stop_pr)

drop letter_knowledge_prautoStop letter_knowledge_pritem_at_time letter_knowledge_prtime_intermed letter_knowledge_pr_BautoStop	letter_knowledge_pr_Bitem_at_tim letter_knowledge_pr_Btime_interm

destring letter_knowledge_fr_* letter_knowledge_fr_B_* letter_knowledge_frduration	letter_knowledge_frtime_remainin letter_knowledge_wf_* letter_knowledge_wf_B_* letter_knowledge_wfduration letter_knowledge_wftime_remainin letter_knowledge_sr_* letter_knowledge_sr_B_* letter_knowledge_srduration letter_knowledge_srtime_remainin letter_knowledge_pr_* letter_knowledge_pr_B_* letter_knowledge_prduration letter_knowledge_prtime_remainin letter_knowledge_frnumber_of_ite	letter_knowledge_frnum_att	letter_knowledge_fritems_per_min	letter_knowledge_reason_fr	letter_knowledge_stop_fr letter_knowledge_wfnumber_of_ite	letter_knowledge_wfnum_att	letter_knowledge_wfitems_per_min	letter_knowledge_reason_wf	letter_knowledge_stop_wf letter_knowledge_srnumber_of_ite	letter_knowledge_srnum_att	letter_knowledge_sritems_per_min	letter_knowledge_reason_sr	letter_knowledge_stop_sr letter_knowledge_prnumber_of_ite	letter_knowledge_prnum_att	letter_knowledge_pritems_per_min	letter_knowledge_reason_pr	letter_knowledge_stop_pr,replace

lab values letter_knowledge_fr_1 - letter_knowledge_fr_20 letter_knowledge_fr_B_1 - letter_knowledge_fr_B_36 letter_knowledge_wf_1 - letter_knowledge_wf_20 letter_knowledge_wf_B_1 - letter_knowledge_wf_B_36 letter_knowledge_sr_1 - letter_knowledge_sr_20 letter_knowledge_sr_B_1 - letter_knowledge_sr_B_36 letter_knowledge_pr_1 - letter_knowledge_pr_20 letter_knowledge_pr_B_1 - letter_knowledge_pr_B_36 cor_inc

lab values letter_knowledge_stop_fr letter_knowledge_stop_wf letter_knowledge_stop_sr letter_knowledge_stop_pr letter_knowledge_reason_fr letter_knowledge_reason_wf letter_knowledge_reason_sr letter_knowledge_reason_pr yes_no

foreach x in letter_knowledge_fr_BgridAutoSto letter_knowledge_wf_BgridAutoSto letter_knowledge_sr_BgridAutoSto letter_knowledge_pr_BgridAutoSto letter_knowledge_frgridAutoStopp letter_knowledge_wfgridAutoStopp letter_knowledge_srgridAutoStopp letter_knowledge_prgridAutoStopp{
	replace `x' = "1" if `x' == "TRUE"
	replace `x' = "0" if `x' == "FALSE"
	destring `x',replace
}

lab values letter_knowledge_fr_BgridAutoSto letter_knowledge_wf_BgridAutoSto letter_knowledge_sr_BgridAutoSto letter_knowledge_pr_BgridAutoSto letter_knowledge_frgridAutoStopp letter_knowledge_wfgridAutoStopp letter_knowledge_srgridAutoStopp letter_knowledge_prgridAutoStopp true_false

*update correction
*fr
foreach x in letter_knowledge_fr_9	letter_knowledge_fr_10	letter_knowledge_fr_11	letter_knowledge_fr_12	letter_knowledge_fr_13	letter_knowledge_fr_14	letter_knowledge_fr_15	letter_knowledge_fr_16	letter_knowledge_fr_17	letter_knowledge_fr_18	letter_knowledge_fr_19	letter_knowledge_fr_20{
	replace `x'= . if letter_knowledge_fr_1==0 & letter_knowledge_fr_2==0 &letter_knowledge_fr_3==0 & letter_knowledge_fr_4==0 & letter_knowledge_fr_5==0 & letter_knowledge_fr_6==0 & letter_knowledge_fr_7 == 0 & letter_knowledge_fr_8 == 0
}

replace letter_knowledge_frnumber_of_ite = 0 if letter_knowledge_fr_1==0 & letter_knowledge_fr_2==0 &letter_knowledge_fr_3==0 & letter_knowledge_fr_4==0 & letter_knowledge_fr_5==0 & letter_knowledge_fr_6==0 & letter_knowledge_fr_7 == 0 & letter_knowledge_fr_8 == 0

replace letter_knowledge_fritems_per_min = 0 if letter_knowledge_fr_1==0 & letter_knowledge_fr_2==0 &letter_knowledge_fr_3==0 & letter_knowledge_fr_4==0 & letter_knowledge_fr_5==0 & letter_knowledge_fr_6==0 & letter_knowledge_fr_7 == 0 & letter_knowledge_fr_8 == 0

replace letter_knowledge_frnum_att = 8 if letter_knowledge_fr_1==0 & letter_knowledge_fr_2==0 &letter_knowledge_fr_3==0 & letter_knowledge_fr_4==0 & letter_knowledge_fr_5==0 & letter_knowledge_fr_6==0 & letter_knowledge_fr_7 == 0 & letter_knowledge_fr_8 == 0

replace letter_knowledge_frgridAutoStopp = 1 if letter_knowledge_fr_1==0 & letter_knowledge_fr_2==0 &letter_knowledge_fr_3==0 & letter_knowledge_fr_4==0 & letter_knowledge_fr_5==0 & letter_knowledge_fr_6==0 & letter_knowledge_fr_7 == 0 & letter_knowledge_fr_8 == 0

replace letter_knowledge_stop_fr = 1 if letter_knowledge_frgridAutoStopp == 1
replace letter_knowledge_stop_fr = 0 if letter_knowledge_frgridAutoStopp == 0

foreach x in letter_knowledge_fr_13	letter_knowledge_fr_14	letter_knowledge_fr_15	letter_knowledge_fr_16	letter_knowledge_fr_17	letter_knowledge_fr_18	letter_knowledge_fr_19	letter_knowledge_fr_20{
	replace `x' = 0 if inlist(interview_ID,"35c2f886-a1f8-47d0-b2cf-1fa485954735","c9efa50e-d6b2-4fee-ab0a-9eb391385bca","5f727244-96b2-401e-8b19-5a3b5bb464ce","73fff59c-a151-4d4d-b903-fb2d1485a31d","bb0155ad-ef53-45da-b681-616aca6cbdc7")
}

egen letter_knowledge_frnum_of_ite1 = rowtotal(letter_knowledge_fr_1 - letter_knowledge_fr_20)
replace letter_knowledge_frnumber_of_ite = letter_knowledge_frnum_of_ite1 if inlist(interview_ID,"35c2f886-a1f8-47d0-b2cf-1fa485954735","c9efa50e-d6b2-4fee-ab0a-9eb391385bca","5f727244-96b2-401e-8b19-5a3b5bb464ce","73fff59c-a151-4d4d-b903-fb2d1485a31d","bb0155ad-ef53-45da-b681-616aca6cbdc7")

replace letter_knowledge_fritems_per_min = letter_knowledge_frnumber_of_ite if inlist(interview_ID,"35c2f886-a1f8-47d0-b2cf-1fa485954735","c9efa50e-d6b2-4fee-ab0a-9eb391385bca","5f727244-96b2-401e-8b19-5a3b5bb464ce","73fff59c-a151-4d4d-b903-fb2d1485a31d","bb0155ad-ef53-45da-b681-616aca6cbdc7")

foreach x in letter_knowledge_fr_Bduration	letter_knowledge_fr_Btime_remain	letter_knowledge_fr_BgridAutoSto	letter_knowledge_fr_Bnumber_of_i	letter_knowledge_fr_Bnum_att	letter_knowledge_fr_Bitems_per_m{
	replace `x' = . if inlist(interview_ID,"35c2f886-a1f8-47d0-b2cf-1fa485954735","c9efa50e-d6b2-4fee-ab0a-9eb391385bca","5f727244-96b2-401e-8b19-5a3b5bb464ce","73fff59c-a151-4d4d-b903-fb2d1485a31d","bb0155ad-ef53-45da-b681-616aca6cbdc7") | letter_knowledge_frnumber_of_ite < 13
}

replace letter_knowledge_fr_Btime_remain = letter_knowledge_fr_Btime_remain - 62 if letter_knowledge_fr_Bnumber_of_i == 0 & letter_knowledge_fr_Bnum_att == 0

egen corrr1 = rowtotal(letter_knowledge_fr_B_1-letter_knowledge_fr_B_36)
replace letter_knowledge_fr_Bnumber_of_i = corrr1 if letter_knowledge_fr_Bnum_att == 0 & letter_knowledge_fr_Bnumber_of_i == 0 

replace letter_knowledge_fr_Bitems_per_m = round(60*(corrr1/(letter_knowledge_fr_Bduration-letter_knowledge_fr_Btime_remain))) if letter_knowledge_fr_Bnum_att == 0 & letter_knowledge_fr_Bnumber_of_i == 0 | !missing(letter_knowledge_fr_Btime_remain)


egen att1 = rownonmiss(letter_knowledge_fr_B_1-letter_knowledge_fr_B_36)
replace letter_knowledge_fr_Bnum_att = att1 if letter_knowledge_fr_Bnum_att == 0

drop letter_knowledge_frnum_of_ite1 att1 corrr1

*wf
foreach x in letter_knowledge_wf_9	letter_knowledge_wf_10	letter_knowledge_wf_11	letter_knowledge_wf_12	letter_knowledge_wf_13	letter_knowledge_wf_14	letter_knowledge_wf_15	letter_knowledge_wf_16	letter_knowledge_wf_17	letter_knowledge_wf_18	letter_knowledge_wf_19	letter_knowledge_wf_20{
	replace `x'= . if letter_knowledge_wf_1==0 & letter_knowledge_wf_2==0 &letter_knowledge_wf_3==0 & letter_knowledge_wf_4==0 & letter_knowledge_wf_5==0 & letter_knowledge_wf_6==0 & letter_knowledge_wf_7 == 0 & letter_knowledge_wf_8 == 0
}

replace letter_knowledge_wfnumber_of_ite = 0 if letter_knowledge_wf_1==0 & letter_knowledge_wf_2==0 &letter_knowledge_wf_3==0 & letter_knowledge_wf_4==0 & letter_knowledge_wf_5==0 & letter_knowledge_wf_6==0 & letter_knowledge_wf_7 == 0 & letter_knowledge_wf_8 == 0

replace letter_knowledge_wfitems_per_min = 0 if letter_knowledge_wf_1==0 & letter_knowledge_wf_2==0 &letter_knowledge_wf_3==0 & letter_knowledge_wf_4==0 & letter_knowledge_wf_5==0 & letter_knowledge_wf_6==0 & letter_knowledge_wf_7 == 0 & letter_knowledge_wf_8 == 0

replace letter_knowledge_wfnum_att = 8 if letter_knowledge_wf_1==0 & letter_knowledge_wf_2==0 &letter_knowledge_wf_3==0 & letter_knowledge_wf_4==0 & letter_knowledge_wf_5==0 & letter_knowledge_wf_6==0 & letter_knowledge_wf_7 == 0 & letter_knowledge_wf_8 == 0

replace letter_knowledge_wfgridAutoStopp = 1 if letter_knowledge_wf_1==0 & letter_knowledge_wf_2==0 &letter_knowledge_wf_3==0 & letter_knowledge_wf_4==0 & letter_knowledge_wf_5==0 & letter_knowledge_wf_6==0 & letter_knowledge_wf_7 == 0 & letter_knowledge_wf_8 == 0

replace letter_knowledge_stop_wf = 1 if letter_knowledge_wfgridAutoStopp == 1
replace letter_knowledge_stop_wf = 0 if letter_knowledge_wfgridAutoStopp == 0

foreach x in letter_knowledge_wf_15	letter_knowledge_wf_16	letter_knowledge_wf_17{
	replace `x' = 0 if inlist(interview_ID,"a3799748-5d88-4de6-a038-c5923894507d")
}

egen letter_knowledge_wfnum_of_ite1 = rowtotal(letter_knowledge_wf_1 - letter_knowledge_wf_20)
replace letter_knowledge_wfnumber_of_ite = letter_knowledge_wfnum_of_ite1 if inlist(interview_ID,"a3799748-5d88-4de6-a038-c5923894507d","67b71d7b-c519-402a-8ecb-9bff07849803", "3ec4200b-e4fc-4b5d-8508-165b7dda4b7d","dd2019e6-d5da-4e39-a73e-086054939141")

replace letter_knowledge_wfitems_per_min = letter_knowledge_wfnumber_of_ite if inlist(interview_ID,"a3799748-5d88-4de6-a038-c5923894507d","67b71d7b-c519-402a-8ecb-9bff07849803","3ec4200b-e4fc-4b5d-8508-165b7dda4b7d","dd2019e6-d5da-4e39-a73e-086054939141")

foreach x in letter_knowledge_wf_Bduration	letter_knowledge_wf_Btime_remain	letter_knowledge_wf_BgridAutoSto	letter_knowledge_wf_Bnumber_of_i	letter_knowledge_wf_Bnum_att	letter_knowledge_wf_Bitems_per_m{
	replace `x' = . if inlist(interview_ID,"a3799748-5d88-4de6-a038-c5923894507d") | letter_knowledge_wfnumber_of_ite < 13
}

replace letter_knowledge_wf_Btime_remain = letter_knowledge_wf_Btime_remain - 62 if letter_knowledge_wf_Bnumber_of_i == 0 & letter_knowledge_wf_Bnum_att == 0

egen corrr1 = rowtotal(letter_knowledge_wf_B_1-letter_knowledge_wf_B_36)
replace letter_knowledge_wf_Bnumber_of_i = corrr1 if letter_knowledge_wf_Bnum_att == 0 & letter_knowledge_wf_Bnumber_of_i == 0 

replace letter_knowledge_wf_Bitems_per_m = round(60*(corrr1/(letter_knowledge_wf_Bduration-letter_knowledge_wf_Btime_remain))) if letter_knowledge_wf_Bnum_att == 0 & letter_knowledge_wf_Bnumber_of_i == 0 | !missing(letter_knowledge_wf_Btime_remain)

egen att1 = rownonmiss(letter_knowledge_wf_B_1-letter_knowledge_wf_B_36)
replace letter_knowledge_wf_Bnum_att = att1 if letter_knowledge_wf_Bnum_att == 0

drop letter_knowledge_wfnum_of_ite1 att1 corrr1


*sr
foreach x in letter_knowledge_sr_9	letter_knowledge_sr_10	letter_knowledge_sr_11	letter_knowledge_sr_12	letter_knowledge_sr_13	letter_knowledge_sr_14	letter_knowledge_sr_15	letter_knowledge_sr_16	letter_knowledge_sr_17	letter_knowledge_sr_18	letter_knowledge_sr_19	letter_knowledge_sr_20{
	replace `x'= . if letter_knowledge_sr_1==0 & letter_knowledge_sr_2==0 &letter_knowledge_sr_3==0 & letter_knowledge_sr_4==0 & letter_knowledge_sr_5==0 & letter_knowledge_sr_6==0 & letter_knowledge_sr_7 == 0 & letter_knowledge_sr_8 == 0
}

replace letter_knowledge_srnumber_of_ite = 0 if letter_knowledge_sr_1==0 & letter_knowledge_sr_2==0 &letter_knowledge_sr_3==0 & letter_knowledge_sr_4==0 & letter_knowledge_sr_5==0 & letter_knowledge_sr_6==0 & letter_knowledge_sr_7 == 0 & letter_knowledge_sr_8 == 0

replace letter_knowledge_sritems_per_min = 0 if letter_knowledge_sr_1==0 & letter_knowledge_sr_2==0 &letter_knowledge_sr_3==0 & letter_knowledge_sr_4==0 & letter_knowledge_sr_5==0 & letter_knowledge_sr_6==0 & letter_knowledge_sr_7 == 0 & letter_knowledge_sr_8 == 0

replace letter_knowledge_srnum_att = 8 if letter_knowledge_sr_1==0 & letter_knowledge_sr_2==0 &letter_knowledge_sr_3==0 & letter_knowledge_sr_4==0 & letter_knowledge_sr_5==0 & letter_knowledge_sr_6==0 & letter_knowledge_sr_7 == 0 & letter_knowledge_sr_8 == 0

replace letter_knowledge_srgridAutoStopp = 1 if letter_knowledge_sr_1==0 & letter_knowledge_sr_2==0 &letter_knowledge_sr_3==0 & letter_knowledge_sr_4==0 & letter_knowledge_sr_5==0 & letter_knowledge_sr_6==0 & letter_knowledge_sr_7 == 0 & letter_knowledge_sr_8 == 0

replace letter_knowledge_stop_sr = 1 if letter_knowledge_srgridAutoStopp == 1
replace letter_knowledge_stop_sr = 0 if letter_knowledge_srgridAutoStopp == 0

foreach x in letter_knowledge_sr_7	letter_knowledge_sr_8 letter_knowledge_sr_11	letter_knowledge_sr_12	letter_knowledge_sr_13	letter_knowledge_sr_14 letter_knowledge_sr_15	letter_knowledge_sr_16	letter_knowledge_sr_17{
	replace `x' = 0 if inlist(interview_ID,"35c2f886-a1f8-47d0-b2cf-1fa485954735","26b79d94-fc5c-4136-97d3-dffaea376bbc")
}

egen letter_knowledge_srnum_of_ite1 = rowtotal(letter_knowledge_sr_1 - letter_knowledge_sr_20)
replace letter_knowledge_srnumber_of_ite = letter_knowledge_srnum_of_ite1 if inlist(interview_ID,"35c2f886-a1f8-47d0-b2cf-1fa485954735","26b79d94-fc5c-4136-97d3-dffaea376bbc")

replace letter_knowledge_sritems_per_min = letter_knowledge_srnumber_of_ite if inlist(interview_ID,"35c2f886-a1f8-47d0-b2cf-1fa485954735","26b79d94-fc5c-4136-97d3-dffaea376bbc")

foreach x in letter_knowledge_sr_Bduration	letter_knowledge_sr_Btime_remain	letter_knowledge_sr_BgridAutoSto	letter_knowledge_sr_Bnumber_of_i	letter_knowledge_sr_Bnum_att	letter_knowledge_sr_Bitems_per_m{
	replace `x' = . if inlist(interview_ID,"35c2f886-a1f8-47d0-b2cf-1fa485954735","26b79d94-fc5c-4136-97d3-dffaea376bbc") |    letter_knowledge_srnumber_of_ite < 13
}

replace letter_knowledge_sr_Btime_remain = letter_knowledge_sr_Btime_remain - 62 if letter_knowledge_sr_Bnumber_of_i == 0 & letter_knowledge_sr_Bnum_att == 0

egen corrr1 = rowtotal(letter_knowledge_sr_B_1-letter_knowledge_sr_B_36)
replace letter_knowledge_sr_Bnumber_of_i = corrr1 if letter_knowledge_sr_Bnum_att == 0 & letter_knowledge_sr_Bnumber_of_i == 0 

replace letter_knowledge_sr_Bitems_per_m = round(60*(corrr1/(letter_knowledge_sr_Bduration-letter_knowledge_sr_Btime_remain))) if letter_knowledge_sr_Bnum_att == 0 & letter_knowledge_sr_Bnumber_of_i == 0 | !missing(letter_knowledge_sr_Btime_remain)


egen att1 = rownonmiss(letter_knowledge_sr_B_1-letter_knowledge_sr_B_36)
replace letter_knowledge_sr_Bnum_att = att1 if letter_knowledge_sr_Bnum_att == 0

drop letter_knowledge_srnum_of_ite1 att1 corrr1


*pr
foreach x in letter_knowledge_pr_9	letter_knowledge_pr_10	letter_knowledge_pr_11	letter_knowledge_pr_12	letter_knowledge_pr_13	letter_knowledge_pr_14	letter_knowledge_pr_15	letter_knowledge_pr_16	letter_knowledge_pr_17	letter_knowledge_pr_18	letter_knowledge_pr_19	letter_knowledge_pr_20{
	replace `x'= . if letter_knowledge_pr_1==0 & letter_knowledge_pr_2==0 &letter_knowledge_pr_3==0 & letter_knowledge_pr_4==0 & letter_knowledge_pr_5==0 & letter_knowledge_pr_6==0 & letter_knowledge_pr_7 == 0 & letter_knowledge_pr_8 == 0
}

replace letter_knowledge_prnumber_of_ite = 0 if letter_knowledge_pr_1==0 & letter_knowledge_pr_2==0 &letter_knowledge_pr_3==0 & letter_knowledge_pr_4==0 & letter_knowledge_pr_5==0 & letter_knowledge_pr_6==0 & letter_knowledge_pr_7 == 0 & letter_knowledge_pr_8 == 0

replace letter_knowledge_pritems_per_min = 0 if letter_knowledge_pr_1==0 & letter_knowledge_pr_2==0 &letter_knowledge_pr_3==0 & letter_knowledge_pr_4==0 & letter_knowledge_pr_5==0 & letter_knowledge_pr_6==0 & letter_knowledge_pr_7 == 0 & letter_knowledge_pr_8 == 0

replace letter_knowledge_prnum_att = 8 if letter_knowledge_pr_1==0 & letter_knowledge_pr_2==0 &letter_knowledge_pr_3==0 & letter_knowledge_pr_4==0 & letter_knowledge_pr_5==0 & letter_knowledge_pr_6==0 & letter_knowledge_pr_7 == 0 & letter_knowledge_pr_8 == 0

replace letter_knowledge_prgridAutoStopp = 1 if letter_knowledge_pr_1==0 & letter_knowledge_pr_2==0 &letter_knowledge_pr_3==0 & letter_knowledge_pr_4==0 & letter_knowledge_pr_5==0 & letter_knowledge_pr_6==0 & letter_knowledge_pr_7 == 0 & letter_knowledge_pr_8 == 0

replace letter_knowledge_stop_pr = 1 if letter_knowledge_prgridAutoStopp == 1
replace letter_knowledge_stop_pr = 0 if letter_knowledge_prgridAutoStopp == 0

replace letter_knowledge_pr_Btime_remain = letter_knowledge_pr_Btime_remain - 62 if letter_knowledge_pr_Bnumber_of_i == 0 & letter_knowledge_pr_Bnum_att == 0

egen corrr1 = rowtotal(letter_knowledge_pr_B_1-letter_knowledge_pr_B_36)
replace letter_knowledge_pr_Bnumber_of_i = corrr1 if letter_knowledge_pr_Bnum_att == 0 & letter_knowledge_pr_Bnumber_of_i == 0 

replace letter_knowledge_pr_Bitems_per_m = round(60*(corrr1/(letter_knowledge_pr_Bduration-letter_knowledge_pr_Btime_remain))) if letter_knowledge_pr_Bnum_att == 0 & letter_knowledge_pr_Bnumber_of_i == 0 | !missing(letter_knowledge_pr_Btime_remain)

egen att1 = rownonmiss(letter_knowledge_pr_B_1-letter_knowledge_pr_B_36)
replace letter_knowledge_pr_Bnum_att = att1 if letter_knowledge_pr_Bnum_att == 0

drop att1 corrr1

*************************************************************************
**Dceoding- Reading Familiar words section
*************************************************************************
ren (v487 v511 v1230 v1254 v1589 v1613 v1968 v1992 interviewer_read_familiar_stop_f interviewer_read_familiar_stop_w interviewer_read_familiar_stop_s interviewer_read_familiar_stop_p) (reading_familiar_words_wfnum_att reading_famila_word_wf_Bnum_att reading_familiar_words_srnum_att reading_famila_word_sr_Bnum_att reading_familiar_words_frnum_att  reading_famila_word_fr_Bnum_att reading_familiar_words_prnum_att reading_famila_word_pr_Bnum_att read_familiar_stop_fr read_familiar_stop_wf read_familiar_stop_sr read_familiar_stop_pr)


*fr
order read_familiar_words_fr_* read_familiar_words_frduration read_familiar_words_frtime_remai read_familiar_words_frgridAutoSt read_familiar_words_frautoStop read_familiar_words_fritem_at_ti read_familiar_words_frtime_inter read_familiar_words_frnumber_of_ reading_familiar_words_frnum_att read_familiar_words_fritems_per_ read_familiar_stop_fr, after(letter_knowledge_pr_Bitems_per_m)

order read_familiar_words_fr_B_*  read_familiar_words_fr_Bduration read_familiar_words_fr_Btime_rem read_familiar_words_fr_BgridAuto read_familiar_words_fr_BautoStop read_familiar_words_fr_Bitem_at_ read_familiar_words_fr_Btime_int read_familiar_words_fr_Bnumber_o reading_famila_word_fr_Bnum_att  read_familiar_words_fr_Bitems_pe,after(read_familiar_stop_fr)

drop read_familiar_words_fr_BautoStop read_familiar_words_fr_Bitem_at_ read_familiar_words_fr_Btime_int read_familiar_words_frautoStop read_familiar_words_fritem_at_ti	read_familiar_words_frtime_inter

*wf
order  read_familiar_words_wf_* read_familiar_words_wfduration read_familiar_words_wftime_remai read_familiar_words_wfgridAutoSt read_familiar_words_wfautoStop read_familiar_words_wfitem_at_ti read_familiar_words_wftime_inter read_familiar_words_wfnumber_of_ reading_familiar_words_wfnum_att read_familiar_words_wfitems_per_ read_familiar_stop_wf, after(read_familiar_words_fr_Bitems_pe) 

order read_familiar_words_wf_B_*  read_familiar_words_wf_Bduration read_familiar_words_wf_Btime_rem read_familiar_words_wf_BgridAuto read_familiar_words_wf_BautoStop read_familiar_words_wf_Bitem_at_ read_familiar_words_wf_Btime_int read_familiar_words_wf_Bnumber_o reading_famila_word_wf_Bnum_att read_familiar_words_wf_Bitems_pe ,after(read_familiar_stop_wf)

drop read_familiar_words_wf_BautoStop read_familiar_words_wf_Bitem_at_ read_familiar_words_wf_Btime_int read_familiar_words_wfautoStop read_familiar_words_wfitem_at_ti	read_familiar_words_wftime_inter

*sr
order  read_familiar_words_sr_* read_familiar_words_srduration read_familiar_words_srtime_remai read_familiar_words_srgridAutoSt read_familiar_words_srautoStop read_familiar_words_sritem_at_ti read_familiar_words_srtime_inter read_familiar_words_srnumber_of_ reading_familiar_words_srnum_att read_familiar_words_sritems_per_ read_familiar_stop_sr, after(read_familiar_words_wf_Bitems_pe) 
 
order read_familiar_words_sr_B_*  read_familiar_words_sr_Bduration read_familiar_words_sr_Btime_rem read_familiar_words_sr_BgridAuto read_familiar_words_sr_BautoStop read_familiar_words_sr_Bitem_at_ read_familiar_words_sr_Btime_int read_familiar_words_sr_Bnumber_o reading_famila_word_sr_Bnum_att read_familiar_words_sr_Bitems_pe,after(read_familiar_stop_sr)

drop read_familiar_words_sr_BautoStop read_familiar_words_sr_Bitem_at_ read_familiar_words_sr_Btime_int read_familiar_words_srautoStop read_familiar_words_sritem_at_ti	read_familiar_words_srtime_inter

*pr
order  read_familiar_words_pr_* read_familiar_words_prduration read_familiar_words_prtime_remai read_familiar_words_prgridAutoSt read_familiar_words_prautoStop read_familiar_words_pritem_at_ti read_familiar_words_prtime_inter read_familiar_words_prnumber_of_ reading_familiar_words_prnum_att read_familiar_words_pritems_per_ read_familiar_stop_pr, after(read_familiar_words_sr_Bitems_pe) 

order read_familiar_words_pr_B_*  read_familiar_words_pr_Bduration read_familiar_words_pr_Btime_rem read_familiar_words_pr_BgridAuto read_familiar_words_pr_Bnumber_o reading_famila_word_pr_Bnum_att read_familiar_words_pr_Bitems_pe,after(read_familiar_stop_pr)

drop read_familiar_words_pr_BautoStop read_familiar_words_pr_Bitem_at_ read_familiar_words_pr_Btime_int read_familiar_words_prautoStop read_familiar_words_pritem_at_ti	read_familiar_words_prtime_inter

destring read_familiar_words_wf_* read_familiar_words_fr_* read_familiar_words_sr_* read_familiar_words_pr_* read_familiar_words_frduration	read_familiar_words_frtime_remai read_familiar_words_frnumber_of_ reading_familiar_words_frnum_att read_familiar_words_fritems_per_ read_familiar_stop_fr read_familiar_words_wfduration read_familiar_words_wftime_remai read_familiar_words_wfnumber_of_ reading_familiar_words_wfnum_att read_familiar_words_wfitems_per_ read_familiar_stop_wf reading_famila_word_wf_Bnum_att read_familiar_words_srduration	read_familiar_words_srtime_remai read_familiar_words_srnumber_of_ reading_familiar_words_srnum_att read_familiar_words_sritems_per_ read_familiar_stop_sr read_familiar_words_prduration	read_familiar_words_prtime_remai read_familiar_words_prnumber_of_ reading_familiar_words_prnum_att read_familiar_words_pritems_per_	read_familiar_stop_pr reading_famila_word_fr_Bnum_att,replace

lab values read_familiar_words_fr_1 - read_familiar_words_fr_20 read_familiar_words_fr_B_1 - read_familiar_words_fr_B_20 read_familiar_words_wf_1 - read_familiar_words_wf_20 read_familiar_words_wf_B_1 - read_familiar_words_wf_B_15 read_familiar_words_sr_1 - read_familiar_words_sr_20 read_familiar_words_sr_B_1 - read_familiar_words_sr_B_15 read_familiar_words_pr_1 - read_familiar_words_pr_20 read_familiar_words_pr_B_1 - read_familiar_words_pr_B_15 cor_inc

foreach x in read_familiar_words_frgridAutoSt read_familiar_words_wfgridAutoSt read_familiar_words_srgridAutoSt read_familiar_words_prgridAutoSt read_familiar_words_fr_BgridAuto read_familiar_words_wf_BgridAuto read_familiar_words_sr_BgridAuto read_familiar_words_pr_BgridAuto{
	replace `x' = "1" if `x' == "TRUE"
	replace `x' = "0" if `x' == "FALSE"
	destring `x',replace
}

lab values read_familiar_words_frgridAutoSt read_familiar_words_wfgridAutoSt read_familiar_words_srgridAutoSt read_familiar_words_prgridAutoSt read_familiar_words_fr_BgridAuto	read_familiar_words_wf_BgridAuto read_familiar_words_sr_BgridAuto read_familiar_words_pr_BgridAuto true_false

lab values read_familiar_stop_fr read_familiar_stop_wf read_familiar_stop_sr read_familiar_stop_pr yes_no

*Update
*fr
foreach x in read_familiar_words_fr_9	read_familiar_words_fr_10	read_familiar_words_fr_11	read_familiar_words_fr_12	read_familiar_words_fr_13	read_familiar_words_fr_14	read_familiar_words_fr_15	read_familiar_words_fr_16	read_familiar_words_fr_17	read_familiar_words_fr_18	read_familiar_words_fr_19	read_familiar_words_fr_20{
	replace `x'= . if read_familiar_words_fr_1==0 & read_familiar_words_fr_2==0 & read_familiar_words_fr_3==0 & read_familiar_words_fr_4==0 & read_familiar_words_fr_5==0 & read_familiar_words_fr_6==0 & read_familiar_words_fr_7 == 0 & read_familiar_words_fr_8 == 0 | interview_ID =="8531b91c-31d7-434a-bbf5-de01dd922f1f"
}

replace read_familiar_words_frnumber_of_ = 0 if read_familiar_words_fr_1==0 & read_familiar_words_fr_2==0 & read_familiar_words_fr_3==0 & read_familiar_words_fr_4==0 & read_familiar_words_fr_5==0 & read_familiar_words_fr_6==0 & read_familiar_words_fr_7 == 0 & read_familiar_words_fr_8 == 0 | interview_ID =="8531b91c-31d7-434a-bbf5-de01dd922f1f"

replace read_familiar_words_fritems_per_ = 0 if read_familiar_words_fr_1==0 & read_familiar_words_fr_2==0 & read_familiar_words_fr_3==0 & read_familiar_words_fr_4==0 & read_familiar_words_fr_5==0 & read_familiar_words_fr_6==0 & read_familiar_words_fr_7 == 0 & read_familiar_words_fr_8 == 0 | interview_ID =="8531b91c-31d7-434a-bbf5-de01dd922f1f"

replace reading_familiar_words_frnum_att = 8 if read_familiar_words_fr_1==0 & read_familiar_words_fr_2==0 & read_familiar_words_fr_3==0 & read_familiar_words_fr_4==0 & read_familiar_words_fr_5==0 & read_familiar_words_fr_6==0 & read_familiar_words_fr_7 == 0 & read_familiar_words_fr_8 == 0 |interview_ID =="8531b91c-31d7-434a-bbf5-de01dd922f1f"

replace read_familiar_words_frgridAutoSt = 1 if read_familiar_words_fr_1==0 & read_familiar_words_fr_2==0 & read_familiar_words_fr_3==0 & read_familiar_words_fr_4==0 & read_familiar_words_fr_5==0 & read_familiar_words_fr_6==0 & read_familiar_words_fr_7 == 0 & read_familiar_words_fr_8 == 0 | interview_ID =="8531b91c-31d7-434a-bbf5-de01dd922f1f"

replace read_familiar_stop_fr = 1 if read_familiar_words_frgridAutoSt == 1
replace read_familiar_stop_fr = 0 if read_familiar_words_frgridAutoSt == 0

replace read_familiar_words_fr_Btime_rem = read_familiar_words_fr_Bduration - 62 if read_familiar_words_fr_Bnumber_o == 0 & reading_famila_word_fr_Bnum_att == 0

egen corrr1 = rowtotal(read_familiar_words_fr_B_1 -read_familiar_words_fr_B_20)
replace read_familiar_words_fr_Bnumber_o = corrr1 if reading_famila_word_fr_Bnum_att == 0 & read_familiar_words_fr_Bnumber_o == 0 

replace read_familiar_words_fr_Bitems_pe = round(60*(corrr1/(read_familiar_words_fr_Bduration-read_familiar_words_fr_Btime_rem))) if reading_famila_word_fr_Bnum_att == 0 & read_familiar_words_fr_Bnumber_o == 0 | !missing(read_familiar_words_fr_Btime_rem)

egen att1 = rownonmiss(read_familiar_words_fr_B_1 -  read_familiar_words_fr_B_20)
replace reading_famila_word_fr_Bnum_att = att1 if reading_famila_word_fr_Bnum_att == 0

drop att1 corrr1

*wf
foreach x in read_familiar_words_wf_9	read_familiar_words_wf_10	read_familiar_words_wf_11	read_familiar_words_wf_12	read_familiar_words_wf_13	read_familiar_words_wf_14	read_familiar_words_wf_15	read_familiar_words_wf_16	read_familiar_words_wf_17	read_familiar_words_wf_18	read_familiar_words_wf_19	read_familiar_words_wf_20{
	replace `x'= . if read_familiar_words_wf_1==0 & read_familiar_words_wf_2==0 & read_familiar_words_wf_3==0 & read_familiar_words_wf_4==0 & read_familiar_words_wf_5==0 & read_familiar_words_wf_6==0 & read_familiar_words_wf_7 == 0 & read_familiar_words_wf_8 == 0
}

replace read_familiar_words_wfnumber_of_ = 0 if read_familiar_words_wf_1==0 & read_familiar_words_wf_2==0 & read_familiar_words_wf_3==0 & read_familiar_words_wf_4==0 & read_familiar_words_wf_5==0 & read_familiar_words_wf_6==0 & read_familiar_words_wf_7 == 0 & read_familiar_words_wf_8 == 0

replace read_familiar_words_wfitems_per_ = 0 if read_familiar_words_wf_1==0 & read_familiar_words_wf_2==0 & read_familiar_words_wf_3==0 & read_familiar_words_wf_4==0 & read_familiar_words_wf_5==0 & read_familiar_words_wf_6==0 & read_familiar_words_wf_7 == 0 & read_familiar_words_wf_8 == 0

replace reading_familiar_words_wfnum_att = 8 if read_familiar_words_wf_1==0 & read_familiar_words_wf_2==0 & read_familiar_words_wf_3==0 & read_familiar_words_wf_4==0 & read_familiar_words_wf_5==0 & read_familiar_words_wf_6==0 & read_familiar_words_wf_7 == 0 & read_familiar_words_wf_8 == 0

replace read_familiar_words_wfgridAutoSt = 1 if read_familiar_words_wf_1==0 & read_familiar_words_wf_2==0 & read_familiar_words_wf_3==0 & read_familiar_words_wf_4==0 & read_familiar_words_wf_5==0 & read_familiar_words_wf_6==0 & read_familiar_words_wf_7 == 0 & read_familiar_words_wf_8 == 0 

replace read_familiar_stop_wf = 1 if read_familiar_words_wfgridAutoSt == 1
replace read_familiar_stop_wf = 0 if read_familiar_words_wfgridAutoSt == 0

replace read_familiar_words_wf_Btime_rem = read_familiar_words_wf_Bduration - 62 if read_familiar_words_wf_Bnumber_o == 0 & reading_famila_word_wf_Bnum_att == 0

egen corrr1 = rowtotal(read_familiar_words_wf_B_1 -read_familiar_words_wf_B_15)
replace read_familiar_words_wf_Bnumber_o = corrr1 if reading_famila_word_wf_Bnum_att == 0 & read_familiar_words_wf_Bnumber_o == 0 

replace read_familiar_words_wf_Bitems_pe = round(60*(corrr1/(read_familiar_words_wf_Bduration-read_familiar_words_wf_Btime_rem))) if reading_famila_word_wf_Bnum_att == 0 & read_familiar_words_wf_Bnumber_o == 0 | !missing(read_familiar_words_wf_Btime_rem)

egen att1 = rownonmiss(read_familiar_words_wf_B_1-read_familiar_words_wf_B_15)
replace reading_famila_word_wf_Bnum_att = att1 if reading_famila_word_wf_Bnum_att == 0

drop att1 corrr1


*sr
foreach x in read_familiar_words_sr_9	read_familiar_words_sr_10	read_familiar_words_sr_11	read_familiar_words_sr_12	read_familiar_words_sr_13	read_familiar_words_sr_14	read_familiar_words_sr_15	read_familiar_words_sr_16	read_familiar_words_sr_17	read_familiar_words_sr_18	read_familiar_words_sr_19	read_familiar_words_sr_20{
	replace `x'= . if read_familiar_words_sr_1==0 & read_familiar_words_sr_2==0 & read_familiar_words_sr_3==0 & read_familiar_words_sr_4==0 & read_familiar_words_sr_5==0 & read_familiar_words_sr_6==0 & read_familiar_words_sr_7 == 0 & read_familiar_words_sr_8 == 0
}

replace read_familiar_words_srnumber_of_ = 0 if read_familiar_words_sr_1==0 & read_familiar_words_sr_2==0 & read_familiar_words_sr_3==0 & read_familiar_words_sr_4==0 & read_familiar_words_sr_5==0 & read_familiar_words_sr_6==0 & read_familiar_words_sr_7 == 0 & read_familiar_words_sr_8 == 0

replace read_familiar_words_sritems_per_ = 0 if read_familiar_words_sr_1==0 & read_familiar_words_sr_2==0 & read_familiar_words_sr_3==0 & read_familiar_words_sr_4==0 & read_familiar_words_sr_5==0 & read_familiar_words_sr_6==0 & read_familiar_words_sr_7 == 0 & read_familiar_words_sr_8 == 0

replace reading_familiar_words_srnum_att = 8 if read_familiar_words_sr_1==0 & read_familiar_words_sr_2==0 & read_familiar_words_sr_3==0 & read_familiar_words_sr_4==0 & read_familiar_words_sr_5==0 & read_familiar_words_sr_6==0 & read_familiar_words_sr_7 == 0 & read_familiar_words_sr_8 == 0

replace read_familiar_words_srgridAutoSt = 1 if read_familiar_words_sr_1==0 & read_familiar_words_sr_2==0 & read_familiar_words_sr_3==0 & read_familiar_words_sr_4==0 & read_familiar_words_sr_5==0 & read_familiar_words_sr_6==0 & read_familiar_words_sr_7 == 0 & read_familiar_words_sr_8 == 0 

replace read_familiar_stop_sr = 1 if read_familiar_words_srgridAutoSt == 1
replace read_familiar_stop_sr = 0 if read_familiar_words_srgridAutoSt == 0

destring reading_famila_word_sr_Bnum_att,replace

replace read_familiar_words_sr_Btime_rem = read_familiar_words_sr_Bduration - 62 if read_familiar_words_sr_Bnumber_o == 0 & reading_famila_word_sr_Bnum_att == 0

egen corrr1 = rowtotal(read_familiar_words_sr_B_1 -read_familiar_words_sr_B_15)
replace read_familiar_words_sr_Bnumber_o = corrr1 if reading_famila_word_sr_Bnum_att == 0 & read_familiar_words_sr_Bnumber_o == 0 

replace read_familiar_words_sr_Bitems_pe = round(60*(corrr1/(read_familiar_words_sr_Bduration-read_familiar_words_sr_Btime_rem))) if reading_famila_word_sr_Bnum_att == 0 & read_familiar_words_sr_Bnumber_o == 0 | !missing(read_familiar_words_sr_Btime_rem)

egen att1 = rownonmiss(read_familiar_words_sr_B_1-read_familiar_words_sr_B_15)
replace reading_famila_word_sr_Bnum_att = att1 if reading_famila_word_sr_Bnum_att == 0  

replace read_familiar_words_sr_Bitems_pe = 15 if interview_ID == "0603e745-4755-4735-ab8b-81a7133999a8"

drop att1 corrr1


*pr
foreach x in read_familiar_words_pr_9	read_familiar_words_pr_10	read_familiar_words_pr_11	read_familiar_words_pr_12	read_familiar_words_pr_13	read_familiar_words_pr_14	read_familiar_words_pr_15	read_familiar_words_pr_16	read_familiar_words_pr_17	read_familiar_words_pr_18	read_familiar_words_pr_19	read_familiar_words_pr_20{
	replace `x'= . if read_familiar_words_pr_1==0 & read_familiar_words_pr_2==0 & read_familiar_words_pr_3==0 & read_familiar_words_pr_4==0 & read_familiar_words_pr_5==0 & read_familiar_words_pr_6==0 & read_familiar_words_pr_7 == 0 & read_familiar_words_pr_8 == 0
}

replace read_familiar_words_prnumber_of_ = 0 if read_familiar_words_pr_1==0 & read_familiar_words_pr_2==0 & read_familiar_words_pr_3==0 & read_familiar_words_pr_4==0 & read_familiar_words_pr_5==0 & read_familiar_words_pr_6==0 & read_familiar_words_pr_7 == 0 & read_familiar_words_pr_8 == 0

replace read_familiar_words_pritems_per_ = 0 if read_familiar_words_pr_1==0 & read_familiar_words_pr_2==0 & read_familiar_words_pr_3==0 & read_familiar_words_pr_4==0 & read_familiar_words_pr_5==0 & read_familiar_words_pr_6==0 & read_familiar_words_pr_7 == 0 & read_familiar_words_pr_8 == 0

replace reading_familiar_words_prnum_att = 8 if read_familiar_words_pr_1==0 & read_familiar_words_pr_2==0 & read_familiar_words_pr_3==0 & read_familiar_words_pr_4==0 & read_familiar_words_pr_5==0 & read_familiar_words_pr_6==0 & read_familiar_words_pr_7 == 0 & read_familiar_words_pr_8 == 0

replace read_familiar_words_prgridAutoSt = 1 if read_familiar_words_pr_1==0 & read_familiar_words_pr_2==0 & read_familiar_words_pr_3==0 & read_familiar_words_pr_4==0 & read_familiar_words_pr_5==0 & read_familiar_words_pr_6==0 & read_familiar_words_pr_7 == 0 & read_familiar_words_pr_8 == 0 

replace read_familiar_stop_pr = 1 if read_familiar_words_prgridAutoSt == 1
replace read_familiar_stop_pr = 0 if read_familiar_words_prgridAutoSt == 0

destring reading_famila_word_pr_Bnum_att,replace

replace read_familiar_words_pr_Btime_rem = read_familiar_words_pr_Bduration - 62 if read_familiar_words_pr_Bnumber_o == 0 & reading_famila_word_pr_Bnum_att == 0

egen corrr1 = rowtotal(read_familiar_words_pr_B_1 -read_familiar_words_pr_B_15)
replace read_familiar_words_pr_Bnumber_o = corrr1 if reading_famila_word_pr_Bnum_att == 0 & read_familiar_words_pr_Bnumber_o == 0 

replace read_familiar_words_pr_Bitems_pe = round(60*(corrr1/(read_familiar_words_pr_Bduration-read_familiar_words_pr_Btime_rem))) if reading_famila_word_pr_Bnum_att == 0 & read_familiar_words_pr_Bnumber_o == 0 | !missing(read_familiar_words_pr_Btime_rem)

egen att1 = rownonmiss(read_familiar_words_pr_B_1-read_familiar_words_pr_B_15)
replace reading_famila_word_pr_Bnum_att = att1 if reading_famila_word_pr_Bnum_att == 0

drop att1 corrr1

*************************************************************************
**Dceoding- Reading Invented words section
*************************************************************************
********************

ren (v549 interviewer_read_invented_stop_w v588 v1284 interviewer_read_invented_stop_s v1323 v1643 interviewer_read_invented_stop_f v1682 v2022 interviewer_read_invented_stop_p v2061) (read_invented_words_wfnum_att read_invented_stop_wf read_invented_word_wf_Bnum_att read_invented_words_srnum_att read_invented_stop_sr read_invented_word_sr_Bnum_att read_invented_words_frnum_att read_invented_stop_fr  read_invented_word_fr_Bnum_att read_invented_words_prnum_att read_invented_stop_pr read_invented_word_pr_Bnum_att)

*fr
order read_invented_words_fr_*  read_invented_words_frduration read_invented_words_frtime_remai read_invented_words_frgridAutoSt read_invented_words_frautoStop read_invented_words_fritem_at_ti read_invented_words_frtime_inter read_invented_words_frnumber_of_ read_invented_words_frnum_att read_invented_words_fritems_per_ read_invented_stop_fr, after(read_familiar_words_pr_Bitems_pe)

order read_invented_words_fr_B_*  read_invented_words_fr_Bduration read_invented_words_fr_Btime_rem read_invented_words_fr_BgridAuto read_invented_words_fr_BautoStop read_invented_words_fr_Bitem_at_ read_invented_words_fr_Btime_int read_invented_words_fr_Bnumber_o read_invented_word_fr_Bnum_att read_invented_words_fr_Bitems_pe,after(read_invented_stop_fr)

drop read_invented_words_frautoStop read_invented_words_fritem_at_ti read_invented_words_frtime_inter read_invented_words_fr_BautoStop read_invented_words_fr_Bitem_at_ read_invented_words_fr_Btime_int

destring read_invented_words_fr_* read_invented_words_frduration read_invented_words_frtime_remai read_invented_words_frnumber_of_ read_invented_words_fritems_per_ read_invented_words_frnum_att read_invented_stop_fr read_invented_word_fr_Bnum_att,replace

*wf
order read_invented_words_wf_*  read_invented_words_wfduration read_invented_words_wftime_remai read_invented_words_wfgridAutoSt read_invented_words_wfautoStop read_invented_words_wfitem_at_ti read_invented_words_wftime_inter read_invented_words_wfnumber_of_ read_invented_words_wfnum_att read_invented_words_wfitems_per_ read_invented_stop_wf, after(read_invented_words_fr_Bitems_pe)

order read_invented_words_wf_B_*  read_invented_words_wf_Bduration read_invented_words_wf_Btime_rem read_invented_words_wf_BgridAuto read_invented_words_wf_BautoStop read_invented_words_wf_Bitem_at_ read_invented_words_wf_Btime_int read_invented_words_wf_Bnumber_o read_invented_word_wf_Bnum_att read_invented_words_wf_Bitems_pe,after(read_invented_stop_wf)

drop read_invented_words_wfautoStop read_invented_words_wfitem_at_ti read_invented_words_wftime_inter read_invented_words_wf_BautoStop read_invented_words_wf_Bitem_at_ read_invented_words_wf_Btime_int

destring read_invented_words_wf_* read_invented_words_wfduration read_invented_words_wftime_remai read_invented_words_wfnumber_of_ read_invented_words_wfitems_per_ read_invented_words_wfnum_att read_invented_stop_wf read_invented_word_wf_Bnum_att,replace

*sr
order read_invented_words_sr_*  read_invented_words_srduration read_invented_words_srtime_remai read_invented_words_srgridAutoSt read_invented_words_srautoStop read_invented_words_sritem_at_ti read_invented_words_srtime_inter read_invented_words_srnumber_of_ read_invented_words_srnum_att read_invented_words_sritems_per_ read_invented_stop_sr, after(read_invented_words_wf_Bitems_pe)

order read_invented_words_sr_B_*  read_invented_words_sr_Bduration read_invented_words_sr_Btime_rem read_invented_words_sr_BgridAuto read_invented_words_sr_BautoStop read_invented_words_sr_Bitem_at_ read_invented_words_sr_Btime_int read_invented_words_sr_Bnumber_o read_invented_word_sr_Bnum_att read_invented_words_sr_Bitems_pe,after(read_invented_stop_sr)

drop read_invented_words_srautoStop read_invented_words_sritem_at_ti read_invented_words_srtime_inter read_invented_words_sr_BautoStop read_invented_words_sr_Bitem_at_ read_invented_words_sr_Btime_int

destring read_invented_words_sr_* read_invented_words_srduration read_invented_words_srtime_remai read_invented_words_srnumber_of_ read_invented_words_sritems_per_ read_invented_words_srnum_att read_invented_stop_sr,replace

*pr
order read_invented_words_pr_*  read_invented_words_prduration read_invented_words_prtime_remai read_invented_words_prgridAutoSt read_invented_words_prautoStop read_invented_words_pritem_at_ti read_invented_words_prtime_inter read_invented_words_prnumber_of_ read_invented_words_prnum_att read_invented_words_pritems_per_ read_invented_stop_pr, after(read_invented_words_sr_Bitems_pe)

order read_invented_words_pr_B_*  read_invented_words_pr_Bduration read_invented_words_pr_Btime_rem read_invented_words_pr_BgridAuto read_invented_words_pr_BautoStop read_invented_words_pr_Bitem_at_ read_invented_words_pr_Btime_int read_invented_words_pr_Bnumber_o read_invented_word_pr_Bnum_att read_invented_words_pr_Bitems_pe,after(read_invented_words_pritems_per_)

drop read_invented_words_prautoStop read_invented_words_pritem_at_ti read_invented_words_prtime_inter read_invented_words_pr_BautoStop read_invented_words_pr_Bitem_at_ read_invented_words_pr_Btime_int

destring read_invented_words_pr_* read_invented_words_prduration read_invented_words_prtime_remai read_invented_words_prnumber_of_ read_invented_words_pritems_per_ read_invented_words_prnum_att read_invented_stop_pr read_invented_word_pr_Bnum_att,replace

lab values read_invented_words_fr_1 - read_invented_words_fr_20 read_invented_words_fr_B_1 - read_invented_words_fr_B_30 read_invented_words_wf_1 - read_invented_words_wf_20 read_invented_words_wf_B_1 - read_invented_words_wf_B_30 read_invented_words_sr_1 - read_invented_words_sr_20 read_invented_words_sr_B_1 - read_invented_words_sr_B_30 read_invented_words_pr_1 - read_invented_words_pr_20 read_invented_words_pr_B_1 - read_invented_words_pr_B_30  cor_inc

foreach x in read_invented_words_frgridAutoSt read_invented_words_wfgridAutoSt read_invented_words_srgridAutoSt read_invented_words_prgridAutoSt read_invented_words_fr_BgridAuto read_invented_words_wf_BgridAuto read_invented_words_pr_BgridAuto read_invented_words_sr_BgridAuto{
	replace `x' = "1" if `x' == "TRUE"
	replace `x' = "0" if `x' == "FALSE"
	destring `x',replace
}

lab values read_invented_words_frgridAutoSt read_invented_words_wfgridAutoSt read_invented_words_srgridAutoSt read_invented_words_prgridAutoSt read_invented_words_fr_BgridAuto read_invented_words_wf_BgridAuto read_invented_words_sr_BgridAuto read_invented_words_pr_BgridAuto true_false

lab values read_invented_stop_fr read_invented_stop_wf read_invented_stop_sr read_invented_stop_pr yes_no

*Update

*fr
foreach x in read_invented_words_fr_9	read_invented_words_fr_10	read_invented_words_fr_11	read_invented_words_fr_12	read_invented_words_fr_13	read_invented_words_fr_14	read_invented_words_fr_15	read_invented_words_fr_16	read_invented_words_fr_17	read_invented_words_fr_18	read_invented_words_fr_19	read_invented_words_fr_20{
	replace `x'= . if read_invented_words_fr_1==0 & read_invented_words_fr_2==0 & read_invented_words_fr_3==0 & read_invented_words_fr_4==0 & read_invented_words_fr_5==0 & read_invented_words_fr_6==0 & read_invented_words_fr_7 == 0 & read_invented_words_fr_8 == 0
}

replace read_invented_words_frnumber_of_ = 0 if read_invented_words_fr_1==0 & read_invented_words_fr_2==0 & read_invented_words_fr_3==0 & read_invented_words_fr_4==0 & read_invented_words_fr_5==0 & read_invented_words_fr_6==0 & read_invented_words_fr_7 == 0 & read_invented_words_fr_8 == 0

replace read_invented_words_fritems_per_ = 0 if read_invented_words_fr_1==0 & read_invented_words_fr_2==0 & read_invented_words_fr_3==0 & read_invented_words_fr_4==0 & read_invented_words_fr_5==0 & read_invented_words_fr_6==0 & read_invented_words_fr_7 == 0 & read_invented_words_fr_8 == 0

replace read_invented_words_frnum_att = 8 if read_invented_words_fr_1==0 & read_invented_words_fr_2==0 & read_invented_words_fr_3==0 & read_invented_words_fr_4==0 & read_invented_words_fr_5==0 & read_invented_words_fr_6==0 & read_invented_words_fr_7 == 0 & read_invented_words_fr_8 == 0

replace read_invented_words_frgridAutoSt = 1 if read_invented_words_fr_1==0 & read_invented_words_fr_2==0 & read_invented_words_fr_3==0 & read_invented_words_fr_4==0 & read_invented_words_fr_5==0 & read_invented_words_fr_6==0 & read_invented_words_fr_7 == 0 & read_invented_words_fr_8 == 0

replace read_invented_stop_fr = 1 if read_invented_words_frgridAutoSt == 1
replace read_invented_stop_fr = 0 if read_invented_words_frgridAutoSt == 0

destring read_invented_word_fr_Bnum_att,replace

replace read_invented_words_fr_Btime_rem = read_invented_words_fr_Bduration - 63 if read_invented_words_fr_Bnumber_o == 0 & read_invented_word_fr_Bnum_att == 0

egen corrr1 = rowtotal(read_invented_words_fr_B_1 -read_invented_words_fr_B_30)
replace read_invented_words_fr_Bnumber_o = corrr1 if read_invented_word_fr_Bnum_att == 0 & read_invented_words_fr_Bnumber_o == 0 

replace read_invented_words_fr_Bitems_pe = round(60*(corrr1/(read_invented_words_fr_Bduration-read_invented_words_fr_Btime_rem))) if read_invented_word_fr_Bnum_att == 0 & read_invented_words_fr_Bnumber_o == 0 | !missing(read_invented_words_fr_Btime_rem)

egen att1 = rownonmiss(read_invented_words_fr_B_1 -read_invented_words_fr_B_30)
replace read_invented_word_fr_Bnum_att = att1 if read_invented_word_fr_Bnum_att == 0

drop att1 corrr1

*wf
foreach x in read_invented_words_wf_9	read_invented_words_wf_10	read_invented_words_wf_11	read_invented_words_wf_12	read_invented_words_wf_13	read_invented_words_wf_14	read_invented_words_wf_15	read_invented_words_wf_16	read_invented_words_wf_17	read_invented_words_wf_18	read_invented_words_wf_19	read_invented_words_wf_20{
	replace `x'= . if read_invented_words_wf_1==0 & read_invented_words_wf_2==0 & read_invented_words_wf_3==0 & read_invented_words_wf_4==0 & read_invented_words_wf_5==0 & read_invented_words_wf_6==0 & read_invented_words_wf_7 == 0 & read_invented_words_wf_8 == 0
}

replace read_invented_words_wfnumber_of_ = 0 if read_invented_words_wf_1==0 & read_invented_words_wf_2==0 & read_invented_words_wf_3==0 & read_invented_words_wf_4==0 & read_invented_words_wf_5==0 & read_invented_words_wf_6==0 & read_invented_words_wf_7 == 0 & read_invented_words_wf_8 == 0

replace read_invented_words_wfitems_per_ = 0 if read_invented_words_wf_1==0 & read_invented_words_wf_2==0 & read_invented_words_wf_3==0 & read_invented_words_wf_4==0 & read_invented_words_wf_5==0 & read_invented_words_wf_6==0 & read_invented_words_wf_7 == 0 & read_invented_words_wf_8 == 0

replace read_invented_words_wfnum_att = 8 if read_invented_words_wf_1==0 & read_invented_words_wf_2==0 & read_invented_words_wf_3==0 & read_invented_words_wf_4==0 & read_invented_words_wf_5==0 & read_invented_words_wf_6==0 & read_invented_words_wf_7 == 0 & read_invented_words_wf_8 == 0

replace read_invented_words_wfgridAutoSt = 1 if read_invented_words_wf_1==0 & read_invented_words_wf_2==0 & read_invented_words_wf_3==0 & read_invented_words_wf_4==0 & read_invented_words_wf_5==0 & read_invented_words_wf_6==0 & read_invented_words_wf_7 == 0 & read_invented_words_wf_8 == 0

replace read_invented_stop_wf = 1 if read_invented_words_wfgridAutoSt == 1
replace read_invented_stop_wf = 0 if read_invented_words_wfgridAutoSt == 0

destring read_invented_word_wf_Bnum_att,replace

replace read_invented_words_wf_Btime_rem = read_invented_words_wf_Bduration - 63 if read_invented_words_wf_Bnumber_o == 0 & read_invented_word_wf_Bnum_att == 0

egen corrr1 = rowtotal(read_invented_words_wf_B_1 -read_invented_words_wf_B_30)
replace read_invented_words_wf_Bnumber_o = corrr1 if read_invented_word_wf_Bnum_att == 0 & read_invented_words_wf_Bnumber_o == 0

replace read_invented_words_wf_Bitems_pe = round(60*(corrr1/(read_invented_words_wf_Bduration-read_invented_words_wf_Btime_rem))) if read_invented_word_wf_Bnum_att == 0 & read_invented_words_wf_Bnumber_o == 0 | !missing(read_invented_words_wf_Btime_rem)

egen att1 = rownonmiss(read_invented_words_wf_B_1 -read_invented_words_wf_B_30)
replace read_invented_word_wf_Bnum_att = att1 if read_invented_word_wf_Bnum_att == 0

drop att1 corrr1

egen corrr1 = rowtotal(read_invented_words_wf_1 -read_invented_words_wf_20)
replace read_invented_words_wfnumber_of_ = corrr1 if inlist(interview_ID ,"c8ff5326-e9dd-4955-94ef-52e0164bd216","73c00981-7704-45c1-a0b1-c68f526a6c20")

replace read_invented_words_wfitems_per_ = round(60*(corrr1/(read_invented_words_wfduration-read_invented_words_wftime_remai))) if inlist(interview_ID ,"c8ff5326-e9dd-4955-94ef-52e0164bd216","73c00981-7704-45c1-a0b1-c68f526a6c20") 
drop corrr1

*sr
foreach x in read_invented_words_sr_9	read_invented_words_sr_10	read_invented_words_sr_11	read_invented_words_sr_12	read_invented_words_sr_13	read_invented_words_sr_14	read_invented_words_sr_15	read_invented_words_sr_16	read_invented_words_sr_17	read_invented_words_sr_18	read_invented_words_sr_19	read_invented_words_sr_20{
	replace `x'= . if read_invented_words_sr_1==0 & read_invented_words_sr_2==0 & read_invented_words_sr_3==0 & read_invented_words_sr_4==0 & read_invented_words_sr_5==0 & read_invented_words_sr_6==0 & read_invented_words_sr_7 == 0 & read_invented_words_sr_8 == 0
}

replace read_invented_words_srnumber_of_ = 0 if read_invented_words_sr_1==0 & read_invented_words_sr_2==0 & read_invented_words_sr_3==0 & read_invented_words_sr_4==0 & read_invented_words_sr_5==0 & read_invented_words_sr_6==0 & read_invented_words_sr_7 == 0 & read_invented_words_sr_8 == 0

replace read_invented_words_sritems_per_ = 0 if read_invented_words_sr_1==0 & read_invented_words_sr_2==0 & read_invented_words_sr_3==0 & read_invented_words_sr_4==0 & read_invented_words_sr_5==0 & read_invented_words_sr_6==0 & read_invented_words_sr_7 == 0 & read_invented_words_sr_8 == 0

replace read_invented_words_srnum_att = 8 if read_invented_words_sr_1==0 & read_invented_words_sr_2==0 & read_invented_words_sr_3==0 & read_invented_words_sr_4==0 & read_invented_words_sr_5==0 & read_invented_words_sr_6==0 & read_invented_words_sr_7 == 0 & read_invented_words_sr_8 == 0

replace read_invented_words_srgridAutoSt = 1 if read_invented_words_sr_1==0 & read_invented_words_sr_2==0 & read_invented_words_sr_3==0 & read_invented_words_sr_4==0 & read_invented_words_sr_5==0 & read_invented_words_sr_6==0 & read_invented_words_sr_7 == 0 & read_invented_words_sr_8 == 0

replace read_invented_stop_sr = 1 if read_invented_words_srgridAutoSt == 1
replace read_invented_stop_sr = 0 if read_invented_words_srgridAutoSt == 0

destring read_invented_word_sr_Bnum_att,replace

replace read_invented_words_sr_Btime_rem = read_invented_words_sr_Bduration - 63 if read_invented_words_sr_Bnumber_o == 0 & read_invented_word_sr_Bnum_att == 0

egen corrr1 = rowtotal(read_invented_words_sr_B_1 -read_invented_words_sr_B_30)
replace read_invented_words_sr_Bnumber_o = corrr1 if read_invented_word_sr_Bnum_att == 0 & read_invented_words_sr_Bnumber_o == 0 

replace read_invented_words_sr_Bitems_pe = round(60*(corrr1/(read_invented_words_sr_Bduration-read_invented_words_sr_Btime_rem))) if read_invented_word_sr_Bnum_att == 0 & read_invented_words_sr_Bnumber_o == 0 | !missing(read_invented_words_sr_Btime_rem)

egen att1 = rownonmiss(read_invented_words_sr_B_1 -read_invented_words_sr_B_30)
replace read_invented_word_sr_Bnum_att = att1 if read_invented_word_sr_Bnum_att == 0

drop att1 corrr1

*pr
foreach x in read_invented_words_pr_9	read_invented_words_pr_10	read_invented_words_pr_11	read_invented_words_pr_12	read_invented_words_pr_13	read_invented_words_pr_14	read_invented_words_pr_15	read_invented_words_pr_16	read_invented_words_pr_17	read_invented_words_pr_18	read_invented_words_pr_19	read_invented_words_pr_20{
	replace `x'= . if read_invented_words_pr_1==0 & read_invented_words_pr_2==0 & read_invented_words_pr_3==0 & read_invented_words_pr_4==0 & read_invented_words_pr_5==0 & read_invented_words_pr_6==0 & read_invented_words_pr_7 == 0 & read_invented_words_pr_8 == 0
}

replace read_invented_words_prnumber_of_ = 0 if read_invented_words_pr_1==0 & read_invented_words_pr_2==0 & read_invented_words_pr_3==0 & read_invented_words_pr_4==0 & read_invented_words_pr_5==0 & read_invented_words_pr_6==0 & read_invented_words_pr_7 == 0 & read_invented_words_pr_8 == 0

replace read_invented_words_pritems_per_ = 0 if read_invented_words_pr_1==0 & read_invented_words_pr_2==0 & read_invented_words_pr_3==0 & read_invented_words_pr_4==0 & read_invented_words_pr_5==0 & read_invented_words_pr_6==0 & read_invented_words_pr_7 == 0 & read_invented_words_pr_8 == 0

replace read_invented_words_prnum_att = 8 if read_invented_words_pr_1==0 & read_invented_words_pr_2==0 & read_invented_words_pr_3==0 & read_invented_words_pr_4==0 & read_invented_words_pr_5==0 & read_invented_words_pr_6==0 & read_invented_words_pr_7 == 0 & read_invented_words_pr_8 == 0

replace read_invented_words_prgridAutoSt = 1 if read_invented_words_pr_1==0 & read_invented_words_pr_2==0 & read_invented_words_pr_3==0 & read_invented_words_pr_4==0 & read_invented_words_pr_5==0 & read_invented_words_pr_6==0 & read_invented_words_pr_7 == 0 & read_invented_words_pr_8 == 0

replace read_invented_stop_pr = 1 if read_invented_words_prgridAutoSt == 1
replace read_invented_stop_pr = 0 if read_invented_words_prgridAutoSt == 0

destring read_invented_word_pr_Bnum_att,replace

replace read_invented_words_pr_Btime_rem = read_invented_words_pr_Bduration - 63 if read_invented_words_pr_Bnumber_o == 0 & read_invented_word_pr_Bnum_att == 0

egen corrr1 = rowtotal(read_invented_words_pr_B_1 -read_invented_words_pr_B_30)
replace read_invented_words_pr_Bnumber_o = corrr1 if read_invented_word_pr_Bnum_att == 0 & read_invented_words_pr_Bnumber_o == 0 

replace read_invented_words_pr_Bitems_pe = round(60*(corrr1/(read_invented_words_pr_Bduration-read_invented_words_pr_Btime_rem))) if read_invented_word_pr_Bnum_att == 0 & read_invented_words_pr_Bnumber_o == 0 | !missing(read_invented_words_pr_Btime_rem)

egen att1 = rownonmiss(read_invented_words_pr_B_1 -read_invented_words_pr_B_30)
replace read_invented_word_pr_Bnum_att = att1 if read_invented_word_pr_Bnum_att == 0

drop att1 corrr1

 
*************************************************************************
**Oral Reading Fluency section
*************************************************************************
ren (v651 v1376 v1735 v2119 interviewer_orf_stop_wf interviewer_orf_stop_fr interviewer_orf_stop_pr interviewer_orf_stop_sr) (oral_reading_fluency_wfnum_att oral_reading_fluency_srnum_att oral_reading_fluency_frnum_att oral_reading_fluency_prnum_att oral_reading_fluency_stop_wf oral_reading_fluency_stop_fr oral_reading_fluency_stop_pr oral_reading_fluency_stop_sr)

 
order oral_reading_fluency_fr_* oral_reading_fluency_frduration oral_reading_fluency_frtime_rema oral_reading_fluency_frgridAutoS oral_reading_fluency_frautoStop oral_reading_fluency_fritem_at_t oral_reading_fluency_frtime_inte oral_reading_fluency_frnumber_of oral_reading_fluency_frnum_att oral_reading_fluency_fritems_per oral_reading_fluency_stop_fr oral_reading_fluency_wf_* oral_reading_fluency_wfduration oral_reading_fluency_wftime_rema oral_reading_fluency_wfgridAutoS oral_reading_fluency_wfautoStop oral_reading_fluency_wfitem_at_t oral_reading_fluency_wftime_inte oral_reading_fluency_wfnumber_of oral_reading_fluency_wfnum_att oral_reading_fluency_wfitems_per oral_reading_fluency_stop_wf oral_reading_fluency_sr_* oral_reading_fluency_srduration oral_reading_fluency_srtime_rema oral_reading_fluency_srgridAutoS oral_reading_fluency_srautoStop oral_reading_fluency_sritem_at_t oral_reading_fluency_srtime_inte oral_reading_fluency_srnumber_of oral_reading_fluency_srnum_att oral_reading_fluency_sritems_per oral_reading_fluency_stop_sr oral_reading_fluency_pr_* oral_reading_fluency_prduration oral_reading_fluency_prtime_rema oral_reading_fluency_prgridAutoS oral_reading_fluency_prautoStop oral_reading_fluency_pritem_at_t oral_reading_fluency_prtime_inte oral_reading_fluency_prnumber_of oral_reading_fluency_prnum_att oral_reading_fluency_pritems_per oral_reading_fluency_stop_pr,after(read_invented_stop_pr)

drop oral_reading_fluency_fritem_at_t oral_reading_fluency_frtime_inte oral_reading_fluency_wfitem_at_t oral_reading_fluency_wftime_inte  oral_reading_fluency_sritem_at_t oral_reading_fluency_srtime_inte oral_reading_fluency_pritem_at_t oral_reading_fluency_prtime_inte


destring oral_reading_fluency_fr_* oral_reading_fluency_frduration oral_reading_fluency_frtime_rema oral_reading_fluency_frautoStop oral_reading_fluency_frnumber_of oral_reading_fluency_frnum_att oral_reading_fluency_fritems_per oral_reading_fluency_stop_fr oral_reading_fluency_wf_* oral_reading_fluency_wfduration oral_reading_fluency_wftime_rema oral_reading_fluency_wfautoStop oral_reading_fluency_wfnumber_of oral_reading_fluency_wfnum_att oral_reading_fluency_wfitems_per oral_reading_fluency_stop_wf oral_reading_fluency_sr_* oral_reading_fluency_srduration oral_reading_fluency_srtime_rema oral_reading_fluency_srautoStop oral_reading_fluency_srnumber_of oral_reading_fluency_srnum_att oral_reading_fluency_sritems_per oral_reading_fluency_stop_sr oral_reading_fluency_pr_* oral_reading_fluency_prduration oral_reading_fluency_prtime_rema oral_reading_fluency_prautoStop oral_reading_fluency_prnumber_of oral_reading_fluency_prnum_att oral_reading_fluency_pritems_per oral_reading_fluency_stop_pr,replace

lab values oral_reading_fluency_fr_1 - oral_reading_fluency_fr_43 oral_reading_fluency_wf_1 - oral_reading_fluency_wf_43  oral_reading_fluency_sr_1 - oral_reading_fluency_sr_43  oral_reading_fluency_pr_1 - oral_reading_fluency_pr_43 cor_inc

foreach x in oral_reading_fluency_frgridAutoS oral_reading_fluency_wfgridAutoS oral_reading_fluency_srgridAutoS oral_reading_fluency_prgridAutoS{
	replace `x' = "1" if `x' == "TRUE"
	replace `x' = "0" if `x' == "FALSE"
	destring `x',replace
}

lab values oral_reading_fluency_frgridAutoS oral_reading_fluency_wfgridAutoS oral_reading_fluency_srgridAutoS oral_reading_fluency_prgridAutoS true_false

*updated
*fr
foreach x in  oral_reading_fluency_fr_9 oral_reading_fluency_fr_10 oral_reading_fluency_fr_11 oral_reading_fluency_fr_12 oral_reading_fluency_fr_13 oral_reading_fluency_fr_14 oral_reading_fluency_fr_15 oral_reading_fluency_fr_16 oral_reading_fluency_fr_17 oral_reading_fluency_fr_18 oral_reading_fluency_fr_19 oral_reading_fluency_fr_20 oral_reading_fluency_fr_21 oral_reading_fluency_fr_22 oral_reading_fluency_fr_23 oral_reading_fluency_fr_24 oral_reading_fluency_fr_25 oral_reading_fluency_fr_26 oral_reading_fluency_fr_27 oral_reading_fluency_fr_28 oral_reading_fluency_fr_29 oral_reading_fluency_fr_30 oral_reading_fluency_fr_31 oral_reading_fluency_fr_32 oral_reading_fluency_fr_33 oral_reading_fluency_fr_34 oral_reading_fluency_fr_35 oral_reading_fluency_fr_36 oral_reading_fluency_fr_37 oral_reading_fluency_fr_38 oral_reading_fluency_fr_39 oral_reading_fluency_fr_40 oral_reading_fluency_fr_41 oral_reading_fluency_fr_42 oral_reading_fluency_fr_43{
	replace `x'= . if oral_reading_fluency_fr_1==0 & oral_reading_fluency_fr_2==0 & oral_reading_fluency_fr_3==0 & oral_reading_fluency_fr_4==0 & oral_reading_fluency_fr_5==0 & oral_reading_fluency_fr_6==0 & oral_reading_fluency_fr_7 == 0 & oral_reading_fluency_fr_8 == 0
}

replace oral_reading_fluency_frnumber_of = 0 if oral_reading_fluency_fr_1==0 & oral_reading_fluency_fr_2==0 & oral_reading_fluency_fr_3==0 & oral_reading_fluency_fr_4==0 & oral_reading_fluency_fr_5==0 & oral_reading_fluency_fr_6==0 & oral_reading_fluency_fr_7 == 0 & oral_reading_fluency_fr_8 == 0

replace oral_reading_fluency_fritems_per = 0 if oral_reading_fluency_fr_1==0 & oral_reading_fluency_fr_2==0 & oral_reading_fluency_fr_3==0 & oral_reading_fluency_fr_4==0 & oral_reading_fluency_fr_5==0 & oral_reading_fluency_fr_6==0 & oral_reading_fluency_fr_7 == 0 & oral_reading_fluency_fr_8 == 0

replace oral_reading_fluency_frnum_att = 8 if oral_reading_fluency_fr_1==0 & oral_reading_fluency_fr_2==0 & oral_reading_fluency_fr_3==0 & oral_reading_fluency_fr_4==0 & oral_reading_fluency_fr_5==0 & oral_reading_fluency_fr_6==0 & oral_reading_fluency_fr_7 == 0 & oral_reading_fluency_fr_8 == 0

replace oral_reading_fluency_frgridAutoS = 1 if oral_reading_fluency_fr_1==0 & oral_reading_fluency_fr_2==0 & oral_reading_fluency_fr_3==0 & oral_reading_fluency_fr_4==0 & oral_reading_fluency_fr_5==0 & oral_reading_fluency_fr_6==0 & oral_reading_fluency_fr_7 == 0 & oral_reading_fluency_fr_8 == 0

replace oral_reading_fluency_stop_fr = 1 if oral_reading_fluency_frgridAutoS == 1
replace oral_reading_fluency_stop_fr = 0 if oral_reading_fluency_frgridAutoS == 0

foreach x in oral_reading_fluency_fr_6	oral_reading_fluency_fr_7	oral_reading_fluency_fr_8	oral_reading_fluency_fr_9	oral_reading_fluency_fr_10	oral_reading_fluency_fr_11	oral_reading_fluency_fr_12{
	replace `x' = 1 if oral_reading_fluency_fr_6 == . & !missing(oral_reading_fluency_fr_5)
}
		
foreach x in oral_reading_fluency_fr_7	oral_reading_fluency_fr_8	oral_reading_fluency_fr_9	oral_reading_fluency_fr_10	oral_reading_fluency_fr_11	oral_reading_fluency_fr_12{
	replace `x' = 1 if oral_reading_fluency_fr_7 == . & !missing(oral_reading_fluency_fr_6)
}

foreach x in oral_reading_fluency_fr_8	oral_reading_fluency_fr_9	oral_reading_fluency_fr_10	oral_reading_fluency_fr_11	oral_reading_fluency_fr_12{
	replace `x' = 1 if oral_reading_fluency_fr_8 == . & !missing(oral_reading_fluency_fr_7)
}


foreach x in oral_reading_fluency_fr_9	oral_reading_fluency_fr_10	oral_reading_fluency_fr_11	oral_reading_fluency_fr_12{
	replace `x' = 1 if oral_reading_fluency_fr_9 == . & !missing(oral_reading_fluency_fr_8)
}

egen corrr = rowtotal(oral_reading_fluency_fr_1 - oral_reading_fluency_fr_43)

replace oral_reading_fluency_frnumber_of = corrr if !missing(oral_reading_fluency_frnumber_of)
replace oral_reading_fluency_fritems_per = corrr if !missing(oral_reading_fluency_fritems_per)

replace oral_reading_fluency_frtime_rema = 0 if oral_reading_fluency_frtime_rema<0

egen att = rownonmiss(oral_reading_fluency_fr_1-oral_reading_fluency_fr_43)

replace oral_reading_fluency_frnum_att = att if !missing(oral_reading_fluency_frnum_att)

drop att corrr

*wf
foreach x in  oral_reading_fluency_wf_9 oral_reading_fluency_wf_10 oral_reading_fluency_wf_11 oral_reading_fluency_wf_12 oral_reading_fluency_wf_13 oral_reading_fluency_wf_14 oral_reading_fluency_wf_15 oral_reading_fluency_wf_16 oral_reading_fluency_wf_17 oral_reading_fluency_wf_18 oral_reading_fluency_wf_19 oral_reading_fluency_wf_20 oral_reading_fluency_wf_21 oral_reading_fluency_wf_22 oral_reading_fluency_wf_23 oral_reading_fluency_wf_24 oral_reading_fluency_wf_25 oral_reading_fluency_wf_26 oral_reading_fluency_wf_27 oral_reading_fluency_wf_28 oral_reading_fluency_wf_29 oral_reading_fluency_wf_30 oral_reading_fluency_wf_31 oral_reading_fluency_wf_32 oral_reading_fluency_wf_33 oral_reading_fluency_wf_34 oral_reading_fluency_wf_35 oral_reading_fluency_wf_36 oral_reading_fluency_wf_37 oral_reading_fluency_wf_38 oral_reading_fluency_wf_39 oral_reading_fluency_wf_40 oral_reading_fluency_wf_41 oral_reading_fluency_wf_42 oral_reading_fluency_wf_43{
	replace `x'= . if oral_reading_fluency_wf_1==0 & oral_reading_fluency_wf_2==0 & oral_reading_fluency_wf_3==0 & oral_reading_fluency_wf_4==0 & oral_reading_fluency_wf_5==0 & oral_reading_fluency_wf_6==0 & oral_reading_fluency_wf_7 == 0 & oral_reading_fluency_wf_8 == 0
}

replace oral_reading_fluency_wfnumber_of = 0 if oral_reading_fluency_wf_1==0 & oral_reading_fluency_wf_2==0 & oral_reading_fluency_wf_3==0 & oral_reading_fluency_wf_4==0 & oral_reading_fluency_wf_5==0 & oral_reading_fluency_wf_6==0 & oral_reading_fluency_wf_7 == 0 & oral_reading_fluency_wf_8 == 0

replace oral_reading_fluency_wfitems_per = 0 if oral_reading_fluency_wf_1==0 & oral_reading_fluency_wf_2==0 & oral_reading_fluency_wf_3==0 & oral_reading_fluency_wf_4==0 & oral_reading_fluency_wf_5==0 & oral_reading_fluency_wf_6==0 & oral_reading_fluency_wf_7 == 0 & oral_reading_fluency_wf_8 == 0

replace oral_reading_fluency_wfnum_att = 8 if oral_reading_fluency_wf_1==0 & oral_reading_fluency_wf_2==0 & oral_reading_fluency_wf_3==0 & oral_reading_fluency_wf_4==0 & oral_reading_fluency_wf_5==0 & oral_reading_fluency_wf_6==0 & oral_reading_fluency_wf_7 == 0 & oral_reading_fluency_wf_8 == 0

replace oral_reading_fluency_wfgridAutoS = 1 if oral_reading_fluency_wf_1==0 & oral_reading_fluency_wf_2==0 & oral_reading_fluency_wf_3==0 & oral_reading_fluency_wf_4==0 & oral_reading_fluency_wf_5==0 & oral_reading_fluency_wf_6==0 & oral_reading_fluency_wf_7 == 0 & oral_reading_fluency_wf_8 == 0

replace oral_reading_fluency_stop_wf = 1 if oral_reading_fluency_wfgridAutoS == 1
replace oral_reading_fluency_stop_wf = 0 if oral_reading_fluency_wfgridAutoS == 0

foreach x in oral_reading_fluency_wf_6	oral_reading_fluency_wf_7	oral_reading_fluency_wf_8	oral_reading_fluency_wf_9	oral_reading_fluency_wf_10	oral_reading_fluency_wf_11	oral_reading_fluency_wf_12{
	replace `x' = 1 if oral_reading_fluency_wf_6 == . & !missing(oral_reading_fluency_wf_5)
}
		
foreach x in oral_reading_fluency_wf_7	oral_reading_fluency_wf_8	oral_reading_fluency_wf_9	oral_reading_fluency_wf_10	oral_reading_fluency_wf_11	oral_reading_fluency_wf_12{
	replace `x' = 1 if oral_reading_fluency_wf_7 == . & !missing(oral_reading_fluency_wf_6)
}

foreach x in oral_reading_fluency_wf_8	oral_reading_fluency_wf_9	oral_reading_fluency_wf_10	oral_reading_fluency_wf_11	oral_reading_fluency_wf_12{
	replace `x' = 1 if oral_reading_fluency_wf_8 == . & !missing(oral_reading_fluency_wf_7)
}


foreach x in oral_reading_fluency_wf_9	oral_reading_fluency_wf_10	oral_reading_fluency_wf_11	oral_reading_fluency_wf_12{
	replace `x' = 1 if oral_reading_fluency_wf_9 == . & !missing(oral_reading_fluency_wf_8)
}

egen corrr = rowtotal(oral_reading_fluency_wf_1 - oral_reading_fluency_wf_43)

replace oral_reading_fluency_wfnumber_of = corrr if !missing(oral_reading_fluency_wfnumber_of)
replace oral_reading_fluency_wfitems_per = corrr if !missing(oral_reading_fluency_wfitems_per)

replace oral_reading_fluency_wftime_rema = 0 if oral_reading_fluency_wftime_rema<0

egen att = rownonmiss(oral_reading_fluency_wf_1-oral_reading_fluency_wf_43)

replace oral_reading_fluency_wfnum_att = att if !missing(oral_reading_fluency_wfnum_att)

drop att corrr

*sr
foreach x in  oral_reading_fluency_sr_9 oral_reading_fluency_sr_10 oral_reading_fluency_sr_11 oral_reading_fluency_sr_12 oral_reading_fluency_sr_13 oral_reading_fluency_sr_14 oral_reading_fluency_sr_15 oral_reading_fluency_sr_16 oral_reading_fluency_sr_17 oral_reading_fluency_sr_18 oral_reading_fluency_sr_19 oral_reading_fluency_sr_20 oral_reading_fluency_sr_21 oral_reading_fluency_sr_22 oral_reading_fluency_sr_23 oral_reading_fluency_sr_24 oral_reading_fluency_sr_25 oral_reading_fluency_sr_26 oral_reading_fluency_sr_27 oral_reading_fluency_sr_28 oral_reading_fluency_sr_29 oral_reading_fluency_sr_30 oral_reading_fluency_sr_31 oral_reading_fluency_sr_32 oral_reading_fluency_sr_33 oral_reading_fluency_sr_34 oral_reading_fluency_sr_35 oral_reading_fluency_sr_36 oral_reading_fluency_sr_37 oral_reading_fluency_sr_38 oral_reading_fluency_sr_39 oral_reading_fluency_sr_40 oral_reading_fluency_sr_41 oral_reading_fluency_sr_42 oral_reading_fluency_sr_43{
	replace `x'= . if oral_reading_fluency_sr_1==0 & oral_reading_fluency_sr_2==0 & oral_reading_fluency_sr_3==0 & oral_reading_fluency_sr_4==0 & oral_reading_fluency_sr_5==0 & oral_reading_fluency_sr_6==0 & oral_reading_fluency_sr_7 == 0 & oral_reading_fluency_sr_8 == 0
}

replace oral_reading_fluency_srnumber_of = 0 if oral_reading_fluency_sr_1==0 & oral_reading_fluency_sr_2==0 & oral_reading_fluency_sr_3==0 & oral_reading_fluency_sr_4==0 & oral_reading_fluency_sr_5==0 & oral_reading_fluency_sr_6==0 & oral_reading_fluency_sr_7 == 0 & oral_reading_fluency_sr_8 == 0

replace oral_reading_fluency_sritems_per = 0 if oral_reading_fluency_sr_1==0 & oral_reading_fluency_sr_2==0 & oral_reading_fluency_sr_3==0 & oral_reading_fluency_sr_4==0 & oral_reading_fluency_sr_5==0 & oral_reading_fluency_sr_6==0 & oral_reading_fluency_sr_7 == 0 & oral_reading_fluency_sr_8 == 0

replace oral_reading_fluency_srnum_att = 8 if oral_reading_fluency_sr_1==0 & oral_reading_fluency_sr_2==0 & oral_reading_fluency_sr_3==0 & oral_reading_fluency_sr_4==0 & oral_reading_fluency_sr_5==0 & oral_reading_fluency_sr_6==0 & oral_reading_fluency_sr_7 == 0 & oral_reading_fluency_sr_8 == 0

replace oral_reading_fluency_srgridAutoS = 1 if oral_reading_fluency_sr_1==0 & oral_reading_fluency_sr_2==0 & oral_reading_fluency_sr_3==0 & oral_reading_fluency_sr_4==0 & oral_reading_fluency_sr_5==0 & oral_reading_fluency_sr_6==0 & oral_reading_fluency_sr_7 == 0 & oral_reading_fluency_sr_8 == 0

replace oral_reading_fluency_stop_sr = 1 if oral_reading_fluency_srgridAutoS == 1
replace oral_reading_fluency_stop_sr = 0 if oral_reading_fluency_srgridAutoS == 0

foreach x in oral_reading_fluency_sr_6	oral_reading_fluency_sr_7	oral_reading_fluency_sr_8	oral_reading_fluency_sr_9	oral_reading_fluency_sr_10	oral_reading_fluency_sr_11	oral_reading_fluency_sr_12{
	replace `x' = 1 if oral_reading_fluency_sr_6 == . & !missing(oral_reading_fluency_sr_5)
}
		
foreach x in oral_reading_fluency_sr_7	oral_reading_fluency_sr_8	oral_reading_fluency_sr_9	oral_reading_fluency_sr_10	oral_reading_fluency_sr_11	oral_reading_fluency_sr_12{
	replace `x' = 1 if oral_reading_fluency_sr_7 == . & !missing(oral_reading_fluency_sr_6)
}

foreach x in oral_reading_fluency_sr_8	oral_reading_fluency_sr_9	oral_reading_fluency_sr_10	oral_reading_fluency_sr_11	oral_reading_fluency_sr_12{
	replace `x' = 1 if oral_reading_fluency_sr_8 == . & !missing(oral_reading_fluency_sr_7)
}


foreach x in oral_reading_fluency_sr_9	oral_reading_fluency_sr_10	oral_reading_fluency_sr_11	oral_reading_fluency_sr_12{
	replace `x' = 1 if oral_reading_fluency_sr_9 == . & !missing(oral_reading_fluency_sr_8)
}

egen corrr = rowtotal(oral_reading_fluency_sr_1 - oral_reading_fluency_sr_43)

replace oral_reading_fluency_srnumber_of = corrr if !missing(oral_reading_fluency_srnumber_of)
replace oral_reading_fluency_sritems_per = corrr if !missing(oral_reading_fluency_sritems_per)

replace oral_reading_fluency_srtime_rema = 0 if oral_reading_fluency_srtime_rema<0

egen att = rownonmiss(oral_reading_fluency_sr_1-oral_reading_fluency_sr_43)

replace oral_reading_fluency_srnum_att = att if !missing(oral_reading_fluency_srnum_att)

drop att corrr

*pr
foreach x in  oral_reading_fluency_pr_9 oral_reading_fluency_pr_10 oral_reading_fluency_pr_11 oral_reading_fluency_pr_12 oral_reading_fluency_pr_13 oral_reading_fluency_pr_14 oral_reading_fluency_pr_15 oral_reading_fluency_pr_16 oral_reading_fluency_pr_17 oral_reading_fluency_pr_18 oral_reading_fluency_pr_19 oral_reading_fluency_pr_20 oral_reading_fluency_pr_21 oral_reading_fluency_pr_22 oral_reading_fluency_pr_23 oral_reading_fluency_pr_24 oral_reading_fluency_pr_25 oral_reading_fluency_pr_26 oral_reading_fluency_pr_27 oral_reading_fluency_pr_28 oral_reading_fluency_pr_29 oral_reading_fluency_pr_30 oral_reading_fluency_pr_31 oral_reading_fluency_pr_32 oral_reading_fluency_pr_33 oral_reading_fluency_pr_34 oral_reading_fluency_pr_35 oral_reading_fluency_pr_36 oral_reading_fluency_pr_37 oral_reading_fluency_pr_38 oral_reading_fluency_pr_39 oral_reading_fluency_pr_40 oral_reading_fluency_pr_41 oral_reading_fluency_pr_42 oral_reading_fluency_pr_43{
	replace `x'= . if oral_reading_fluency_pr_1==0 & oral_reading_fluency_pr_2==0 & oral_reading_fluency_pr_3==0 & oral_reading_fluency_pr_4==0 & oral_reading_fluency_pr_5==0 & oral_reading_fluency_pr_6==0 & oral_reading_fluency_pr_7 == 0 & oral_reading_fluency_pr_8 == 0
}

replace oral_reading_fluency_prnumber_of = 0 if oral_reading_fluency_pr_1==0 & oral_reading_fluency_pr_2==0 & oral_reading_fluency_pr_3==0 & oral_reading_fluency_pr_4==0 & oral_reading_fluency_pr_5==0 & oral_reading_fluency_pr_6==0 & oral_reading_fluency_pr_7 == 0 & oral_reading_fluency_pr_8 == 0

replace oral_reading_fluency_pritems_per = 0 if oral_reading_fluency_pr_1==0 & oral_reading_fluency_pr_2==0 & oral_reading_fluency_pr_3==0 & oral_reading_fluency_pr_4==0 & oral_reading_fluency_pr_5==0 & oral_reading_fluency_pr_6==0 & oral_reading_fluency_pr_7 == 0 & oral_reading_fluency_pr_8 == 0

replace oral_reading_fluency_prnum_att = 8 if oral_reading_fluency_pr_1==0 & oral_reading_fluency_pr_2==0 & oral_reading_fluency_pr_3==0 & oral_reading_fluency_pr_4==0 & oral_reading_fluency_pr_5==0 & oral_reading_fluency_pr_6==0 & oral_reading_fluency_pr_7 == 0 & oral_reading_fluency_pr_8 == 0

replace oral_reading_fluency_prgridAutoS = 1 if oral_reading_fluency_pr_1==0 & oral_reading_fluency_pr_2==0 & oral_reading_fluency_pr_3==0 & oral_reading_fluency_pr_4==0 & oral_reading_fluency_pr_5==0 & oral_reading_fluency_pr_6==0 & oral_reading_fluency_pr_7 == 0 & oral_reading_fluency_pr_8 == 0

replace oral_reading_fluency_stop_pr = 1 if oral_reading_fluency_prgridAutoS == 1
replace oral_reading_fluency_stop_pr = 0 if oral_reading_fluency_prgridAutoS == 0

foreach x in oral_reading_fluency_pr_6	oral_reading_fluency_pr_7	oral_reading_fluency_pr_8	oral_reading_fluency_pr_9	oral_reading_fluency_pr_10	oral_reading_fluency_pr_11	oral_reading_fluency_pr_12{
	replace `x' = 1 if oral_reading_fluency_pr_6 == . & !missing(oral_reading_fluency_pr_5)
}
		
foreach x in oral_reading_fluency_pr_7	oral_reading_fluency_pr_8	oral_reading_fluency_pr_9	oral_reading_fluency_pr_10	oral_reading_fluency_pr_11	oral_reading_fluency_pr_12{
	replace `x' = 1 if oral_reading_fluency_pr_7 == . & !missing(oral_reading_fluency_pr_6)
}

foreach x in oral_reading_fluency_pr_8	oral_reading_fluency_pr_9	oral_reading_fluency_pr_10	oral_reading_fluency_pr_11	oral_reading_fluency_pr_12{
	replace `x' = 1 if oral_reading_fluency_pr_8 == . & !missing(oral_reading_fluency_pr_7)
}


foreach x in oral_reading_fluency_pr_9	oral_reading_fluency_pr_10	oral_reading_fluency_pr_11	oral_reading_fluency_pr_12{
	replace `x' = 1 if oral_reading_fluency_pr_9 == . & !missing(oral_reading_fluency_pr_8)
}

egen corrr = rowtotal(oral_reading_fluency_pr_1 - oral_reading_fluency_pr_43)

replace oral_reading_fluency_prnumber_of = corrr if !missing(oral_reading_fluency_prnumber_of)
replace oral_reading_fluency_pritems_per = corrr if !missing(oral_reading_fluency_pritems_per)

replace oral_reading_fluency_prtime_rema = 0 if oral_reading_fluency_prtime_rema<0

egen att = rownonmiss(oral_reading_fluency_pr_1-oral_reading_fluency_pr_43)

replace oral_reading_fluency_prnum_att = att if !missing(oral_reading_fluency_prnum_att)

drop att corrr
*************************************************************************
**Reading Comprehension section
*************************************************************************
order reading_comprehension_fr_q1 reading_comprehension_fr_q2 reading_comprehension_fr_q3 reading_comprehension_fr_q4 reading_comprehension_fr_q5 reading_comprehension_fr_q6  reading_comprehension_wf_q1 reading_comprehension_wf_q2 reading_comprehension_wf_q3 reading_comprehension_wf_q4 reading_comprehension_wf_q5 reading_comprehension_wf_q6 reading_comprehension_sr_q1 reading_comprehension_sr_q2 reading_comprehension_sr_q3 reading_comprehension_sr_q4 reading_comprehension_sr_q5 reading_comprehension_sr_q6  reading_comprehension_pr_q1 reading_comprehension_pr_q2 reading_comprehension_pr_q3 reading_comprehension_pr_q4 reading_comprehension_pr_q5 reading_comprehension_pr_q6,after(oral_reading_fluency_stop_pr)

destring reading_comprehension_fr_q1 reading_comprehension_fr_q2 reading_comprehension_fr_q3 reading_comprehension_fr_q4 reading_comprehension_fr_q5 reading_comprehension_fr_q6  reading_comprehension_wf_q1 reading_comprehension_wf_q2 reading_comprehension_wf_q3 reading_comprehension_wf_q4 reading_comprehension_wf_q5 reading_comprehension_wf_q6 reading_comprehension_sr_q1 reading_comprehension_sr_q2 reading_comprehension_sr_q3 reading_comprehension_sr_q4 reading_comprehension_sr_q5 reading_comprehension_sr_q6  reading_comprehension_pr_q1 reading_comprehension_pr_q2 reading_comprehension_pr_q3 reading_comprehension_pr_q4 reading_comprehension_pr_q5 reading_comprehension_pr_q6,replace


lab define read_comp 1 "Correct" 2 "Incorrect" 99 "No response"
destring reading_comprehension_*,replace
lab values reading_comprehension_* read_comp

*************************************************************************
**Reading Comprehension Picture matching section
*************************************************************************

ren (v698  v703 v708 v713 v718 v723 v728 v733 v738 v743 v748 v1387 v1390 v1393 v1396 v1399 v1402 v1405 v1408 v1411 v1414 v1417 v1746 v1749 v1752 v1755 v1758 v1761 v1764 v1774 v1777 v1780 v1783 v2130 v2133 v2136 v2139 v2142 v2145 v2148 v2151 v2154 v2157 v2160 interviewer_rc_pm_stop_wf interviewer_rc_pm_stop_pr interviewer_rc_pm_stop_fr interviewer_rc_pm_stop_sr) (rc_picture_matching_example_wf rc_picture_matching_wf_q1 rc_picture_matching_wf_q2 rc_picture_matching_wf_q3 rc_picture_matching_wf_q4 rc_picture_matching_wf_q5 rc_picture_matching_wf_q6 rc_picture_matching_wf_q7 rc_picture_matching_wf_q8 rc_picture_matching_wf_q9 rc_picture_matching_wf_q10  rc_picture_matching_example_sr rc_picture_matching_sr_q1 rc_picture_matching_sr_q2 rc_picture_matching_sr_q3 rc_picture_matching_sr_q4 rc_picture_matching_sr_q5 rc_picture_matching_sr_q6 rc_picture_matching_sr_q7 rc_picture_matching_sr_q8 rc_picture_matching_sr_q9 rc_picture_matching_sr_q10 rc_picture_matching_example_fr rc_picture_matching_fr_q1 rc_picture_matching_fr_q2 rc_picture_matching_fr_q3 rc_picture_matching_fr_q4 rc_picture_matching_fr_q5 rc_picture_matching_fr_q6 rc_picture_matching_fr_q7 rc_picture_matching_fr_q8 rc_picture_matching_fr_q9 rc_picture_matching_fr_q10 rc_picture_matching_example_pr rc_picture_matching_pr_q1 rc_picture_matching_pr_q2 rc_picture_matching_pr_q3 rc_picture_matching_pr_q4 rc_picture_matching_pr_q5 rc_picture_matching_pr_q6 rc_picture_matching_pr_q7 rc_picture_matching_pr_q8 rc_picture_matching_pr_q9 rc_picture_matching_pr_q10 rc_pm_stop_wf rc_pm_stop_pr rc_pm_stop_fr rc_pm_stop_sr)

order rc_picture_matching_example_fr rc_picture_matching_fr_q* rc_pm_stop_fr rc_picture_matching_example_wf rc_picture_matching_wf_q* rc_pm_stop_wf rc_picture_matching_example_sr rc_picture_matching_sr_q* rc_pm_stop_sr rc_picture_matching_example_pr rc_picture_matching_pr_q* rc_pm_stop_pr,after(reading_comprehension_pr_q6)

destring rc_picture_matching_example_fr rc_picture_matching_fr_q* rc_pm_stop_fr rc_picture_matching_example_wf rc_picture_matching_wf_q* rc_pm_stop_wf rc_picture_matching_example_sr rc_picture_matching_sr_q* rc_pm_stop_sr rc_picture_matching_example_pr rc_picture_matching_pr_q* rc_pm_stop_pr,replace

* correct picture
* 1. Define the value label (only once)
label define childruns 3 "The child runs", replace
label define childplays 4 "The child plays", replace
label define sleeps 3 "He sleeps", replace
label define catdog 1 "Cat and dog", replace
label define plogh 1 "The farmer ploughs", replace
label define duck 2 "The duck swims", replace
label define mouse 2 "The mouse is in front of the box", replace
label define ppmus 1 "People make music", replace
label define egg 3 "A hen is sitting on her eggs", replace
label define tree 2 "In my village there are many hills. I like to play on the hill with a single tree. It is the best for climbing.", replace
label define skip 2 "A group of friends get together to play in the evenings after school. There are always more than two children playing. They sometimes sing songs, but they don't have any instruments. They also don't have a ball, so they mainly play hopscotch, skipping rope, or tag", replace

* 2. Apply the label to each variable
foreach x in rc_picture_matching_example_fr rc_picture_matching_example_wf rc_picture_matching_example_sr rc_picture_matching_example_pr {
    label values `x' childruns
}

foreach x in rc_picture_matching_fr_q1 rc_picture_matching_wf_q1 rc_picture_matching_sr_q1 rc_picture_matching_pr_q1 {
    label values `x' childplays
}

foreach x in rc_picture_matching_fr_q2 rc_picture_matching_wf_q2 rc_picture_matching_sr_q2 rc_picture_matching_pr_q2 {
    label values `x' sleeps
}

foreach x in rc_picture_matching_fr_q3 rc_picture_matching_wf_q3 rc_picture_matching_sr_q3 rc_picture_matching_pr_q3 {
    label values `x' catdog
}

foreach x in rc_picture_matching_fr_q4 rc_picture_matching_wf_q4 rc_picture_matching_sr_q4 rc_picture_matching_pr_q4 {
    label values `x' plogh
}

foreach x in rc_picture_matching_fr_q5 rc_picture_matching_wf_q5 rc_picture_matching_sr_q5 rc_picture_matching_pr_q5 {
    label values `x' duck
}

foreach x in rc_picture_matching_fr_q6 rc_picture_matching_wf_q6 rc_picture_matching_sr_q6 rc_picture_matching_pr_q6 {
    label values `x' mouse
}

foreach x in rc_picture_matching_fr_q7 rc_picture_matching_wf_q7 rc_picture_matching_sr_q7 rc_picture_matching_pr_q7 {
    label values `x' ppmus
}

foreach x in rc_picture_matching_fr_q8 rc_picture_matching_wf_q8 rc_picture_matching_sr_q8 rc_picture_matching_pr_q8 {
    label values `x' egg
}

foreach x in rc_picture_matching_fr_q9 rc_picture_matching_wf_q9 rc_picture_matching_sr_q9 rc_picture_matching_pr_q9 {
    label values `x' tree
}

foreach x in rc_picture_matching_fr_q10 rc_picture_matching_wf_q10 rc_picture_matching_sr_q10 rc_picture_matching_pr_q10 {
    label values `x' skip
}

lab values rc_pm_stop_fr rc_pm_stop_wf rc_pm_stop_pr rc_pm_stop_sr yes_no

replace rc_pm_stop_fr = 1 if rc_picture_matching_fr_q6 == . & !missing(rc_picture_matching_fr_q5)
replace rc_pm_stop_fr = 0 if !missing(rc_picture_matching_fr_q6)

replace rc_pm_stop_wf = 1 if rc_picture_matching_wf_q6 == . & !missing(rc_picture_matching_wf_q5)
replace rc_pm_stop_wf = 0 if !missing(rc_picture_matching_wf_q6)

replace rc_pm_stop_sr = 1 if rc_picture_matching_sr_q6 == . & !missing(rc_picture_matching_sr_q5)
replace rc_pm_stop_sr = 0 if !missing(rc_picture_matching_sr_q6)

replace rc_pm_stop_pr = 1 if rc_picture_matching_pr_q6 == . & !missing(rc_picture_matching_pr_q5)
replace rc_pm_stop_pr = 0 if !missing(rc_picture_matching_pr_q6)

*************************************************************************
**Math form section
*************************************************************************
*math_language_record
destring math_language_record,replace
lab values math_language_record lan

*shapes
destring shapes_number_1 number_shapes_correct_1 shapes_number_2  number_shapes_correct_2 shapes_number_3 number_shapes_correct_3,replace

order identifying_shapes_response_lang shapes_number_1 number_shapes_correct_1 shapes_number_2  number_shapes_correct_2 shapes_number_3 number_shapes_correct_3,after(math_language_record)

*identifying_shapes_response_lang
destring identifying_shapes_response_lang,replace

lab values identifying_shapes_response_lang lan

*position_tracking
order position_tracking_response_langu,before(position_tracking_1)
destring position_tracking_1 - position_tracking_6 position_tracking_response_langu,replace

lab values position_tracking_response_langu lan
recode position_tracking_1 - position_tracking_6 (2=0)

lab values position_tracking_1 - position_tracking_6 cor_inc

* identifying_numbers 
order identifying_numbers_response_lan,after(position_tracking_6)

foreach x in identifying_numbers_grid_2gridAu identifying_numbers_grid_1gridAu identifying_numbers_grid_3gridAu{
	replace `x' = "1" if `x' == "TRUE"
	replace `x' = "0" if `x' == "FALSE"
	destring `x',replace
}

destring identifying_numbers_response_lan - v839 identifying_numbers_correct_1 - v854 identifying_numbers_correct_2 identifying_numbers_grid_2gridAu identifying_numbers_grid_1gridAu identifying_numbers_grid_3_1 - v865 identifying_numbers_grid_3autoSt,replace

lab values identifying_numbers_grid_2gridAu identifying_numbers_grid_1gridAu identifying_numbers_grid_3gridAu true_false
lab values identifying_numbers_response_lan lan
lab values identifying_numbers_grid_1_1 - identifying_numbers_grid_1_8  identifying_numbers_grid_2_1 - identifying_numbers_grid_2_8 identifying_numbers_grid_3_1 - identifying_numbers_grid_3_4 cor_inc

drop identifying_numbers_grid_1autoSt identifying_numbers_grid_2autoSt v839 v854 v865 identifying_numbers_grid_3autoSt

order  identifying_numbers_grid_3_1 -  identifying_numbers_grid_3gridAu,after(identifying_numbers_correct_2)

ren identifying_numbers_grid_3number identify_numbers_grid_3num_corr
ren identifying_numbers_grid_2number identify_numbers_grid_2num_corr
ren identifying_numbers_grid_1number identify_numbers_grid_1num_corr

drop identifying_numbers_correct_1 identifying_numbers_correct_2 identifying_numbers_grid_3gridAu identifying_numbers_grid_2gridAu identifying_numbers_grid_1gridAu

*counting
order counting_language,before(counting_1)

destring counting_language counting_1 - counting_6,replace
lab values counting_language lan

recode counting_1 - counting_6 (2=0)
lab values counting_1 - counting_6 cor_inc

*digital_discrimination
order digital_discrimination_language,before(digital_discrimination_grid_1_1)
destring digital_discrimination_*,replace

lab values digital_discrimination_grid_1_1 - digital_discrimination_grid_1_4 digital_discrimination_grid_2_1 - digital_discrimination_grid_2_4 digital_discrimination_grid_3_1 - digital_discrimination_grid_3_2 cor_inc
lab values digital_discrimination_language lan

foreach x in digital_discrimination_grid_3gri digital_discrimination_grid_2gri digital_discrimination_grid_1gri{
	replace `x' = "1" if `x' == "TRUE"
	replace `x' = "0" if `x' == "FALSE"
	destring `x',replace
}

lab values digital_discrimination_grid_3gri digital_discrimination_grid_2gri digital_discrimination_grid_1gri true_false
ren digital_discrimination_grid_1num digital_discrimination_1num_corr
ren digital_discrimination_grid_2num digital_discrimination_2num_corr
ren digital_discrimination_grid_3num digital_discrimination_3num_corr

drop v903 v914 v923 digital_discrimination_grid_1aut digital_discrimination_grid_2aut digital_discrimination_grid_3aut digital_discrimination_grid_1gri	digital_discrimination_correct_1 digital_discrimination_grid_2gri	digital_discrimination_correct_2 digital_discrimination_grid_3gri

*Missing
order missing_response_language,before(missing_number_grid_1_1)
destring missing_number_grid_* missing_response_language missing_number_correct_grid_1,replace
lab values missing_number_grid_1_1 - missing_number_grid_1_4 missing_number_grid_2_1 - missing_number_grid_2_4 cor_inc
lab values missing_response_language lan

drop v938 v949 missing_number_grid_1autoStop missing_number_grid_2autoStop


foreach x in missing_number_grid_1gridAutoSto missing_number_grid_2gridAutoSto{
	replace `x' = "1" if `x' == "TRUE"
	replace `x' = "0" if `x' == "FALSE"
	destring `x',replace
}
lab values missing_number_grid_1gridAutoSto missing_number_grid_2gridAutoSto true_false

ren missing_number_grid_1number_of_i missing_number_1num_corr
ren missing_number_grid_2number_of_i missing_number_2num_corr

drop missing_number_grid_1gridAutoSto missing_number_correct_grid_1 missing_number_grid_2gridAutoSto

*Decimal
drop decimal_system_grid_1autoStop decimal_system_grid_2autoStop decimal_system_grid_3autoStop v964 v975 v984

ren decimal_system_grid_3number_of_i decimal_system_3num_corr
ren decimal_system_grid_2number_of_i decimal_system_2num_corr
ren decimal_system_grid_1number_of_i decimal_system_1num_corr

destring decimal_correct_* decimal_system_* decimal_response_language,replace

order decimal_response_language,before(decimal_system_grid_1_1)
lab values decimal_response_language lan

foreach x in decimal_system_grid_2gridAutoSto  decimal_system_grid_1gridAutoSto decimal_system_grid_3gridAutoSto{
	replace `x' = "1" if `x' == "TRUE"
	replace `x' = "0" if `x' == "FALSE"
	destring `x',replace
}
lab values decimal_system_grid_2gridAutoSto  decimal_system_grid_1gridAutoSto decimal_system_grid_3gridAutoSto true_false

lab values decimal_system_grid_1_1 - decimal_system_grid_1_4 decimal_system_grid_2_1 - decimal_system_grid_2_4 decimal_system_grid_3_1 decimal_system_grid_3_2 cor_inc

drop decimal_system_grid_1gridAutoSto	decimal_correct_1 decimal_system_grid_2gridAutoSto	decimal_correct_2 decimal_system_grid_3gridAutoSto

*Addion and subtraction
order addition_subtraction_response_la,before(addition_subtraction_1)

destring addition_subtraction_response_la addition_subtraction*,replace

lab define add_sub 1"Correct" 2"Partially correct" 3"Incorrect"

lab values addition_subtraction_response_la lan
lab values addition_subtraction_1 - addition_subtraction_5 add_sub

*Addition  and Subtraction strategy Grid
gen addition_subtraction_strategy = .
lab var addition_subtraction_strategy"Note the strategy the student used to solve the addition and subtraction questions"
order addition_subtraction_strategy,before(addition_subtraction_strategy_1)

lab values addition_subtraction_strategy_1 - addition_subtraction_strategy_99 yes_no

*word_addition_subtraction
order word_addition_subtraction_respon,before(word_addition_subtraction_1)

destring word_addition_subtraction_respon word_addition_subtraction_*,replace

lab values word_addition_subtraction_respon lan
lab values word_addition_subtraction_1 - word_addition_subtraction_5 add_sub

*word add sub strategy
ren (word_addition_subtraction_strate v1035 v1036 v1037) (word_add_sub_strategy_1 word_add_sub_strategy_2 word_add_sub_strategy_3 word_add_sub_strategy_99 )

destring word_add_sub_strategy_*,replace
lab values word_add_sub_strategy_1 - word_add_sub_strategy_99 yes_no

*translator
ren translator translators
destring translators,replace
lab values translators yes_no
lab var translators"Was the translator used?"
order translators INT_ENDTIME,after(word_add_sub_strategy_99)

destring reading_famila_word_sr_Bnum_att read_invented_word_sr_Bnum_att reading_famila_word_pr_Bnum_att GPSlatitude GPSlongitude GPSaccuracy,replace

// ds, has(type string)
// destring `r(varlist)', replace

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

lab define int_sem 1"Very confident" 2 "Somewhat confident" 3"Not confident"

destring interviewer_semantic_1 interviewer_semantic_2 interviewer_semantic_3 interviewer_semantic_4 semantic_language_timer1time_rem semantic_language_timer2time_rem semantic_language_timer3time_rem semantic_language_timer4time_rem,replace

lab values interviewer_semantic_1 interviewer_semantic_2 interviewer_semantic_3 interviewer_semantic_4 int_sem

*correction
foreach x in semantic_language_timer1time_rem semantic_language_timer2time_rem semantic_language_timer3time_rem semantic_language_timer4time_rem{
	replace `x' = 0  if !missing(`x') & (`x' > 0 | `x' < 0)
}

replace INT_DATE=  td(08dec2025) if interview_ID == "7c7ce476-52ae-46d1-b214-b24d120eac32"

*Corrections.
*Client Query 1.
replace survey_language = 1 if B4 == 3 & survey_language != 1
replace survey_language = official_language if B4 == 1 & survey_language == 1

*Query 2.
replace teaching_language =1 if interview_ID =="d03e46ec-dd62-4a81-b2c3-7594ec03ff79"
replace teaching_language =3 if interview_ID =="6deb405f-a52e-4547-8927-1d9789a58eba"
replace teaching_language =1 if interview_ID =="6bfd7f9f-8346-4772-b4e4-85b95389bea6"
replace teaching_language =1 if interview_ID =="0a0bac0b-7fee-4684-bd91-88a4b9034726"
replace teaching_language =3 if interview_ID =="f33fd61f-2d41-4ebc-a7e5-d48c2bc8643d"
replace teaching_language =3 if interview_ID =="e9acb732-0e86-4c23-a4ab-b1fd28bb32b4"
replace teaching_language =3 if interview_ID =="acfd0e15-e404-4719-a042-b32fb68e29b1"
replace teaching_language =3 if interview_ID =="47e9f5fc-92a6-4c4f-bbb3-3e16af493fd5"
replace teaching_language =3 if interview_ID =="3506df89-9581-4a5b-ac89-fb274d49d350"
replace teaching_language =3 if interview_ID =="d6b9c0c5-667b-4f6b-9f41-301b44cdada0"
replace teaching_language =3 if interview_ID =="eb556751-a143-44ca-a4fa-bc9a93833f69"
replace teaching_language =3 if interview_ID =="ceb56aff-c84a-48f1-8fb5-28aa6a4a7408"
replace teaching_language =3 if interview_ID =="b4318f26-486e-4833-bc9b-e6e03a6387f6"
replace teaching_language =3 if interview_ID =="45451da8-6aea-4ccd-a668-fcf6fcca1084"
replace teaching_language =3 if interview_ID =="9e4ed0cc-3d30-4f77-814d-a4c56e292587"
replace teaching_language =3 if interview_ID =="e5ea7c5d-ae9e-408a-b6a3-190a650e4bb4"
replace teaching_language =3 if interview_ID =="91fd21c5-3d48-456a-b33e-9ccc1199647b"
replace teaching_language =3 if interview_ID =="a45cd6b0-302a-47c6-8ac0-24f9949d65b4"
replace teaching_language =3 if interview_ID =="987c1aba-d5ae-4fc1-b977-11d61c1accc2"
replace teaching_language =3 if interview_ID =="d171cc2c-40d1-462e-8531-23811ab76b1d"
replace teaching_language =3 if interview_ID =="827ab6a2-6ab0-44b8-8926-42b61b393e58"
replace teaching_language =3 if interview_ID =="ae264f26-2482-435a-ab2b-7f496a34d19c"
replace teaching_language =3 if interview_ID =="fac45cb0-0101-475c-a7a8-432678d7643d"
replace teaching_language =3 if interview_ID =="dbe08ef8-79d1-4966-b423-c8df4ea4acbf"
replace teaching_language =3 if interview_ID =="e23bc4d0-8eaf-4b1f-910a-98c0b0386594"
replace teaching_language =3 if interview_ID =="c7aeb8c7-81c8-4f3f-8584-421e61eb4dc3"
replace teaching_language =3 if interview_ID =="3a64ac6c-1dd1-490e-a6f5-d6509f56bcad"
replace teaching_language =3 if interview_ID =="021c7c83-722d-4818-a494-ab5274360532"
replace teaching_language =3 if interview_ID =="ed131b98-c787-4c82-882c-1d2796ab369a"
replace teaching_language =3 if interview_ID =="a69faeaf-9aa1-4e50-a309-13c75bcb7da1"
replace teaching_language =3 if interview_ID =="58e215ac-afef-42d9-8cb7-7e6bdefb9d62"
replace teaching_language =3 if interview_ID =="3dba3444-f931-4192-a026-0592fed5c4db"
replace teaching_language =3 if interview_ID =="28d6e665-18e3-496c-84bd-57f5ae998d08"
replace teaching_language =1 if interview_ID =="f9a21cb3-0622-4552-a3ca-975394b9ca03"
replace teaching_language =1 if interview_ID =="57e40005-7add-4dd2-bb9d-5759c2981aa1"
replace teaching_language =1 if interview_ID =="ffa369ac-4283-4a90-98fc-8846a6c6fb4e"
replace teaching_language =3 if interview_ID =="1c99fea7-31d3-4fbe-9949-e030e0c2fe22"
replace teaching_language =3 if interview_ID =="ac518c97-0e79-4799-89cb-51f1acc52413"
replace teaching_language =3 if interview_ID =="f9c51d62-9d83-492a-90d2-a376ba12b8a6"
replace teaching_language =1 if interview_ID =="48422b8d-42ad-4294-95f3-7bb2d2701d36"
replace teaching_language =3 if interview_ID =="b27b2164-9414-41ed-ad4c-6ad383f86e44"
replace teaching_language =1 if interview_ID =="24e563f4-7d09-4d17-8169-d8814d697ffb"
replace teaching_language =1 if interview_ID =="d988403c-a0a2-44eb-86f0-2de65ce7db54"
replace teaching_language =1 if interview_ID =="e331d060-57d1-41a4-8848-e2f62d57ae65"
replace teaching_language =1 if interview_ID =="56bb62c2-a467-4786-8eef-bfe55ba3ba9b"
replace teaching_language =3 if interview_ID =="196aa4be-9aac-4248-b02e-de881f76db71"
replace teaching_language =3 if interview_ID =="371e0e95-b6f3-4517-9852-942506c8e086"
replace teaching_language =3 if interview_ID =="952690be-cd52-4bc5-ad46-62bf83c09b3a"
replace teaching_language =1 if interview_ID =="54045343-38e8-4bc7-aa0c-b56350f62bfc"
replace teaching_language =3 if interview_ID =="20d2bb4a-d1ab-46e9-bf57-70c07c123719"
replace teaching_language =3 if interview_ID =="6860cd27-31b9-4c21-a54c-0d0fd8f8209d"
replace teaching_language =1 if interview_ID =="3c155564-2174-4b0f-8542-ce0c061257eb"
replace teaching_language =1 if interview_ID =="189318b4-6126-40eb-bbcd-da310507f175"
replace teaching_language =3 if interview_ID =="fa7c730e-4e47-4e56-9adf-331a3dbce907"
replace teaching_language =3 if interview_ID =="b4918c03-457a-44b9-a048-aa68b8846e21"
replace teaching_language =3 if interview_ID =="c2bfffc5-9f55-416f-a8b4-01fe9b77ba4c"
replace teaching_language =3 if interview_ID =="c13e00e0-9036-46a4-be98-80d9df50bdd1"
replace teaching_language =1 if interview_ID =="764eaee0-b5be-4432-874b-69b1261cc181"
replace teaching_language =1 if interview_ID =="0603e745-4755-4735-ab8b-81a7133999a8"
replace teaching_language =1 if interview_ID =="2166db2f-c8b8-4a12-898e-8296e1b10890"
replace teaching_language =1 if interview_ID =="c905025e-4182-40be-831f-b476507dfa77"
replace teaching_language =1 if interview_ID =="9bbde13b-062c-4f07-8cc5-7561b17a480d"
replace teaching_language =3 if interview_ID =="85bc6364-0680-4751-86cd-ee3fda033816"
replace teaching_language =1 if interview_ID =="840d9ee5-ca5a-43f6-a855-9257880755da"
replace teaching_language =1 if interview_ID =="a86a2cd3-f0b6-4a89-91e5-25c1db9a269d"
replace teaching_language =3 if interview_ID =="90e20319-9fc1-4c08-a9b9-3f851839aded"
replace teaching_language =1 if interview_ID =="be0cd69b-653b-4da4-bfc5-a1d41d6d12e2"
replace teaching_language =3 if interview_ID =="24b7ec03-358c-4ac7-af7f-32137d492cb2"
replace teaching_language =3 if interview_ID =="03da1bc6-09f3-40b8-bef9-2cbc0d0cca5d"
replace teaching_language =3 if interview_ID =="17011753-34e8-4c53-853a-d2cb0f2f83f3"
replace teaching_language =3 if interview_ID =="1d852e1b-7029-450f-937e-09975a21638b"
replace teaching_language =3 if interview_ID =="16a2a2e2-7692-4df3-a6e0-0b4183b70642"
replace teaching_language =3 if interview_ID =="9fedd8b1-26d4-4f91-bbc0-dfa887f6c186"
replace teaching_language =3 if interview_ID =="3f55022b-b396-4388-8f39-d8f36054d20a"
replace teaching_language =3 if interview_ID =="04d1d201-dfd2-4a7b-9a58-8902ce9ee60a"
replace teaching_language =1 if interview_ID =="f925fc1d-0d39-41ac-95d4-93679ff6d84c"
replace teaching_language =3 if interview_ID =="903bd68a-d26b-491a-94c2-0cf91418cf6d"
replace teaching_language =3 if interview_ID =="5bcc1c7d-0f28-4158-a2df-6ebfff0e3701"
replace teaching_language =3 if interview_ID =="7316171a-365c-4f27-bc5c-a2d19739d52a"
replace teaching_language =3 if interview_ID =="146af2fd-2f60-4d50-aae1-5449c556cd7b"
replace teaching_language =1 if interview_ID =="cf6b59a7-6ed5-4f0a-83e1-3b6554e76190"
replace teaching_language =3 if interview_ID =="828a231d-8d3b-4515-82f2-4db8720c1887"
replace teaching_language =3 if interview_ID =="4dc7b3e5-f8c8-4a66-9acb-4185ede2c16b"
replace teaching_language =3 if interview_ID =="4963cf77-9f2b-40ed-a8b4-1bb0b7561e25"
replace teaching_language =3 if interview_ID =="b48552c3-08bd-4b63-8e07-8a9b534653fe"
replace teaching_language =3 if interview_ID =="7f0e472f-7946-44f4-8b11-535c2c87545e"
replace teaching_language =3 if interview_ID =="c3b4ea71-c3bc-424a-aa3d-a97c73caf437"
replace teaching_language =3 if interview_ID =="87d312cc-e8e9-484f-b63a-50f0a4daec07"
replace teaching_language =3 if interview_ID =="5c2a2905-8d24-420d-8a50-8031ecf83e0e"
replace teaching_language =3 if interview_ID =="297ad4cd-9734-4d17-9424-ed3fa3594af6"
replace teaching_language =3 if interview_ID =="d9c218e5-e0e6-493c-a1d1-0fabfbfc039b"
replace teaching_language =1 if interview_ID =="f472aa19-e4ee-4e09-b6ab-8bd600de957d"
replace teaching_language =1 if interview_ID =="7a7ca376-9da9-4ba4-a445-802999b1d569"
replace teaching_language =1 if interview_ID =="2fbdb190-ce6b-4db3-bd3d-86eeb77f4c2f"
replace teaching_language =2 if interview_ID =="664c5d1c-1210-4aaf-b804-5b42b7057989"
replace teaching_language =1 if interview_ID =="e6112283-c0b2-4c38-8292-1ffa830d7dc8"
replace teaching_language =1 if interview_ID =="6f2c99cb-779a-47ef-ba75-450073085f94"
replace teaching_language =1 if interview_ID =="2d4589ca-0227-430d-ab9d-3f48b9852abb"
replace teaching_language =1 if interview_ID =="33af1dd8-7b97-40ca-90a3-ff9bf5cc78b9"
replace teaching_language =2 if interview_ID =="775fdf37-148c-42cf-9e6e-789e29b752e0"
replace teaching_language =1 if interview_ID =="49d3258b-2f7f-4a5b-b7da-a94119a1741d"
replace teaching_language =1 if interview_ID =="fc083b06-21a2-4665-8228-d741d3d22d15"
replace teaching_language =1 if interview_ID =="df33a347-224b-4d44-b56a-ff31036cff13"
replace teaching_language =2 if interview_ID =="74a5d05b-d0ef-46ff-a1f8-ef76b03464ce"
replace teaching_language =2 if interview_ID =="9aa0c22e-d171-4b2d-a3c7-37fdcd43484b"
replace teaching_language =1 if interview_ID =="d0273b2f-d376-49d6-b1dc-82fc45816d0d"
replace teaching_language =1 if interview_ID =="ce096236-6d51-45ee-9bf3-c71e9644f103"
replace teaching_language =1 if interview_ID =="5f855822-db47-4379-8082-f4b892591670"
replace teaching_language =2 if interview_ID =="80f5c997-81f6-4501-b289-0acbe647690f"
replace teaching_language =1 if interview_ID =="bba9da36-baf3-489d-8964-49514a08ae95"
replace teaching_language =2 if interview_ID =="2e1d1197-4bb8-43ee-8ec6-43c71f5fc1af"
replace teaching_language =1 if interview_ID =="4eae42ee-944c-48e1-a67e-650538cc8941"
replace teaching_language =1 if interview_ID =="34240a67-95fe-48e6-9dc3-481a5eb995f8"
replace teaching_language =2 if interview_ID =="687b58cd-3781-4864-8956-3254c912f3dc"
replace teaching_language =1 if interview_ID =="70692290-12f9-4600-8e8b-161b8d6b6dd8"
replace teaching_language =2 if interview_ID =="3ab06563-d43a-4539-8a4a-2fe171d9f713"
replace teaching_language =2 if interview_ID =="f497c2b1-6436-4d4a-80d5-c36f7c31aafc"
replace teaching_language =1 if interview_ID =="b508dc8b-253b-42b1-b88f-435fdbe52869"
replace teaching_language =2 if interview_ID =="38bdc126-72b7-4df0-8444-c471ca2a87e4"
replace teaching_language =1 if interview_ID =="18e148e8-0d56-481d-addc-401cd8a79600"
replace teaching_language =2 if interview_ID =="96c50de6-a383-4198-a9df-d2dc2e6c678c"
replace teaching_language =2 if interview_ID =="bb896380-88b3-426b-b1cb-c992b1145c15"
replace teaching_language =2 if interview_ID =="016920bf-44b8-4d91-a780-c6a0e957484d"
replace teaching_language =1 if interview_ID =="958c05fe-fa40-4655-b83a-c9653c7ddfd4"
replace teaching_language =2 if interview_ID =="64f00d50-e875-4e77-92c1-f4d53ba1a922"
replace teaching_language =2 if interview_ID =="2eeabd68-3ed4-49f5-a54d-375966e9f7e8"
replace teaching_language =1 if interview_ID =="4aad058f-af72-471c-95cb-20e762b2f6d8"
replace teaching_language =2 if interview_ID =="cdacae65-f165-42ee-8668-d30927fa89b4"
replace teaching_language =2 if interview_ID =="a83d057f-42b8-4ce6-a7e3-c2fb4f1e9cf4"
replace teaching_language =1 if interview_ID =="c9c31e8d-6685-43f6-abdb-acb22510e956"
replace teaching_language =2 if interview_ID =="27ff1a9b-b5d9-4ed0-9fc5-a3dcc1e64519"
replace teaching_language =1 if interview_ID =="cc4ccbd3-15ab-4f89-b523-6aaba6d526e9"
replace teaching_language =1 if interview_ID =="2d855cfe-06f0-4c0f-88b6-4e2f1b6e9659"
replace teaching_language =1 if interview_ID =="d4172b31-e410-4ae7-9e35-df10df8671e3"
replace teaching_language =1 if interview_ID =="695d3744-bced-4b2d-a3c7-f9dab6c0dd92"
replace teaching_language =1 if interview_ID =="4592a6d6-e884-4dcf-9010-cf8ac8140ede"
replace teaching_language =1 if interview_ID =="db5e40e9-5901-4841-bb67-5ae1a3c6a7eb"
replace teaching_language =1 if interview_ID =="ae1ce825-0716-42b8-8df0-f4c03de0b574"
replace teaching_language =1 if interview_ID =="16de6940-63b3-46ea-bbe8-bbcb02e7f9fe"
replace teaching_language =1 if interview_ID =="eab63d34-d938-449e-ab1d-55de9b38c544"
replace teaching_language =2 if interview_ID =="ecd24a66-fb95-406e-a056-30c082ccc370"
replace teaching_language =1 if interview_ID =="fd081796-3a85-40a8-9ac2-0ab56af3c176"
replace teaching_language =2 if interview_ID =="1ccccc68-0735-4dab-b908-a0d3a80a4c9a"
replace teaching_language =2 if interview_ID =="8290158c-8202-4707-a821-c6ca4e5f4cf7"
replace teaching_language =2 if interview_ID =="e1d5d06e-04d1-488f-9f20-0be1971b0b14"
replace teaching_language =2 if interview_ID =="5875efa2-2b0b-4353-b809-e69b1c767cc7"
replace teaching_language =2 if interview_ID =="b2810855-8afa-47f4-b6fa-9c5ebb61fba4"
replace teaching_language =2 if interview_ID =="ef097054-041a-4ff4-985f-27d9e373255e"
replace teaching_language =2 if interview_ID =="a59b6d10-2cb8-4c01-8442-e59478955834"
replace teaching_language =1 if interview_ID =="05cc7dad-1032-4141-b32f-b29e2b442c53"
replace teaching_language =1 if interview_ID =="4a7aab47-6fa0-4d04-87dc-3a23946705b9"
replace teaching_language =2 if interview_ID =="de6386c0-0baf-49b3-bffb-3cac46465ed0"
replace teaching_language =1 if interview_ID =="3676f691-4038-4d35-850f-081bb916d90e"
replace teaching_language =2 if interview_ID =="04af0d11-cd0a-438a-84b3-b07badf6126d"
replace teaching_language =2 if interview_ID =="2f95b04e-68ef-4dec-bba4-0aa80fe4c337"
replace teaching_language =1 if interview_ID =="4bb9439e-83db-41e3-873d-67a4d77efc3e"
replace teaching_language =2 if interview_ID =="849563d3-9773-4a1d-89d8-b7b3a16beb89"
replace teaching_language =1 if interview_ID =="dfbcf07f-5330-48e9-992f-5234859a41a6"
replace teaching_language =2 if interview_ID =="ae218944-f91c-4924-b5ea-1b31a3b0f013"
replace teaching_language =1 if interview_ID =="4644aea1-f044-4cb4-b79a-638800249e8e"
replace teaching_language =1 if interview_ID =="fb9c234b-de3a-40b1-877d-e0774134e95a"
replace teaching_language =2 if interview_ID =="54450ef7-08f0-4f9a-a288-f09d7a6c382d"
replace teaching_language =1 if interview_ID =="896bdf68-1cc1-4b29-bba7-c19e80e50af4"
replace teaching_language =1 if interview_ID =="e5ffddbc-31f4-41e2-a5ad-a63bf0a2f196"
replace teaching_language =1 if interview_ID =="987e3c29-0aa1-4a9c-8aac-916cbc79c550"
replace teaching_language =2 if interview_ID =="278c20ad-72e0-474f-98a2-eb146c877e82"
replace teaching_language =1 if interview_ID =="7e029362-f6a3-411d-8b23-17cd283b7bd8"
replace teaching_language =2 if interview_ID =="b14a5f5e-8b6c-45ed-9ccd-fa1aef85d4dc"
replace teaching_language =1 if interview_ID =="371c0317-3508-4318-b597-f78fe787d8c2"
replace teaching_language =1 if interview_ID =="8036d97d-de52-4a90-be25-312c7151c8b4"
replace teaching_language =1 if interview_ID =="8d3c5fd7-5873-4bf9-81a7-17cc5e4bf39e"
replace teaching_language =1 if interview_ID =="2d0edb86-ec51-4056-a030-9e611ed03ac5"
replace teaching_language =1 if interview_ID =="e9c0ac27-52af-4d1a-8db0-8144b2c5b136"
replace teaching_language =1 if interview_ID =="a0932450-5d6a-4c41-a840-7e8d3073dbe1"
replace teaching_language =2 if interview_ID =="d894d25a-03bc-4663-9dea-fbdf62608d63"
replace teaching_language =1 if interview_ID =="94a31cc7-278a-4dc1-a99f-69fedfbfb4ff"
replace teaching_language =1 if interview_ID =="906a3c39-e317-44ac-a320-b9e0e7bf872c"
replace teaching_language =2 if interview_ID =="36c27614-ece9-4128-8f7e-4e1d7c5a0fa2"
replace teaching_language =2 if interview_ID =="bd2b73ce-9bf3-476d-b89c-47f166f60259"
replace teaching_language =2 if interview_ID =="3cd2c24c-6a2c-470f-90c2-a025d028238d"
replace teaching_language =1 if interview_ID =="4ccb1827-b89e-4397-9de0-746a9203fa5f"
replace teaching_language =2 if interview_ID =="3e41e2ff-9e52-4d18-b6e8-6faf47694c1f"
replace teaching_language =1 if interview_ID =="721f4c0a-19e0-44a6-a988-9dcb1099479e"
replace teaching_language =2 if interview_ID =="dc021baf-6958-4b75-ab39-a6963e4177c4"
replace teaching_language =2 if interview_ID =="f6bdb475-82a5-47e7-aa3a-728b13a2906b"
replace teaching_language =2 if interview_ID =="cfee0ae8-ab33-49d0-8a64-e9828e7b273e"
replace teaching_language =1 if interview_ID =="b186bac0-cc7f-409d-853f-6e45b086c73d"
replace teaching_language =1 if interview_ID =="8c21f71d-6af5-489c-b9c0-71360d00efce"
replace teaching_language =2 if interview_ID =="2cd65397-d824-480c-97ed-cf25d86de3e3"
replace teaching_language =1 if interview_ID =="e323eca7-90a5-408f-881d-f97277b5a5d7"
replace teaching_language =2 if interview_ID =="2205b7de-57f0-4715-85cc-73673f868678"
replace teaching_language =2 if interview_ID =="b0a34862-9126-4fbe-a263-1b445ef70ef3"
replace teaching_language =2 if interview_ID =="8f2109f7-7b96-4b23-8383-7fa94872f586"
replace teaching_language =1 if interview_ID =="4c2c557a-2499-4a4e-99d6-41547e8c1a5d"
replace teaching_language =2 if interview_ID =="6f4445ff-dc73-4064-9174-0044d2973395"
replace teaching_language =1 if interview_ID =="480d348e-70f2-4c4e-8a30-cb6f8cd3ffb8"
replace teaching_language =1 if interview_ID =="1d4c9450-8d69-4f4b-8795-11257f6bfeab"
replace teaching_language =1 if interview_ID =="b10da94e-4ef1-4886-9ee2-be6be009489b"
replace teaching_language =1 if interview_ID =="3c9bd3bb-5071-44b4-a65d-50f28f9608a4"
replace teaching_language =1 if interview_ID =="f6f55a81-b07b-4ddc-8c70-0a9d77a7f56d"
replace teaching_language =1 if interview_ID =="0f1e6edb-fbdd-49a6-98b4-8a29a96c6fce"
replace teaching_language =1 if interview_ID =="ddf9180a-94dd-4109-a1d3-e26552185847"
replace teaching_language =1 if interview_ID =="6129d954-3047-43e7-97a6-b58e5870603b"
replace teaching_language =1 if interview_ID =="e2a5aa95-3efe-4176-8de2-a917e416f892"
replace teaching_language =1 if interview_ID =="eff2f8f1-8eca-4e81-937a-6cb060ad35fe"
replace teaching_language =2 if interview_ID =="56645761-47d9-4afd-abac-085730b553b4"
replace teaching_language =1 if interview_ID =="ec1cca0d-209a-422a-add1-556ab98ff141"
replace teaching_language =2 if interview_ID =="5d269cb5-2db4-4006-881f-d0c5cf95d158"
replace teaching_language =2 if interview_ID =="fc355bf6-b25a-4cf0-9e92-a866fd8c9cda"
replace teaching_language =1 if interview_ID =="a88f1ef6-f60a-43a9-931f-4739f52c69d7"
replace teaching_language =1 if interview_ID =="52db65f5-3c9f-4d76-bade-daa69c6693f7"
replace teaching_language =1 if interview_ID =="d7c38247-d416-4855-b261-5050a11bac45"
replace teaching_language =2 if interview_ID =="32083ff4-497b-470c-83d3-ef7e448879be"
replace teaching_language =2 if interview_ID =="d747478e-c559-4fa5-a205-dd55d2e84615"
replace teaching_language =2 if interview_ID =="7644de24-742d-4cbe-bbc6-0e4916ed7133"
replace teaching_language =2 if interview_ID =="ba3d30d5-2d1b-4345-88dc-4687ca935d06"
replace teaching_language =1 if interview_ID =="342492e9-a75c-415e-9303-e4fff2ef6019"
replace teaching_language =2 if interview_ID =="423b834f-e93d-4f99-a392-d2cedd3a09ec"
replace teaching_language =1 if interview_ID =="cc2c09e4-d50e-4db2-b70a-1343534512c4"
replace teaching_language =1 if interview_ID =="5a8c8e58-9d6a-4a8b-8802-079294482ae1"
replace teaching_language =1 if interview_ID =="763ea2cb-2ba2-4707-b96a-0209f4d0ca55"
replace teaching_language =2 if interview_ID =="585e2373-1621-41c8-a53c-c84166907d78"
replace teaching_language =2 if interview_ID =="3eb87b48-e1b1-4004-aced-ffa569170df3"
replace teaching_language =2 if interview_ID =="a5cbd55d-9a46-4dc9-8d9f-bf71d9e2e05b"
replace teaching_language =2 if interview_ID =="cbc373d5-d289-4b98-b8b8-8d13ce9e469e"
replace teaching_language =1 if interview_ID =="50e669b7-5e85-4250-b834-d2bd5ef2f6a2"
replace teaching_language =2 if interview_ID =="86700737-288a-4b8e-b7fd-0db7c2f3ddce"
replace teaching_language =1 if interview_ID =="7301d1e7-6c89-4219-9050-27e16a5bb8fb"
replace teaching_language =2 if interview_ID =="9a624f36-28c4-436e-b0a6-1e4d914d0d30"
replace teaching_language =2 if interview_ID =="9ece55b5-5dd4-4a2b-9d27-3eb4087925e5"
replace teaching_language =1 if interview_ID =="41dc0aa6-9bbe-4fa0-aae9-a563b1c49456"
replace teaching_language =2 if interview_ID =="744dcc9a-7871-446d-9161-ac97cbd808df"
replace teaching_language =2 if interview_ID =="57af00e3-d5db-4f4d-8741-d5a691d27744"
replace teaching_language =1 if interview_ID =="82eea277-0346-4c40-b235-30f785cc6a8c"
replace teaching_language =2 if interview_ID =="f956d6aa-5c0c-4739-9e00-dc2e3a315c71"
replace teaching_language =2 if interview_ID =="e66b02e8-0253-423a-970c-c354079d37fb"
replace teaching_language =1 if interview_ID =="76da393a-4246-4d2d-87eb-f5c0fa97db92"
replace teaching_language =2 if interview_ID =="1eeedaaf-eecb-45b0-a69d-ea362dd1c425"
replace teaching_language =2 if interview_ID =="dd445b1c-916f-4b7c-9059-24f0a45655a8"
replace teaching_language =2 if interview_ID =="a3799748-5d88-4de6-a038-c5923894507d"
replace teaching_language =2 if interview_ID =="500d304c-1438-41e4-96b5-9c38c84f7e39"
replace teaching_language =2 if interview_ID =="02cddc5e-7724-4cec-8019-f15ca2aaf6da"
replace teaching_language =2 if interview_ID =="4dd8a3b9-5493-40ac-8625-55221a642082"
replace teaching_language =2 if interview_ID =="6e2f6dad-354e-4bf6-8452-21008ad88ca7"
replace teaching_language =2 if interview_ID =="2611f2db-a04a-47da-b261-259ccd28e338"
replace teaching_language =2 if interview_ID =="ccde7f7d-4080-427c-8805-3c9dea4bf1cc"
replace teaching_language =2 if interview_ID =="75ded4fd-27e2-440e-90d2-977194e4e0f9"
replace teaching_language =2 if interview_ID =="1e82a138-c1bd-40da-b7f5-bc1c37566c7f"
replace teaching_language =2 if interview_ID =="7451cbf4-4128-4e20-aa6a-fd1d09750f3a"
replace teaching_language =1 if interview_ID =="2ddf89db-e7bb-4cc4-a5bf-3284a3536072"
replace teaching_language =1 if interview_ID =="2ea90b08-8d95-441e-a8a4-8bd812e0aa57"
replace teaching_language =2 if interview_ID =="5f3c57b5-a7b6-4031-b106-64c6a4969f01"
replace teaching_language =2 if interview_ID =="eeda558d-9be8-46c0-a2f7-dc543d34a5dc"
replace teaching_language =2 if interview_ID =="0efe8e10-f0fa-4fa8-b28e-da8c9192a60f"
replace teaching_language =1 if interview_ID =="1f111b6a-387e-4e61-81c9-622d207742f7"
replace teaching_language =2 if interview_ID =="ca332f93-3166-4d0a-90ef-44d651ebf19a"
replace teaching_language =2 if interview_ID =="3a3d32d6-3da6-4f5d-a72b-c57591490ea2"
replace teaching_language =2 if interview_ID =="6eb72794-efc0-48af-92e2-a90b403de61f"
replace teaching_language =2 if interview_ID =="bbdfb929-3c53-480a-a728-4633f329f833"
replace teaching_language =2 if interview_ID =="8cf7dab5-e361-4e11-a07b-53b4ddb07d3b"
replace teaching_language =2 if interview_ID =="dab6f85d-1dcf-420d-a750-47681dea2b8e"
replace teaching_language =2 if interview_ID =="967f49aa-c855-4fcb-b32c-a46e896964a8"
replace teaching_language =2 if interview_ID =="d2bd98e7-64bd-499e-bbcf-95f2ef86650b"
replace teaching_language =2 if interview_ID =="5d3e5dbf-5132-4f46-b027-e401fd6611f4"
replace teaching_language =2 if interview_ID =="7d5e030b-01da-4e7c-b0d7-237e2a63754f"
replace teaching_language =2 if interview_ID =="6ebca319-337b-40fc-a0e7-170ea5dc629f"
replace teaching_language =2 if interview_ID =="5d3db37f-b6ac-43ec-9130-af7edc8149cd"
replace teaching_language =2 if interview_ID =="d67f831d-b280-4f07-b17f-d350388e3e01"
replace teaching_language =2 if interview_ID =="f830bab3-74e7-45f4-b0e2-8c3885992c71"
replace teaching_language =2 if interview_ID =="e654d973-eae8-4dfa-849b-4b7b226911bc"
replace teaching_language =2 if interview_ID =="dbd1c883-0268-4394-a86c-9ba0d1e56d09"
replace teaching_language =2 if interview_ID =="bc95181a-9571-4c52-afdc-a3eac063cfcb"
replace teaching_language =2 if interview_ID =="97d71f6c-98da-4cd9-bc86-dce05b13fb44"
replace teaching_language =2 if interview_ID =="f7f16800-2a85-442b-9f83-69ffbc18021c"
replace teaching_language =2 if interview_ID =="c36a9870-8acb-41cb-b989-78b7f52753a9"
replace teaching_language =1 if interview_ID =="7895b14d-fcb2-45d4-b877-8b48e14e4457"
replace teaching_language =1 if interview_ID =="8ad12e26-7380-4936-8b9d-7771e5b65fec"
replace teaching_language =2 if interview_ID =="fac43095-6f57-476e-bc3f-6364aab4708e"
replace teaching_language =2 if interview_ID =="2abb8dd0-08b8-41a7-9637-3e8e64ae7276"
replace teaching_language =2 if interview_ID =="74ac1b56-86c2-4946-86a3-1b850eeeed35"
replace teaching_language =2 if interview_ID =="992de92e-d253-43df-9fce-5d6937cc4b1a"
replace teaching_language =1 if interview_ID =="32c49089-74ee-45b7-9679-59f048b79e51"
replace teaching_language =2 if interview_ID =="c860a452-4dca-422b-927b-af6f89153562"
replace teaching_language =2 if interview_ID =="2c2d763c-77a2-46a8-8bcd-a46e75709bca"
replace teaching_language =2 if interview_ID =="aa71dbcc-9fd7-4b18-8b0e-480a4869766d"
replace teaching_language =2 if interview_ID =="73fff59c-a151-4d4d-b903-fb2d1485a31d"
replace teaching_language =2 if interview_ID =="b3d2bace-76f2-4c37-8dae-bd6d50d38057"
replace teaching_language =2 if interview_ID =="00aa1fe9-0240-4be0-b851-223e592e7bf5"
replace teaching_language =2 if interview_ID =="5dd52609-089b-4200-9ce6-ec1b0e3100bb"
replace teaching_language =2 if interview_ID =="de3c2ea7-219c-420e-922b-c6c8d9cc6aa0"
replace teaching_language =2 if interview_ID =="ff7bcb16-4d87-4766-8924-fb161da2e83e"
replace teaching_language =2 if interview_ID =="acedeb6c-4873-4230-8a07-2e059b91d746"
replace teaching_language =2 if interview_ID =="08b9b550-4288-456e-8452-10720aed8fa4"

*Query 4.
*phonological_awareness

foreach x in phonological_awareness_fr_1 phonological_awareness_fr_2 phonological_awareness_fr_3 phonological_awareness_fr_4 phonological_awareness_fr_5 phonological_awareness_fr_6 phonological_awareness_fr_7 phonological_awareness_fr_8 phonological_awareness_fr_9 phonological_awareness_fr_10 phonological_awareness_frnumber_ phonological_awareness_frnum_att phonological_awareness_frgridAut phonological_awareness_frautoSto phonological_stop_fr{
	replace `x' = . if B4 == 1
}

foreach x in  phonological_awareness_sr_1 phonological_awareness_sr_2 phonological_awareness_sr_3 phonological_awareness_sr_4 phonological_awareness_sr_5 phonological_awareness_sr_6 phonological_awareness_sr_7 phonological_awareness_sr_8 phonological_awareness_sr_9 phonological_awareness_sr_10 phonological_awareness_srnumber_ phonological_awareness_srnum_att phonological_awareness_srgridAut phonological_awareness_srautoSto phonological_stop_sr phonological_awareness_pr_1 phonological_awareness_pr_2 phonological_awareness_pr_3 phonological_awareness_pr_4 phonological_awareness_pr_5 phonological_awareness_pr_6 phonological_awareness_pr_7 phonological_awareness_pr_8 phonological_awareness_pr_9 phonological_awareness_pr_10 phonological_awareness_prnumber_ phonological_awareness_prnum_att phonological_awareness_prgridAut phonological_awareness_prautoSto phonological_stop_pr{
	replace `x' = . if B4 == 2 & survey_language == 2 & official_language == 2
}

foreach x in   phonological_awareness_wf_1 phonological_awareness_wf_2 phonological_awareness_wf_3 phonological_awareness_wf_4 phonological_awareness_wf_5 phonological_awareness_wf_6 phonological_awareness_wf_7 phonological_awareness_wf_8 phonological_awareness_wf_9 phonological_awareness_wf_10 phonological_awareness_wfnumber_ phonological_awareness_wfnum_att phonological_awareness_wfgridAut phonological_awareness_wfautoSto phonological_stop_wf phonological_awareness_pr_1 phonological_awareness_pr_2 phonological_awareness_pr_3 phonological_awareness_pr_4 phonological_awareness_pr_5 phonological_awareness_pr_6 phonological_awareness_pr_7 phonological_awareness_pr_8 phonological_awareness_pr_9 phonological_awareness_pr_10 phonological_awareness_prnumber_ phonological_awareness_prnum_att phonological_awareness_prgridAut phonological_awareness_prautoSto phonological_stop_pr{
	replace `x' = . if B4 == 2 & survey_language == 3 & official_language == 3
}

foreach x in   phonological_awareness_wf_1 phonological_awareness_wf_2 phonological_awareness_wf_3 phonological_awareness_wf_4 phonological_awareness_wf_5 phonological_awareness_wf_6 phonological_awareness_wf_7 phonological_awareness_wf_8 phonological_awareness_wf_9 phonological_awareness_wf_10 phonological_awareness_wfnumber_ phonological_awareness_wfnum_att phonological_awareness_wfgridAut phonological_awareness_wfautoSto phonological_stop_wf  phonological_awareness_sr_1 phonological_awareness_sr_2 phonological_awareness_sr_3 phonological_awareness_sr_4 phonological_awareness_sr_5 phonological_awareness_sr_6 phonological_awareness_sr_7 phonological_awareness_sr_8 phonological_awareness_sr_9 phonological_awareness_sr_10 phonological_awareness_srnumber_ phonological_awareness_srnum_att phonological_awareness_srgridAut phonological_awareness_srautoSto phonological_stop_sr{
	replace `x' = . if B4 == 2 & survey_language == 4 & official_language == 4
}

foreach x in  phonological_awareness_wf_1 phonological_awareness_wf_2 phonological_awareness_wf_3 phonological_awareness_wf_4 phonological_awareness_wf_5 phonological_awareness_wf_6 phonological_awareness_wf_7 phonological_awareness_wf_8 phonological_awareness_wf_9 phonological_awareness_wf_10 phonological_awareness_wfnumber_ phonological_awareness_wfnum_att phonological_awareness_wfgridAut phonological_awareness_wfautoSto phonological_stop_wf phonological_awareness_sr_1 phonological_awareness_sr_2 phonological_awareness_sr_3 phonological_awareness_sr_4 phonological_awareness_sr_5 phonological_awareness_sr_6 phonological_awareness_sr_7 phonological_awareness_sr_8 phonological_awareness_sr_9 phonological_awareness_sr_10 phonological_awareness_srnumber_ phonological_awareness_srnum_att phonological_awareness_srgridAut phonological_awareness_srautoSto phonological_stop_sr phonological_awareness_pr_1 phonological_awareness_pr_2 phonological_awareness_pr_3 phonological_awareness_pr_4 phonological_awareness_pr_5 phonological_awareness_pr_6 phonological_awareness_pr_7 phonological_awareness_pr_8 phonological_awareness_pr_9 phonological_awareness_pr_10 phonological_awareness_prnumber_ phonological_awareness_prnum_att phonological_awareness_prgridAut phonological_awareness_prautoSto phonological_stop_pr{
	replace `x' = . if B4 == 3 & survey_language == 1
}

//////////////////////////////////////////////////

******OTHER ASSESSMENT SECTIONS TO BE SORTED.
//////////////////////////////////////////////////

*Query 5
*fr
egen corr_lett_fr = rowtotal(letter_knowledge_fr_1 - letter_knowledge_fr_20)

replace letter_knowledge_frnumber_of_ite = corr_lett_fr
drop corr_lett_fr

*wf
egen corr_lett_wf = rowtotal(letter_knowledge_wf_1 - letter_knowledge_wf_20)

replace letter_knowledge_wfnumber_of_ite = corr_lett_wf

drop corr_lett_wf

*sr
egen corr_lett_sr = rowtotal(letter_knowledge_sr_1 - letter_knowledge_sr_20)

replace letter_knowledge_srnumber_of_ite = corr_lett_sr

drop corr_lett_sr

*pr
egen corr_lett_pr = rowtotal(letter_knowledge_pr_1 - letter_knowledge_pr_20)

replace letter_knowledge_prnumber_of_ite = corr_lett_pr

drop corr_lett_pr

///////////////////////////////////////////////
*Do for other assessment sections too.
///////////////////////////////////////////////

*Query 6/7.
*GPS issue
drop if inlist(interview_ID, "2c2d763c-77a2-46a8-8bcd-a46e75709bca", "00aa1fe9-0240-4be0-b851-223e592e7bf5","5dd52609-089b-4200-9ce6-ec1b0e3100bb")

*Corrections on school grade data
*Student-CE1
replace Ecole = 60 if inlist(interview_ID,"34240a67-95fe-48e6-9dc3-481a5eb995f8")
drop if inlist(interview_ID,"db5e40e9-5901-4841-bb67-5ae1a3c6a7eb","f155b559-9343-422f-b48a-534e15410db8")

*CP
drop if inlist(interview_ID,"50ea1893-d501-4ac3-9caf-39c180bc5790","ec024bd8-7641-4d5f-b311-045fc7b45c4c")

replace Ecole = 60 if inlist(interview_ID,"6f2c99cb-779a-47ef-ba75-450073085f94","d0273b2f-d376-49d6-b1dc-82fc45816d0d","4aad058f-af72-471c-95cb-20e762b2f6d8","fc083b06-21a2-4665-8228-d741d3d22d15","18e148e8-0d56-481d-addc-401cd8a79600","33af1dd8-7b97-40ca-90a3-ff9bf5cc78b9")

*CE1
replace Ecole = 17 if inlist(interview_ID,"f6d5a07d-0d19-4411-a497-155614f3e724")
replace Ecole = 60 if inlist(interview_ID,"cdacae65-f165-42ee-8668-d30927fa89b4","a83d057f-42b8-4ce6-a7e3-c2fb4f1e9cf4","323e8c24-dd56-4749-a507-d0699efc9619","687b58cd-3781-4864-8956-3254c912f3dc","80f5c997-81f6-4501-b289-0acbe647690f","64f00d50-e875-4e77-92c1-f4d53ba1a922","2eeabd68-3ed4-49f5-a54d-375966e9f7e8","38bdc126-72b7-4df0-8444-c471ca2a87e4")

*semantic 6-12 corr
replace semantic_language_timer1time_rem = 0 if inlist(interview_ID,"c661d318-bc92-4a49-bdaa-82467b79d913","1e0571ed-db76-4822-8c23-8af79ce41085")

replace semantic_language_timer2time_rem = 0 if interview_ID == "47e9f5fc-92a6-4c4f-bbb3-3e16af493fd5"

*09-12 Corrections
egen corr_red_fr = rowtotal(read_familiar_words_wf_1 - read_familiar_words_wf_20)

replace read_familiar_words_wfnumber_of_ = corr_red_fr

drop corr_red_fr

*Dropping incomplete interviews.
drop if inlist(interview_ID,"eb556751-a143-44ca-a4fa-bc9a93833f69","9e4ed0cc-3d30-4f77-814d-a4c56e292587","3dba3444-f931-4192-a026-0592fed5c4db","bbdfb929-3c53-480a-a728-4633f329f833","d9c218e5-e0e6-493c-a1d1-0fabfbfc039b","47e9f5fc-92a6-4c4f-bbb3-3e16af493fd5","ce096236-6d51-45ee-9bf3-c71e9644f103","5f855822-db47-4379-8082-f4b892591670")

drop if inlist(interview_ID,"de3c2ea7-219c-420e-922b-c6c8d9cc6aa0","fd078077-4f3f-4e65-82ce-7f10b8982c97","05cc7dad-1032-4141-b32f-b29e2b442c53")

drop if inlist(interview_ID,"7869334c-cd3d-4388-8419-a216dd14caef","f2a4e283-d553-4d14-ad0e-a58a1bcb8424","8ff22001-8c87-4dd9-98d4-eeaa9a822b54","9ed45e5b-3930-43cb-b03c-b810974c8c56","43ac1534-7f8e-425d-88f8-cc93e82f173b","78ba35a8-bcb9-405a-9f4e-266a98275e54","419c2b74-de5a-4aad-a54b-280d098d1ce5","840ba10d-cf58-4833-b331-89cd74cc9772")

drop if inlist(interview_ID,"2d9cb548-7200-48a5-9566-e17039a1bff8","06c17ef7-1608-458f-8473-2f736870f4b5","86cd1e56-aa42-499b-b877-74f71485d830","c95c2b98-bd5b-4dcf-9238-210b23130ed2","38e8446d-f142-427a-b3cf-027bb64cd917","f07daf03-9221-4709-9d1c-e99ebe5119bd","cef32e30-7229-4564-8eb9-541425055a67","22495d80-cb3c-435f-b21f-d801f89a6629")

drop if inlist(interview_ID,"840ef329-dacb-462e-9009-f55d1296f1b4","126795ed-3114-45b3-8d85-d753a0d7108f","827947db-1c1a-4ad7-9979-6ae5296b56d9","7dc317cb-d5b9-46bd-b8e2-7195df5fbb6d","8ba63e44-856f-4478-8d36-c8ae3d911b19","d3816a4b-33c6-4b32-80d2-d89b53157feb","9dcd5ddd-7c4f-49c4-a82e-49cdc3a63daa","b55c5039-e885-42f7-b59c-3352d7a7ba4a")

drop if inlist(interview_ID,"46d53249-ec7e-4b7a-87d5-ed5f0f5c8ca9","6beb9aa4-212a-4448-833c-0ae62c737a71","a732939c-eee6-45d4-bfa5-a226f9ff321c","349f62ac-f24d-47ae-92c8-3b893d44d528","19641916-5d8a-44dc-84f7-14687a0f1dc5","5d84205a-b25f-4b07-ba84-ad4967439d32","7416e101-ba15-4426-b0ce-f749708f7653","d0df4be5-d867-4bf2-8354-3273d271108b")

drop if inlist(interview_ID,"2353cf8a-8572-440f-bf88-7fe4b897108b","0ac45d66-8ac1-43e3-892d-526c644742fa")

drop if inlist(interview_ID,"159f4fce-be16-48c4-9bfb-23d143ee91db")

drop if inlist(interview_ID,"a7ff331e-4908-4621-8ef0-88a94e169773","f5df61f6-7e29-4a91-af8f-cfe4d479a6a5","40d3557b-f93e-497f-b805-dea78f5f3e59")

*school correction
replace Echantillon = 2 if interview_ID == "f6d5a07d-0d19-4411-a497-155614f3e724"

*16-12
drop if inlist(interview_ID,"8a42aaa4-4325-446c-9ca3-2c18e97d3e9d","ea7279f1-8c3b-43f9-8a07-2f9176292898","fd689c26-672e-4435-b5b6-950eaabae2dc","5a104bc0-4075-4f5b-bb15-74af197d97a4")

*17-12
drop if inlist(interview_ID,"72429a1b-7e8b-48d8-a0f8-e405b61e8112","a6794d7e-d108-4290-a002-d96e30d35bf3","472a7053-6b5d-4c0a-a2f1-97e30aca668d","2bc7a4f8-c0f2-4d8c-8b55-393fe7ab9636","54ecd43d-01c2-49d1-afe3-c9cc07084ec8","5e17e2bd-a9f0-4214-9a73-cf029181fd08","d111a8a7-90cc-4554-ac0e-00c2a1c62046","6446b6f9-a1c9-48bc-a528-0ec9aac496d0")

drop if inlist(interview_ID,"9abf1bf7-c3e2-4613-ae84-030adc69af86","b82ab1de-c817-4ecb-8cb0-616bc81218fa")

*18-12
drop if inlist(interview_ID,"efbf2b31-fa00-4227-89a2-c0399a58414c","0587f7b5-8cbd-4ccd-97b2-06b0c85ef07f","8906ba92-3881-4b0c-a77d-088f42df9d46","d6717c6c-f9e4-49ea-8827-b23b46dc9aeb","663ad069-2a87-4c15-9ef2-06b4fecde15b","983ef8a4-d482-4d35-bd4b-d0d0bacafc0d","2b1c2df1-4df9-4638-9edf-4cdef133567a","44b42643-c356-477b-a4a8-0411c1531b41")

*19-12
drop if inlist(interview_ID,"b92ff6f5-791f-4d47-b488-729482e50d16","21b9a97e-a0be-4f82-9a47-bfbd86f0a076")

*20-12
drop if inlist(interview_ID,"88cb16c9-5436-4991-9b3f-b31f43873a38")

replace SUP_NAME = 4 if interview_ID == "6a3df464-5eb5-4e79-b97b-cb3ea2c9ad6e"
replace ENUM_NAME = 23 if interview_ID == "6a3df464-5eb5-4e79-b97b-cb3ea2c9ad6e"

replace SUP_NAME = 5 if interview_ID == "f2b25984-966a-42c4-a907-7dc0dd9ffb35"
replace ENUM_NAME = 25 if interview_ID == "f2b25984-966a-42c4-a907-7dc0dd9ffb35"

*23-12
drop if inlist(interview_ID,"a5fbe66c-6cdb-47b2-93ae-25f0ea2576fb","13ba90a8-993c-409f-9847-2e91ebaa132a")

*Corrections
*letter knowledge
foreach x in letter_knowledge_fr_16 letter_knowledge_fr_17 letter_knowledge_fr_18 letter_knowledge_fr_19 letter_knowledge_fr_20{
	replace `x' = 0 if interview_ID == "a6725c3a-7479-4863-a933-030c458c2b62"
}

replace letter_knowledge_frnum_att = 20 if interview_ID == "a6725c3a-7479-4863-a933-030c458c2b62"

foreach x in letter_knowledge_wf_B_31	letter_knowledge_wf_B_32	letter_knowledge_wf_B_33	letter_knowledge_wf_B_34	letter_knowledge_wf_B_35	letter_knowledge_wf_B_36{
	replace `x' = 0 if inlist(interview_ID,"4b934f6a-45c0-4a64-9416-46b346f21acc","d35d2383-0a47-4ed2-bee8-68275cc26b0a")
}
					
foreach x in letter_knowledge_wf_B_25	letter_knowledge_wf_B_26	letter_knowledge_wf_B_27	letter_knowledge_wf_B_28	letter_knowledge_wf_B_29	letter_knowledge_wf_B_30{
	replace `x' = 0 if inlist(interview_ID,"d35d2383-0a47-4ed2-bee8-68275cc26b0a")
}

replace letter_knowledge_wf_Bnum_att = 36 if inlist(interview_ID,"4b934f6a-45c0-4a64-9416-46b346f21acc","d35d2383-0a47-4ed2-bee8-68275cc26b0a")

***GENERAL CORRECTIONS and order
*phonological_awareness
ren phonological_awareness_frnumber_ phonological_awareness_frnumCorr
ren phonological_awareness_wfnumber_ phonological_awareness_wfnumCorr
ren phonological_awareness_srnumber_ phonological_awareness_srnumCorr
ren phonological_awareness_prnumber_ phonological_awareness_prnumCorr

replace phonological_awareness_frnum_att = 10 if phonological_awareness_frnum_att == 0
replace phonological_awareness_wfnum_att = 10 if phonological_awareness_wfnum_att == 0
replace phonological_awareness_sr_5 = 0 if interview_ID == "d5ce0f5a-f00b-4d86-9557-4fca07a8351c"
replace phonological_awareness_srnumCorr = 0 if interview_ID == "d5ce0f5a-f00b-4d86-9557-4fca07a8351c"
replace phonological_awareness_srnum_att = 5 if interview_ID == "d5ce0f5a-f00b-4d86-9557-4fca07a8351c"
replace phonological_awareness_srnum_att = 10 if phonological_awareness_srnum_att == 0
replace phonological_awareness_prnum_att = 10 if phonological_awareness_prnum_att == 0

replace survey_language = 3 if interview_ID == "47666102-d07b-4124-9f18-3e70cec3d3e5"

foreach x in phonological_awareness_fr_1 phonological_awareness_fr_2	phonological_awareness_fr_3	phonological_awareness_fr_4	phonological_awareness_fr_5{
	replace `x' = 0 if interview_ID == "b6ada92b-db03-4fb8-ae3c-aa68909d7c20"
}
replace phonological_awareness_frnum_att = 5 if interview_ID == "b6ada92b-db03-4fb8-ae3c-aa68909d7c20"				
// replace phonological_awareness_frnumCorr = 0 if interview_ID == "b6ada92b-db03-4fb8-ae3c-aa68909d7c20"
replace phonological_awareness_frgridAut = 1 if interview_ID == "b6ada92b-db03-4fb8-ae3c-aa68909d7c20"
replace phonological_awareness_frautoSto = 5 if interview_ID == "b6ada92b-db03-4fb8-ae3c-aa68909d7c20"	
replace phonological_stop_fr = 1 if interview_ID == "b6ada92b-db03-4fb8-ae3c-aa68909d7c20"

replace survey_language = official_language if B4 == 1 & survey_language != official_language

replace pr_oral_vocabulary_example_1 = 1  if interview_ID == "bb3899a2-3c0d-4d2e-868a-33889996bf0f"
replace pr_oral_vocabulary_example_2 = 3 if interview_ID == "bb3899a2-3c0d-4d2e-868a-33889996bf0f"
replace pr_ov_picture_matching_q1 = 2 if interview_ID == "bb3899a2-3c0d-4d2e-868a-33889996bf0f"
replace pr_ov_picture_matching_q2 = 2 if interview_ID == "bb3899a2-3c0d-4d2e-868a-33889996bf0f" 
replace pr_ov_picture_matching_q3 = 1 if interview_ID == "bb3899a2-3c0d-4d2e-868a-33889996bf0f"
replace pr_ov_picture_matching_q4 = 3 if interview_ID == "bb3899a2-3c0d-4d2e-868a-33889996bf0f"
replace pr_ov_picture_matching_q5 = 4 if interview_ID == "bb3899a2-3c0d-4d2e-868a-33889996bf0f"
replace pr_ov_picture_matching_q6 = 4 if interview_ID == "bb3899a2-3c0d-4d2e-868a-33889996bf0f"
replace pr_ov_picture_matching_q7 = 1 if interview_ID == "bb3899a2-3c0d-4d2e-868a-33889996bf0f"
replace pr_ov_picture_matching_q8 = 4 if interview_ID == "bb3899a2-3c0d-4d2e-868a-33889996bf0f"
replace pr_ov_picture_matching_q9 = 2 if interview_ID == "bb3899a2-3c0d-4d2e-868a-33889996bf0f"
replace pr_ov_picture_matching_q10 = 3 if interview_ID == "bb3899a2-3c0d-4d2e-868a-33889996bf0f"
replace pr_ov_picture_matching_q11 = 3 if interview_ID == "bb3899a2-3c0d-4d2e-868a-33889996bf0f"
replace pr_ov_picture_matching_q12 = 4 if interview_ID == "bb3899a2-3c0d-4d2e-868a-33889996bf0f"
replace pr_ov_picture_matching_q13 = 4 if interview_ID == "bb3899a2-3c0d-4d2e-868a-33889996bf0f"
replace pr_ov_picture_matching_q14 = 2 if interview_ID == "bb3899a2-3c0d-4d2e-868a-33889996bf0f"
replace pr_ov_picture_matching_q15 = 2 if interview_ID == "bb3899a2-3c0d-4d2e-868a-33889996bf0f"

*Letter knowledge
replace letter_knowledge_frnumber_of_ite = . if letter_knowledge_frgridAutoStopp == .
replace letter_knowledge_wfnumber_of_ite = . if letter_knowledge_wfgridAutoStopp == .
replace letter_knowledge_srnumber_of_ite = . if letter_knowledge_srgridAutoStopp == .
replace letter_knowledge_prnumber_of_ite = . if letter_knowledge_prgridAutoStopp == .

replace letter_knowledge_wf_11 = 0 if interview_ID == "2682570a-c0cb-433d-952f-87fc71639c5f"
replace letter_knowledge_wfnumber_of_ite = 2 if interview_ID == "2682570a-c0cb-433d-952f-87fc71639c5f"

foreach x in letter_knowledge_wf_12	letter_knowledge_wf_13	letter_knowledge_wf_14	letter_knowledge_wf_15 letter_knowledge_wf_16{
	replace `x' = . if inlist(interview_ID,"ad003360-678d-4610-806f-f8e391bdfcfe","d80424bc-7e1a-41a9-bf1d-12d1816dc263")
}

replace letter_knowledge_wfnum_att = 11 if inlist(interview_ID,"ad003360-678d-4610-806f-f8e391bdfcfe","d80424bc-7e1a-41a9-bf1d-12d1816dc263")
replace letter_knowledge_wfnumber_of_ite = 1 if inlist(interview_ID,"ad003360-678d-4610-806f-f8e391bdfcfe","d80424bc-7e1a-41a9-bf1d-12d1816dc263")
replace letter_knowledge_wfitems_per_min = 1 if inlist(interview_ID,"ad003360-678d-4610-806f-f8e391bdfcfe","d80424bc-7e1a-41a9-bf1d-12d1816dc263")

replace letter_knowledge_wf_16 = . if interview_ID == "2c9b3e83-0ab8-4137-8a81-3bf80bf7fa31"
replace letter_knowledge_wfnumber_of_ite = 2 if interview_ID == "2c9b3e83-0ab8-4137-8a81-3bf80bf7fa31"
replace letter_knowledge_wfnum_att = 15 if interview_ID == "2c9b3e83-0ab8-4137-8a81-3bf80bf7fa31"

foreach x in letter_knowledge_wf_11	letter_knowledge_wf_12	letter_knowledge_wf_13	letter_knowledge_wf_14	letter_knowledge_wf_15	letter_knowledge_wf_16	letter_knowledge_wf_17	letter_knowledge_wf_18	letter_knowledge_wf_19{
	replace `x' = . if interview_ID == "e9fd15ba-5704-40be-8886-6235129bb81d"
}

replace letter_knowledge_wf_10 = 0 if interview_ID == "e9fd15ba-5704-40be-8886-6235129bb81d"
replace letter_knowledge_wf_2 = 1 if interview_ID == "e9fd15ba-5704-40be-8886-6235129bb81d"

replace letter_knowledge_wfnumber_of_ite = 2 if interview_ID == "e9fd15ba-5704-40be-8886-6235129bb81d"
replace letter_knowledge_wfnum_att = 10 if interview_ID == "e9fd15ba-5704-40be-8886-6235129bb81d"
replace letter_knowledge_wfitems_per_min = 2 if interview_ID == "e9fd15ba-5704-40be-8886-6235129bb81d"

foreach x in letter_knowledge_wf_14	letter_knowledge_wf_15	letter_knowledge_wf_16	letter_knowledge_wf_17	letter_knowledge_wf_18	letter_knowledge_wf_19{
	replace `x' = . if interview_ID == "f497c2b1-6436-4d4a-80d5-c36f7c31aafc"
}

replace letter_knowledge_wfnumber_of_ite = 4 if interview_ID == "f497c2b1-6436-4d4a-80d5-c36f7c31aafc"
replace letter_knowledge_wfnum_att = 13 if interview_ID == "f497c2b1-6436-4d4a-80d5-c36f7c31aafc"
replace letter_knowledge_wfitems_per_min = 4 if interview_ID == "f497c2b1-6436-4d4a-80d5-c36f7c31aafc"

foreach x in letter_knowledge_wf_16	letter_knowledge_wf_17	letter_knowledge_wf_18	letter_knowledge_wf_19	letter_knowledge_wf_20{
	replace `x' = . if interview_ID == "56645761-47d9-4afd-abac-085730b553b4"
}

replace letter_knowledge_wfnumber_of_ite = 1 if interview_ID == "56645761-47d9-4afd-abac-085730b553b4"
replace letter_knowledge_wfnum_att = 15 if interview_ID == "56645761-47d9-4afd-abac-085730b553b4"
replace letter_knowledge_wfitems_per_min = 1 if interview_ID == "56645761-47d9-4afd-abac-085730b553b4"

foreach x in letter_knowledge_wf_15	letter_knowledge_wf_16	letter_knowledge_wf_17	letter_knowledge_wf_18	letter_knowledge_wf_19	letter_knowledge_wf_20{
	replace `x' = 0 if interview_ID == "74ac1b56-86c2-4946-86a3-1b850eeeed35"
}

replace letter_knowledge_wfnum_att = 20 if interview_ID == "74ac1b56-86c2-4946-86a3-1b850eeeed35"
replace letter_knowledge_wfitems_per_min = 11 if interview_ID == "74ac1b56-86c2-4946-86a3-1b850eeeed35"

foreach x in letter_knowledge_wf_B_31	letter_knowledge_wf_B_32	letter_knowledge_wf_B_33	letter_knowledge_wf_B_34	letter_knowledge_wf_B_35	letter_knowledge_wf_B_36{
	replace `x' = 1 if interview_ID == "3f197fd3-1df0-4d5f-abbb-df99f67083ec"
}

replace letter_knowledge_wfnumber_of_ite = 32 if interview_ID == "3f197fd3-1df0-4d5f-abbb-df99f67083ec"
replace letter_knowledge_wfnum_att = 36 if interview_ID == "3f197fd3-1df0-4d5f-abbb-df99f67083ec"
replace letter_knowledge_wfitems_per_min = 32 if interview_ID == "3f197fd3-1df0-4d5f-abbb-df99f67083ec"

replace letter_knowledge_wf_16 =. if interview_ID == "103908ef-ba91-4b6a-8921-9971bf647149"
replace letter_knowledge_wfnumber_of_ite = 3 if interview_ID == "103908ef-ba91-4b6a-8921-9971bf647149"
replace letter_knowledge_wfnum_att = 15 if interview_ID == "103908ef-ba91-4b6a-8921-9971bf647149"
replace letter_knowledge_wfitems_per_min = 4 if interview_ID == "103908ef-ba91-4b6a-8921-9971bf647149"

replace letter_knowledge_fr_20 = 0 if interview_ID == "b4f87406-afd2-40d1-8bba-f3ec88cf4a55"
replace letter_knowledge_fr_12 = 1 if interview_ID == "b4f87406-afd2-40d1-8bba-f3ec88cf4a55"

replace letter_knowledge_fr_12 = 1 if interview_ID == "bd029f92-31a8-4f2b-baa0-36002d217c31"
replace letter_knowledge_fr_20 = 0 if interview_ID == "bd029f92-31a8-4f2b-baa0-36002d217c31"

replace letter_knowledge_fr_10 = 1 if interview_ID == "0f8ff879-aca7-4168-9d16-83b37e608677"
replace letter_knowledge_fr_18 = 0 if interview_ID == "0f8ff879-aca7-4168-9d16-83b37e608677"

foreach x in letter_knowledge_fr_11	letter_knowledge_fr_12	letter_knowledge_fr_13	letter_knowledge_fr_14{
	replace `x' = 1 if interview_ID == "83019b95-ff10-46b5-a59f-348b6d819b43"
}

foreach x in letter_knowledge_fr_15	letter_knowledge_fr_16	letter_knowledge_fr_17	letter_knowledge_fr_18	letter_knowledge_fr_19	letter_knowledge_fr_20{
	replace `x' = 0 if interview_ID == "83019b95-ff10-46b5-a59f-348b6d819b43"
}
									
replace letter_knowledge_frnumber_of_ite = 10 if interview_ID == "83019b95-ff10-46b5-a59f-348b6d819b43"
replace letter_knowledge_frnum_att = 20 if interview_ID == "83019b95-ff10-46b5-a59f-348b6d819b43"
replace letter_knowledge_wfitems_per_min = 10 if interview_ID == "83019b95-ff10-46b5-a59f-348b6d819b43"

foreach x in letter_knowledge_fr_19	letter_knowledge_fr_20{
	replace `x' = 0 if interview_ID == "5c83cb5c-2fbe-498a-9f67-94072021d431"
}

replace letter_knowledge_frnum_att = 20 if interview_ID == "5c83cb5c-2fbe-498a-9f67-94072021d431"

foreach x in letter_knowledge_fr_14	letter_knowledge_fr_15	letter_knowledge_fr_16{
	replace `x' = 0 if interview_ID == "0ed0e89b-99ca-4d19-a536-248a2c971655"
}

foreach x in letter_knowledge_fr_6	letter_knowledge_fr_7	letter_knowledge_fr_8 {
	replace `x' = 1 if interview_ID == "0ed0e89b-99ca-4d19-a536-248a2c971655"
}

replace letter_knowledge_fr_12 = 0 if interview_ID == "9953b512-5f6f-4a91-8e6a-e58fb348bc93"
replace letter_knowledge_fr_4 = 1 if interview_ID == "9953b512-5f6f-4a91-8e6a-e58fb348bc93"

foreach x in letter_knowledge_fr_12	letter_knowledge_fr_13	letter_knowledge_fr_14	letter_knowledge_fr_15{
	replace `x' = 1 if interview_ID == "5c2a2905-8d24-420d-8a50-8031ecf83e0e"
}

foreach x in letter_knowledge_fr_16	letter_knowledge_fr_17	letter_knowledge_fr_18	letter_knowledge_fr_19	letter_knowledge_fr_20{
	replace `x' = 0 if interview_ID == "5c2a2905-8d24-420d-8a50-8031ecf83e0e"
}

replace letter_knowledge_frnumber_of_ite = 7 if interview_ID == "5c2a2905-8d24-420d-8a50-8031ecf83e0e"	
replace letter_knowledge_frnum_att = 20 if interview_ID == "5c2a2905-8d24-420d-8a50-8031ecf83e0e"				

foreach x in letter_knowledge_sr_15	letter_knowledge_sr_16	letter_knowledge_sr_17	letter_knowledge_sr_18	letter_knowledge_sr_19	letter_knowledge_sr_20{
	replace `x' = 0 if interview_ID == "5c2a2905-8d24-420d-8a50-8031ecf83e0e"
}

replace letter_knowledge_srnum_att = 20 if interview_ID == "5c2a2905-8d24-420d-8a50-8031ecf83e0e"

foreach x in letter_knowledge_sr_B_26	letter_knowledge_sr_B_27	letter_knowledge_sr_B_28	letter_knowledge_sr_B_29	letter_knowledge_sr_B_30	letter_knowledge_sr_B_31	letter_knowledge_sr_B_32	letter_knowledge_sr_B_33	letter_knowledge_sr_B_34	letter_knowledge_sr_B_35	letter_knowledge_sr_B_36{
	replace `x' = 1 if interview_ID == "dc237945-7bef-4bb6-ac31-2f0092bab4b4"
}

foreach x in letter_knowledge_sr_B_6	letter_knowledge_sr_B_7	letter_knowledge_sr_B_8	letter_knowledge_sr_B_9	letter_knowledge_sr_B_10	letter_knowledge_sr_B_11	letter_knowledge_sr_B_12	letter_knowledge_sr_B_13	letter_knowledge_sr_B_14	letter_knowledge_sr_B_15	letter_knowledge_sr_B_16	letter_knowledge_sr_B_17	letter_knowledge_sr_B_18	letter_knowledge_sr_B_19	letter_knowledge_sr_B_20	letter_knowledge_sr_B_21	letter_knowledge_sr_B_22	letter_knowledge_sr_B_23	letter_knowledge_sr_B_24	letter_knowledge_sr_B_25	letter_knowledge_sr_B_26	letter_knowledge_sr_B_27	letter_knowledge_sr_B_28	letter_knowledge_sr_B_29	letter_knowledge_sr_B_30	letter_knowledge_sr_B_31	letter_knowledge_sr_B_32	letter_knowledge_sr_B_33	letter_knowledge_sr_B_34	letter_knowledge_sr_B_35	letter_knowledge_sr_B_36{
	replace `x'= 1 if interview_ID == "13edcb48-f3a1-4066-ba2a-7fe3c73f2959"
}
		

foreach x in letter_knowledge_fr_19	letter_knowledge_fr_20{
	replace `x' = 0 if interview_ID == "8b390415-7b64-43e1-9ee1-e67e697b8363"
}
		


foreach x in letter_knowledge_fr_16	letter_knowledge_fr_17	letter_knowledge_fr_18	letter_knowledge_fr_19	letter_knowledge_fr_20{
	replace `x' = 0 if interview_ID == "f925fc1d-0d39-41ac-95d4-93679ff6d84c"
}

replace letter_knowledge_fr_20 = 0 if interview_ID == "3a3a0832-5e45-4ad6-bd05-89dac7be312e"

foreach x in letter_knowledge_fr_13	letter_knowledge_fr_14	letter_knowledge_fr_15	letter_knowledge_fr_16{
	replace `x' = . if interview_ID == "a9a22aea-03d3-4b02-a9b8-1c15b3af14b9"
}

replace letter_knowledge_fr_14 = . if interview_ID == "016eeae1-a795-4405-bb27-4b781052595f"

foreach x in letter_knowledge_wf_B_35	letter_knowledge_wf_B_36{
	replace `x' = 0 if interview_ID == "321720b4-f07d-456e-a814-1c83fd10d396"
}

replace letter_knowledge_sr_10 = . if interview_ID == "eab6ab41-0ea4-4ba1-962f-5e69c884c0a9"
replace letter_knowledge_sr_12 = . if interview_ID == "c13e00e0-9036-46a4-be98-80d9df50bdd1"
replace letter_knowledge_sr_19 = . if interview_ID == "19513c2d-4a84-4a2a-be1f-a2ef023ec8c5"
replace letter_knowledge_sr_18 = . if interview_ID == "19513c2d-4a84-4a2a-be1f-a2ef023ec8c5"
replace letter_knowledge_sr_17 = . if interview_ID == "19513c2d-4a84-4a2a-be1f-a2ef023ec8c5"

foreach x in letter_knowledge_sr_14	letter_knowledge_sr_15	letter_knowledge_sr_16	letter_knowledge_sr_17	letter_knowledge_sr_18	letter_knowledge_sr_19	letter_knowledge_sr_20{
	replace `x' = 0 if interview_ID == "297ad4cd-9734-4d17-9424-ed3fa3594af6"
}
				
foreach x in letter_knowledge_sr_18	letter_knowledge_sr_19	letter_knowledge_sr_20{
	replace `x' = 0 if interview_ID == "a9f3cd1c-abc3-4869-8811-35b13feb0605"
}				
				

foreach x in letter_knowledge_fr_12	letter_knowledge_fr_13	letter_knowledge_fr_14	letter_knowledge_fr_15	letter_knowledge_fr_16{
	replace `x' = . if interview_ID == "eff2f8f1-8eca-4e81-937a-6cb060ad35fe"
}

foreach x in letter_knowledge_wf_17	letter_knowledge_wf_18	letter_knowledge_wf_19	letter_knowledge_wf_20{
	replace `x' = . if interview_ID == "aff6cc3a-5b78-47db-9f6b-131b698f8747"
}

foreach x in letter_knowledge_sr_B_31	letter_knowledge_sr_B_32	letter_knowledge_sr_B_33	letter_knowledge_sr_B_34	letter_knowledge_sr_B_35	letter_knowledge_sr_B_36{
	replace `x' = 1 if interview_ID == "6f05653a-06c3-484e-b644-981d47abd64e"
}

foreach x in letter_knowledge_sr_10	letter_knowledge_sr_11	letter_knowledge_sr_12	letter_knowledge_sr_13	letter_knowledge_sr_14	letter_knowledge_sr_15 letter_knowledge_sr_16{
	replace `x' = . if interview_ID == "0bf6b66e-d8fb-4b93-8823-0f0553372775"
}

foreach x in letter_knowledge_sr_19	letter_knowledge_sr_20{
	replace `x' = . if interview_ID == "e9eaac0c-d21b-429c-ac56-7bb6e280d0f6"
}

foreach x in letter_knowledge_sr_17	letter_knowledge_sr_18	letter_knowledge_sr_19	letter_knowledge_sr_20{
	replace `x' = . if interview_ID == "4bd6ed53-ffbc-4619-b2e1-fde9ea22a61b"
}

foreach x in letter_knowledge_sr_17	letter_knowledge_sr_18	letter_knowledge_sr_19	letter_knowledge_sr_20{
	replace `x' = . if interview_ID == "1f0ed039-51e2-470e-b829-fcbbaa74cf25"
}

foreach x in letter_knowledge_pr_12	letter_knowledge_pr_13	letter_knowledge_pr_14	letter_knowledge_pr_15{
	replace `x' = . if interview_ID == "20c72d9f-b7fb-448e-bb20-fc8806183901"
}

*fr
egen tots = rowtotal(letter_knowledge_fr_1 - letter_knowledge_fr_20)

replace letter_knowledge_frnumber_of_ite = tots if !missing(letter_knowledge_frnumber_of_ite)

egen tots1 = rownonmiss(letter_knowledge_fr_1 - letter_knowledge_fr_20)
replace letter_knowledge_frnum_att = tots1 if !missing(letter_knowledge_frnum_att)

replace letter_knowledge_fritems_per_min = round(60*(letter_knowledge_frnumber_of_ite/(letter_knowledge_frduration-letter_knowledge_frtime_remainin))) if !missing(letter_knowledge_frtime_remainin)

drop tots tots1

egen tots = rowtotal(letter_knowledge_fr_B_1 - letter_knowledge_fr_B_36)

replace letter_knowledge_fr_Bnumber_of_i = tots if !missing(letter_knowledge_fr_Bnumber_of_i)

egen tots1 = rownonmiss(letter_knowledge_fr_B_1 - letter_knowledge_fr_B_36)
replace letter_knowledge_fr_Bnum_att = tots1 if !missing(letter_knowledge_fr_Bnum_att)

replace letter_knowledge_fr_Bitems_per_m = round(60*(letter_knowledge_fr_Bnumber_of_i/(letter_knowledge_fr_Bduration-letter_knowledge_fr_Btime_remain))) if !missing(letter_knowledge_fr_Btime_remain)

drop tots tots1

*wf

egen tots = rowtotal(letter_knowledge_wf_1 - letter_knowledge_wf_20)

replace letter_knowledge_wfnumber_of_ite = tots if !missing(letter_knowledge_wfnumber_of_ite)

egen tots1 = rownonmiss(letter_knowledge_wf_1 - letter_knowledge_wf_20)
replace letter_knowledge_wfnum_att = tots1 if !missing(letter_knowledge_wfnum_att)

replace letter_knowledge_wfitems_per_min = round(60*(letter_knowledge_wfnumber_of_ite/(letter_knowledge_wfduration-letter_knowledge_wftime_remainin))) if !missing(letter_knowledge_wftime_remainin)

drop tots tots1

egen tots = rowtotal(letter_knowledge_wf_B_1 - letter_knowledge_wf_B_36)

replace letter_knowledge_wf_Bnumber_of_i = tots if !missing(letter_knowledge_wf_Bnumber_of_i)

egen tots1 = rownonmiss(letter_knowledge_wf_B_1 - letter_knowledge_wf_B_36)
replace letter_knowledge_wf_Bnum_att = tots1 if !missing(letter_knowledge_wf_Bnum_att)

replace letter_knowledge_wf_Bitems_per_m = round(60*(letter_knowledge_wf_Bnumber_of_i/(letter_knowledge_wf_Bduration-letter_knowledge_wf_Btime_remain))) if !missing(letter_knowledge_wf_Btime_remain)

drop tots tots1

*sr
egen tots = rowtotal(letter_knowledge_sr_1 - letter_knowledge_sr_20)

replace letter_knowledge_srnumber_of_ite = tots if !missing(letter_knowledge_srnumber_of_ite)

egen tots1 = rownonmiss(letter_knowledge_sr_1 - letter_knowledge_sr_20)
replace letter_knowledge_srnum_att = tots1 if !missing(letter_knowledge_srnum_att)

replace letter_knowledge_sritems_per_min = round(60*(letter_knowledge_srnumber_of_ite/(letter_knowledge_srduration-letter_knowledge_srtime_remainin))) if !missing(letter_knowledge_srtime_remainin)

drop tots tots1

egen tots = rowtotal(letter_knowledge_sr_B_1 - letter_knowledge_sr_B_36)

replace letter_knowledge_sr_Bnumber_of_i = tots if !missing(letter_knowledge_sr_Btime_remain)

egen tots1 = rownonmiss(letter_knowledge_sr_B_1 - letter_knowledge_sr_B_36)
replace letter_knowledge_sr_Bnum_att = tots1 if !missing(letter_knowledge_sr_Bnum_att)

replace letter_knowledge_sr_Bitems_per_m = round(60*(letter_knowledge_sr_Bnumber_of_i/(letter_knowledge_sr_Bduration-letter_knowledge_sr_Btime_remain))) if !missing(letter_knowledge_sr_Btime_remain)

drop tots tots1			

*pr
egen tots = rowtotal(letter_knowledge_pr_1 - letter_knowledge_pr_20)

replace letter_knowledge_prnumber_of_ite = tots if !missing(letter_knowledge_prnumber_of_ite)

egen tots1 = rownonmiss(letter_knowledge_pr_1 - letter_knowledge_pr_20)
replace letter_knowledge_prnum_att = tots1 if !missing(letter_knowledge_prnum_att)

replace letter_knowledge_pritems_per_min = round(60*(letter_knowledge_prnumber_of_ite/(letter_knowledge_prduration-letter_knowledge_prtime_remainin))) if !missing(letter_knowledge_prtime_remainin)

drop tots tots1

egen tots = rowtotal(letter_knowledge_pr_B_1 - letter_knowledge_pr_B_36)

replace letter_knowledge_pr_Bnumber_of_i = tots if !missing(letter_knowledge_pr_Btime_remain)

egen tots1 = rownonmiss(letter_knowledge_pr_B_1 - letter_knowledge_pr_B_36)
replace letter_knowledge_pr_Bnum_att = tots1 if !missing(letter_knowledge_pr_Bnum_att)

replace letter_knowledge_pr_Bitems_per_m = round(60*(letter_knowledge_pr_Bnumber_of_i/(letter_knowledge_pr_Bduration-letter_knowledge_pr_Btime_remain))) if !missing(letter_knowledge_pr_Btime_remain)

drop tots tots1

*rename
ren (letter_knowledge_frnumber_of_ite letter_knowledge_fr_Bnumber_of_i letter_knowledge_wfnumber_of_ite letter_knowledge_wf_Bnumber_of_i letter_knowledge_srnumber_of_ite letter_knowledge_sr_Bnumber_of_i letter_knowledge_prnumber_of_ite letter_knowledge_pr_Bnumber_of_i) (letter_knowledge_frnum_corr letter_knowledge_fr_Bnum_corr letter_knowledge_wfnum_corr letter_knowledge_wf_Bnum_corr letter_knowledge_srnum_corr letter_knowledge_sr_Bnum_corr letter_knowledge_prnum_corr letter_knowledge_pr_Bnum_corr)

*Reading Familiar
*fr
drop read_familiar_words_fr_B_16	read_familiar_words_fr_B_17	read_familiar_words_fr_B_18	read_familiar_words_fr_B_19	read_familiar_words_fr_B_20
				
foreach x in read_familiar_words_fr_1	read_familiar_words_fr_2	read_familiar_words_fr_3	read_familiar_words_fr_4	read_familiar_words_fr_5	read_familiar_words_fr_6	read_familiar_words_fr_7	read_familiar_words_fr_8{
	replace `x' = 0 if interview_ID == "8531b91c-31d7-434a-bbf5-de01dd922f1f"
}

replace read_familiar_words_fr_13 = . if interview_ID == "4a7aab47-6fa0-4d04-87dc-3a23946705b9"
replace read_familiar_words_fr_14 = . if interview_ID == "06d394d5-de23-4af0-b8bb-9f7e8890860c"
replace read_familiar_words_fr_15 = . if interview_ID == "b357ca16-5891-494b-981c-07200c5d0908"
foreach x in read_familiar_words_fr_15	read_familiar_words_fr_16	read_familiar_words_fr_17	read_familiar_words_fr_18	read_familiar_words_fr_19{
	replace `x' = . if interview_ID == "4644aea1-f044-4cb4-b79a-638800249e8e"
}

replace read_familiar_words_fr_20 = . if interview_ID == "ddeb78bf-5a97-495a-b6b9-97587ba7210c"
replace read_familiar_words_fr_20 = . if interview_ID == "6d3906b5-2196-4cd2-86a2-fe350906db6f"

foreach x in read_familiar_words_fr_19	read_familiar_words_fr_20{
	replace `x' = 0 if interview_ID == "f481619c-ce36-4071-9723-cdef053c2a1b"
}

foreach x in read_familiar_words_fr_18	read_familiar_words_fr_19	read_familiar_words_fr_20{
	replace `x' = 0 if interview_ID == "cf6b59a7-6ed5-4f0a-83e1-3b6554e76190"
}

foreach x in read_familiar_words_fr_17	read_familiar_words_fr_18	read_familiar_words_fr_19	read_familiar_words_fr_20{
	replace `x' = 0 if interview_ID == "5e1ab6e9-06c6-439c-b861-8fc5bef186e1"
}	

foreach x in read_familiar_words_fr_15	read_familiar_words_fr_16	read_familiar_words_fr_17	read_familiar_words_fr_18	read_familiar_words_fr_19	read_familiar_words_fr_20{
	replace `x' = 0 if interview_ID == "e5ea7c5d-ae9e-408a-b6a3-190a650e4bb4"
}

foreach x in read_familiar_words_fr_13	read_familiar_words_fr_14	read_familiar_words_fr_15	read_familiar_words_fr_16	read_familiar_words_fr_17	read_familiar_words_fr_18	read_familiar_words_fr_19	read_familiar_words_fr_20{
	replace `x' = 0 if interview_ID == "f925fc1d-0d39-41ac-95d4-93679ff6d84c"
}

foreach x in read_familiar_words_fr_11	read_familiar_words_fr_12	read_familiar_words_fr_13	read_familiar_words_fr_14	read_familiar_words_fr_15	read_familiar_words_fr_16	read_familiar_words_fr_17	read_familiar_words_fr_18	read_familiar_words_fr_19	read_familiar_words_fr_20{
	replace `x' = 0 if interview_ID == "5c2a2905-8d24-420d-8a50-8031ecf83e0e"
}

foreach x in read_familiar_words_fr_B_11	read_familiar_words_fr_B_12	read_familiar_words_fr_B_13	read_familiar_words_fr_B_14	read_familiar_words_fr_B_15{
	replace `x' = 0 if inlist(interview_ID,"42ab1e80-ba90-4662-869b-e17299b246db","d0ec1b72-c94a-459c-9e7e-262643185722","9689f590-7d70-4e06-a13d-cc0dd71d3eeb","1d56fc80-0f93-4d3d-b401-393cfaaef250","ccecdd5b-5546-4568-ac8c-ce6ba135389c","9a0ebaef-434f-4cbf-bcfa-9d5df07d9c1c","8177163f-7625-4dbd-809d-b732d2a7e147","8a8259b2-9b58-4c5b-971a-43da419b25d6")
	replace `x' = 0 if inlist(interview_ID,"27c31cfb-fe79-4d9f-93dc-c1d455f2c219","2a739f6e-0d1b-483c-8521-135a7ed503ac","f33e5478-bbdb-43d3-ba0f-23d03414a3a2","9ae1afd4-343c-4676-aaa1-794fcf1401f0")
}

egen tots = rowtotal(read_familiar_words_fr_1 - read_familiar_words_fr_20)

replace read_familiar_words_frnumber_of_ = tots if !missing(read_familiar_words_frnumber_of_)

egen tots1 = rownonmiss(read_familiar_words_fr_1 - read_familiar_words_fr_20)
replace reading_familiar_words_frnum_att = tots1 if !missing(reading_familiar_words_frnum_att)

replace read_familiar_words_fritems_per_ = round(60*(read_familiar_words_frnumber_of_/(read_familiar_words_frduration-read_familiar_words_frtime_remai))) if !missing(read_familiar_words_frtime_remai)

drop tots tots1

egen tots = rowtotal(read_familiar_words_fr_B_1 - read_familiar_words_fr_B_15)

replace read_familiar_words_fr_Bnumber_o = tots if !missing(read_familiar_words_fr_Bnumber_o)

egen tots1 = rownonmiss(read_familiar_words_fr_B_1 - read_familiar_words_fr_B_15)
replace reading_famila_word_fr_Bnum_att = tots1 if !missing(reading_famila_word_fr_Bnum_att)

replace read_familiar_words_fr_Bitems_pe = round(60*(read_familiar_words_fr_Bnumber_o/(read_familiar_words_fr_Bduration-read_familiar_words_fr_Btime_rem))) if !missing(read_familiar_words_fr_Btime_rem)

drop tots tots1

*Wf
replace read_familiar_words_wf_20 = 0 if interview_ID == "e6f2e82d-1582-454b-8f26-b97d0dc342de"
replace read_familiar_words_wf_10 = . if interview_ID == "54a3da50-0c85-4e4d-a48a-c23707890669"
replace read_familiar_words_wf_11 = . if interview_ID == "d1dc00b3-c575-4e71-a3fa-f3b2dc2934dc"

foreach x in read_familiar_words_wf_10	read_familiar_words_wf_11	read_familiar_words_wf_12	read_familiar_words_wf_13{
	replace `x' = . if interview_ID == "fc355bf6-b25a-4cf0-9e92-a866fd8c9cda"
}


egen tots = rowtotal(read_familiar_words_wf_1 - read_familiar_words_wf_20)

replace read_familiar_words_wfnumber_of_ = tots if !missing(read_familiar_words_wfnumber_of_)

egen tots1 = rownonmiss(read_familiar_words_wf_1 - read_familiar_words_wf_20)
replace reading_familiar_words_wfnum_att = tots1 if !missing(reading_familiar_words_wfnum_att)

replace read_familiar_words_wfitems_per_ = round(60*(read_familiar_words_wfnumber_of_/(read_familiar_words_wfduration-read_familiar_words_wftime_remai))) if !missing(read_familiar_words_wftime_remai)

drop tots tots1

*sr
replace read_familiar_words_sr_16 = . if interview_ID == "4d218420-28c0-4260-9745-33c110e10268"
replace read_familiar_words_sr_17 = . if interview_ID == "df4d5ab9-17e0-4ba8-92a4-0c1a5678b5f9"
replace read_familiar_words_sr_20 = . if interview_ID == "ad8ac41d-6e8b-4542-99d3-f90c0ddf6951"
replace read_familiar_words_sr_20 = . if interview_ID == "dd63f6b7-29f6-4fc8-9713-dc4ce9294e0a"
replace read_familiar_words_sr_19 = . if interview_ID == "dd63f6b7-29f6-4fc8-9713-dc4ce9294e0a"

foreach x in read_familiar_words_sr_16	read_familiar_words_sr_17	read_familiar_words_sr_18	read_familiar_words_sr_19	read_familiar_words_sr_20{
	replace `x' = 0 if inlist(interview_ID,"5c2a2905-8d24-420d-8a50-8031ecf83e0e","e5ea7c5d-ae9e-408a-b6a3-190a650e4bb4")
}

replace read_familiar_words_sr_20 = 0 if interview_ID == "5e1ab6e9-06c6-439c-b861-8fc5bef186e1"

egen tots = rowtotal(read_familiar_words_sr_1 - read_familiar_words_sr_20)

replace read_familiar_words_srnumber_of_ = tots if !missing(read_familiar_words_srnumber_of_)

egen tots1 = rownonmiss(read_familiar_words_sr_1 - read_familiar_words_sr_20)
replace reading_familiar_words_srnum_att = tots1 if !missing(reading_familiar_words_srnum_att)

replace read_familiar_words_sritems_per_ = round(60*(read_familiar_words_srnumber_of_/(read_familiar_words_srduration-read_familiar_words_srtime_remai))) if !missing(read_familiar_words_srtime_remai)

drop tots tots1

*pr
replace read_familiar_words_pr_20 = . if interview_ID == "5948ec97-e222-494d-bbc0-438f385e3414"

egen tots = rowtotal(read_familiar_words_pr_1 - read_familiar_words_pr_20)

replace read_familiar_words_prnumber_of_ = tots if !missing(read_familiar_words_prnumber_of_)

egen tots1 = rownonmiss(read_familiar_words_pr_1 - read_familiar_words_pr_20)
replace reading_familiar_words_prnum_att = tots1 if !missing(reading_familiar_words_prnum_att)

replace read_familiar_words_pritems_per_ = round(60*(read_familiar_words_prnumber_of_/(read_familiar_words_prduration-read_familiar_words_prtime_remai))) if !missing(read_familiar_words_prtime_remai)

drop tots tots1

// *rename
ren (read_familiar_words_frnumber_of_ read_familiar_words_fritems_per_ read_familiar_words_fr_Bnumber_o read_familiar_words_fr_Bitems_pe read_familiar_words_wfnumber_of_ read_familiar_words_wfitems_per_ read_familiar_words_wf_Bnumber_o read_familiar_words_wf_Bitems_pe read_familiar_words_srnumber_of_ read_familiar_words_sritems_per_ read_familiar_words_sr_Bnumber_o read_familiar_words_sr_Bitems_pe read_familiar_words_prnumber_of_ read_familiar_words_pritems_per_ read_familiar_words_pr_Bnumber_o read_familiar_words_pr_Bitems_pe read_familiar_words_prtime_remai read_familiar_words_srtime_remai read_familiar_words_wftime_remai read_familiar_words_frtime_remai) (read_familiar_words_frnum_corr read_familiar_words_fr_permin read_familiar_words_fr_Bnum_corr read_familiar_words_fr_B_permin read_familiar_words_wfnum_corr read_familiar_words_wf_permin read_familiar_words_wf_Bnum_corr read_familiar_words_wf_B_permin read_familiar_words_srnum_corr read_familiar_words_sr_permin read_familiar_words_sr_Bnum_corr read_familiar_words_sr_B_permin read_familiar_words_prnum_corr read_familiar_words_pr_permin read_familiar_words_pr_Bnum_corr read_familiar_words_pr_B_permin read_familiar_words_prtime_rem read_familiar_words_srtime_rem read_familiar_words_wftime_rem read_familiar_words_frtime_rem)

*invented words
*fr
replace read_invented_words_fr_12 = . if interview_ID == "a958a897-82f2-4ffb-b404-19d74922ba2c"
replace read_invented_words_fr_13 = . if interview_ID == "0d96f6a7-d43a-41a8-a372-1351ea22b6b6"
replace read_invented_words_fr_14 = . if interview_ID == "bd27d281-449a-4618-821f-cd292ab0ba3c"
replace read_invented_words_fr_15 = . if interview_ID == "0c162021-056f-46dc-bcc8-f90dae15a258"
replace read_invented_words_fr_15 = . if interview_ID == "b109d098-746c-47cf-884f-ed9e2dd05d80"

foreach x in read_invented_words_fr_16	read_invented_words_fr_17{
	replace `x' = . if interview_ID == "73c00981-7704-45c1-a0b1-c68f526a6c20"
}

foreach x in read_invented_words_fr_18	read_invented_words_fr_19	read_invented_words_fr_20{
	replace `x' = . if interview_ID == "de7235b2-a59c-4a25-af2e-e8f5ac991255"
}

replace read_familiar_words_pr_20 = . if interview_ID == "5948ec97-e222-494d-bbc0-438f385e3414"

foreach x in read_invented_words_fr_11	read_invented_words_fr_12	read_invented_words_fr_13	read_invented_words_fr_14	read_invented_words_fr_15	read_invented_words_fr_16	read_invented_words_fr_17	read_invented_words_fr_18{
	replace `x' = 0 if interview_ID == "f925fc1d-0d39-41ac-95d4-93679ff6d84c"
}

foreach x in read_invented_words_fr_12	read_invented_words_fr_13	read_invented_words_fr_14	read_invented_words_fr_15	read_invented_words_fr_16	read_invented_words_fr_17	read_invented_words_fr_18 read_invented_words_fr_19{
	replace `x' = 0 if interview_ID == "5c2a2905-8d24-420d-8a50-8031ecf83e0e"
}

foreach x in read_invented_words_fr_14	read_invented_words_fr_15	read_invented_words_fr_16	read_invented_words_fr_17	read_invented_words_fr_18 read_invented_words_fr_19 read_invented_words_fr_20{
	replace `x' = 0 if inlist(interview_ID,"7e41401a-2629-47d3-989b-331096ec30d2")
}


foreach x in read_invented_words_fr_19 read_invented_words_fr_20{
	replace `x' = 0 if inlist(interview_ID,"cf6b59a7-6ed5-4f0a-83e1-3b6554e76190")
}

foreach x in read_invented_words_fr_16	read_invented_words_fr_17	read_invented_words_fr_18 read_invented_words_fr_19 read_invented_words_fr_20{
	replace `x' = 0 if inlist(interview_ID,"5e1ab6e9-06c6-439c-b861-8fc5bef186e1","e5ea7c5d-ae9e-408a-b6a3-190a650e4bb4")
}

replace read_invented_words_frgridAutoSt = 1 if inlist(interview_ID,"f925fc1d-0d39-41ac-95d4-93679ff6d84c","5c2a2905-8d24-420d-8a50-8031ecf83e0e")

replace read_invented_words_fr_13 = . if interview_ID == "46b2d1b6-7ad7-48ad-862f-c6be59093ca2"

egen tots = rowtotal(read_invented_words_fr_1 - read_invented_words_fr_20)

replace read_invented_words_frnumber_of_ = tots if !missing(read_invented_words_frnumber_of_)

egen tots1 = rownonmiss(read_invented_words_fr_1 - read_invented_words_fr_20)
replace read_invented_words_frnum_att = tots1 if !missing(read_invented_words_frnum_att)

replace read_invented_words_fritems_per_ = round(60*(read_invented_words_frnumber_of_/(read_invented_words_frduration-read_invented_words_frtime_remai))) if !missing(read_invented_words_frtime_remai)

drop tots tots1

*wf
replace read_invented_words_wf_19 = . if inlist(interview_ID,"46b2d1b6-7ad7-48ad-862f-c6be59093ca2","d1dc00b3-c575-4e71-a3fa-f3b2dc2934dc")
replace read_invented_words_wf_20 = . if interview_ID == "a00516de-33bb-4505-a4fd-76a6d98369da"

foreach x in read_invented_words_wf_B_21	read_invented_words_wf_B_22	read_invented_words_wf_B_23	read_invented_words_wf_B_24	read_invented_words_wf_B_25	read_invented_words_wf_B_26	read_invented_words_wf_B_27	read_invented_words_wf_B_28	read_invented_words_wf_B_29	read_invented_words_wf_B_30{
	replace `x' = 0 if inlist(interview_ID,"8177163f-7625-4dbd-809d-b732d2a7e147","ae1ce825-0716-42b8-8df0-f4c03de0b574","b508dc8b-253b-42b1-b88f-435fdbe52869","42ab1e80-ba90-4662-869b-e17299b246db")

}
									

egen tots = rowtotal(read_invented_words_wf_1 - read_invented_words_wf_20)

replace read_invented_words_wfnumber_of_ = tots if !missing(read_invented_words_wfnumber_of_)

egen tots1 = rownonmiss(read_invented_words_wf_1 - read_invented_words_wf_20)
replace read_invented_words_wfnum_att = tots1 if !missing(read_invented_words_wfnum_att)

replace read_invented_words_wfitems_per_ = round(60*(read_invented_words_wfnumber_of_/(read_invented_words_wfduration-read_invented_words_wftime_remai))) if !missing(read_invented_words_wftime_remai)

drop tots tots1

egen tots = rowtotal(read_invented_words_wf_B_1 - read_invented_words_wf_B_30)

replace read_invented_words_wf_Bnumber_o = tots if !missing(read_invented_words_wf_Bnumber_o)

egen tots1 = rownonmiss(read_invented_words_wf_B_1 - read_invented_words_wf_B_30)
replace read_invented_word_wf_Bnum_att = tots1 if !missing(read_invented_word_wf_Bnum_att)

replace read_invented_words_wf_Bitems_pe = round(60*(read_invented_words_wf_Bnumber_o/(read_invented_words_wf_Bduration-read_invented_words_wf_Btime_rem))) if !missing(read_invented_words_wf_Btime_rem)

drop tots tots1

*sr
replace read_invented_words_sr_10 = . if interview_ID =="04019db5-34f1-4ec5-a3e3-34ac4388c46a"

foreach x in read_invented_words_sr_15	read_invented_words_sr_16	read_invented_words_sr_17	read_invented_words_sr_18	read_invented_words_sr_19	read_invented_words_sr_20{
	replace `x' = 0 if interview_ID =="e5ea7c5d-ae9e-408a-b6a3-190a650e4bb4"
}

foreach x in read_invented_words_sr_16	read_invented_words_sr_17	read_invented_words_sr_18	read_invented_words_sr_19	read_invented_words_sr_20{
	replace `x' = 0 if interview_ID =="5e1ab6e9-06c6-439c-b861-8fc5bef186e1"
}				


egen tots = rowtotal(read_invented_words_sr_1 - read_invented_words_sr_20)

replace read_invented_words_srnumber_of_ = tots if !missing(read_invented_words_srnumber_of_)

egen tots1 = rownonmiss(read_invented_words_sr_1 - read_invented_words_sr_20)
replace read_invented_words_srnum_att = tots1 if !missing(read_invented_words_srnum_att)

replace read_invented_words_sritems_per_ = round(60*(read_invented_words_srnumber_of_/(read_invented_words_srduration-read_invented_words_srtime_remai))) if !missing(read_invented_words_srtime_remai)

drop tots tots1

*pr
foreach x in read_invented_words_pr_15	read_invented_words_pr_16	read_invented_words_pr_17	read_invented_words_pr_18	read_invented_words_pr_19	read_invented_words_pr_20{
	replace `x' = 0 if interview_ID == "7e41401a-2629-47d3-989b-331096ec30d2"

}
replace read_invented_words_pr_20 = 0 if interview_ID == "5f727244-96b2-401e-8b19-5a3b5bb464ce"
replace read_invented_words_pr_10 = . if interview_ID == "a958a897-82f2-4ffb-b404-19d74922ba2c"

egen tots = rowtotal(read_invented_words_pr_1 - read_invented_words_pr_20)

replace read_invented_words_prnumber_of_ = tots if !missing(read_invented_words_prnumber_of_)

egen tots1 = rownonmiss(read_invented_words_pr_1 - read_invented_words_pr_20)
replace read_invented_words_prnum_att = tots1 if !missing(read_invented_words_prnum_att)

replace read_invented_words_pritems_per_ = round(60*(read_invented_words_prnumber_of_/(read_invented_words_prduration-read_invented_words_prtime_remai))) if !missing(read_invented_words_prtime_remai)

drop tots tots1

ren (read_invented_words_frtime_remai read_invented_words_frnumber_of_ read_invented_words_fritems_per_ read_invented_words_fr_Bnumber_o read_invented_words_fr_Bitems_pe read_invented_words_wftime_remai read_invented_words_wfnumber_of_ read_invented_words_wfitems_per_ read_invented_words_wf_Bnumber_o read_invented_words_wf_Bitems_pe read_invented_words_srtime_remai read_invented_words_srnumber_of_ read_invented_words_sritems_per_ read_invented_words_sr_Bnumber_o read_invented_words_sr_Bitems_pe read_invented_words_prtime_remai read_invented_words_prnumber_of_ read_invented_words_pritems_per_ read_invented_words_pr_Bnumber_o read_invented_words_pr_Bitems_pe) (read_invented_words_frtime_rem read_invented_words_frnum_corr read_invented_words_fr_permin read_invented_words_fr_Bnum_corr read_invented_words_fr_B_permin read_invented_words_wftime_rem read_invented_words_wfnum_corr read_invented_words_wf_permin read_invented_words_wf_Bnum_corr read_invented_words_wf_B_permin read_invented_words_srtime_rem read_invented_words_srnum_corr read_invented_words_sr_permin read_invented_words_sr_Bnum_corr read_invented_words_sr_B_permin read_invented_words_prtime_rem read_invented_words_prnum_corr read_invented_words_pr_permin read_invented_words_pr_Bnum_corr read_invented_words_pr_B_permin)

replace  read_invented_stop_fr =  read_invented_words_frgridAutoSt

order read_invented_stop_pr,before(read_invented_words_pr_B_1)

*Oral fluency
replace oral_reading_fluency_fr_5 = 1 if interview_ID == "e7cc05fb-fdd9-47f8-aae1-39ca408d019a"
foreach x in oral_reading_fluency_fr_6	oral_reading_fluency_fr_7	oral_reading_fluency_fr_8	oral_reading_fluency_fr_9{
	replace `x' = 0 if interview_ID == "e7cc05fb-fdd9-47f8-aae1-39ca408d019a"
}
				
egen tots = rowtotal(oral_reading_fluency_fr_1 - oral_reading_fluency_fr_43)

replace oral_reading_fluency_frnumber_of = tots if !missing(oral_reading_fluency_frnumber_of)

egen tots1 = rownonmiss(oral_reading_fluency_fr_1 - oral_reading_fluency_fr_43)
replace oral_reading_fluency_frnum_att = tots1 if !missing(oral_reading_fluency_frnum_att)

replace oral_reading_fluency_fritems_per = round(60*(oral_reading_fluency_frnumber_of/(oral_reading_fluency_frduration-oral_reading_fluency_frtime_rema))) if !missing(oral_reading_fluency_frtime_rema)

drop tots tots1

*wf
foreach x in oral_reading_fluency_wf_5	oral_reading_fluency_wf_6	oral_reading_fluency_wf_7	oral_reading_fluency_wf_8	oral_reading_fluency_wf_9{
	replace `x' = 0 if inlist(interview_ID,"987e3c29-0aa1-4a9c-8aac-916cbc79c550","ab219bc7-b750-4c74-bff8-2bb8aca3abef")
}

foreach x in oral_reading_fluency_wf_3	oral_reading_fluency_wf_4	oral_reading_fluency_wf_5	oral_reading_fluency_wf_6	oral_reading_fluency_wf_7	oral_reading_fluency_wf_8	oral_reading_fluency_wf_9{
	replace `x' = 0 if inlist(interview_ID,"e7745731-8ebf-4eeb-8ee6-0cc3f33d7d02")
}

egen tots = rowtotal(oral_reading_fluency_wf_1 - oral_reading_fluency_wf_43)

replace oral_reading_fluency_wfnumber_of = tots if !missing(oral_reading_fluency_wfnumber_of)

egen tots1 = rownonmiss(oral_reading_fluency_wf_1 - oral_reading_fluency_wf_43)
replace oral_reading_fluency_wfnum_att = tots1 if !missing(oral_reading_fluency_wfnum_att)

replace oral_reading_fluency_wfitems_per = round(60*(oral_reading_fluency_wfnumber_of/(oral_reading_fluency_wfduration-oral_reading_fluency_wftime_rema))) if !missing(oral_reading_fluency_wftime_rema)

drop tots tots1

*sr
foreach x in oral_reading_fluency_sr_5	oral_reading_fluency_sr_6	oral_reading_fluency_sr_7	oral_reading_fluency_sr_8	oral_reading_fluency_sr_9{
	replace `x' = 0 if inlist(interview_ID,"18be914a-c4ca-402a-8c5e-219db207aafc")
}

egen tots = rowtotal(oral_reading_fluency_sr_1 - oral_reading_fluency_sr_43)

replace oral_reading_fluency_srnumber_of = tots if !missing(oral_reading_fluency_srnumber_of)

egen tots1 = rownonmiss(oral_reading_fluency_sr_1 - oral_reading_fluency_sr_43)
replace oral_reading_fluency_srnum_att = tots1 if !missing(oral_reading_fluency_srnum_att)

replace oral_reading_fluency_sritems_per = round(60*(oral_reading_fluency_srnumber_of/(oral_reading_fluency_srduration-oral_reading_fluency_srtime_rema))) if !missing(oral_reading_fluency_srtime_rema)

drop tots tots1

*renaming
ren (oral_reading_fluency_prtime_rema oral_reading_fluency_prnumber_of oral_reading_fluency_pritems_per oral_reading_fluency_sritems_per oral_reading_fluency_srnumber_of oral_reading_fluency_srtime_rema oral_reading_fluency_wfitems_per oral_reading_fluency_wfnumber_of oral_reading_fluency_wftime_rema oral_reading_fluency_fritems_per oral_reading_fluency_frnumber_of oral_reading_fluency_frtime_rema) (oral_reading_fluency_prtime_rem oral_reading_fluency_prnum_corr oral_reading_fluency_pr_permin oral_reading_fluency_sr_permin oral_reading_fluency_srnum_corr oral_reading_fluency_srtime_rem oral_reading_fluency_wf_permin oral_reading_fluency_wfnum_corr oral_reading_fluency_wftime_rem oral_reading_fluency_fr_permin oral_reading_fluency_frnum_corr oral_reading_fluency_frtime_rem)

*Reading comprehension
*okay.

*Demographics
replace Groupe = 2 if Ecole == 17

*translators
replace translators = 0
replace translators  = 1 if enumerator_langugae_4 == 0 & official_language == 4
replace translators  = 1 if enumerator_langugae_3 == 0 & official_language == 3
replace translators  = 1 if enumerator_langugae_2 == 0 & official_language == 2
replace translators  = 1 if enumerator_langugae_1 == 0 & survey_language == 1

destring B3,replace
lab define age 999"Unknown"
lab values B3 age

replace B6_S = trim(strproper(B6_S))
replace B6_S = "Socé" if B6_S == "SocÃ©"
replace B7_S = trim(strproper(B7_S))
replace languages_spoken_S1 = trim(strproper(languages_spoken_S1))
replace languages_spoken_S1 = "Socé" if languages_spoken_S1 == "SocÃ©"

lab define sema_lan 5"Bambara" 6 "Hassania" 7 "Diola" 8 "Socé",modify

replace semantic_test_language2 = 5 if interview_ID == "24767f56-9002-4914-97f0-f01eaf51e2c4"

destring semantic_language_timer2duration semantic_language_timer1duration,replace

replace semantic_test_language3 =5 if interview_ID == "9f04ec82-5b08-4646-b1cf-a21cb6a6dad1"
replace semantic_test_language3 =5 if interview_ID == "b14c7f78-4875-4073-8c5a-490d4a7fbade"
replace semantic_test_language3 =5 if interview_ID == "90c70ca3-899b-4009-aced-bbe64dbdc55b"
replace semantic_test_language3 =5 if interview_ID == "e37e31ff-971c-4cc3-ae27-538080cbc069"
replace semantic_test_language3 =5 if interview_ID == "ff70233f-5294-4948-af54-d001d5bb26d2"
replace semantic_test_language3 =5 if interview_ID == "7ec5527d-a4cb-4091-9a78-cbaafb13a9f1"
replace semantic_test_language3 =5 if interview_ID == "21fe13d4-aa5d-4d75-a8b8-89938f7aeaa0"
replace semantic_test_language3 =5 if interview_ID == "41589498-bc0a-4ccd-8d6a-a60de062d072"
replace semantic_test_language3 =5 if interview_ID == "d9c058a2-f459-416c-b9f0-534f64f9b7d4"
replace semantic_test_language3 =5 if interview_ID == "3122f87b-bf1b-4c4f-a07e-2e891b814b4c"
replace semantic_test_language3 =5 if interview_ID == "efad7096-ad35-4f09-9e74-9db263fc6c25"
replace semantic_test_language3 =5 if interview_ID == "a2eaf066-d08a-4066-a261-da62c4107f08"
replace semantic_test_language3 =5 if interview_ID == "58d76b31-75b1-40ee-8d71-062145fd8fc3"
replace semantic_test_language3 =5 if interview_ID == "1bf20f3c-72c9-40c4-9469-0cd557b03956"
replace semantic_test_language3 =5 if interview_ID == "66143b1b-38bb-4ec4-81aa-758e8f5edf17"
replace semantic_test_language3 =5 if interview_ID == "d0d3be98-c6ea-4d87-879a-fd4d7d3ac419"
replace semantic_test_language3 =5 if interview_ID == "6f13e3d7-c2ed-4750-a156-515989af35bd"
replace semantic_test_language3 =6 if interview_ID == "569e513e-88a5-4a78-9eae-339ee0fa17f2"
replace semantic_test_language3 =6 if interview_ID == "284166c3-ffda-436a-9335-d4f2e1530693"
replace semantic_test_language3 =6 if interview_ID == "75886d6f-abcc-466f-b3ae-82a162a946ac"
replace semantic_test_language3 =7 if interview_ID == "e9792b8a-09cf-4ef2-b478-30b3ee858fc9"
replace semantic_test_language3 =8 if interview_ID == "644488fd-d186-45a2-82ec-ad0e5603720a"

replace languages_spoken_S1 ="Hassania" if interview_ID == "569e513e-88a5-4a78-9eae-339ee0fa17f2"
replace languages_spoken_S1 ="Hassania" if interview_ID == "284166c3-ffda-436a-9335-d4f2e1530693"
replace languages_spoken_S1 ="Hassania" if interview_ID == "75886d6f-abcc-466f-b3ae-82a162a946ac"
replace languages_spoken_S1 ="Diola" if interview_ID == "e9792b8a-09cf-4ef2-b478-30b3ee858fc9"
replace languages_spoken_S1 ="Socé" if interview_ID == "644488fd-d186-45a2-82ec-ad0e5603720a"

replace semantic_test_language4 = 8 if interview_ID == "24b7ec03-358c-4ac7-af7f-32137d492cb2"

*MATHEMATICS SECTIONS
*identifying_numbers
foreach x in identifying_numbers_grid_2_1	identifying_numbers_grid_2_2	identifying_numbers_grid_2_3	identifying_numbers_grid_2_4	identifying_numbers_grid_2_5	identifying_numbers_grid_2_6	identifying_numbers_grid_2_7	identifying_numbers_grid_2_8	identify_numbers_grid_2num_corr{
	replace `x' = . if identify_numbers_grid_1num_corr < 4
}
								
foreach x in identifying_numbers_grid_3_1	identifying_numbers_grid_3_2	identifying_numbers_grid_3_3	identifying_numbers_grid_3_4	identify_numbers_grid_3num_corr{
	replace `x' = . if identify_numbers_grid_2num_corr < 4
}

*counting
egen counting_score = rowtotal(counting_1 - counting_6) if !missing(counting_1)
order counting_score,after(counting_6)

egen tots1 = rowtotal(identifying_numbers_grid_3_1 - identifying_numbers_grid_3_4)
replace identify_numbers_grid_3num_corr = tots1 if !missing(identifying_numbers_grid_3_4)
drop tots1

*discrimination
foreach x in digital_discrimination_grid_2_1	digital_discrimination_grid_2_2	digital_discrimination_grid_2_3	digital_discrimination_grid_2_4	digital_discrimination_2num_corr{
	replace `x' = . if digital_discrimination_1num_corr < 2
}

foreach x in digital_discrimination_grid_3_1	digital_discrimination_grid_3_2	digital_discrimination_3num_corr{
	replace `x' = . if digital_discrimination_2num_corr < 2 | digital_discrimination_2num_corr == .
}

*missing
foreach x in missing_number_grid_2_1	missing_number_grid_2_2	missing_number_grid_2_3	missing_number_grid_2_4	missing_number_2num_corr{
	replace `x' = . if missing_number_1num_corr < 2 | missing_number_1num_corr == .
}

*decimal
foreach x in decimal_system_grid_2_1	decimal_system_grid_2_2	decimal_system_grid_2_3	decimal_system_grid_2_4	decimal_system_2num_corr{
	replace `x' = . if decimal_system_1num_corr < 2 | decimal_system_1num_corr == .
}

foreach x in decimal_system_grid_3_1	decimal_system_grid_3_2	decimal_system_3num_corr{
	replace `x' = . if decimal_system_2num_corr < 2 | decimal_system_2num_corr == .
}

*Addition
replace addition_subtraction_3 = . if addition_subtraction_1 == 2 & addition_subtraction_2 == 2

*word
replace word_addition_subtraction_3 = . if word_addition_subtraction_1 ==2 & word_addition_subtraction_2 == 3
replace word_addition_subtraction_4 = . if word_addition_subtraction_1 ==2 & word_addition_subtraction_2 == 3

*position
egen position_tracking_score = rowtotal(position_tracking_1 - position_tracking_6) if !missing(position_tracking_1)

order position_tracking_score,after(position_tracking_6)

*Language spoken
replace B7_4 = 1 if languages_spoken_4 == 1 & B7_4 == 0 & B6_4 == 0
replace B7_3 = 1 if languages_spoken_3 == 1 & B7_3 == 0 & B6_3 == 0
replace B6_2 = 1 if languages_spoken_2 == 1 & B7_2 == 0 & B6_2 == 0
replace B6_1 = 1 if languages_spoken_1 == 1 & B7_1 == 0 & B6_1 == 0
replace B6_S = languages_spoken_S1 if !missing(languages_spoken_S1)

*Teaching
replace teaching_language = 3 if interview_ID =="e9acb732-0e86-4c23-a4ab-b1fd28bb32b4"
replace teaching_language = 3 if interview_ID =="3a64ac6c-1dd1-490e-a6f5-d6509f56bcad"
replace teaching_language = 3 if interview_ID =="a45cd6b0-302a-47c6-8ac0-24f9949d65b4"
replace teaching_language = 3 if interview_ID =="28d6e665-18e3-496c-84bd-57f5ae998d08"
replace teaching_language = 3 if interview_ID =="6deb405f-a52e-4547-8927-1d9789a58eba"
replace teaching_language = 3 if interview_ID =="f33fd61f-2d41-4ebc-a7e5-d48c2bc8643d"
replace teaching_language = 3 if interview_ID =="021c7c83-722d-4818-a494-ab5274360532"
replace teaching_language = 3 if interview_ID =="30fa5a12-e59c-451d-a044-61740aa65669"
replace teaching_language = 3 if interview_ID =="c7aeb8c7-81c8-4f3f-8584-421e61eb4dc3"
replace teaching_language = 3 if interview_ID =="7331cb1f-6e5b-41dd-bedc-78cf73d94357"
replace teaching_language = 3 if interview_ID =="a69faeaf-9aa1-4e50-a309-13c75bcb7da1"
replace teaching_language = 3 if interview_ID =="ae264f26-2482-435a-ab2b-7f496a34d19c"
replace teaching_language = 3 if interview_ID =="acfd0e15-e404-4719-a042-b32fb68e29b1"
replace teaching_language = 3 if interview_ID =="185d6153-3b11-415d-a696-6b48de7c4fb7"
replace teaching_language = 3 if interview_ID =="987c1aba-d5ae-4fc1-b977-11d61c1accc2"
replace teaching_language = 3 if interview_ID =="91fd21c5-3d48-456a-b33e-9ccc1199647b"
replace teaching_language = 3 if interview_ID =="b4318f26-486e-4833-bc9b-e6e03a6387f6"
replace teaching_language = 3 if interview_ID =="e23bc4d0-8eaf-4b1f-910a-98c0b0386594"
replace teaching_language = 3 if interview_ID =="45451da8-6aea-4ccd-a668-fcf6fcca1084"
replace teaching_language = 3 if interview_ID =="d171cc2c-40d1-462e-8531-23811ab76b1d"
replace teaching_language = 3 if interview_ID =="fac45cb0-0101-475c-a7a8-432678d7643d"
replace teaching_language = 3 if interview_ID =="e6b11413-be62-4251-b8f2-5fc228f303d5"
replace teaching_language = 3 if interview_ID =="827ab6a2-6ab0-44b8-8926-42b61b393e58"
replace teaching_language = 3 if interview_ID =="d6b9c0c5-667b-4f6b-9f41-301b44cdada0"
replace teaching_language = 3 if interview_ID =="3506df89-9581-4a5b-ac89-fb274d49d350"
replace teaching_language = 3 if interview_ID =="f8c76f65-4374-4512-b93a-728ed6e9c7ae"
replace teaching_language = 3 if interview_ID =="dbe08ef8-79d1-4966-b423-c8df4ea4acbf"
replace teaching_language = 3 if interview_ID =="ed131b98-c787-4c82-882c-1d2796ab369a"
replace teaching_language = 3 if interview_ID =="e5ea7c5d-ae9e-408a-b6a3-190a650e4bb4"
replace teaching_language = 3 if interview_ID =="ceb56aff-c84a-48f1-8fb5-28aa6a4a7408"
replace teaching_language = 3 if interview_ID =="df4d5ab9-17e0-4ba8-92a4-0c1a5678b5f9"
replace teaching_language = 3 if interview_ID =="58e215ac-afef-42d9-8cb7-7e6bdefb9d62"
replace teaching_language = 1 if interview_ID =="0a0bac0b-7fee-4684-bd91-88a4b9034726"
replace teaching_language = 1 if interview_ID =="6bfd7f9f-8346-4772-b4e4-85b95389bea6"
replace teaching_language = 1 if interview_ID =="d03e46ec-dd62-4a81-b2c3-7594ec03ff79"
replace teaching_language = 3 if interview_ID =="196aa4be-9aac-4248-b02e-de881f76db71"
replace teaching_language = 3 if interview_ID =="b4918c03-457a-44b9-a048-aa68b8846e21"
replace teaching_language = 3 if interview_ID =="ac518c97-0e79-4799-89cb-51f1acc52413"
replace teaching_language = 3 if interview_ID =="c13e00e0-9036-46a4-be98-80d9df50bdd1"
replace teaching_language = 3 if interview_ID =="1c99fea7-31d3-4fbe-9949-e030e0c2fe22"
replace teaching_language = 3 if interview_ID =="c2bfffc5-9f55-416f-a8b4-01fe9b77ba4c"
replace teaching_language = 3 if interview_ID =="85bc6364-0680-4751-86cd-ee3fda033816"
replace teaching_language = 3 if interview_ID =="6860cd27-31b9-4c21-a54c-0d0fd8f8209d"
replace teaching_language = 3 if interview_ID =="20d2bb4a-d1ab-46e9-bf57-70c07c123719"
replace teaching_language = 3 if interview_ID =="b27b2164-9414-41ed-ad4c-6ad383f86e44"
replace teaching_language = 3 if interview_ID =="f9c51d62-9d83-492a-90d2-a376ba12b8a6"
replace teaching_language = 3 if interview_ID =="90e20319-9fc1-4c08-a9b9-3f851839aded"
replace teaching_language = 3 if interview_ID =="fa7c730e-4e47-4e56-9adf-331a3dbce907"
replace teaching_language = 3 if interview_ID =="952690be-cd52-4bc5-ad46-62bf83c09b3a"
replace teaching_language = 3 if interview_ID =="371e0e95-b6f3-4517-9852-942506c8e086"
replace teaching_language = 1 if interview_ID =="c905025e-4182-40be-831f-b476507dfa77"
replace teaching_language = 1 if interview_ID =="24e563f4-7d09-4d17-8169-d8814d697ffb"
replace teaching_language = 1 if interview_ID =="57e40005-7add-4dd2-bb9d-5759c2981aa1"
replace teaching_language = 1 if interview_ID =="d988403c-a0a2-44eb-86f0-2de65ce7db54"
replace teaching_language = 1 if interview_ID =="9bbde13b-062c-4f07-8cc5-7561b17a480d"
replace teaching_language = 1 if interview_ID =="189318b4-6126-40eb-bbcd-da310507f175"
replace teaching_language = 1 if interview_ID =="e331d060-57d1-41a4-8848-e2f62d57ae65"
replace teaching_language = 1 if interview_ID =="764eaee0-b5be-4432-874b-69b1261cc181"
replace teaching_language = 1 if interview_ID =="3c155564-2174-4b0f-8542-ce0c061257eb"
replace teaching_language = 1 if interview_ID =="0603e745-4755-4735-ab8b-81a7133999a8"
replace teaching_language = 1 if interview_ID =="54045343-38e8-4bc7-aa0c-b56350f62bfc"
replace teaching_language = 1 if interview_ID =="56bb62c2-a467-4786-8eef-bfe55ba3ba9b"
replace teaching_language = 1 if interview_ID =="ffa369ac-4283-4a90-98fc-8846a6c6fb4e"
replace teaching_language = 1 if interview_ID =="2166db2f-c8b8-4a12-898e-8296e1b10890"
replace teaching_language = 1 if interview_ID =="840d9ee5-ca5a-43f6-a855-9257880755da"
replace teaching_language = 1 if interview_ID =="a86a2cd3-f0b6-4a89-91e5-25c1db9a269d"
replace teaching_language = 1 if interview_ID =="f9a21cb3-0622-4552-a3ca-975394b9ca03"
replace teaching_language = 1 if interview_ID =="48422b8d-42ad-4294-95f3-7bb2d2701d36"
replace teaching_language = 3 if interview_ID =="07992024-d430-448d-a01c-16a3debbd989"
replace teaching_language = 3 if interview_ID =="3de51b30-9e62-4f30-a6bd-e8ee1f24fe1c"
replace teaching_language = 3 if interview_ID =="d2ac7566-d4a9-4626-996e-0902ed267ad9"
replace teaching_language = 3 if interview_ID =="dd83c2af-621f-4cf2-9f4f-b02fe26014be"
replace teaching_language = 3 if interview_ID =="83fc7080-1015-4fd5-ae9e-776ced4f88fc"
replace teaching_language = 3 if interview_ID =="2c6d8655-7375-4000-a3a1-fbc5a851bec9"
replace teaching_language = 3 if interview_ID =="6b5fcd78-99ad-4bf4-b6ca-6275e6d8589c"
replace teaching_language = 3 if interview_ID =="11cc25b3-0385-4f11-9702-875c0481d8c6"
replace teaching_language = 3 if interview_ID =="11a32762-88c6-4c27-8411-73d99b4eb5c6"
replace teaching_language = 3 if interview_ID =="76d10f7f-19c1-4ad5-a7c4-63f0ca39d589"
replace teaching_language = 3 if interview_ID =="87626f23-a1f2-42f4-bdb0-7f2dc82b8de9"
replace teaching_language = 3 if interview_ID =="7b76380f-b11a-4e9b-b9f3-752e99fa3e4d"
replace teaching_language = 3 if interview_ID =="8d6bc2e6-75e0-4587-8a08-e31b5e4f22c0"
replace teaching_language = 3 if interview_ID =="c78b7181-f44e-49f6-a54e-118a296e60f4"
replace teaching_language = 3 if interview_ID =="1ceb8c8c-cc27-4c65-9883-827f4a6e8c34"
replace teaching_language = 1 if interview_ID =="db8d4dac-98e4-465c-841c-74770857a598"
replace teaching_language = 1 if interview_ID =="d2ebbbaf-7eca-4065-bf58-d0a1220a3755"
replace teaching_language = 1 if interview_ID =="ba040111-7188-4a22-9c83-4df2b878d9f6"
replace teaching_language = 1 if interview_ID =="94c198f1-b78f-490a-954d-29b1952e0242"
replace teaching_language = 1 if interview_ID =="b4616e7e-c830-4f05-8a3c-26000e3d9811"
replace teaching_language = 1 if interview_ID =="cf63d421-998d-40e4-b7c8-355394f8ba07"
replace teaching_language = 1 if interview_ID =="a415caf2-d03d-4f4f-883d-6916336f997e"
replace teaching_language = 1 if interview_ID =="fc400068-b818-4fef-807b-bcb329d7df47"
replace teaching_language = 1 if interview_ID =="47666102-d07b-4124-9f18-3e70cec3d3e5"
replace teaching_language = 1 if interview_ID =="d430e97b-c5d3-43a4-9148-afeb9f16f6e8"
replace teaching_language = 1 if interview_ID =="9581fd9d-a2b2-4e67-9440-40a7995440c3"
replace teaching_language = 1 if interview_ID =="d8b86387-0a8f-4b75-af41-edc05d67a860"
replace teaching_language = 1 if interview_ID =="7c68fed5-4e50-4ce2-b2e6-2818b9231542"
replace teaching_language = 1 if interview_ID =="9e0bd3c0-34d6-47b7-b71b-deb862fbab15"
replace teaching_language = 1 if interview_ID =="8621eacf-4963-4195-be37-69b2f4f46767"
replace teaching_language = 1 if interview_ID =="04258a37-5377-4cd2-9115-d1bc1bb3e05e"
replace teaching_language = 1 if interview_ID =="e37e31ff-971c-4cc3-ae27-538080cbc069"
replace teaching_language = 1 if interview_ID =="b25b96b2-88b7-4a6d-99a2-97f8920b5fac"
replace teaching_language = 3 if interview_ID =="926162f4-8934-4d79-bcf3-9be8cc5170a1"
replace teaching_language = 3 if interview_ID =="c52e24d2-2947-454a-9d18-41c036731cd8"
replace teaching_language = 3 if interview_ID =="f31151cf-9dda-4297-a7cb-8535d306ac13"
replace teaching_language = 3 if interview_ID =="2c4810e4-4b7f-4d2d-a3a3-2c1788588552"
replace teaching_language = 3 if interview_ID =="3e75ddf9-aacd-42a7-8d95-b296111f879e"
replace teaching_language = 3 if interview_ID =="27f4bbb1-72b0-4677-a0bb-142edf807ed8"
replace teaching_language = 3 if interview_ID =="4626a9bd-14c6-4cd0-bda4-84a1d3b0cdbb"
replace teaching_language = 3 if interview_ID =="c2efa10a-4aa5-444a-b5a7-252f92b46613"
replace teaching_language = 3 if interview_ID =="5bce8d17-47db-42f1-b730-cf803f338116"
replace teaching_language = 3 if interview_ID =="b0b19fae-a5ed-4551-b20e-bcfab266a6da"
replace teaching_language = 3 if interview_ID =="644488fd-d186-45a2-82ec-ad0e5603720a"
replace teaching_language = 3 if interview_ID =="05fb38f7-fb19-4eef-b05f-eea8b33546e7"
replace teaching_language = 3 if interview_ID =="3d73ee77-9e4d-4b03-a13f-891f67cadd9a"
replace teaching_language = 3 if interview_ID =="d00af9de-f156-4aab-b9dc-43c6cd1ed226"
replace teaching_language = 3 if interview_ID =="dd3dc528-ab26-458c-b899-5e5c67456c7b"
replace teaching_language = 3 if interview_ID =="a3061344-71ff-4647-a3d8-ce64aa26855f"
replace teaching_language = 3 if interview_ID =="2b273a2c-4a80-4ab9-a414-0d17bf1383da"
replace teaching_language = 3 if interview_ID =="e38be73d-9cfa-4929-b415-d349e46e50cf"
replace teaching_language = 3 if interview_ID =="8f4d56a7-9e63-4598-abcf-e18a7fe7a912"
replace teaching_language = 3 if interview_ID =="5bf46475-9bde-473d-9fbb-de4437f4a567"
replace teaching_language = 3 if interview_ID =="adbb1f3e-2315-4e4c-a85a-b84d49359b3b"
replace teaching_language = 3 if interview_ID =="b6828548-ca8c-4d29-ae1a-7907eb5a9024"
replace teaching_language = 3 if interview_ID =="5e1ab6e9-06c6-439c-b861-8fc5bef186e1"
replace teaching_language = 3 if interview_ID =="041d20a7-7876-4637-85cb-306266d0a25f"
replace teaching_language = 3 if interview_ID =="90a98560-f263-4117-8c6f-a144e97bcd7d"
replace teaching_language = 3 if interview_ID =="578415c0-1f18-4233-9779-5b3289ed4f2c"
replace teaching_language = 3 if interview_ID =="842da73e-0151-4c8c-abbd-4e58b98c9d44"
replace teaching_language = 3 if interview_ID =="a0840150-b6b9-450d-9a1e-b2dea83752fa"
replace teaching_language = 3 if interview_ID =="8466ba38-fcc1-43ca-a8e9-05b223e5cd2b"
replace teaching_language = 3 if interview_ID =="d59de60d-2d39-49b8-b916-fa8e35b667bc"
replace teaching_language = 1 if interview_ID =="c0f2bc33-2280-4c33-87fa-0b488a335cc1"
replace teaching_language = 1 if interview_ID =="f9823154-9cec-4010-9f3f-cbac3249bd72"
replace teaching_language = 1 if interview_ID =="3a3a0832-5e45-4ad6-bd05-89dac7be312e"
replace teaching_language = 3 if interview_ID =="83b4c940-2da7-4402-bf33-4080d59686e8"
replace teaching_language = 3 if interview_ID =="5dfaa279-7471-4f38-8a3d-c092704074ba"
replace teaching_language = 3 if interview_ID =="1a9d35fc-4c35-4da5-bd70-059e8c482cf9"
replace teaching_language = 3 if interview_ID =="e26d6913-3504-4c7d-b9e0-666838d32467"
replace teaching_language = 3 if interview_ID =="a638d656-dcf4-4997-bb1d-58dc0a747fe9"
replace teaching_language = 3 if interview_ID =="cc26262b-7c7d-4b99-a608-8ac925152497"
replace teaching_language = 3 if interview_ID =="fd7e52b7-7bb2-4ef3-85fe-f941f63bd42e"
replace teaching_language = 3 if interview_ID =="9afaa6c3-4430-4259-a540-ea4db8c6dbdf"
replace teaching_language = 3 if interview_ID =="796e091f-967d-4c49-91d9-e2573c456b33"
replace teaching_language = 3 if interview_ID =="1f7f6b44-ec1e-4910-9965-6da693f59a68"
replace teaching_language = 3 if interview_ID =="f4d41df2-64db-4918-969a-79dc134a9d2f"
replace teaching_language = 3 if interview_ID =="c0cfdfdd-f300-4333-8686-8fe8c953f432"
replace teaching_language = 3 if interview_ID =="d2e3cb34-d0cb-4e00-8c7a-5f245f6ca172"
replace teaching_language = 3 if interview_ID =="754b931b-ece0-41f4-a665-b9019bcc32ca"
replace teaching_language = 3 if interview_ID =="138b651d-60b0-448c-8d16-06db1ac0c2a7"
replace teaching_language = 3 if interview_ID =="cf45a1fa-06ab-42d9-b856-5cad26f13c20"
replace teaching_language = 3 if interview_ID =="0d9a3a74-67d5-4182-ae0e-199bb71b8b05"
replace teaching_language = 3 if interview_ID =="de9a04ad-61ff-4dca-96fe-11636ad44752"
replace teaching_language = 3 if interview_ID =="e7581c97-9182-4dc3-a108-d3a93e6a4991"
replace teaching_language = 3 if interview_ID =="e34d8af4-97e1-4cc7-8b7b-5de024882e50"
replace teaching_language = 3 if interview_ID =="b32f1031-9481-4299-bfa0-60b6ff351b43"
replace teaching_language = 3 if interview_ID =="b8be0be8-2ff5-40c8-b0a6-b97acead26f8"
replace teaching_language = 3 if interview_ID =="211fd7e8-4404-45fc-87a8-0838b52d08a2"
replace teaching_language = 3 if interview_ID =="b5621c75-34c9-45ac-9c3e-636e3827e7c5"
replace teaching_language = 3 if interview_ID =="a0be1398-85c5-4d51-b7b1-a13ffe3ba622"
replace teaching_language = 3 if interview_ID =="dd31bc49-127d-4fe2-b703-187789b91f0a"
replace teaching_language = 3 if interview_ID =="e64ed648-03fa-4819-8e23-661b9e13fbb7"
replace teaching_language = 3 if interview_ID =="c49e70f3-8eca-4f7e-9259-11e0c341ac16"
replace teaching_language = 3 if interview_ID =="11f1ff39-a4ea-48a0-b8a8-cdfe6be80482"
replace teaching_language = 3 if interview_ID =="363ce377-e26c-4aaf-8d8d-cd1958d6f523"
replace teaching_language = 3 if interview_ID =="086c3394-a7df-45b3-8c2e-5473574aae96"
replace teaching_language = 1 if interview_ID =="8269988f-2110-44a4-a57f-199f34260267"
replace teaching_language = 1 if interview_ID =="7a3643cc-50f8-41bd-bc35-42714e02e6d9"
replace teaching_language = 1 if interview_ID =="770feaa2-8f30-4317-879b-b35a080898f0"
replace teaching_language = 3 if interview_ID =="4b0d21a4-e614-4386-b40e-30c6025ad3ee"
replace teaching_language = 3 if interview_ID =="61331070-b9a8-43b4-a8a6-f413343f15da"
replace teaching_language = 3 if interview_ID =="07f17fa3-dd20-4a72-a8d8-6b527b445f97"
replace teaching_language = 3 if interview_ID =="edd8507b-1bc4-4c9f-95a5-ef3e5ecaf4d3"
replace teaching_language = 3 if interview_ID =="ece9ade2-cf6e-4523-8230-3a78c6a70647"
replace teaching_language = 3 if interview_ID =="43a27b4f-6132-4df5-bd6e-f7af3db191e2"
replace teaching_language = 3 if interview_ID =="aca539a0-214b-4fc7-93c5-682d123c63bd"
replace teaching_language = 3 if interview_ID =="ae96cd84-aaf9-41d5-bd4b-0bd5c3ea54d7"
replace teaching_language = 3 if interview_ID =="5b1e52b7-2029-48bf-bfae-70a364085cd0"
replace teaching_language = 3 if interview_ID =="33a7c02b-6eda-4e2e-b021-dcab819f60a2"
replace teaching_language = 3 if interview_ID =="a26868af-f6b8-4de5-8e29-70bc41c3fff8"
replace teaching_language = 3 if interview_ID =="a574cc3e-2957-493a-b60e-036c844cf4e7"
replace teaching_language = 3 if interview_ID =="e0ededb5-13a4-4d1d-baf2-cf9ae96f6300"
replace teaching_language = 3 if interview_ID =="9c98e67e-f2bf-47cf-bcd1-fd12f731ec5a"
replace teaching_language = 3 if interview_ID =="27c0d42e-4fa6-49e3-a2d5-35a7ada411fa"
replace teaching_language = 1 if interview_ID =="1669487b-393e-45e8-a7e4-b266087b8ed6"
replace teaching_language = 1 if interview_ID =="4eb930e6-0f0a-49a9-af46-2d3410846408"
replace teaching_language = 1 if interview_ID =="d4758a16-d8c0-4306-88cd-e126618d1e07"
replace teaching_language = 1 if interview_ID =="bee52567-6a6d-4d1c-a031-39dfde24f298"
replace teaching_language = 1 if interview_ID =="c9efa50e-d6b2-4fee-ab0a-9eb391385bca"
replace teaching_language = 1 if interview_ID =="fcf1d6fe-33e5-4d35-b16b-05e3dccc474b"
replace teaching_language = 1 if interview_ID =="e9dc91bf-47ee-412e-b297-de714e522531"
replace teaching_language = 1 if interview_ID =="50b44f36-640e-47e4-a9e0-13833f797227"
replace teaching_language = 1 if interview_ID =="c1a810b2-7a8e-4e1a-9900-9c34cbbcb95d"
replace teaching_language = 1 if interview_ID =="8558a2fa-f0d6-4c48-9a7b-c359c5ad1f97"
replace teaching_language = 1 if interview_ID =="35c2f886-a1f8-47d0-b2cf-1fa485954735"
replace teaching_language = 1 if interview_ID =="f8f7d052-df34-4e11-bbe6-e4e4787b0739"
replace teaching_language = 1 if interview_ID =="0df49203-ad76-4492-83bb-5e34f74c9a26"
replace teaching_language = 1 if interview_ID =="26b79d94-fc5c-4136-97d3-dffaea376bbc"
replace teaching_language = 1 if interview_ID =="a5ee8c69-307d-4137-9aba-806489aa150e"
replace teaching_language = 1 if interview_ID =="d1a232c0-2bcc-49c4-8b24-2afadabbf5e6"
replace teaching_language = 1 if interview_ID =="fa2832ab-36e7-42cc-8ec5-4329836d48a8"
replace teaching_language = 1 if interview_ID =="a5e23af2-5815-4c0d-895c-4f901e985799"
replace teaching_language = 3 if interview_ID =="7316171a-365c-4f27-bc5c-a2d19739d52a"
replace teaching_language = 3 if interview_ID =="04b68848-1a9a-4f63-8aa0-372601d20b19"
replace teaching_language = 3 if interview_ID =="f9cf514b-0466-4c5c-8127-6b1a3a2d4c59"
replace teaching_language = 3 if interview_ID =="05d139d9-b716-4aca-bd15-344d20781f8d"
replace teaching_language = 3 if interview_ID =="17011753-34e8-4c53-853a-d2cb0f2f83f3"
replace teaching_language = 3 if interview_ID =="4dc7b3e5-f8c8-4a66-9acb-4185ede2c16b"
replace teaching_language = 3 if interview_ID =="87d312cc-e8e9-484f-b63a-50f0a4daec07"
replace teaching_language = 3 if interview_ID =="45cfa74e-4fe0-43ba-9a37-88d61e7610d8"
replace teaching_language = 3 if interview_ID =="24b7ec03-358c-4ac7-af7f-32137d492cb2"
replace teaching_language = 3 if interview_ID =="297ad4cd-9734-4d17-9424-ed3fa3594af6"
replace teaching_language = 3 if interview_ID =="c3b4ea71-c3bc-424a-aa3d-a97c73caf437"
replace teaching_language = 3 if interview_ID =="e7d2062b-da73-425d-8145-2c2b34e5f871"
replace teaching_language = 3 if interview_ID =="9fedd8b1-26d4-4f91-bbc0-dfa887f6c186"
replace teaching_language = 3 if interview_ID =="7035dc1a-f384-48a2-8040-bfd3417f458a"
replace teaching_language = 3 if interview_ID =="426efc5d-8470-4c13-a291-bce911363ea1"
replace teaching_language = 3 if interview_ID =="7f0e472f-7946-44f4-8b11-535c2c87545e"
replace teaching_language = 3 if interview_ID =="2893993b-f640-47c6-9b06-28fb00386987"
replace teaching_language = 3 if interview_ID =="709b61ed-eda6-4e96-95a3-f2dadbc4ff6f"
replace teaching_language = 3 if interview_ID =="03da1bc6-09f3-40b8-bef9-2cbc0d0cca5d"
replace teaching_language = 3 if interview_ID =="16a2a2e2-7692-4df3-a6e0-0b4183b70642"
replace teaching_language = 3 if interview_ID =="5c2a2905-8d24-420d-8a50-8031ecf83e0e"
replace teaching_language = 3 if interview_ID =="b48552c3-08bd-4b63-8e07-8a9b534653fe"
replace teaching_language = 3 if interview_ID =="903bd68a-d26b-491a-94c2-0cf91418cf6d"
replace teaching_language = 3 if interview_ID =="146af2fd-2f60-4d50-aae1-5449c556cd7b"
replace teaching_language = 3 if interview_ID =="5bcc1c7d-0f28-4158-a2df-6ebfff0e3701"
replace teaching_language = 3 if interview_ID =="1d852e1b-7029-450f-937e-09975a21638b"
replace teaching_language = 3 if interview_ID =="3f55022b-b396-4388-8f39-d8f36054d20a"
replace teaching_language = 3 if interview_ID =="04d1d201-dfd2-4a7b-9a58-8902ce9ee60a"
replace teaching_language = 3 if interview_ID =="4963cf77-9f2b-40ed-a8b4-1bb0b7561e25"
replace teaching_language = 3 if interview_ID =="828a231d-8d3b-4515-82f2-4db8720c1887"
replace teaching_language = 1 if interview_ID =="cf6b59a7-6ed5-4f0a-83e1-3b6554e76190"
replace teaching_language = 1 if interview_ID =="f925fc1d-0d39-41ac-95d4-93679ff6d84c"
replace teaching_language = 1 if interview_ID =="be0cd69b-653b-4da4-bfc5-a1d41d6d12e2"
replace teaching_language = 2 if interview_ID =="7c99c318-402d-408e-bb0e-748d3a3378ae"
replace teaching_language = 2 if interview_ID =="a382ae7c-388c-4f1e-b43e-d726c40baa3b"
replace teaching_language = 2 if interview_ID =="ae7b675e-ca64-4f3a-96f1-0a95a68acee7"
replace teaching_language = 2 if interview_ID =="f00fb721-4cf8-413c-bce3-f9104cfa7193"
replace teaching_language = 2 if interview_ID =="b09e6ad7-7935-46a3-b748-b6f52c73c0b3"
replace teaching_language = 2 if interview_ID =="0af61c57-4477-4873-8a87-470f094765f8"
replace teaching_language = 2 if interview_ID =="2bdcb8dc-2a41-455d-8bb2-98cd44badd5d"
replace teaching_language = 2 if interview_ID =="ba8813be-37ab-4a35-a16a-6e257e3633fe"
replace teaching_language = 2 if interview_ID =="cec5317f-1c1c-4591-b1bf-ed85678a6206"
replace teaching_language = 2 if interview_ID =="1870459e-e7c2-47eb-973e-3716d768e7e8"
replace teaching_language = 2 if interview_ID =="fdac54a9-1e29-415f-ad70-9e72623f3ff8"
replace teaching_language = 2 if interview_ID =="9577faa5-296d-4cad-8f46-59b3869914c3"
replace teaching_language = 2 if interview_ID =="728148d2-f3ae-4364-a0d2-c6eb3d4d4c4f"
replace teaching_language = 2 if interview_ID =="fdacd5fe-d5c4-441b-a30a-ac686ee6dc54"
replace teaching_language = 2 if interview_ID =="a3fd0ab2-26f8-4424-a90b-9624b1719f38"
replace teaching_language = 2 if interview_ID =="a208d649-13cf-4550-b8ac-1aa4794fd03c"
replace teaching_language = 2 if interview_ID =="5d659af7-49c5-4f31-8d7e-322d91a18e87"
replace teaching_language = 2 if interview_ID =="a26cf77a-a539-4e23-8f51-3f4cad817ea0"
replace teaching_language = 2 if interview_ID =="d3827e8b-5458-46e5-b397-0b57449d12de"
replace teaching_language = 2 if interview_ID =="534e16e9-10fc-4340-8a2d-0eb48980bd0e"
replace teaching_language = 1 if interview_ID =="ab9fd958-1990-44e2-b223-8a32c4251250"
replace teaching_language = 2 if interview_ID =="1744d7fa-d5a5-4b48-915a-7ae62f7c357a"
replace teaching_language = 2 if interview_ID =="feb4df7e-884d-401f-a40f-6e972f2b1891"
replace teaching_language = 2 if interview_ID =="e2167502-b439-41a1-8b8a-4b35a58b1e77"
replace teaching_language = 2 if interview_ID =="2560f714-9d5c-4ccf-b8ff-8cb999b7fb5a"
replace teaching_language = 2 if interview_ID =="b5f00748-476c-4f6a-b9a6-79d45036aa96"
replace teaching_language = 2 if interview_ID =="3be542ac-14f5-4587-91ba-2cf04e946299"
replace teaching_language = 2 if interview_ID =="39388d42-bc85-4e75-b6ec-7f3c840aec5c"
replace teaching_language = 2 if interview_ID =="32e300eb-252c-4f93-8789-c63654ab68ac"
replace teaching_language = 2 if interview_ID =="cca265fa-b9e1-4c2a-b48e-f818c3c3c796"
replace teaching_language = 1 if interview_ID =="b70d9bd8-930c-433a-b520-49a9a51cc3c0"
replace teaching_language = 1 if interview_ID =="c188c97e-d875-4714-8a78-0515f4dea2c6"
replace teaching_language = 1 if interview_ID =="aa052faa-9568-4509-8f99-edb69f4c9b0b"
replace teaching_language = 3 if interview_ID =="0b5f2b5d-7569-4291-800d-fdae7800cef3"
replace teaching_language = 3 if interview_ID =="15616365-ae70-4b71-a203-0874cd8dbf66"
replace teaching_language = 3 if interview_ID =="e6fb109d-c241-475a-993b-d5e18993f75f"
replace teaching_language = 3 if interview_ID =="5fd218dd-356a-4cb6-8de3-852998b8d10c"
replace teaching_language = 3 if interview_ID =="bf5f7845-5418-435f-bd6b-2433552a35c3"
replace teaching_language = 3 if interview_ID =="581f2a10-bc76-48f2-9349-5c7f21c7af87"
replace teaching_language = 3 if interview_ID =="deca15db-3525-43b6-b3e6-56fef304dc3a"
replace teaching_language = 3 if interview_ID =="cfa966dd-8fe3-45cc-a7b3-b75eea98a48e"
replace teaching_language = 3 if interview_ID =="0ff67ea1-1847-4068-a0d7-1562f8b0e895"
replace teaching_language = 3 if interview_ID =="bb38e98b-b82d-4c4a-ae3b-ebff5e853efa"
replace teaching_language = 3 if interview_ID =="a728f0ed-90ef-48f9-aa70-b304c6955e05"
replace teaching_language = 3 if interview_ID =="007da706-4754-48f2-94a5-61c87b775aaa"
replace teaching_language = 3 if interview_ID =="49041733-6519-4897-8e74-a6773a664c0c"
replace teaching_language = 3 if interview_ID =="0d285ffe-f99e-4fb1-b06b-1dbd87f205a0"
replace teaching_language = 3 if interview_ID =="3ff12f0d-cb08-4a71-97e5-373db188fa1b"
replace teaching_language = 1 if interview_ID =="04188747-378a-4465-b3a2-f5a7e751ec7f"
replace teaching_language = 1 if interview_ID =="817a87c1-b038-4f21-950a-9c39c05ab085"
replace teaching_language = 1 if interview_ID =="cd25d754-c050-4770-a221-8f2c79b61c2d"
replace teaching_language = 1 if interview_ID =="31473fb4-c1d9-43b2-aad4-47cf52b8bd85"
replace teaching_language = 1 if interview_ID =="1b198724-2c86-44b2-93d7-b84f070b7724"
replace teaching_language = 1 if interview_ID =="991c3b30-e187-423d-9ced-3a5813bea805"
replace teaching_language = 1 if interview_ID =="255a8b2c-15fa-4ae7-a0cb-4162c909ae46"
replace teaching_language = 1 if interview_ID =="261789f2-8533-4687-b1e8-c1174f5fabf3"
replace teaching_language = 1 if interview_ID =="d3f2ee2f-755e-4b7c-8541-cd92ae041e6e"
replace teaching_language = 1 if interview_ID =="8106d3e2-4a00-4408-935a-46d70c48a2ed"
replace teaching_language = 1 if interview_ID =="4a4d44d7-3ccd-4c02-89a9-eb20ab5374eb"
replace teaching_language = 1 if interview_ID =="3ea9d43b-c79c-45ba-8cfa-f7d14497beaf"
replace teaching_language = 1 if interview_ID =="61d513e6-9329-4e37-88f9-413de3fa8a46"
replace teaching_language = 1 if interview_ID =="f0aa8ac4-7bee-4f7a-b739-4fe659c8f45d"
replace teaching_language = 1 if interview_ID =="65c6d154-7c51-411f-8450-4773569fef76"
replace teaching_language = 1 if interview_ID =="b1ed57cd-6405-4420-8c86-ffc041d29f3c"
replace teaching_language = 3 if interview_ID =="0ac3348f-874d-41bb-b833-f026c7269f4f"
replace teaching_language = 3 if interview_ID =="4bd6ed53-ffbc-4619-b2e1-fde9ea22a61b"
replace teaching_language = 3 if interview_ID =="7d3cdbb2-7ea8-4ae3-a5c9-f41a305d32fb"
replace teaching_language = 3 if interview_ID =="e299e4e6-c113-4322-abf8-76e5d866e24a"
replace teaching_language = 3 if interview_ID =="204d6cc2-4677-4486-b68e-11dc6017bcd0"
replace teaching_language = 3 if interview_ID =="ef03cf10-ed90-43de-a8ad-e81be208471a"
replace teaching_language = 3 if interview_ID =="99474a0b-c9b9-4d55-9525-cd5d1bf305b8"
replace teaching_language = 3 if interview_ID =="eab6ab41-0ea4-4ba1-962f-5e69c884c0a9"
replace teaching_language = 3 if interview_ID =="d5ce0f5a-f00b-4d86-9557-4fca07a8351c"
replace teaching_language = 3 if interview_ID =="f613af99-d4b5-47be-880b-d8c2368e5f75"
replace teaching_language = 3 if interview_ID =="3e71390d-76e4-411f-8b72-cc21f271817c"
replace teaching_language = 3 if interview_ID =="1c4d83c1-38b5-45f6-814f-eee251013076"
replace teaching_language = 3 if interview_ID =="864493cd-a708-4263-8762-110ce98a08d0"
replace teaching_language = 3 if interview_ID =="3f79901d-2aa4-4e10-804b-dc3ac320090a"
replace teaching_language = 3 if interview_ID =="ee6c043b-611e-4276-8197-42feada4753d"
replace teaching_language = 3 if interview_ID =="23d6f3e6-5359-4e6b-a4c9-69fd71c89aae"
replace teaching_language = 3 if interview_ID =="41ad679b-be65-4b92-8d8f-60d686e0e685"
replace teaching_language = 3 if interview_ID =="016eeae1-a795-4405-bb27-4b781052595f"
replace teaching_language = 3 if interview_ID =="405c2cbf-f0ae-4e5d-9d71-2fe134245fc6"
replace teaching_language = 3 if interview_ID =="82f17526-939c-458e-843d-24ed250fa0a0"
replace teaching_language = 3 if interview_ID =="e24a1993-25c7-46e0-899b-ecd08b0994f6"
replace teaching_language = 3 if interview_ID =="4bde80de-af5a-4faf-b591-3affe1a8bdfb"
replace teaching_language = 3 if interview_ID =="065a2fbe-8808-43ad-9489-dcdcf6ac79ee"
replace teaching_language = 3 if interview_ID =="fcb923aa-73b5-4d00-8302-ef03d5f077e2"
replace teaching_language = 3 if interview_ID =="d0fedad9-2cad-4504-a638-1a42625aecd6"
replace teaching_language = 3 if interview_ID =="76a31c2c-b834-49d7-adba-5cb7063a390f"
replace teaching_language = 3 if interview_ID =="12e532ad-404b-4cbc-830c-78d67428f6af"
replace teaching_language = 3 if interview_ID =="99e42197-a00f-4022-8b65-826959587021"
replace teaching_language = 3 if interview_ID =="dda54887-722f-4e8a-8851-281fc1d3b601"
replace teaching_language = 3 if interview_ID =="42744cab-6549-4fd6-87b5-c69a62de4825"
replace teaching_language = 1 if interview_ID =="b6f9a5d8-944b-47ac-8da0-d96c2bf5350c"
replace teaching_language = 1 if interview_ID =="51713990-31c5-46c3-95d1-f2720f51340a"
replace teaching_language = 1 if interview_ID =="fb0d306c-dbba-48c6-bc4c-6d4e60ecb287"
replace teaching_language = 3 if interview_ID =="da0d585f-c16d-4413-a0b5-8b0146e1e24f"
replace teaching_language = 3 if interview_ID =="5c6328ff-6ba8-4a9b-831f-aedef575c6f5"
replace teaching_language = 3 if interview_ID =="4104a352-3ff5-43dc-8d9c-29d2aa974b02"
replace teaching_language = 3 if interview_ID =="765ea53a-b6fb-48f4-8ed3-43820c959545"
replace teaching_language = 3 if interview_ID =="cd137c71-4e4c-494e-90a8-16a1aae25550"
replace teaching_language = 3 if interview_ID =="ae6b7f4f-a9aa-4ff9-90d3-aac3aef09ee2"
replace teaching_language = 3 if interview_ID =="fcde1c11-e1bd-4d12-beac-ce3a72892e33"
replace teaching_language = 3 if interview_ID =="56a63205-4287-4856-976a-b4c4a251742a"
replace teaching_language = 3 if interview_ID =="0f0cf9ba-567b-4f14-a31d-e94b024b525a"
replace teaching_language = 3 if interview_ID =="4bca1881-f5c5-4acf-85d9-3727ebba2c39"
replace teaching_language = 3 if interview_ID =="4630eb82-b207-4f4a-abb0-dc396a42dc91"
replace teaching_language = 3 if interview_ID =="05a49925-7243-40a8-9d6f-812b31cbafdd"
replace teaching_language = 3 if interview_ID =="065aaf88-1203-403b-ac1a-8a08208299fc"
replace teaching_language = 3 if interview_ID =="338fe80e-8167-4e56-a8f0-807c40cf3860"
replace teaching_language = 3 if interview_ID =="694ca3cc-60ec-41ad-a1c5-67d80e575560"
replace teaching_language = 3 if interview_ID =="9e903394-10d1-4309-942d-ac5bffafa635"
replace teaching_language = 3 if interview_ID =="0e7dedd7-5fef-4a86-9337-fb53d8a61191"
replace teaching_language = 3 if interview_ID =="773d3ca2-e849-4699-820e-304c501e2b73"
replace teaching_language = 3 if interview_ID =="2cc21de9-20e9-42b6-aedb-9259c2384925"
replace teaching_language = 3 if interview_ID =="0b19ad5b-8754-4ef5-8b4d-01bc778b0072"
replace teaching_language = 3 if interview_ID =="2e8718a7-7566-44da-b249-89af4670c79c"
replace teaching_language = 3 if interview_ID =="5add2c07-4080-490f-b63e-c2d3178f304b"
replace teaching_language = 3 if interview_ID =="8fa386a7-f646-4a35-91ec-3c313a37d7c9"
replace teaching_language = 3 if interview_ID =="5e39feca-6643-4c5e-a96a-158220db67b3"
replace teaching_language = 3 if interview_ID =="554867b0-5d95-4831-923a-8cd986659b6b"
replace teaching_language = 3 if interview_ID =="47ad1902-b5eb-4e37-bd3c-bf63d1415e8b"
replace teaching_language = 3 if interview_ID =="b6a94208-d84b-4001-8095-7aeab5199bc4"
replace teaching_language = 3 if interview_ID =="f089d52c-f478-4fa5-9fba-9a9b03da345e"
replace teaching_language = 3 if interview_ID =="c7e0f174-7a51-4988-a68d-77e1992ef692"
replace teaching_language = 3 if interview_ID =="4e50ec10-eca2-4ca0-9fa5-3e0d9ac452fb"
replace teaching_language = 3 if interview_ID =="887dfd8e-d4ef-4914-b51a-743239edbe06"
replace teaching_language = 3 if interview_ID =="96690f79-b002-40b4-9841-4d83f8c45caa"
replace teaching_language = 1 if interview_ID =="1ae31e2b-c77c-4342-8ac4-c54aa83fc07a"
replace teaching_language = 1 if interview_ID =="fa5e59e2-2d87-49b8-af9d-fcbf0f4b23e1"
replace teaching_language = 1 if interview_ID =="a36b3a5f-18d2-41ba-93ce-4e7ba8c351c2"
replace teaching_language = 1 if interview_ID =="bdea7879-9cd7-4c5a-86b5-9b9828d5287e"
replace teaching_language = 3 if interview_ID =="54296630-7def-4963-b0aa-3fb57f4d6599"
replace teaching_language = 3 if interview_ID =="40930127-7a0c-4fd1-a405-79e829a519bf"
replace teaching_language = 3 if interview_ID =="c68e0985-3ea5-450d-99d5-dc4adc1be2fe"
replace teaching_language = 3 if interview_ID =="f6d5a07d-0d19-4411-a497-155614f3e724"
replace teaching_language = 3 if interview_ID =="8c04d224-d20b-4cb8-bb85-9b84534619a6"
replace teaching_language = 3 if interview_ID =="2062d5be-0490-4c08-bec3-4c12d730a853"
replace teaching_language = 3 if interview_ID =="f05cfc06-2792-498e-8dc9-a42f064004d9"
replace teaching_language = 3 if interview_ID =="91ea74b1-588e-4a72-bc2b-e0dcfdfe830a"
replace teaching_language = 3 if interview_ID =="edaaacd5-4c46-4966-8e89-aa32a1e27cf1"
replace teaching_language = 3 if interview_ID =="fc368e48-4c23-4dec-8c58-33e7d3bf1be3"
replace teaching_language = 3 if interview_ID =="7a16ed8b-8ab2-48ec-85e5-da91b712f8fb"
replace teaching_language = 3 if interview_ID =="42358ba1-4c19-4187-b342-5777c8752c5d"
replace teaching_language = 3 if interview_ID =="f95c1561-1d10-4b77-b942-ae94d2a4a754"
replace teaching_language = 3 if interview_ID =="19d857bc-dddc-4022-98d2-71a1079770d3"
replace teaching_language = 3 if interview_ID =="80192859-0182-443d-ae00-52f833e6898c"
replace teaching_language = 3 if interview_ID =="e934dc34-b1e4-448f-9e4d-f2a78a047c3a"
replace teaching_language = 1 if interview_ID =="2b0a9bdd-35e2-4d36-91f6-dd7c0c83112e"
replace teaching_language = 1 if interview_ID =="88147bfb-6289-45b9-80cb-88f0d21b8ee9"
replace teaching_language = 1 if interview_ID =="8cf32f39-bf43-41d4-8c45-dcd343f0ba46"
replace teaching_language = 1 if interview_ID =="04cd8b3a-afcc-4f05-a415-e424ca70fb2b"
replace teaching_language = 3 if interview_ID =="ad8ac41d-6e8b-4542-99d3-f90c0ddf6951"
replace teaching_language = 1 if interview_ID =="938b3ee7-2d2a-4a19-a70a-43aa14b669fe"
replace teaching_language = 1 if interview_ID =="acb5e8e1-be70-4346-a731-5867c42f327a"
replace teaching_language = 1 if interview_ID =="0d77b946-dd6b-4063-8881-f6618aa4ae39"
replace teaching_language = 1 if interview_ID =="11b575ed-75e5-4c16-ba91-e633fff5e625"
replace teaching_language = 1 if interview_ID =="30b5b127-7314-4c00-9cca-c53f63cb8432"
replace teaching_language = 1 if interview_ID =="94b87995-16cf-4103-a6c2-f3f3e1a936d7"
replace teaching_language = 1 if interview_ID =="16f5b2eb-9aaf-45af-bc73-ad5626791bc1"
replace teaching_language = 1 if interview_ID =="152a637b-52f9-4f40-9322-63d346d15bbe"
replace teaching_language = 1 if interview_ID =="2be98656-5f96-40c6-b298-35a9101cebae"
replace teaching_language = 1 if interview_ID =="3cbaacd6-c6a1-4ba1-8a91-eeb9d944217c"
replace teaching_language = 1 if interview_ID =="d3554d76-de3c-4df7-95c7-5d4b480c872d"
replace teaching_language = 1 if interview_ID =="4c833cf3-8f8c-406d-a5ce-6dc5cacf8520"
replace teaching_language = 1 if interview_ID =="76b04df6-432d-4cb9-968f-1580d98f75c9"
replace teaching_language = 3 if interview_ID =="93d82381-7a0e-488f-861a-50308a50c8e9"
replace teaching_language = 3 if interview_ID =="a2f65083-80b8-4914-a38e-1f199e6a4013"
replace teaching_language = 3 if interview_ID =="92f724e7-e785-4652-9844-1590ba68f34f"
replace teaching_language = 3 if interview_ID =="cba56b3a-0c78-48fa-8a48-05598f258226"
replace teaching_language = 3 if interview_ID =="d2e05a7d-9c93-48a4-821d-ef2634c0f33f"
replace teaching_language = 3 if interview_ID =="0cf99da0-4c6c-4edc-8067-5eb9e3d0848e"
replace teaching_language = 3 if interview_ID =="f8b12b04-b9aa-4489-9cee-083efd8d7ce6"
replace teaching_language = 3 if interview_ID =="874e596a-eac9-4bb8-a5f2-084de238a2d2"
replace teaching_language = 3 if interview_ID =="3381df22-0450-45db-a3b6-5b0582b16417"
replace teaching_language = 3 if interview_ID =="c35a5091-bd16-4e12-b6fe-46bfead3cb2e"
replace teaching_language = 3 if interview_ID =="17f6c464-a795-4a9c-84b6-6ce43697c04a"
replace teaching_language = 3 if interview_ID =="127a59af-4ddf-486a-9a03-671daf788d15"
replace teaching_language = 3 if interview_ID =="b5b543f2-47b9-4ae4-8162-22c7d0f40c34"
replace teaching_language = 3 if interview_ID =="f03ff60d-c26a-427f-9bfe-50f23759fb99"
replace teaching_language = 1 if interview_ID =="6fb3f617-586e-4b37-96b4-4ac456fbe7ee"
replace teaching_language = 1 if interview_ID =="6a2eb10d-f264-45a4-ac35-1f2a8e8dbc49"
replace teaching_language = 1 if interview_ID =="ecd46d98-e55d-4871-b411-334df74c605f"
replace teaching_language = 1 if interview_ID =="e2a20481-b960-42de-9d22-9dc83bec503d"
replace teaching_language = 1 if interview_ID =="43411494-2538-40ff-acc7-71264d5510ae"
replace teaching_language = 1 if interview_ID =="4d218420-28c0-4260-9745-33c110e10268"
replace teaching_language = 1 if interview_ID =="845cc896-43b7-453b-b1c7-9e4d336d2ad6"
replace teaching_language = 1 if interview_ID =="6ff0d76c-0d15-4701-88a5-046c0135c708"
replace teaching_language = 1 if interview_ID =="ea9bcf16-8e4d-41bc-b9d8-23e0b85f1b8d"
replace teaching_language = 1 if interview_ID =="dd63f6b7-29f6-4fc8-9713-dc4ce9294e0a"
replace teaching_language = 1 if interview_ID =="5821c53b-c3f6-48ea-9cd6-d60a00106c6e"
replace teaching_language = 1 if interview_ID =="c9cfa38a-decb-4c44-8037-447948813a82"
replace teaching_language = 1 if interview_ID =="a3a305ae-8191-43c3-b7d9-0c88d3c3120a"
replace teaching_language = 1 if interview_ID =="05895e3d-7e7a-42a2-8017-e699efa38470"
replace teaching_language = 1 if interview_ID =="a207a121-fb73-4800-aa3b-71870a610b85"
replace teaching_language = 1 if interview_ID =="35848c87-db55-4013-bd63-ebe9430f87b1"
replace teaching_language = 1 if interview_ID =="f34aa718-727b-4543-bf98-17a97e5ea2c3"
replace teaching_language = 1 if interview_ID =="b2da6eac-83ef-47e1-b340-9d454d62a060"
replace teaching_language = 3 if interview_ID =="a9f3cd1c-abc3-4869-8811-35b13feb0605"
replace teaching_language = 3 if interview_ID =="aa8b05af-06c9-4dc3-986f-1e8e96663bca"
replace teaching_language = 3 if interview_ID =="601ba6f6-04c3-4176-813f-d27d1ff9316c"
replace teaching_language = 3 if interview_ID =="5494cbbe-64e7-4590-9f66-85b551a6ab4d"
replace teaching_language = 3 if interview_ID =="6992a934-41be-416f-87b1-c4f68d18082e"
replace teaching_language = 3 if interview_ID =="6ce1c1bf-26d8-4187-91f0-a6a4ea289d18"
replace teaching_language = 3 if interview_ID =="759c082b-3608-4cef-88c5-4695b8be8a86"
replace teaching_language = 3 if interview_ID =="089a82d9-8b88-4f64-a535-f20037890ae2"
replace teaching_language = 3 if interview_ID =="6db5e79e-4e6e-41ba-897d-a23e300484fb"
replace teaching_language = 3 if interview_ID =="8558485f-9411-4692-b9e7-68f34f0027e7"
replace teaching_language = 3 if interview_ID =="bc993276-73f9-4614-9e3a-25d964e42aac"
replace teaching_language = 3 if interview_ID =="aa63a8b7-09b8-4701-8f98-c778489a821c"
replace teaching_language = 3 if interview_ID =="0d8bf350-582e-46a4-bdcd-b890306a6660"
replace teaching_language = 3 if interview_ID =="147faede-5a31-4660-9f55-fdc579440a2f"
replace teaching_language = 3 if interview_ID =="729f3fc1-ccbc-466c-bca2-5ba3ef703a50"
replace teaching_language = 3 if interview_ID =="413f1a69-d4a4-4a8d-aa28-c8813ec10eaa"
replace teaching_language = 3 if interview_ID =="166413f6-4057-4ae0-9851-1484a505128b"
replace teaching_language = 3 if interview_ID =="a2bf668d-c5a2-49ab-8463-561513e1fa7e"
replace teaching_language = 3 if interview_ID =="f481619c-ce36-4071-9723-cdef053c2a1b"
replace teaching_language = 3 if interview_ID =="099fc059-a232-40d0-9169-74e43e340c44"
replace teaching_language = 3 if interview_ID =="b311e562-a639-4ea6-9ebc-add8b3fe2b49"
replace teaching_language = 3 if interview_ID =="ecafc959-5ca8-4adc-b092-5fb5a9f668c5"
replace teaching_language = 3 if interview_ID =="bb0155ad-ef53-45da-b681-616aca6cbdc7"
replace teaching_language = 3 if interview_ID =="e7062024-7fb3-403e-a14c-005538fc4f31"
replace teaching_language = 3 if interview_ID =="a1a6ae70-c21a-49b8-9dac-a9902b19c993"
replace teaching_language = 3 if interview_ID =="94103181-7f7f-4602-8cf0-34c85bbe0b78"
replace teaching_language = 3 if interview_ID =="a65586cc-28a3-4388-bf30-ec5f80fa23fc"
replace teaching_language = 3 if interview_ID =="a2dd02df-71b2-46f5-86db-8dddf08c5552"
replace teaching_language = 3 if interview_ID =="91de5c9d-0c71-4780-9fd9-8912c527cdcf"
replace teaching_language = 3 if interview_ID =="8531b91c-31d7-434a-bbf5-de01dd922f1f"
replace teaching_language = 1 if interview_ID =="e0de58d3-03c9-4311-9b0d-8b1c63299e95"
replace teaching_language = 1 if interview_ID =="a36f4ed2-53ae-4466-ade2-6e9c4af961cd"
replace teaching_language = 1 if interview_ID =="6184e180-3d1d-46b4-ae23-ef529fa18a22"
replace teaching_language = 3 if interview_ID =="86d156f6-e16f-457e-bbdf-811e9b598bc4"
replace teaching_language = 3 if interview_ID =="5c85bbf5-a4ce-4e4e-b341-3a71b71527a3"
replace teaching_language = 3 if interview_ID =="f20e594c-20ce-4190-b9e3-a70551d61cbe"
replace teaching_language = 3 if interview_ID =="af95046d-7e30-4b1e-8337-8706df700caf"
replace teaching_language = 3 if interview_ID =="83fd6d81-63d3-4a86-9e32-76247f9abb4f"
replace teaching_language = 3 if interview_ID =="5d0b309b-4069-4e98-98c0-180d6ced3496"
replace teaching_language = 3 if interview_ID =="cb788ae0-9d80-4e1d-893c-36d8bf1fab8c"
replace teaching_language = 3 if interview_ID =="f5455c5c-e5e2-40af-9d3b-ab4f16f57144"
replace teaching_language = 3 if interview_ID =="199b12b5-30fd-4a96-8ea7-5dd2a2562174"
replace teaching_language = 3 if interview_ID =="9434bb7a-35ff-4ba0-8ccb-a3757c95002c"
replace teaching_language = 3 if interview_ID =="a9b65579-550e-4814-9cc1-df4fd258852d"
replace teaching_language = 3 if interview_ID =="6ec5cf5f-7e95-406a-a5b3-856276bf173e"
replace teaching_language = 3 if interview_ID =="6f05653a-06c3-484e-b644-981d47abd64e"
replace teaching_language = 3 if interview_ID =="75860c6e-9087-4eb2-b61b-10adeeb7c48b"
replace teaching_language = 3 if interview_ID =="6a2979f1-79f7-42a8-a51f-e4b2e842d5c8"
replace teaching_language = 1 if interview_ID =="1ca30e0d-5be9-43a9-9efe-4fcea1e3ce06"
replace teaching_language = 1 if interview_ID =="ec6c90d7-aff2-432d-b91a-30c74fdac209"
replace teaching_language = 1 if interview_ID =="f1875251-50b7-4296-9c09-175e0aa23296"
replace teaching_language = 1 if interview_ID =="0e053477-a01a-4bd4-b14e-23c08d645f78"
replace teaching_language = 1 if interview_ID =="503806bb-0442-41e5-84a8-c98d8934a9dd"
replace teaching_language = 1 if interview_ID =="1d11b2d4-2273-4d0d-b0d5-a8671cc158e7"
replace teaching_language = 1 if interview_ID =="625937be-1cb5-4683-b187-6be236f8c55e"
replace teaching_language = 1 if interview_ID =="e28498a1-607f-4180-8688-884b3fdef54a"
replace teaching_language = 1 if interview_ID =="732fa026-69f4-4ec0-b484-4e8aac227efe"
replace teaching_language = 1 if interview_ID =="13edcb48-f3a1-4066-ba2a-7fe3c73f2959"
replace teaching_language = 1 if interview_ID =="885708d6-7ddc-4abc-93f7-c4e8190d2dac"
replace teaching_language = 1 if interview_ID =="cc13791d-061b-4ed9-a62f-84b6317d9cf0"
replace teaching_language = 1 if interview_ID =="8f1ada2c-f342-4ef7-97eb-bb482922f080"
replace teaching_language = 1 if interview_ID =="2930cdfe-fadc-4bc1-bb7c-d1df969c6b9f"
replace teaching_language = 1 if interview_ID =="8d049d54-8148-4fac-b27d-d251e0949fa2"
replace teaching_language = 1 if interview_ID =="551a84d9-244a-4a08-b368-d2206d45b0bd"
replace teaching_language = 1 if interview_ID =="5a425119-bb2b-421e-b5c8-bb89e3f6b7b4"
replace teaching_language = 1 if interview_ID =="975499c5-0049-4f50-bb1b-5e4dc0404ec6"
replace teaching_language = 3 if interview_ID =="7ea9712e-a7a0-4af6-9a46-53e67eec9243"
replace teaching_language = 3 if interview_ID =="881eca66-b4fd-4f24-9d25-aba2054722ed"
replace teaching_language = 3 if interview_ID =="1f0ed039-51e2-470e-b829-fcbbaa74cf25"
replace teaching_language = 3 if interview_ID =="2d41d9d7-3abd-4496-a2d0-2327410eb997"
replace teaching_language = 3 if interview_ID =="1a125578-9a56-4bfe-9f51-d5c61b88582c"
replace teaching_language = 3 if interview_ID =="39c57771-66f0-4df9-ab07-f67161eb236d"
replace teaching_language = 3 if interview_ID =="06b13770-4104-48e6-ba17-9b06eb018eb2"
replace teaching_language = 3 if interview_ID =="0e9ba280-1764-4cb2-83b8-66027271ffe9"
replace teaching_language = 3 if interview_ID =="c20fbf6b-6885-4643-aa1e-4e92c470df64"
replace teaching_language = 3 if interview_ID =="0d8d166d-feeb-4f27-8f88-13bb5b82a0bd"
replace teaching_language = 3 if interview_ID =="0cfd66a9-6510-4a2b-aaa4-d2836fbff3a6"
replace teaching_language = 3 if interview_ID =="77d2404c-18c0-4b4b-a7cb-372fc1105dac"
replace teaching_language = 3 if interview_ID =="c141e6fe-9ada-4a17-aa05-8864d872804d"
replace teaching_language = 3 if interview_ID =="c2dc25e4-da8e-4344-aaa3-13caa6ec7fe0"
replace teaching_language = 3 if interview_ID =="2c617cb1-9fc1-4c4f-b756-447d3be621e9"
replace teaching_language = 1 if interview_ID =="1bf20f3c-72c9-40c4-9469-0cd557b03956"
replace teaching_language = 1 if interview_ID =="eb64cf91-c0c1-4013-8061-49ea38f82715"
replace teaching_language = 1 if interview_ID =="14672d22-4778-4ddd-8156-68e113548d3d"
replace teaching_language = 1 if interview_ID =="bdd43171-d377-4dcd-bb2f-12da2e3b00f0"
replace teaching_language = 1 if interview_ID =="ada9b2c1-8175-4aff-ba99-d0ec5e6aa0f7"
replace teaching_language = 1 if interview_ID =="d159c4b4-200d-4164-a16a-d5d4c09c82cd"
replace teaching_language = 1 if interview_ID =="0ed0e89b-99ca-4d19-a536-248a2c971655"
replace teaching_language = 1 if interview_ID =="22fe7924-b0af-4049-8ed8-8c63f259c4c3"
replace teaching_language = 1 if interview_ID =="a366924e-83ee-4b64-b1d4-4ce1915b1236"
replace teaching_language = 1 if interview_ID =="dd15a588-de50-4999-8783-8cced1670d3c"
replace teaching_language = 1 if interview_ID =="d7d00dff-5e0e-471a-bd92-b2d00b1470c2"
replace teaching_language = 1 if interview_ID =="6ff2e454-edd5-4075-acde-66aeb8aae122"
replace teaching_language = 1 if interview_ID =="18645496-fbfb-4681-aea5-81b18ae9e00d"
replace teaching_language = 1 if interview_ID =="25766f80-1338-4686-ac23-9aa83a810ef6"
replace teaching_language = 1 if interview_ID =="62a10f24-7a26-4f14-9c10-a8e2866fe4f1"
replace teaching_language = 1 if interview_ID =="5b85afc2-4ada-48ca-b227-4a3f3823c6e4"
replace teaching_language = 1 if interview_ID =="a4cb6cdb-48f2-4982-be38-3ba4c11b5a41"
replace teaching_language = 1 if interview_ID =="224f3ff8-fdef-43b2-bad3-8768b91b9369"
replace teaching_language = 4 if interview_ID =="7183fd95-fe90-47ab-8130-2a8aa5460802"
replace teaching_language = 4 if interview_ID =="0c173654-0a49-410c-a638-e63921cc4577"
replace teaching_language = 4 if interview_ID =="3df4f11a-06a6-405c-bee1-cb2bf9a5068c"
replace teaching_language = 4 if interview_ID =="d08041ee-96d8-44d0-a3e8-c8536bdff41b"
replace teaching_language = 4 if interview_ID =="4ecbd3bc-1376-4e5f-b42a-9612d7f78112"
replace teaching_language = 4 if interview_ID =="53922b68-5cb7-42cc-8292-5658de74f50a"
replace teaching_language = 4 if interview_ID =="0dacfdcf-c0bc-4414-8746-805a0a07a1a2"
replace teaching_language = 4 if interview_ID =="ca40162a-c1df-4535-8615-1ec454c289e2"
replace teaching_language = 4 if interview_ID =="48765bee-7382-4dc4-a8ad-b043f6e8f2cd"
replace teaching_language = 4 if interview_ID =="9262473b-7b29-4edd-a4ee-0aae3bef517e"
replace teaching_language = 4 if interview_ID =="c8c669af-05e3-4e8f-b574-93b5f383b47b"
replace teaching_language = 4 if interview_ID =="9b9f431d-25d6-498a-9aec-442b33c38002"
replace teaching_language = 4 if interview_ID =="3a563f9e-0c9a-4355-b989-0e812fecb7a3"
replace teaching_language = 4 if interview_ID =="6e827057-5501-4e70-85e3-e3948c1a6dd9"
replace teaching_language = 4 if interview_ID =="5136b684-922f-49d7-b4f3-5e2e773633c7"
replace teaching_language = 4 if interview_ID =="18b0147a-3936-4b70-a157-228cbc569d96"
replace teaching_language = 4 if interview_ID =="c0f2eeba-6677-4d04-a74e-4c6f3c3fc46d"
replace teaching_language = 4 if interview_ID =="9b08b48a-cacd-4878-9711-94b876d7ac52"
replace teaching_language = 4 if interview_ID =="5c7ae7a1-8d95-4468-a06e-f67f919f43a6"
replace teaching_language = 4 if interview_ID =="32347704-d81c-4e2e-bbf8-3b002684271b"
replace teaching_language = 4 if interview_ID =="d5d38bcd-9fde-4930-aaff-1753911fcca8"
replace teaching_language = 4 if interview_ID =="9a07d9d9-e9b8-467e-b22a-b31cbb110b0a"
replace teaching_language = 4 if interview_ID =="d9ed801f-31fc-45b2-b10f-48249f09a52a"
replace teaching_language = 4 if interview_ID =="795e3e03-59cd-4798-9fd5-64b370d25d11"
replace teaching_language = 4 if interview_ID =="4c6b70ab-34b6-45db-8821-063a62965351"
replace teaching_language = 4 if interview_ID =="4e93e87f-edc3-4cac-8bc3-f17acbe9e479"
replace teaching_language = 4 if interview_ID =="0658f402-e5a1-44c8-8f07-b7b378fa2bd6"
replace teaching_language = 4 if interview_ID =="dd98c291-43d0-4946-9124-dea638d44596"
replace teaching_language = 4 if interview_ID =="ae513efd-0ff8-43c3-8a11-918f656c002f"
replace teaching_language = 4 if interview_ID =="6e743c32-be75-4ad1-be91-7ea7358ec0ae"
replace teaching_language = 1 if interview_ID =="06fb6339-f6c5-4134-899c-23317d36e879"
replace teaching_language = 1 if interview_ID =="ac6bd1de-8a68-4829-bdff-cbc1f4296fcc"
replace teaching_language = 1 if interview_ID =="1eb16329-c5e1-4d76-b8ca-f13f6740a130"
replace teaching_language = 4 if interview_ID =="8cf993b8-b752-4c52-ad80-c00f8aea3073"
replace teaching_language = 4 if interview_ID =="b7db9826-8150-4ec6-a5c8-2c0e50058619"
replace teaching_language = 4 if interview_ID =="63238591-89a5-47fb-a9f2-c00541b424fe"
replace teaching_language = 4 if interview_ID =="b69080f8-353e-4cba-bd78-a192362f75d2"
replace teaching_language = 4 if interview_ID =="1d2d305c-3074-41e7-97f4-364601e9496d"
replace teaching_language = 4 if interview_ID =="3fb094cb-d166-4879-b4d8-9fe72496c154"
replace teaching_language = 4 if interview_ID =="24767f56-9002-4914-97f0-f01eaf51e2c4"
replace teaching_language = 4 if interview_ID =="ec476ed7-457b-4929-92f4-a8ab9e050ac5"
replace teaching_language = 4 if interview_ID =="6feed385-4b3a-45f3-9ac6-665707511869"
replace teaching_language = 4 if interview_ID =="f5cf769e-1e60-469f-a558-d9a379bfb2c3"
replace teaching_language = 4 if interview_ID =="39fa5464-8b50-4f99-9f4d-028d9793ab2a"
replace teaching_language = 4 if interview_ID =="f3aafa9b-8b40-4d91-9a11-8a4ba04a8d07"
replace teaching_language = 4 if interview_ID =="7f1516dd-31b9-4745-9073-7374b2a64921"
replace teaching_language = 4 if interview_ID =="f9483987-4664-4f02-beab-58ac3c0c5003"
replace teaching_language = 4 if interview_ID =="432d229c-5b63-4e63-8bee-7ff5c9eb7100"
replace teaching_language = 4 if interview_ID =="6b338573-992f-4f94-9a74-9d96d8f3da08"
replace teaching_language = 4 if interview_ID =="345fc734-03ce-4429-9392-3ceae18eab16"
replace teaching_language = 4 if interview_ID =="126a57d9-2a64-4972-9134-47a860acd248"
replace teaching_language = 4 if interview_ID =="bb16de79-d2a0-4b87-b3ba-0d494bc3bf2e"
replace teaching_language = 4 if interview_ID =="bfe34b7d-f352-4869-a322-525bba5c9b2e"
replace teaching_language = 4 if interview_ID =="25ef728b-3b6e-4a81-a393-aeca4d36404e"
replace teaching_language = 4 if interview_ID =="d1eb7518-69be-4d77-ad12-49479cc690c3"
replace teaching_language = 4 if interview_ID =="622f8ce1-e48f-44c2-ab3a-544ee9fe2139"
replace teaching_language = 4 if interview_ID =="bb3899a2-3c0d-4d2e-868a-33889996bf0f"
replace teaching_language = 4 if interview_ID =="bef77b9b-94af-4920-a5c3-4b90a3fd5c76"
replace teaching_language = 4 if interview_ID =="151c5781-ee1d-4ee5-98eb-fdfcef5d0bfd"
replace teaching_language = 4 if interview_ID =="1a9192ad-2ca2-4ffa-be5e-9ab20c7e9caa"
replace teaching_language = 1 if interview_ID =="642645fe-3920-49ad-b04d-7721d7c03230"
replace teaching_language = 1 if interview_ID =="5b555897-423a-4835-a220-309987cec3f1"
replace teaching_language = 1 if interview_ID =="8eab1d8f-d7b2-4e19-a174-0a3f3b583871"
replace teaching_language = 1 if interview_ID =="4627908c-28ef-43be-aae7-3eb942bb11fc"
replace teaching_language = 3 if interview_ID =="68eb3021-03af-4741-b7ac-22ad4ef0f568"
replace teaching_language = 3 if interview_ID =="090b9158-d427-4856-9cf3-beec47354d2d"
replace teaching_language = 3 if interview_ID =="a6f7672a-4526-48c3-b868-7b3b946a204d"
replace teaching_language = 3 if interview_ID =="c01283f9-d213-4ea0-a22a-fec3a05589c9"
replace teaching_language = 3 if interview_ID =="7cd7e302-e525-4511-95a8-93d2a4b0d7a6"
replace teaching_language = 3 if interview_ID =="b76f6e77-2054-409b-9c96-c9f01394e27e"
replace teaching_language = 3 if interview_ID =="7d9a0607-313d-4307-968c-42e0fa0736ed"
replace teaching_language = 3 if interview_ID =="f387aff0-d066-4ba9-9b1e-556e347178f7"
replace teaching_language = 3 if interview_ID =="afe3e4d0-17d6-4b1b-b0ca-a00acbb80348"
replace teaching_language = 3 if interview_ID =="49e96a47-8eaa-4d0c-8019-45dfc8b18cfe"
replace teaching_language = 3 if interview_ID =="2a7febcd-9c97-4f9a-8597-4bf1fd6ceca6"
replace teaching_language = 3 if interview_ID =="e088d5f3-5411-410d-95b4-3c6b7c89c30d"
replace teaching_language = 3 if interview_ID =="6ea03661-f088-4a1a-ab64-8be8950fdc7a"
replace teaching_language = 3 if interview_ID =="e3a9e1fd-3a11-477a-bae9-1f1ed59f7b31"
replace teaching_language = 3 if interview_ID =="9dff3ae8-b9fe-451c-b3d4-edcbdcb7c633"
replace teaching_language = 3 if interview_ID =="420aa0b0-2a95-445a-9842-a2c1cc7fac6b"
replace teaching_language = 3 if interview_ID =="aff4970e-afe1-4cd8-926b-27a6383cdac9"
replace teaching_language = 3 if interview_ID =="06691d62-7cab-4ca0-a0aa-55f7fbc12867"
replace teaching_language = 3 if interview_ID =="9f4485ba-e1ff-4965-9270-b7bcecd8b13c"
replace teaching_language = 3 if interview_ID =="da59b912-708b-4d22-b7d8-f2fe57b9feaa"
replace teaching_language = 3 if interview_ID =="ec85a16c-b26c-43a6-ad32-273918f28686"
replace teaching_language = 3 if interview_ID =="dc237945-7bef-4bb6-ac31-2f0092bab4b4"
replace teaching_language = 3 if interview_ID =="13165d81-f3c3-4341-b45c-3a6a14bd0974"
replace teaching_language = 3 if interview_ID =="184a0f0c-776b-452d-b6f0-41ce75d4a0c7"
replace teaching_language = 3 if interview_ID =="59b85ddf-63ec-4265-81e6-a804c4fd21e7"
replace teaching_language = 3 if interview_ID =="a07295bf-c64c-4f2a-b136-60e2bc338696"
replace teaching_language = 3 if interview_ID =="be4d5e90-25ce-475b-b8bf-bdac2beaa18a"
replace teaching_language = 3 if interview_ID =="5e33b04c-1075-4ce6-8720-0f9fa5715ae9"
replace teaching_language = 3 if interview_ID =="101fe090-af9d-4869-ae28-442cb9270d98"
replace teaching_language = 3 if interview_ID =="a9a22aea-03d3-4b02-a9b8-1c15b3af14b9"
replace teaching_language = 1 if interview_ID =="0ada33d9-ea04-4d6f-9d0f-21d9883381f8"
replace teaching_language = 1 if interview_ID =="59dbde91-a816-4240-b61a-0c83e967dc7b"
replace teaching_language = 1 if interview_ID =="af771052-6cc1-4b80-b9da-4e4ad39a22ff"
replace teaching_language = 2 if interview_ID =="674117ea-42ca-42c3-9ef8-e3aaec4da256"
replace teaching_language = 2 if interview_ID =="f761942c-005b-4186-a823-907f483d9ea0"
replace teaching_language = 2 if interview_ID =="89136f84-468c-4203-aade-626e72b2798c"
replace teaching_language = 2 if interview_ID =="568d4ae7-f997-42c1-939e-d669faa98a7a"
replace teaching_language = 2 if interview_ID =="9100fee1-e589-422f-9c88-3220235f8b3b"
replace teaching_language = 2 if interview_ID =="5836153d-58b1-41ba-b5cc-7b15104a02bb"
replace teaching_language = 2 if interview_ID =="cceeabe8-442d-40a5-b45f-f6f4619aa2d3"
replace teaching_language = 2 if interview_ID =="3d0afc37-e12c-484d-9bbb-3170215d37bb"
replace teaching_language = 2 if interview_ID =="eba775bd-2d81-4b76-a6a0-074f4ec597ce"
replace teaching_language = 2 if interview_ID =="f8aa7dbd-41d4-431f-82d7-7d29fe8e6b8a"
replace teaching_language = 2 if interview_ID =="9d01a6dd-da25-4d18-9744-db374ab09077"
replace teaching_language = 2 if interview_ID =="16a524a5-5430-43c6-ae39-fdc46a63f226"
replace teaching_language = 2 if interview_ID =="168816b3-cba7-41fd-9766-f7c1a2fe9914"
replace teaching_language = 2 if interview_ID =="99f730ab-80ba-42a5-8423-c6479973a096"
replace teaching_language = 2 if interview_ID =="78b8779d-7a5e-4fec-9bb7-1dc5c30a8cde"
replace teaching_language = 1 if interview_ID =="b4693391-e7d7-44c6-887e-e5091934a8f1"
replace teaching_language = 1 if interview_ID =="e7f3cf43-25d9-4818-b805-b9f02a64a56e"
replace teaching_language = 1 if interview_ID =="43f705b7-5ffc-45d3-8bcc-c6a62810ca11"
replace teaching_language = 1 if interview_ID =="17a10a27-3122-4782-9de3-e6b3433102bd"
replace teaching_language = 1 if interview_ID =="160bbba3-76dd-42a7-b8fe-4790ff034383"
replace teaching_language = 1 if interview_ID =="0438dca7-5a24-46e9-8d81-4eeebfabc1f1"
replace teaching_language = 1 if interview_ID =="b36c3c5b-6e0c-400c-b0c9-fc4ef05e2c47"
replace teaching_language = 1 if interview_ID =="67fbdb03-ae2c-41c9-a4fd-580518558384"
replace teaching_language = 1 if interview_ID =="e116d81a-372f-43fc-b999-fab473260fe1"
replace teaching_language = 1 if interview_ID =="4d06aef4-7665-4d9c-8fc6-185c1dc3a362"
replace teaching_language = 1 if interview_ID =="cf65f9de-85d4-4cb2-8e33-19f861ab00a6"
replace teaching_language = 1 if interview_ID =="8b8a641c-21aa-4be0-ba2a-e8b35bd75d6f"
replace teaching_language = 1 if interview_ID =="e19713d6-bb72-44b9-ab60-f44d4c67a3a5"
replace teaching_language = 1 if interview_ID =="14ad7661-8937-4d38-8e5f-c034c1d73e34"
replace teaching_language = 1 if interview_ID =="c7bb8dbd-98d0-4cad-aab7-1ccc541ddfb6"
replace teaching_language = 1 if interview_ID =="fd427ede-c6ab-49af-8352-779cc47d092a"
replace teaching_language = 1 if interview_ID =="d51aaad9-bf32-4daf-8535-77f555fcb41b"
replace teaching_language = 1 if interview_ID =="1bcda336-e9ec-42b5-a95f-8d44c2d08a34"
replace teaching_language = 2 if interview_ID =="22cf458e-f742-4291-bb8c-c1d659bb7744"
replace teaching_language = 2 if interview_ID =="185f320f-fd83-4fc3-8749-5e872ea8e8f3"
replace teaching_language = 2 if interview_ID =="bd35578e-95b7-4553-8cda-c7c57b7ac3c9"
replace teaching_language = 2 if interview_ID =="fd6b9eba-da3a-456c-b05a-c07c717a7435"
replace teaching_language = 2 if interview_ID =="cf7cb1b9-3dce-460f-a44e-719b39ae56de"
replace teaching_language = 2 if interview_ID =="cf8a83a1-d9c9-425c-8fd0-fc8d63bae4c6"
replace teaching_language = 2 if interview_ID =="895617d5-4905-4cdc-8eee-5a9996f78eb3"
replace teaching_language = 2 if interview_ID =="37380133-07c8-458c-bfcc-344efcff96de"
replace teaching_language = 2 if interview_ID =="635b341c-b288-4928-9e48-b0293dbdaf43"
replace teaching_language = 2 if interview_ID =="ef414160-b1e6-4a11-9e28-d48d5cb2c4c7"
replace teaching_language = 2 if interview_ID =="7070efc2-3a8f-416b-b232-d99eeee1e5ae"
replace teaching_language = 2 if interview_ID =="8fd502db-bef8-4729-b673-0fddafbb69f0"
replace teaching_language = 2 if interview_ID =="51e501df-cb2c-4568-a139-19ba1ab88970"
replace teaching_language = 2 if interview_ID =="7ae35e44-b9d6-414c-8c0b-3d0dcfb3cdb9"
replace teaching_language = 2 if interview_ID =="6ba09826-f4b1-4633-81ad-ce55976ba973"
replace teaching_language = 2 if interview_ID =="d99c7ef3-5ede-4051-bad3-0397cfd9a5af"
replace teaching_language = 2 if interview_ID =="5be6cc18-0872-4e37-be8f-bfe8ce8ab763"
replace teaching_language = 2 if interview_ID =="e54b53d3-2ad6-41d1-a0f4-5cf267d239cc"
replace teaching_language = 2 if interview_ID =="b1c193e4-da8e-40a4-a063-49a792503d10"
replace teaching_language = 2 if interview_ID =="3c53fd4b-cebd-4da9-81ff-1239631749d2"
replace teaching_language = 2 if interview_ID =="dcc4ac82-ce9a-4be1-8650-49afbbb9c196"
replace teaching_language = 2 if interview_ID =="05053c0a-fe90-4ca1-9a2f-b144d7a13f07"
replace teaching_language = 2 if interview_ID =="45ae1c22-f849-4963-a0e6-81f17952cdd5"
replace teaching_language = 2 if interview_ID =="0f539a76-684e-420c-a796-b5a3bee76ed5"
replace teaching_language = 2 if interview_ID =="4b82aebb-fba7-4855-8ef5-fa9c716cc1a8"
replace teaching_language = 2 if interview_ID =="66603a23-c423-438a-a357-b0bbeaa41441"
replace teaching_language = 2 if interview_ID =="787eba5e-b59b-412f-9a0a-053d9de91c2b"
replace teaching_language = 2 if interview_ID =="686d61b1-45a9-4c13-a390-d1653bb02be8"
replace teaching_language = 2 if interview_ID =="6bc2c898-9bd8-4882-b9cd-5c58c4406070"
replace teaching_language = 2 if interview_ID =="b0948ce1-f0fe-4ce5-8dc2-cdff223018bf"
replace teaching_language = 1 if interview_ID =="ce4d23f6-b313-49db-b5d0-45bde8140740"
replace teaching_language = 1 if interview_ID =="6462dc72-be58-4e12-ae58-cd9adb2120c3"
replace teaching_language = 1 if interview_ID =="dd94f688-61e3-4551-9d27-b69eac1375b5"
replace teaching_language = 3 if interview_ID =="72419dbf-c362-421b-bc6b-27191fed676c"
replace teaching_language = 3 if interview_ID =="2d367424-1843-49e2-b3e4-c2217cc90279"
replace teaching_language = 3 if interview_ID =="820acefe-346e-4270-b5f8-73775b154a14"
replace teaching_language = 3 if interview_ID =="aa50495c-af1d-4207-91ba-4c2de2f4e87c"
replace teaching_language = 3 if interview_ID =="0e39f25b-7207-4944-93c5-b1ed087d46b1"
replace teaching_language = 3 if interview_ID =="a4daa452-118e-4b6f-8816-14b1ede25c74"
replace teaching_language = 3 if interview_ID =="a1e72744-d49f-41e0-a6f4-11f4bf5404ad"
replace teaching_language = 3 if interview_ID =="5f4b423c-3f5b-4a16-923b-46937cb8eded"
replace teaching_language = 3 if interview_ID =="deac7f1a-b7f3-410b-9936-22d6942a2442"
replace teaching_language = 3 if interview_ID =="81f182a2-b8ea-4d68-a2b0-4b609de87925"
replace teaching_language = 3 if interview_ID =="b1ae5c38-7ebd-447d-971c-4df373c38a14"
replace teaching_language = 3 if interview_ID =="e9eaac0c-d21b-429c-ac56-7bb6e280d0f6"
replace teaching_language = 3 if interview_ID =="1d49074e-3b49-4e90-a2de-9f79102dbb0f"
replace teaching_language = 3 if interview_ID =="1b1ddcf5-f2af-4f69-8a21-33cf9e737396"
replace teaching_language = 3 if interview_ID =="93971e19-2a86-423b-a92e-fcf24546e030"
replace teaching_language = 3 if interview_ID =="af384a2f-633b-483e-8613-1769e379f8f1"
replace teaching_language = 3 if interview_ID =="bb1ee7bb-5709-4c36-8c14-7782ea6f9396"
replace teaching_language = 3 if interview_ID =="04297724-daed-4479-8ff1-0977427ccc55"
replace teaching_language = 3 if interview_ID =="2fdd33c6-46ef-4a31-b5aa-5a44b192b166"
replace teaching_language = 3 if interview_ID =="e4168b90-5d24-4956-8bef-311550fa93fd"
replace teaching_language = 3 if interview_ID =="88d9d498-844a-4884-a281-118165b55c2c"
replace teaching_language = 3 if interview_ID =="9c8ff015-8e4c-43fd-9e41-eeceb2669091"
replace teaching_language = 3 if interview_ID =="8a668c5b-bbc3-47fa-9c0f-0ee5b605269b"
replace teaching_language = 3 if interview_ID =="56b22575-5037-4c85-abf1-9b32c7d14817"
replace teaching_language = 3 if interview_ID =="dfd5bd34-9080-43ea-ad02-a38515b7cf0b"
replace teaching_language = 3 if interview_ID =="d8d4a5a2-c611-4cf9-9eb3-520363f3cbff"
replace teaching_language = 3 if interview_ID =="f6647380-6f5b-4cbf-a450-8eb70f95f99b"
replace teaching_language = 3 if interview_ID =="538c5ee8-2940-432b-b6cd-339d5b24f01e"
replace teaching_language = 3 if interview_ID =="c1577374-b069-41d5-a6c2-034b72424d24"
replace teaching_language = 3 if interview_ID =="2884659e-905f-42e9-8f0f-3ac0e3eee1c2"
replace teaching_language = 1 if interview_ID =="f9b7a79c-6095-49d5-be36-84c87e9d7b47"
replace teaching_language = 1 if interview_ID =="629b976f-786d-46da-96f7-19e7be5a09c3"
replace teaching_language = 1 if interview_ID =="49c22686-b976-4978-b98e-688d17146860"
replace teaching_language = 3 if interview_ID =="46cb57fa-6bcb-43d5-a6fc-067117c7808f"
replace teaching_language = 3 if interview_ID =="f862ba89-5c71-4984-a298-f56fa06453bb"
replace teaching_language = 3 if interview_ID =="dc0527d2-8f84-4347-a772-3a401e8077da"
replace teaching_language = 3 if interview_ID =="8fb628db-37c7-45fd-a697-9de1717e59a0"
replace teaching_language = 3 if interview_ID =="ed282e76-db68-4bd0-a931-4dfa39c57bbe"
replace teaching_language = 3 if interview_ID =="011af643-eb5d-478f-81fa-f1c6849c2da4"
replace teaching_language = 3 if interview_ID =="7b51ed90-9fc7-4493-91d3-5ed4dafd109e"
replace teaching_language = 3 if interview_ID =="d76cfa84-f917-469c-9e62-673c9e1c0165"
replace teaching_language = 3 if interview_ID =="af54d09d-5f5d-4aa3-985a-f9036a625d3b"
replace teaching_language = 3 if interview_ID =="131748be-a7be-4296-a17f-1b895f8ab47f"
replace teaching_language = 3 if interview_ID =="1882f90e-a134-4e9f-bebd-b1877a2182b8"
replace teaching_language = 3 if interview_ID =="54420e21-81d4-4e3a-a477-bbe2b5b728a5"
replace teaching_language = 3 if interview_ID =="77e726c4-d023-4ac7-b09c-55bb9c21ddf3"
replace teaching_language = 3 if interview_ID =="857cfa5d-29da-4b37-b5b5-d326f27091e0"
replace teaching_language = 3 if interview_ID =="146e8540-4cd7-48c9-be68-41f6d1e742d0"
replace teaching_language = 3 if interview_ID =="a2d78a04-b9bf-4026-94df-6666023cce3a"
replace teaching_language = 3 if interview_ID =="8835084a-d30e-4d68-beb6-4547369d69a9"
replace teaching_language = 3 if interview_ID =="02ea8d0b-4efa-40f4-92f8-4c5c2c404f77"
replace teaching_language = 3 if interview_ID =="9151ef53-fc42-43f2-ae47-d5f8e516f176"
replace teaching_language = 3 if interview_ID =="ef39c66b-2441-4946-b624-76329c5d2ac3"
replace teaching_language = 3 if interview_ID =="a6da8e51-c5c6-451a-8ab8-358a27790f72"
replace teaching_language = 3 if interview_ID =="fa0ee780-8be8-463b-b2bb-a2ad1ab197fa"
replace teaching_language = 3 if interview_ID =="d1312358-d4e3-40ca-9c51-d71190a46fa7"
replace teaching_language = 3 if interview_ID =="1636c5a5-3ab1-45ae-afc2-dbed93291361"
replace teaching_language = 3 if interview_ID =="69efbb32-a1d2-4281-b1b1-2ac359bd2679"
replace teaching_language = 3 if interview_ID =="3e8b5e94-b8da-4b69-9da5-c5579007cae6"
replace teaching_language = 3 if interview_ID =="5923e7b8-8eb9-4297-9ec6-3f6bef8ab843"
replace teaching_language = 3 if interview_ID =="0f83dcc7-4930-4040-a993-d200dd61f7ce"
replace teaching_language = 3 if interview_ID =="9a651a70-a0dd-44e0-ae10-a5a12a7bbd4a"
replace teaching_language = 3 if interview_ID =="da0062b9-8179-4fcc-919e-172e58fb961b"
replace teaching_language = 1 if interview_ID =="a4de4b5b-2305-41b4-8eef-fda2a4845f2f"
replace teaching_language = 1 if interview_ID =="263b8309-80fb-493b-a1a1-036c6e5edc13"
replace teaching_language = 1 if interview_ID =="aabccf1f-e403-4a35-b875-e7499fd42791"
replace teaching_language = 3 if interview_ID =="60d690c4-f1fc-43de-8cce-d8f6fd8d528b"
replace teaching_language = 3 if interview_ID =="96cf961a-0a95-4812-9389-c96a9408d340"
replace teaching_language = 3 if interview_ID =="9e561ba3-bf99-4631-b68b-68f5263550b9"
replace teaching_language = 3 if interview_ID =="1c67e387-390b-4a5e-81c1-ba27875c2c5d"
replace teaching_language = 3 if interview_ID =="dfbf5404-4944-4b75-8e33-debf855bcdc4"
replace teaching_language = 3 if interview_ID =="ecdf8d73-f771-486c-b22a-ee056f246a2d"
replace teaching_language = 3 if interview_ID =="bc9d06bc-78aa-49df-8445-8ed976f5f143"
replace teaching_language = 3 if interview_ID =="b12861ed-60ff-40b8-b001-769ae7a85028"
replace teaching_language = 3 if interview_ID =="5b5cbf6a-0041-4e75-b33a-4f3db6a1b992"
replace teaching_language = 3 if interview_ID =="6e9c72dc-b15b-4f5e-bba4-f90f3efafdfa"
replace teaching_language = 3 if interview_ID =="26f6bd4c-ac6a-44ed-bec0-0b34ef83be0b"
replace teaching_language = 3 if interview_ID =="3e272e22-8013-4d22-a090-5ff169f665b8"
replace teaching_language = 3 if interview_ID =="839a5aa6-08ba-4ee5-b0a2-580716f82f71"
replace teaching_language = 3 if interview_ID =="6b8e47f1-7b9b-4328-bd50-5779dec73e08"
replace teaching_language = 3 if interview_ID =="46e02613-19cb-4f3c-95dd-59df27ba4422"
replace teaching_language = 1 if interview_ID =="0d3a9d93-6f9e-46d9-a467-f7b608bd3981"
replace teaching_language = 1 if interview_ID =="18be914a-c4ca-402a-8c5e-219db207aafc"
replace teaching_language = 1 if interview_ID =="8f881490-ecdd-4bb3-9a27-ead212c0e639"
replace teaching_language = 1 if interview_ID =="5a861d48-f296-49f0-86a7-c3a83b71178e"
replace teaching_language = 1 if interview_ID =="c3bb3779-1f10-4e22-99e2-462f385f8553"
replace teaching_language = 1 if interview_ID =="6b6707b7-9c4d-4349-804c-ccc5596edc40"
replace teaching_language = 1 if interview_ID =="882e6346-2908-4350-af47-b53596278d9d"
replace teaching_language = 1 if interview_ID =="4a2ee612-6b02-4b0e-8e5e-abbf5a9602f3"
replace teaching_language = 1 if interview_ID =="ee79a0c3-4ee5-44b6-a871-42a50a54bbef"
replace teaching_language = 1 if interview_ID =="30be37b2-1f7c-4191-97d5-342afde1d682"
replace teaching_language = 1 if interview_ID =="d1209b21-ba1d-4aae-b3bb-b052fe0a85ff"
replace teaching_language = 1 if interview_ID =="b41c5fdc-e941-4af8-b80e-f46d95c1678e"
replace teaching_language = 1 if interview_ID =="2fa8050e-f5ad-447d-8983-6e4acb624959"
replace teaching_language = 1 if interview_ID =="ce495180-0cad-47e3-ae22-866c774dbbaa"
replace teaching_language = 1 if interview_ID =="7407ccd8-6b13-4e01-8dea-c8d0e64ed5ea"
replace teaching_language = 1 if interview_ID =="b5d23c6f-e74a-4d5d-ae1c-d33ef5441685"
replace teaching_language = 1 if interview_ID =="ce4e1042-54a1-4924-85dd-0d0a91847fe4"
replace teaching_language = 1 if interview_ID =="445fba62-2101-4146-92fb-4137d8e3f98f"
replace teaching_language = 3 if interview_ID =="c8796dc5-3ef9-4c84-a7f2-f7870297f137"
replace teaching_language = 3 if interview_ID =="10495e7c-cc8d-45e8-9a65-198b2787902f"
replace teaching_language = 3 if interview_ID =="1dfb3865-3b56-4f2a-92aa-a38b99b22d52"
replace teaching_language = 3 if interview_ID =="ea896799-d59f-4d81-8933-237b1f96c4d0"
replace teaching_language = 3 if interview_ID =="1f5a5c1d-1359-4920-8324-ae3c5c2ab61d"
replace teaching_language = 3 if interview_ID =="d90775ba-40d7-4072-99c6-d07cd02087d1"
replace teaching_language = 3 if interview_ID =="a8c9c3ae-7528-4364-afe2-54084e739b86"
replace teaching_language = 3 if interview_ID =="9af42d60-0b65-4d29-a84a-6a63751d39d0"
replace teaching_language = 3 if interview_ID =="3f853770-6d95-49c0-ae53-44aa38b0526d"
replace teaching_language = 3 if interview_ID =="cdf3c340-f228-48eb-ba71-69c709d54877"
replace teaching_language = 3 if interview_ID =="fd8ec6a4-1d31-426f-8adc-a46b2dff6f67"
replace teaching_language = 3 if interview_ID =="fcf8d582-254f-4d94-899f-a76f936bf614"
replace teaching_language = 3 if interview_ID =="3e03bfdd-11f4-43ce-a1fa-95ecedc1e56c"
replace teaching_language = 3 if interview_ID =="5fcb73e7-f713-4ee9-9fc4-d5575cea3656"
replace teaching_language = 3 if interview_ID =="cea0e017-c7a4-4ed1-b909-8ee996356b71"
replace teaching_language = 1 if interview_ID =="c426ae6a-9a5d-4948-9ab1-9e5e25c26182"
replace teaching_language = 1 if interview_ID =="9e98747a-68bf-476c-9371-4abb80a696a8"
replace teaching_language = 1 if interview_ID =="34257bde-5522-4600-8d6f-1eb686df1d97"
replace teaching_language = 1 if interview_ID =="73518d30-8843-487a-87f9-6efdcf9b0075"
replace teaching_language = 1 if interview_ID =="e89aecb6-f480-4786-831c-65f3b0237601"
replace teaching_language = 1 if interview_ID =="13ef7c88-fb9f-4da7-9b05-06aa4176f043"
replace teaching_language = 1 if interview_ID =="b39b0515-7c88-4d7f-b809-8043001c765e"
replace teaching_language = 1 if interview_ID =="7c194947-f40c-4db9-81cf-cee588c52a36"
replace teaching_language = 1 if interview_ID =="5aa649e9-6ff2-4fcf-9541-a8870e089ff4"
replace teaching_language = 1 if interview_ID =="915bdc1f-d29f-4a53-b395-7d807b271670"
replace teaching_language = 1 if interview_ID =="8238a774-87aa-4615-b16b-c286b4b81bf6"
replace teaching_language = 1 if interview_ID =="ec550fc2-ef85-4492-bb5b-c1fa97555f42"
replace teaching_language = 1 if interview_ID =="29dde85f-9358-429a-b6ff-32a9f7ddd12e"
replace teaching_language = 1 if interview_ID =="b75a83cd-26b6-4480-b95d-e917f6bcd77d"
replace teaching_language = 1 if interview_ID =="68ef6259-0613-4937-8a7f-39d6509a750a"
replace teaching_language = 1 if interview_ID =="ea07b9b9-bf74-4a0f-acf1-57d3e15fb354"
replace teaching_language = 1 if interview_ID =="821dfdc1-077b-4246-a4bb-73dcd6be29bc"
replace teaching_language = 1 if interview_ID =="8fa4a467-8fe8-4b73-90dd-c965973d442c"
replace teaching_language = 3 if interview_ID =="f3bea347-0fd0-4906-bda0-401bcfa897ec"
replace teaching_language = 3 if interview_ID =="ee9cc52f-b318-4be9-a603-ef3a6975d9dc"
replace teaching_language = 3 if interview_ID =="796415ef-f9d1-41c8-9828-bd471e2c1915"
replace teaching_language = 3 if interview_ID =="a3f753fd-0ec1-4a6b-9c92-ea5a243849f0"
replace teaching_language = 3 if interview_ID =="abd467d9-be25-4b1f-ab58-9a71b6e95eda"
replace teaching_language = 3 if interview_ID =="1d551a26-f737-4da2-b9e1-4b290f734325"
replace teaching_language = 3 if interview_ID =="7d45cfc3-4623-4d1c-ad62-8dc476b7303c"
replace teaching_language = 3 if interview_ID =="41f8cffc-c6ef-47de-9197-5c48d7d01814"
replace teaching_language = 3 if interview_ID =="8f1da195-d51e-460c-8f25-a01ff60070d5"
replace teaching_language = 3 if interview_ID =="0bf6b66e-d8fb-4b93-8823-0f0553372775"
replace teaching_language = 3 if interview_ID =="e36dc9ca-3a7c-46ef-ad9b-8c352e557bc8"
replace teaching_language = 3 if interview_ID =="cacf8c01-b807-4a6e-9b40-c7464f8fbc12"
replace teaching_language = 3 if interview_ID =="c8dc33da-35b1-4a5c-a448-12b2c2843b74"
replace teaching_language = 3 if interview_ID =="dfca95bf-063f-41a7-b498-865b52abfd92"
replace teaching_language = 3 if interview_ID =="c031642b-42fe-4c8f-af7e-0383dbcebbd1"
replace teaching_language = 3 if interview_ID =="e5119281-ce9b-4cbf-b2ca-4670d46cbfc3"
replace teaching_language = 3 if interview_ID =="04019db5-34f1-4ec5-a3e3-34ac4388c46a"
replace teaching_language = 3 if interview_ID =="b30625f3-24e7-4939-a9d0-eea1b48f1aa1"
replace teaching_language = 3 if interview_ID =="cbeabe26-bf3d-4c55-80ae-c2b98550aa3e"
replace teaching_language = 3 if interview_ID =="8923c234-9297-4be7-bce1-4dbd8d021e1d"
replace teaching_language = 3 if interview_ID =="b3973b6d-89a8-434d-b207-ce38918bbaf0"
replace teaching_language = 3 if interview_ID =="24a82183-e54a-4c80-acaa-3909b074a51d"
replace teaching_language = 3 if interview_ID =="d431d46d-ec8d-4b4e-a140-7e17fb5c1348"
replace teaching_language = 3 if interview_ID =="34ec6c9c-0a4e-43b8-80b4-a2821357e1ee"
replace teaching_language = 3 if interview_ID =="8dbb82b8-1dda-4b27-8476-140a17cb1294"
replace teaching_language = 3 if interview_ID =="8f9933f2-7fc3-421a-86b1-9ec6c6300d34"
replace teaching_language = 3 if interview_ID =="5f7d0939-dc4a-4718-b0e2-7c98592276ff"
replace teaching_language = 3 if interview_ID =="1f0446a0-73f7-4564-98e6-d3d34a746bcb"
replace teaching_language = 3 if interview_ID =="d4d3dcc8-6e11-4af4-8d0f-95342859bff5"
replace teaching_language = 3 if interview_ID =="a68b362a-324b-4cc6-a3e5-1000458c2dab"
replace teaching_language = 1 if interview_ID =="55268856-b983-41c0-a65f-46a7655c8834"
replace teaching_language = 1 if interview_ID =="b5932b7f-d704-4ec3-8c35-f34fef02d453"
replace teaching_language = 1 if interview_ID =="163d8e92-1cfe-4901-9463-ce56e2525ad8"
replace teaching_language = 3 if interview_ID =="e9d5c554-3655-4d38-9fa4-20dd628df834"
replace teaching_language = 3 if interview_ID =="d3cb6daf-6ec0-4501-9d92-33e522e5fc83"
replace teaching_language = 3 if interview_ID =="f36a481c-270d-4857-9592-2270cc700cd6"
replace teaching_language = 3 if interview_ID =="d79a5769-46d9-4db1-bb4b-957d0f8b8ad0"
replace teaching_language = 3 if interview_ID =="8e110973-ba09-4142-b0c4-895d26db1358"
replace teaching_language = 3 if interview_ID =="d656d1fb-9606-429d-ae47-4753d1f9214a"
replace teaching_language = 3 if interview_ID =="a1112004-52b1-475e-8fb4-12cdb98d6eb9"
replace teaching_language = 3 if interview_ID =="08b665ae-c369-4e52-8c3b-0c93ef0df5f8"
replace teaching_language = 3 if interview_ID =="50c2f077-5844-4e70-8312-1413c3e72d85"
replace teaching_language = 3 if interview_ID =="0379b886-7539-4db0-92aa-7ec191e994b1"
replace teaching_language = 3 if interview_ID =="34e7fae6-df76-443b-96c1-92e31bb3f96d"
replace teaching_language = 3 if interview_ID =="46f38f0d-6933-4860-b866-e93f78f0e1b4"
replace teaching_language = 3 if interview_ID =="10656fd2-0194-411a-a48f-21af413ec033"
replace teaching_language = 3 if interview_ID =="011b8d3f-cdde-4f44-8609-7434768e2c4c"
replace teaching_language = 3 if interview_ID =="0933de36-cc05-4d9d-a0e9-faf542bdec1a"
replace teaching_language = 3 if interview_ID =="fe55c96f-0b49-4a78-9127-17627d04d6ff"
replace teaching_language = 3 if interview_ID =="7c3043cf-0276-41c3-9380-894bd3938322"
replace teaching_language = 3 if interview_ID =="7d8eb3b9-a9c4-4466-9fcd-e868358fad22"
replace teaching_language = 3 if interview_ID =="a8d3f40b-bbc4-4077-8a43-328cc9af71bd"
replace teaching_language = 3 if interview_ID =="a95ac23d-77c0-419a-82a6-f9178dcecfcd"
replace teaching_language = 3 if interview_ID =="4ded2ec0-1493-4708-b3a0-a41b04efe457"
replace teaching_language = 3 if interview_ID =="51094f50-bd64-49ef-a752-9fe9a25679d9"
replace teaching_language = 3 if interview_ID =="6ab42676-b308-4206-ae9b-cb36a0104aea"
replace teaching_language = 3 if interview_ID =="e9e86c2b-38e3-4f1a-92e4-a721a6d0b7b0"
replace teaching_language = 3 if interview_ID =="dfbd6324-f754-44f8-9056-5063bad5eb1b"
replace teaching_language = 3 if interview_ID =="c5cc1658-01c4-45ff-8966-5de1ce64bdbf"
replace teaching_language = 3 if interview_ID =="b9b47031-168a-4d98-acc5-cdf485c3f087"
replace teaching_language = 3 if interview_ID =="504b6f59-b571-484a-907e-c40e7ca06f02"
replace teaching_language = 3 if interview_ID =="7dd9dc2e-b09b-461e-ba68-a599e839ec3f"
replace teaching_language = 3 if interview_ID =="0d96f6a7-d43a-41a8-a372-1351ea22b6b6"
replace teaching_language = 1 if interview_ID =="821eda56-f1f0-4f3a-83ff-6a0fa3463ab3"
replace teaching_language = 1 if interview_ID =="84b40d93-22e6-438e-9ab4-fc37a48ec178"
replace teaching_language = 1 if interview_ID =="fc40e7b7-80cf-4d16-9fcf-3e840f4b926a"
replace teaching_language = 4 if interview_ID =="f150a531-b15c-4005-b834-e731c40e5fa3"
replace teaching_language = 4 if interview_ID =="980c086f-9658-4b17-9236-ff2625825304"
replace teaching_language = 4 if interview_ID =="67d035b1-bc41-443d-8a4a-91df1c1c9c72"
replace teaching_language = 4 if interview_ID =="a4ee5c0c-a1d7-4044-b4e9-9315b71f0711"
replace teaching_language = 4 if interview_ID =="2a147b0d-9d07-4312-a54a-f9c531ba3433"
replace teaching_language = 4 if interview_ID =="cddfd414-b91c-42e3-9ab0-ec31e4e188be"
replace teaching_language = 4 if interview_ID =="8d0cbea6-4af1-45b9-a603-9215ed301f8f"
replace teaching_language = 4 if interview_ID =="31b9953f-f435-48cd-841a-5b23e7c02c29"
replace teaching_language = 4 if interview_ID =="676c57a7-0ab1-47bd-b148-cb98cc3fe508"
replace teaching_language = 4 if interview_ID =="42b9c7aa-3992-432d-bcc5-da6c7e61e922"
replace teaching_language = 4 if interview_ID =="5467272d-891a-4429-a1d9-81f3f54dedcc"
replace teaching_language = 4 if interview_ID =="855c1f39-8109-46b6-9d12-89ae58eb5f7e"
replace teaching_language = 4 if interview_ID =="e586a214-c95c-4fa2-bd8f-e5d84cf228fc"
replace teaching_language = 4 if interview_ID =="62a6409f-9c97-4edd-9af7-c83b1984daf5"
replace teaching_language = 4 if interview_ID =="ccc97b6a-21b1-495e-95d2-f97f72781197"
replace teaching_language = 4 if interview_ID =="5f245ecf-2232-4e05-9aae-6c38b0625aa5"
replace teaching_language = 4 if interview_ID =="2f8dcf67-a428-4950-a0bd-80ebd80b7783"
replace teaching_language = 4 if interview_ID =="8b390415-7b64-43e1-9ee1-e67e697b8363"
replace teaching_language = 4 if interview_ID =="214a47ef-bda4-4406-8162-1441839f2282"
replace teaching_language = 4 if interview_ID =="1524de9a-ccbf-4289-8052-4f2ee451023c"
replace teaching_language = 4 if interview_ID =="0468f33f-6deb-4f5b-a8b0-6173cc6375d0"
replace teaching_language = 4 if interview_ID =="3f726d6a-70b8-438b-89d7-f3a0cfe191e2"
replace teaching_language = 4 if interview_ID =="d97e54e2-c177-4fbe-b56a-1b000953b2bf"
replace teaching_language = 4 if interview_ID =="179a4aaa-ad42-467a-acf8-46fb6dccde54"
replace teaching_language = 4 if interview_ID =="a4907a68-5ba2-4dc6-bce2-ebf6e4e88eaa"
replace teaching_language = 4 if interview_ID =="027a196d-7043-4bb4-aa5e-7fcd32e46d91"
replace teaching_language = 4 if interview_ID =="6ff1fd58-e2f7-46e4-b7f4-56218f10d02d"
replace teaching_language = 4 if interview_ID =="cce2f8bf-5812-4f13-8b91-0306a5f35ba4"
replace teaching_language = 4 if interview_ID =="0c2f0b83-c323-4807-8aef-1f676bbf5342"
replace teaching_language = 4 if interview_ID =="c0785915-bda8-41ba-a477-933b7c208382"
replace teaching_language = 1 if interview_ID =="7c0deefb-5d0a-49fe-8f7b-8b7b10441830"
replace teaching_language = 1 if interview_ID =="445769b4-4e0f-439e-9032-051db282d685"
replace teaching_language = 1 if interview_ID =="9dfed3f7-9bde-4cc8-9c1b-f97416c869a5"
replace teaching_language = 3 if interview_ID =="72729516-fd51-413d-b037-3c02210c5f0e"
replace teaching_language = 3 if interview_ID =="2fbb0ba5-3d7e-4d05-8d91-d13e0867b956"
replace teaching_language = 3 if interview_ID =="7228d066-0295-426a-821b-454645ef4c8a"
replace teaching_language = 3 if interview_ID =="81a32ca1-e57b-420a-a366-75606653b461"
replace teaching_language = 3 if interview_ID =="4cf5864e-baf6-44d7-a490-36a337ab67ae"
replace teaching_language = 3 if interview_ID =="e7b11eb9-8bd0-4b91-8b27-e40aca35b94c"
replace teaching_language = 3 if interview_ID =="69a61dac-f835-4015-b842-1ca56a9415b9"
replace teaching_language = 3 if interview_ID =="438a6bd5-9aad-4d7e-830d-e1cb94e83201"
replace teaching_language = 3 if interview_ID =="20617e2e-c9b3-42c2-a226-9664955f51c5"
replace teaching_language = 3 if interview_ID =="54b13313-4cdb-44cc-b865-40d355e602ad"
replace teaching_language = 3 if interview_ID =="a19467a0-938a-4869-b10e-fdaa1f14b2bb"
replace teaching_language = 3 if interview_ID =="d2e1f3ef-b614-4850-a693-23ef219b50d7"
replace teaching_language = 3 if interview_ID =="f5aafe4d-a460-4b3a-b678-c632fb56ea2a"
replace teaching_language = 3 if interview_ID =="792d4e39-5497-486e-962b-6a717625d339"
replace teaching_language = 3 if interview_ID =="48db46d8-b3ac-4ab5-b06b-1606d3a7e701"
replace teaching_language = 1 if interview_ID =="290377b2-af13-407b-8748-b0c84324c520"
replace teaching_language = 1 if interview_ID =="d63bb10e-dbb7-4a2d-8414-9d40b5b918ea"
replace teaching_language = 1 if interview_ID =="b1b97ec2-6b9e-4dca-8ad3-db2e66ce29e2"
replace teaching_language = 1 if interview_ID =="19fa8c35-c778-44f6-ae05-02d4834d11e2"
replace teaching_language = 1 if interview_ID =="2322ffe1-bc85-4769-99f5-57cf3156f581"
replace teaching_language = 1 if interview_ID =="25d15318-2e38-41a9-ba7f-a56de906cc7f"
replace teaching_language = 1 if interview_ID =="5d68e054-e0a9-41e0-b0c3-ba1f2ddad9b7"
replace teaching_language = 1 if interview_ID =="d47da4a9-c0d4-4386-a3f4-2a13d0f203ec"
replace teaching_language = 1 if interview_ID =="d2edba9b-becb-4b92-973f-ac1e5139a783"
replace teaching_language = 1 if interview_ID =="9953b512-5f6f-4a91-8e6a-e58fb348bc93"
replace teaching_language = 1 if interview_ID =="d7e78a59-5874-4239-9391-8f4b0865cd18"
replace teaching_language = 1 if interview_ID =="19ebb2e3-ed01-4712-bb91-a745aa914ea6"
replace teaching_language = 1 if interview_ID =="fb84eda8-e8cd-4d65-9b81-548353f17d74"
replace teaching_language = 1 if interview_ID =="d238436d-fee5-46e7-ad4b-1e490f54c108"
replace teaching_language = 1 if interview_ID =="7c4c7db5-3f6e-457d-9f2f-516a002cdbfd"
replace teaching_language = 1 if interview_ID =="ba8225bd-a1eb-4bad-8aab-f5689a809b31"
replace teaching_language = 1 if interview_ID =="766f8ad4-f11a-4816-ba35-3702e5cf7e19"
replace teaching_language = 1 if interview_ID =="61063fa4-3a7c-42db-b2c0-133bcff996b3"
replace teaching_language = 4 if interview_ID =="01e6708e-e1a1-4f8f-be47-ba8cf8932f80"
replace teaching_language = 4 if interview_ID =="a8c3d06a-12c7-44ef-9c7d-0f84daa62f20"
replace teaching_language = 4 if interview_ID =="d4dd5010-da84-4f51-b226-36c2d99539e7"
replace teaching_language = 4 if interview_ID =="350f0a83-5f5e-4d23-bfd5-dbefa2147a16"
replace teaching_language = 4 if interview_ID =="7aded777-0979-4a00-9c1d-74ce0999fbeb"
replace teaching_language = 4 if interview_ID =="0640225d-1f69-4165-be67-8c6d1892e2a2"
replace teaching_language = 4 if interview_ID =="1de6ec42-99cf-4718-9469-a11e044926c4"
replace teaching_language = 4 if interview_ID =="cd8a4ad5-eccd-4578-8f9b-302fcb23ff6e"
replace teaching_language = 4 if interview_ID =="e543891b-db97-4957-8253-b42c9a50184b"
replace teaching_language = 4 if interview_ID =="dcd6482b-a9c6-4982-a661-fe6368bb3ace"
replace teaching_language = 4 if interview_ID =="323a4ac0-bfae-457e-a1eb-9c79ebc01032"
replace teaching_language = 4 if interview_ID =="be8de64f-a46a-4600-bf17-6c49b1e0b83f"
replace teaching_language = 4 if interview_ID =="4546504d-a655-4ca4-8318-e22346326c2a"
replace teaching_language = 4 if interview_ID =="e81a625a-3100-4035-9be5-2c07366b68c1"
replace teaching_language = 4 if interview_ID =="eafd91e9-bd51-4a12-8dad-f8719368d420"
replace teaching_language = 4 if interview_ID =="02286aa3-b43b-4b75-b74d-e8c70e4a5a1f"
replace teaching_language = 4 if interview_ID =="da1d9ab3-fba9-44fc-ae69-8e34c71ed1cf"
replace teaching_language = 4 if interview_ID =="4e5969b1-15ee-4294-9d79-dccb444d58c5"
replace teaching_language = 4 if interview_ID =="00c10308-94b5-4ff2-b8f1-62e4b3da6fc9"
replace teaching_language = 4 if interview_ID =="3c9b326d-57c9-48f8-a751-210725db9bd0"
replace teaching_language = 4 if interview_ID =="28cb40eb-9823-4220-b231-105c1766536b"
replace teaching_language = 4 if interview_ID =="a05bcfff-d5de-49bf-9bda-62c70e00c12d"
replace teaching_language = 4 if interview_ID =="5e6f524d-a2c1-451d-9433-a95872ac1f04"
replace teaching_language = 4 if interview_ID =="d0d60e91-9075-49c3-902c-c19440c1de60"
replace teaching_language = 4 if interview_ID =="cc915cfd-626a-4f61-b79d-e34a81182e05"
replace teaching_language = 4 if interview_ID =="eaa3174e-789f-4e85-9927-ae045f0c32c6"
replace teaching_language = 4 if interview_ID =="ef13c991-ebfb-4f8b-8466-71cebc19c717"
replace teaching_language = 4 if interview_ID =="c0a046c5-c100-41fa-b8a0-14042c216feb"
replace teaching_language = 4 if interview_ID =="06bdf91d-b5c6-491d-8a80-66c6b243949f"
replace teaching_language = 4 if interview_ID =="c08b2a86-f297-4bb2-8928-040daf48e0c6"
replace teaching_language = 4 if interview_ID =="b7d4715c-881a-4376-a317-e216e5849218"
replace teaching_language = 4 if interview_ID =="21ca6b22-982b-42ee-9a8b-0433992b4957"
replace teaching_language = 4 if interview_ID =="5948ec97-e222-494d-bbc0-438f385e3414"
replace teaching_language = 1 if interview_ID =="9aa67971-8b63-4b28-ae38-cef4a73120b1"
replace teaching_language = 1 if interview_ID =="100f9d32-6342-4d0d-81c3-4a7f16cdf006"
replace teaching_language = 3 if interview_ID =="09fe424c-6131-46b3-b94e-94a814dd1228"
replace teaching_language = 3 if interview_ID =="ecda14ce-53fe-4b0f-99fb-d9e24b9dd0ed"
replace teaching_language = 3 if interview_ID =="6a9d5279-55f2-46f6-b6fd-3cd9c14349ea"
replace teaching_language = 3 if interview_ID =="cd827057-24e1-4015-a0e6-769cfac1ef38"
replace teaching_language = 3 if interview_ID =="69a856c5-6072-4d8c-90c3-137b590debd1"
replace teaching_language = 3 if interview_ID =="d0a68cfb-1c83-4da3-93c1-f62f26dd1997"
replace teaching_language = 3 if interview_ID =="90ce701a-1a4a-4ab2-8f7f-bcba19798782"
replace teaching_language = 3 if interview_ID =="19513c2d-4a84-4a2a-be1f-a2ef023ec8c5"
replace teaching_language = 3 if interview_ID =="ba56a309-68f5-4fa8-b9d3-04337d743348"
replace teaching_language = 3 if interview_ID =="e5fe2764-d3c8-4c0b-97de-b8c593f39c55"
replace teaching_language = 3 if interview_ID =="a8dba994-9dc7-45ea-accd-9086e3f47776"
replace teaching_language = 3 if interview_ID =="57c561f7-ea1d-40a2-872c-309374901c76"
replace teaching_language = 3 if interview_ID =="717497de-b442-43f4-a1fe-1063b5ee5cf6"
replace teaching_language = 3 if interview_ID =="e5bd2780-e837-42d7-9994-cab31811e412"
replace teaching_language = 3 if interview_ID =="6ed60be7-cfce-4602-845b-2c6c000dea61"
replace teaching_language = 1 if interview_ID =="e04249ff-2759-43cf-b3fd-1d02d025a55b"
replace teaching_language = 1 if interview_ID =="6f73e14c-cbb5-46dd-a95d-3209e94f43ef"
replace teaching_language = 1 if interview_ID =="dd576692-4564-45a7-a314-f38ed19487bb"
replace teaching_language = 1 if interview_ID =="cbe57208-42c6-4cb9-a50a-6d671f12c1ac"
replace teaching_language = 1 if interview_ID =="f73aa4b2-ad9b-468f-bd43-6c8e48b27652"
replace teaching_language = 1 if interview_ID =="06b625ba-85b8-4c5d-b448-82391a190763"
replace teaching_language = 1 if interview_ID =="8c2ff819-0fb0-4e5c-94ba-2245cc321009"
replace teaching_language = 1 if interview_ID =="215ce12a-c4a9-41fc-ab82-b97158e10375"
replace teaching_language = 1 if interview_ID =="90326198-19b8-4792-b126-f979d597b7dc"
replace teaching_language = 1 if interview_ID =="629accfd-5d95-44b0-8b4f-fbecfe310a2e"
replace teaching_language = 1 if interview_ID =="5f71cc23-e8b7-4311-a80a-8cc69b96fe89"
replace teaching_language = 1 if interview_ID =="e2e709aa-466f-4760-931c-ef711e7f3ad4"
replace teaching_language = 1 if interview_ID =="d28687c6-c1bb-4603-acac-93a485ccc7c3"
replace teaching_language = 1 if interview_ID =="2bd2079c-47c9-4d5f-8931-a89205f3626d"
replace teaching_language = 1 if interview_ID =="d548cc18-18fd-4edd-9a36-36d4f3bb33a2"
replace teaching_language = 1 if interview_ID =="58f0731d-a2e9-4802-a4db-659ceb6e7277"
replace teaching_language = 1 if interview_ID =="e316ced1-6d18-47c7-a699-733431d774a8"
replace teaching_language = 1 if interview_ID =="55c8b2b5-acf4-4c94-9119-d932110217e5"
replace teaching_language = 1 if interview_ID =="1a354681-c266-4dc6-b435-84cdd831bb4d"
replace teaching_language = 2 if interview_ID =="bc31015f-7e11-4be9-9d4b-5121dd871cfc"
replace teaching_language = 2 if interview_ID =="d9632d09-edca-44f7-a1dc-30fb6c43b78a"
replace teaching_language = 2 if interview_ID =="f00fbbf8-a09d-48cd-b373-f300a3d35d07"
replace teaching_language = 2 if interview_ID =="562ff357-8dcf-4ad5-bc9f-c95486107397"
replace teaching_language = 2 if interview_ID =="7ecdd16a-2c2b-49cd-b4cf-09dc56eac490"
replace teaching_language = 2 if interview_ID =="90c70ca3-899b-4009-aced-bbe64dbdc55b"
replace teaching_language = 2 if interview_ID =="d22ccaaa-b2d9-4bdd-8f17-5a99fc58b419"
replace teaching_language = 2 if interview_ID =="392babb2-a244-4bd9-851b-a89173b0c101"
replace teaching_language = 2 if interview_ID =="ff70233f-5294-4948-af54-d001d5bb26d2"
replace teaching_language = 2 if interview_ID =="529844ed-60a3-4bb2-97c9-1ada16c08f37"
replace teaching_language = 2 if interview_ID =="3f197fd3-1df0-4d5f-abbb-df99f67083ec"
replace teaching_language = 2 if interview_ID =="d3bfaafb-fcdc-4671-aad4-2d04aa8f2418"
replace teaching_language = 2 if interview_ID =="2e56358f-0031-40e0-9165-6c7c93c471bb"
replace teaching_language = 2 if interview_ID =="a2eaf066-d08a-4066-a261-da62c4107f08"
replace teaching_language = 2 if interview_ID =="eb62ade8-384d-40e4-b4ed-fe53172b45e9"
replace teaching_language = 2 if interview_ID =="1470c96b-d6d1-4b40-a4aa-23156d13da88"
replace teaching_language = 2 if interview_ID =="ad3d7ac7-afe0-4dfc-bc98-6d874d271876"
replace teaching_language = 2 if interview_ID =="66143b1b-38bb-4ec4-81aa-758e8f5edf17"
replace teaching_language = 2 if interview_ID =="61baf362-d9e8-48c0-99d8-9393c58f030a"
replace teaching_language = 2 if interview_ID =="93b75adb-8d78-409d-9713-3af9f9e9dbbf"
replace teaching_language = 2 if interview_ID =="d0d3be98-c6ea-4d87-879a-fd4d7d3ac419"
replace teaching_language = 2 if interview_ID =="c471a17e-38fc-402e-95f3-07fb2b876eed"
replace teaching_language = 2 if interview_ID =="f0ecd82c-7fb9-4bcd-ad6a-0d1eeac617d2"
replace teaching_language = 2 if interview_ID =="627d5d94-ef32-47d0-8854-cd485a60fe3a"
replace teaching_language = 2 if interview_ID =="14088813-c893-442d-9bde-767dc51d69f4"
replace teaching_language = 2 if interview_ID =="7ec5527d-a4cb-4091-9a78-cbaafb13a9f1"
replace teaching_language = 2 if interview_ID =="42d70da8-57f1-4838-9e9b-0b05ae570d0a"
replace teaching_language = 2 if interview_ID =="9f04ec82-5b08-4646-b1cf-a21cb6a6dad1"
replace teaching_language = 2 if interview_ID =="12f73d05-07ac-445f-b39a-e544be52fb5e"
replace teaching_language = 2 if interview_ID =="efad7096-ad35-4f09-9e74-9db263fc6c25"
replace teaching_language = 1 if interview_ID =="41589498-bc0a-4ccd-8d6a-a60de062d072"
replace teaching_language = 1 if interview_ID =="d9c058a2-f459-416c-b9f0-534f64f9b7d4"
replace teaching_language = 1 if interview_ID =="5182809c-6be1-4d73-8abe-6d58632d5aeb"
replace teaching_language = 1 if interview_ID =="a6725c3a-7479-4863-a933-030c458c2b62"
replace teaching_language = 1 if interview_ID =="3122f87b-bf1b-4c4f-a07e-2e891b814b4c"
replace teaching_language = 2 if interview_ID =="fbefabcb-1121-4581-8d69-c984c41835f3"
replace teaching_language = 2 if interview_ID =="0cf45ead-c31f-4ae3-8d5b-f8fa08b303ac"
replace teaching_language = 2 if interview_ID =="5d90539a-62f3-4a00-8832-1ecfdf1ae1f6"
replace teaching_language = 2 if interview_ID =="2ae2dc61-02d9-40a9-b8c2-cbf393293543"
replace teaching_language = 2 if interview_ID =="c8798460-7c04-4e55-8c38-c5878b181758"
replace teaching_language = 2 if interview_ID =="cbab8118-f56c-42ea-9492-e33f984ed12d"
replace teaching_language = 2 if interview_ID =="67bde7d5-edab-46c6-81e2-1e2a028f7bd2"
replace teaching_language = 2 if interview_ID =="92a98231-01ba-42a5-99e4-d875bef42468"
replace teaching_language = 2 if interview_ID =="40176113-04e5-4706-890a-6e3071886ce6"
replace teaching_language = 2 if interview_ID =="7448fb3a-43c9-4dc0-b5b6-ee8daa826016"
replace teaching_language = 2 if interview_ID =="83164ff3-0387-4288-b8ad-84d7afd51043"
replace teaching_language = 2 if interview_ID =="9788ecdb-34e9-4151-b631-ebc71f655869"
replace teaching_language = 2 if interview_ID =="e9fd15ba-5704-40be-8886-6235129bb81d"
replace teaching_language = 2 if interview_ID =="0b0d24ee-3768-458c-99fb-e5b9a7c436f9"
replace teaching_language = 2 if interview_ID =="2edb0e64-35bb-4d15-8a3a-cb2391ae5261"
replace teaching_language = 2 if interview_ID =="b2705db7-9ce4-496b-a525-43668f24cdb1"
replace teaching_language = 2 if interview_ID =="934c7889-6a58-4c21-804a-3051544df184"
replace teaching_language = 2 if interview_ID =="4fecbd87-f37d-4c05-a88d-f04be9e2f50e"
replace teaching_language = 2 if interview_ID =="42d2f51c-7e29-46d1-afa0-921b103cd614"
replace teaching_language = 2 if interview_ID =="0f93b54f-10fa-4768-90c9-a077834b6b67"
replace teaching_language = 2 if interview_ID =="22a8038e-f42d-431b-9d49-988f8256ab01"
replace teaching_language = 2 if interview_ID =="8a077e34-50ca-4abf-9e78-11bae4be830e"
replace teaching_language = 2 if interview_ID =="f86530e0-d0ea-4270-af13-770e86c6106d"
replace teaching_language = 2 if interview_ID =="27e67103-17c2-44e5-913b-74d59f4bcd18"
replace teaching_language = 2 if interview_ID =="40e5e810-5c2c-4878-8637-04d28a3b9803"
replace teaching_language = 2 if interview_ID =="49397fc4-bebe-476e-98f4-841be837510a"
replace teaching_language = 2 if interview_ID =="c682e2c5-747d-4914-9c4d-44fe3ba4942e"
replace teaching_language = 2 if interview_ID =="da9aae0b-7203-4a0f-af5b-285747ec8001"
replace teaching_language = 2 if interview_ID =="307c2f6a-532f-4550-b4f5-cbcffd4e6e23"
replace teaching_language = 2 if interview_ID =="66937495-201b-44b1-a88c-68ce49f0965a"
replace teaching_language = 1 if interview_ID =="133f1d50-bf18-4e92-8d0b-fbd408136c21"
replace teaching_language = 1 if interview_ID =="8a8259b2-9b58-4c5b-971a-43da419b25d6"
replace teaching_language = 1 if interview_ID =="0022196e-5323-4a02-8fab-cd760ad8050e"
replace teaching_language = 2 if interview_ID =="6f0fd177-0b41-4ad9-9b81-3c549450b9c5"
replace teaching_language = 2 if interview_ID =="54b28038-c3a0-4bb9-9ab0-fdf9a3b09c0d"
replace teaching_language = 2 if interview_ID =="3c5a2b32-95d7-4adc-a163-3001d9222415"
replace teaching_language = 2 if interview_ID =="364bb990-2839-4b82-a921-415eb60ff9cc"
replace teaching_language = 2 if interview_ID =="8e7aa582-ed30-44fa-88c9-40e4498dad5d"
replace teaching_language = 2 if interview_ID =="e8bf8d31-3820-4304-b1c5-a3ebb46fb043"
replace teaching_language = 2 if interview_ID =="5377d69c-0544-4c6a-bdbb-1d3c7f85322f"
replace teaching_language = 2 if interview_ID =="fb687117-eb54-4d13-8abe-3dde3321090a"
replace teaching_language = 2 if interview_ID =="8b85d002-0e9d-4f52-845b-d1209d9b286d"
replace teaching_language = 2 if interview_ID =="ac2ff391-8d40-4d62-b200-f71eb71594d3"
replace teaching_language = 2 if interview_ID =="d8716679-ac24-4b0b-8ce2-c9ceef52734c"
replace teaching_language = 2 if interview_ID =="63c36ab0-a1b2-4603-a6cf-e75e3c5540bc"
replace teaching_language = 2 if interview_ID =="aabb8cbe-5c29-42bd-9ba8-ff822c713dd5"
replace teaching_language = 2 if interview_ID =="c436260d-f6a1-4079-9a33-d1a8c634c915"
replace teaching_language = 2 if interview_ID =="56b33386-a47c-43ed-aa24-1ca128fe7cda"
replace teaching_language = 2 if interview_ID =="8324ec5b-0452-4f3f-b027-5f8c7b1ddebe"
replace teaching_language = 2 if interview_ID =="376bab4a-1491-4220-913d-7270c3aa17e3"
replace teaching_language = 2 if interview_ID =="35005e59-b868-4081-89ed-523e4f61d725"
replace teaching_language = 1 if interview_ID =="b109d098-746c-47cf-884f-ed9e2dd05d80"
replace teaching_language = 1 if interview_ID =="b8ac0c0e-aaac-45a7-b689-7f1ebce9d213"
replace teaching_language = 1 if interview_ID =="0f8ff879-aca7-4168-9d16-83b37e608677"
replace teaching_language = 1 if interview_ID =="f956c3d4-1dff-4b76-92ff-c0e21dd1c125"
replace teaching_language = 1 if interview_ID =="90827f4d-6663-4e63-ba1d-463cdbffff10"
replace teaching_language = 1 if interview_ID =="0161bd0b-d890-4618-903c-1515d53d82af"
replace teaching_language = 1 if interview_ID =="f93c5310-6e33-41b3-b2f9-06b713643fa4"
replace teaching_language = 1 if interview_ID =="1f723ffd-ae27-46b3-82cc-e549cc0a6169"
replace teaching_language = 1 if interview_ID =="a231f59d-70f5-47cc-8037-630c1904e920"
replace teaching_language = 1 if interview_ID =="8d872f0a-2776-43aa-8348-6c35ef419609"
replace teaching_language = 1 if interview_ID =="2be263c2-0ef4-4af6-985b-0305b62fcda7"
replace teaching_language = 1 if interview_ID =="08af111c-2a17-4092-b541-919600048748"
replace teaching_language = 1 if interview_ID =="bc1984e9-5936-4a0c-832b-de8cf99916c1"
replace teaching_language = 1 if interview_ID =="103908ef-ba91-4b6a-8921-9971bf647149"
replace teaching_language = 1 if interview_ID =="38dcb5b5-c192-4981-a500-649fef39d8f4"
replace teaching_language = 1 if interview_ID =="e7cc05fb-fdd9-47f8-aae1-39ca408d019a"
replace teaching_language = 1 if interview_ID =="c4c769ff-3656-4ab7-a52e-9f0399b75028"
replace teaching_language = 1 if interview_ID =="9d4eb409-f58e-47ab-909d-20da53882408"
replace teaching_language = 2 if interview_ID =="9e2118c9-7983-4437-9575-e761ed2d0134"
replace teaching_language = 2 if interview_ID =="8bf15f3c-e4d4-46f5-8e40-cf323fdb2538"
replace teaching_language = 2 if interview_ID =="cf055524-a234-4089-9765-107519f136c4"
replace teaching_language = 2 if interview_ID =="85938fbb-5c7e-4ce3-a25d-ce57cd082506"
replace teaching_language = 2 if interview_ID =="1e1d78a8-e27b-481f-9874-9a6bb0fe6474"
replace teaching_language = 2 if interview_ID =="5484aadf-e442-4f79-8789-20ac74dbe32a"
replace teaching_language = 2 if interview_ID =="7cfc7ba3-8034-45b0-938d-a9e163168bd8"
replace teaching_language = 2 if interview_ID =="005009c3-e909-4e85-88a8-f73f1b6dba14"
replace teaching_language = 2 if interview_ID =="77043e12-9ebc-40d9-9674-6c931dc95ea7"
replace teaching_language = 2 if interview_ID =="79b1f3a4-07cc-455f-90ff-fd15ec14d13e"
replace teaching_language = 2 if interview_ID =="d7c72aae-502c-49e5-a49d-9c368fb7820e"
replace teaching_language = 2 if interview_ID =="9400563c-f814-426b-9eac-613b9ee95649"
replace teaching_language = 2 if interview_ID =="7088cd6f-2a3b-419b-bf37-f84bfd9d3d27"
replace teaching_language = 2 if interview_ID =="3c72b0ec-b5e9-4fa6-86b2-8af8462f9069"
replace teaching_language = 2 if interview_ID =="6488c43c-464d-4e99-9122-df910dbfc979"
replace teaching_language = 2 if interview_ID =="c716f745-965e-4d2f-a44c-7f58bb103e07"
replace teaching_language = 2 if interview_ID =="4a5d1807-d4ee-4b01-9acf-2ba308182a6a"
replace teaching_language = 2 if interview_ID =="2fb054a7-6856-4666-b3ac-18cd8a561ef5"
replace teaching_language = 2 if interview_ID =="a231c93c-a596-4098-8c6c-c71b797da48c"
replace teaching_language = 2 if interview_ID =="b954f74b-dfc4-439c-8413-2111eff88307"
replace teaching_language = 2 if interview_ID =="6ab4c570-383c-4a68-9346-1ffc9ae13f64"
replace teaching_language = 2 if interview_ID =="593e9679-60b9-435d-b60a-ce7bd3d4260d"
replace teaching_language = 2 if interview_ID =="86d03738-94f2-40b9-86a5-318a10067f96"
replace teaching_language = 2 if interview_ID =="cf4d3610-079c-47c5-90de-a815ab7deec0"
replace teaching_language = 2 if interview_ID =="7d0be1a1-b3da-47f0-a120-f3b0cc07d4b1"
replace teaching_language = 2 if interview_ID =="e1e8ef67-fcc7-4588-abbf-b8ebf4aa692f"
replace teaching_language = 2 if interview_ID =="d4d130ef-c112-4fe1-bb58-ecb4a1762194"
replace teaching_language = 2 if interview_ID =="100399db-75ea-464f-b099-e2535fc41f22"
replace teaching_language = 2 if interview_ID =="6397be74-47e0-4d9b-8b63-c188ab7575fb"
replace teaching_language = 2 if interview_ID =="15ec73d8-4982-4c7c-b799-f78923569765"
replace teaching_language = 1 if interview_ID =="9721ed24-ebf4-492b-aa39-86be19a76a04"
replace teaching_language = 1 if interview_ID =="3ab31aa2-c6d1-4f54-a991-83e994b51475"
replace teaching_language = 1 if interview_ID =="d95bcb47-6e10-48b2-ad4d-ffdab7d907b6"
replace teaching_language = 2 if interview_ID =="6d84ae33-15f1-4ce8-82de-864a4b19b895"
replace teaching_language = 2 if interview_ID =="ec40656e-85d9-42d6-b58f-6d5f7185d4ce"
replace teaching_language = 2 if interview_ID =="8dd270be-b62a-4245-b0a7-248bacd74759"
replace teaching_language = 2 if interview_ID =="727e3ad9-ac72-48d4-aa3e-0e5b716a9b54"
replace teaching_language = 2 if interview_ID =="df4a690a-1634-47bc-a774-0f08ace38d75"
replace teaching_language = 2 if interview_ID =="f4e45ee0-7748-40a0-a008-21ad870eed41"
replace teaching_language = 2 if interview_ID =="6b4b4967-4cc0-4125-8425-b8f13fe76a62"
replace teaching_language = 2 if interview_ID =="5e54fde5-f8e5-4d96-ae68-a43d0b8ff662"
replace teaching_language = 2 if interview_ID =="e53ac560-8bd1-40ac-a091-9e1f8bdae46a"
replace teaching_language = 2 if interview_ID =="3ea2075d-3aab-4dae-9123-f1901b8cdf9d"
replace teaching_language = 2 if interview_ID =="13c070ee-df05-4eb7-a5a5-26bab8cc7c77"
replace teaching_language = 2 if interview_ID =="5c25b03a-9a37-4434-bd17-3e4cfc14958a"
replace teaching_language = 2 if interview_ID =="d9d0c959-1351-4c1a-b562-8a134de36a69"
replace teaching_language = 2 if interview_ID =="93f86d39-ba63-4d18-a250-a323cf68f5b9"
replace teaching_language = 2 if interview_ID =="f9ad8989-0138-4999-bd66-995531122a82"
replace teaching_language = 1 if interview_ID =="f1481a46-0b7c-48eb-87ca-fc7d5edea6ff"
replace teaching_language = 1 if interview_ID =="147d8351-2200-4be9-85d3-e2a0638bf2fc"
replace teaching_language = 1 if interview_ID =="412e9994-6895-4fd4-bd03-9e7bf6549add"
replace teaching_language = 1 if interview_ID =="b3eb32ed-7a84-4226-a15d-63f8b08ad146"
replace teaching_language = 1 if interview_ID =="40a19e54-fec0-4113-8705-62d81e7ceb0e"
replace teaching_language = 1 if interview_ID =="8177163f-7625-4dbd-809d-b732d2a7e147"
replace teaching_language = 1 if interview_ID =="89468544-65b7-48b1-ac02-513adbdec7c8"
replace teaching_language = 1 if interview_ID =="59cd8d88-f733-4968-9595-a52f1ca5c871"
replace teaching_language = 1 if interview_ID =="e436d9e7-f025-4417-8a92-f207c12b80e6"
replace teaching_language = 1 if interview_ID =="e659cab5-4350-4545-8c86-34953f6572f8"
replace teaching_language = 1 if interview_ID =="21d731ed-9220-4c62-81ba-8362668fb3bf"
replace teaching_language = 1 if interview_ID =="7c364f65-edc0-45a1-b7a5-1244ea6b86af"
replace teaching_language = 1 if interview_ID =="f08bd673-d836-43c2-90d7-31e9c93b24e0"
replace teaching_language = 1 if interview_ID =="0b1d685c-43f1-4e86-acf9-dad33fa23193"
replace teaching_language = 1 if interview_ID =="63d2fd94-0be8-4d25-9d7c-c68666d0496f"
replace teaching_language = 1 if interview_ID =="760e1d70-ed23-41c8-b948-5418982cf879"
replace teaching_language = 1 if interview_ID =="350b2f47-d70d-4bd8-b776-8e88d69608fd"
replace teaching_language = 1 if interview_ID =="8a3b93f4-33ba-47ff-bb1b-b2e688a443a9"
replace teaching_language = 2 if interview_ID =="2607bd7a-1cc4-487e-b7a2-ef3cfec80a34"
replace teaching_language = 2 if interview_ID =="c7606f63-1ef5-4646-aea8-b53a67487306"
replace teaching_language = 2 if interview_ID =="0848f555-cd1b-48bc-b2ff-50c113e317ca"
replace teaching_language = 2 if interview_ID =="bb2bf87c-c047-4b06-a428-6459afd2a21a"
replace teaching_language = 2 if interview_ID =="bccdb567-929f-4527-a73a-c19932fdc331"
replace teaching_language = 2 if interview_ID =="868bc000-7f38-43cb-a98d-2ade6d7d890b"
replace teaching_language = 2 if interview_ID =="809e43dd-445b-4f0f-b939-4cc660ebf6e9"
replace teaching_language = 2 if interview_ID =="834f3169-e6d2-4ebc-aebd-a90b1f7d26ba"
replace teaching_language = 2 if interview_ID =="cd631077-cb46-49fc-92fb-858e5b07a460"
replace teaching_language = 2 if interview_ID =="d35f0a8c-dbff-424a-88fa-20e36d3e3122"
replace teaching_language = 2 if interview_ID =="09d94393-ef48-4f6e-a986-9101e0b5ea26"
replace teaching_language = 2 if interview_ID =="fb51261e-66e8-4153-b26b-c43eb8922dfb"
replace teaching_language = 2 if interview_ID =="525d0f32-4b10-46df-8085-101df30f0867"
replace teaching_language = 2 if interview_ID =="d4b1fc4d-ea5c-4259-8a0b-d29dd35d8791"
replace teaching_language = 2 if interview_ID =="e909215d-9dfa-4fc5-b556-2daf15ec95a4"
replace teaching_language = 1 if interview_ID =="21a66f3a-bc71-463e-9eb7-16237de98482"
replace teaching_language = 1 if interview_ID =="bcbb9b01-4597-413c-a755-060fe9529e89"
replace teaching_language = 1 if interview_ID =="10a8bc73-cebb-40f9-9444-5c70555e0460"
replace teaching_language = 1 if interview_ID =="0bd31c3a-39b8-4ee0-adfe-6676bda58770"
replace teaching_language = 1 if interview_ID =="11e1542c-7a6f-4cda-8a2d-4d444b32bb0e"
replace teaching_language = 1 if interview_ID =="ef44d7e5-b2aa-4e70-918c-6fa9769aa9e3"
replace teaching_language = 1 if interview_ID =="7c170041-8172-4a82-9e34-ced2f756142d"
replace teaching_language = 1 if interview_ID =="4c23d555-924d-47e6-9847-cbec63a31c3d"
replace teaching_language = 1 if interview_ID =="267e82d0-65ca-4ebf-9894-2831d8722d18"
replace teaching_language = 1 if interview_ID =="45df95bd-a12c-4c79-89fa-ddf28e4eec54"
replace teaching_language = 1 if interview_ID =="ced5d636-60ae-4451-a4c6-b2770c945dd9"
replace teaching_language = 1 if interview_ID =="5d67904e-404e-462c-b418-9d57fc153db1"
replace teaching_language = 1 if interview_ID =="1b90b4f4-a457-46b3-9339-c1a565f9ad1e"
replace teaching_language = 1 if interview_ID =="531af313-4452-4698-b88e-37a1cbc6491f"
replace teaching_language = 1 if interview_ID =="a00516de-33bb-4505-a4fd-76a6d98369da"
replace teaching_language = 1 if interview_ID =="90d1e516-786e-4086-96e8-c3a67a7c4209"
replace teaching_language = 1 if interview_ID =="13870a17-8a99-49c5-90e5-81efb14847a3"
replace teaching_language = 1 if interview_ID =="13d63ade-0de2-421d-9650-1a0462a1b01c"
replace teaching_language = 1 if interview_ID =="f1c110e0-8e05-430a-a8cc-a908cc165127"
replace teaching_language = 2 if interview_ID =="99658bc8-57d3-4605-88c9-8799ed7071dc"
replace teaching_language = 2 if interview_ID =="d2c8e352-e00a-4198-a2ed-0b6e7d6ee857"
replace teaching_language = 2 if interview_ID =="468497b9-1cda-4c77-ab00-b456dabf8e5c"
replace teaching_language = 2 if interview_ID =="fa601735-438a-4109-86d9-e7528cc5f004"
replace teaching_language = 2 if interview_ID =="4ed88121-e367-429a-b436-b24a1b96a4b4"
replace teaching_language = 2 if interview_ID =="9277240e-8676-42b3-9c22-4d7c2ec212ae"
replace teaching_language = 2 if interview_ID =="7e4eca1a-2876-4d2c-8db6-d0f4a019d6c0"
replace teaching_language = 2 if interview_ID =="9a973898-aaa0-4497-bbd8-3d3b3c7dc985"
replace teaching_language = 2 if interview_ID =="347f49f8-c6a4-4a79-85f7-48f348b0b22c"
replace teaching_language = 2 if interview_ID =="a679bd63-fe87-431a-9289-8a49d4f8cdf1"
replace teaching_language = 2 if interview_ID =="0d14ac20-94a4-4a65-8cf3-c3390e2bff7d"
replace teaching_language = 2 if interview_ID =="f2911768-555c-4960-88a2-57b48f6f0167"
replace teaching_language = 2 if interview_ID =="a4a6f75f-1744-4db0-80b0-57c6ac0efdd4"
replace teaching_language = 2 if interview_ID =="140ba05b-6b10-4479-afa9-5ee992436213"
replace teaching_language = 2 if interview_ID =="409d7b3a-8a40-4c7b-8cdd-2a976c55c482"
replace teaching_language = 1 if interview_ID =="d1dc00b3-c575-4e71-a3fa-f3b2dc2934dc"
replace teaching_language = 1 if interview_ID =="19f3b3c0-1da2-47ab-960a-bc6f95583939"
replace teaching_language = 1 if interview_ID =="a29f0b55-3b64-4858-b25d-45663ea0930e"
replace teaching_language = 1 if interview_ID =="a2b2d8e6-9d57-408c-b249-77db229e6e3e"
replace teaching_language = 1 if interview_ID =="659b54b7-fd5e-4da0-ae1d-0ede21388735"
replace teaching_language = 1 if interview_ID =="79371bbc-5650-4774-9ade-ce7ad9e666a0"
replace teaching_language = 1 if interview_ID =="8f1f2ccc-cdb5-4ec1-829e-ec35b60e1cd1"
replace teaching_language = 1 if interview_ID =="0bbd9e71-5d5f-46aa-9cc7-d1caa6273895"
replace teaching_language = 1 if interview_ID =="de7235b2-a59c-4a25-af2e-e8f5ac991255"
replace teaching_language = 1 if interview_ID =="8687f9cd-5f4b-4e86-8eb0-4983e57fb21a"
replace teaching_language = 1 if interview_ID =="e6496057-ac93-4eb6-87e0-7bd4bef8db51"
replace teaching_language = 1 if interview_ID =="46b2d1b6-7ad7-48ad-862f-c6be59093ca2"
replace teaching_language = 1 if interview_ID =="076b38de-8e93-4e4c-8424-d615e3032454"
replace teaching_language = 1 if interview_ID =="8a602dc3-a760-4ddd-8f3b-e22bdc6231de"
replace teaching_language = 1 if interview_ID =="cc6f4537-1eb6-4087-8eac-b6ef1672fa01"
replace teaching_language = 1 if interview_ID =="caf321c7-24db-461f-ba82-86efc28d174f"
replace teaching_language = 1 if interview_ID =="1b6c1aa2-32cf-44af-82ef-d9c29588b6f8"
replace teaching_language = 1 if interview_ID =="cb46dbc5-e66d-47fc-9ee3-abe3722fe14c"
replace teaching_language = 2 if interview_ID =="c8020d00-ebb2-4897-af8c-f3130dfdd071"
replace teaching_language = 2 if interview_ID =="0ab65944-d8db-4060-b12c-1448b83c5ebb"
replace teaching_language = 2 if interview_ID =="fbec60cc-fcaa-4356-b916-39a77abffb01"
replace teaching_language = 2 if interview_ID =="e68e4e25-5e58-44bc-82a1-a91be50d9c86"
replace teaching_language = 2 if interview_ID =="1eb910a3-25bf-49d8-99c8-f2cde9df7b0e"
replace teaching_language = 2 if interview_ID =="5b385802-0491-4491-bdba-2325a2837ffd"
replace teaching_language = 2 if interview_ID =="de77bc7d-b8e0-4dad-9374-0fd5286bb74b"
replace teaching_language = 2 if interview_ID =="4a411497-a69c-450a-bb4c-7eaed9562eb9"
replace teaching_language = 2 if interview_ID =="cf9c93a9-cf14-4365-a2d3-f35f982ebefe"
replace teaching_language = 2 if interview_ID =="26744dbe-3bff-49d4-9365-f17807d03196"
replace teaching_language = 2 if interview_ID =="d31e5467-5a1e-4b9c-862f-bcf4a88ca5a8"
replace teaching_language = 2 if interview_ID =="4f598c8f-c1e7-411b-b792-70348d0d2fc1"
replace teaching_language = 2 if interview_ID =="f793c34c-e205-45b6-a95a-d1001a3cd0aa"
replace teaching_language = 2 if interview_ID =="291fd494-f176-4648-b5b0-16d8ec00dff0"
replace teaching_language = 2 if interview_ID =="651b4701-8b4a-48f7-a33c-8df23833864f"
replace teaching_language = 2 if interview_ID =="0e45004c-5467-4074-aa04-882bc5309303"
replace teaching_language = 2 if interview_ID =="3c8790bf-370e-4c1b-a3d2-0e993d6906d9"
replace teaching_language = 2 if interview_ID =="9507645e-04b6-431d-bd2b-a7aaa29e5c52"
replace teaching_language = 2 if interview_ID =="dc56d9f7-e223-4dcb-9b57-d5adf83016ff"
replace teaching_language = 2 if interview_ID =="ffbb69e2-af04-46ef-9436-cbbaf5ad5948"
replace teaching_language = 2 if interview_ID =="bca63a2a-f5b2-4d1b-b222-3af0986af4e6"
replace teaching_language = 2 if interview_ID =="d3cd1046-41d5-4f22-b03b-43a27f2afd64"
replace teaching_language = 2 if interview_ID =="964e7813-4dcd-41a9-9a24-31b13c6717c3"
replace teaching_language = 2 if interview_ID =="1e4f064d-b066-46a2-8460-00d305fc76a1"
replace teaching_language = 2 if interview_ID =="349f35a3-a28a-4ea6-8ccb-a30d43d77365"
replace teaching_language = 2 if interview_ID =="14bf4f59-5843-4c2d-a8aa-aa630dde688c"
replace teaching_language = 2 if interview_ID =="c06481d5-1421-4040-9020-e3a7e3da3b68"
replace teaching_language = 2 if interview_ID =="547a449f-421b-4113-9609-b84a7a2788be"
replace teaching_language = 2 if interview_ID =="51c1e3a5-86dc-4e33-b9af-93f9916fe381"
replace teaching_language = 2 if interview_ID =="8d04d63a-0463-485e-8c65-4f5dde22c672"
replace teaching_language = 1 if interview_ID =="f33e5478-bbdb-43d3-ba0f-23d03414a3a2"
replace teaching_language = 1 if interview_ID =="78f739e4-40ba-4fd9-a89f-4a5a24e5916f"
replace teaching_language = 1 if interview_ID =="0091564e-8b08-4d6e-ad40-4227de59f98f"
replace teaching_language = 2 if interview_ID =="1c09f67b-0b71-4184-9fc8-d44cff5e77c0"
replace teaching_language = 2 if interview_ID =="650b16de-b140-4398-a12f-8be8677c5f4d"
replace teaching_language = 2 if interview_ID =="a4798145-3b1a-4388-a2df-25d6c94e11a5"
replace teaching_language = 2 if interview_ID =="593a8f89-0004-49d8-8704-fa5f4de94310"
replace teaching_language = 2 if interview_ID =="35b58e89-9f50-4f70-8d53-7fb2742e4263"
replace teaching_language = 2 if interview_ID =="890fb8b1-ca30-4e71-8170-f98ca3ed6702"
replace teaching_language = 2 if interview_ID =="a1fac646-c5fa-4c13-8104-dfc8251d33f5"
replace teaching_language = 2 if interview_ID =="da16fb83-fda5-46ce-8bbe-e5be3a1f93b1"
replace teaching_language = 2 if interview_ID =="0e4eb789-f1fb-4fc2-88b7-da36ce003e6b"
replace teaching_language = 1 if interview_ID =="c325dadc-d9f9-4099-a119-4f8c8584e281"
replace teaching_language = 1 if interview_ID =="08862b10-8ada-4b77-8c7d-67992f7fd886"
replace teaching_language = 1 if interview_ID =="9590ca59-9abd-4ab1-a9a6-408e797b213f"
replace teaching_language = 1 if interview_ID =="d6e1aeaa-2d93-464e-99f9-8add288565c1"
replace teaching_language = 1 if interview_ID =="2b20cd41-9150-4214-b47c-a37eb35d06d1"
replace teaching_language = 1 if interview_ID =="e7266a75-dd38-4c1a-a71d-fba6a5e1f694"
replace teaching_language = 1 if interview_ID =="88cacd4e-afbc-404d-aa61-6fa3fe4db9d2"
replace teaching_language = 1 if interview_ID =="391f1d88-7aaf-4fdd-8896-a11499fb84ad"
replace teaching_language = 1 if interview_ID =="fd4a3f34-2a86-42a2-975d-b2368b802ce5"
replace teaching_language = 1 if interview_ID =="a37aff2c-1638-4490-8385-6dede3472366"
replace teaching_language = 1 if interview_ID =="cba5bda6-0e65-4c9d-98a1-2a3f77df9985"
replace teaching_language = 1 if interview_ID =="040d7c69-e9db-4ff1-bee7-28e34a6d3753"
replace teaching_language = 1 if interview_ID =="d9a40e13-ac31-4ef6-8a5a-f4d31b14190e"
replace teaching_language = 1 if interview_ID =="546b49e4-7b07-494a-972a-4ff3ff72b79c"
replace teaching_language = 1 if interview_ID =="c0266bfa-afb4-44f3-aceb-d47a95ccfbf0"
replace teaching_language = 1 if interview_ID =="0ea4943b-dc34-4f8a-91ea-6162aef264e5"
replace teaching_language = 1 if interview_ID =="f13c6700-5ccc-46d4-83a9-16c40e3c80ed"
replace teaching_language = 1 if interview_ID =="94c65d85-4fea-46f2-a855-22691925252a"
replace teaching_language = 2 if interview_ID =="cd74f6b7-2bad-4aa1-9470-a65e17998696"
replace teaching_language = 2 if interview_ID =="84929fc2-93b4-49f8-a1ca-d351189b7776"
replace teaching_language = 2 if interview_ID =="03663b5e-d362-4b70-9161-26ed58361ff8"
replace teaching_language = 2 if interview_ID =="0e25554b-2994-4172-97f8-e4fd21717742"
replace teaching_language = 2 if interview_ID =="76cde405-531c-4b4b-8129-3ddce86fc864"
replace teaching_language = 2 if interview_ID =="2ac36255-8120-486b-9a51-59023326ac7f"
replace teaching_language = 2 if interview_ID =="9a566920-2a29-4145-8d8b-e5d088e6ad92"
replace teaching_language = 2 if interview_ID =="5f1be2e0-7c58-45c4-96dc-33cbb2fa1001"
replace teaching_language = 2 if interview_ID =="cf1d7513-cf7a-4de2-9463-7c14f38933f5"
replace teaching_language = 2 if interview_ID =="72a8311d-32c7-4af9-8b7d-ca80e77633cc"
replace teaching_language = 2 if interview_ID =="b23a63d2-eea4-457c-86eb-daba99215ffa"
replace teaching_language = 2 if interview_ID =="6b81278e-0745-4111-ad93-c814ef8fbbae"
replace teaching_language = 2 if interview_ID =="eda53058-14f1-4799-b06e-6a7cd00d67d6"
replace teaching_language = 2 if interview_ID =="b0cfe5a8-4bc5-4f0b-89ae-d144de74752f"
replace teaching_language = 2 if interview_ID =="3d53427a-0f5f-408c-abf6-24928b722a3d"
replace teaching_language = 2 if interview_ID =="c73b5b79-c5a0-4331-a338-e4f98973d391"
replace teaching_language = 2 if interview_ID =="29760027-f853-478b-9279-8a6e6cb2723c"
replace teaching_language = 2 if interview_ID =="656785d3-59be-4f66-aac8-237d3d296ab8"
replace teaching_language = 1 if interview_ID =="d4c1c3e4-246c-4e46-b259-ceac25113b64"
replace teaching_language = 1 if interview_ID =="5853318d-06ae-44ff-80ce-45fae6168d34"
replace teaching_language = 1 if interview_ID =="6674279f-61dd-40d3-82e6-aaa7d34fc759"
replace teaching_language = 1 if interview_ID =="04de9789-8e99-406b-9d6e-7f060c997c1d"
replace teaching_language = 1 if interview_ID =="de4b028a-033a-4df9-bc0f-2e52bfc9c1a3"
replace teaching_language = 1 if interview_ID =="102ab3e2-73b5-4b98-9254-436bbd2f15be"
replace teaching_language = 1 if interview_ID =="6372c06c-2a46-48ff-9443-8c5fde4f4371"
replace teaching_language = 1 if interview_ID =="3558592f-4ffa-40f1-8545-e26c3ac4c6c8"
replace teaching_language = 1 if interview_ID =="b3d969b0-7f32-45d0-b016-3fae4e4ead36"
replace teaching_language = 1 if interview_ID =="06d394d5-de23-4af0-b8bb-9f7e8890860c"
replace teaching_language = 1 if interview_ID =="5df4ffd0-c3b2-4b72-9007-2c6145f5628a"
replace teaching_language = 1 if interview_ID =="52d26817-da8d-4f36-b5ee-ac63a0025143"
replace teaching_language = 1 if interview_ID =="4a71b3dd-94e5-4b80-923b-6430a15fcc04"
replace teaching_language = 1 if interview_ID =="3723c719-9a07-4447-8ef9-4ad6c38b8264"
replace teaching_language = 1 if interview_ID =="50be20ac-6c07-4d30-9bf3-45e1305770e1"
replace teaching_language = 1 if interview_ID =="3b7be8e4-7ec1-4ed4-adcf-5e04e0a045cf"
replace teaching_language = 1 if interview_ID =="01e00d55-fd1f-4062-abe3-c7eb88690e1e"
replace teaching_language = 1 if interview_ID =="79fc83f4-9851-4bb0-8840-6a77f025e0fe"
replace teaching_language = 1 if interview_ID =="18b59846-d0da-43c8-bf00-c7e71ddbcca2"
replace teaching_language = 2 if interview_ID =="1d2b7177-08c7-417d-9f49-32e671ff0f7b"
replace teaching_language = 2 if interview_ID =="bb0b0a97-754b-4992-a916-feb2be85d2ee"
replace teaching_language = 2 if interview_ID =="ad003360-678d-4610-806f-f8e391bdfcfe"
replace teaching_language = 2 if interview_ID =="ee89df31-1430-4b7e-95e5-27b2a83ad8c9"
replace teaching_language = 2 if interview_ID =="cc7279f7-25b2-4e36-aca9-1fa64dac3f6a"
replace teaching_language = 2 if interview_ID =="6a3df464-5eb5-4e79-b97b-cb3ea2c9ad6e"
replace teaching_language = 2 if interview_ID =="6da62714-f01e-4468-8aca-2df50b814676"
replace teaching_language = 2 if interview_ID =="28eded12-98f1-48e0-af1f-3a5d469d1e6f"
replace teaching_language = 2 if interview_ID =="c21eea29-d5cd-479b-88f8-36330279596e"
replace teaching_language = 2 if interview_ID =="2b1ece95-8d67-4691-b436-f4351f2ffbb2"
replace teaching_language = 2 if interview_ID =="e30ad39d-2716-470f-bec7-0a11204f1057"
replace teaching_language = 2 if interview_ID =="f544bee7-8108-4fab-8117-a6e21c17414d"
replace teaching_language = 2 if interview_ID =="0a6368e9-ea81-4d02-a9c7-15ebe8fbcea4"
replace teaching_language = 2 if interview_ID =="1a3e9111-5558-4f07-aceb-850d3b1b806a"
replace teaching_language = 2 if interview_ID =="aa705510-01bc-4030-81ae-ba6279c3d234"
replace teaching_language = 2 if interview_ID =="6a929c65-7741-4c33-b743-1d088af226b1"
replace teaching_language = 2 if interview_ID =="d0560bb6-122c-48f7-b94b-4b357b6c88e6"
replace teaching_language = 2 if interview_ID =="ea24c04f-3b14-47fe-890f-d483a586c430"
replace teaching_language = 2 if interview_ID =="9ee1d44a-3aac-4528-88d6-e2382ae3e55e"
replace teaching_language = 2 if interview_ID =="33c2d3ad-7dff-495f-b985-547e15c11400"
replace teaching_language = 2 if interview_ID =="8fc5ac8f-5454-4a1c-854d-92d530bc1ceb"
replace teaching_language = 2 if interview_ID =="f1dfc244-9ea0-4c37-91f8-1fa1e4739f92"
replace teaching_language = 2 if interview_ID =="d0ec1b72-c94a-459c-9e7e-262643185722"
replace teaching_language = 2 if interview_ID =="19e598a3-682e-4adb-a789-2b559bb446b6"
replace teaching_language = 2 if interview_ID =="424b3f7b-358e-4f5e-917c-39b960338ff4"
replace teaching_language = 2 if interview_ID =="72d458bc-35dc-4ff2-bbf0-8f201aa7911a"
replace teaching_language = 2 if interview_ID =="628a445c-5a0a-455d-940a-d81920166473"
replace teaching_language = 2 if interview_ID =="f4812f80-450b-4c0d-86ed-a21356e88b61"
replace teaching_language = 2 if interview_ID =="3f3aa98d-d947-4d37-b350-97760472ced6"
replace teaching_language = 2 if interview_ID =="27744365-5cdd-4c2d-a888-586a0c2ec52d"
replace teaching_language = 2 if interview_ID =="9e93324a-eb17-4be3-b915-ea64ff1075a8"
replace teaching_language = 2 if interview_ID =="fadf56f5-88a6-421f-a1f8-806770b21676"
replace teaching_language = 2 if interview_ID =="997e5583-3507-4899-9af6-a97269562087"
replace teaching_language = 2 if interview_ID =="3de165ae-da16-46c8-886a-224eaeb499a7"
replace teaching_language = 2 if interview_ID =="fd3d8e7b-b6d9-4e5d-b023-fba94faf264f"
replace teaching_language = 1 if interview_ID =="37669e6e-dfe9-445e-ae7e-b50a5707510b"
replace teaching_language = 1 if interview_ID =="b5a39bbe-530d-459d-8f76-bcef1cb865f7"
replace teaching_language = 1 if interview_ID =="9a0ebaef-434f-4cbf-bcfa-9d5df07d9c1c"
replace teaching_language = 2 if interview_ID =="44f44ace-fe6d-4c14-aee9-af0c5227c282"
replace teaching_language = 2 if interview_ID =="57638b8d-f407-41e4-896a-a2598b08d16e"
replace teaching_language = 2 if interview_ID =="e1fb7752-1723-45c6-9cf3-48bdd9246b14"
replace teaching_language = 2 if interview_ID =="c805806c-fc82-404a-8a52-ec5cae292014"
replace teaching_language = 2 if interview_ID =="a4a0ff2f-0ac2-4f23-a390-b4f3a7dc1261"
replace teaching_language = 2 if interview_ID =="dd2019e6-d5da-4e39-a73e-086054939141"
replace teaching_language = 2 if interview_ID =="8aa09fba-4da6-49e4-ac56-e6aefbb9b367"
replace teaching_language = 2 if interview_ID =="fdcd7834-8d95-4012-94a7-4b698a0de52f"
replace teaching_language = 2 if interview_ID =="5c8de8ad-10fc-4c1e-90dc-f867e01e3a57"
replace teaching_language = 2 if interview_ID =="68d86be1-6336-4660-9650-97872f2cccb6"
replace teaching_language = 2 if interview_ID =="8c7b41f8-1a25-4110-84dd-b6bf5da0a761"
replace teaching_language = 2 if interview_ID =="c9a3f1c0-2b55-4024-8a07-f8085c9087a7"
replace teaching_language = 2 if interview_ID =="2c9b3e83-0ab8-4137-8a81-3bf80bf7fa31"
replace teaching_language = 2 if interview_ID =="6d747a9f-dd07-4ffa-80f0-6021c2b9f67b"
replace teaching_language = 2 if interview_ID =="9af25dcc-065d-4c76-b6b5-055b5f8e588b"
replace teaching_language = 1 if interview_ID =="6f8b4d38-aa24-4757-8a89-1fddee27f57d"
replace teaching_language = 1 if interview_ID =="063fcc01-ae23-4446-8a2e-7178c2c2ffe0"
replace teaching_language = 1 if interview_ID =="f8ed41d1-08c3-4302-9edd-7d1e6ca898ba"
replace teaching_language = 1 if interview_ID =="d101ffb3-b65c-4cdb-b72b-f064d8a02b37"
replace teaching_language = 1 if interview_ID =="9879793b-d763-465b-a8f3-0a0fc17b978f"
replace teaching_language = 1 if interview_ID =="b357ca16-5891-494b-981c-07200c5d0908"
replace teaching_language = 1 if interview_ID =="e56b2fd1-6f0d-459a-a095-d880376a2a19"
replace teaching_language = 1 if interview_ID =="fda035dd-0a5f-4207-b1fe-d3df9b1726ab"
replace teaching_language = 1 if interview_ID =="350b15fa-d5f7-44dd-b687-23b3042918e3"
replace teaching_language = 1 if interview_ID =="debc8d8a-0fa4-409d-854b-219978905cd5"
replace teaching_language = 1 if interview_ID =="ab8326a7-3a0c-431d-877d-d4cdcbc56274"
replace teaching_language = 1 if interview_ID =="67f4c0d7-a875-42e7-8b0d-7de9ee9f1705"
replace teaching_language = 1 if interview_ID =="9512b111-ff69-4336-8725-f338f37b6ef5"
replace teaching_language = 1 if interview_ID =="cc3f7cd2-6f52-4bd7-9e2f-1b2d5de6469f"
replace teaching_language = 1 if interview_ID =="50ea4e94-ef69-4780-85c1-b54a57dce063"
replace teaching_language = 1 if interview_ID =="14421726-3c81-4ac4-bb1c-6171fc59e9ec"
replace teaching_language = 1 if interview_ID =="8219db24-0bf3-4dea-b7fd-1a4649f9bf44"
replace teaching_language = 1 if interview_ID =="f35b6dd8-d967-4933-811d-52c700091673"
replace teaching_language = 2 if interview_ID =="d560d936-eb98-414d-a84d-a4479cd6aeab"
replace teaching_language = 2 if interview_ID =="0a708281-face-43a6-9d7c-36699bad832d"
replace teaching_language = 2 if interview_ID =="e9b9861a-b159-4d57-815e-9375aaf388db"
replace teaching_language = 2 if interview_ID =="9978a876-070b-4069-9e42-fced11b57a75"
replace teaching_language = 2 if interview_ID =="24d9823d-de5f-4791-b3cb-244f4b0e093a"
replace teaching_language = 2 if interview_ID =="53bb2b77-1abd-4bc6-96d7-fb03ba1924cb"
replace teaching_language = 2 if interview_ID =="03c5cab6-dde7-4b4d-9eda-fb331528eec0"
replace teaching_language = 2 if interview_ID =="2fd9700a-9684-43da-8ec1-87f3f7240b80"
replace teaching_language = 2 if interview_ID =="de3b2603-110a-434f-a480-eece8ed13fa8"
replace teaching_language = 2 if interview_ID =="3c96f255-bc73-4f4d-9d00-cf18ec8dd369"
replace teaching_language = 2 if interview_ID =="28e1e7b8-cfe3-4125-a1d2-73f26d94f386"
replace teaching_language = 2 if interview_ID =="96b9fc87-6027-4776-b27b-a67694c116f7"
replace teaching_language = 2 if interview_ID =="da14f1da-21db-446a-8464-3575a346b7db"
replace teaching_language = 2 if interview_ID =="0a2ee12c-bcf7-4010-8bce-b1dc5e6ddd89"
replace teaching_language = 2 if interview_ID =="cf83a628-ff29-4c73-b243-c5da9dc3b6bd"
replace teaching_language = 2 if interview_ID =="d244a3be-86b6-4158-8d14-bd7a91863ea6"
replace teaching_language = 2 if interview_ID =="e759f90a-eaab-4945-ad3c-905eeb103b9f"
replace teaching_language = 2 if interview_ID =="53c34665-36fa-43c2-9bd2-c9a0b9f44362"
replace teaching_language = 2 if interview_ID =="5974c557-a87d-4e80-9bf1-e0023e71a431"
replace teaching_language = 2 if interview_ID =="9d83bf34-22e7-4c5d-9469-d9eadb9e651b"
replace teaching_language = 2 if interview_ID =="cb637296-8da2-4a9b-a909-524045454c2b"
replace teaching_language = 2 if interview_ID =="375bc08b-7bd4-424f-8265-ee6d497a0768"
replace teaching_language = 2 if interview_ID =="70794d12-e969-47fa-834f-2878485c0e03"
replace teaching_language = 2 if interview_ID =="16d0f3fc-4e6e-43ea-8e73-661879b5f7dd"
replace teaching_language = 2 if interview_ID =="b6ada92b-db03-4fb8-ae3c-aa68909d7c20"
replace teaching_language = 2 if interview_ID =="ab219bc7-b750-4c74-bff8-2bb8aca3abef"
replace teaching_language = 2 if interview_ID =="f58d649d-1f91-4065-bf3f-14028ccd27d1"
replace teaching_language = 2 if interview_ID =="7af04de7-7940-45ec-a1ce-6ee9d54f43fc"
replace teaching_language = 2 if interview_ID =="e4e63c62-60c5-4d52-a6ab-86ed7145f276"
replace teaching_language = 2 if interview_ID =="974cc3fd-c44a-4a1a-b1bd-912aab377b65"
replace teaching_language = 1 if interview_ID =="72c68a36-5d76-4704-a67b-38fbf618767a"
replace teaching_language = 1 if interview_ID =="dcfa7e1d-12a5-44b3-a225-b7c4edea1dd6"
replace teaching_language = 1 if interview_ID =="4fa29a30-2456-440d-98cf-48f5fb309172"
replace teaching_language = 2 if interview_ID =="65218e1c-f9e1-42ae-8005-a0dcd0f358b2"
replace teaching_language = 2 if interview_ID =="6bd6581b-8063-4cb6-a92e-d3f7eaa0b11c"
replace teaching_language = 2 if interview_ID =="664c5d1c-1210-4aaf-b804-5b42b7057989"
replace teaching_language = 2 if interview_ID =="687b58cd-3781-4864-8956-3254c912f3dc"
replace teaching_language = 2 if interview_ID =="b02ce9c0-b874-471b-8707-12ab174e2cfa"
replace teaching_language = 2 if interview_ID =="cdacae65-f165-42ee-8668-d30927fa89b4"
replace teaching_language = 2 if interview_ID =="c6a16bb2-d364-4b73-b565-d395ce7389fc"
replace teaching_language = 2 if interview_ID =="2eeabd68-3ed4-49f5-a54d-375966e9f7e8"
replace teaching_language = 2 if interview_ID =="64917000-39cf-452e-9240-1e1bf852a463"
replace teaching_language = 2 if interview_ID =="38bdc126-72b7-4df0-8444-c471ca2a87e4"
replace teaching_language = 2 if interview_ID =="323e8c24-dd56-4749-a507-d0699efc9619"
replace teaching_language = 2 if interview_ID =="a83d057f-42b8-4ce6-a7e3-c2fb4f1e9cf4"
replace teaching_language = 2 if interview_ID =="80f5c997-81f6-4501-b289-0acbe647690f"
replace teaching_language = 2 if interview_ID =="cf312148-2827-44f9-9692-be0c45a36cfb"
replace teaching_language = 2 if interview_ID =="0dd59e1c-563b-4e90-bbc0-b27be3e787a9"
replace teaching_language = 2 if interview_ID =="64f00d50-e875-4e77-92c1-f4d53ba1a922"
replace teaching_language = 2 if interview_ID =="d0273b2f-d376-49d6-b1dc-82fc45816d0d"
replace teaching_language = 2 if interview_ID =="8e4d65c3-818e-4291-b81a-02b7829201cd"
replace teaching_language = 2 if interview_ID =="33af1dd8-7b97-40ca-90a3-ff9bf5cc78b9"
replace teaching_language = 2 if interview_ID =="18e148e8-0d56-481d-addc-401cd8a79600"
replace teaching_language = 2 if interview_ID =="c9405d9c-7a1e-4555-9180-eab8f2d4bfd0"
replace teaching_language = 2 if interview_ID =="470b9801-2689-4ada-a803-4c9966115ef8"
replace teaching_language = 2 if interview_ID =="7a7ca376-9da9-4ba4-a445-802999b1d569"
replace teaching_language = 2 if interview_ID =="4e6377e5-fe7e-4208-a1fd-df6cc3cee14f"
replace teaching_language = 2 if interview_ID =="6f2c99cb-779a-47ef-ba75-450073085f94"
replace teaching_language = 2 if interview_ID =="f0812c8f-4b08-4d71-b9a0-68c15232cae5"
replace teaching_language = 2 if interview_ID =="7ed319c3-de86-4ac2-a470-a5ad9b450233"
replace teaching_language = 2 if interview_ID =="18feea2a-c4dc-4c58-99db-155d2123163a"
replace teaching_language = 2 if interview_ID =="fc083b06-21a2-4665-8228-d741d3d22d15"
replace teaching_language = 2 if interview_ID =="4aad058f-af72-471c-95cb-20e762b2f6d8"
replace teaching_language = 2 if interview_ID =="2fbdb190-ce6b-4db3-bd3d-86eeb77f4c2f"
replace teaching_language = 1 if interview_ID =="ccecdd5b-5546-4568-ac8c-ce6ba135389c"
replace teaching_language = 1 if interview_ID =="34240a67-95fe-48e6-9dc3-481a5eb995f8"
replace teaching_language = 1 if interview_ID =="c5b9df03-6d52-4892-adca-8088ccece9ae"
replace teaching_language = 1 if interview_ID =="f472aa19-e4ee-4e09-b6ab-8bd600de957d"
replace teaching_language = 2 if interview_ID =="ec399d0c-8225-4b25-a76a-bb8738a2a86c"
replace teaching_language = 2 if interview_ID =="c931fa81-b717-4113-8476-82b40330fed9"
replace teaching_language = 2 if interview_ID =="09ddc276-9010-4c57-89c7-69894da59702"
replace teaching_language = 2 if interview_ID =="9ca642cd-3b03-4eea-8667-d6192151802e"
replace teaching_language = 2 if interview_ID =="14f713b8-a0d5-4178-ae6c-9ad6c84c1700"
replace teaching_language = 2 if interview_ID =="67b71d7b-c519-402a-8ecb-9bff07849803"
replace teaching_language = 2 if interview_ID =="430c6a4d-bbc0-4d38-800a-96385b360a73"
replace teaching_language = 2 if interview_ID =="c546b85b-b5f2-4cb6-8487-af253270a1c9"
replace teaching_language = 2 if interview_ID =="3cac5927-3590-4ae1-bf72-3e52afe1eb6e"
replace teaching_language = 2 if interview_ID =="ae1980e9-afef-4339-9c27-77470e204195"
replace teaching_language = 2 if interview_ID =="2d28c81c-4180-4486-b04b-656cfd91dd55"
replace teaching_language = 2 if interview_ID =="6f13e3d7-c2ed-4750-a156-515989af35bd"
replace teaching_language = 2 if interview_ID =="a4fbe54f-4518-449e-952d-fe1bf62e816b"
replace teaching_language = 2 if interview_ID =="9852ca2d-c63f-4aa6-ad7e-7f9a1489ae0b"
replace teaching_language = 2 if interview_ID =="d9823d86-d6bb-45da-ae53-fec4fdc817d8"
replace teaching_language = 2 if interview_ID =="c394122b-92ee-4d38-9b95-30c519615dee"
replace teaching_language = 2 if interview_ID =="acd37270-5639-4e87-8454-31e3f4356b91"
replace teaching_language = 2 if interview_ID =="16c3c3a6-3b32-4a80-877a-98f8bfcf3c43"
replace teaching_language = 2 if interview_ID =="2a739f6e-0d1b-483c-8521-135a7ed503ac"
replace teaching_language = 2 if interview_ID =="3461019a-7193-41df-bd17-f115fd78a393"
replace teaching_language = 2 if interview_ID =="e843d0f3-9152-4d8b-a69b-1993c6e1a7e9"
replace teaching_language = 2 if interview_ID =="22835368-e385-4f78-be11-a1c5e7009d07"
replace teaching_language = 2 if interview_ID =="46f6a5bf-51cd-47c0-a986-847311cc5b16"
replace teaching_language = 2 if interview_ID =="1f76e176-f144-4136-bc46-485df4faaae5"
replace teaching_language = 2 if interview_ID =="b14c7f78-4875-4073-8c5a-490d4a7fbade"
replace teaching_language = 2 if interview_ID =="1af7bd56-15e2-4eb9-8f02-456531b6ae84"
replace teaching_language = 2 if interview_ID =="11e9e8f6-b131-4016-95ce-938c2c1cb711"
replace teaching_language = 2 if interview_ID =="0d55b670-abb7-40c0-80b0-d8a2e74b37b7"
replace teaching_language = 2 if interview_ID =="6d68e781-f3cc-4c01-9617-07d23e54c447"
replace teaching_language = 2 if interview_ID =="f5a4d9c3-6d75-4365-aa7a-66e30ea33d46"
replace teaching_language = 1 if interview_ID =="da961432-3710-4522-be2e-a0c17f8e3d39"
replace teaching_language = 1 if interview_ID =="d1091924-cb35-4ab2-9282-c2c173b834b1"
replace teaching_language = 1 if interview_ID =="ab9b17e8-ca29-40a6-bbfc-aaad23021fce"
replace teaching_language = 2 if interview_ID =="96c50de6-a383-4198-a9df-d2dc2e6c678c"
replace teaching_language = 2 if interview_ID =="906e0544-b353-4f21-8cf8-6822ef276d26"
replace teaching_language = 2 if interview_ID =="f08a1fda-e0be-4c34-abb3-7b913c02f3de"
replace teaching_language = 2 if interview_ID =="2e1d1197-4bb8-43ee-8ec6-43c71f5fc1af"
replace teaching_language = 2 if interview_ID =="3ab06563-d43a-4539-8a4a-2fe171d9f713"
replace teaching_language = 2 if interview_ID =="bdadd3b8-489c-4838-a596-a385068734de"
replace teaching_language = 2 if interview_ID =="9aa0c22e-d171-4b2d-a3c7-37fdcd43484b"
replace teaching_language = 2 if interview_ID =="bb896380-88b3-426b-b1cb-c992b1145c15"
replace teaching_language = 2 if interview_ID =="016920bf-44b8-4d91-a780-c6a0e957484d"
replace teaching_language = 2 if interview_ID =="74090fe3-0a3a-42e9-8ead-f0094f456ba0"
replace teaching_language = 2 if interview_ID =="74a5d05b-d0ef-46ff-a1f8-ef76b03464ce"
replace teaching_language = 2 if interview_ID =="f497c2b1-6436-4d4a-80d5-c36f7c31aafc"
replace teaching_language = 2 if interview_ID =="775fdf37-148c-42cf-9e6e-789e29b752e0"
replace teaching_language = 2 if interview_ID =="db2a1029-6203-4feb-ae64-d1cc97c59a05"
replace teaching_language = 2 if interview_ID =="0a577b6e-cc63-4521-8d03-2c451dce2ec4"
replace teaching_language = 1 if interview_ID =="e6112283-c0b2-4c38-8292-1ffa830d7dc8"
replace teaching_language = 1 if interview_ID =="0c162021-056f-46dc-bcc8-f90dae15a258"
replace teaching_language = 1 if interview_ID =="4eae42ee-944c-48e1-a67e-650538cc8941"
replace teaching_language = 1 if interview_ID =="49d3258b-2f7f-4a5b-b7da-a94119a1741d"
replace teaching_language = 1 if interview_ID =="abfc3392-0f4d-4f43-aa78-9674ebe6e7f5"
replace teaching_language = 1 if interview_ID =="bba9da36-baf3-489d-8964-49514a08ae95"
replace teaching_language = 1 if interview_ID =="183f8321-4aef-42fc-9e54-7bc3074434ab"
replace teaching_language = 1 if interview_ID =="b508dc8b-253b-42b1-b88f-435fdbe52869"
replace teaching_language = 1 if interview_ID =="658ec4d3-306c-4b9d-98f4-fd5e6b8c505c"
replace teaching_language = 1 if interview_ID =="15461490-488f-4c17-b558-cbb64a3856f6"
replace teaching_language = 1 if interview_ID =="2d4589ca-0227-430d-ab9d-3f48b9852abb"
replace teaching_language = 1 if interview_ID =="e8fbcbb2-989f-4cf3-961b-af85d0873607"
replace teaching_language = 1 if interview_ID =="02ba99b6-0242-4081-b8d8-66a89cbea000"
replace teaching_language = 1 if interview_ID =="df33a347-224b-4d44-b56a-ff31036cff13"
replace teaching_language = 1 if interview_ID =="9c860851-1a8c-4863-8c3a-04b86c54fcb6"
replace teaching_language = 1 if interview_ID =="958c05fe-fa40-4655-b83a-c9653c7ddfd4"
replace teaching_language = 1 if interview_ID =="70692290-12f9-4600-8e8b-161b8d6b6dd8"
replace teaching_language = 1 if interview_ID =="783e1cc0-24e8-412c-a669-75c9a0361d56"
replace teaching_language = 2 if interview_ID =="555533d0-d12b-4ed1-9790-06efa34ed08a"
replace teaching_language = 2 if interview_ID =="6d0fdc25-875c-4e3f-ab22-c5f2ed403c40"
replace teaching_language = 2 if interview_ID =="a45d33f2-93a9-4cd3-be9d-bc103c9cc841"
replace teaching_language = 2 if interview_ID =="df3f0ed7-6a19-4c8b-b3b9-1eb24df460f0"
replace teaching_language = 2 if interview_ID =="4a34a731-ce03-4677-92ce-c55f3289448d"
replace teaching_language = 2 if interview_ID =="b174921d-b295-4c02-aa57-9e95b15df1a0"
replace teaching_language = 2 if interview_ID =="9ffb65da-52b0-4eca-85d1-ce56cd1f8d6a"
replace teaching_language = 2 if interview_ID =="39204958-dd1a-4374-ba28-3c6abf7bff18"
replace teaching_language = 2 if interview_ID =="3cae6a7b-d625-4998-a811-18f65c9b729b"
replace teaching_language = 2 if interview_ID =="464c0162-ae05-475b-a08d-c8649309b53f"
replace teaching_language = 2 if interview_ID =="e90ee702-0d0c-40b7-821c-9e1dc99f815c"
replace teaching_language = 2 if interview_ID =="dc8f2d6c-616d-48e7-ad32-c4a426bacb8c"
replace teaching_language = 2 if interview_ID =="bb779fdf-2173-47ea-9670-321b3af30723"
replace teaching_language = 2 if interview_ID =="6256b3fb-c6c8-4c33-a9bd-6e41309ea0d6"
replace teaching_language = 2 if interview_ID =="21fe13d4-aa5d-4d75-a8b8-89938f7aeaa0"
replace teaching_language = 1 if interview_ID =="5e530301-bd1f-47d9-8246-7b179e9581b1"
replace teaching_language = 1 if interview_ID =="8fbba011-20fc-44f8-bfd9-bc88dda6e226"
replace teaching_language = 1 if interview_ID =="12d723f2-7eb9-47d8-80da-2662dda0f6c3"
replace teaching_language = 1 if interview_ID =="4de80865-2357-4b0e-b2da-de592221282b"
replace teaching_language = 1 if interview_ID =="610796e6-a3cf-4adb-8ae3-cd7db278d7df"
replace teaching_language = 1 if interview_ID =="69254ce2-3130-44d8-a88c-a3b680a489be"
replace teaching_language = 1 if interview_ID =="49800590-5166-4ce7-a1a3-1b78054fedd9"
replace teaching_language = 1 if interview_ID =="79550c2e-4086-4f10-833d-7fe80f4c9049"
replace teaching_language = 1 if interview_ID =="78e94deb-38c9-425c-b647-739d3038e60b"
replace teaching_language = 1 if interview_ID =="13188a78-9a7c-40ba-97de-a2b8fd01a954"
replace teaching_language = 1 if interview_ID =="55458af1-cf96-42fb-8a23-9c3a0709a177"
replace teaching_language = 1 if interview_ID =="6b2ecac7-7cc7-4c3b-a2e7-ac9e55a53d3b"
replace teaching_language = 1 if interview_ID =="ec55c3ad-013d-4b7a-88d6-4d2c5fb95f34"
replace teaching_language = 1 if interview_ID =="9407e1f0-3279-43ec-8d90-86699d9795ef"
replace teaching_language = 1 if interview_ID =="214d5cec-e73b-4410-afa7-f373842ccecb"
replace teaching_language = 1 if interview_ID =="9481b061-9639-4d55-8ed1-e35c47cd297e"
replace teaching_language = 1 if interview_ID =="e7745731-8ebf-4eeb-8ee6-0cc3f33d7d02"
replace teaching_language = 1 if interview_ID =="69de2c51-b0f6-4eaa-8a9a-f1d6ea1a8d01"
replace teaching_language = 1 if interview_ID =="c6d60e7e-7eb8-48a8-9c33-4ae90f6a28b5"
replace teaching_language = 1 if interview_ID =="bc757bad-3857-4a98-b6e5-414094eba822"
replace teaching_language = 1 if interview_ID =="50e76470-2f86-4ae1-a6c3-714d27a72cda"
replace teaching_language = 2 if interview_ID =="5875efa2-2b0b-4353-b809-e69b1c767cc7"
replace teaching_language = 2 if interview_ID =="ad3984b4-91a8-4eac-a191-7792a2cb7afa"
replace teaching_language = 2 if interview_ID =="48fecf30-0640-4af1-8b4f-1670f4eccce4"
replace teaching_language = 2 if interview_ID =="ecd24a66-fb95-406e-a056-30c082ccc370"
replace teaching_language = 2 if interview_ID =="6e7f9918-5edb-4594-a405-258d4fbf7544"
replace teaching_language = 2 if interview_ID =="6825d049-f11e-45de-b7b2-2666e15836d1"
replace teaching_language = 2 if interview_ID =="69f9e382-d113-43a8-9c2d-d7a4c30f9553"
replace teaching_language = 2 if interview_ID =="8290158c-8202-4707-a821-c6ca4e5f4cf7"
replace teaching_language = 2 if interview_ID =="f1c124d6-14eb-4864-8c48-b455c5aa8b7c"
replace teaching_language = 2 if interview_ID =="e1d5d06e-04d1-488f-9f20-0be1971b0b14"
replace teaching_language = 2 if interview_ID =="1ccccc68-0735-4dab-b908-a0d3a80a4c9a"
replace teaching_language = 2 if interview_ID =="ef097054-041a-4ff4-985f-27d9e373255e"
replace teaching_language = 2 if interview_ID =="b2810855-8afa-47f4-b6fa-9c5ebb61fba4"
replace teaching_language = 2 if interview_ID =="27ff1a9b-b5d9-4ed0-9fc5-a3dcc1e64519"
replace teaching_language = 2 if interview_ID =="d80424bc-7e1a-41a9-bf1d-12d1816dc263"
replace teaching_language = 1 if interview_ID =="d4172b31-e410-4ae7-9e35-df10df8671e3"
replace teaching_language = 1 if interview_ID =="16de6940-63b3-46ea-bbe8-bbcb02e7f9fe"
replace teaching_language = 1 if interview_ID =="aeb77b3b-a96e-4a1c-ae7f-b754451a031c"
replace teaching_language = 1 if interview_ID =="7087399a-267a-4133-9cc7-7644242512f2"
replace teaching_language = 1 if interview_ID =="19c90d12-faee-4cff-a467-a7a2f641217a"
replace teaching_language = 1 if interview_ID =="176f8d21-9fa1-4f6c-8fa4-b573f9a3b530"
replace teaching_language = 1 if interview_ID =="6183e847-88b6-42c2-9909-85dd21245dcb"
replace teaching_language = 1 if interview_ID =="8557f1b8-ea2a-4349-b4ae-798ca152f689"
replace teaching_language = 1 if interview_ID =="eab63d34-d938-449e-ab1d-55de9b38c544"
replace teaching_language = 1 if interview_ID =="cc4ccbd3-15ab-4f89-b523-6aaba6d526e9"
replace teaching_language = 1 if interview_ID =="c9c31e8d-6685-43f6-abdb-acb22510e956"
replace teaching_language = 1 if interview_ID =="a42aba02-cab6-41d1-9b06-51993db00fa1"
replace teaching_language = 1 if interview_ID =="ae1ce825-0716-42b8-8df0-f4c03de0b574"
replace teaching_language = 1 if interview_ID =="9addcb66-6624-448d-903a-941401b8161d"
replace teaching_language = 1 if interview_ID =="2d855cfe-06f0-4c0f-88b6-4e2f1b6e9659"
replace teaching_language = 1 if interview_ID =="4592a6d6-e884-4dcf-9010-cf8ac8140ede"
replace teaching_language = 1 if interview_ID =="695d3744-bced-4b2d-a3c7-f9dab6c0dd92"
replace teaching_language = 1 if interview_ID =="fd081796-3a85-40a8-9ac2-0ab56af3c176"
replace teaching_language = 2 if interview_ID =="25e1985c-5e06-4ef1-ba45-6b398aeb169e"
replace teaching_language = 2 if interview_ID =="ec52ca6a-e5c7-4623-9243-e5df726fd976"
replace teaching_language = 2 if interview_ID =="8c2ecbf2-9074-4d91-b8e7-2a7ef846751f"
replace teaching_language = 2 if interview_ID =="d79365ce-4c42-4809-aa2c-946f8e9c93e8"
replace teaching_language = 2 if interview_ID =="c660cb0a-d38d-41a1-af98-67fc14ed4c80"
replace teaching_language = 2 if interview_ID =="3d25277c-643a-4018-99a5-8790056f7d3c"
replace teaching_language = 2 if interview_ID =="54450ef7-08f0-4f9a-a288-f09d7a6c382d"
replace teaching_language = 2 if interview_ID =="a59b6d10-2cb8-4c01-8442-e59478955834"
replace teaching_language = 2 if interview_ID =="3ecc7557-2ef0-4c1b-b5b2-90f37e31f222"
replace teaching_language = 2 if interview_ID =="8e1d6743-df27-4079-bde4-a00f9294cda5"
replace teaching_language = 2 if interview_ID =="4083fe67-451e-4a15-a734-39889c212010"
replace teaching_language = 2 if interview_ID =="849563d3-9773-4a1d-89d8-b7b3a16beb89"
replace teaching_language = 2 if interview_ID =="ae218944-f91c-4924-b5ea-1b31a3b0f013"
replace teaching_language = 2 if interview_ID =="2f95b04e-68ef-4dec-bba4-0aa80fe4c337"
replace teaching_language = 2 if interview_ID =="885dc384-3d97-48bb-b8f6-fdf5c3fc41e9"
replace teaching_language = 2 if interview_ID =="de6386c0-0baf-49b3-bffb-3cac46465ed0"
replace teaching_language = 2 if interview_ID =="04af0d11-cd0a-438a-84b3-b07badf6126d"
replace teaching_language = 1 if interview_ID =="bd27d281-449a-4618-821f-cd292ab0ba3c"
replace teaching_language = 1 if interview_ID =="473f0212-5fef-4f20-8d23-82de99369d7d"
replace teaching_language = 1 if interview_ID =="e5ffddbc-31f4-41e2-a5ad-a63bf0a2f196"
replace teaching_language = 1 if interview_ID =="5c83cb5c-2fbe-498a-9f67-94072021d431"
replace teaching_language = 1 if interview_ID =="4bb9439e-83db-41e3-873d-67a4d77efc3e"
replace teaching_language = 1 if interview_ID =="16bfd78f-5de7-4fe9-aa6c-919d8887369c"
replace teaching_language = 1 if interview_ID =="fb9c234b-de3a-40b1-877d-e0774134e95a"
replace teaching_language = 1 if interview_ID =="4644aea1-f044-4cb4-b79a-638800249e8e"
replace teaching_language = 1 if interview_ID =="987e3c29-0aa1-4a9c-8aac-916cbc79c550"
replace teaching_language = 1 if interview_ID =="a3012d37-306a-4f2a-969b-ddaf3987d8d1"
replace teaching_language = 1 if interview_ID =="95006e39-a32e-4ba8-bfe5-47001d57620e"
replace teaching_language = 1 if interview_ID =="6ae293ae-f1b6-4a21-b300-5189e8ec52b4"
replace teaching_language = 1 if interview_ID =="4cc2d77a-fc2a-4a30-845d-d4df8d340119"
replace teaching_language = 1 if interview_ID =="896bdf68-1cc1-4b29-bba7-c19e80e50af4"
replace teaching_language = 1 if interview_ID =="4a7aab47-6fa0-4d04-87dc-3a23946705b9"
replace teaching_language = 1 if interview_ID =="249a7d61-59c0-44a1-be16-48aee7773716"
replace teaching_language = 1 if interview_ID =="dfbcf07f-5330-48e9-992f-5234859a41a6"
replace teaching_language = 1 if interview_ID =="c9cb165b-b7da-4029-9f28-179c81e99906"
replace teaching_language = 1 if interview_ID =="3676f691-4038-4d35-850f-081bb916d90e"
replace teaching_language = 2 if interview_ID =="58d76b31-75b1-40ee-8d71-062145fd8fc3"
replace teaching_language = 2 if interview_ID =="267ab00d-15d5-467e-a2fe-af07f2179c4d"
replace teaching_language = 2 if interview_ID =="7a97ed1d-20cc-4c1f-80f7-98392f16a303"
replace teaching_language = 2 if interview_ID =="a0c0e846-01e2-45f3-a1c4-fc4c8d612e9d"
replace teaching_language = 2 if interview_ID =="88d3d1b9-b022-4e74-b012-54899ca085fb"
replace teaching_language = 2 if interview_ID =="ec737af7-7269-4bc9-a163-dec856847075"
replace teaching_language = 2 if interview_ID =="5dcd7d8c-3f6f-49ff-98f2-d6a23c5cea8e"
replace teaching_language = 2 if interview_ID =="995ce52e-8dbd-4f33-91b6-50393637ae49"
replace teaching_language = 2 if interview_ID =="e07dd096-8e4f-4e7b-8e95-ec742d714ac8"
replace teaching_language = 2 if interview_ID =="e0803f1d-df21-46a5-80a6-afa8283ba7b9"
replace teaching_language = 2 if interview_ID =="0a52ac27-4049-490c-933d-726e41dd2c06"
replace teaching_language = 2 if interview_ID =="369a2614-49d5-47e5-a40b-dffaf8ea0f98"
replace teaching_language = 2 if interview_ID =="a8623de1-cf21-4b05-a851-11ddbac688cf"
replace teaching_language = 2 if interview_ID =="8023879b-7906-40fd-93be-00d716dea77c"
replace teaching_language = 2 if interview_ID =="d30b30e0-26eb-4bc8-987f-bf27619d54f8"
replace teaching_language = 2 if interview_ID =="46334cea-b5ea-4b29-86db-c31f278af527"
replace teaching_language = 2 if interview_ID =="58b8b835-a14f-4c8c-b26c-dd5a66af9944"
replace teaching_language = 2 if interview_ID =="84ba238e-8e8f-4015-82d6-774e75890adc"
replace teaching_language = 2 if interview_ID =="f57b5b68-f1aa-4594-a447-5c760a804b50"
replace teaching_language = 2 if interview_ID =="2d670784-1216-40b2-9c14-1803ea64be07"
replace teaching_language = 2 if interview_ID =="d3eae98d-1b66-46ea-bdd2-27892375e695"
replace teaching_language = 2 if interview_ID =="7a46b033-23a6-4f3c-a21e-b979a168c430"
replace teaching_language = 2 if interview_ID =="72e495fd-1cdc-4872-902c-91875eee7562"
replace teaching_language = 2 if interview_ID =="cfa60164-2237-4032-8c86-4fbf36ffc188"
replace teaching_language = 2 if interview_ID =="f77c5d44-dfa6-420a-9ab0-c04ee750f860"
replace teaching_language = 2 if interview_ID =="482d7847-070d-4101-86b0-8357d709c6f9"
replace teaching_language = 2 if interview_ID =="9f7659dc-9afe-4a82-8543-73740869cdf0"
replace teaching_language = 2 if interview_ID =="27c31cfb-fe79-4d9f-93dc-c1d455f2c219"
replace teaching_language = 2 if interview_ID =="e6dd0343-b22a-455b-9bad-e5ffe0759208"
replace teaching_language = 2 if interview_ID =="7765c322-dd0c-4d16-824c-d59116c4fbb8"
replace teaching_language = 2 if interview_ID =="cfb08cfd-99c6-44c8-90f9-0cf296bd50fd"
replace teaching_language = 1 if interview_ID =="29543f5c-b04e-4f58-ab1c-6257daf48927"
replace teaching_language = 1 if interview_ID =="b32b66aa-4135-42d6-9c0f-a0310a39823c"
replace teaching_language = 1 if interview_ID =="8a0bd6bf-605f-4605-9606-1172bbfd09cf"
replace teaching_language = 2 if interview_ID =="4887e675-554f-4d54-8d86-55fe6417b497"
replace teaching_language = 2 if interview_ID =="c93e366c-af82-411e-8fd9-bb0b53f09dfc"
replace teaching_language = 2 if interview_ID =="6223cedb-fca9-4b2e-aae8-3196bb3d1a27"
replace teaching_language = 2 if interview_ID =="d0450eb9-c163-4078-86cd-e09a79af2b6a"
replace teaching_language = 2 if interview_ID =="730cf5db-0202-46f5-af9d-da1d9d81cfc1"
replace teaching_language = 2 if interview_ID =="86d5be3b-c1d9-4cd7-946d-96a556475616"
replace teaching_language = 2 if interview_ID =="fe56020d-cd18-4921-b368-e94b7efec637"
replace teaching_language = 2 if interview_ID =="c6313706-a104-48c0-b7ff-c15c3eba8a6e"
replace teaching_language = 2 if interview_ID =="8f089e1c-32a0-4080-bf59-922ebee57430"
replace teaching_language = 2 if interview_ID =="0f47e8e9-2fe2-4234-ace6-624a20319d59"
replace teaching_language = 2 if interview_ID =="1b539f9f-4a2f-4daa-9188-6a41519f20ef"
replace teaching_language = 2 if interview_ID =="0743339a-f595-45a3-9eca-638d004747af"
replace teaching_language = 2 if interview_ID =="a421e826-3fe2-4ad5-aa8a-b813faedcbc2"
replace teaching_language = 2 if interview_ID =="9199d485-71a7-47ef-853f-b36cc3126683"
replace teaching_language = 2 if interview_ID =="68b9e336-586c-43ca-a512-7ee7ba1e59ef"
replace teaching_language = 2 if interview_ID =="579a8333-55d0-4d42-9d69-d348957490ef"
replace teaching_language = 2 if interview_ID =="10e062bf-f68d-477b-94f4-118c99065e40"
replace teaching_language = 2 if interview_ID =="c16fb8f8-54cd-45a9-be52-f955237799af"
replace teaching_language = 2 if interview_ID =="a94fef84-ce43-4923-a371-82f0dae82906"
replace teaching_language = 2 if interview_ID =="f8dd39da-c30e-4e7d-82ff-a5365579fcfa"
replace teaching_language = 2 if interview_ID =="42ab1e80-ba90-4662-869b-e17299b246db"
replace teaching_language = 2 if interview_ID =="8b33fe97-b6ca-4843-8f93-1f8b05c3f31f"
replace teaching_language = 2 if interview_ID =="aa7e816a-6f78-42e9-b263-f3bd459b630e"
replace teaching_language = 2 if interview_ID =="c0fe1388-47d7-4f83-a295-21aa2c864b69"
replace teaching_language = 2 if interview_ID =="0c3b2482-282c-451c-8c3a-89d9e83c2b09"
replace teaching_language = 2 if interview_ID =="df1d859a-6a8a-4f74-a0e3-1d28c7d9ee5f"
replace teaching_language = 2 if interview_ID =="7e93b4ff-0990-4959-86f1-4260160f4368"
replace teaching_language = 2 if interview_ID =="a056eb3f-071a-4b6a-bd8e-2d5f8169a57c"
replace teaching_language = 2 if interview_ID =="5511ee83-e119-4b16-a688-d715df61f5a6"
replace teaching_language = 2 if interview_ID =="03f42024-3cf0-4b32-aa48-bcc0fe3f0418"
replace teaching_language = 1 if interview_ID =="7c3ef5a6-4251-40ac-9a57-10d02d69ee1f"
replace teaching_language = 1 if interview_ID =="9689f590-7d70-4e06-a13d-cc0dd71d3eeb"
replace teaching_language = 1 if interview_ID =="2d68e1e0-fb31-4b98-a2b1-b7adbd05342c"
replace teaching_language = 2 if interview_ID =="19370949-ff75-4ce3-8abd-67e121bb1fac"
replace teaching_language = 2 if interview_ID =="5897e891-24c2-443e-b321-1a07632ba4ee"
replace teaching_language = 2 if interview_ID =="61b74894-2eca-4fb4-8918-3997b2078334"
replace teaching_language = 2 if interview_ID =="fc9aa0d6-8995-44d1-9729-6182b26196b1"
replace teaching_language = 2 if interview_ID =="4f681fcf-1442-4b0a-8d58-483811259ce7"
replace teaching_language = 2 if interview_ID =="9c47c355-8319-428e-a59c-454088def706"
replace teaching_language = 2 if interview_ID =="95e55163-6621-4e2f-8da5-202c5a8900cf"
replace teaching_language = 2 if interview_ID =="bb28bda2-6d60-4470-9648-13a4892e9ef0"
replace teaching_language = 2 if interview_ID =="026dddbf-1df3-4083-955b-ee5a8613dd9a"
replace teaching_language = 2 if interview_ID =="2185fcc3-ca1e-48cc-8459-a21e3a247fe8"
replace teaching_language = 2 if interview_ID =="b443c03e-cf8d-4ef0-827f-5de2bfb3c9ab"
replace teaching_language = 2 if interview_ID =="471028fb-1f99-4e3c-aad9-d0d3cbe5ebd9"
replace teaching_language = 2 if interview_ID =="3ce1417e-8d46-4592-97b0-4ca77256e2d3"
replace teaching_language = 2 if interview_ID =="f1d833db-b751-4242-969f-eac41469e30c"
replace teaching_language = 2 if interview_ID =="66f3863f-c9ea-49d0-a075-3adcff996d45"
replace teaching_language = 2 if interview_ID =="f4fe1458-af6b-41ab-b9b4-d39054b28cc3"
replace teaching_language = 2 if interview_ID =="5502ba5c-dc83-4ab4-8f2a-710bdfc77226"
replace teaching_language = 2 if interview_ID =="4566b671-c137-47a4-8292-8d0a4c059edd"
replace teaching_language = 2 if interview_ID =="aff6cc3a-5b78-47db-9f6b-131b698f8747"
replace teaching_language = 2 if interview_ID =="e5a05424-50b0-4bc5-b06e-6d3781281e96"
replace teaching_language = 2 if interview_ID =="e0ed5349-c8c6-4f19-948c-7f697362b0e7"
replace teaching_language = 2 if interview_ID =="b186a63c-51bf-4999-877c-bc47a075e0af"
replace teaching_language = 2 if interview_ID =="7a8d39df-1465-4d51-a5a9-2c7de84ebe9b"
replace teaching_language = 2 if interview_ID =="4008e043-3032-408e-b2cf-2d7de7c28afb"
replace teaching_language = 2 if interview_ID =="9d5a694f-72ec-4b2d-9ec8-8f6ba8df8c23"
replace teaching_language = 2 if interview_ID =="c6ccdce4-a816-4f2b-b212-cc79e2b3871a"
replace teaching_language = 2 if interview_ID =="f85355b9-22d2-4546-9061-ac799104abb7"
replace teaching_language = 2 if interview_ID =="a2bac118-efe9-44d7-8af4-732d773e07d1"
replace teaching_language = 2 if interview_ID =="4ca6f91c-7a1b-491e-91bd-f1c51f2f1ab0"
replace teaching_language = 2 if interview_ID =="892e9b67-4ed1-4a3f-b630-fce339e10447"
replace teaching_language = 1 if interview_ID =="f82a3066-f2ad-4f76-9ba9-6eb5031ae6c2"
replace teaching_language = 1 if interview_ID =="542bcf7c-6abc-4286-9809-1c80b7850c85"
replace teaching_language = 1 if interview_ID =="196c2d90-c892-41ea-8577-d2387717def4"
replace teaching_language = 2 if interview_ID =="8764d008-37d1-4283-9a6c-d6fe42bc968c"
replace teaching_language = 2 if interview_ID =="257b9f02-7c31-4218-8882-9f65210f06cb"
replace teaching_language = 2 if interview_ID =="4f005a01-7469-490f-a3ed-420eb50d46ae"
replace teaching_language = 2 if interview_ID =="7ea07b27-b812-4a7b-b376-0eee6a7574be"
replace teaching_language = 2 if interview_ID =="78a49041-d127-4435-8039-b1b24678b8d2"
replace teaching_language = 2 if interview_ID =="0a2b3fa6-97ba-4194-844b-254dfe0b8742"
replace teaching_language = 2 if interview_ID =="706f7650-e48c-4037-86f4-52e8ca58d956"
replace teaching_language = 2 if interview_ID =="175a1e60-6e35-43a3-a7af-f1b2e05c2985"
replace teaching_language = 2 if interview_ID =="3b331ee8-bd6c-427a-a36d-e0e01354e092"
replace teaching_language = 2 if interview_ID =="16e10e5a-74b2-4ed1-92fd-5f570ed23187"
replace teaching_language = 2 if interview_ID =="3e59b488-40f5-47f0-a7c5-14efc851a16b"
replace teaching_language = 2 if interview_ID =="d9adfa28-6b3d-4369-afee-21dfa85a9b4c"
replace teaching_language = 2 if interview_ID =="209c3b2b-b464-4c85-b4d8-e804c9a120e8"
replace teaching_language = 2 if interview_ID =="185b4d3e-c1ab-4190-8a4b-c25eeee130b8"
replace teaching_language = 2 if interview_ID =="d20561fa-0589-4bdf-a7bc-0da0993a5fb2"
replace teaching_language = 2 if interview_ID =="2b29acbf-80bc-4fa5-acba-ad4a1d8116fb"
replace teaching_language = 2 if interview_ID =="1894bf3e-640d-4036-bdc5-88727258ddfd"
replace teaching_language = 2 if interview_ID =="c5eb7db9-ca06-4571-80be-888a304a2211"
replace teaching_language = 2 if interview_ID =="55d0fe44-60e0-4459-a3e5-9ee099e06adc"
replace teaching_language = 2 if interview_ID =="72e6289b-e5c8-41b8-8ea6-5237b1fe4bf2"
replace teaching_language = 2 if interview_ID =="7522ea5a-55f7-4f4a-bca5-37fd3ed9fc39"
replace teaching_language = 2 if interview_ID =="5f7b8010-04d1-45fe-99a2-beb7dde997fa"
replace teaching_language = 2 if interview_ID =="42e879ae-62f9-492b-a5d6-578934def43e"
replace teaching_language = 2 if interview_ID =="1596bedf-921f-447d-8da5-7d498df3d6a2"
replace teaching_language = 2 if interview_ID =="61982048-720e-4e7a-a7fa-8ff3ebbdf7a9"
replace teaching_language = 2 if interview_ID =="1d56fc80-0f93-4d3d-b401-393cfaaef250"
replace teaching_language = 2 if interview_ID =="aaa6de8f-89b3-4570-84fc-ab77e9bb7186"
replace teaching_language = 2 if interview_ID =="b2580000-6ab8-4c9e-ab37-d78f651f70a9"
replace teaching_language = 2 if interview_ID =="a0009359-dd41-4cef-be92-c8d7e9be870a"
replace teaching_language = 2 if interview_ID =="44565545-dbd1-4967-a79b-1e8734bf7bf4"
replace teaching_language = 2 if interview_ID =="5e02cd7a-b096-41b3-8969-2982630af2f1"
replace teaching_language = 1 if interview_ID =="3da903f2-a9a6-450f-925d-4a72126b82ec"
replace teaching_language = 1 if interview_ID =="f03948d5-6cce-4aba-8ec1-28efe2cfa731"
replace teaching_language = 1 if interview_ID =="cc34e29e-6ca7-414f-862d-118780f7350d"
replace teaching_language = 2 if interview_ID =="54a3da50-0c85-4e4d-a48a-c23707890669"
replace teaching_language = 2 if interview_ID =="2dbc0d99-1a52-416e-98ad-62173c272839"
replace teaching_language = 2 if interview_ID =="c1027bd7-df2f-4340-a05a-ce0712454ccb"
replace teaching_language = 2 if interview_ID =="04c9fc12-1632-4dd5-85f6-c19f26dd80ff"
replace teaching_language = 2 if interview_ID =="1d2aa9b7-4d58-49d9-95f9-bff7541456ff"
replace teaching_language = 2 if interview_ID =="d78b5aaf-3d36-4b1e-893c-90976cfc7b52"
replace teaching_language = 2 if interview_ID =="a0c27261-8682-4b7b-a9df-d58142ec58bb"
replace teaching_language = 2 if interview_ID =="c8f06068-cfe7-4ecc-96df-e7b3a1e03ff9"
replace teaching_language = 2 if interview_ID =="af477e90-0f5b-432a-970c-4e0febfe866f"
replace teaching_language = 2 if interview_ID =="1875fa70-96a2-4b6c-863e-57be4047ffc2"
replace teaching_language = 2 if interview_ID =="ef62b67c-4e6e-4cbe-bc15-9ab50974999c"
replace teaching_language = 2 if interview_ID =="aa196db0-42c5-490d-b9be-e8f377a8b64f"
replace teaching_language = 2 if interview_ID =="2b57159b-dcea-4e3f-b4fb-38ef7abbde99"
replace teaching_language = 2 if interview_ID =="a96ba806-ab05-4313-8f91-5d695422c339"
replace teaching_language = 2 if interview_ID =="dcb8c80e-ccfb-42af-89a4-503deaf82b70"
replace teaching_language = 2 if interview_ID =="122a3775-ade1-4606-a980-f7066fb2cf1c"
replace teaching_language = 2 if interview_ID =="83019b95-ff10-46b5-a59f-348b6d819b43"
replace teaching_language = 2 if interview_ID =="9cdb80a3-0a6a-4880-babf-e7eeb82fd8a2"
replace teaching_language = 2 if interview_ID =="f708394f-3051-405f-a09f-7657386d7208"
replace teaching_language = 2 if interview_ID =="90b7f566-c507-4302-bf7a-47559502e8f7"
replace teaching_language = 2 if interview_ID =="a7ee66c5-6ca3-4270-943e-8d97534e409e"
replace teaching_language = 2 if interview_ID =="103f2713-7896-406c-8cf8-9e25c62fca0b"
replace teaching_language = 2 if interview_ID =="b028292c-425c-4cb2-841a-7e2951f36cee"
replace teaching_language = 2 if interview_ID =="4074070f-880b-4124-af18-5311f67eafa7"
replace teaching_language = 2 if interview_ID =="b6688a1d-520a-4bf3-8893-e3d60d0def2f"
replace teaching_language = 2 if interview_ID =="3ec4200b-e4fc-4b5d-8508-165b7dda4b7d"
replace teaching_language = 2 if interview_ID =="dadc63bd-9fd5-4e0a-b5ab-06bc7404cde3"
replace teaching_language = 2 if interview_ID =="eefab7ac-1e95-43e2-bcaa-425362521994"
replace teaching_language = 2 if interview_ID =="065b6b02-20cb-4ec7-82a8-f59f3f3b16c3"
replace teaching_language = 2 if interview_ID =="71a9e35f-0f05-476e-8160-716eb8ce68bd"
replace teaching_language = 1 if interview_ID =="6f8fe98b-f1fa-4a83-b36b-58052db04f14"
replace teaching_language = 1 if interview_ID =="800c650b-3102-49b6-80cd-5d8caf763a37"
replace teaching_language = 1 if interview_ID =="0c82af10-54fc-45e7-ae38-1d1f4f45bdf7"
replace teaching_language = 2 if interview_ID =="278c20ad-72e0-474f-98a2-eb146c877e82"
replace teaching_language = 2 if interview_ID =="2205b7de-57f0-4715-85cc-73673f868678"
replace teaching_language = 2 if interview_ID =="b0a34862-9126-4fbe-a263-1b445ef70ef3"
replace teaching_language = 2 if interview_ID =="36c27614-ece9-4128-8f7e-4e1d7c5a0fa2"
replace teaching_language = 2 if interview_ID =="b14a5f5e-8b6c-45ed-9ccd-fa1aef85d4dc"
replace teaching_language = 2 if interview_ID =="6f4445ff-dc73-4064-9174-0044d2973395"
replace teaching_language = 2 if interview_ID =="f6bdb475-82a5-47e7-aa3a-728b13a2906b"
replace teaching_language = 2 if interview_ID =="cfee0ae8-ab33-49d0-8a64-e9828e7b273e"
replace teaching_language = 2 if interview_ID =="8f2109f7-7b96-4b23-8383-7fa94872f586"
replace teaching_language = 2 if interview_ID =="d894d25a-03bc-4663-9dea-fbdf62608d63"
replace teaching_language = 2 if interview_ID =="dc021baf-6958-4b75-ab39-a6963e4177c4"
replace teaching_language = 2 if interview_ID =="2cd65397-d824-480c-97ed-cf25d86de3e3"
replace teaching_language = 2 if interview_ID =="bd2b73ce-9bf3-476d-b89c-47f166f60259"
replace teaching_language = 2 if interview_ID =="3cd2c24c-6a2c-470f-90c2-a025d028238d"
replace teaching_language = 2 if interview_ID =="3e41e2ff-9e52-4d18-b6e8-6faf47694c1f"
replace teaching_language = 1 if interview_ID =="2d0edb86-ec51-4056-a030-9e611ed03ac5"
replace teaching_language = 1 if interview_ID =="b186bac0-cc7f-409d-853f-6e45b086c73d"
replace teaching_language = 1 if interview_ID =="6d3906b5-2196-4cd2-86a2-fe350906db6f"
replace teaching_language = 1 if interview_ID =="906a3c39-e317-44ac-a320-b9e0e7bf872c"
replace teaching_language = 1 if interview_ID =="4c2c557a-2499-4a4e-99d6-41547e8c1a5d"
replace teaching_language = 1 if interview_ID =="4ccb1827-b89e-4397-9de0-746a9203fa5f"
replace teaching_language = 1 if interview_ID =="480d348e-70f2-4c4e-8a30-cb6f8cd3ffb8"
replace teaching_language = 1 if interview_ID =="721f4c0a-19e0-44a6-a988-9dcb1099479e"
replace teaching_language = 1 if interview_ID =="bd029f92-31a8-4f2b-baa0-36002d217c31"
replace teaching_language = 1 if interview_ID =="94a31cc7-278a-4dc1-a99f-69fedfbfb4ff"
replace teaching_language = 1 if interview_ID =="e9c0ac27-52af-4d1a-8db0-8144b2c5b136"
replace teaching_language = 1 if interview_ID =="7e029362-f6a3-411d-8b23-17cd283b7bd8"
replace teaching_language = 1 if interview_ID =="8036d97d-de52-4a90-be25-312c7151c8b4"
replace teaching_language = 1 if interview_ID =="e323eca7-90a5-408f-881d-f97277b5a5d7"
replace teaching_language = 1 if interview_ID =="a0932450-5d6a-4c41-a840-7e8d3073dbe1"
replace teaching_language = 1 if interview_ID =="8d3c5fd7-5873-4bf9-81a7-17cc5e4bf39e"
replace teaching_language = 1 if interview_ID =="371c0317-3508-4318-b597-f78fe787d8c2"
replace teaching_language = 1 if interview_ID =="8c21f71d-6af5-489c-b9c0-71360d00efce"
replace teaching_language = 2 if interview_ID =="a5cbd55d-9a46-4dc9-8d9f-bf71d9e2e05b"
replace teaching_language = 2 if interview_ID =="fc355bf6-b25a-4cf0-9e92-a866fd8c9cda"
replace teaching_language = 2 if interview_ID =="585e2373-1621-41c8-a53c-c84166907d78"
replace teaching_language = 2 if interview_ID =="d747478e-c559-4fa5-a205-dd55d2e84615"
replace teaching_language = 2 if interview_ID =="7644de24-742d-4cbe-bbc6-0e4916ed7133"
replace teaching_language = 2 if interview_ID =="9a624f36-28c4-436e-b0a6-1e4d914d0d30"
replace teaching_language = 2 if interview_ID =="3eb87b48-e1b1-4004-aced-ffa569170df3"
replace teaching_language = 2 if interview_ID =="86700737-288a-4b8e-b7fd-0db7c2f3ddce"
replace teaching_language = 2 if interview_ID =="cbc373d5-d289-4b98-b8b8-8d13ce9e469e"
replace teaching_language = 2 if interview_ID =="423b834f-e93d-4f99-a392-d2cedd3a09ec"
replace teaching_language = 2 if interview_ID =="5d269cb5-2db4-4006-881f-d0c5cf95d158"
replace teaching_language = 2 if interview_ID =="ba3d30d5-2d1b-4345-88dc-4687ca935d06"
replace teaching_language = 2 if interview_ID =="56645761-47d9-4afd-abac-085730b553b4"
replace teaching_language = 2 if interview_ID =="32083ff4-497b-470c-83d3-ef7e448879be"
replace teaching_language = 2 if interview_ID =="9ece55b5-5dd4-4a2b-9d27-3eb4087925e5"
replace teaching_language = 1 if interview_ID =="7301d1e7-6c89-4219-9050-27e16a5bb8fb"
replace teaching_language = 1 if interview_ID =="cc2c09e4-d50e-4db2-b70a-1343534512c4"
replace teaching_language = 1 if interview_ID =="d7c38247-d416-4855-b261-5050a11bac45"
replace teaching_language = 1 if interview_ID =="3c9bd3bb-5071-44b4-a65d-50f28f9608a4"
replace teaching_language = 1 if interview_ID =="6129d954-3047-43e7-97a6-b58e5870603b"
replace teaching_language = 1 if interview_ID =="f6f55a81-b07b-4ddc-8c70-0a9d77a7f56d"
replace teaching_language = 1 if interview_ID =="1d4c9450-8d69-4f4b-8795-11257f6bfeab"
replace teaching_language = 1 if interview_ID =="eff2f8f1-8eca-4e81-937a-6cb060ad35fe"
replace teaching_language = 1 if interview_ID =="5a8c8e58-9d6a-4a8b-8802-079294482ae1"
replace teaching_language = 1 if interview_ID =="a88f1ef6-f60a-43a9-931f-4739f52c69d7"
replace teaching_language = 1 if interview_ID =="52db65f5-3c9f-4d76-bade-daa69c6693f7"
replace teaching_language = 1 if interview_ID =="b10da94e-4ef1-4886-9ee2-be6be009489b"
replace teaching_language = 1 if interview_ID =="342492e9-a75c-415e-9303-e4fff2ef6019"
replace teaching_language = 1 if interview_ID =="763ea2cb-2ba2-4707-b96a-0209f4d0ca55"
replace teaching_language = 1 if interview_ID =="ec1cca0d-209a-422a-add1-556ab98ff141"
replace teaching_language = 1 if interview_ID =="50e669b7-5e85-4250-b834-d2bd5ef2f6a2"
replace teaching_language = 1 if interview_ID =="e2a5aa95-3efe-4176-8de2-a917e416f892"
replace teaching_language = 1 if interview_ID =="ddf9180a-94dd-4109-a1d3-e26552185847"
replace teaching_language = 1 if interview_ID =="0f1e6edb-fbdd-49a6-98b4-8a29a96c6fce"
replace teaching_language = 2 if interview_ID =="81489cef-05e1-4c1a-8bb1-c98ec1fa58b2"
replace teaching_language = 2 if interview_ID =="dd445b1c-916f-4b7c-9059-24f0a45655a8"
replace teaching_language = 2 if interview_ID =="f4fc3024-c500-4e55-a64b-6dd8fb9e84c2"
replace teaching_language = 2 if interview_ID =="49f6ec22-1d7c-4391-bde8-15fbccf48f49"
replace teaching_language = 2 if interview_ID =="2611f2db-a04a-47da-b261-259ccd28e338"
replace teaching_language = 2 if interview_ID =="ce0d08ed-a5fa-4301-af8f-cbd6aaf9aadb"
replace teaching_language = 2 if interview_ID =="ccde7f7d-4080-427c-8805-3c9dea4bf1cc"
replace teaching_language = 2 if interview_ID =="bbdb56ba-7522-4abc-9451-61123174d015"
replace teaching_language = 2 if interview_ID =="75ded4fd-27e2-440e-90d2-977194e4e0f9"
replace teaching_language = 2 if interview_ID =="480d9bb4-df94-4dd2-9983-fd68b96da85d"
replace teaching_language = 2 if interview_ID =="2c0fd94b-db37-4b49-b305-9e71815e0b2d"
replace teaching_language = 2 if interview_ID =="744dcc9a-7871-446d-9161-ac97cbd808df"
replace teaching_language = 2 if interview_ID =="02cddc5e-7724-4cec-8019-f15ca2aaf6da"
replace teaching_language = 2 if interview_ID =="1e82a138-c1bd-40da-b7f5-bc1c37566c7f"
replace teaching_language = 2 if interview_ID =="7451cbf4-4128-4e20-aa6a-fd1d09750f3a"
replace teaching_language = 2 if interview_ID =="b055c3fc-c1df-4988-a8dd-cc8c80869ad8"
replace teaching_language = 2 if interview_ID =="a256cb9d-9520-4650-b824-e9635f5fb387"
replace teaching_language = 2 if interview_ID =="6e2f6dad-354e-4bf6-8452-21008ad88ca7"
replace teaching_language = 2 if interview_ID =="f956d6aa-5c0c-4739-9e00-dc2e3a315c71"
replace teaching_language = 2 if interview_ID =="d6de487e-f26f-4f13-9f7b-fcef2714b372"
replace teaching_language = 2 if interview_ID =="57af00e3-d5db-4f4d-8741-d5a691d27744"
replace teaching_language = 2 if interview_ID =="a3799748-5d88-4de6-a038-c5923894507d"
replace teaching_language = 2 if interview_ID =="4f96cbf6-036e-4eb1-970c-8d2bff846da7"
replace teaching_language = 2 if interview_ID =="4dd8a3b9-5493-40ac-8625-55221a642082"
replace teaching_language = 2 if interview_ID =="e66b02e8-0253-423a-970c-c354079d37fb"
replace teaching_language = 2 if interview_ID =="1eeedaaf-eecb-45b0-a69d-ea362dd1c425"
replace teaching_language = 2 if interview_ID =="78120397-631d-44be-adad-55578110bfbf"
replace teaching_language = 2 if interview_ID =="500d304c-1438-41e4-96b5-9c38c84f7e39"
replace teaching_language = 2 if interview_ID =="4b24b072-8e17-420e-a9b3-aece431ef4d6"
replace teaching_language = 2 if interview_ID =="5b6d1a91-e454-45a3-9170-9a2eec4edbf8"
replace teaching_language = 1 if interview_ID =="41dc0aa6-9bbe-4fa0-aae9-a563b1c49456"
replace teaching_language = 1 if interview_ID =="82eea277-0346-4c40-b235-30f785cc6a8c"
replace teaching_language = 1 if interview_ID =="76da393a-4246-4d2d-87eb-f5c0fa97db92"
replace teaching_language = 2 if interview_ID =="e30001ee-a120-47b2-a978-31d6248caea5"
replace teaching_language = 2 if interview_ID =="b692ec7f-c10a-48f3-990c-dffef2cbf687"
replace teaching_language = 2 if interview_ID =="3b062de7-fc61-438d-8bf2-692173b29a75"
replace teaching_language = 2 if interview_ID =="bdfc6dbe-d784-41e1-9b38-7e1d040be065"
replace teaching_language = 2 if interview_ID =="75bb7e98-b07a-4647-befa-50e05701279c"
replace teaching_language = 2 if interview_ID =="33860ecb-65e0-4008-95f8-01f9a4c2e66b"
replace teaching_language = 2 if interview_ID =="d6513c14-d985-4a1a-a112-cab3556e8507"
replace teaching_language = 2 if interview_ID =="cf0ac634-b4d3-4372-828a-5a8c6c509a59"
replace teaching_language = 2 if interview_ID =="9c0303e9-b025-469e-8933-c28af776fcd9"
replace teaching_language = 2 if interview_ID =="d5ef370b-ece2-484c-b899-8ee9b8a3bde1"
replace teaching_language = 2 if interview_ID =="23b47b38-7758-4df2-a703-34e21f599406"
replace teaching_language = 2 if interview_ID =="13f86346-9cdf-4cf0-9e8b-9a37621f3ab9"
replace teaching_language = 2 if interview_ID =="e8e336d6-04cf-495f-aa65-c16d641dce48"
replace teaching_language = 2 if interview_ID =="97770443-2022-48e2-99c1-8787411df0fd"
replace teaching_language = 2 if interview_ID =="571d18e8-6860-4668-9827-88bce519afa6"
replace teaching_language = 2 if interview_ID =="7fe33265-b588-4991-957a-45c47b444833"
replace teaching_language = 2 if interview_ID =="47ee1a1a-b5dc-4da9-8f02-724fc60370b4"
replace teaching_language = 2 if interview_ID =="e9b9338d-03de-4443-843a-bba4910cf077"
replace teaching_language = 2 if interview_ID =="cf2620f8-e7d9-4afb-b6e5-8258d0053d05"
replace teaching_language = 2 if interview_ID =="88094c2c-03c5-40de-a5fd-bc20592ae4f2"
replace teaching_language = 2 if interview_ID =="321720b4-f07d-456e-a814-1c83fd10d396"
replace teaching_language = 2 if interview_ID =="f3a66193-c84c-4dfb-bdd4-6343c5fda36d"
replace teaching_language = 2 if interview_ID =="8eafbb69-2216-48ae-ad6e-9bd078e2c8d4"
replace teaching_language = 2 if interview_ID =="76619b8c-878e-4126-b7d7-5fc054426f25"
replace teaching_language = 2 if interview_ID =="10009c21-ac8e-4440-830e-14e457d94ae4"
replace teaching_language = 2 if interview_ID =="24ddb85f-4829-4aa5-98de-677c17942d33"
replace teaching_language = 2 if interview_ID =="1d05d7f0-2a06-48af-9707-2d521914e10c"
replace teaching_language = 2 if interview_ID =="f7228e42-bba4-4566-a141-e1d14e3d3412"
replace teaching_language = 2 if interview_ID =="6e720f58-c233-45d1-b568-0ad4cd61a57d"
replace teaching_language = 2 if interview_ID =="e2491eff-f629-44bb-9413-3aeb4deab811"
replace teaching_language = 2 if interview_ID =="e621c03b-a58f-4e41-8d76-1b625301b331"
replace teaching_language = 1 if interview_ID =="e0e2eb4e-acb7-42b2-b9d4-449c487d9913"
replace teaching_language = 1 if interview_ID =="91b0a099-2320-4d67-9fd9-50c479c4568a"
replace teaching_language = 1 if interview_ID =="512deda3-7f79-4413-bf7e-16f0e58179ae"
replace teaching_language = 2 if interview_ID =="a1dd9b8a-8464-4115-b6cc-70be539641ba"
replace teaching_language = 2 if interview_ID =="5ab428e4-abd3-4a2e-aa31-fe88f6cdf57e"
replace teaching_language = 2 if interview_ID =="33285c9f-b9b4-4aea-ada9-d2c1629a7f54"
replace teaching_language = 2 if interview_ID =="9f1d2b4f-fc36-45df-a6d4-9967dab6bcbe"
replace teaching_language = 2 if interview_ID =="0fc6aa22-752d-4eea-bd33-8378de86282b"
replace teaching_language = 2 if interview_ID =="c8b20888-5863-4b55-a529-1e961cd24b41"
replace teaching_language = 2 if interview_ID =="006f5792-cc96-4c31-84f2-83db4a34075e"
replace teaching_language = 2 if interview_ID =="8bf3d982-a411-44bd-8b3d-304e47f75759"
replace teaching_language = 2 if interview_ID =="ef3f9a5a-bbe9-498e-9f68-54d6d5753b0f"
replace teaching_language = 2 if interview_ID =="175a9ddd-edb2-458b-a40f-6e531a0f359f"
replace teaching_language = 2 if interview_ID =="1188fe0a-84e4-47a0-a81f-93938406cac2"
replace teaching_language = 2 if interview_ID =="243170e3-9017-4b88-a919-c978da7803fe"
replace teaching_language = 2 if interview_ID =="a670c40c-5ba1-46bd-8b95-0e62940a60f7"
replace teaching_language = 2 if interview_ID =="3a6af633-5bfc-43e5-bea0-bdf0e19a83bb"
replace teaching_language = 2 if interview_ID =="4b25375a-5936-4fd0-836c-3178f0ddbe24"
replace teaching_language = 2 if interview_ID =="a526e0dd-84f4-4b02-ab69-5806c29a3fed"
replace teaching_language = 2 if interview_ID =="e4a43b15-534b-4ccf-84ac-81917ae5a3c7"
replace teaching_language = 2 if interview_ID =="ef1039a9-2bee-4423-b990-8d83ec39734f"
replace teaching_language = 2 if interview_ID =="01c25760-17c1-4852-809b-5a3d76c622e7"
replace teaching_language = 2 if interview_ID =="76660ce7-b5c0-4ca6-a1a0-32b15c9abde0"
replace teaching_language = 2 if interview_ID =="c2bc1a5d-0428-4a04-afce-f380629c3d45"
replace teaching_language = 2 if interview_ID =="62f30be9-e156-4cc4-b0ec-6112e28ad3fb"
replace teaching_language = 2 if interview_ID =="00735275-09b8-4bcc-ae02-83f38ad38dee"
replace teaching_language = 2 if interview_ID =="93070771-4819-43b3-b5f9-2ac2a7ad1ee2"
replace teaching_language = 2 if interview_ID =="85a72bca-d923-44f5-98ef-9c06f00367ce"
replace teaching_language = 2 if interview_ID =="804a83fb-388b-4b36-9101-41f651e206bf"
replace teaching_language = 2 if interview_ID =="5a1b4293-0c1c-463b-a29a-9856237dea92"
replace teaching_language = 2 if interview_ID =="efc1ea7f-31d8-4692-97b9-f5a525131880"
replace teaching_language = 2 if interview_ID =="c8c91645-5858-4b5b-81bc-0abcd32b183a"
replace teaching_language = 2 if interview_ID =="8e2f2b8d-a055-4e95-a2f6-782d5d3c73b8"
replace teaching_language = 1 if interview_ID =="efea57df-e364-4719-a921-f474f48abf52"
replace teaching_language = 1 if interview_ID =="616540c8-6671-4e45-bec4-bb37bb8e38ab"
replace teaching_language = 1 if interview_ID =="729a4333-d159-4c0a-aca8-a60f94173d07"
replace teaching_language = 2 if interview_ID =="679b860d-e557-4ed0-ad12-0b30ee045491"
replace teaching_language = 2 if interview_ID =="c0cfca14-fcc5-4810-9a75-209d72573712"
replace teaching_language = 2 if interview_ID =="df8c7760-dc1e-44fb-89a8-4527f3e115b2"
replace teaching_language = 2 if interview_ID =="f0347610-f0e7-465b-ad83-5a16c8c95ad7"
replace teaching_language = 2 if interview_ID =="cd089376-7677-4b54-9b45-855c7d83b240"
replace teaching_language = 2 if interview_ID =="ce5e58d2-3d97-4af8-8047-2586cdeed46c"
replace teaching_language = 2 if interview_ID =="b876096e-74c4-47c5-a8a6-c231acfb3c19"
replace teaching_language = 2 if interview_ID =="5f2a8673-65a9-43ca-963d-635b04698b16"
replace teaching_language = 2 if interview_ID =="fe86eca2-5867-4ade-b519-b67d14e45bb2"
replace teaching_language = 2 if interview_ID =="01ffac2f-209d-468d-afde-01a943131e45"
replace teaching_language = 2 if interview_ID =="980a9f69-8c17-48c1-9a4e-7b2021999c6c"
replace teaching_language = 2 if interview_ID =="3b2cf192-788e-411a-97f5-2b022a6d7a67"
replace teaching_language = 2 if interview_ID =="53be1fdd-afbb-4840-9e52-599d193d005b"
replace teaching_language = 2 if interview_ID =="a71d532e-9316-49c9-9899-3c4faf431c52"
replace teaching_language = 2 if interview_ID =="fd1c3553-9069-4090-9ffb-c1d69e7e1404"
replace teaching_language = 2 if interview_ID =="e9792b8a-09cf-4ef2-b478-30b3ee858fc9"
replace teaching_language = 2 if interview_ID =="994d3e33-fc0b-4308-9e20-2e1ff54a6bbe"
replace teaching_language = 2 if interview_ID =="049a7f55-fcfc-4714-824b-77181feab726"
replace teaching_language = 2 if interview_ID =="526b1b44-5d24-4310-8e05-7838677557cc"
replace teaching_language = 2 if interview_ID =="2c8c0f78-9934-40b4-b8d9-2197b70a94b3"
replace teaching_language = 2 if interview_ID =="f2b25984-966a-42c4-a907-7dc0dd9ffb35"
replace teaching_language = 2 if interview_ID =="c4dc222d-eeb3-435e-b6b9-69684898e829"
replace teaching_language = 2 if interview_ID =="14ead4b3-219b-443e-8167-ce249173174d"
replace teaching_language = 2 if interview_ID =="6d9ddbb5-e9b5-4baf-92f7-900437528398"
replace teaching_language = 2 if interview_ID =="b8e21258-7951-493e-aa2f-ffe621bfeb43"
replace teaching_language = 2 if interview_ID =="b90c66e9-979a-4c5a-9047-7f1e00dd0ebf"
replace teaching_language = 2 if interview_ID =="dd49ca82-8d0c-47e7-8bef-5db44a0991ac"
replace teaching_language = 2 if interview_ID =="1167f150-be84-4357-a59a-816e180aa9e5"
replace teaching_language = 2 if interview_ID =="b33f933f-5395-404c-a2d5-2f2b2e4e6c8d"
replace teaching_language = 2 if interview_ID =="ddeb78bf-5a97-495a-b6b9-97587ba7210c"
replace teaching_language = 1 if interview_ID =="b46572e4-771f-46d4-9f95-9778009121ab"
replace teaching_language = 1 if interview_ID =="f3ec8ae7-c06a-48f5-a5f3-b61e582af506"
replace teaching_language = 1 if interview_ID =="5e747f2a-7fae-4aad-8574-4cfea8e8cb1d"
replace teaching_language = 2 if interview_ID =="d67f831d-b280-4f07-b17f-d350388e3e01"
replace teaching_language = 2 if interview_ID =="7d5e030b-01da-4e7c-b0d7-237e2a63754f"
replace teaching_language = 2 if interview_ID =="6eb72794-efc0-48af-92e2-a90b403de61f"
replace teaching_language = 2 if interview_ID =="f830bab3-74e7-45f4-b0e2-8c3885992c71"
replace teaching_language = 2 if interview_ID =="97d71f6c-98da-4cd9-bc86-dce05b13fb44"
replace teaching_language = 2 if interview_ID =="263c1ec5-f0f1-4dd1-8763-6ac339342b48"
replace teaching_language = 2 if interview_ID =="3a3d32d6-3da6-4f5d-a72b-c57591490ea2"
replace teaching_language = 2 if interview_ID =="967f49aa-c855-4fcb-b32c-a46e896964a8"
replace teaching_language = 2 if interview_ID =="d2bd98e7-64bd-499e-bbcf-95f2ef86650b"
replace teaching_language = 2 if interview_ID =="42b018d5-1f96-476c-8866-e67d0f8a097b"
replace teaching_language = 2 if interview_ID =="f7f16800-2a85-442b-9f83-69ffbc18021c"
replace teaching_language = 2 if interview_ID =="e654d973-eae8-4dfa-849b-4b7b226911bc"
replace teaching_language = 2 if interview_ID =="8cf7dab5-e361-4e11-a07b-53b4ddb07d3b"
replace teaching_language = 2 if interview_ID =="1c2166f4-b8d3-41fa-b682-c780c935c496"
replace teaching_language = 2 if interview_ID =="9dc481b0-68fc-489d-a638-4ebbec8031ab"
replace teaching_language = 2 if interview_ID =="dbd1c883-0268-4394-a86c-9ba0d1e56d09"
replace teaching_language = 2 if interview_ID =="43caccb6-a09f-443f-80aa-fb2970b31a33"
replace teaching_language = 2 if interview_ID =="eeda558d-9be8-46c0-a2f7-dc543d34a5dc"
replace teaching_language = 2 if interview_ID =="55618187-a073-46a4-b94b-a397cf4319bd"
replace teaching_language = 2 if interview_ID =="aca1ba89-81b6-42c4-8e2e-81e9bc8db60e"
replace teaching_language = 2 if interview_ID =="bc95181a-9571-4c52-afdc-a3eac063cfcb"
replace teaching_language = 2 if interview_ID =="e55f6a07-5a34-446b-a548-7636b0c4b60d"
replace teaching_language = 2 if interview_ID =="39604079-8bea-4c60-b0fd-6a8b131e80de"
replace teaching_language = 2 if interview_ID =="0efe8e10-f0fa-4fa8-b28e-da8c9192a60f"
replace teaching_language = 2 if interview_ID =="5d3db37f-b6ac-43ec-9130-af7edc8149cd"
replace teaching_language = 2 if interview_ID =="5f3c57b5-a7b6-4031-b106-64c6a4969f01"
replace teaching_language = 2 if interview_ID =="5d3e5dbf-5132-4f46-b027-e401fd6611f4"
replace teaching_language = 2 if interview_ID =="ca332f93-3166-4d0a-90ef-44d651ebf19a"
replace teaching_language = 2 if interview_ID =="6ebca319-337b-40fc-a0e7-170ea5dc629f"
replace teaching_language = 2 if interview_ID =="dab6f85d-1dcf-420d-a750-47681dea2b8e"
replace teaching_language = 1 if interview_ID =="2ea90b08-8d95-441e-a8a4-8bd812e0aa57"
replace teaching_language = 1 if interview_ID =="2ddf89db-e7bb-4cc4-a5bf-3284a3536072"
replace teaching_language = 1 if interview_ID =="e261c368-6c36-4ab7-b9af-fb4aec8da3fd"
replace teaching_language = 1 if interview_ID =="1f111b6a-387e-4e61-81c9-622d207742f7"
replace teaching_language = 2 if interview_ID =="db517ef9-86bd-4b52-843b-79db6f9148a9"
replace teaching_language = 2 if interview_ID =="aa71dbcc-9fd7-4b18-8b0e-480a4869766d"
replace teaching_language = 2 if interview_ID =="e4900719-ffa5-4b38-8e86-937fbb31b85f"
replace teaching_language = 2 if interview_ID =="8c908de3-3228-4a7e-a417-fd61f10954a1"
replace teaching_language = 2 if interview_ID =="86e44aac-e1b9-4cc7-8b1d-e289eed5e88f"
replace teaching_language = 2 if interview_ID =="b3d2bace-76f2-4c37-8dae-bd6d50d38057"
replace teaching_language = 2 if interview_ID =="a44445f0-b02d-4376-9985-6440a6a54352"
replace teaching_language = 2 if interview_ID =="c860a452-4dca-422b-927b-af6f89153562"
replace teaching_language = 2 if interview_ID =="eedca5a3-afd8-45a0-a837-4b166c8ebb35"
replace teaching_language = 2 if interview_ID =="19e98665-e383-4cc7-8391-05fffe810a53"
replace teaching_language = 2 if interview_ID =="74ac1b56-86c2-4946-86a3-1b850eeeed35"
replace teaching_language = 2 if interview_ID =="08b9b550-4288-456e-8452-10720aed8fa4"
replace teaching_language = 2 if interview_ID =="ff7bcb16-4d87-4766-8924-fb161da2e83e"
replace teaching_language = 2 if interview_ID =="1e1127c6-05a2-43eb-8301-51ce1fbc6849"
replace teaching_language = 2 if interview_ID =="a38f1661-0b50-4956-8485-2830ac18558e"
replace teaching_language = 2 if interview_ID =="ee82e78c-94bf-4ae9-a8e3-854fdc91b4b1"
replace teaching_language = 2 if interview_ID =="0a5c5a50-0377-4a19-aa32-f63a81416f01"
replace teaching_language = 2 if interview_ID =="d6e675e1-6c02-43f7-a166-38db2e439e4d"
replace teaching_language = 2 if interview_ID =="774b3968-d03d-4177-bba0-612bb98722b7"
replace teaching_language = 2 if interview_ID =="992de92e-d253-43df-9fce-5d6937cc4b1a"
replace teaching_language = 2 if interview_ID =="b12e2829-a266-40da-b98c-78315b8cc698"
replace teaching_language = 2 if interview_ID =="c36a9870-8acb-41cb-b989-78b7f52753a9"
replace teaching_language = 2 if interview_ID =="acedeb6c-4873-4230-8a07-2e059b91d746"
replace teaching_language = 2 if interview_ID =="fac43095-6f57-476e-bc3f-6364aab4708e"
replace teaching_language = 2 if interview_ID =="73fff59c-a151-4d4d-b903-fb2d1485a31d"
replace teaching_language = 2 if interview_ID =="73c00981-7704-45c1-a0b1-c68f526a6c20"
replace teaching_language = 2 if interview_ID =="831c1990-b278-4749-895b-b4dd1264022d"
replace teaching_language = 2 if interview_ID =="7943994d-ee2d-4c6b-9bd9-4d8950008f94"
replace teaching_language = 2 if interview_ID =="b6a36043-a94f-43e3-8c1c-c476dc69d75f"
replace teaching_language = 2 if interview_ID =="2abb8dd0-08b8-41a7-9637-3e8e64ae7276"
replace teaching_language = 2 if interview_ID =="2917010d-b894-44fb-a283-5774df652cea"
replace teaching_language = 2 if interview_ID =="b81e1bc3-2b34-4971-9767-532ba20fa416"
replace teaching_language = 1 if interview_ID =="8ad12e26-7380-4936-8b9d-7771e5b65fec"
replace teaching_language = 1 if interview_ID =="32c49089-74ee-45b7-9679-59f048b79e51"
replace teaching_language = 1 if interview_ID =="7895b14d-fcb2-45d4-b877-8b48e14e4457"
replace teaching_language = 4 if interview_ID =="4eccc41a-693f-4135-9880-96c4c573e17e"
replace teaching_language = 4 if interview_ID =="ed7cd5a0-66e5-4a55-8fec-0a2bd743055a"
replace teaching_language = 4 if interview_ID =="a6aa0863-5ea8-4d5b-a71f-0f72020a501d"
replace teaching_language = 4 if interview_ID =="162e0b66-4d5c-4500-957e-463f05da65da"
replace teaching_language = 4 if interview_ID =="a95e954e-5f08-41cb-978a-0e606e2c85a2"
replace teaching_language = 4 if interview_ID =="2dc59d1d-b6cf-4bdb-a734-4a2e0e41dad4"
replace teaching_language = 4 if interview_ID =="bf1675f1-d576-4306-9119-3c8533bdebe3"
replace teaching_language = 4 if interview_ID =="20c72d9f-b7fb-448e-bb20-fc8806183901"
replace teaching_language = 4 if interview_ID =="19fa14ae-1ce1-4c06-9e3f-9ee79f3876f5"
replace teaching_language = 4 if interview_ID =="69dd2e9c-6b09-4bc0-b7cb-a72c261efa79"
replace teaching_language = 4 if interview_ID =="d2c71a15-324b-4908-880c-cd2a37b9ae46"
replace teaching_language = 4 if interview_ID =="9eb564d4-7e04-41bf-8459-db05771e754f"
replace teaching_language = 4 if interview_ID =="163a6306-383f-4c50-b275-748a2dfc1784"
replace teaching_language = 4 if interview_ID =="c92f24a4-f128-4e90-becb-b22254757d25"
replace teaching_language = 4 if interview_ID =="1ff0ba88-de3e-412e-a91c-0e00fc6e02d1"
replace teaching_language = 4 if interview_ID =="a0be9944-2ce1-40ed-a1ee-6a74e3ba3489"
replace teaching_language = 4 if interview_ID =="b36268e5-4160-4503-af8d-779c7e257c28"
replace teaching_language = 4 if interview_ID =="9ae1afd4-343c-4676-aaa1-794fcf1401f0"
replace teaching_language = 4 if interview_ID =="4216a0b5-263e-4c69-b5a3-20b7c1e79ebc"
replace teaching_language = 4 if interview_ID =="6667c4d9-0ce3-4390-a29d-cb3041f9b9c0"
replace teaching_language = 4 if interview_ID =="7e41401a-2629-47d3-989b-331096ec30d2"
replace teaching_language = 4 if interview_ID =="ad0546d6-62c5-4dcb-9bf0-8294b459aed0"
replace teaching_language = 4 if interview_ID =="88172f5d-9ee2-49ed-a194-88aa39fd0d68"
replace teaching_language = 4 if interview_ID =="15309489-7991-4be9-917f-e95ae1a1f634"
replace teaching_language = 4 if interview_ID =="b5bc2e22-eec6-45b8-93a7-376bc26a4eb8"
replace teaching_language = 4 if interview_ID =="8ac31df8-b66c-45e7-9182-fd248c6cc65f"
replace teaching_language = 4 if interview_ID =="69bec4cc-9e03-4580-a866-83f43498287e"
replace teaching_language = 4 if interview_ID =="06ab165a-d11f-448a-a479-159b3d8a2b93"
replace teaching_language = 4 if interview_ID =="4582ecc6-5903-4cef-a07a-afa4b68bfd75"
replace teaching_language = 4 if interview_ID =="536c993a-d5db-4c69-b4f3-f2011bc391a0"
replace teaching_language = 4 if interview_ID =="cbb99d8f-f08c-4dc8-b5b1-7ed736cd9ffa"
replace teaching_language = 4 if interview_ID =="509cd000-5938-4ec0-a757-8c207ffab784"
replace teaching_language = 4 if interview_ID =="25712d97-52bd-477b-acee-5157f9514c8c"
replace teaching_language = 4 if interview_ID =="beb09b4d-4425-42ef-864b-9612321d4794"
replace teaching_language = 1 if interview_ID =="1ccc86eb-4e04-49f2-92b6-4face371bfa0"
replace teaching_language = 1 if interview_ID =="b6e7e68b-c4bb-4bd4-ab22-223c837ff10c"
replace teaching_language = 1 if interview_ID =="f150858d-e984-41f3-8a01-d7722b025a8c"
replace teaching_language = 2 if interview_ID =="7c7ce476-52ae-46d1-b214-b24d120eac32"
replace teaching_language = 2 if interview_ID =="d2e4d460-7652-4152-adb3-1cb0be59410f"
replace teaching_language = 2 if interview_ID =="f675a67f-886a-4acb-87da-91195b6d558c"
replace teaching_language = 2 if interview_ID =="accab29a-0a0f-43b0-971e-39a0935bae0b"
replace teaching_language = 2 if interview_ID =="7467ffd5-3823-48ad-af1b-2dbf89e5b889"
replace teaching_language = 2 if interview_ID =="030cc374-461f-4f8c-b20a-e8b448d623ed"
replace teaching_language = 2 if interview_ID =="5639a53d-d823-49c6-9c60-20daa7cd9038"
replace teaching_language = 2 if interview_ID =="17369be9-8fbf-4c5e-a6fb-14aae2949693"
replace teaching_language = 2 if interview_ID =="80f1eda4-fbb1-46d2-97df-c112986ab45f"
replace teaching_language = 2 if interview_ID =="f524f689-f0e8-48ab-9723-1d224ba7a2d1"
replace teaching_language = 2 if interview_ID =="25388f44-35b3-4a7a-9cc8-be9fd1c25fe3"
replace teaching_language = 2 if interview_ID =="508164a5-6284-4172-9f2b-06e4eaf9d2bc"
replace teaching_language = 2 if interview_ID =="e6f2e82d-1582-454b-8f26-b97d0dc342de"
replace teaching_language = 2 if interview_ID =="c7efe715-4657-4bf7-a399-f7a9765cadca"
replace teaching_language = 2 if interview_ID =="7fa95357-6e70-4c2b-a2d8-ead718a6157b"
replace teaching_language = 2 if interview_ID =="b6958f8b-3db2-4e2c-8d63-b712285d825f"
replace teaching_language = 2 if interview_ID =="97ff7b85-efa8-4924-8a09-2ee4ebe61ef6"
replace teaching_language = 2 if interview_ID =="3d58b784-d765-47c6-bc77-c1f0e04c4bb1"
replace teaching_language = 2 if interview_ID =="7223b5f2-dde7-4dcc-a095-6be5735db507"
replace teaching_language = 2 if interview_ID =="80c94ed1-e18f-47e8-8287-b802240db3b8"
replace teaching_language = 2 if interview_ID =="571941a4-f410-4cbe-a1d8-b24e2a785c44"
replace teaching_language = 2 if interview_ID =="3abc00de-9343-4d72-9614-833bfa1a735c"
replace teaching_language = 2 if interview_ID =="c7293c71-cd66-4df0-a180-3d65dec93a28"
replace teaching_language = 2 if interview_ID =="885cefd5-bd54-453f-b27a-3dd909fb3e51"
replace teaching_language = 2 if interview_ID =="4b934f6a-45c0-4a64-9416-46b346f21acc"
replace teaching_language = 2 if interview_ID =="0fa6f447-1765-441c-bec8-488ba19c6d57"
replace teaching_language = 2 if interview_ID =="fdcd1d5b-1e6e-474e-8669-310e2b781e51"
replace teaching_language = 2 if interview_ID =="a63d1c79-f57a-43b0-8ad5-5209d0d7fffb"
replace teaching_language = 2 if interview_ID =="fc642d39-0573-4830-a23a-27200feb0490"
replace teaching_language = 2 if interview_ID =="87696f04-702d-4bac-8460-cf72db1a42f0"
replace teaching_language = 1 if interview_ID =="c4783693-ad83-4f4f-a2fa-e1970e56e81d"
replace teaching_language = 1 if interview_ID =="3abe7bad-ae05-41a1-a3fc-92114f340b1e"
replace teaching_language = 1 if interview_ID =="00826e7c-3fee-4d2a-ac67-3df565e0fd5c"
replace teaching_language = 2 if interview_ID =="9c9cccc8-4c9d-4e72-84aa-af34f703e184"
replace teaching_language = 2 if interview_ID =="63e07917-b3a6-4475-a3bb-8e027b3dc813"
replace teaching_language = 2 if interview_ID =="a211cbb3-0f58-4c5b-8ed6-66790aa9af0c"
replace teaching_language = 2 if interview_ID =="2682570a-c0cb-433d-952f-87fc71639c5f"
replace teaching_language = 2 if interview_ID =="1d29936e-abd3-41f4-b7d4-f7550a542441"
replace teaching_language = 2 if interview_ID =="61858bf5-4529-4ce4-9132-8974caf9c80c"
replace teaching_language = 2 if interview_ID =="2954206b-aedd-492a-bc40-f631781a0811"
replace teaching_language = 2 if interview_ID =="c6e82907-fb84-445d-b18c-ad21e3b373d6"
replace teaching_language = 2 if interview_ID =="c6e516ed-482b-464a-86e9-8eb829bfea2e"
replace teaching_language = 2 if interview_ID =="8a7901a0-bde0-47f7-8908-c1a47823f385"
replace teaching_language = 2 if interview_ID =="8f5a83df-7884-419f-b21e-de1b9d422037"
replace teaching_language = 2 if interview_ID =="d3f89a12-f705-43c8-8581-630ea4421dde"
replace teaching_language = 2 if interview_ID =="3cd11e49-26ef-4306-9f10-2d024d4df17b"
replace teaching_language = 2 if interview_ID =="1e6ce836-abca-4845-8650-e0d52914b27f"
replace teaching_language = 2 if interview_ID =="8e04f3d5-23dd-4146-a9b5-cf607883ccef"
replace teaching_language = 2 if interview_ID =="d2caf56a-4342-4405-9ae8-1235540a4325"
replace teaching_language = 2 if interview_ID =="ca2cc16f-af4a-4832-b6c4-d28f16bfb1e3"
replace teaching_language = 2 if interview_ID =="71469162-ccdf-4ec2-8b14-4806547db824"
replace teaching_language = 2 if interview_ID =="c8ff5326-e9dd-4955-94ef-52e0164bd216"
replace teaching_language = 2 if interview_ID =="1135b700-ad36-483a-bf8f-526ad318ba9d"
replace teaching_language = 2 if interview_ID =="ac205740-fd5b-48b6-8beb-60b3680323c5"
replace teaching_language = 2 if interview_ID =="4302fdc3-7c5f-49d8-bab2-746d0ebe119e"
replace teaching_language = 2 if interview_ID =="6e9be019-e514-4517-a314-6a4d79a7e17d"
replace teaching_language = 2 if interview_ID =="02e82e7c-ee77-4571-ba56-7605bfa08a2c"
replace teaching_language = 2 if interview_ID =="d8399ee7-cd01-4ad7-b47c-3a5b89b3df3a"
replace teaching_language = 2 if interview_ID =="3b1ebb7d-9a19-46b6-a0fe-85c277d343d9"
replace teaching_language = 2 if interview_ID =="0f8e2f43-6bb2-4f63-9ba0-21563437c026"
replace teaching_language = 2 if interview_ID =="2ef4702e-3e93-4985-beaf-8c6bd59946a7"
replace teaching_language = 2 if interview_ID =="0c3af58d-b82b-4712-aa60-e65eddbb6539"
replace teaching_language = 2 if interview_ID =="e95fe261-dcd2-46ba-a433-c94aebc53d2a"
replace teaching_language = 1 if interview_ID =="936b8519-0a68-47e1-96c3-ca0e5316df62"
replace teaching_language = 1 if interview_ID =="0f32ff33-1eee-4513-a1ab-7b28e2c94fff"
replace teaching_language = 1 if interview_ID =="f634b439-08fa-4b47-bfbe-5416412abf36"
replace teaching_language = 2 if interview_ID =="88491fd8-0f10-4149-b19a-e08749cb19aa"
replace teaching_language = 2 if interview_ID =="d9d0b92a-b8a8-4257-a023-a2998cf20c0f"
replace teaching_language = 2 if interview_ID =="f93dbef1-0704-4a98-9636-17619e58269f"
replace teaching_language = 2 if interview_ID =="75886d6f-abcc-466f-b3ae-82a162a946ac"
replace teaching_language = 2 if interview_ID =="a565338f-16a8-457b-80f9-58160bec56ce"
replace teaching_language = 2 if interview_ID =="dd1fe3db-a145-4a8c-aa41-9417c967283e"
replace teaching_language = 2 if interview_ID =="284166c3-ffda-436a-9335-d4f2e1530693"
replace teaching_language = 2 if interview_ID =="2129eac4-01e6-4474-b7e5-cd61d3de8fcc"
replace teaching_language = 2 if interview_ID =="01f3c52b-8514-4b3a-a333-b300c59019e5"
replace teaching_language = 2 if interview_ID =="820de0cb-482a-4efe-af19-e34a4d80124d"
replace teaching_language = 2 if interview_ID =="9dcb0660-9960-4ef7-99a1-798353192be1"
replace teaching_language = 2 if interview_ID =="569e513e-88a5-4a78-9eae-339ee0fa17f2"
replace teaching_language = 2 if interview_ID =="810a0ce7-c3fc-4dee-ac68-42f0f284c409"
replace teaching_language = 2 if interview_ID =="bc4131fa-a489-46f1-85b3-effdb1d8b52f"
replace teaching_language = 2 if interview_ID =="8fd6d725-5058-4b3e-a0aa-82fbcbbc8a11"
replace teaching_language = 2 if interview_ID =="16f1d853-91f4-4029-9a98-3dd2ab562357"
replace teaching_language = 2 if interview_ID =="29417b44-ae39-4fb9-861e-26ed5fb81842"
replace teaching_language = 2 if interview_ID =="009a0a05-3bc1-4d86-991d-7fc7dfeacfd9"
replace teaching_language = 2 if interview_ID =="db71bf7a-bf57-4ebe-a930-7d0f359607cc"
replace teaching_language = 2 if interview_ID =="984b9d35-d5c7-42b0-8a4a-f68e4d035fd6"
replace teaching_language = 2 if interview_ID =="14457211-4d52-4570-ae1e-c5c75f354175"
replace teaching_language = 2 if interview_ID =="23ce1a66-9eb2-42c5-81c8-7d10cc7918e5"
replace teaching_language = 2 if interview_ID =="247f896d-2bf0-481f-b61d-d0352370233f"
replace teaching_language = 2 if interview_ID =="76978c17-7719-4533-93c1-b0f3849d294a"
replace teaching_language = 2 if interview_ID =="3ed5b130-3b53-48cf-b17a-a4eaecc7d341"
replace teaching_language = 2 if interview_ID =="cce03981-4996-4a5d-b475-d2868e34783e"
replace teaching_language = 2 if interview_ID =="15e250a4-1118-4cf9-b4ec-3891b8ff162a"
replace teaching_language = 2 if interview_ID =="da61f6f3-e699-4546-93b8-686d284255a5"
replace teaching_language = 2 if interview_ID =="d35d2383-0a47-4ed2-bee8-68275cc26b0a"
replace teaching_language = 2 if interview_ID =="93a011ec-88bb-46ae-b2e1-2ad4ea2e75ea"
replace teaching_language = 1 if interview_ID =="f8959099-5a49-4c05-ba77-171a41309c79"
replace teaching_language = 1 if interview_ID =="dfc970ce-7cb4-4ac4-9a20-fdee11481469"
replace teaching_language = 1 if interview_ID =="c9a065cd-cab2-4583-9658-9fe14376716d"
replace teaching_language = 4 if interview_ID =="bbf2abd2-df7b-45f2-9f1b-34de26b7ed3a"
replace teaching_language = 4 if interview_ID =="b957881c-18e3-4f06-98f8-aafd80f6cd66"
replace teaching_language = 4 if interview_ID =="150aa235-8ef7-4886-a2f5-5ea03ffc7924"
replace teaching_language = 4 if interview_ID =="59654320-48f0-443e-a345-bdd2c05a826b"
replace teaching_language = 4 if interview_ID =="245fa1de-47b5-4677-b4d7-2dd95f9a2e9a"
replace teaching_language = 4 if interview_ID =="8b28e407-54f7-4751-9f78-a332bc35dc03"
replace teaching_language = 4 if interview_ID =="7cd83584-fa4c-4ef4-8924-0de3a7a79144"
replace teaching_language = 4 if interview_ID =="1c5fd30a-fa3e-44b0-9925-84b39ffb5d3e"
replace teaching_language = 4 if interview_ID =="f8ed5942-4d6e-4897-9fe1-40fabdcaceec"
replace teaching_language = 4 if interview_ID =="f69c8a0e-766c-45a8-aaf3-b18764a8883c"
replace teaching_language = 4 if interview_ID =="b3b0eeb6-a338-42aa-89f8-cbb01e9f7e88"
replace teaching_language = 4 if interview_ID =="fa0f796c-ef7d-4d7b-a1e9-7ea7c21560fc"
replace teaching_language = 4 if interview_ID =="8997132e-615f-443b-8fdf-56be2371efcc"
replace teaching_language = 4 if interview_ID =="67f8cabb-4851-4916-9fe0-ca26da6dc43c"
replace teaching_language = 4 if interview_ID =="c8d5fd89-1a74-4a69-a0dd-c8e1563427d8"
replace teaching_language = 4 if interview_ID =="16ac1e05-29dd-44b8-a6fc-38f813643e83"
replace teaching_language = 4 if interview_ID =="11068648-384f-4b15-99a6-5931fc1213d1"
replace teaching_language = 4 if interview_ID =="0a4532f9-851d-469d-8daf-33bc988a0dfe"
replace teaching_language = 4 if interview_ID =="15d5a34f-99ff-4d5b-a1a4-a4a084c1d150"
replace teaching_language = 4 if interview_ID =="9b7cbbc8-6219-4d2f-bd59-3e538ce3b27f"
replace teaching_language = 4 if interview_ID =="239ddf07-e0dd-4d86-b3e1-1aebc28e784b"
replace teaching_language = 4 if interview_ID =="0dd83c4d-5f61-4168-bd29-d0e8083bd7e8"
replace teaching_language = 4 if interview_ID =="76b7e9d7-e589-47e1-ada4-08bc1dab89e5"
replace teaching_language = 4 if interview_ID =="c4c066ca-eaca-43bf-8be7-2d24dd4b3aa3"
replace teaching_language = 4 if interview_ID =="eeec3012-d277-4773-8885-ee575d6441b3"
replace teaching_language = 4 if interview_ID =="b1205d44-2db5-4aa5-9c32-4c649592e047"
replace teaching_language = 4 if interview_ID =="602fe0e6-31ff-4ba7-a73b-9398d294b597"
replace teaching_language = 4 if interview_ID =="21ed6ac9-8016-4385-9d04-7d39600e85bc"
replace teaching_language = 1 if interview_ID =="1181c6ab-1662-4855-9880-b914123648c0"
replace teaching_language = 1 if interview_ID =="632deb19-2cf6-422b-b928-d0d44e9969a1"
replace teaching_language = 1 if interview_ID =="b224b867-b87e-4884-8d8c-e379261adbf5"
replace teaching_language = 4 if interview_ID =="d0aee15e-1a4e-4426-a373-ed554107e43e"
replace teaching_language = 4 if interview_ID =="fa250cbb-efa6-436f-83ee-8ee7183c26b5"
replace teaching_language = 4 if interview_ID =="cf7d8a9f-2df6-4ad5-ad40-5ec18169b951"
replace teaching_language = 4 if interview_ID =="4603863a-574a-4a47-a976-8139526e9e8a"
replace teaching_language = 4 if interview_ID =="721d03b4-f66a-4e93-8cd0-6d5f61f02f4d"
replace teaching_language = 4 if interview_ID =="605ccb81-1796-4d11-8718-58f4897b6960"
replace teaching_language = 4 if interview_ID =="944d2c75-b555-4afa-9810-cf7ea22efa1e"
replace teaching_language = 4 if interview_ID =="ba81eaab-4b85-4326-b441-fead5f629fb4"
replace teaching_language = 4 if interview_ID =="a4cf998d-266c-49ed-ac1c-d450266284a0"
replace teaching_language = 4 if interview_ID =="8c35a464-a767-4e32-b380-9b31545eb8d8"
replace teaching_language = 4 if interview_ID =="352aa2d1-6f2b-4fb8-ba70-e8b1fa066971"
replace teaching_language = 4 if interview_ID =="e2244d88-b77d-44c2-b8a4-440b6fc537ff"
replace teaching_language = 4 if interview_ID =="0428ace6-21a7-4c7b-9670-5d284bf06987"
replace teaching_language = 4 if interview_ID =="f7ef49fc-849d-4b5f-bbbf-05c72d0566bd"
replace teaching_language = 4 if interview_ID =="84410bed-4a92-4c64-b528-a1c08694a9b7"
replace teaching_language = 4 if interview_ID =="9ec46caf-a671-49b6-a66d-f73eeef13f63"
replace teaching_language = 4 if interview_ID =="c7c0a4ff-3e09-4f4a-9c5c-d76cc60e34af"
replace teaching_language = 4 if interview_ID =="951be73b-44cb-4969-b88a-aa0a820466b3"
replace teaching_language = 4 if interview_ID =="a958a897-82f2-4ffb-b404-19d74922ba2c"
replace teaching_language = 4 if interview_ID =="b44bca0b-23b4-4225-a1c8-3ca20d06224c"
replace teaching_language = 4 if interview_ID =="442d36cf-cf53-4e40-af0a-8c1f8adfd35c"
replace teaching_language = 4 if interview_ID =="a669355c-c861-4c4c-aec7-6e4702b12e29"
replace teaching_language = 4 if interview_ID =="f097c3dd-5bb0-4c01-b993-62eca8d58e16"
replace teaching_language = 4 if interview_ID =="b8c3591e-cabb-47a2-8dd3-21a9f8358279"
replace teaching_language = 4 if interview_ID =="fe0c37e0-52ab-4385-bd02-39c902ec214d"
replace teaching_language = 4 if interview_ID =="d6a5f352-9991-4676-ace0-75ad04367d4f"
replace teaching_language = 4 if interview_ID =="b4f87406-afd2-40d1-8bba-f3ec88cf4a55"
replace teaching_language = 4 if interview_ID =="10e18a5d-a3d3-418c-a172-aa94b5e7a891"
replace teaching_language = 1 if interview_ID =="8b3a4326-6be3-4662-bd21-0e7a142e2b26"
replace teaching_language = 1 if interview_ID =="158cc3d4-3f65-4cc0-b2b6-a0037c1b87c6"
replace teaching_language = 1 if interview_ID =="0968ca27-1ccf-4021-8480-295af2563110"
replace teaching_language = 4 if interview_ID =="8fe054f0-1f47-4f27-bfb2-285567c64902"
replace teaching_language = 4 if interview_ID =="7d30c532-bf01-4ed7-b47a-19eb1d3cd8ec"
replace teaching_language = 4 if interview_ID =="5b31c448-ae85-4394-9e97-8ca581a63efb"
replace teaching_language = 4 if interview_ID =="8b7ba1f8-db7f-4d59-bed7-8546b2b11c15"
replace teaching_language = 4 if interview_ID =="c1510086-cb40-474b-9110-e73918591865"
replace teaching_language = 4 if interview_ID =="1076d730-9f06-4dfd-86c6-920a2be574fa"
replace teaching_language = 4 if interview_ID =="3405399b-da3f-4b77-9ef8-524e2275b7fc"
replace teaching_language = 4 if interview_ID =="1e0571ed-db76-4822-8c23-8af79ce41085"
replace teaching_language = 4 if interview_ID =="c4be5fc4-0ca3-4770-a6bf-dbe1e86c90e1"
replace teaching_language = 4 if interview_ID =="a06d65c4-cb0a-4972-b670-ca3c22da4056"
replace teaching_language = 4 if interview_ID =="053efc8e-dc45-49c9-af6d-ac9e3709047f"
replace teaching_language = 4 if interview_ID =="c6e8cfab-7075-44b6-8ccd-621f33407259"
replace teaching_language = 4 if interview_ID =="21b4c50d-0c3f-4dd4-ba0d-bc2f459da32a"
replace teaching_language = 4 if interview_ID =="4bb7a987-02b3-4411-ad86-fd9e959c4302"
replace teaching_language = 4 if interview_ID =="afa683a4-53da-44d5-a39f-42343962e194"
replace teaching_language = 4 if interview_ID =="90fceb6c-0ebe-4300-a0b5-34ba6b6af976"
replace teaching_language = 4 if interview_ID =="8ea4e409-5e2d-445d-95d3-7f3205e7404f"
replace teaching_language = 4 if interview_ID =="c4f16d04-1c01-45b4-94be-87c5313f6a26"
replace teaching_language = 4 if interview_ID =="f31debf1-445d-4854-9972-1ca3f3a45323"
replace teaching_language = 4 if interview_ID =="0dc686f3-34c2-41e2-b736-b7193705afe1"
replace teaching_language = 4 if interview_ID =="fff7f585-b9b1-4a11-9fd6-83293abead8a"
replace teaching_language = 4 if interview_ID =="9cbc322c-f905-4680-81b9-b3e79e159afc"
replace teaching_language = 4 if interview_ID =="c661d318-bc92-4a49-bdaa-82467b79d913"
replace teaching_language = 4 if interview_ID =="6ded6395-77f8-41b2-8108-1b97a4229c0f"
replace teaching_language = 4 if interview_ID =="adbe626c-018e-4354-8b2f-cf95068acc76"
replace teaching_language = 4 if interview_ID =="54b99c24-5a34-46b8-9e7d-485f3e0abb6f"
replace teaching_language = 4 if interview_ID =="3a3ebddd-8fe5-4dd4-ba86-3d1b49e43eda"
replace teaching_language = 4 if interview_ID =="5379d279-d5e5-49b9-9c48-88ae09cd22d1"
replace teaching_language = 4 if interview_ID =="f2dd19b2-2c65-47ff-ade5-e46f7663a31d"
replace teaching_language = 4 if interview_ID =="5f727244-96b2-401e-8b19-5a3b5bb464ce"
replace teaching_language = 1 if interview_ID =="e3348e99-aa13-4199-a3b0-a997df91a845"
replace teaching_language = 1 if interview_ID =="ad534585-c04b-444a-8781-63a6e544c27f"
replace teaching_language = 1 if interview_ID =="19d88ac1-b717-4aa5-bf1a-bfcb7a28ee70"

replace teaching_language = 2 if interview_ID == "ab9fd958-1990-44e2-b223-8a32c4251250"
replace teaching_language = 1 if interview_ID == "ad8ac41d-6e8b-4542-99d3-f90c0ddf6951"

lab var Intro_Q1"What do you like to do when you're not in school?"
lab var Intro_Q2"What do you like to play?"
lab var B2_S"Please specify other?"
lab var IA"IA"
lab var IEF"IEF"
lab var Arrondissement"Arrondissement"
lab var Commune"Commune"
lab var Ecole"Ecole"
lab var Groupe"Groupe"
lab var Language"Language"
lab var Echantillon"Echantillon"

foreach x in interviewer_semantic_1 interviewer_semantic_2 interviewer_semantic_3 interviewer_semantic_4{
	lab var `x'"What is your level of confidence in accurately counting the words"
}

foreach x in word_count_language_1 word_count_language_2 word_count_language_3 word_count_language_4{
	lab var `x'"Enter number of correct words spoken in this language in 60 seconds"
}

foreach x in semantic_recording_1 semantic_recording_2 semantic_recording_3 semantic_recording_4{
	lab var `x'"Semantic language recording"
}

lab var counting_score"Counting scores"
lab var position_tracking_score"Position tracking scores"
lab var rc_pm_stop_sr"Interviewer: Was the stop rule triggered Picture matching?"
lab var oral_reading_fluency_stop_sr"Interviewer: Was the stop rule triggered Oral reading fluency words?"

replace B9_S = "Funeral ceremony" if interview_ID =="5b6d1a91-e454-45a3-9170-9a2eec4edbf8"
replace B9_S = "Registration problem" if interview_ID =="1ccccc68-0735-4dab-b908-a0d3a80a4c9a"
replace B9_S = "Her mother had gone to a funeral and locked the room, so she couldn't get her bag or clothes out" if interview_ID =="5875efa2-2b0b-4353-b809-e69b1c767cc7"
replace B9_S = "Going to Koranic school" if interview_ID =="b876096e-74c4-47c5-a8a6-c231acfb3c19"
replace B9_S = "My grandmother asked me not to go" if interview_ID =="323e8c24-dd56-4749-a507-d0699efc9619"
replace B9_S = "I just registered for school." if interview_ID =="a4a6f75f-1744-4db0-80b0-57c6ac0efdd4"
replace B9_S = "My father had forbidden me to go." if interview_ID =="9d01a6dd-da25-4d18-9744-db374ab09077"
replace B9_S = "There was a ceremony at home." if interview_ID =="754b931b-ece0-41f4-a665-b9019bcc32ca"
replace B9_S = "I was traveling." if interview_ID =="694ca3cc-60ec-41ad-a1c5-67d80e575560"
replace B9_S = "Ceremony at home." if interview_ID =="b6828548-ca8c-4d29-ae1a-7907eb5a9024"
replace B9_S = "There was a funeral next to our house." if interview_ID =="de9a04ad-61ff-4dca-96fe-11636ad44752"
replace B9_S = "I had gone to visit my father." if interview_ID =="69dd2e9c-6b09-4bc0-b7cb-a72c261efa79"
replace B9_S = "There was a wedding at my house." if interview_ID =="4bb7a987-02b3-4411-ad86-fd9e959c4302"
replace B9_S = "Visiting my father." if interview_ID =="7e41401a-2629-47d3-989b-331096ec30d2"
replace B9_S = "Traveling." if interview_ID =="9f7659dc-9afe-4a82-8543-73740869cdf0"
replace B9_S = "There was a test for the 5th grade students at school." if interview_ID =="0f8e2f43-6bb2-4f63-9ba0-21563437c026"

foreach x in phonological_awareness_sr_1 phonological_awareness_sr_2 phonological_awareness_sr_3 phonological_awareness_sr_4 phonological_awareness_sr_5 phonological_awareness_sr_6 phonological_awareness_sr_7 phonological_awareness_sr_8 phonological_awareness_sr_9 phonological_awareness_sr_10 phonological_awareness_srnumCorr phonological_awareness_srnum_att phonological_awareness_srgridAut phonological_awareness_srautoSto phonological_stop_sr{
	replace `x' = . if interview_ID == "78a49041-d127-4435-8039-b1b24678b8d2"
}

replace rc_picture_matching_fr_q6=. if inlist(interview_ID,"1eeedaaf-eecb-45b0-a69d-ea362dd1c425")

replace rc_picture_matching_fr_q6 = 4 if inlist(interview_ID,"8177163f-7625-4dbd-809d-b732d2a7e147","934c7889-6a58-4c21-804a-3051544df184","503806bb-0442-41e5-84a8-c98d8934a9dd","8c21f71d-6af5-489c-b9c0-71360d00efce","b32b66aa-4135-42d6-9c0f-a0310a39823c")

replace rc_pm_stop_fr = 1 if inlist(interview_ID,"1eeedaaf-eecb-45b0-a69d-ea362dd1c425","8177163f-7625-4dbd-809d-b732d2a7e147","934c7889-6a58-4c21-804a-3051544df184","503806bb-0442-41e5-84a8-c98d8934a9dd","8c21f71d-6af5-489c-b9c0-71360d00efce","b32b66aa-4135-42d6-9c0f-a0310a39823c")

replace rc_pm_stop_wf = 1 if inlist(interview_ID,"8687f9cd-5f4b-4e86-8eb0-4983e57fb21a","fac43095-6f57-476e-bc3f-6364aab4708e","ca332f93-3166-4d0a-90ef-44d651ebf19a","c7293c71-cd66-4df0-a180-3d65dec93a28","e7745731-8ebf-4eeb-8ee6-0cc3f33d7d02","787eba5e-b59b-412f-9a0a-053d9de91c2b")

replace rc_picture_matching_sr_q6 = 1 if inlist(interview_ID,"5bf46475-9bde-473d-9fbb-de4437f4a567","dd15a588-de50-4999-8783-8cced1670d3c")

replace rc_pm_stop_sr = 1 if inlist(interview_ID,"503806bb-0442-41e5-84a8-c98d8934a9dd","57e40005-7add-4dd2-bb9d-5759c2981aa1","9e98747a-68bf-476c-9371-4abb80a696a8","5bf46475-9bde-473d-9fbb-de4437f4a567","dd15a588-de50-4999-8783-8cced1670d3c","6a2eb10d-f264-45a4-ac35-1f2a8e8dbc49")

replace rc_pm_stop_pr = 1 if inlist(interview_ID,"d0d60e91-9075-49c3-902c-c19440c1de60")

replace rc_pm_stop_fr = 1 if inlist(interview_ID,"9721ed24-ebf4-492b-aa39-86be19a76a04","0df49203-ad76-4492-83bb-5e34f74c9a26","72d458bc-35dc-4ff2-bbf0-8f201aa7911a","cc915cfd-626a-4f61-b79d-e34a81182e05","aabccf1f-e403-4a35-b875-e7499fd42791","412e9994-6895-4fd4-bd03-9e7bf6549add")

replace B1a = trim(strproper(B1a))
replace B1b = trim(strproper(B1b))
replace Student_Name = trim(strproper(Student_Name))

replace Intro_Q1 = trim(Intro_Q1)
replace Intro_Q2 = trim(Intro_Q2)

replace Intro_Q1 ="" if Intro_Q1 == "-999"
replace Intro_Q2 ="" if Intro_Q2 == "8"
gen inter = upper(substr(Intro_Q1,1,1)) + lower(substr(Intro_Q1,2,.)) if !missing(Intro_Q1)
replace Intro_Q1 = inter

drop inter

gen inter = upper(substr(Intro_Q2,1,1)) + lower(substr(Intro_Q2,2,.)) if !missing(Intro_Q2)
replace Intro_Q2 = inter

drop inter

replace B1a = "Awa" if interview_ID == "635b341c-b288-4928-9e48-b0293dbdaf43"
replace Student_Name = "Awa Ba" if interview_ID == "635b341c-b288-4928-9e48-b0293dbdaf43"

*GPS_Latitude
replace GPSlatitude = 15.3411223 if interview_ID == "08b9b550-4288-456e-8452-10720aed8fa4"
replace GPSlatitude = 15.3411223 if interview_ID == "0a5c5a50-0377-4a19-aa32-f63a81416f01"
replace GPSlatitude = 15.3411223 if interview_ID == "19e98665-e383-4cc7-8391-05fffe810a53"
replace GPSlatitude = 15.3411223 if interview_ID == "32c49089-74ee-45b7-9679-59f048b79e51"
replace GPSlatitude = 15.3411596 if interview_ID == "774b3968-d03d-4177-bba0-612bb98722b7"
replace GPSlatitude = 15.3411596 if interview_ID == "7895b14d-fcb2-45d4-b877-8b48e14e4457"
replace GPSlatitude = 15.3411596 if interview_ID == "7943994d-ee2d-4c6b-9bd9-4d8950008f94"
replace GPSlatitude = 15.3410163 if interview_ID == "a44445f0-b02d-4376-9985-6440a6a54352"
replace GPSlatitude = 15.3410163 if interview_ID == "b3d2bace-76f2-4c37-8dae-bd6d50d38057"
replace GPSlatitude = 15.3410163 if interview_ID == "c36a9870-8acb-41cb-b989-78b7f52753a9"
replace GPSlatitude = 15.3410163 if interview_ID == "c860a452-4dca-422b-927b-af6f89153562"
replace GPSlatitude = 15.3410163 if interview_ID == "db517ef9-86bd-4b52-843b-79db6f9148a9"
replace GPSlatitude = 15.3410163 if interview_ID == "ff7bcb16-4d87-4766-8924-fb161da2e83e"
replace GPSlatitude = 14.4773953 if interview_ID == "8466ba38-fcc1-43ca-a8e9-05b223e5cd2b"
replace GPSlatitude = 15.3574176 if interview_ID == "06ab165a-d11f-448a-a479-159b3d8a2b93"
replace GPSlatitude = 15.3574176 if interview_ID == "7e41401a-2629-47d3-989b-331096ec30d2"
replace GPSlatitude = 15.3574176 if interview_ID == "cbb99d8f-f08c-4dc8-b5b1-7ed736cd9ffa"
replace GPSlatitude = 15.3574176 if interview_ID == "d2c71a15-324b-4908-880c-cd2a37b9ae46"
replace GPSlatitude = 15.2709904 if interview_ID == "944d2c75-b555-4afa-9810-cf7ea22efa1e"
replace GPSlatitude = 15.2709904 if interview_ID == "f097c3dd-5bb0-4c01-b993-62eca8d58e16"
replace GPSlatitude = 14.1316984 if interview_ID == "350b15fa-d5f7-44dd-b687-23b3042918e3"
replace GPSlatitude = 14.1316984 if interview_ID == "50ea4e94-ef69-4780-85c1-b54a57dce063"
replace GPSlatitude = 14.1316984 if interview_ID == "8aa09fba-4da6-49e4-ac56-e6aefbb9b367"
replace GPSlatitude = 14.1316984 if interview_ID == "9512b111-ff69-4336-8725-f338f37b6ef5"
replace GPSlatitude = 14.1316984 if interview_ID == "9879793b-d763-465b-a8f3-0a0fc17b978f"
replace GPSlatitude = 14.1316984 if interview_ID == "e56b2fd1-6f0d-459a-a095-d880376a2a19"
replace GPSlatitude = 14.1316984 if interview_ID == "fdcd7834-8d95-4012-94a7-4b698a0de52f"
replace GPSlatitude = 14.4641626 if interview_ID == "32e300eb-252c-4f93-8789-c63654ab68ac"
replace GPSlatitude = 14.4641626 if interview_ID == "a208d649-13cf-4550-b8ac-1aa4794fd03c"
replace GPSlatitude = 14.4641626 if interview_ID == "ae7b675e-ca64-4f3a-96f1-0a95a68acee7"
replace GPSlatitude = 14.4641626 if interview_ID == "b5f00748-476c-4f6a-b9a6-79d45036aa96"
replace GPSlatitude = 13.9575583 if interview_ID == "08862b10-8ada-4b77-8c7d-67992f7fd886"
replace GPSlatitude = 13.9575583 if interview_ID == "88cacd4e-afbc-404d-aa61-6fa3fe4db9d2"
replace GPSlatitude = 13.9575583 if interview_ID == "94c65d85-4fea-46f2-a855-22691925252a"
replace GPSlatitude = 15.3523558 if interview_ID == "14457211-4d52-4570-ae1e-c5c75f354175"
replace GPSlatitude = 15.3523558 if interview_ID == "16f1d853-91f4-4029-9a98-3dd2ab562357"
replace GPSlatitude = 15.3523558 if interview_ID == "284166c3-ffda-436a-9335-d4f2e1530693"
replace GPSlatitude = 15.3523558 if interview_ID == "569e513e-88a5-4a78-9eae-339ee0fa17f2"
replace GPSlatitude = 15.3523558 if interview_ID == "75886d6f-abcc-466f-b3ae-82a162a946ac"
replace GPSlatitude = 15.3523558 if interview_ID == "9dcb0660-9960-4ef7-99a1-798353192be1"
replace GPSlatitude = 15.3523558 if interview_ID == "db71bf7a-bf57-4ebe-a930-7d0f359607cc"
replace GPSlatitude = 14.1371195 if interview_ID == "0022196e-5323-4a02-8fab-cd760ad8050e"
replace GPSlatitude = 14.1371195 if interview_ID == "2edb0e64-35bb-4d15-8a3a-cb2391ae5261"
replace GPSlatitude = 14.1371195 if interview_ID == "cbab8118-f56c-42ea-9492-e33f984ed12d"
replace GPSlatitude = 14.1371195 if interview_ID == "da9aae0b-7203-4a0f-af5b-285747ec8001"
replace GPSlatitude = 14.1371195 if interview_ID == "fbefabcb-1121-4581-8d69-c984c41835f3"
replace GPSlatitude = 13.9499182 if interview_ID == "50e76470-2f86-4ae1-a6c3-714d27a72cda"
replace GPSlatitude = 13.9499182 if interview_ID == "55458af1-cf96-42fb-8a23-9c3a0709a177"
replace GPSlatitude = 13.9499182 if interview_ID == "6256b3fb-c6c8-4c33-a9bd-6e41309ea0d6"
replace GPSlatitude = 13.9499182 if interview_ID == "78e94deb-38c9-425c-b647-739d3038e60b"
replace GPSlatitude = 13.9499182 if interview_ID == "9ffb65da-52b0-4eca-85d1-ce56cd1f8d6a"
replace GPSlatitude = 14.4517078 if interview_ID == "04188747-378a-4465-b3a2-f5a7e751ec7f"
replace GPSlatitude = 14.4517078 if interview_ID == "1b198724-2c86-44b2-93d7-b84f070b7724"
replace GPSlatitude = 14.4517078 if interview_ID == "cd25d754-c050-4770-a221-8f2c79b61c2d"
replace GPSlatitude = 14.4517078 if interview_ID == "deca15db-3525-43b6-b3e6-56fef304dc3a"
replace GPSlatitude = 14.0593219 if interview_ID == "0438dca7-5a24-46e9-8d81-4eeebfabc1f1"
replace GPSlatitude = 14.0593219 if interview_ID == "160bbba3-76dd-42a7-b8fe-4790ff034383"
replace GPSlatitude = 14.0593219 if interview_ID == "168816b3-cba7-41fd-9766-f7c1a2fe9914"
replace GPSlatitude = 14.0593219 if interview_ID == "3d0afc37-e12c-484d-9bbb-3170215d37bb"
replace GPSlatitude = 14.0593219 if interview_ID == "43f705b7-5ffc-45d3-8bcc-c6a62810ca11"
replace GPSlatitude = 14.0593219 if interview_ID == "8b8a641c-21aa-4be0-ba2a-e8b35bd75d6f"
replace GPSlatitude = 14.0593219 if interview_ID == "99f730ab-80ba-42a5-8423-c6479973a096"
replace GPSlatitude = 14.0593219 if interview_ID == "f761942c-005b-4186-a823-907f483d9ea0"
replace GPSlatitude = 14.0593219 if interview_ID == "f8aa7dbd-41d4-431f-82d7-7d29fe8e6b8a"
replace GPSlatitude = 14.1265645 if interview_ID == "70794d12-e969-47fa-834f-2878485c0e03"
replace GPSlatitude = 14.1265645 if interview_ID == "72c68a36-5d76-4704-a67b-38fbf618767a"
replace GPSlatitude = 14.1265645 if interview_ID == "d244a3be-86b6-4158-8d14-bd7a91863ea6"
replace GPSlatitude = 14.1265645 if interview_ID == "da14f1da-21db-446a-8464-3575a346b7db"
replace GPSlatitude = 14.1265645 if interview_ID == "de3b2603-110a-434f-a480-eece8ed13fa8"
replace GPSlatitude = 14.1245926 if interview_ID == "6d3906b5-2196-4cd2-86a2-fe350906db6f"
replace GPSlatitude = 14.1245926 if interview_ID == "b186bac0-cc7f-409d-853f-6e45b086c73d"
replace GPSlatitude = 14.0968563 if interview_ID == "8557f1b8-ea2a-4349-b4ae-798ca152f689"
replace GPSlatitude = 15.3730676 if interview_ID == "5d3e5dbf-5132-4f46-b027-e401fd6611f4"
replace GPSlatitude = 15.3730676 if interview_ID == "5f3c57b5-a7b6-4031-b106-64c6a4969f01"
replace GPSlatitude = 15.3730676 if interview_ID == "eeda558d-9be8-46c0-a2f7-dc543d34a5dc"
replace GPSlatitude = 15.3730676 if interview_ID == "f7f16800-2a85-442b-9f83-69ffbc18021c"
replace GPSlatitude = 14.1120511 if interview_ID == "16bfd78f-5de7-4fe9-aa6c-919d8887369c"
replace GPSlatitude = 14.1120511 if interview_ID == "3ecc7557-2ef0-4c1b-b5b2-90f37e31f222"
replace GPSlatitude = 14.1120511 if interview_ID == "4644aea1-f044-4cb4-b79a-638800249e8e"
replace GPSlatitude = 14.1120511 if interview_ID == "4a7aab47-6fa0-4d04-87dc-3a23946705b9"
replace GPSlatitude = 14.1120511 if interview_ID == "4bb9439e-83db-41e3-873d-67a4d77efc3e"
replace GPSlatitude = 14.1120511 if interview_ID == "8c2ecbf2-9074-4d91-b8e7-2a7ef846751f"
replace GPSlatitude = 14.1106183 if interview_ID == "fb9c234b-de3a-40b1-877d-e0774134e95a"
replace GPSlatitude = 14.1106183 if interview_ID == "09ddc276-9010-4c57-89c7-69894da59702"
replace GPSlatitude = 14.1106183 if interview_ID == "11e9e8f6-b131-4016-95ce-938c2c1cb711"
replace GPSlatitude = 14.1106183 if interview_ID == "16c3c3a6-3b32-4a80-877a-98f8bfcf3c43"
replace GPSlatitude = 14.1106183 if interview_ID == "2d28c81c-4180-4486-b04b-656cfd91dd55"
replace GPSlatitude = 14.1106183 if interview_ID == "3cac5927-3590-4ae1-bf72-3e52afe1eb6e"
replace GPSlatitude = 14.1106183 if interview_ID == "c931fa81-b717-4113-8476-82b40330fed9"
replace GPSlatitude = 14.1106183 if interview_ID == "ec399d0c-8225-4b25-a76a-bb8738a2a86c"
replace GPSlatitude = 14.1103861 if interview_ID == "0a52ac27-4049-490c-933d-726e41dd2c06"
replace GPSlatitude = 14.1103861 if interview_ID == "5dcd7d8c-3f6f-49ff-98f2-d6a23c5cea8e"
replace GPSlatitude = 15.5307829 if interview_ID == "0dc686f3-34c2-41e2-b736-b7193705afe1"
replace GPSlatitude = 15.5307829 if interview_ID == "19d88ac1-b717-4aa5-bf1a-bfcb7a28ee70"
replace GPSlatitude = 15.5307829 if interview_ID == "1e0571ed-db76-4822-8c23-8af79ce41085"
replace GPSlatitude = 15.5307829 if interview_ID == "21b4c50d-0c3f-4dd4-ba0d-bc2f459da32a"
replace GPSlatitude = 15.5307829 if interview_ID == "3405399b-da3f-4b77-9ef8-524e2275b7fc"
replace GPSlatitude = 15.5307829 if interview_ID == "3a3ebddd-8fe5-4dd4-ba86-3d1b49e43eda"
replace GPSlatitude = 15.5307829 if interview_ID == "5b31c448-ae85-4394-9e97-8ca581a63efb"
replace GPSlatitude = 15.5307829 if interview_ID == "8b7ba1f8-db7f-4d59-bed7-8546b2b11c15"
replace GPSlatitude = 15.5307829 if interview_ID == "a06d65c4-cb0a-4972-b670-ca3c22da4056"
replace GPSlatitude = 15.5307829 if interview_ID == "adbe626c-018e-4354-8b2f-cf95068acc76"
replace GPSlatitude = 15.5307829 if interview_ID == "c661d318-bc92-4a49-bdaa-82467b79d913"
replace GPSlatitude = 15.5307829 if interview_ID == "c6e8cfab-7075-44b6-8ccd-621f33407259"
replace GPSlatitude = 15.5307829 if interview_ID == "f2dd19b2-2c65-47ff-ade5-e46f7663a31d"
replace GPSlatitude = 15.5307829 if interview_ID == "fff7f585-b9b1-4a11-9fd6-83293abead8a"
replace GPSlatitude = 13.7624976 if interview_ID == "03f42024-3cf0-4b32-aa48-bcc0fe3f0418"
replace GPSlatitude = 13.7624976 if interview_ID == "10e062bf-f68d-477b-94f4-118c99065e40"
replace GPSlatitude = 13.7624976 if interview_ID == "730cf5db-0202-46f5-af9d-da1d9d81cfc1"
replace GPSlatitude = 13.7624976 if interview_ID == "7e93b4ff-0990-4959-86f1-4260160f4368"
replace GPSlatitude = 13.7624976 if interview_ID == "fe56020d-cd18-4921-b368-e94b7efec637"
replace GPSlatitude = 14.0885831 if interview_ID == "cb46dbc5-e66d-47fc-9ee3-abe3722fe14c"
replace GPSlatitude = 14.1652563 if interview_ID == "15ec73d8-4982-4c7c-b799-f78923569765"
replace GPSlatitude = 14.1652563 if interview_ID == "3c72b0ec-b5e9-4fa6-86b2-8af8462f9069"
replace GPSlatitude = 14.1652563 if interview_ID == "4a5d1807-d4ee-4b01-9acf-2ba308182a6a"
replace GPSlatitude = 14.1652563 if interview_ID == "7088cd6f-2a3b-419b-bf37-f84bfd9d3d27"
replace GPSlatitude = 14.1652563 if interview_ID == "d4d130ef-c112-4fe1-bb58-ecb4a1762194"
replace GPSlatitude = 14.1652563 if interview_ID == "e1e8ef67-fcc7-4588-abbf-b8ebf4aa692f"
replace GPSlatitude = 14.1339814 if interview_ID == "376bab4a-1491-4220-913d-7270c3aa17e3"
replace GPSlatitude = 14.1069198 if interview_ID == "0dacfdcf-c0bc-4414-8746-805a0a07a1a2"
replace GPSlatitude = 14.1069198 if interview_ID == "795e3e03-59cd-4798-9fd5-64b370d25d11"
replace GPSlatitude = 14.1069198 if interview_ID == "c8c669af-05e3-4e8f-b574-93b5f383b47b"
replace GPSlatitude = 14.1204176 if interview_ID == "6feed385-4b3a-45f3-9ac6-665707511869"
replace GPSlatitude = 14.1551238 if interview_ID == "61baf362-d9e8-48c0-99d8-9393c58f030a"
replace GPSlatitude = 14.1551238 if interview_ID == "627d5d94-ef32-47d0-8854-cd485a60fe3a"
replace GPSlatitude = 14.1551238 if interview_ID == "9f04ec82-5b08-4646-b1cf-a21cb6a6dad1"
replace GPSlatitude = 14.1551238 if interview_ID == "bc31015f-7e11-4be9-9d4b-5121dd871cfc"
replace GPSlatitude = 14.1551238 if interview_ID == "ff70233f-5294-4948-af54-d001d5bb26d2"
replace GPSlatitude = 15.3767223 if interview_ID == "d6de487e-f26f-4f13-9f7b-fcef2714b372"
replace GPSlatitude = 14.3722389 if interview_ID == "5897e891-24c2-443e-b321-1a07632ba4ee"
replace GPSlatitude = 14.3722389 if interview_ID == "61b74894-2eca-4fb4-8918-3997b2078334"
replace GPSlatitude = 14.3722389 if interview_ID == "b443c03e-cf8d-4ef0-827f-5de2bfb3c9ab"
replace GPSlatitude = 14.3722389 if interview_ID == "e5a05424-50b0-4bc5-b06e-6d3781281e96"
replace GPSlatitude = 13.7126863 if interview_ID == "00c10308-94b5-4ff2-b8f1-62e4b3da6fc9"
replace GPSlatitude = 13.7126863 if interview_ID == "01e6708e-e1a1-4f8f-be47-ba8cf8932f80"
replace GPSlatitude = 13.7126863 if interview_ID == "21ca6b22-982b-42ee-9a8b-0433992b4957"
replace GPSlatitude = 13.7126863 if interview_ID == "28cb40eb-9823-4220-b231-105c1766536b"
replace GPSlatitude = 13.7126863 if interview_ID == "323a4ac0-bfae-457e-a1eb-9c79ebc01032"
replace GPSlatitude = 13.7126863 if interview_ID == "5e6f524d-a2c1-451d-9433-a95872ac1f04"
replace GPSlatitude = 13.7126863 if interview_ID == "9aa67971-8b63-4b28-ae38-cef4a73120b1"
replace GPSlatitude = 13.7126863 if interview_ID == "a05bcfff-d5de-49bf-9bda-62c70e00c12d"
replace GPSlatitude = 13.7126863 if interview_ID == "b7d4715c-881a-4376-a317-e216e5849218"
replace GPSlatitude = 13.7126863 if interview_ID == "be8de64f-a46a-4600-bf17-6c49b1e0b83f"
replace GPSlatitude = 13.7126863 if interview_ID == "c08b2a86-f297-4bb2-8928-040daf48e0c6"
replace GPSlatitude = 13.7126863 if interview_ID == "c0a046c5-c100-41fa-b8a0-14042c216feb"
replace GPSlatitude = 13.7126863 if interview_ID == "cc915cfd-626a-4f61-b79d-e34a81182e05"
replace GPSlatitude = 13.7126863 if interview_ID == "cd8a4ad5-eccd-4578-8f9b-302fcb23ff6e"
replace GPSlatitude = 13.7126863 if interview_ID == "d4dd5010-da84-4f51-b226-36c2d99539e7"
replace GPSlatitude = 15.2760077 if interview_ID == "049a7f55-fcfc-4714-824b-77181feab726"
replace GPSlatitude = 15.2760077 if interview_ID == "53be1fdd-afbb-4840-9e52-599d193d005b"
replace GPSlatitude = 15.2760077 if interview_ID == "679b860d-e557-4ed0-ad12-0b30ee045491"
replace GPSlatitude = 15.2760077 if interview_ID == "88094c2c-03c5-40de-a5fd-bc20592ae4f2"
replace GPSlatitude = 15.2760077 if interview_ID == "b692ec7f-c10a-48f3-990c-dffef2cbf687"
replace GPSlatitude = 15.2760077 if interview_ID == "e621c03b-a58f-4e41-8d76-1b625301b331"
replace GPSlatitude = 14.0822808 if interview_ID == "0091564e-8b08-4d6e-ad40-4227de59f98f"
replace GPSlatitude = 14.0822808 if interview_ID == "26744dbe-3bff-49d4-9365-f17807d03196"
replace GPSlatitude = 14.0822808 if interview_ID == "651b4701-8b4a-48f7-a33c-8df23833864f"
replace GPSlatitude = 14.0822808 if interview_ID == "8d04d63a-0463-485e-8c65-4f5dde22c672"
replace GPSlatitude = 14.0822808 if interview_ID == "c8020d00-ebb2-4897-af8c-f3130dfdd071"
replace GPSlatitude = 14.0822808 if interview_ID == "d3cd1046-41d5-4f22-b03b-43a27f2afd64"
replace GPSlatitude = 14.0822808 if interview_ID == "de77bc7d-b8e0-4dad-9374-0fd5286bb74b"
replace GPSlatitude = 14.1578958 if interview_ID == "e436d9e7-f025-4417-8a92-f207c12b80e6"
replace GPSlatitude = 15.3434235 if interview_ID == "0fa6f447-1765-441c-bec8-488ba19c6d57"
replace GPSlatitude = 15.3434235 if interview_ID == "5639a53d-d823-49c6-9c60-20daa7cd9038"
replace GPSlatitude = 15.3434235 if interview_ID == "7467ffd5-3823-48ad-af1b-2dbf89e5b889"
replace GPSlatitude = 15.3434235 if interview_ID == "885cefd5-bd54-453f-b27a-3dd909fb3e51"
replace GPSlatitude = 15.3434235 if interview_ID == "97ff7b85-efa8-4924-8a09-2ee4ebe61ef6"
replace GPSlatitude = 15.3434235 if interview_ID == "accab29a-0a0f-43b0-971e-39a0935bae0b"
replace GPSlatitude = 15.3434235 if interview_ID == "d2e4d460-7652-4152-adb3-1cb0be59410f"
replace GPSlatitude = 14.3231944 if interview_ID == "aa63a8b7-09b8-4701-8f98-c778489a821c"
replace GPSlatitude = 15.4228487 if interview_ID == "18b59846-d0da-43c8-bf00-c7e71ddbcca2"
replace GPSlatitude = 15.4228487 if interview_ID == "52d26817-da8d-4f36-b5ee-ac63a0025143"
replace GPSlatitude = 15.4228487 if interview_ID == "79fc83f4-9851-4bb0-8840-6a77f025e0fe"
replace GPSlatitude = 15.2969417 if interview_ID == "4b25375a-5936-4fd0-836c-3178f0ddbe24"
replace GPSlatitude = 15.2969417 if interview_ID == "76660ce7-b5c0-4ca6-a1a0-32b15c9abde0"
replace GPSlatitude = 15.2969417 if interview_ID == "85a72bca-d923-44f5-98ef-9c06f00367ce"
replace GPSlatitude = 15.2969417 if interview_ID == "9f1d2b4f-fc36-45df-a6d4-9967dab6bcbe"
replace GPSlatitude = 14.3586395 if interview_ID == "83fd6d81-63d3-4a86-9e32-76247f9abb4f"
replace GPSlatitude = 14.3586395 if interview_ID == "9434bb7a-35ff-4ba0-8ccb-a3757c95002c"
replace GPSlatitude = 14.3586395 if interview_ID == "f20e594c-20ce-4190-b9e3-a70551d61cbe"
replace GPSlatitude = 14.3586395 if interview_ID == "f5455c5c-e5e2-40af-9d3b-ab4f16f57144"
replace GPSlatitude = 14.4360155 if interview_ID == "57e40005-7add-4dd2-bb9d-5759c2981aa1"
replace GPSlatitude = 14.4360155 if interview_ID == "840d9ee5-ca5a-43f6-a855-9257880755da"
replace GPSlatitude = 14.0401346 if interview_ID == "21a66f3a-bc71-463e-9eb7-16237de98482"
replace GPSlatitude = 14.0401346 if interview_ID == "834f3169-e6d2-4ebc-aebd-a90b1f7d26ba"
replace GPSlatitude = 15.3513855 if interview_ID == "0c3af58d-b82b-4712-aa60-e65eddbb6539"
replace GPSlatitude = 15.3513855 if interview_ID == "2682570a-c0cb-433d-952f-87fc71639c5f"
replace GPSlatitude = 15.3513855 if interview_ID == "3b1ebb7d-9a19-46b6-a0fe-85c277d343d9"
replace GPSlatitude = 15.3513855 if interview_ID == "61858bf5-4529-4ce4-9132-8974caf9c80c"
replace GPSlatitude = 15.3513855 if interview_ID == "63e07917-b3a6-4475-a3bb-8e027b3dc813"
replace GPSlatitude = 15.3513855 if interview_ID == "c8ff5326-e9dd-4955-94ef-52e0164bd216"
replace GPSlatitude = 15.3513855 if interview_ID == "ca2cc16f-af4a-4832-b6c4-d28f16bfb1e3"
replace GPSlatitude = 14.1015754 if interview_ID == "e89aecb6-f480-4786-831c-65f3b0237601"
replace GPSlatitude = 15.1880463 if interview_ID == "c8d5fd89-1a74-4a69-a0dd-c8e1563427d8"
replace GPSlatitude = 14.5398616 if interview_ID == "04d1d201-dfd2-4a7b-9a58-8902ce9ee60a"
replace GPSlatitude = 14.5398616 if interview_ID == "1d852e1b-7029-450f-937e-09975a21638b"
replace GPSlatitude = 14.5398616 if interview_ID == "2893993b-f640-47c6-9b06-28fb00386987"
replace GPSlatitude = 14.5398616 if interview_ID == "903bd68a-d26b-491a-94c2-0cf91418cf6d"
replace GPSlatitude = 14.5398616 if interview_ID == "c3b4ea71-c3bc-424a-aa3d-a97c73caf437"
replace GPSlatitude = 14.2860349 if interview_ID == "122a3775-ade1-4606-a980-f7066fb2cf1c"
replace GPSlatitude = 14.2860349 if interview_ID == "71a9e35f-0f05-476e-8160-716eb8ce68bd"
replace GPSlatitude = 14.2860349 if interview_ID == "a0c27261-8682-4b7b-a9df-d58142ec58bb"
replace GPSlatitude = 14.2860349 if interview_ID == "a7ee66c5-6ca3-4270-943e-8d97534e409e"
replace GPSlatitude = 14.2860349 if interview_ID == "a96ba806-ab05-4313-8f91-5d695422c339"
replace GPSlatitude = 14.2860349 if interview_ID == "c8f06068-cfe7-4ecc-96df-e7b3a1e03ff9"
replace GPSlatitude = 14.0904797 if interview_ID == "2e1d1197-4bb8-43ee-8ec6-43c71f5fc1af"
replace GPSlatitude = 14.0904797 if interview_ID == "70692290-12f9-4600-8e8b-161b8d6b6dd8"
replace GPSlatitude = 14.0904797 if interview_ID == "74a5d05b-d0ef-46ff-a1f8-ef76b03464ce"
replace GPSlatitude = 14.0047453 if interview_ID == "9ee1d44a-3aac-4528-88d6-e2382ae3e55e"
replace GPSlatitude = 14.0047453 if interview_ID == "aa705510-01bc-4030-81ae-ba6279c3d234"
replace GPSlatitude = 14.0047453 if interview_ID == "b5a39bbe-530d-459d-8f76-bcef1cb865f7"
replace GPSlatitude = 14.0047453 if interview_ID == "e30ad39d-2716-470f-bec7-0a11204f1057"
replace GPSlatitude = 14.0047453 if interview_ID == "f4812f80-450b-4c0d-86ed-a21356e88b61"
replace GPSlatitude = 14.0047453 if interview_ID == "f544bee7-8108-4fab-8117-a6e21c17414d"
replace GPSlatitude = 14.3156135 if interview_ID == "257b9f02-7c31-4218-8882-9f65210f06cb"
replace GPSlatitude = 14.3156135 if interview_ID == "2b29acbf-80bc-4fa5-acba-ad4a1d8116fb"
replace GPSlatitude = 14.3156135 if interview_ID == "3da903f2-a9a6-450f-925d-4a72126b82ec"
replace GPSlatitude = 14.3156135 if interview_ID == "42e879ae-62f9-492b-a5d6-578934def43e"
replace GPSlatitude = 14.3156135 if interview_ID == "55d0fe44-60e0-4459-a3e5-9ee099e06adc"
replace GPSlatitude = 14.3156135 if interview_ID == "7ea07b27-b812-4a7b-b376-0eee6a7574be"
replace GPSlatitude = 14.3156135 if interview_ID == "d20561fa-0589-4bdf-a7bc-0da0993a5fb2"
replace GPSlatitude = 14.3156135 if interview_ID == "f03948d5-6cce-4aba-8ec1-28efe2cfa731"
replace GPSlatitude = 13.9810722 if interview_ID == "027a196d-7043-4bb4-aa5e-7fcd32e46d91"
replace GPSlatitude = 13.9810722 if interview_ID == "0468f33f-6deb-4f5b-a8b0-6173cc6375d0"
replace GPSlatitude = 13.9810722 if interview_ID == "0c2f0b83-c323-4807-8aef-1f676bbf5342"
replace GPSlatitude = 13.9810722 if interview_ID == "214a47ef-bda4-4406-8162-1441839f2282"
replace GPSlatitude = 13.9810722 if interview_ID == "2a147b0d-9d07-4312-a54a-f9c531ba3433"
replace GPSlatitude = 13.9810722 if interview_ID == "31b9953f-f435-48cd-841a-5b23e7c02c29"
replace GPSlatitude = 13.9810722 if interview_ID == "42b9c7aa-3992-432d-bcc5-da6c7e61e922"
replace GPSlatitude = 13.9810722 if interview_ID == "5467272d-891a-4429-a1d9-81f3f54dedcc"
replace GPSlatitude = 13.9810722 if interview_ID == "676c57a7-0ab1-47bd-b148-cb98cc3fe508"
replace GPSlatitude = 13.9810722 if interview_ID == "7c0deefb-5d0a-49fe-8f7b-8b7b10441830"
replace GPSlatitude = 13.9810722 if interview_ID == "8b390415-7b64-43e1-9ee1-e67e697b8363"
replace GPSlatitude = 13.9810722 if interview_ID == "8d0cbea6-4af1-45b9-a603-9215ed301f8f"
replace GPSlatitude = 13.9810722 if interview_ID == "a4907a68-5ba2-4dc6-bce2-ebf6e4e88eaa"
replace GPSlatitude = 13.9810722 if interview_ID == "cce2f8bf-5812-4f13-8b91-0306a5f35ba4"
replace GPSlatitude = 13.9810722 if interview_ID == "cddfd414-b91c-42e3-9ab0-ec31e4e188be"
replace GPSlatitude = 13.9810722 if interview_ID == "d97e54e2-c177-4fbe-b56a-1b000953b2bf"
replace GPSlatitude = 13.9810722 if interview_ID == "e586a214-c95c-4fa2-bd8f-e5d84cf228fc"
replace GPSlatitude = 13.9810722 if interview_ID == "f150a531-b15c-4005-b834-e731c40e5fa3"
replace GPSlatitude = 14.3354794 if interview_ID == "47ad1902-b5eb-4e37-bd3c-bf63d1415e8b"

*GPS_Longitude
replace GPSlongitude = -15.4849889 if interview_ID == "08b9b550-4288-456e-8452-10720aed8fa4"
replace GPSlongitude = -15.4849889 if interview_ID == "0a5c5a50-0377-4a19-aa32-f63a81416f01"
replace GPSlongitude = -15.4849889 if interview_ID == "19e98665-e383-4cc7-8391-05fffe810a53"
replace GPSlongitude = -15.4849889 if interview_ID == "32c49089-74ee-45b7-9679-59f048b79e51"
replace GPSlongitude = -15.4850976 if interview_ID == "774b3968-d03d-4177-bba0-612bb98722b7"
replace GPSlongitude = -15.4850976 if interview_ID == "7895b14d-fcb2-45d4-b877-8b48e14e4457"
replace GPSlongitude = -15.4850976 if interview_ID == "7943994d-ee2d-4c6b-9bd9-4d8950008f94"
replace GPSlongitude = -15.4850797 if interview_ID == "a44445f0-b02d-4376-9985-6440a6a54352"
replace GPSlongitude = -15.4850797 if interview_ID == "b3d2bace-76f2-4c37-8dae-bd6d50d38057"
replace GPSlongitude = -15.4850797 if interview_ID == "c36a9870-8acb-41cb-b989-78b7f52753a9"
replace GPSlongitude = -15.4850797 if interview_ID == "c860a452-4dca-422b-927b-af6f89153562"
replace GPSlongitude = -15.4850797 if interview_ID == "db517ef9-86bd-4b52-843b-79db6f9148a9"
replace GPSlongitude = -15.4850797 if interview_ID == "ff7bcb16-4d87-4766-8924-fb161da2e83e"
replace GPSlongitude = -16.3985271 if interview_ID == "8466ba38-fcc1-43ca-a8e9-05b223e5cd2b"
replace GPSlongitude = -15.4708586 if interview_ID == "06ab165a-d11f-448a-a479-159b3d8a2b93"
replace GPSlongitude = -15.4708586 if interview_ID == "7e41401a-2629-47d3-989b-331096ec30d2"
replace GPSlongitude = -15.4708586 if interview_ID == "cbb99d8f-f08c-4dc8-b5b1-7ed736cd9ffa"
replace GPSlongitude = -15.4708586 if interview_ID == "d2c71a15-324b-4908-880c-cd2a37b9ae46"
replace GPSlongitude = -14.8697248 if interview_ID == "944d2c75-b555-4afa-9810-cf7ea22efa1e"
replace GPSlongitude = -14.8697248 if interview_ID == "f097c3dd-5bb0-4c01-b993-62eca8d58e16"
replace GPSlongitude = -15.7544979 if interview_ID == "350b15fa-d5f7-44dd-b687-23b3042918e3"
replace GPSlongitude = -15.7544979 if interview_ID == "50ea4e94-ef69-4780-85c1-b54a57dce063"
replace GPSlongitude = -15.7544979 if interview_ID == "8aa09fba-4da6-49e4-ac56-e6aefbb9b367"
replace GPSlongitude = -15.7544979 if interview_ID == "9512b111-ff69-4336-8725-f338f37b6ef5"
replace GPSlongitude = -15.7544979 if interview_ID == "9879793b-d763-465b-a8f3-0a0fc17b978f"
replace GPSlongitude = -15.7544979 if interview_ID == "e56b2fd1-6f0d-459a-a095-d880376a2a19"
replace GPSlongitude = -15.7544979 if interview_ID == "fdcd7834-8d95-4012-94a7-4b698a0de52f"
replace GPSlongitude = -16.2911434 if interview_ID == "32e300eb-252c-4f93-8789-c63654ab68ac"
replace GPSlongitude = -16.2911434 if interview_ID == "a208d649-13cf-4550-b8ac-1aa4794fd03c"
replace GPSlongitude = -16.2911434 if interview_ID == "ae7b675e-ca64-4f3a-96f1-0a95a68acee7"
replace GPSlongitude = -16.2911434 if interview_ID == "b5f00748-476c-4f6a-b9a6-79d45036aa96"
replace GPSlongitude = -15.5764183 if interview_ID == "08862b10-8ada-4b77-8c7d-67992f7fd886"
replace GPSlongitude = -15.5764183 if interview_ID == "88cacd4e-afbc-404d-aa61-6fa3fe4db9d2"
replace GPSlongitude = -15.5764183 if interview_ID == "94c65d85-4fea-46f2-a855-22691925252a"
replace GPSlongitude = -15.4873115 if interview_ID == "14457211-4d52-4570-ae1e-c5c75f354175"
replace GPSlongitude = -15.4873115 if interview_ID == "16f1d853-91f4-4029-9a98-3dd2ab562357"
replace GPSlongitude = -15.4873115 if interview_ID == "284166c3-ffda-436a-9335-d4f2e1530693"
replace GPSlongitude = -15.4873115 if interview_ID == "569e513e-88a5-4a78-9eae-339ee0fa17f2"
replace GPSlongitude = -15.4873115 if interview_ID == "75886d6f-abcc-466f-b3ae-82a162a946ac"
replace GPSlongitude = -15.4873115 if interview_ID == "9dcb0660-9960-4ef7-99a1-798353192be1"
replace GPSlongitude = -15.4873115 if interview_ID == "db71bf7a-bf57-4ebe-a930-7d0f359607cc"
replace GPSlongitude = -15.8028482 if interview_ID == "0022196e-5323-4a02-8fab-cd760ad8050e"
replace GPSlongitude = -15.8028482 if interview_ID == "2edb0e64-35bb-4d15-8a3a-cb2391ae5261"
replace GPSlongitude = -15.8028482 if interview_ID == "cbab8118-f56c-42ea-9492-e33f984ed12d"
replace GPSlongitude = -15.8028482 if interview_ID == "da9aae0b-7203-4a0f-af5b-285747ec8001"
replace GPSlongitude = -15.8028482 if interview_ID == "fbefabcb-1121-4581-8d69-c984c41835f3"
replace GPSlongitude = -15.407856 if interview_ID == "50e76470-2f86-4ae1-a6c3-714d27a72cda"
replace GPSlongitude = -15.407856 if interview_ID == "55458af1-cf96-42fb-8a23-9c3a0709a177"
replace GPSlongitude = -15.407856 if interview_ID == "6256b3fb-c6c8-4c33-a9bd-6e41309ea0d6"
replace GPSlongitude = -15.407856 if interview_ID == "78e94deb-38c9-425c-b647-739d3038e60b"
replace GPSlongitude = -15.407856 if interview_ID == "9ffb65da-52b0-4eca-85d1-ce56cd1f8d6a"
replace GPSlongitude = -16.300291 if interview_ID == "04188747-378a-4465-b3a2-f5a7e751ec7f"
replace GPSlongitude = -16.300291 if interview_ID == "1b198724-2c86-44b2-93d7-b84f070b7724"
replace GPSlongitude = -16.300291 if interview_ID == "cd25d754-c050-4770-a221-8f2c79b61c2d"
replace GPSlongitude = -16.300291 if interview_ID == "deca15db-3525-43b6-b3e6-56fef304dc3a"
replace GPSlongitude = -16.3303217 if interview_ID == "0438dca7-5a24-46e9-8d81-4eeebfabc1f1"
replace GPSlongitude = -16.3303217 if interview_ID == "160bbba3-76dd-42a7-b8fe-4790ff034383"
replace GPSlongitude = -16.3303217 if interview_ID == "168816b3-cba7-41fd-9766-f7c1a2fe9914"
replace GPSlongitude = -16.3303217 if interview_ID == "3d0afc37-e12c-484d-9bbb-3170215d37bb"
replace GPSlongitude = -16.3303217 if interview_ID == "43f705b7-5ffc-45d3-8bcc-c6a62810ca11"
replace GPSlongitude = -16.3303217 if interview_ID == "8b8a641c-21aa-4be0-ba2a-e8b35bd75d6f"
replace GPSlongitude = -16.3303217 if interview_ID == "99f730ab-80ba-42a5-8423-c6479973a096"
replace GPSlongitude = -16.3303217 if interview_ID == "f761942c-005b-4186-a823-907f483d9ea0"
replace GPSlongitude = -16.3303217 if interview_ID == "f8aa7dbd-41d4-431f-82d7-7d29fe8e6b8a"
replace GPSlongitude = -15.743092 if interview_ID == "70794d12-e969-47fa-834f-2878485c0e03"
replace GPSlongitude = -15.743092 if interview_ID == "72c68a36-5d76-4704-a67b-38fbf618767a"
replace GPSlongitude = -15.743092 if interview_ID == "d244a3be-86b6-4158-8d14-bd7a91863ea6"
replace GPSlongitude = -15.743092 if interview_ID == "da14f1da-21db-446a-8464-3575a346b7db"
replace GPSlongitude = -15.743092 if interview_ID == "de3b2603-110a-434f-a480-eece8ed13fa8"
replace GPSlongitude = -15.5804495 if interview_ID == "6d3906b5-2196-4cd2-86a2-fe350906db6f"
replace GPSlongitude = -15.5804495 if interview_ID == "b186bac0-cc7f-409d-853f-6e45b086c73d"
replace GPSlongitude = -15.5453995 if interview_ID == "8557f1b8-ea2a-4349-b4ae-798ca152f689"
replace GPSlongitude = -16.4707607 if interview_ID == "5d3e5dbf-5132-4f46-b027-e401fd6611f4"
replace GPSlongitude = -16.4707607 if interview_ID == "5f3c57b5-a7b6-4031-b106-64c6a4969f01"
replace GPSlongitude = -16.4707607 if interview_ID == "eeda558d-9be8-46c0-a2f7-dc543d34a5dc"
replace GPSlongitude = -16.4707607 if interview_ID == "f7f16800-2a85-442b-9f83-69ffbc18021c"
replace GPSlongitude = -15.5386679 if interview_ID == "16bfd78f-5de7-4fe9-aa6c-919d8887369c"
replace GPSlongitude = -15.5386679 if interview_ID == "3ecc7557-2ef0-4c1b-b5b2-90f37e31f222"
replace GPSlongitude = -15.5386679 if interview_ID == "4644aea1-f044-4cb4-b79a-638800249e8e"
replace GPSlongitude = -15.5386679 if interview_ID == "4a7aab47-6fa0-4d04-87dc-3a23946705b9"
replace GPSlongitude = -15.5386679 if interview_ID == "4bb9439e-83db-41e3-873d-67a4d77efc3e"
replace GPSlongitude = -15.5386679 if interview_ID == "8c2ecbf2-9074-4d91-b8e7-2a7ef846751f"
replace GPSlongitude = -15.5348432 if interview_ID == "fb9c234b-de3a-40b1-877d-e0774134e95a"
replace GPSlongitude = -15.5348432 if interview_ID == "09ddc276-9010-4c57-89c7-69894da59702"
replace GPSlongitude = -15.5348432 if interview_ID == "11e9e8f6-b131-4016-95ce-938c2c1cb711"
replace GPSlongitude = -15.5348432 if interview_ID == "16c3c3a6-3b32-4a80-877a-98f8bfcf3c43"
replace GPSlongitude = -15.5348432 if interview_ID == "2d28c81c-4180-4486-b04b-656cfd91dd55"
replace GPSlongitude = -15.5348432 if interview_ID == "3cac5927-3590-4ae1-bf72-3e52afe1eb6e"
replace GPSlongitude = -15.5348432 if interview_ID == "c931fa81-b717-4113-8476-82b40330fed9"
replace GPSlongitude = -15.5348432 if interview_ID == "ec399d0c-8225-4b25-a76a-bb8738a2a86c"
replace GPSlongitude = -15.5407096 if interview_ID == "0a52ac27-4049-490c-933d-726e41dd2c06"
replace GPSlongitude = -15.5407096 if interview_ID == "5dcd7d8c-3f6f-49ff-98f2-d6a23c5cea8e"
replace GPSlongitude = -15.431725 if interview_ID == "0dc686f3-34c2-41e2-b736-b7193705afe1"
replace GPSlongitude = -15.431725 if interview_ID == "19d88ac1-b717-4aa5-bf1a-bfcb7a28ee70"
replace GPSlongitude = -15.431725 if interview_ID == "1e0571ed-db76-4822-8c23-8af79ce41085"
replace GPSlongitude = -15.431725 if interview_ID == "21b4c50d-0c3f-4dd4-ba0d-bc2f459da32a"
replace GPSlongitude = -15.431725 if interview_ID == "3405399b-da3f-4b77-9ef8-524e2275b7fc"
replace GPSlongitude = -15.431725 if interview_ID == "3a3ebddd-8fe5-4dd4-ba86-3d1b49e43eda"
replace GPSlongitude = -15.431725 if interview_ID == "5b31c448-ae85-4394-9e97-8ca581a63efb"
replace GPSlongitude = -15.431725 if interview_ID == "8b7ba1f8-db7f-4d59-bed7-8546b2b11c15"
replace GPSlongitude = -15.431725 if interview_ID == "a06d65c4-cb0a-4972-b670-ca3c22da4056"
replace GPSlongitude = -15.431725 if interview_ID == "adbe626c-018e-4354-8b2f-cf95068acc76"
replace GPSlongitude = -15.431725 if interview_ID == "c661d318-bc92-4a49-bdaa-82467b79d913"
replace GPSlongitude = -15.431725 if interview_ID == "c6e8cfab-7075-44b6-8ccd-621f33407259"
replace GPSlongitude = -15.431725 if interview_ID == "f2dd19b2-2c65-47ff-ade5-e46f7663a31d"
replace GPSlongitude = -15.431725 if interview_ID == "fff7f585-b9b1-4a11-9fd6-83293abead8a"
replace GPSlongitude = -15.234949 if interview_ID == "03f42024-3cf0-4b32-aa48-bcc0fe3f0418"
replace GPSlongitude = -15.234949 if interview_ID == "10e062bf-f68d-477b-94f4-118c99065e40"
replace GPSlongitude = -15.234949 if interview_ID == "730cf5db-0202-46f5-af9d-da1d9d81cfc1"
replace GPSlongitude = -15.234949 if interview_ID == "7e93b4ff-0990-4959-86f1-4260160f4368"
replace GPSlongitude = -15.234949 if interview_ID == "fe56020d-cd18-4921-b368-e94b7efec637"
replace GPSlongitude = -15.5954133 if interview_ID == "cb46dbc5-e66d-47fc-9ee3-abe3722fe14c"
replace GPSlongitude = -15.7329584 if interview_ID == "15ec73d8-4982-4c7c-b799-f78923569765"
replace GPSlongitude = -15.7329584 if interview_ID == "3c72b0ec-b5e9-4fa6-86b2-8af8462f9069"
replace GPSlongitude = -15.7329584 if interview_ID == "4a5d1807-d4ee-4b01-9acf-2ba308182a6a"
replace GPSlongitude = -15.7329584 if interview_ID == "7088cd6f-2a3b-419b-bf37-f84bfd9d3d27"
replace GPSlongitude = -15.7329584 if interview_ID == "d4d130ef-c112-4fe1-bb58-ecb4a1762194"
replace GPSlongitude = -15.7329584 if interview_ID == "e1e8ef67-fcc7-4588-abbf-b8ebf4aa692f"
replace GPSlongitude = -15.8287322 if interview_ID == "376bab4a-1491-4220-913d-7270c3aa17e3"
replace GPSlongitude = -16.32172 if interview_ID == "0dacfdcf-c0bc-4414-8746-805a0a07a1a2"
replace GPSlongitude = -16.32172 if interview_ID == "795e3e03-59cd-4798-9fd5-64b370d25d11"
replace GPSlongitude = -16.32172 if interview_ID == "c8c669af-05e3-4e8f-b574-93b5f383b47b"
replace GPSlongitude = -16.3047863 if interview_ID == "6feed385-4b3a-45f3-9ac6-665707511869"
replace GPSlongitude = -15.7229247 if interview_ID == "61baf362-d9e8-48c0-99d8-9393c58f030a"
replace GPSlongitude = -15.7229247 if interview_ID == "627d5d94-ef32-47d0-8854-cd485a60fe3a"
replace GPSlongitude = -15.7229247 if interview_ID == "9f04ec82-5b08-4646-b1cf-a21cb6a6dad1"
replace GPSlongitude = -15.7229247 if interview_ID == "bc31015f-7e11-4be9-9d4b-5121dd871cfc"
replace GPSlongitude = -15.7229247 if interview_ID == "ff70233f-5294-4948-af54-d001d5bb26d2"
replace GPSlongitude = -16.4430334 if interview_ID == "d6de487e-f26f-4f13-9f7b-fcef2714b372"
replace GPSlongitude = -15.4712389 if interview_ID == "5897e891-24c2-443e-b321-1a07632ba4ee"
replace GPSlongitude = -15.4712389 if interview_ID == "61b74894-2eca-4fb4-8918-3997b2078334"
replace GPSlongitude = -15.4712389 if interview_ID == "b443c03e-cf8d-4ef0-827f-5de2bfb3c9ab"
replace GPSlongitude = -15.4712389 if interview_ID == "e5a05424-50b0-4bc5-b06e-6d3781281e96"
replace GPSlongitude = -16.4120623 if interview_ID == "00c10308-94b5-4ff2-b8f1-62e4b3da6fc9"
replace GPSlongitude = -16.4120623 if interview_ID == "01e6708e-e1a1-4f8f-be47-ba8cf8932f80"
replace GPSlongitude = -16.4120623 if interview_ID == "21ca6b22-982b-42ee-9a8b-0433992b4957"
replace GPSlongitude = -16.4120623 if interview_ID == "28cb40eb-9823-4220-b231-105c1766536b"
replace GPSlongitude = -16.4120623 if interview_ID == "323a4ac0-bfae-457e-a1eb-9c79ebc01032"
replace GPSlongitude = -16.4120623 if interview_ID == "5e6f524d-a2c1-451d-9433-a95872ac1f04"
replace GPSlongitude = -16.4120623 if interview_ID == "9aa67971-8b63-4b28-ae38-cef4a73120b1"
replace GPSlongitude = -16.4120623 if interview_ID == "a05bcfff-d5de-49bf-9bda-62c70e00c12d"
replace GPSlongitude = -16.4120623 if interview_ID == "b7d4715c-881a-4376-a317-e216e5849218"
replace GPSlongitude = -16.4120623 if interview_ID == "be8de64f-a46a-4600-bf17-6c49b1e0b83f"
replace GPSlongitude = -16.4120623 if interview_ID == "c08b2a86-f297-4bb2-8928-040daf48e0c6"
replace GPSlongitude = -16.4120623 if interview_ID == "c0a046c5-c100-41fa-b8a0-14042c216feb"
replace GPSlongitude = -16.4120623 if interview_ID == "cc915cfd-626a-4f61-b79d-e34a81182e05"
replace GPSlongitude = -16.4120623 if interview_ID == "cd8a4ad5-eccd-4578-8f9b-302fcb23ff6e"
replace GPSlongitude = -16.4120623 if interview_ID == "d4dd5010-da84-4f51-b226-36c2d99539e7"
replace GPSlongitude = -16.529491 if interview_ID == "049a7f55-fcfc-4714-824b-77181feab726"
replace GPSlongitude = -16.529491 if interview_ID == "53be1fdd-afbb-4840-9e52-599d193d005b"
replace GPSlongitude = -16.529491 if interview_ID == "679b860d-e557-4ed0-ad12-0b30ee045491"
replace GPSlongitude = -16.529491 if interview_ID == "88094c2c-03c5-40de-a5fd-bc20592ae4f2"
replace GPSlongitude = -16.529491 if interview_ID == "b692ec7f-c10a-48f3-990c-dffef2cbf687"
replace GPSlongitude = -16.529491 if interview_ID == "e621c03b-a58f-4e41-8d76-1b625301b331"
replace GPSlongitude = -15.6102835 if interview_ID == "0091564e-8b08-4d6e-ad40-4227de59f98f"
replace GPSlongitude = -15.6102835 if interview_ID == "26744dbe-3bff-49d4-9365-f17807d03196"
replace GPSlongitude = -15.6102835 if interview_ID == "651b4701-8b4a-48f7-a33c-8df23833864f"
replace GPSlongitude = -15.6102835 if interview_ID == "8d04d63a-0463-485e-8c65-4f5dde22c672"
replace GPSlongitude = -15.6102835 if interview_ID == "c8020d00-ebb2-4897-af8c-f3130dfdd071"
replace GPSlongitude = -15.6102835 if interview_ID == "d3cd1046-41d5-4f22-b03b-43a27f2afd64"
replace GPSlongitude = -15.6102835 if interview_ID == "de77bc7d-b8e0-4dad-9374-0fd5286bb74b"
replace GPSlongitude = -15.8364498 if interview_ID == "e436d9e7-f025-4417-8a92-f207c12b80e6"
replace GPSlongitude = -15.4637681 if interview_ID == "0fa6f447-1765-441c-bec8-488ba19c6d57"
replace GPSlongitude = -15.4637681 if interview_ID == "5639a53d-d823-49c6-9c60-20daa7cd9038"
replace GPSlongitude = -15.4637681 if interview_ID == "7467ffd5-3823-48ad-af1b-2dbf89e5b889"
replace GPSlongitude = -15.4637681 if interview_ID == "885cefd5-bd54-453f-b27a-3dd909fb3e51"
replace GPSlongitude = -15.4637681 if interview_ID == "97ff7b85-efa8-4924-8a09-2ee4ebe61ef6"
replace GPSlongitude = -15.4637681 if interview_ID == "accab29a-0a0f-43b0-971e-39a0935bae0b"
replace GPSlongitude = -15.4637681 if interview_ID == "d2e4d460-7652-4152-adb3-1cb0be59410f"
replace GPSlongitude = -16.4113213 if interview_ID == "aa63a8b7-09b8-4701-8f98-c778489a821c"
replace GPSlongitude = -14.4754742 if interview_ID == "18b59846-d0da-43c8-bf00-c7e71ddbcca2"
replace GPSlongitude = -14.4754742 if interview_ID == "52d26817-da8d-4f36-b5ee-ac63a0025143"
replace GPSlongitude = -14.4754742 if interview_ID == "79fc83f4-9851-4bb0-8840-6a77f025e0fe"
replace GPSlongitude = -16.5364367 if interview_ID == "4b25375a-5936-4fd0-836c-3178f0ddbe24"
replace GPSlongitude = -16.5364367 if interview_ID == "76660ce7-b5c0-4ca6-a1a0-32b15c9abde0"
replace GPSlongitude = -16.5364367 if interview_ID == "85a72bca-d923-44f5-98ef-9c06f00367ce"
replace GPSlongitude = -16.5364367 if interview_ID == "9f1d2b4f-fc36-45df-a6d4-9967dab6bcbe"
replace GPSlongitude = -16.4117287 if interview_ID == "83fd6d81-63d3-4a86-9e32-76247f9abb4f"
replace GPSlongitude = -16.4117287 if interview_ID == "9434bb7a-35ff-4ba0-8ccb-a3757c95002c"
replace GPSlongitude = -16.4117287 if interview_ID == "f20e594c-20ce-4190-b9e3-a70551d61cbe"
replace GPSlongitude = -16.4117287 if interview_ID == "f5455c5c-e5e2-40af-9d3b-ab4f16f57144"
replace GPSlongitude = -16.3625677 if interview_ID == "57e40005-7add-4dd2-bb9d-5759c2981aa1"
replace GPSlongitude = -16.3625677 if interview_ID == "840d9ee5-ca5a-43f6-a855-9257880755da"
replace GPSlongitude = -15.7450745 if interview_ID == "21a66f3a-bc71-463e-9eb7-16237de98482"
replace GPSlongitude = -15.7450745 if interview_ID == "834f3169-e6d2-4ebc-aebd-a90b1f7d26ba"
replace GPSlongitude = -15.486272 if interview_ID == "0c3af58d-b82b-4712-aa60-e65eddbb6539"
replace GPSlongitude = -15.486272 if interview_ID == "2682570a-c0cb-433d-952f-87fc71639c5f"
replace GPSlongitude = -15.486272 if interview_ID == "3b1ebb7d-9a19-46b6-a0fe-85c277d343d9"
replace GPSlongitude = -15.486272 if interview_ID == "61858bf5-4529-4ce4-9132-8974caf9c80c"
replace GPSlongitude = -15.486272 if interview_ID == "63e07917-b3a6-4475-a3bb-8e027b3dc813"
replace GPSlongitude = -15.486272 if interview_ID == "c8ff5326-e9dd-4955-94ef-52e0164bd216"
replace GPSlongitude = -15.486272 if interview_ID == "ca2cc16f-af4a-4832-b6c4-d28f16bfb1e3"
replace GPSlongitude = -16.4775989 if interview_ID == "e89aecb6-f480-4786-831c-65f3b0237601"
replace GPSlongitude = -15.2972037 if interview_ID == "c8d5fd89-1a74-4a69-a0dd-c8e1563427d8"
replace GPSlongitude = -16.4784071 if interview_ID == "04d1d201-dfd2-4a7b-9a58-8902ce9ee60a"
replace GPSlongitude = -16.4784071 if interview_ID == "1d852e1b-7029-450f-937e-09975a21638b"
replace GPSlongitude = -16.4784071 if interview_ID == "2893993b-f640-47c6-9b06-28fb00386987"
replace GPSlongitude = -16.4784071 if interview_ID == "903bd68a-d26b-491a-94c2-0cf91418cf6d"
replace GPSlongitude = -16.4784071 if interview_ID == "c3b4ea71-c3bc-424a-aa3d-a97c73caf437"
replace GPSlongitude = -15.5322463 if interview_ID == "122a3775-ade1-4606-a980-f7066fb2cf1c"
replace GPSlongitude = -15.5322463 if interview_ID == "71a9e35f-0f05-476e-8160-716eb8ce68bd"
replace GPSlongitude = -15.5322463 if interview_ID == "a0c27261-8682-4b7b-a9df-d58142ec58bb"
replace GPSlongitude = -15.5322463 if interview_ID == "a7ee66c5-6ca3-4270-943e-8d97534e409e"
replace GPSlongitude = -15.5322463 if interview_ID == "a96ba806-ab05-4313-8f91-5d695422c339"
replace GPSlongitude = -15.5322463 if interview_ID == "c8f06068-cfe7-4ecc-96df-e7b3a1e03ff9"
replace GPSlongitude = -15.5595801 if interview_ID == "2e1d1197-4bb8-43ee-8ec6-43c71f5fc1af"
replace GPSlongitude = -15.5595801 if interview_ID == "70692290-12f9-4600-8e8b-161b8d6b6dd8"
replace GPSlongitude = -15.5595801 if interview_ID == "74a5d05b-d0ef-46ff-a1f8-ef76b03464ce"
replace GPSlongitude = -15.6298494 if interview_ID == "9ee1d44a-3aac-4528-88d6-e2382ae3e55e"
replace GPSlongitude = -15.6298494 if interview_ID == "aa705510-01bc-4030-81ae-ba6279c3d234"
replace GPSlongitude = -15.6298494 if interview_ID == "b5a39bbe-530d-459d-8f76-bcef1cb865f7"
replace GPSlongitude = -15.6298494 if interview_ID == "e30ad39d-2716-470f-bec7-0a11204f1057"
replace GPSlongitude = -15.6298494 if interview_ID == "f4812f80-450b-4c0d-86ed-a21356e88b61"
replace GPSlongitude = -15.6298494 if interview_ID == "f544bee7-8108-4fab-8117-a6e21c17414d"
replace GPSlongitude = -15.5216209 if interview_ID == "257b9f02-7c31-4218-8882-9f65210f06cb"
replace GPSlongitude = -15.5216209 if interview_ID == "2b29acbf-80bc-4fa5-acba-ad4a1d8116fb"
replace GPSlongitude = -15.5216209 if interview_ID == "3da903f2-a9a6-450f-925d-4a72126b82ec"
replace GPSlongitude = -15.5216209 if interview_ID == "42e879ae-62f9-492b-a5d6-578934def43e"
replace GPSlongitude = -15.5216209 if interview_ID == "55d0fe44-60e0-4459-a3e5-9ee099e06adc"
replace GPSlongitude = -15.5216209 if interview_ID == "7ea07b27-b812-4a7b-b376-0eee6a7574be"
replace GPSlongitude = -15.5216209 if interview_ID == "d20561fa-0589-4bdf-a7bc-0da0993a5fb2"
replace GPSlongitude = -15.5216209 if interview_ID == "f03948d5-6cce-4aba-8ec1-28efe2cfa731"
replace GPSlongitude = -16.2278528 if interview_ID == "027a196d-7043-4bb4-aa5e-7fcd32e46d91"
replace GPSlongitude = -16.2278528 if interview_ID == "0468f33f-6deb-4f5b-a8b0-6173cc6375d0"
replace GPSlongitude = -16.2278528 if interview_ID == "0c2f0b83-c323-4807-8aef-1f676bbf5342"
replace GPSlongitude = -16.2278528 if interview_ID == "214a47ef-bda4-4406-8162-1441839f2282"
replace GPSlongitude = -16.2278528 if interview_ID == "2a147b0d-9d07-4312-a54a-f9c531ba3433"
replace GPSlongitude = -16.2278528 if interview_ID == "31b9953f-f435-48cd-841a-5b23e7c02c29"
replace GPSlongitude = -16.2278528 if interview_ID == "42b9c7aa-3992-432d-bcc5-da6c7e61e922"
replace GPSlongitude = -16.2278528 if interview_ID == "5467272d-891a-4429-a1d9-81f3f54dedcc"
replace GPSlongitude = -16.2278528 if interview_ID == "676c57a7-0ab1-47bd-b148-cb98cc3fe508"
replace GPSlongitude = -16.2278528 if interview_ID == "7c0deefb-5d0a-49fe-8f7b-8b7b10441830"
replace GPSlongitude = -16.2278528 if interview_ID == "8b390415-7b64-43e1-9ee1-e67e697b8363"
replace GPSlongitude = -16.2278528 if interview_ID == "8d0cbea6-4af1-45b9-a603-9215ed301f8f"
replace GPSlongitude = -16.2278528 if interview_ID == "a4907a68-5ba2-4dc6-bce2-ebf6e4e88eaa"
replace GPSlongitude = -16.2278528 if interview_ID == "cce2f8bf-5812-4f13-8b91-0306a5f35ba4"
replace GPSlongitude = -16.2278528 if interview_ID == "cddfd414-b91c-42e3-9ab0-ec31e4e188be"
replace GPSlongitude = -16.2278528 if interview_ID == "d97e54e2-c177-4fbe-b56a-1b000953b2bf"
replace GPSlongitude = -16.2278528 if interview_ID == "e586a214-c95c-4fa2-bd8f-e5d84cf228fc"
replace GPSlongitude = -16.2278528 if interview_ID == "f150a531-b15c-4005-b834-e731c40e5fa3"
replace GPSlongitude = -16.3002534 if interview_ID == "47ad1902-b5eb-4e37-bd3c-bf63d1415e8b"

*GPS_Accuracy
replace GPSaccuracy = 9.23900032 if interview_ID == "08b9b550-4288-456e-8452-10720aed8fa4"
replace GPSaccuracy = 9.23900032 if interview_ID == "0a5c5a50-0377-4a19-aa32-f63a81416f01"
replace GPSaccuracy = 9.23900032 if interview_ID == "19e98665-e383-4cc7-8391-05fffe810a53"
replace GPSaccuracy = 9.23900032 if interview_ID == "32c49089-74ee-45b7-9679-59f048b79e51"
replace GPSaccuracy = 2.099999905 if interview_ID == "774b3968-d03d-4177-bba0-612bb98722b7"
replace GPSaccuracy = 2.099999905 if interview_ID == "7895b14d-fcb2-45d4-b877-8b48e14e4457"
replace GPSaccuracy = 2.099999905 if interview_ID == "7943994d-ee2d-4c6b-9bd9-4d8950008f94"
replace GPSaccuracy = 5810.591797 if interview_ID == "a44445f0-b02d-4376-9985-6440a6a54352"
replace GPSaccuracy = 5810.591797 if interview_ID == "b3d2bace-76f2-4c37-8dae-bd6d50d38057"
replace GPSaccuracy = 5810.591797 if interview_ID == "c36a9870-8acb-41cb-b989-78b7f52753a9"
replace GPSaccuracy = 5810.591797 if interview_ID == "c860a452-4dca-422b-927b-af6f89153562"
replace GPSaccuracy = 5810.591797 if interview_ID == "db517ef9-86bd-4b52-843b-79db6f9148a9"
replace GPSaccuracy = 5810.591797 if interview_ID == "ff7bcb16-4d87-4766-8924-fb161da2e83e"
replace GPSaccuracy = 3.21600008 if interview_ID == "8466ba38-fcc1-43ca-a8e9-05b223e5cd2b"
replace GPSaccuracy = 36.40399933 if interview_ID == "06ab165a-d11f-448a-a479-159b3d8a2b93"
replace GPSaccuracy = 36.40399933 if interview_ID == "7e41401a-2629-47d3-989b-331096ec30d2"
replace GPSaccuracy = 36.40399933 if interview_ID == "cbb99d8f-f08c-4dc8-b5b1-7ed736cd9ffa"
replace GPSaccuracy = 36.40399933 if interview_ID == "d2c71a15-324b-4908-880c-cd2a37b9ae46"
replace GPSaccuracy = 2099.999023 if interview_ID == "944d2c75-b555-4afa-9810-cf7ea22efa1e"
replace GPSaccuracy = 2099.999023 if interview_ID == "f097c3dd-5bb0-4c01-b993-62eca8d58e16"
replace GPSaccuracy = 7.915999889 if interview_ID == "350b15fa-d5f7-44dd-b687-23b3042918e3"
replace GPSaccuracy = 7.915999889 if interview_ID == "50ea4e94-ef69-4780-85c1-b54a57dce063"
replace GPSaccuracy = 7.915999889 if interview_ID == "8aa09fba-4da6-49e4-ac56-e6aefbb9b367"
replace GPSaccuracy = 7.915999889 if interview_ID == "9512b111-ff69-4336-8725-f338f37b6ef5"
replace GPSaccuracy = 7.915999889 if interview_ID == "9879793b-d763-465b-a8f3-0a0fc17b978f"
replace GPSaccuracy = 7.915999889 if interview_ID == "e56b2fd1-6f0d-459a-a095-d880376a2a19"
replace GPSaccuracy = 7.915999889 if interview_ID == "fdcd7834-8d95-4012-94a7-4b698a0de52f"
replace GPSaccuracy = 3 if interview_ID == "32e300eb-252c-4f93-8789-c63654ab68ac"
replace GPSaccuracy = 3 if interview_ID == "a208d649-13cf-4550-b8ac-1aa4794fd03c"
replace GPSaccuracy = 3 if interview_ID == "ae7b675e-ca64-4f3a-96f1-0a95a68acee7"
replace GPSaccuracy = 3 if interview_ID == "b5f00748-476c-4f6a-b9a6-79d45036aa96"
replace GPSaccuracy = 2.016000032 if interview_ID == "08862b10-8ada-4b77-8c7d-67992f7fd886"
replace GPSaccuracy = 2.016000032 if interview_ID == "88cacd4e-afbc-404d-aa61-6fa3fe4db9d2"
replace GPSaccuracy = 2.016000032 if interview_ID == "94c65d85-4fea-46f2-a855-22691925252a"
replace GPSaccuracy = 15.56200027 if interview_ID == "14457211-4d52-4570-ae1e-c5c75f354175"
replace GPSaccuracy = 15.56200027 if interview_ID == "16f1d853-91f4-4029-9a98-3dd2ab562357"
replace GPSaccuracy = 15.56200027 if interview_ID == "284166c3-ffda-436a-9335-d4f2e1530693"
replace GPSaccuracy = 15.56200027 if interview_ID == "569e513e-88a5-4a78-9eae-339ee0fa17f2"
replace GPSaccuracy = 15.56200027 if interview_ID == "75886d6f-abcc-466f-b3ae-82a162a946ac"
replace GPSaccuracy = 15.56200027 if interview_ID == "9dcb0660-9960-4ef7-99a1-798353192be1"
replace GPSaccuracy = 15.56200027 if interview_ID == "db71bf7a-bf57-4ebe-a930-7d0f359607cc"
replace GPSaccuracy = 9.647999763 if interview_ID == "0022196e-5323-4a02-8fab-cd760ad8050e"
replace GPSaccuracy = 9.647999763 if interview_ID == "2edb0e64-35bb-4d15-8a3a-cb2391ae5261"
replace GPSaccuracy = 9.647999763 if interview_ID == "cbab8118-f56c-42ea-9492-e33f984ed12d"
replace GPSaccuracy = 9.647999763 if interview_ID == "da9aae0b-7203-4a0f-af5b-285747ec8001"
replace GPSaccuracy = 9.647999763 if interview_ID == "fbefabcb-1121-4581-8d69-c984c41835f3"
replace GPSaccuracy = 5.5 if interview_ID == "50e76470-2f86-4ae1-a6c3-714d27a72cda"
replace GPSaccuracy = 5.5 if interview_ID == "55458af1-cf96-42fb-8a23-9c3a0709a177"
replace GPSaccuracy = 5.5 if interview_ID == "6256b3fb-c6c8-4c33-a9bd-6e41309ea0d6"
replace GPSaccuracy = 5.5 if interview_ID == "78e94deb-38c9-425c-b647-739d3038e60b"
replace GPSaccuracy = 5.5 if interview_ID == "9ffb65da-52b0-4eca-85d1-ce56cd1f8d6a"
replace GPSaccuracy = 5.099999905 if interview_ID == "04188747-378a-4465-b3a2-f5a7e751ec7f"
replace GPSaccuracy = 5.099999905 if interview_ID == "1b198724-2c86-44b2-93d7-b84f070b7724"
replace GPSaccuracy = 5.099999905 if interview_ID == "cd25d754-c050-4770-a221-8f2c79b61c2d"
replace GPSaccuracy = 5.099999905 if interview_ID == "deca15db-3525-43b6-b3e6-56fef304dc3a"
replace GPSaccuracy = 1.519000053 if interview_ID == "0438dca7-5a24-46e9-8d81-4eeebfabc1f1"
replace GPSaccuracy = 1.519000053 if interview_ID == "160bbba3-76dd-42a7-b8fe-4790ff034383"
replace GPSaccuracy = 1.519000053 if interview_ID == "168816b3-cba7-41fd-9766-f7c1a2fe9914"
replace GPSaccuracy = 1.519000053 if interview_ID == "3d0afc37-e12c-484d-9bbb-3170215d37bb"
replace GPSaccuracy = 1.519000053 if interview_ID == "43f705b7-5ffc-45d3-8bcc-c6a62810ca11"
replace GPSaccuracy = 1.519000053 if interview_ID == "8b8a641c-21aa-4be0-ba2a-e8b35bd75d6f"
replace GPSaccuracy = 1.519000053 if interview_ID == "99f730ab-80ba-42a5-8423-c6479973a096"
replace GPSaccuracy = 1.519000053 if interview_ID == "f761942c-005b-4186-a823-907f483d9ea0"
replace GPSaccuracy = 1.519000053 if interview_ID == "f8aa7dbd-41d4-431f-82d7-7d29fe8e6b8a"
replace GPSaccuracy = 3.21600008 if interview_ID == "70794d12-e969-47fa-834f-2878485c0e03"
replace GPSaccuracy = 3.21600008 if interview_ID == "72c68a36-5d76-4704-a67b-38fbf618767a"
replace GPSaccuracy = 3.21600008 if interview_ID == "d244a3be-86b6-4158-8d14-bd7a91863ea6"
replace GPSaccuracy = 3.21600008 if interview_ID == "da14f1da-21db-446a-8464-3575a346b7db"
replace GPSaccuracy = 3.21600008 if interview_ID == "de3b2603-110a-434f-a480-eece8ed13fa8"
replace GPSaccuracy = 1.666000009 if interview_ID == "6d3906b5-2196-4cd2-86a2-fe350906db6f"
replace GPSaccuracy = 1.666000009 if interview_ID == "b186bac0-cc7f-409d-853f-6e45b086c73d"
replace GPSaccuracy = 2.099999905 if interview_ID == "8557f1b8-ea2a-4349-b4ae-798ca152f689"
replace GPSaccuracy = 5.106999874 if interview_ID == "5d3e5dbf-5132-4f46-b027-e401fd6611f4"
replace GPSaccuracy = 5.106999874 if interview_ID == "5f3c57b5-a7b6-4031-b106-64c6a4969f01"
replace GPSaccuracy = 5.106999874 if interview_ID == "eeda558d-9be8-46c0-a2f7-dc543d34a5dc"
replace GPSaccuracy = 5.106999874 if interview_ID == "f7f16800-2a85-442b-9f83-69ffbc18021c"
replace GPSaccuracy = 2.700000048 if interview_ID == "16bfd78f-5de7-4fe9-aa6c-919d8887369c"
replace GPSaccuracy = 2.700000048 if interview_ID == "3ecc7557-2ef0-4c1b-b5b2-90f37e31f222"
replace GPSaccuracy = 2.700000048 if interview_ID == "4644aea1-f044-4cb4-b79a-638800249e8e"
replace GPSaccuracy = 2.700000048 if interview_ID == "4a7aab47-6fa0-4d04-87dc-3a23946705b9"
replace GPSaccuracy = 2.700000048 if interview_ID == "4bb9439e-83db-41e3-873d-67a4d77efc3e"
replace GPSaccuracy = 2.700000048 if interview_ID == "8c2ecbf2-9074-4d91-b8e7-2a7ef846751f"
replace GPSaccuracy = 3.21600008 if interview_ID == "fb9c234b-de3a-40b1-877d-e0774134e95a"
replace GPSaccuracy = 3.21600008 if interview_ID == "09ddc276-9010-4c57-89c7-69894da59702"
replace GPSaccuracy = 3.21600008 if interview_ID == "11e9e8f6-b131-4016-95ce-938c2c1cb711"
replace GPSaccuracy = 3.21600008 if interview_ID == "16c3c3a6-3b32-4a80-877a-98f8bfcf3c43"
replace GPSaccuracy = 3.21600008 if interview_ID == "2d28c81c-4180-4486-b04b-656cfd91dd55"
replace GPSaccuracy = 3.21600008 if interview_ID == "3cac5927-3590-4ae1-bf72-3e52afe1eb6e"
replace GPSaccuracy = 3.21600008 if interview_ID == "c931fa81-b717-4113-8476-82b40330fed9"
replace GPSaccuracy = 3.21600008 if interview_ID == "ec399d0c-8225-4b25-a76a-bb8738a2a86c"
replace GPSaccuracy = 3.21600008 if interview_ID == "0a52ac27-4049-490c-933d-726e41dd2c06"
replace GPSaccuracy = 3.21600008 if interview_ID == "5dcd7d8c-3f6f-49ff-98f2-d6a23c5cea8e"
replace GPSaccuracy = 2.007999897 if interview_ID == "0dc686f3-34c2-41e2-b736-b7193705afe1"
replace GPSaccuracy = 2.007999897 if interview_ID == "19d88ac1-b717-4aa5-bf1a-bfcb7a28ee70"
replace GPSaccuracy = 2.007999897 if interview_ID == "1e0571ed-db76-4822-8c23-8af79ce41085"
replace GPSaccuracy = 2.007999897 if interview_ID == "21b4c50d-0c3f-4dd4-ba0d-bc2f459da32a"
replace GPSaccuracy = 2.007999897 if interview_ID == "3405399b-da3f-4b77-9ef8-524e2275b7fc"
replace GPSaccuracy = 2.007999897 if interview_ID == "3a3ebddd-8fe5-4dd4-ba86-3d1b49e43eda"
replace GPSaccuracy = 2.007999897 if interview_ID == "5b31c448-ae85-4394-9e97-8ca581a63efb"
replace GPSaccuracy = 2.007999897 if interview_ID == "8b7ba1f8-db7f-4d59-bed7-8546b2b11c15"
replace GPSaccuracy = 2.007999897 if interview_ID == "a06d65c4-cb0a-4972-b670-ca3c22da4056"
replace GPSaccuracy = 2.007999897 if interview_ID == "adbe626c-018e-4354-8b2f-cf95068acc76"
replace GPSaccuracy = 2.007999897 if interview_ID == "c661d318-bc92-4a49-bdaa-82467b79d913"
replace GPSaccuracy = 2.007999897 if interview_ID == "c6e8cfab-7075-44b6-8ccd-621f33407259"
replace GPSaccuracy = 2.007999897 if interview_ID == "f2dd19b2-2c65-47ff-ade5-e46f7663a31d"
replace GPSaccuracy = 2.007999897 if interview_ID == "fff7f585-b9b1-4a11-9fd6-83293abead8a"
replace GPSaccuracy = 3.21600008 if interview_ID == "03f42024-3cf0-4b32-aa48-bcc0fe3f0418"
replace GPSaccuracy = 3.21600008 if interview_ID == "10e062bf-f68d-477b-94f4-118c99065e40"
replace GPSaccuracy = 3.21600008 if interview_ID == "730cf5db-0202-46f5-af9d-da1d9d81cfc1"
replace GPSaccuracy = 3.21600008 if interview_ID == "7e93b4ff-0990-4959-86f1-4260160f4368"
replace GPSaccuracy = 3.21600008 if interview_ID == "fe56020d-cd18-4921-b368-e94b7efec637"
replace GPSaccuracy = 4.699999809 if interview_ID == "cb46dbc5-e66d-47fc-9ee3-abe3722fe14c"
replace GPSaccuracy = 3.21600008 if interview_ID == "15ec73d8-4982-4c7c-b799-f78923569765"
replace GPSaccuracy = 3.21600008 if interview_ID == "3c72b0ec-b5e9-4fa6-86b2-8af8462f9069"
replace GPSaccuracy = 3.21600008 if interview_ID == "4a5d1807-d4ee-4b01-9acf-2ba308182a6a"
replace GPSaccuracy = 3.21600008 if interview_ID == "7088cd6f-2a3b-419b-bf37-f84bfd9d3d27"
replace GPSaccuracy = 3.21600008 if interview_ID == "d4d130ef-c112-4fe1-bb58-ecb4a1762194"
replace GPSaccuracy = 3.21600008 if interview_ID == "e1e8ef67-fcc7-4588-abbf-b8ebf4aa692f"
replace GPSaccuracy = 4.21600008 if interview_ID == "376bab4a-1491-4220-913d-7270c3aa17e3"
replace GPSaccuracy = 15 if interview_ID == "0dacfdcf-c0bc-4414-8746-805a0a07a1a2"
replace GPSaccuracy = 15 if interview_ID == "795e3e03-59cd-4798-9fd5-64b370d25d11"
replace GPSaccuracy = 15 if interview_ID == "c8c669af-05e3-4e8f-b574-93b5f383b47b"
replace GPSaccuracy = 11 if interview_ID == "6feed385-4b3a-45f3-9ac6-665707511869"
replace GPSaccuracy = 3.21600008 if interview_ID == "61baf362-d9e8-48c0-99d8-9393c58f030a"
replace GPSaccuracy = 3.21600008 if interview_ID == "627d5d94-ef32-47d0-8854-cd485a60fe3a"
replace GPSaccuracy = 3.21600008 if interview_ID == "9f04ec82-5b08-4646-b1cf-a21cb6a6dad1"
replace GPSaccuracy = 3.21600008 if interview_ID == "bc31015f-7e11-4be9-9d4b-5121dd871cfc"
replace GPSaccuracy = 3.21600008 if interview_ID == "ff70233f-5294-4948-af54-d001d5bb26d2"
replace GPSaccuracy = 15 if interview_ID == "d6de487e-f26f-4f13-9f7b-fcef2714b372"
replace GPSaccuracy = 3.21600008 if interview_ID == "5897e891-24c2-443e-b321-1a07632ba4ee"
replace GPSaccuracy = 3.21600008 if interview_ID == "61b74894-2eca-4fb4-8918-3997b2078334"
replace GPSaccuracy = 3.21600008 if interview_ID == "b443c03e-cf8d-4ef0-827f-5de2bfb3c9ab"
replace GPSaccuracy = 3.21600008 if interview_ID == "e5a05424-50b0-4bc5-b06e-6d3781281e96"
replace GPSaccuracy = 9 if interview_ID == "00c10308-94b5-4ff2-b8f1-62e4b3da6fc9"
replace GPSaccuracy = 9 if interview_ID == "01e6708e-e1a1-4f8f-be47-ba8cf8932f80"
replace GPSaccuracy = 9 if interview_ID == "21ca6b22-982b-42ee-9a8b-0433992b4957"
replace GPSaccuracy = 9 if interview_ID == "28cb40eb-9823-4220-b231-105c1766536b"
replace GPSaccuracy = 9 if interview_ID == "323a4ac0-bfae-457e-a1eb-9c79ebc01032"
replace GPSaccuracy = 9 if interview_ID == "5e6f524d-a2c1-451d-9433-a95872ac1f04"
replace GPSaccuracy = 9 if interview_ID == "9aa67971-8b63-4b28-ae38-cef4a73120b1"
replace GPSaccuracy = 9 if interview_ID == "a05bcfff-d5de-49bf-9bda-62c70e00c12d"
replace GPSaccuracy = 9 if interview_ID == "b7d4715c-881a-4376-a317-e216e5849218"
replace GPSaccuracy = 9 if interview_ID == "be8de64f-a46a-4600-bf17-6c49b1e0b83f"
replace GPSaccuracy = 9 if interview_ID == "c08b2a86-f297-4bb2-8928-040daf48e0c6"
replace GPSaccuracy = 9 if interview_ID == "c0a046c5-c100-41fa-b8a0-14042c216feb"
replace GPSaccuracy = 9 if interview_ID == "cc915cfd-626a-4f61-b79d-e34a81182e05"
replace GPSaccuracy = 9 if interview_ID == "cd8a4ad5-eccd-4578-8f9b-302fcb23ff6e"
replace GPSaccuracy = 9 if interview_ID == "d4dd5010-da84-4f51-b226-36c2d99539e7"
replace GPSaccuracy = 8.878000259 if interview_ID == "049a7f55-fcfc-4714-824b-77181feab726"
replace GPSaccuracy = 8.878000259 if interview_ID == "53be1fdd-afbb-4840-9e52-599d193d005b"
replace GPSaccuracy = 8.878000259 if interview_ID == "679b860d-e557-4ed0-ad12-0b30ee045491"
replace GPSaccuracy = 8.878000259 if interview_ID == "88094c2c-03c5-40de-a5fd-bc20592ae4f2"
replace GPSaccuracy = 8.878000259 if interview_ID == "b692ec7f-c10a-48f3-990c-dffef2cbf687"
replace GPSaccuracy = 8.878000259 if interview_ID == "e621c03b-a58f-4e41-8d76-1b625301b331"
replace GPSaccuracy = 3.21600008 if interview_ID == "0091564e-8b08-4d6e-ad40-4227de59f98f"
replace GPSaccuracy = 3.21600008 if interview_ID == "26744dbe-3bff-49d4-9365-f17807d03196"
replace GPSaccuracy = 3.21600008 if interview_ID == "651b4701-8b4a-48f7-a33c-8df23833864f"
replace GPSaccuracy = 3.21600008 if interview_ID == "8d04d63a-0463-485e-8c65-4f5dde22c672"
replace GPSaccuracy = 3.21600008 if interview_ID == "c8020d00-ebb2-4897-af8c-f3130dfdd071"
replace GPSaccuracy = 3.21600008 if interview_ID == "d3cd1046-41d5-4f22-b03b-43a27f2afd64"
replace GPSaccuracy = 3.21600008 if interview_ID == "de77bc7d-b8e0-4dad-9374-0fd5286bb74b"
replace GPSaccuracy = 2.186000109 if interview_ID == "e436d9e7-f025-4417-8a92-f207c12b80e6"
replace GPSaccuracy = 2.378999949 if interview_ID == "0fa6f447-1765-441c-bec8-488ba19c6d57"
replace GPSaccuracy = 2.378999949 if interview_ID == "5639a53d-d823-49c6-9c60-20daa7cd9038"
replace GPSaccuracy = 2.378999949 if interview_ID == "7467ffd5-3823-48ad-af1b-2dbf89e5b889"
replace GPSaccuracy = 2.378999949 if interview_ID == "885cefd5-bd54-453f-b27a-3dd909fb3e51"
replace GPSaccuracy = 2.378999949 if interview_ID == "97ff7b85-efa8-4924-8a09-2ee4ebe61ef6"
replace GPSaccuracy = 2.378999949 if interview_ID == "accab29a-0a0f-43b0-971e-39a0935bae0b"
replace GPSaccuracy = 2.378999949 if interview_ID == "d2e4d460-7652-4152-adb3-1cb0be59410f"
replace GPSaccuracy = 3.572999954 if interview_ID == "aa63a8b7-09b8-4701-8f98-c778489a821c"
replace GPSaccuracy = 6.138000011 if interview_ID == "18b59846-d0da-43c8-bf00-c7e71ddbcca2"
replace GPSaccuracy = 6.138000011 if interview_ID == "52d26817-da8d-4f36-b5ee-ac63a0025143"
replace GPSaccuracy = 6.138000011 if interview_ID == "79fc83f4-9851-4bb0-8840-6a77f025e0fe"
replace GPSaccuracy = 2.665999889 if interview_ID == "4b25375a-5936-4fd0-836c-3178f0ddbe24"
replace GPSaccuracy = 2.665999889 if interview_ID == "76660ce7-b5c0-4ca6-a1a0-32b15c9abde0"
replace GPSaccuracy = 2.665999889 if interview_ID == "85a72bca-d923-44f5-98ef-9c06f00367ce"
replace GPSaccuracy = 2.665999889 if interview_ID == "9f1d2b4f-fc36-45df-a6d4-9967dab6bcbe"
replace GPSaccuracy = 3.21600008 if interview_ID == "83fd6d81-63d3-4a86-9e32-76247f9abb4f"
replace GPSaccuracy = 3.21600008 if interview_ID == "9434bb7a-35ff-4ba0-8ccb-a3757c95002c"
replace GPSaccuracy = 3.21600008 if interview_ID == "f20e594c-20ce-4190-b9e3-a70551d61cbe"
replace GPSaccuracy = 3.21600008 if interview_ID == "f5455c5c-e5e2-40af-9d3b-ab4f16f57144"
replace GPSaccuracy = 3.21600008 if interview_ID == "57e40005-7add-4dd2-bb9d-5759c2981aa1"
replace GPSaccuracy = 3.21600008 if interview_ID == "840d9ee5-ca5a-43f6-a855-9257880755da"
replace GPSaccuracy = 14.12100029 if interview_ID == "21a66f3a-bc71-463e-9eb7-16237de98482"
replace GPSaccuracy = 14.12100029 if interview_ID == "834f3169-e6d2-4ebc-aebd-a90b1f7d26ba"
replace GPSaccuracy = 72.90000153 if interview_ID == "0c3af58d-b82b-4712-aa60-e65eddbb6539"
replace GPSaccuracy = 72.90000153 if interview_ID == "2682570a-c0cb-433d-952f-87fc71639c5f"
replace GPSaccuracy = 72.90000153 if interview_ID == "3b1ebb7d-9a19-46b6-a0fe-85c277d343d9"
replace GPSaccuracy = 72.90000153 if interview_ID == "61858bf5-4529-4ce4-9132-8974caf9c80c"
replace GPSaccuracy = 72.90000153 if interview_ID == "63e07917-b3a6-4475-a3bb-8e027b3dc813"
replace GPSaccuracy = 72.90000153 if interview_ID == "c8ff5326-e9dd-4955-94ef-52e0164bd216"
replace GPSaccuracy = 72.90000153 if interview_ID == "ca2cc16f-af4a-4832-b6c4-d28f16bfb1e3"
replace GPSaccuracy = 7.534999847 if interview_ID == "e89aecb6-f480-4786-831c-65f3b0237601"
replace GPSaccuracy = 2200 if interview_ID == "c8d5fd89-1a74-4a69-a0dd-c8e1563427d8"
replace GPSaccuracy = 3.21600008 if interview_ID == "04d1d201-dfd2-4a7b-9a58-8902ce9ee60a"
replace GPSaccuracy = 3.21600008 if interview_ID == "1d852e1b-7029-450f-937e-09975a21638b"
replace GPSaccuracy = 3.21600008 if interview_ID == "2893993b-f640-47c6-9b06-28fb00386987"
replace GPSaccuracy = 3.21600008 if interview_ID == "903bd68a-d26b-491a-94c2-0cf91418cf6d"
replace GPSaccuracy = 3.21600008 if interview_ID == "c3b4ea71-c3bc-424a-aa3d-a97c73caf437"
replace GPSaccuracy = 8.800000191 if interview_ID == "122a3775-ade1-4606-a980-f7066fb2cf1c"
replace GPSaccuracy = 8.800000191 if interview_ID == "71a9e35f-0f05-476e-8160-716eb8ce68bd"
replace GPSaccuracy = 8.800000191 if interview_ID == "a0c27261-8682-4b7b-a9df-d58142ec58bb"
replace GPSaccuracy = 8.800000191 if interview_ID == "a7ee66c5-6ca3-4270-943e-8d97534e409e"
replace GPSaccuracy = 8.800000191 if interview_ID == "a96ba806-ab05-4313-8f91-5d695422c339"
replace GPSaccuracy = 8.800000191 if interview_ID == "c8f06068-cfe7-4ecc-96df-e7b3a1e03ff9"
replace GPSaccuracy = 4.699999809 if interview_ID == "2e1d1197-4bb8-43ee-8ec6-43c71f5fc1af"
replace GPSaccuracy = 4.699999809 if interview_ID == "70692290-12f9-4600-8e8b-161b8d6b6dd8"
replace GPSaccuracy = 4.699999809 if interview_ID == "74a5d05b-d0ef-46ff-a1f8-ef76b03464ce"
replace GPSaccuracy = 4.288000107 if interview_ID == "9ee1d44a-3aac-4528-88d6-e2382ae3e55e"
replace GPSaccuracy = 4.288000107 if interview_ID == "aa705510-01bc-4030-81ae-ba6279c3d234"
replace GPSaccuracy = 4.288000107 if interview_ID == "b5a39bbe-530d-459d-8f76-bcef1cb865f7"
replace GPSaccuracy = 4.288000107 if interview_ID == "e30ad39d-2716-470f-bec7-0a11204f1057"
replace GPSaccuracy = 4.288000107 if interview_ID == "f4812f80-450b-4c0d-86ed-a21356e88b61"
replace GPSaccuracy = 4.288000107 if interview_ID == "f544bee7-8108-4fab-8117-a6e21c17414d"
replace GPSaccuracy = 4.665999889 if interview_ID == "257b9f02-7c31-4218-8882-9f65210f06cb"
replace GPSaccuracy = 4.665999889 if interview_ID == "2b29acbf-80bc-4fa5-acba-ad4a1d8116fb"
replace GPSaccuracy = 4.665999889 if interview_ID == "3da903f2-a9a6-450f-925d-4a72126b82ec"
replace GPSaccuracy = 4.665999889 if interview_ID == "42e879ae-62f9-492b-a5d6-578934def43e"
replace GPSaccuracy = 4.665999889 if interview_ID == "55d0fe44-60e0-4459-a3e5-9ee099e06adc"
replace GPSaccuracy = 4.665999889 if interview_ID == "7ea07b27-b812-4a7b-b376-0eee6a7574be"
replace GPSaccuracy = 4.665999889 if interview_ID == "d20561fa-0589-4bdf-a7bc-0da0993a5fb2"
replace GPSaccuracy = 4.665999889 if interview_ID == "f03948d5-6cce-4aba-8ec1-28efe2cfa731"
replace GPSaccuracy = 4.900000095 if interview_ID == "027a196d-7043-4bb4-aa5e-7fcd32e46d91"
replace GPSaccuracy = 4.900000095 if interview_ID == "0468f33f-6deb-4f5b-a8b0-6173cc6375d0"
replace GPSaccuracy = 4.900000095 if interview_ID == "0c2f0b83-c323-4807-8aef-1f676bbf5342"
replace GPSaccuracy = 4.900000095 if interview_ID == "214a47ef-bda4-4406-8162-1441839f2282"
replace GPSaccuracy = 4.900000095 if interview_ID == "2a147b0d-9d07-4312-a54a-f9c531ba3433"
replace GPSaccuracy = 4.900000095 if interview_ID == "31b9953f-f435-48cd-841a-5b23e7c02c29"
replace GPSaccuracy = 4.900000095 if interview_ID == "42b9c7aa-3992-432d-bcc5-da6c7e61e922"
replace GPSaccuracy = 4.900000095 if interview_ID == "5467272d-891a-4429-a1d9-81f3f54dedcc"
replace GPSaccuracy = 4.900000095 if interview_ID == "676c57a7-0ab1-47bd-b148-cb98cc3fe508"
replace GPSaccuracy = 4.900000095 if interview_ID == "7c0deefb-5d0a-49fe-8f7b-8b7b10441830"
replace GPSaccuracy = 4.900000095 if interview_ID == "8b390415-7b64-43e1-9ee1-e67e697b8363"
replace GPSaccuracy = 4.900000095 if interview_ID == "8d0cbea6-4af1-45b9-a603-9215ed301f8f"
replace GPSaccuracy = 4.900000095 if interview_ID == "a4907a68-5ba2-4dc6-bce2-ebf6e4e88eaa"
replace GPSaccuracy = 4.900000095 if interview_ID == "cce2f8bf-5812-4f13-8b91-0306a5f35ba4"
replace GPSaccuracy = 4.900000095 if interview_ID == "cddfd414-b91c-42e3-9ab0-ec31e4e188be"
replace GPSaccuracy = 4.900000095 if interview_ID == "d97e54e2-c177-4fbe-b56a-1b000953b2bf"
replace GPSaccuracy = 4.900000095 if interview_ID == "e586a214-c95c-4fa2-bd8f-e5d84cf228fc"
replace GPSaccuracy = 4.900000095 if interview_ID == "f150a531-b15c-4005-b834-e731c40e5fa3"
replace GPSaccuracy = 6.230000019 if interview_ID == "47ad1902-b5eb-4e37-bd3c-bf63d1415e8b"

replace GPSlatitude = 14.348937 if interview_ID == "c9cfa38a-decb-4c44-8037-447948813a82"
replace GPSlongitude = -16.4181292 if interview_ID == "c9cfa38a-decb-4c44-8037-447948813a82"
replace GPSaccuracy = 3.21600008 if interview_ID == "c9cfa38a-decb-4c44-8037-447948813a82"
replace GPSlatitude = 14.1316984 if interview_ID == "5c8de8ad-10fc-4c1e-90dc-f867e01e3a57"
replace GPSlongitude = -15.7544979 if interview_ID == "5c8de8ad-10fc-4c1e-90dc-f867e01e3a57"
replace GPSaccuracy = 7.915999889 if interview_ID == "5c8de8ad-10fc-4c1e-90dc-f867e01e3a57"
replace GPSlatitude = 14.4641626 if interview_ID == "ba8813be-37ab-4a35-a16a-6e257e3633fe"
replace GPSlongitude = -16.2911434 if interview_ID == "ba8813be-37ab-4a35-a16a-6e257e3633fe"
replace GPSaccuracy = 3 if interview_ID == "ba8813be-37ab-4a35-a16a-6e257e3633fe"

replace GPSlatitude = 14.1371195 if interview_ID == "f86530e0-d0ea-4270-af13-770e86c6106d"
replace GPSlatitude = 14.0920802 if interview_ID == "0dd59e1c-563b-4e90-bbc0-b27be3e787a9"
replace GPSlatitude = 14.0920802 if interview_ID == "18e148e8-0d56-481d-addc-401cd8a79600"
replace GPSlatitude = 14.0920802 if interview_ID == "7ed319c3-de86-4ac2-a470-a5ad9b450233"
replace GPSlatitude = 14.0920802 if interview_ID == "b02ce9c0-b874-471b-8707-12ab174e2cfa"
replace GPSlatitude = 15.3730676 if interview_ID == "f830bab3-74e7-45f4-b0e2-8c3885992c71"
replace GPSlatitude = 15.3676623 if interview_ID == "9a624f36-28c4-436e-b0a6-1e4d914d0d30"
replace GPSlatitude = 14.0885831 if interview_ID == "8a602dc3-a760-4ddd-8f3b-e22bdc6231de"
replace GPSlatitude = 14.0338522 if interview_ID == "5be6cc18-0872-4e37-be8f-bfe8ce8ab763"
replace GPSlatitude = 14.0338522 if interview_ID == "895617d5-4905-4cdc-8eee-5a9996f78eb3"
replace GPSlatitude = 14.0338522 if interview_ID == "b0948ce1-f0fe-4ce5-8dc2-cdff223018bf"
replace GPSlatitude = 14.0338522 if interview_ID == "0658f402-e5a1-44c8-8f07-b7b378fa2bd6"
replace GPSlatitude = 14.1069198 if interview_ID == "18b0147a-3936-4b70-a157-228cbc569d96"
replace GPSlatitude = 14.1069198 if interview_ID == "3df4f11a-06a6-405c-bee1-cb2bf9a5068c"
replace GPSlatitude = 14.1069198 if interview_ID == "6e827057-5501-4e70-85e3-e3948c1a6dd9"
replace GPSlatitude = 14.1069198 if interview_ID == "9b08b48a-cacd-4878-9711-94b876d7ac52"
replace GPSlatitude = 14.1069198 if interview_ID == "ca40162a-c1df-4535-8615-1ec454c289e2"
replace GPSlatitude = 15.3767223 if interview_ID == "ce0d08ed-a5fa-4301-af8f-cbd6aaf9aadb"
replace GPSlatitude = 15.3434235 if interview_ID == "a63d1c79-f57a-43b0-8ad5-5209d0d7fffb"
replace GPSlatitude = 15.3434235 if interview_ID == "b6958f8b-3db2-4e2c-8d63-b712285d825f"
replace GPSlatitude = 15.3434235 if interview_ID == "f524f689-f0e8-48ab-9723-1d224ba7a2d1"
replace GPSlatitude = 15.2969417 if interview_ID == "006f5792-cc96-4c31-84f2-83db4a34075e"
replace GPSlatitude = 15.2969417 if interview_ID == "ef1039a9-2bee-4423-b990-8d83ec39734f"
replace GPSlatitude = 14.0904797 if interview_ID == "0c162021-056f-46dc-bcc8-f90dae15a258"
replace GPSlatitude = 14.0904797 if interview_ID == "775fdf37-148c-42cf-9e6e-789e29b752e0"
replace GPSlatitude = 14.0904797 if interview_ID == "9aa0c22e-d171-4b2d-a3c7-37fdcd43484b"
replace GPSlatitude = 14.0904797 if interview_ID == "f497c2b1-6436-4d4a-80d5-c36f7c31aafc"
replace GPSlatitude = 13.9810722 if interview_ID == "5f245ecf-2232-4e05-9aae-6c38b0625aa5"

replace GPSlongitude = -15.8028482 if interview_ID == "f86530e0-d0ea-4270-af13-770e86c6106d"
replace GPSlongitude = -15.5504803 if interview_ID == "0dd59e1c-563b-4e90-bbc0-b27be3e787a9"
replace GPSlongitude = -15.5504803 if interview_ID == "18e148e8-0d56-481d-addc-401cd8a79600"
replace GPSlongitude = -15.5504803 if interview_ID == "7ed319c3-de86-4ac2-a470-a5ad9b450233"
replace GPSlongitude = -15.5504803 if interview_ID == "b02ce9c0-b874-471b-8707-12ab174e2cfa"
replace GPSlongitude = -16.4707607 if interview_ID == "f830bab3-74e7-45f4-b0e2-8c3885992c71"
replace GPSlongitude = -16.4542177 if interview_ID == "9a624f36-28c4-436e-b0a6-1e4d914d0d30"
replace GPSlongitude = -15.5954133 if interview_ID == "8a602dc3-a760-4ddd-8f3b-e22bdc6231de"
replace GPSlongitude = -16.3642719 if interview_ID == "5be6cc18-0872-4e37-be8f-bfe8ce8ab763"
replace GPSlongitude = -16.3642719 if interview_ID == "895617d5-4905-4cdc-8eee-5a9996f78eb3"
replace GPSlongitude = -16.3642719 if interview_ID == "b0948ce1-f0fe-4ce5-8dc2-cdff223018bf"
replace GPSlongitude = -16.3642719 if interview_ID == "0658f402-e5a1-44c8-8f07-b7b378fa2bd6"
replace GPSlongitude = -16.32172 if interview_ID == "18b0147a-3936-4b70-a157-228cbc569d96"
replace GPSlongitude = -16.32172 if interview_ID == "3df4f11a-06a6-405c-bee1-cb2bf9a5068c"
replace GPSlongitude = -16.32172 if interview_ID == "6e827057-5501-4e70-85e3-e3948c1a6dd9"
replace GPSlongitude = -16.32172 if interview_ID == "9b08b48a-cacd-4878-9711-94b876d7ac52"
replace GPSlongitude = -16.32172 if interview_ID == "ca40162a-c1df-4535-8615-1ec454c289e2"
replace GPSlongitude = -16.4430334 if interview_ID == "ce0d08ed-a5fa-4301-af8f-cbd6aaf9aadb"
replace GPSlongitude = -15.4637681 if interview_ID == "a63d1c79-f57a-43b0-8ad5-5209d0d7fffb"
replace GPSlongitude = -15.4637681 if interview_ID == "b6958f8b-3db2-4e2c-8d63-b712285d825f"
replace GPSlongitude = -15.4637681 if interview_ID == "f524f689-f0e8-48ab-9723-1d224ba7a2d1"
replace GPSlongitude = -16.5364367 if interview_ID == "006f5792-cc96-4c31-84f2-83db4a34075e"
replace GPSlongitude = -16.5364367 if interview_ID == "ef1039a9-2bee-4423-b990-8d83ec39734f"
replace GPSlongitude = -15.5595801 if interview_ID == "0c162021-056f-46dc-bcc8-f90dae15a258"
replace GPSlongitude = -15.5595801 if interview_ID == "775fdf37-148c-42cf-9e6e-789e29b752e0"
replace GPSlongitude = -15.5595801 if interview_ID == "9aa0c22e-d171-4b2d-a3c7-37fdcd43484b"
replace GPSlongitude = -15.5595801 if interview_ID == "f497c2b1-6436-4d4a-80d5-c36f7c31aafc"
replace GPSlongitude = -16.2278528 if interview_ID == "5f245ecf-2232-4e05-9aae-6c38b0625aa5"

replace GPSaccuracy = 9.647999763 if interview_ID == "f86530e0-d0ea-4270-af13-770e86c6106d"
replace GPSaccuracy = 4.800000191 if interview_ID == "0dd59e1c-563b-4e90-bbc0-b27be3e787a9"
replace GPSaccuracy = 4.800000191 if interview_ID == "18e148e8-0d56-481d-addc-401cd8a79600"
replace GPSaccuracy = 4.800000191 if interview_ID == "7ed319c3-de86-4ac2-a470-a5ad9b450233"
replace GPSaccuracy = 4.800000191 if interview_ID == "b02ce9c0-b874-471b-8707-12ab174e2cfa"
replace GPSaccuracy = 5.106999874 if interview_ID == "f830bab3-74e7-45f4-b0e2-8c3885992c71"
replace GPSaccuracy = 48.90000153 if interview_ID == "9a624f36-28c4-436e-b0a6-1e4d914d0d30"
replace GPSaccuracy = 4.699999809 if interview_ID == "8a602dc3-a760-4ddd-8f3b-e22bdc6231de"
replace GPSaccuracy = 1.73300004 if interview_ID == "5be6cc18-0872-4e37-be8f-bfe8ce8ab763"
replace GPSaccuracy = 1.73300004 if interview_ID == "895617d5-4905-4cdc-8eee-5a9996f78eb3"
replace GPSaccuracy = 1.73300004 if interview_ID == "b0948ce1-f0fe-4ce5-8dc2-cdff223018bf"
replace GPSaccuracy = 1.73300004 if interview_ID == "0658f402-e5a1-44c8-8f07-b7b378fa2bd6"
replace GPSaccuracy = 15 if interview_ID == "18b0147a-3936-4b70-a157-228cbc569d96"
replace GPSaccuracy = 15 if interview_ID == "3df4f11a-06a6-405c-bee1-cb2bf9a5068c"
replace GPSaccuracy = 15 if interview_ID == "6e827057-5501-4e70-85e3-e3948c1a6dd9"
replace GPSaccuracy = 15 if interview_ID == "9b08b48a-cacd-4878-9711-94b876d7ac52"
replace GPSaccuracy = 15 if interview_ID == "ca40162a-c1df-4535-8615-1ec454c289e2"
replace GPSaccuracy = 15 if interview_ID == "ce0d08ed-a5fa-4301-af8f-cbd6aaf9aadb"
replace GPSaccuracy = 2.378999949 if interview_ID == "a63d1c79-f57a-43b0-8ad5-5209d0d7fffb"
replace GPSaccuracy = 2.378999949 if interview_ID == "b6958f8b-3db2-4e2c-8d63-b712285d825f"
replace GPSaccuracy = 2.378999949 if interview_ID == "f524f689-f0e8-48ab-9723-1d224ba7a2d1"
replace GPSaccuracy = 2.665999889 if interview_ID == "006f5792-cc96-4c31-84f2-83db4a34075e"
replace GPSaccuracy = 2.665999889 if interview_ID == "ef1039a9-2bee-4423-b990-8d83ec39734f"
replace GPSaccuracy = 4.699999809 if interview_ID == "0c162021-056f-46dc-bcc8-f90dae15a258"
replace GPSaccuracy = 4.699999809 if interview_ID == "775fdf37-148c-42cf-9e6e-789e29b752e0"
replace GPSaccuracy = 4.699999809 if interview_ID == "9aa0c22e-d171-4b2d-a3c7-37fdcd43484b"
replace GPSaccuracy = 4.699999809 if interview_ID == "f497c2b1-6436-4d4a-80d5-c36f7c31aafc"
replace GPSaccuracy = 4.900000095 if interview_ID == "5f245ecf-2232-4e05-9aae-6c38b0625aa5"

*Field team
replace ENUM_NAME = 37 if interview_ID =="b311e562-a639-4ea6-9ebc-add8b3fe2b49"
replace ENUM_NAME = 41 if interview_ID =="e9dc91bf-47ee-412e-b297-de714e522531"
replace ENUM_NAME = 37 if interview_ID =="6bfd7f9f-8346-4772-b4e4-85b95389bea6"
replace ENUM_NAME = 37 if interview_ID =="d03e46ec-dd62-4a81-b2c3-7594ec03ff79"
replace ENUM_NAME = 37 if interview_ID =="a45cd6b0-302a-47c6-8ac0-24f9949d65b4"
replace ENUM_NAME = 41 if interview_ID =="ffa369ac-4283-4a90-98fc-8846a6c6fb4e"
replace ENUM_NAME = 41 if interview_ID =="48422b8d-42ad-4294-95f3-7bb2d2701d36"
replace ENUM_NAME = 41 if interview_ID =="a86a2cd3-f0b6-4a89-91e5-25c1db9a269d"
replace ENUM_NAME = 41 if interview_ID =="f9a21cb3-0622-4552-a3ca-975394b9ca03"
replace ENUM_NAME = 39 if interview_ID =="8c21f71d-6af5-489c-b9c0-71360d00efce"
replace ENUM_NAME = 39 if interview_ID =="8d3c5fd7-5873-4bf9-81a7-17cc5e4bf39e"
replace ENUM_NAME = 39 if interview_ID =="371c0317-3508-4318-b597-f78fe787d8c2"
replace ENUM_NAME = 38 if interview_ID =="0f1e6edb-fbdd-49a6-98b4-8a29a96c6fce"
replace ENUM_NAME = 38 if interview_ID =="ddf9180a-94dd-4109-a1d3-e26552185847"
replace ENUM_NAME = 38 if interview_ID =="e2a5aa95-3efe-4176-8de2-a917e416f892"
replace ENUM_NAME = 40 if interview_ID =="8b3a4326-6be3-4662-bd21-0e7a142e2b26"
replace ENUM_NAME = 40 if interview_ID =="10e18a5d-a3d3-418c-a172-aa94b5e7a891"
replace ENUM_NAME = 41 if interview_ID =="b1ed57cd-6405-4420-8c86-ffc041d29f3c"
replace ENUM_NAME = 41 if interview_ID =="f0aa8ac4-7bee-4f7a-b739-4fe659c8f45d"
replace ENUM_NAME = 41 if interview_ID =="bb38e98b-b82d-4c4a-ae3b-ebff5e853efa"
replace ENUM_NAME = 38 if interview_ID =="24ddb85f-4829-4aa5-98de-677c17942d33"
replace ENUM_NAME = 38 if interview_ID =="47ee1a1a-b5dc-4da9-8f02-724fc60370b4"
replace ENUM_NAME = 40 if interview_ID =="00826e7c-3fee-4d2a-ac67-3df565e0fd5c"
replace ENUM_NAME = 40 if interview_ID =="c4783693-ad83-4f4f-a2fa-e1970e56e81d"
replace ENUM_NAME = 37 if interview_ID =="1ae31e2b-c77c-4342-8ac4-c54aa83fc07a"
replace ENUM_NAME = 41 if interview_ID =="d3554d76-de3c-4df7-95c7-5d4b480c872d"
replace ENUM_NAME = 41 if interview_ID =="11b575ed-75e5-4c16-ba91-e633fff5e625"
replace ENUM_NAME = 41 if interview_ID =="4c833cf3-8f8c-406d-a5ce-6dc5cacf8520"
replace ENUM_NAME = 38 if interview_ID =="5e747f2a-7fae-4aad-8574-4cfea8e8cb1d"
replace ENUM_NAME = 38 if interview_ID =="b46572e4-771f-46d4-9f95-9778009121ab"
replace ENUM_NAME = 38 if interview_ID =="1167f150-be84-4357-a59a-816e180aa9e5"
replace ENUM_NAME = 40 if interview_ID =="dfc970ce-7cb4-4ac4-9a20-fdee11481469"
replace ENUM_NAME = 40 if interview_ID =="f8959099-5a49-4c05-ba77-171a41309c79"
replace ENUM_NAME = 37 if interview_ID =="770feaa2-8f30-4317-879b-b35a080898f0"
replace ENUM_NAME = 37 if interview_ID =="7a3643cc-50f8-41bd-bc35-42714e02e6d9"
replace ENUM_NAME = 37 if interview_ID =="8269988f-2110-44a4-a57f-199f34260267"
replace ENUM_NAME = 41 if interview_ID =="04258a37-5377-4cd2-9115-d1bc1bb3e05e"
replace ENUM_NAME = 41 if interview_ID =="e37e31ff-971c-4cc3-ae27-538080cbc069"
replace ENUM_NAME = 41 if interview_ID =="b25b96b2-88b7-4a6d-99a2-97f8920b5fac"
replace ENUM_NAME = 42 if interview_ID =="88d3d1b9-b022-4e74-b012-54899ca085fb"
replace ENUM_NAME = 42 if interview_ID =="58b8b835-a14f-4c8c-b26c-dd5a66af9944"
replace ENUM_NAME = 40 if interview_ID =="1e6ce836-abca-4845-8650-e0d52914b27f"
replace ENUM_NAME = 40 if interview_ID =="b36268e5-4160-4503-af8d-779c7e257c28"
replace ENUM_NAME = 41 if interview_ID =="b2da6eac-83ef-47e1-b340-9d454d62a060"
replace ENUM_NAME = 41 if interview_ID =="ae96cd84-aaf9-41d5-bd4b-0bd5c3ea54d7"
replace ENUM_NAME = 39 if interview_ID =="cb46dbc5-e66d-47fc-9ee3-abe3722fe14c"
replace ENUM_NAME = 39 if interview_ID =="de7235b2-a59c-4a25-af2e-e8f5ac991255"
replace ENUM_NAME = 38 if interview_ID =="efea57df-e364-4719-a921-f474f48abf52"
replace ENUM_NAME = 38 if interview_ID =="616540c8-6671-4e45-bec4-bb37bb8e38ab"
replace ENUM_NAME = 38 if interview_ID =="00735275-09b8-4bcc-ae02-83f38ad38dee"
replace ENUM_NAME = 40 if interview_ID =="f634b439-08fa-4b47-bfbe-5416412abf36"
replace ENUM_NAME = 40 if interview_ID =="936b8519-0a68-47e1-96c3-ca0e5316df62"
replace ENUM_NAME = 40 if interview_ID =="1135b700-ad36-483a-bf8f-526ad318ba9d"
replace ENUM_NAME = 41 if interview_ID =="b5d23c6f-e74a-4d5d-ae1c-d33ef5441685"
replace ENUM_NAME = 41 if interview_ID =="ce4e1042-54a1-4924-85dd-0d0a91847fe4"
replace ENUM_NAME = 41 if interview_ID =="8f881490-ecdd-4bb3-9a27-ead212c0e639"
replace ENUM_NAME = 37 if interview_ID =="821eda56-f1f0-4f3a-83ff-6a0fa3463ab3"
replace ENUM_NAME = 37 if interview_ID =="84b40d93-22e6-438e-9ab4-fc37a48ec178"
replace ENUM_NAME = 41 if interview_ID =="8fa4a467-8fe8-4b73-90dd-c965973d442c"
replace ENUM_NAME = 41 if interview_ID =="ea07b9b9-bf74-4a0f-acf1-57d3e15fb354"
replace ENUM_NAME = 39 if interview_ID =="08af111c-2a17-4092-b541-919600048748"
replace ENUM_NAME = 38 if interview_ID =="b70d9bd8-930c-433a-b520-49a9a51cc3c0"
replace ENUM_NAME = 38 if interview_ID =="c188c97e-d875-4714-8a78-0515f4dea2c6"
replace ENUM_NAME = 38 if interview_ID =="aa052faa-9568-4509-8f99-edb69f4c9b0b"
replace ENUM_NAME = 40 if interview_ID =="9dfed3f7-9bde-4cc8-9c1b-f97416c869a5"
replace ENUM_NAME = 40 if interview_ID =="445769b4-4e0f-439e-9032-051db282d685"
replace ENUM_NAME = 40 if interview_ID =="a4ee5c0c-a1d7-4044-b4e9-9315b71f0711"
replace ENUM_NAME = 40 if interview_ID =="cce2f8bf-5812-4f13-8b91-0306a5f35ba4"
replace ENUM_NAME = 41 if interview_ID =="a4cb6cdb-48f2-4982-be38-3ba4c11b5a41"
replace ENUM_NAME = 41 if interview_ID =="5b85afc2-4ada-48ca-b227-4a3f3823c6e4"
replace ENUM_NAME = 41 if interview_ID =="224f3ff8-fdef-43b2-bad3-8768b91b9369"
replace ENUM_NAME = 37 if interview_ID =="0ada33d9-ea04-4d6f-9d0f-21d9883381f8"
replace ENUM_NAME = 37 if interview_ID =="59dbde91-a816-4240-b61a-0c83e967dc7b"
replace ENUM_NAME = 37 if interview_ID =="af771052-6cc1-4b80-b9da-4e4ad39a22ff"
replace ENUM_NAME = 41 if interview_ID =="61063fa4-3a7c-42db-b2c0-133bcff996b3"
replace ENUM_NAME = 41 if interview_ID =="ba8225bd-a1eb-4bad-8aab-f5689a809b31"
replace ENUM_NAME = 41 if interview_ID =="766f8ad4-f11a-4816-ba35-3702e5cf7e19"
replace ENUM_NAME = 40 if interview_ID =="100f9d32-6342-4d0d-81c3-4a7f16cdf006"
replace ENUM_NAME = 37 if interview_ID =="f9b7a79c-6095-49d5-be36-84c87e9d7b47"
replace ENUM_NAME = 37 if interview_ID =="49c22686-b976-4978-b98e-688d17146860"
replace ENUM_NAME = 37 if interview_ID =="0e39f25b-7207-4944-93c5-b1ed087d46b1"
replace ENUM_NAME = 41 if interview_ID =="6a9d5279-55f2-46f6-b6fd-3cd9c14349ea"
replace ENUM_NAME = 39 if interview_ID =="79fc83f4-9851-4bb0-8840-6a77f025e0fe"
replace ENUM_NAME = 39 if interview_ID =="18b59846-d0da-43c8-bf00-c7e71ddbcca2"
replace ENUM_NAME = 40 if interview_ID =="1eb16329-c5e1-4d76-b8ca-f13f6740a130"
replace ENUM_NAME = 40 if interview_ID =="ae513efd-0ff8-43c3-8a11-918f656c002f"
replace ENUM_NAME = 40 if interview_ID =="9a07d9d9-e9b8-467e-b22a-b31cbb110b0a"
replace ENUM_NAME = 39 if interview_ID =="94c65d85-4fea-46f2-a855-22691925252a"
replace ENUM_NAME = 39 if interview_ID =="0ea4943b-dc34-4f8a-91ea-6162aef264e5"
replace ENUM_NAME = 41 if interview_ID =="bc757bad-3857-4a98-b6e5-414094eba822"

replace ENUM_NAME = 37 if interview_ID =="bc993276-73f9-4614-9e3a-25d964e42aac"
replace ENUM_NAME = 40 if interview_ID =="0f32ff33-1eee-4513-a1ab-7b28e2c94fff"
replace ENUM_NAME = 37 if interview_ID =="263b8309-80fb-493b-a1a1-036c6e5edc13"
replace ENUM_NAME = 37 if interview_ID =="a4de4b5b-2305-41b4-8eef-fda2a4845f2f"
replace ENUM_NAME = 37 if interview_ID =="8fb628db-37c7-45fd-a697-9de1717e59a0"
replace ENUM_NAME = 41 if interview_ID =="821dfdc1-077b-4246-a4bb-73dcd6be29bc"
replace ENUM_NAME = 38 if interview_ID =="d51aaad9-bf32-4daf-8535-77f555fcb41b"
replace ENUM_NAME = 38 if interview_ID =="fd427ede-c6ab-49af-8352-779cc47d092a"
replace ENUM_NAME = 38 if interview_ID =="1bcda336-e9ec-42b5-a95f-8d44c2d08a34"
replace ENUM_NAME = 40 if interview_ID =="642645fe-3920-49ad-b04d-7721d7c03230"
replace ENUM_NAME = 40 if interview_ID =="63238591-89a5-47fb-a9f2-c00541b424fe"
replace ENUM_NAME = 39 if interview_ID =="f13c6700-5ccc-46d4-83a9-16c40e3c80ed"
replace ENUM_NAME = 41 if interview_ID =="69de2c51-b0f6-4eaa-8a9a-f1d6ea1a8d01"

lab def enum 37"Moustapha Diamé"	38"Amath Niang"	39"Ismaila Lo"	40"Mouhamet Diop"	41"Alkhayri Diawara"	42"Mouhamed Habib So",add

replace SUP_NAME = 5 if interview_ID == "1870459e-e7c2-47eb-973e-3716d768e7e8"
replace ENUM_NAME = 28 if interview_ID == "1870459e-e7c2-47eb-973e-3716d768e7e8"
replace ENUM_NAME = 9 if interview_ID == "eb64cf91-c0c1-4013-8061-49ea38f82715"
replace ENUM_NAME = 7 if interview_ID == "76b04df6-432d-4cb9-968f-1580d98f75c9"
replace ENUM_NAME = 1 if interview_ID == "0a0bac0b-7fee-4684-bd91-88a4b9034726"
replace ENUM_NAME = 32 if interview_ID == "0968ca27-1ccf-4021-8480-295af2563110"
replace ENUM_NAME = 41 if interview_ID == "629accfd-5d95-44b0-8b4f-fbecfe310a2e"
replace ENUM_NAME = 10 if interview_ID == "f34aa718-727b-4543-bf98-17a97e5ea2c3"
replace ENUM_NAME = 41 if interview_ID == "f34aa718-727b-4543-bf98-17a97e5ea2c3"
replace ENUM_NAME = 40 if interview_ID == "2682570a-c0cb-433d-952f-87fc71639c5f"
replace ENUM_NAME = 41 if interview_ID == "1f0ed039-51e2-470e-b829-fcbbaa74cf25"

replace INT_STARTTIME = clock("10:10","hm") if interview_ID == "65c6d154-7c51-411f-8450-4773569fef76"
replace INT_ENDTIME   = clock("10:45","hm") if interview_ID == "65c6d154-7c51-411f-8450-4773569fef76"
replace INT_STARTTIME = clock("10:10","hm") if interview_ID == "629accfd-5d95-44b0-8b4f-fbecfe310a2e"
replace INT_STARTTIME = clock("10:00","hm") if interview_ID == "ac6bd1de-8a68-4829-bdff-cbc1f4296fcc"
replace INT_STARTTIME = clock("11:35","hm") if interview_ID == "5136b684-922f-49d7-b4f3-5e2e773633c7"
replace INT_STARTTIME = clock("13:00","hm") if interview_ID == "56bb62c2-a467-4786-8eef-bfe55ba3ba9b"
replace INT_STARTTIME = clock("14:08","hm") if interview_ID == "3a6af633-5bfc-43e5-bea0-bdf0e19a83bb"
replace INT_ENDTIME   = clock("15:10","hm") if interview_ID == "3a6af633-5bfc-43e5-bea0-bdf0e19a83bb"
replace INT_STARTTIME = clock("12:12","hm") if interview_ID == "0f32ff33-1eee-4513-a1ab-7b28e2c94fff"
replace INT_ENDTIME   = clock("13:05","hm") if interview_ID == "0f32ff33-1eee-4513-a1ab-7b28e2c94fff"
replace INT_STARTTIME = clock("12:20","hm") if interview_ID == "b311e562-a639-4ea6-9ebc-add8b3fe2b49"
replace INT_STARTTIME = clock("09:29","hm") if interview_ID == "4627908c-28ef-43be-aae7-3eb942bb11fc"
replace INT_STARTTIME = clock("13:30","hm") if interview_ID == "bfe34b7d-f352-4869-a322-525bba5c9b2e"
replace INT_STARTTIME = clock("10:54","hm") if interview_ID == "a8c3d06a-12c7-44ef-9c7d-0f84daa62f20"
replace INT_STARTTIME = clock("09:55","hm") if interview_ID == "8c2ff819-0fb0-4e5c-94ba-2245cc321009"
replace INT_STARTTIME = clock("14:07","hm") if interview_ID == "936b8519-0a68-47e1-96c3-ca0e5316df62"
replace INT_STARTTIME = clock("15:11","hm") if interview_ID == "936b8519-0a68-47e1-96c3-ca0e5316df62"
replace INT_STARTTIME = clock("10:20","hm") if interview_ID == "ae96cd84-aaf9-41d5-bd4b-0bd5c3ea54d7"
replace INT_STARTTIME = clock("11:30","hm") if interview_ID == "ae96cd84-aaf9-41d5-bd4b-0bd5c3ea54d7"
replace INT_STARTTIME = clock("16:50","hm") if interview_ID == "1f0ed039-51e2-470e-b829-fcbbaa74cf25"
replace INT_STARTTIME = clock("16:20","hm") if interview_ID == "eb64cf91-c0c1-4013-8061-49ea38f82715"
replace INT_ENDTIME = clock("10:30","hm") if interview_ID == "1d2b7177-08c7-417d-9f49-32e671ff0f7b"
replace INT_STARTTIME = clock("13:45","hm") if interview_ID == "936b8519-0a68-47e1-96c3-ca0e5316df62"
replace INT_ENDTIME = clock("14:50","hm") if interview_ID == "936b8519-0a68-47e1-96c3-ca0e5316df62"
replace INT_STARTTIME = clock("10:20","hm") if interview_ID == "ae96cd84-aaf9-41d5-bd4b-0bd5c3ea54d7"
replace INT_ENDTIME = clock("11:30","hm") if interview_ID == "ae96cd84-aaf9-41d5-bd4b-0bd5c3ea54d7"

*Time. 
gen double time_diff = INT_ENDTIME - INT_STARTTIME
replace Duration_mins = time_diff/(1000*60) 

drop tabletUserName Comments 
drop time_diff

*School correction
replace Ecole = 102 if interview_ID == "7cd7be1f-f25a-4b85-9430-a073a2225739"

*Teaching language correction
replace teaching_language = 1 if inlist(interview_ID,"aad7270d-0f73-4447-908a-ed20dab1ce41","7af64321-be2a-449f-9350-d3491d6ff2a3")

replace official_language = 4 if interview_ID == "27dd3d37-664a-4880-99b6-abf46ab96870"

replace read_familiar_words_wfnum_corr = . if read_familiar_words_wf_1 == .

*Translations
replace B9_S = "Ceremony at home." if interview_ID == "b6828548-ca8c-4d29-ae1a-7907eb5a9024"
replace B9_S = "Public holiday" if interview_ID == "21e3b695-bc0c-4811-86a3-7dad59bfa376"
replace B9_S = "Public holiday" if interview_ID == "7a0b1be7-26c4-459c-8bee-0eca20c1be12"
replace B9_S = "Public holiday" if interview_ID == "e3574a21-ab42-4df2-8508-c2d8ae529eb0"
replace B9_S = "Funeral ceremony" if interview_ID == "5b6d1a91-e454-45a3-9170-9a2eec4edbf8"
replace B9_S = "Going to Koranic school" if interview_ID == "b876096e-74c4-47c5-a8a6-c231acfb3c19"
replace B9_S = "Her mother had gone to a funeral and locked the room, so she couldn't get her bag or clothes out" if interview_ID == "5875efa2-2b0b-4353-b809-e69b1c767cc7"
replace B9_S = "I had gone to visit my father." if interview_ID == "69dd2e9c-6b09-4bc0-b7cb-a72c261efa79"
replace B9_S = "I just registered for school." if interview_ID == "a4a6f75f-1744-4db0-80b0-57c6ac0efdd4"
replace B9_S = "I was traveling." if interview_ID == "694ca3cc-60ec-41ad-a1c5-67d80e575560"
replace B9_S = "I woke up late and missed school." if interview_ID == "2f8eb35d-5160-4ca3-8b18-67839a8b2d73"
replace B9_S = "Public holiday" if interview_ID == "27dd3d37-664a-4880-99b6-abf46ab96870"
replace B9_S = "Public holiday" if interview_ID == "29968a77-6217-4f6a-9433-a6c2085970e2"
replace B9_S = "Public holiday" if interview_ID == "786b91b5-0973-4c45-b978-3cb64bf6e4df"
replace B9_S = "Public holiday" if interview_ID == "7e90b9a4-4a95-458c-b4ce-1a0843669c65"
replace B9_S = "Public holiday" if interview_ID == "9988177a-a2f3-4953-b173-88bbf8026067"
replace B9_S = "Public holiday" if interview_ID == "ad19fd96-96a8-4f6e-a482-2d475dc3eecc"
replace B9_S = "My father had forbidden me to go." if interview_ID == "9d01a6dd-da25-4d18-9744-db374ab09077"
replace B9_S = "My grandmother asked me not to go" if interview_ID == "323e8c24-dd56-4749-a507-d0699efc9619"
replace B9_S = "Registration problem" if interview_ID == "1ccccc68-0735-4dab-b908-a0d3a80a4c9a"
replace B9_S = "There was a ceremony at home." if interview_ID == "754b931b-ece0-41f4-a665-b9019bcc32ca"
replace B9_S = "There was a funeral next to our house." if interview_ID == "de9a04ad-61ff-4dca-96fe-11636ad44752"
replace B9_S = "There was a test for the 5th grade students at school." if interview_ID == "0f8e2f43-6bb2-4f63-9ba0-21563437c026"
replace B9_S = "There was a wedding at my house." if interview_ID == "4bb7a987-02b3-4411-ad86-fd9e959c4302"
replace B9_S = "Traveling." if interview_ID == "9f7659dc-9afe-4a82-8543-73740869cdf0"
replace B9_S = "Visiting my father." if interview_ID == "7e41401a-2629-47d3-989b-331096ec30d2"



*saving data to raw data
cd "${gsdData}\Raw"
save "Main\Student\MOHEBS Student Baseline Processed Dataset 05-02 v01.dta",replace

*saving data to processed data
cd "${gsdData}\Processed"
save "Main\Student\MOHEBS Student Baseline Processed Dataset 05-02 v01.dta",replace

// drop if INT_DATE < td(02jan2026)
//
// global var_kept "interview_ID INT_DATE INT_STARTTIME INT_ENDTIME survey_language ENUM_NAME assessment_type interviewer_type IA IEF Arrondissement Commune Echantillon Ecole Groupe Language official_language teaching_language Student_Name B2 B3 B4 GPSlatitude GPSlongitude GPSaccuracy"
// //
// export excel $var_kept using "MOHEBS GPS list v01.xlsx", sheet(data,replace)firstrow(variables)


// Semantic - No auto stop
// Phonological - Auto stop after first 5 wrongs
// Oral vocabulary - No auto stop
// Letter knowledge - Stop if 8 or more wrongs in the first 20 letters (Applied stop 8 consecutive - this will include the first 8)
// Decoding Familiar - Stop if 8 or more wrongs in the first 20 letters (Applied stop 8 consecutive - this will include the first 8)
// Decoding Invented - Stop if 8 or more wrongs in the first 20 letters (Applied stop 8 consecutive - this will include the first 8)
// Oral reading fluency - Auto stop after first 8
// Reading comprehension - No auto stop
// Reading comprehension picture matching - First 5 wrongs * (This was not applied to the script)

// MATHS SECTION
// Identifying shapes - If a student identifies correctly at least one triangle in grid 1 or grid 2, they will see grid 3; other wise they will not see grid 3
// Distance/ position tracking - No skip
// Identifying numbers
//
// If the student gives fewer than 4 correct answers between lines 1 and 2, move on to the next activity. If the student moves to lines 3 and 4 but gives fewer than 4 correct answers between those lines, move on to the next activity.
// Counting - No skip
// Digital discrimination
//
// If the student gives fewer than 2 correct answers between lines 1 and 2, move on to the next activity.
//
// If the student moves to lines 3 and 4, but gives less than 2 correct points between these lines, move on to the next activity.
// Missing number
//
// If child gives fewer than 2 correct responses between Rows 1 and 2, assign a 0 and move to the next activity. 
//
// If the child progresses to Rows 3 and 4, but gives fewer than 2 correct between those rows, assign a 1 and move to the next activity
// Decimal system
//
// If the student gives fewer than 2 correct answers between lines 1 and 2, move on to the next activity.
//
// If the student moves to lines 3 and 4, but gives less than 2 correct points between these lines, move on to the next activity.
// Addition and subtraction
//
// If the student cannot solve any of the first two problems, move on to the next activity.
//
// If the student answers at least one correctly, continue with the rest of the examples.
// Addition and subtraction word problem
//
// If the student fails to solve either of the first two problems, move on to the next activity.
//
// If the student answers at least one of the first two correctly, continue with the remaining problems.
// 

// Reading comprehension vs oral reading fluency - For all languages
// General section - Enabled when in oral reading fluency number of items per minute >=10
// Q1 - Enabled when number of items attempted in oral reading fluency >1
// Q2 - Enabled when number of items attempted in oral reading fluency >8
// Q3 - Enabled when number of items attempted in oral reading fluency >17
// Q4 - Enabled when number of items attempted in oral reading fluency >24
// Q5 - Enabled when number of items attempted in oral reading fluency >32
// Q6 - Enabled when number of items attempted in oral reading fluency >32
// Reading comprehension picture matching vs decoding - For all languages
// Enabled when reading familiar>12 or reading invented >12 (13 and above) 

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
replace issue_comment ="Time taken to the next interview is way wierd, seems the interview started earlier or overlapped the other interview, kindly clarify"
keep if !inrange(gap_mins,0,10)
cap export excel $var_kept INT_STARTTIME INT_ENDTIME gap_mins issue_comment using "MOHEBS DQA issues ${dates} v01.xlsx", sheet(lag_time_issues,replace)firstrow(variables)
restore

**GPS Accuracy
preserve
replace issue_comment ="The GPS Accuracy captured is low"
keep if GPSaccuracy> 20
cap export excel $var_kept GPS* issue_comment using "MOHEBS DQA issues ${dates} v01.xlsx", sheet(GPSaccuracy_issues,replace)firstrow(variables)
restore

**Duplicates GPS
duplicates tag GPSlatitude GPSlongitude, gen (gps_dup)

preserve
replace issue_comment ="The GPS captured are duplicated, kindly clarify"
keep if gps_dup> 0
cap export excel $var_kept GPS* issue_comment using "MOHEBS DQA issues ${dates} v01.xlsx", sheet(gps_duplicates_issues,replace)firstrow(variables)
restore

**Duplicates Interviews_General
duplicates tag, gen (Interview_gen_dup)

preserve
replace issue_comment ="The interviews have duplicates, kindly clarify"
keep if Interview_gen_dup> 0
cap export excel $var_kept issue_comment using "MOHEBS DQA issues ${dates} v01.xlsx", sheet(Interv_dupl_gen_issues,replace)firstrow(variables)
restore

**Duplicates Interviews_Main
duplicates tag Ecole Student_Name B2 B3 B4,gen(int_dup)

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

*Teaching language against school.
bysort Ecole teaching_language: gen tag = _n == 1
bysort Ecole: egen teaching_language_uniq = total(tag)

sort Ecole teaching_language

preserve
replace issue_comment ="The school teaching language seems inconsitent, kindly clarify"
keep if teaching_language_uniq > 1
cap export excel $var_kept issue_comment using "MOHEBS DQA issues ${dates} v01.xlsx", sheet(Teach_School,replace)firstrow(variables)
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
summ letter_knowledge_frnum_att letter_knowledge_frnumber_of_ite letter_knowledge_wfnum_att letter_knowledge_wfnumber_of_ite letter_knowledge_srnum_att letter_knowledge_srnumber_of_ite letter_knowledge_prnum_att letter_knowledge_prnumber_of_ite

*Letter_knowledge part b
summ letter_knowledge_fr_Bnum_att letter_knowledge_fr_Bnumber_of_i letter_knowledge_sr_Bnum_att letter_knowledge_sr_Bnumber_of_i letter_knowledge_pr_Bnum_att letter_knowledge_pr_Bnumber_of_i letter_knowledge_wf_Bnum_att letter_knowledge_wf_Bnumber_of_i

*reading familiar part a
summ reading_familiar_words_frnum_att read_familiar_words_frnumber_of_ reading_familiar_words_srnum_att read_familiar_words_srnumber_of_ reading_familiar_words_prnum_att read_familiar_words_prnumber_of_ reading_familiar_words_wfnum_att read_familiar_words_wfnumber_of_ 

*reading familiar part b
summ reading_famila_word_fr_Bnum_att read_familiar_words_fr_Bnumber_o reading_famila_word_sr_Bnum_att read_familiar_words_sr_Bnumber_o reading_famila_word_pr_Bnum_att read_familiar_words_pr_Bnumber_o reading_famila_word_wf_Bnum_att read_familiar_words_wf_Bnumber_o

*reading invented part a
summ read_invented_words_frnum_att read_invented_words_frnumber_of_ read_invented_words_srnum_att read_invented_words_srnumber_of_ read_invented_words_prnum_att read_invented_words_prnumber_of_ read_invented_words_wfnum_att read_invented_words_wfnumber_of_

*reading invented part b
summ read_invented_word_fr_Bnum_att read_invented_words_fr_Bnumber_o read_invented_word_sr_Bnum_att read_invented_words_sr_Bnumber_o read_invented_word_pr_Bnum_att read_invented_words_pr_Bnumber_o read_invented_word_wf_Bnum_att read_invented_words_wf_Bnumber_o

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







