
********************************************************************************
* PROJECT: LBB Teacher Questionnaire - Quality Control (QC)
********************************************************************************

**Setting the working directory
cls
clear all
cd "C:\Users\oyoo\OneDrive - Dalberg Global Development Advisors\QUALITY CONTROL\Projects\2026\Projects\UNICEF LBB\Main\Data\Raw\Teachers"

***import dataset
import spss using "Teacher LBB Baseline Study_WIDE.sav", clear


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
drop SubmissionDate username starttime endtime deviceid devicephonenum device_info caseid password Enum_calc instanceID formdef_version


*Dropping unconsented interviews.
drop if Consent == 0

order KEY

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

save "Teacher LBB Baseline Processed data.dta",replace

*checks-Flaggings
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

global var_kept "KEY INT_DATE START_TIME END_TIME ENUM_NAME County School_description RES_NAME RES_PHONE B4"

** generate a Comment based on the issue raised
gen issue_comment = ""


*Duration check in minutes
preserve
gen duration_mins = duration / 60
replace issue_comment ="interview duration is *Longer* or *Shorter*, kindly clarify"
keep if !inrange(duration_mins,25,45)
cap export excel $var_kept duration_mins issue_comment using "LBB DQA Teachers ${dates}.xlsx", sheet(duration_issues,replace)firstrow(variables)
restore



*Lag time check

*Step 2: Sort by enumerator and time
bysort INT_DATE ENUM_NAME (START_TIME): gen gap_mins = (START_TIME - END_TIME[_n-1]) / 60000 if _n > 1

preserve
replace issue_comment ="Time taken to the next interview is way wierd, seems the interview started earlier or overlapped the other interview, kindly clarify"
keep if !inrange(gap_mins,0,20)
cap export excel $var_kept gap_mins issue_comment using "LBB DQA Teachers ${dates}.xlsx", sheet(lag_time_issues,replace)firstrow(variables)
restore



*GPS Accuracy
preserve
replace issue_comment = "The GPS Accuracy is way low, kindly clarify"
keep if GPS_Accuracy > 20 & !missing(GPS_Accuracy)
cap export excel $var_kept GPS_Accuracy issue_comment using "LBB DQA Teachers ${dates} .xlsx",sheet(GPS_issues,replace)firstrow(variables)
restore




*Duplicate GPS
duplicates tag GPS_Latitude GPS_Longitude GPS_Altitude,gen(dup1)

preserve
replace issue_comment = "The interview is done on the same point of location, kindly clarify"
keep if dup1 > 0
cap export excel $var_kept GPS_Latitude GPS_Longitude GPS_Altitude issue_comment using "LBB DQA Teachers ${dates} .xlsx",sheet(GPS_Dups_issues,replace)firstrow(variables)
restore



**Respondent Name
preserve
replace issue_comment = "The Respondent name seems invalid, kindly clarify"
keep if strlen(RES_NAME) < 3 | missing(RES_NAME)
cap export excel $var_kept RES_NAME issue_comment using "LBB DQA Teachers ${dates} .xlsx",sheet(RES_NAME_issues,replace)firstrow(variables)
restore



//phone number duplicates Flaggings
preserve
replace issue_comment = "Duplicate phone number found"
* Check variable exists
capture confirm variable RES_PHONE
if !_rc {
       gen clean_phone = ustrregexra(RES_PHONE, "[^0-9]", "")
* Remove obviously invalid numbers (too short/long)
    replace clean_phone = "" if strlen(clean_phone) < 9  // Too short
    replace clean_phone = "" if strlen(clean_phone) > 12 // Too long
    duplicates tag clean_phone, gen(dup_count)
        keep if dup_count > 0 & !missing(clean_phone) & clean_phone != ""
        if _N > 0 {
        export excel $var_kept RES_NAME RES_PHONE clean_phone dup_count issue_comment using "LBB DQA Teachers ${dates}.xlsx", sheet("Duplicate_Phones", replace) firstrow(variables)
    }
}
else {
    display "RES_PHONE variable not found - skipping phone checks"
}
restore



// Check duplicates by teacher name and school for duplicate interviews
preserve
replace issue_comment = "Possible duplicate submission"
duplicates tag School_name RES_NAME, gen(dup_count)
keep if dup_count > 0
cap export excel $var_kept School_name RES_NAME  dup_count issue_comment using "LBB DQA Teachers ${dates}.xlsx", sheet("Interview_Duplicates", replace) firstrow(variables)
restore


