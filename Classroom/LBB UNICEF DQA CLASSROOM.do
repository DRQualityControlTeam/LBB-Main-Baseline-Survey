
********************************************************************************
* PROJECT: LBB Classroom Questionnaire - Quality Control (QC)
********************************************************************************
**Setting the working directory
cls
clear all
cd "C:\Users\oyoo\OneDrive - Dalberg Global Development Advisors\QUALITY CONTROL\Projects\2026\Projects\UNICEF LBB\Main\Data\Raw\Classroom"

***import dataset
import spss using "UNICEF Classroom Observation_WIDE.sav", clear

**Converting date to stata format calender
// *sort time and date
replace INT_DATE = dofc(INT_DATE)
format INT_DATE %td

lab var INT_DATE"Interview Date"

drop if INT_DATE<td(02Mar2026)

*Time.
gen str8 START_TIME_str = string(START_TIME, "%tcHH:MM:SS")
gen str8 END_TIME_str   = string(END_TIME,   "%tcHH:MM:SS")

*dropping irrelevant variables
drop SubmissionDate starttime endtime deviceid devicephonenum username device_info caseid password

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

lab values County cnty_lbl

*School
label define school_lbl 1 "Iftin Integrated Primary" 2 "Jaribu Primary" 3 "Chief Muturi Integrated Primary" 4 "Enchurrai" 5 "Kikelelwa Integrated Primary" 6 "Lokitang Primary" 7 "Kakuma Placeholder School" 8 "Kibarani Integrated" 9 "Mtsara wa Tsatsu Pri School" 10 "Sahajanad Special School" 11 "Timboni Special School" 12 "Vilakwe Pri School" 13 "Daua Integrated Primary" 14 "Kamor Integrated Primary" 15 "Mandera DEB Primary" 16 "Mandera Special School for the Blind" 17 "Shashafey Integrated Primary" 18 "Al-Hidaya Muslim Primary" 19 "Kiwanja Ndege Primary School" 20 "Logologo Integrated Primary School" 21 "St. Johns Primary" 22 "St. Theresa Girls Primary" 23 "Lkurroto Primary School" 24 "Maralal DEB Primary" 25 "Ntepes Primary School" 26 "Seneya Special Primary School" 27 "St. Pauls Integrated Primary School" 28 "Kakuma Arid Zone" 29 "Kakuma Mixed Primary" 30 "Nationokar Primary" 31 "Barwaqo Girls Integrated Primary" 32 "Catholic Integrated Primary and Junior School" 33 "Got-Ade Primary School" 34 "ICF Integrated Primary School" 35 "Kalkacha Primary School" 36 "Volunteer Primary and Junior School" 37 "Wajir Township Primary" 38 "Misanga FYM Primary" 39 "Mukhuyu FYM Primary" 40 "Mupeli DEB Primary" 41 "Musikoma RC Primary" 42 "Sacred Heart Misikhu RC Boys Primary"

lab values  School_name school_lbl

save "Classroom LBB Baseline Processed data.dta",replace

//checks-Flaggings
***************************************************************************************
cd "C:\Users\oyoo\OneDrive - Dalberg Global Development Advisors\QUALITY CONTROL\Projects\2026\Projects\UNICEF LBB\Main\Quality Control Sheets"

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

global var_kept "KEY INT_DATE START_TIME END_TIME ENUM_NAME County School_name School_description SUBJECT SUBJECT_S"

** generate a Comment based on the issue raised
gen issue_comment = ""

*Duration check in minutes
preserve
gen duration_mins = duration / 60
replace issue_comment ="interview duration is *Longer* or *Shorter*, kindly clarify"
keep if !inrange(duration_mins,5,15)
cap export excel $var_kept duration_mins issue_comment using "LBB DQA Classroom ${dates}.xlsx", sheet(duration_issues,replace)firstrow(variables)
restore

*Lag time check

*Step 2: Sort by enumerator and time
bysort INT_DATE ENUM_NAME (START_TIME): gen gap_mins = (START_TIME - END_TIME[_n-1]) / 60000 if _n > 1

