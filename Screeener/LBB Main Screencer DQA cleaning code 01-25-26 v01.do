*************************************************************************
*LBB Braille Checker Screener

*************************************************************************
cls
clear all
cd "C:\Users\oyoo\OneDrive - Dalberg Global Development Advisors\QUALITY CONTROL\Projects\2026\Projects\UNICEF LBB\Main\Data\Raw\Screener"

***import dataset

import spss using "Long format\UNICEF School Screener Questionnaire_Headteacher.sav", clear

*dropping irrelevant variables
drop SubmissionDate	starttime endtime deviceid devicephonenum	username device_info duration caseid password formdef_version instanceID enum_calc

order KEY

*sort sup
replace SUP_NAME = 2 if ENUM_NAME == 9
replace SUP_NAME = 2 if ENUM_NAME == 5

*Formating date
gen INT_DATE1 = dofc(INT_DATE)
format INT_DATE1 %td

drop INT_DATE
ren INT_DATE1 INT_DATE

order INT_DATE, after(KEY)
lab var INT_DATE"Date of observation"

*Location data
label define County_id ///
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

lab values County County_id

*school
label define school_id 1 "Iftin integrated primary" 2 "Jaribu primary" 3 "Chief Muturi Integrated Primary" 4 "Enchurrai" 5 "Kikelelwa Integrated Primary" 6 "Lokitang primary" 7 "Eliyes" 8 "Kibarani Integrated" 9 "Mtsara wa Tsatsu pri school" 10 "Sahajanad Special School" 11 "Timboni Special school" 12 "Vilakwe Pri School" 13 "Daua Integrated Primary" 14 "Kamor Integrated Primary" 15 "Mandera DEB Primary" 16 "Mandera Special School for the Blind" 17 "Shashafey Integrated Primary" 18 "Al- Hidaya Muslim Primary" 19 "Kiwanja Ndege Primary School" 20 "Logologo Integrated Primary School" 21 "St. Johns Primary" 22 "St. Theresa Girls Primary" 23 "Lkurroto Primary School" 24 "Maralal DEB Primary" 25 "Ntepes Primary School" 26 "Seneya Special Primary School" 27 "St. Pauls Integrated Primary School" 28 "kakuma arid zone" 29 "Kakuma mixed primary" 30 "Nationokar primary" 31 "Barwaqo Girls Integrated Primary" 32 "Catholic Integrated Primary and Juniour School" 33 "Got-Ade Primary School" 34 "ICF Integrated Primary School -" 35 "Kalkacha Primary School" 36 "Volunteer Primary and Junior School" 37 "Wajir Township Primary" 38 "Misanga FYM Primary" 39 "Mukhuyu FYM Primary" 40 "Mupeli DEB Primary" 41 "Musikoma RCPrimary" 42 "Sacred Heart Misikhu RC Boys Primary"

lab values School_name school_id

save "Long format\main LBB Screener.dta",replace

*************************************************************************

*************************************************************************

*conector to SET_OF_B3_rpt section B3
cls
clear all
***import dataset B section

import spss using "Long format\UNICEF School Screener Questionnaire_Headteacher-Questionnaire-SECTION_B-B3_rpt.sav", clear

merge m:m SET_OF_B3_rpt using "Long format\main LBB Screener.dta"

order KEY PARENT_KEY INT_DATE - B3_rpt_count B3_total  B3_calc1 - B3_grade_total

*B3_calc1
label define grade_id 1 "PP1" 2 "PP2" 3 "Grade 1" 4 "Grade 2" 5 "Grade 3" 6 "Grade 4" 7 "Grade 5" 8 "Grade 6" 9 "Grade 7" 10 "Grade 8" 11 "Grade 9"

ren B3_calc2 B3_Grade_level
destring B3_Grade_level,replace
lab values B3_Grade_level grade_id
lab var B3_Grade_level"B3. What is the total enrolment per grade? Please tell me the total enrolment for boys and girls"

ren B3_calc1 B3_Grade_iteration
destring B3_Grade_iteration,replace
lab var B3_Grade_iteration"The position number of Grade iteration"

drop B3_calc3

ren B3_grade_total B3_Grade_total
destring B3_Grade_total,replace

lab var B3_rpt_count"How many iterations"

drop _merge
save "Long format\Merged data with B3 sorted.dta",replace


*conector to SET_OF_C2_rpt section C2
cls
clear all
***import dataset C section

import spss using "Long format\UNICEF School Screener Questionnaire_Headteacher-Questionnaire-SECTION_C-C2_rpt.sav", clear