// Outlier check for variable B6
// Outlier check PP1 CLASS SIZE (>100 students = unrealistic)

preserve
replace issue_comment = "PP1 class has >100 students please verify"
keep if B5_1 == 1
gen total_pp1 = B6_PP1_1 + B6_PP1_2
keep if total_pp1 > 100 & !missing(total_pp1)
if _N > 0 {
  export excel $var_kept   B6_PP1_1 B6_PP1_2 total_pp1 issue_comment using "LBB DQA Teachers ${dates}.xlsx", sheet("PP1_Over100", replace) firstrow(variables)
}
restore


// Outlier check PP2 CLASS SIZE (>100 students = unrealistic)
preserve
replace issue_comment = "PP2 class has >100 students, please verify"
keep if B5_2 == 1
gen total_pp2 = B6_PP2_1 + B6_PP2_2
keep if total_pp2 > 100 & !missing(total_pp2)
if _N > 0 {
 export excel $var_kept  B6_PP2_1 B6_PP2_2 total_pp2 issue_comment using "LBB DQA Teachers ${dates}.xlsx", sheet("PP2_Over100", replace) firstrow(variables)
}
restore



// Outlier check GRADE 1 CLASS SIZE (>100 students = unrealistic)
preserve
replace issue_comment = "Grade 1 class has >100 students please verify"
keep if B5_3 == 1
gen total_grade1 = B6_Grade1_1 + B6_Grade1_2
keep if total_grade1 > 100 & !missing(total_grade1)
if _N > 0 {
  export excel $var_kept B6_Grade1_1 B6_Grade1_2 total_grade1 issue_comment using "LBB DQA Teachers ${dates}.xlsx", sheet("Grade1_Over100", replace) firstrow(variables)
}
restore


//  Outlier check GRADE 2 CLASS SIZE (>100 students = unrealistic)
preserve
replace issue_comment = "Grade 2 class has >100 students please verify"
keep if B5_4 == 1
gen total_grade2 = B6_Grade2_1 + B6_Grade2_2
keep if total_grade2 > 100 & !missing(total_grade2)
if _N > 0 {
    export excel $var_kept B6_Grade2_1 B6_Grade2_2 total_grade2 issue_comment using "LBB DQA Teachers ${dates}.xlsx", sheet("Grade2_Over100", replace) firstrow(variables)
}
restore


// Outlier check for variable B7
// CHECK 1: PP1 VI LEARNERS (>100 = unrealistic)
preserve
replace issue_comment = "PP1 has >100 visually impaired learners please verify"
keep if B5_1 == 1
gen total_vi_pp1 = B7_PP1_1 + B7_PP1_2
keep if total_vi_pp1 > 100 & !missing(total_vi_pp1)
if _N > 0 {
    export excel $var_kept B7_PP1_1 B7_PP1_2 total_vi_pp1 issue_comment using "LBB DQA Teachers ${dates}.xlsx", sheet("PP1_VI_Over100", replace) firstrow(variables)
}
restore



// CHECK 2 PP2 VI LEARNERS (>100 = unrealistic)
preserve
replace issue_comment = "PP2 has >100 visually impaired learners please verify"
keep if B5_2 == 1
gen total_vi_pp2 = B7_PP2_1 + B7_PP2_2
keep if total_vi_pp2 > 100 & !missing(total_vi_pp2)
if _N > 0 {
    export excel $var_kept B7_PP2_1 B7_PP2_2 total_vi_pp2 issue_comment using "LBB DQA Teachers ${dates}.xlsx", sheet("PP2_VI_Over100", replace) firstrow(variables)
}
restore



// CHECK 3: Grade1 VI LEARNERS (>100 = unrealistic)
preserve
replace issue_comment = "Grade1 has >100 visually impaired learners please verify"
keep if B5_3 == 1
gen total_vi_grade1 = B7_Grade1_1 + B7_Grade1_2
keep if total_vi_grade1 > 100 & !missing(total_vi_grade1)
if _N > 0 {
    export excel $var_kept B7_Grade1_1 B7_Grade1_2 total_vi_grade1 issue_comment using "LBB DQA Teachers ${dates}.xlsx", sheet("Grade1_VI_Over100", replace) firstrow(variables)
}
restore


