* Encoding: UTF-8.
**************************************************************************************************************************************************************************************
*LBB PROJECT*********************************************************************************************************************************************
*********************************************************************************************************************************************
***TEACHERS SURVEY

get stata file = "C:\Users\oyoo\OneDrive - Dalberg Global Development Advisors\QUALITY CONTROL\Projects\2026\Projects\UNICEF LBB\Main\Data\Raw\Teachers\Teacher LBB Baseline Processed data.dta".

************************************************************************************************************************************************************************************.
variable level INT_DATE ENUM_NAME Ecole (Nominal).

*Output Tally.
OUTPUT NEW.

*Daily Achievements Output for Student Survey.

* Custom Tables.
CTABLES
  /VLABELS VARIABLES=SUP_NAME ENUM_NAME INT_DATE DISPLAY=LABEL
  /TABLE SUP_NAME > ENUM_NAME BY INT_DATE [COUNT F40.0]
  /SLABELS VISIBLE=NO
  /CATEGORIES VARIABLES=SUP_NAME ENUM_NAME ORDER=A KEY=VALUE EMPTY=EXCLUDE
  /CATEGORIES VARIABLES=INT_DATE ORDER=A KEY=VALUE EMPTY=EXCLUDE TOTAL=YES POSITION=AFTER
  /CRITERIA CILEVEL=95
  /TITLES TITLE="MOHEBS Student Survey - Team achievements".

* Daily Achievement Output for Student Survey by Schools, Intervention group, and Grade.
* Custom Tables.
CTABLES
  /VLABELS VARIABLES=Echantillon IEF Ecole B4 DISPLAY=LABEL
  /TABLE Echantillon [C] > IEF [C] > Ecole [C][COUNT F40.0] BY B4 [C]
  /SLABELS VISIBLE=NO
  /CATEGORIES VARIABLES=Echantillon IEF Ecole ORDER=A KEY=VALUE EMPTY=EXCLUDE
  /CATEGORIES VARIABLES=B4 ORDER=A KEY=VALUE EMPTY=EXCLUDE TOTAL=YES POSITION=AFTER
  /CRITERIA CILEVEL=95
    /TITLES TITLE ="MOHEBS Student Survey - Tracker achievements- Main".
  
*By gender.
CTABLES
  /VLABELS VARIABLES=Echantillon IEF Ecole B4 B2 DISPLAY=LABEL
  /TABLE Echantillon [C] > IEF [C] > Ecole [C][COUNT F40.0] BY B4 [C] > B2 [C]
  /SLABELS VISIBLE=NO
  /CATEGORIES VARIABLES=Echantillon IEF Ecole ORDER=A KEY=VALUE EMPTY=EXCLUDE
  /CATEGORIES VARIABLES=B4 B2 ORDER=A KEY=VALUE EMPTY=EXCLUDE TOTAL=YES POSITION=AFTER
  /CRITERIA CILEVEL=95
  /TITLES TITLE ="MOHEBS Student Survey - Location achievements- Main".

* Export Output.
OUTPUT EXPORT
  /CONTENTS  EXPORT=VISIBLE  LAYERS=PRINTSETTING  MODELVIEWS=PRINTSETTING
  /XLSX  DOCUMENTFILE='C:\Users\oyoo\OneDrive - Dalberg Global Development Advisors\QUALITY CONTROL\Projects\2025\MOHEBS\Progress\Main\Field\MOHEBS Daily Updates v02.xlsx'
     OPERATION=CREATEFILE sheet="Student Achievements"
     LOCATION=LASTCOLUMN  NOTESCAPTIONS=YES.
OUTPUT CLOSE *.

***TEACHERS SURVEY

get stata file = "C:\Users\oyoo\OneDrive - Dalberg Global Development Advisors\QUALITY CONTROL\Projects\2025\MOHEBS\Data\Raw\Main\Teachers\MOHEBS Teachers Baseline Processed Dataset 27-01 v01.dta".

************************************************************************************************************************************************************************************.
variable level INT_DATE ENUM_NAME School (nominal).

*Output Tally.
OUTPUT NEW.

*Team's achievements.

* Custom Tables.
CTABLES
  /VLABELS VARIABLES=SUP_NAME ENUM_NAME INT_DATE DISPLAY=LABEL
  /TABLE SUP_NAME > ENUM_NAME BY INT_DATE [COUNT F40.0]
  /SLABELS VISIBLE=NO
  /CATEGORIES VARIABLES=SUP_NAME ENUM_NAME ORDER=A KEY=VALUE EMPTY=EXCLUDE
  /CATEGORIES VARIABLES=INT_DATE ORDER=A KEY=VALUE EMPTY=EXCLUDE TOTAL=YES POSITION=AFTER
  /CRITERIA CILEVEL=95
    /TITLES TITLE="MOHEBS Teachers Survey - Team achievements".


* Custom Tables.
CTABLES
  /VLABELS VARIABLES=IEF School Group DISPLAY=LABEL
  /TABLE IEF [C] > School [C][COUNT F40.0] BY Group [C]
  /SLABELS VISIBLE=NO
  /CATEGORIES VARIABLES=IEF School ORDER=A KEY=VALUE EMPTY=EXCLUDE
  /CATEGORIES VARIABLES=Group ORDER=A KEY=VALUE EMPTY=EXCLUDE TOTAL=YES POSITION=AFTER
  /CRITERIA CILEVEL=95
  /TITLES TITLE ="MOHEBS Teachers Survey - Location achievements- Main".

* Export Output.
OUTPUT EXPORT
  /CONTENTS  EXPORT=VISIBLE  LAYERS=PRINTSETTING  MODELVIEWS=PRINTSETTING
  /XLSX  DOCUMENTFILE='C:\Users\oyoo\OneDrive - Dalberg Global Development Advisors\QUALITY CONTROL\Projects\2025\MOHEBS\Progress\Main\Field\MOHEBS Daily Updates v02.xlsx'
     OPERATION=CREATESHEET sheet="Teachers Achievements"
     LOCATION=LASTCOLUMN  NOTESCAPTIONS=YES.
OUTPUT CLOSE *.
