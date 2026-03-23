*Merging VI and Non-VI
**Setting the working directory
cls
clear all
cd "C:\Users\oyoo\OneDrive - Dalberg Global Development Advisors\QUALITY CONTROL\Projects\2026\Projects\UNICEF LBB\Main\Data\Raw\Student"

use "VI\LBB Baseline Survey Processed data VIs.dta",replace

append using "Non VI\LBB Baseline Survey Processed data NON-VIs.dta", force gen(source)

drop source

ren Diability_Cat Category

save "Merged\LBB Baseline Survey Raw data Merged VI-NON VI.dta",replace