// CHECK 4: Grade2 VI LEARNERS (>100 = unrealistic)
preserve
replace issue_comment = "Grade2 has >100 visually impaired learners please verify"
keep if B5_4 == 1
gen total_vi_grade2 = B7_Grade2_1 + B7_Grade2_2
keep if total_vi_grade2 > 100 & !missing(total_vi_grade2)
if _N > 0 {
    export excel $var_kept B7_Grade2_1 B7_Grade2_2 total_vi_grade2 issue_comment using "LBB DQA Teachers ${dates}.xlsx", sheet("Grade2_VI_Over100", replace) firstrow(variables)
}
restore



//Class Size Logic: B7 (VI learners) ≤ B6 (Total learners) - bonus check already handle by survey CTO
* Check for each grade separately
foreach grade in PP1 PP2 Grade1 Grade2 {
    preserve
    replace issue_comment = "VI learners (B7) > Total learners (B6) for `grade'"
    
    // Map grade to correct B5 variable
    if "`grade'" == "PP1" local b5_var = "B5_1"
    if "`grade'" == "PP2" local b5_var = "B5_2"
    if "`grade'" == "Grade1" local b5_var = "B5_3"
    if "`grade'" == "Grade2" local b5_var = "B5_4"
    
    // Generate totals for each grade ONLY if teacher teaches that grade
    gen total_`grade' = B6_`grade'_1 + B6_`grade'_2 if `b5_var' == 1
    gen vi_`grade' = B7_`grade'_1 + B7_`grade'_2 if `b5_var' == 1
    
    // Keep only problematic cases
    keep if `b5_var' == 1 & vi_`grade' > total_`grade' & !missing(vi_`grade') & !missing(total_`grade')
    
    // Export if any problems found
    if _N > 0 {
        export excel $var_kept B6_`grade'_1 B6_`grade'_2 B7_`grade'_1 B7_`grade'_2 issue_comment using "LBB DQA Teachers ${dates}.xlsx", sheet("ClassSize_`grade'_issues", replace) firstrow(variables)
    }
    restore
}


//2. Teaching Arrangement vs VI Learners (B11 vs B7)
preserve
replace issue_comment = "B11=4 (No VI learners) but reported VI learners in B7"
egen total_vi = rowtotal(B7_PP1_1 B7_PP1_2 B7_PP2_1 B7_PP2_2 B7_Grade1_1 B7_Grade1_2 B7_Grade2_1 B7_Grade2_2)
keep if B11 == 4 & total_vi > 0 & !missing(B11)
cap export excel $var_kept B11 total_vi issue_comment using "LBB DQA Teachers ${dates}.xlsx", sheet("B11 vs B7_Consistency", replace) firstrow(variables)
restore



// CHECK B14 - Years teaching in this school/unit
preserve
replace issue_comment = "B14: Years teaching in this school >50 (unrealistic)"
keep if B14 > 50 & !missing(B14)
if _N > 0 {
    export excel $var_kept B14 issue_comment using "LBB DQA Teachers ${dates}.xlsx", sheet("B14_Over50", replace) firstrow(variables)
}
restore


// CHECK B15 - Years teaching VI learners overall
preserve
replace issue_comment = "B15: Years teaching VI learners >50 (unrealistic)"
keep if B15 > 50 & !missing(B15)
if _N > 0 {
    export excel $var_kept B15 issue_comment using "LBB DQA Teachers ${dates}.xlsx", sheet("B15_Over50", replace) firstrow(variables)
}
restore


// CHECK 1 C2=1 (Trained) but no braille training selected but recorded advanced Braile skills in B13
preserve
replace issue_comment = "Reported training (C2=1) but no braille training (C3_2≠1) despite advanced braille skills recorded in B13"
keep if inrange(B13, 4, 5) & !missing(B13) & C2 == 1
* But didn't select braille training
keep if C3_2 != 1 & !missing(C3_2)
if _N > 0 {
    export excel $var_kept B13 C2 C3_2 issue_comment using "LBB DQA Teachers ${dates}.xlsx", sheet("Trained_No_Braille", replace) firstrow(variables)
}
restore


// CHECK 2: C2=2 (No training) but advanced braille skills in B13
preserve
replace issue_comment = "No training (C2=2) but has advanced braille skills (verify if self-taught)"
keep if inrange(B13, 4, 5) & !missing(B13) & C2 == 2
if _N > 0 {
    export excel $var_kept B13 C2 issue_comment using "LBB DQA Teachers ${dates}.xlsx", sheet("No_Training_Advancedskills", replace) firstrow(variables)
}
restore


// Outlier check  C4 variable > 104 weeks (2 years - unrealistic)
preserve
replace issue_comment = "Training duration >104 weeks (2+ years) - please verify"
gen flag_high_weeks = 0
foreach var in C4_1{
    replace flag_high_weeks = 1 if `var' > 104 & !missing(`var')
}
keep if flag_high_weeks == 1
if _N > 0 {
    export excel $var_kept C4_1 issue_comment using "LBB DQA Teachers ${dates}.xlsx", sheet("C4_Over_104_Weeks", replace) firstrow(variables)
}
restore


// LBB Familiarity vs Use (C6 vs C9)
preserve
replace issue_comment = "C6=1 (Never heard of LBB) but reports using it often (C9=4-5)"
keep if C6 == 1 & inrange(C9, 4, 5)
cap export excel $var_kept C6 C9 issue_comment using "LBB DQA Teachers ${dates}.xlsx", sheet("C6 vs C9_Consistency", replace) firstrow(variables)
restore


// OUTLIER CHECK: Book counts (D4, D6, D8) for each grade Flag if >100 books for any subject in any grade (unrealistic)


// BLOCK 1: CHECK ENGLISH BOOKS (D4 variables)
preserve
replace issue_comment = "Number of English books >100 (unrealistic for one class)"
gen flag_d4 = 0
* PP1 English books
replace flag_d4 = 1 if D4_PP1 > 100 & !missing(D4_PP1)
replace issue_comment = "PP1 English: " + string(D4_PP1) + " books" if D4_PP1 > 100 & !missing(D4_PP1)
* PP2 English books
replace flag_d4 = 1 if D4_PP2 > 100 & !missing(D4_PP2)
replace issue_comment = "PP2 English: " + string(D4_PP2) + " books" if D4_PP2 > 100 & !missing(D4_PP2)
* Grade 1 English books
replace flag_d4 = 1 if D4_Grade1 > 100 & !missing(D4_Grade1)
replace issue_comment = "Grade 1 English: " + string(D4_Grade1) + " books" if D4_Grade1 > 100 & !missing(D4_Grade1)
* Grade 2 English books
replace flag_d4 = 1 if D4_Grade2 > 100 & !missing(D4_Grade2)
replace issue_comment = "Grade 2 English: " + string(D4_Grade2) + " books" if D4_Grade2 > 100 & !missing(D4_Grade2)
* Keep only flagged cases
keep if flag_d4 == 1
if _N > 0 {
    export excel $var_kept D4_PP1 D4_PP2 D4_Grade1 D4_Grade2 issue_comment using "LBB DQA Teachers ${dates}.xlsx", sheet("D4_English_Books", replace) firstrow(variables)
}
restore


// BLOCK 2: CHECK KISWAHILI BOOKS (D6 variables)
preserve
replace issue_comment = "Number of Kiswahili books >100 (unrealistic for one class)"
gen flag_d6 = 0
* PP1 Kiswahili books
replace flag_d6 = 1 if D6_PP1 > 100 & !missing(D6_PP1)
replace issue_comment = "PP1 Kiswahili: " + string(D6_PP1) + " books" if D6_PP1 > 100 & !missing(D6_PP1)
* PP2 Kiswahili books
replace flag_d6 = 1 if D6_PP2 > 100 & !missing(D6_PP2)
replace issue_comment = "PP2 Kiswahili: " + string(D6_PP2) + " books" if D6_PP2 > 100 & !missing(D6_PP2)
* Grade 1 Kiswahili books
replace flag_d6 = 1 if D6_Grade1 > 100 & !missing(D6_Grade1)
replace issue_comment = "Grade 1 Kiswahili: " + string(D6_Grade1) + " books" if D6_Grade1 > 100 & !missing(D6_Grade1)
* Grade 2 Kiswahili books
replace flag_d6 = 1 if D6_Grade2 > 100 & !missing(D6_Grade2)
replace issue_comment = "Grade 2 Kiswahili: " + string(D6_Grade2) + " books" if D6_Grade2 > 100 & !missing(D6_Grade2)
* Keep only flagged cases
keep if flag_d6 == 1
if _N > 0 {
    export excel $var_kept D6_PP1 D6_PP2 D6_Grade1 D6_Grade2 issue_comment using "LBB DQA Teachers ${dates}.xlsx", sheet("D6_Kiswahili_Books", replace) firstrow(variables)
}
restore


// BLOCK 3: CHECK MATHEMATICS BOOKS (D8 variables)
preserve
replace issue_comment = "Number of Mathematics books >100 (unrealistic for one class)"
gen flag_d8 = 0
* PP1 Mathematics books
replace flag_d8 = 1 if D8_PP1 > 100 & !missing(D8_PP1)
replace issue_comment = "PP1 Math: " + string(D8_PP1) + " books" if D8_PP1 > 100 & !missing(D8_PP1)
* PP2 Mathematics books
replace flag_d8 = 1 if D8_PP2 > 100 & !missing(D8_PP2)
replace issue_comment = "PP2 Math: " + string(D8_PP2) + " books" if D8_PP2 > 100 & !missing(D8_PP2)
* Grade 1 Mathematics books
replace flag_d8 = 1 if D8_Grade1 > 100 & !missing(D8_Grade1)
replace issue_comment = "Grade 1 Math: " + string(D8_Grade1) + " books" if D8_Grade1 > 100 & !missing(D8_Grade1)
* Grade 2 Mathematics books
replace flag_d8 = 1 if D8_Grade2 > 100 & !missing(D8_Grade2)
replace issue_comment = "Grade 2 Math: " + string(D8_Grade2) + " books" if D8_Grade2 > 100 & !missing(D8_Grade2)
* Keep only flagged cases
keep if flag_d8 == 1
if _N > 0 {
    export excel $var_kept D8_PP1 D8_PP2 D8_Grade1 D8_Grade2 issue_comment using "LBB DQA Teachers ${dates}.xlsx", sheet("D8_Math_Books", replace) firstrow(variables)
}
restore

// // Treatment/Control Logic (Section G)
// preserve
// replace issue_comment = "Control school (Sch_Type=2) but answered LBB section G"
// // Check if any G-section variable has data
// gen g_section_answered = 0
// forvalues i = 1/12 {
//     capture confirm variable G`i'
//     if !_rc {
//         replace g_section_answered = 1 if !missing(G`i')
//     }
// }
//
// keep if Sch_Type == 2 & g_section_answered == 1
//
// cap export excel $var_kept Sch_Type G1 G2 G3 G4 G5 G6 G7 G8 G9 G10 G11 G12 issue_comment using "LBB DQA Teachers ${dates}.xlsx", sheet("Treatment_Control_Mix", replace) firstrow(variables)
// restore


// STRAIGHT-LINING CHECK FOR SECTION E ATTITUDINAL QUESTIONS
preserve
replace issue_comment = "Possible straight-lining (many extreme answers)"
local e_vars "E5 E6 E8 E9 E10 E11 E12 E13_1 E13_2 E13_3 E14 E15 E16 E17"
* Count extreme answers (1 or 5)
egen extreme_count = anycount(`e_vars'), values(1 5)
egen total_answered = rownonmiss(`e_vars')
* Keep only if: At least 10 questions answered and at least 80% are extreme
keep if total_answered >= 10 & (extreme_count / total_answered) >= 0.8
if _N > 0 {
    export excel $var_kept `e_vars' extreme_count total_answered issue_comment using "LBB DQA Teachers ${dates}.xlsx", sheet("Straight_Lining_SectionE", replace) firstrow(variables)
}
restore

// For Other specify questions
// CHECK 1: Text too short (<3 characters)
preserve
replace issue_comment = "Text response too short (<3 characters)"
local text_vars B4_S B5_S B9_S B10_PP1_S B10_PP2_S B10_Grade1_S B10_Grade2_S B11_S B16_S B17_S C1_S C3_S D2_S D10_S G4_S G8_S

gen flag_short = 0
gen short_vars = ""

foreach var in `text_vars' {
    capture confirm variable `var'
    if !_rc {
        gen temp = trim(`var')
        replace flag_short = 1 if ///
            strlen(temp) < 3 & ///
            !missing(temp) & ///
            temp != ""
        replace short_vars = short_vars + " `var':'" + temp + "'" ///
            if strlen(temp) < 3 & ///
            !missing(temp) & ///
            temp != ""
        drop temp
    }
}

keep if flag_short == 1
replace issue_comment = issue_comment + " -" + short_vars

if _N > 0 {
    export excel caseid ENUM_NAME School RES_NAME ///
        B4_S B5_S B9_S issue_comment short_vars ///
        using "LBB DQA Teachers ${dates}.xlsx", ///
        sheet("Short_Responses", replace) firstrow(variables)
}
restore