drop VI_confirm
label drop labels0

merge m:m SET_OF_C2_rpt using "Long format\Merged data with B3 sorted.dta"

*C2_calc1
ren C2_calc2 C2_Grade_level
destring C2_Grade_level,replace
lab values C2_Grade_level grade_id
lab var C2_Grade_level"C2. Please tell me the total number of learners with visual impairment in each grade"

drop C2_calc3

ren C2_calc1 C2_Grade_iteration
destring C2_Grade_iteration,replace
lab var C2_Grade_iteration"The position number of Grade iteration"

ren (total_calc1 total_calc2) (C2_total B3_C2_total)
destring C2_total B3_C2_total,replace

drop KEY

order C2_Grade_iteration C2_Grade_level C2a_1 C2a_2 C2b_1 C2b_2 C2c_1 C2c_2 C2d_1 C2d_2 C2e_1 C2e_2 C2_total B3_C2_total SET_OF_C2_rpt, after(C2_rpt_count)

*drop test data
drop if INT_DATE < td(03Mar2026)

*Sort B1
split B1, parse(" ") gen(B1_1_)

foreach var of varlist B1_1_* {
	destring `var',replace
    label values `var' grade_id
	decode `var', gen(`var'_new)
}

foreach var of varlist B1_1_*_new {
    replace `var' = "" if trim(`var') == "" | missing(`var')
}

gen B1_values = ""

foreach var of varlist B1_1_*_new {
    replace B1_values = ///
        cond(missing(B1_values) | B1_values=="", ///
            `var', ///
            cond(`var'=="", ///
                B1_values, ///
                B1_values + ", " + `var'))
}

drop B1_1_1_new - B1_1_11_new B1_1_1 - B1_1_11 _merge

order B1_values,after(B1)
lab var B1_values"B1. Education levels offered:"

*Sort E1
lab define e1 1	"Braille textbooks" ///
2	"Large print materials" ///
3	"Tactile learning materials" ///
4	"Audio learning materials" ///
96	"Others (specify)" ///
99	"None"

split E1, parse(" ") gen(E1_1_)

foreach var of varlist E1_1_* {
	destring `var',replace
    label values `var' e1
	decode `var', gen(`var'_new)
}

foreach var of varlist E1_1_*_new {
    replace `var' = "" if trim(`var') == "" | missing(`var')
}

gen E1_values = ""

foreach var of varlist E1_1_*_new E1_S{
    replace E1_values = ///
        cond(missing(E1_values) | E1_values=="", ///
            `var', ///
            cond(`var'=="", ///
                E1_values, ///
                E1_values + ", " + `var'))
}

drop E1_1_1_new - E1_1_5_new E1_1_1 - E1_1_5

order E1_values,after(E1)
lab var E1_values"E1. Which adapted learning material are available in this school:"

*E2
lab define e2 1	"Braille machines/slates" ///
2	"Magnifiers" ///
3	"White canes" ///
96	"Others (specify)" ///
99	"None"

split E2, parse(" ") gen(E2_1_)

foreach var of varlist E2_1_* {
	destring `var',replace
    label values `var' e2
	decode `var', gen(`var'_new)
}

foreach var of varlist E2_1_*_new {
    replace `var' = "" if trim(`var') == "" | missing(`var')
}

gen E2_values = ""

foreach var of varlist E2_1_*_new E2_S{
    replace E2_values = ///
        cond(missing(E2_values) | E2_values=="", ///
            `var', ///
            cond(`var'=="", ///
                E2_values, ///
                E2_values + ", " + `var'))
}

// drop E2_1_1_new - E2_1_5_new E2_1_1 - E2_1_5

order E2_values,after(E2)
lab var E2_values"E2. Which assistive devices are available:"

*E3
lab define e3 1	"Accessible pathways" ///
2	"Adequate classroom lighting" ///
3	"Safe classroom layout" ///
4	"Ramps/handrails" ///
5	"Accessible toilets" ///
96	"Others (specify)" ///
99	"None"


split E3, parse(" ") gen(E3_1_)

foreach var of varlist E3_1_* {
	destring `var',replace
    label values `var' e3
	decode `var', gen(`var'_new)
}

foreach var of varlist E3_1_*_new {
    replace `var' = "" if trim(`var') == "" | missing(`var')
}

gen E3_values = ""