preserve
replace issue_comment ="Time taken to the next interview is way wierd, seems the interview started earlier or overlapped the other interview, kindly clarify"
keep if !inrange(gap_mins,0,60)
cap export excel $var_kept gap_mins issue_comment using "LBB DQA Classroom ${dates}.xlsx", sheet(lag_time_issues,replace)firstrow(variables)
restore

*GPS Accuracy
preserve
replace issue_comment = "The GPS Accuracy is way low, kindly clarify"
keep if GPS_Accuracy > 20 & !missing(GPS_Accuracy)
cap export excel $var_kept GPS_Accuracy issue_comment using "LBB DQA Classroom ${dates}.xlsx",sheet(GPS_issues,replace)firstrow(variables)
restore



*Duplicate GPS
duplicates tag GPS_Latitude GPS_Longitude GPS_Altitude,gen(dup1)

preserve
replace issue_comment = "The interview is done on the same point of location, kindly clarify"
keep if dup1 > 0
cap export excel $var_kept GPS_Latitude GPS_Longitude GPS_Altitude issue_comment using "LBB DQA Classroom ${dates} .xlsx",sheet(GPS_Dups_issues,replace)firstrow(variables)
restore


*Duplicate observations
preserve
    replace issue_comment = "Possible duplicate observation (same school, grade, subject, date)"
    duplicates tag School_name GRADE SUBJECT INT_DATE, gen(dup_obs)
    keep if dup_obs > 0
 cap export excel $var_kept dup_obs issue_comment using "LBB DQA Classroom ${dates}.xlsx", sheet(Duplicate_Observations, replace) firstrow(variables)
restore




*Enumerator productivity (too many observations in one day)
preserve
    bysort ENUM_NAME INT_DATE: gen n_obs = _N
    replace issue_comment = "Enumerator conducted more than 5 observations on a single day"
    keep if n_obs > 5
 cap export excel $var_kept n_obs issue_comment using "LBB DQA Classroom ${dates}.xlsx", sheet(High_Productivity, replace) firstrow(variables)
restore




*Weekend observations
preserve
    gen dow = dow(INT_DATE)
    replace issue_comment = "Observation conducted on weekend"
    keep if inlist(dow, 0, 6)
 cap export excel $var_kept INT_DATE dow issue_comment using "LBB DQA Classroom  ${dates}.xlsx", sheet(Weekend_Observations, replace) firstrow(variables)
restore



* B1a should equal B1b + B1c
preserve
    replace issue_comment = "Total learners (B1a) does not equal VI + non‑VI (B1b+B1c)"
    keep if !missing(B1a) & !missing(B1b) & !missing(B1c) & B1a != B1b + B1c
    cap export excel $var_kept B1a B1b B1c issue_comment using "LBB DQA Classroom ${dates}.xlsx", sheet(ClassSize_Inconsistent, replace) firstrow(variables)
restore


*check for very short responses (notes)
local text_vars "B6 C4 D4 E5 H3 General_Comments"
foreach var of local text_vars {
    capture confirm variable `var'
    if !_rc {
        preserve
            replace issue_comment = "`var' text response too short (<5 characters)"
            keep if strlen(trim(`var')) < 5 & !missing(`var')
     cap export excel $var_kept `var' issue_comment using "LBB DQA Classroom ${dates}.xlsx", sheet(Short_`var', replace) firstrow(variables)
        restore
    }
}




* H1_S (challenges other)
preserve
    replace issue_comment = "Other challenge specified but text too short (<3 characters)"
    keep if H1_96 == 1 & (strlen(trim(H1_S)) < 3 | missing(H1_S))
    cap export excel $var_kept H1_96 H1_S issue_comment using "LBB DQA Classroom ${dates}.xlsx", sheet(H1_Other_Short, replace) firstrow(variables)
restore



* H2_S (enablers other)
preserve
    replace issue_comment = "Other enabler specified but text too short (<3 characters)"
    keep if H2_96 == 1 & (strlen(trim(H2_S)) < 3 | missing(H2_S))
   cap export excel $var_kept H2_96 H2_S issue_comment using "LBB DQA Classroom ${dates}.xlsx", sheet(H2_Other_Short, replace) firstrow(variables)
restore