foreach var of varlist E3_1_*_new E3_S{
    replace E3_values = ///
        cond(missing(E3_values) | E3_values=="", ///
            `var', ///
            cond(`var'=="", ///
                E3_values, ///
                E3_values + ", " + `var'))
}

// drop E3_1_1_new - E3_1_5_new E2_1_1 - E2_1_5

order E3_values,after(E3)
lab var E3_values"E3. Which accessible features are available in this school?:"

destring B3_total,replace

*Corrections in data
*Iftin school
*PP2
replace B3b = 192 if PARENT_KEY == "uuid:191166f6-2de1-4cd8-91bb-95d108812ea4" & B3_Grade_level == 2

*G1
replace B3b = 238 if PARENT_KEY == "uuid:191166f6-2de1-4cd8-91bb-95d108812ea4" & B3_Grade_level == 3

*G2
replace B3b = 221 if PARENT_KEY == "uuid:191166f6-2de1-4cd8-91bb-95d108812ea4" & B3_Grade_level == 4

*G3
replace B3b = 219 if PARENT_KEY == "uuid:191166f6-2de1-4cd8-91bb-95d108812ea4" & B3_Grade_level == 5

*G4
replace B3b = 175 if PARENT_KEY == "uuid:191166f6-2de1-4cd8-91bb-95d108812ea4" & B3_Grade_level == 6

*G5
replace B3b = 162 if PARENT_KEY == "uuid:191166f6-2de1-4cd8-91bb-95d108812ea4" & B3_Grade_level == 7

*G6
replace B3b = 149 if PARENT_KEY == "uuid:191166f6-2de1-4cd8-91bb-95d108812ea4" & B3_Grade_level == 8

*G7
replace B3b = 194 if PARENT_KEY == "uuid:191166f6-2de1-4cd8-91bb-95d108812ea4" & B3_Grade_level == 9

*G8
replace B3b = 183 if PARENT_KEY == "uuid:191166f6-2de1-4cd8-91bb-95d108812ea4" & B3_Grade_level == 10

*G9
replace B3b = 186 if PARENT_KEY == "uuid:191166f6-2de1-4cd8-91bb-95d108812ea4" & B3_Grade_level == 11

*Loukitang school
*PP1
replace B3b = 143 if PARENT_KEY == "uuid:5e5d6d62-8b45-4ed5-a0ec-ed8a77aa1acb" & B3_Grade_level == 1

*PP2
replace B3a = 151 if PARENT_KEY == "uuid:5e5d6d62-8b45-4ed5-a0ec-ed8a77aa1acb" & B3_Grade_level == 2
replace B3b = 145 if PARENT_KEY == "uuid:5e5d6d62-8b45-4ed5-a0ec-ed8a77aa1acb" & B3_Grade_level == 2

*G1
replace B3a = 202 if PARENT_KEY == "uuid:5e5d6d62-8b45-4ed5-a0ec-ed8a77aa1acb" & B3_Grade_level == 3
replace B3b = 174 if PARENT_KEY == "uuid:5e5d6d62-8b45-4ed5-a0ec-ed8a77aa1acb" & B3_Grade_level == 3

*G2
replace B3a = 179 if PARENT_KEY == "uuid:5e5d6d62-8b45-4ed5-a0ec-ed8a77aa1acb" & B3_Grade_level == 4
replace B3b = 182 if PARENT_KEY == "uuid:5e5d6d62-8b45-4ed5-a0ec-ed8a77aa1acb" & B3_Grade_level == 4

*G3
replace B3a = 180 if PARENT_KEY == "uuid:5e5d6d62-8b45-4ed5-a0ec-ed8a77aa1acb" & B3_Grade_level == 5
replace B3b = 168 if PARENT_KEY == "uuid:5e5d6d62-8b45-4ed5-a0ec-ed8a77aa1acb" & B3_Grade_level == 5

*G4
replace B3a = 173 if PARENT_KEY == "uuid:5e5d6d62-8b45-4ed5-a0ec-ed8a77aa1acb" & B3_Grade_level == 6
replace B3b = 168 if PARENT_KEY == "uuid:5e5d6d62-8b45-4ed5-a0ec-ed8a77aa1acb" & B3_Grade_level == 6

*G6
replace B3a = 182 if PARENT_KEY == "uuid:5e5d6d62-8b45-4ed5-a0ec-ed8a77aa1acb" & B3_Grade_level == 8
replace B3b = 148 if PARENT_KEY == "uuid:5e5d6d62-8b45-4ed5-a0ec-ed8a77aa1acb" & B3_Grade_level == 8

*Totals summation
*Grade level total
gen B3_G_total = B3a + B3b

replace B3_Grade_total = B3_G_total
ghjg
*Total students ///Run this line manually.

bysort School_name: egen B2_tots = total(B3_Grade_total)

replace B2 = B2_tots
replace B3_total = B2_tots

drop B2_tots B3_G_total

*categorise the levels by PP1 - PP2; G1 - G2 ; G3 - G9
lab define c2s_lv 1"PP1 - PP2" 2 "G1 - G2" 3 "G3 - G9"

gen grade_categ = .
replace grade_categ = 1 if C2_Grade_level == 1 | C2_Grade_level == 2
replace grade_categ = 2 if C2_Grade_level == 3 | C2_Grade_level == 4
replace grade_categ = 3 if C2_Grade_level == 5 | C2_Grade_level == 6 | C2_Grade_level == 7 | C2_Grade_level == 8 | C2_Grade_level == 9 | C2_Grade_level == 10 | C2_Grade_level == 11

lab values grade_categ c2s_lv

sdadsf
*Total based on the new categorise
bysort School_name grade_categ: egen C2_tots = total(C2_total)


br School_name C2_Grade_level C2_total grade_categ C2_tots

*Add missing data

replace RES_POSITION = 1 if inlist(PARENT_KEY,"uuid:191166f6-2de1-4cd8-91bb-95d108812ea4","uuid:5e5d6d62-8b45-4ed5-a0ec-ed8a77aa1acb","uuid:0c104b28-e03b-4eff-9d12-ca7be4d89cad","uuid:95656b48-9c35-468e-adef-49848860e1ee")

replace RES_PHONE = "726210678" if inlist(PARENT_KEY,"uuid:191166f6-2de1-4cd8-91bb-95d108812ea4")

replace RES_PHONE = "719652374" if inlist(PARENT_KEY,"uuid:5e5d6d62-8b45-4ed5-a0ec-ed8a77aa1acb")

replace RES_PHONE = "720321590" if inlist(PARENT_KEY,"uuid:0c104b28-e03b-4eff-9d12-ca7be4d89cad")

replace RES_PHONE = "728491300" if inlist(PARENT_KEY,"uuid:95656b48-9c35-468e-adef-49848860e1ee")

replace RES_NAME = "Boniface Lonyait" if PARENT_KEY == "uuid:95656b48-9c35-468e-adef-49848860e1ee"

replace Sub_county = "Fafi" if PARENT_KEY == "uuid:191166f6-2de1-4cd8-91bb-95d108812ea4"
replace Sub_county = "Daadab" if PARENT_KEY == "uuid:5e5d6d62-8b45-4ed5-a0ec-ed8a77aa1acb"
replace Sub_county = "Samburu Central" if inlist(PARENT_KEY,"uuid:0c104b28-e03b-4eff-9d12-ca7be4d89cad","uuid:95656b48-9c35-468e-adef-49848860e1ee")

replace EMIS = "Q9JX" if PARENT_KEY == "uuid:95656b48-9c35-468e-adef-49848860e1ee"

*Jaribu school
drop if PARENT_KEY == "uuid:84ecfe9f-9654-4a0e-a4d9-293cabc054d5"

*On hold Sahajanad Special School //awaiting the data from other platform
drop if PARENT_KEY == "uuid:9bc21eb3-8dc7-4814-8a17-713bf13656ef"

drop total_vi_boys	total_vi_girls	total_boys	total_girls E2_1_1	E2_1_2	E2_1_1_new	E2_1_2_new	E3_1_1	E3_1_2	E3_1_3	E3_1_4	E3_1_5	E3_1_1_new	E3_1_2_new	E3_1_3_new	E3_1_4_new	E3_1_5_new

drop g1_vi_total g2_vi_total G1_VI_count SET_OF_G1_VI G2_VI_count	SET_OF_G2_VI

save "Long format\LBB Screener Headteacher dataset.dta",replace
export excel using "Long format\LBB Screener Headteacher dataset.xlsx", sheetreplace firstrow(variables)

*Add VIs
***Pull VIs.
cls
clear all
use "Long format\LBB Screener Headteacher dataset.dta"

merge m:m School_name C2_Grade_level using "C:\Users\oyoo\OneDrive - Dalberg Global Development Advisors\QUALITY CONTROL\Projects\2026\Projects\UNICEF LBB\Main\Data\Raw\Student\VI\LBB Baseline for screener data VIs.dta" 

order School_name,after(Village)
order C2_Grade_level,after(C2_Grade_iteration)
order interview_ID,after(E2_1_3_new)
drop _merge CONSENT

ren interview_ID interview_ID_VIs

save "Long format\LBB Screener Headteacher-VIs dataset.dta",replace

***Pull NON-VIs.
cls
clear all
use "C:\Users\oyoo\OneDrive - Dalberg Global Development Advisors\QUALITY CONTROL\Projects\2026\Projects\UNICEF LBB\Main\Data\Raw\Student\Non VI\LBB Baseline for screener data NON-VIs.dta"

merge m:m School_name C2_Grade_level using "Long format\LBB Screener Headteacher-VIs dataset.dta" 

order School_name,after(Village)
order C2_Grade_level,after(C2_Grade_iteration)
order interview_ID,after(interview_ID_VIs)

drop _merge CONSENT

ren interview_ID interview_ID_NON_VIs

lab values C2_Grade_level grade_id

*drop Jaribu school
// drop if School_name == 2
gen VI_done = "Yes"
replace VI_done = "No" if missing(interview_ID_VIs)

gen Non_VI_done = "Yes"
replace Non_VI_done = "No" if missing(interview_ID_NON_VIs)

replace EMIS = "TBC" if School_name == 23

save "Long format\LBB Screener Headteacher-VIs-NON-VIs dataset.dta",replace

***Pull Teachers. -- How to connect Teachers and Observations without matching 1:1
cls
clear all
use "Long format\LBB Screener Headteacher-VIs-NON-VIs dataset.dta"

mmerge School_name using "C:\Users\oyoo\OneDrive - Dalberg Global Development Advisors\QUALITY CONTROL\Projects\2026\Projects\UNICEF LBB\Main\Data\Raw\Teachers\Teacher LBB Baseline Screener data.dta" 

drop _merge

gen Teacher_done = "Yes"
replace Teacher_done = "No" if missing(interview_ID_Teachers)

save "Long format\LBB Screener Headteacher-VIs-NON-VIs-Teachers dataset.dta",replace

***Pull Classroom.
cls
clear all
use "Long format\LBB Screener Headteacher-VIs-NON-VIs-Teachers dataset.dta"

mmerge School_name using "C:\Users\oyoo\OneDrive - Dalberg Global Development Advisors\QUALITY CONTROL\Projects\2026\Projects\UNICEF LBB\Main\Data\Raw\Classroom\Classroom LBB Baseline Screener data.dta" 

drop _merge

gen Class_done = "Yes"
replace Class_done = "No" if missing(interview_ID_Classroom)

order grade_categ C2_tots, after(Class_done)

*Sahajanad	
replace County = 4 if School_name == 10
replace Sub_county = "Kilifi South" if School_name == 10

*Jaribu
replace County = 1 if School_name == 2

*sum for each category of visual
gen  Blind = .
replace Blind = C2a_1 + C2a_2 if !missing(C2a_1) & !missing(C2a_2)

gen  Low_vis_large_print = .
replace Low_vis_large_print = C2b_1 + C2b_2 if !missing(C2b_1) & !missing(C2b_2)

gen Low_vis_magnifying_glass = .
replace Low_vis_magnifying_glass = C2c_1 + C2c_2 if !missing(C2c_1) & !missing(C2c_2)

gen Low_vis_donot_glass = .
replace Low_vis_donot_glass = C2d_1 + C2d_2 if !missing(C2d_1) & !missing(C2d_2)

gen Low_vis_glass = .
replace Low_vis_glass = C2e_1 + C2e_2 if !missing(C2e_1) & !missing(C2e_2)

gen tot_low_vis = .
replace tot_low_vis = Low_vis_large_print + Low_vis_magnifying_glass + Low_vis_donot_glass + Low_vis_glass

gen cat_vision = .

replace cat_vision = 1 if Blind > 0 & tot_low_vis == 0 & !missing(Blind)
replace cat_vision = 2 if Blind > 0 & tot_low_vis > 0 & !missing(Blind) & !missing(tot_low_vis)
replace cat_vision = 3 if Blind == 0 & tot_low_vis > 0
replace cat_vision = 4 if Blind == 0 & tot_low_vis == 0

lab define cts_vis 1"Only Blind" 2"Blind and Low vision" 3"Only Low vision" 4"No Blind and Low vision"

lab values cat_vision cts_vis


save "Long format\LBB Screener Headteacher-VIs-NON-VIs-Teachers-Class dataset.dta",replace
export excel using "Long format\LBB Screener Headteacher-VIs-NON-VIs-Teachers-Class dataset.xlsx", sheetreplace firstrow(variables)




