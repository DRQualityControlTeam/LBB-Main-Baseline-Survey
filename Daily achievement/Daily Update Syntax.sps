* Encoding: UTF-8.
**************************************************************************************************************************************************************************************
*LBB PROJECT*********************************************************************************************************************************************
*********************************************************************************************************************************************
***SCREENER SURVEY

get stata file = "C:\Users\oyoo\OneDrive - Dalberg Global Development Advisors\QUALITY CONTROL\Projects\2026\Projects\UNICEF LBB\Main\Data\Raw\Screener\Long format\LBB Screener Headteacher dataset.dta".

************************************************************************************************************************************************************************************.
VARIABLE LEVEL INT_DATE School_name (NOMINAL).

*Output Tally.
OUTPUT NEW.

*Daily Achievements Output for Student Survey.

SORT CASES BY PARENT_KEY ENUM_NAME.
MATCH FILES /FILE=* /BY PARENT_KEY ENUM_NAME /FIRST=first.
SELECT IF first=1.
EXECUTE.

* Custom Tables.
CTABLES
  /VLABELS VARIABLES=SUP_NAME ENUM_NAME INT_DATE DISPLAY=NONE
  /TABLE SUP_NAME > ENUM_NAME BY INT_DATE [C][COUNT F40.0]
  /CATEGORIES VARIABLES=SUP_NAME ENUM_NAME ORDER=A KEY=VALUE EMPTY=EXCLUDE
  /CATEGORIES VARIABLES=INT_DATE ORDER=A KEY=VALUE EMPTY=EXCLUDE TOTAL=YES POSITION=AFTER
    /SLABELS VISIBLE=NO
  /CRITERIA CILEVEL=95
  /TITLES TITLE="Daily Team Achievements".

* Custom Tables.
CTABLES
  /VLABELS VARIABLES=County Sub_county School_name DISPLAY=NONE
  /TABLE County > Sub_county > School_name [COUNT F40.0]
  /CATEGORIES VARIABLES=County Sub_county School_name ORDER=A KEY=VALUE EMPTY=EXCLUDE
  /CRITERIA CILEVEL=95
  /TITLES TITLE="Schools visited".

* Export Output.
OUTPUT EXPORT
  /CONTENTS  EXPORT=VISIBLE  LAYERS=PRINTSETTING  MODELVIEWS=PRINTSETTING
  /XLSX  DOCUMENTFILE='C:\Users\oyoo\OneDrive - Dalberg Global Development Advisors\QUALITY CONTROL\Projects\2026\Projects\UNICEF LBB\Main\Progress\LBB Daily Updates v02.xlsx'
     OPERATION=CREATEFILE sheet="Screener Achievements"
     LOCATION=LASTCOLUMN  NOTESCAPTIONS=YES.
OUTPUT CLOSE *.

***VIs SURVEY

get stata file = "C:\Users\oyoo\OneDrive - Dalberg Global Development Advisors\QUALITY CONTROL\Projects\2026\Projects\UNICEF LBB\Main\Data\Raw\Student\VI\LBB Baseline Survey Processed data VIs.dta".

************************************************************************************************************************************************************************************.
VARIABLE LEVEL INT_DATE School (NOMINAL).

*Output Tally.
OUTPUT NEW.

*Daily Achievements Output for Student Survey.

* Custom Tables.
CTABLES
  /VLABELS VARIABLES=SUP_NAME ENUM_NAME INT_DATE DISPLAY=NONE
  /TABLE SUP_NAME > ENUM_NAME BY INT_DATE [C][COUNT F40.0]
  /CATEGORIES VARIABLES=SUP_NAME ENUM_NAME ORDER=A KEY=VALUE EMPTY=EXCLUDE
  /CATEGORIES VARIABLES=INT_DATE ORDER=A KEY=VALUE EMPTY=EXCLUDE TOTAL=YES POSITION=AFTER
    /SLABELS VISIBLE=NO
  /CRITERIA CILEVEL=95
  /TITLES TITLE="Daily Team Achievements".

* Custom Tables.
CTABLES
  /VLABELS VARIABLES=County School DISPLAY=NONE
  /TABLE County > School [COUNT F40.0]
  /CATEGORIES VARIABLES=County School ORDER=A KEY=VALUE EMPTY=EXCLUDE
  /CRITERIA CILEVEL=95
  /TITLES TITLE="Schools visited".

* Export Output.
OUTPUT EXPORT
  /CONTENTS  EXPORT=VISIBLE  LAYERS=PRINTSETTING  MODELVIEWS=PRINTSETTING
  /XLSX  DOCUMENTFILE='C:\Users\oyoo\OneDrive - Dalberg Global Development Advisors\QUALITY CONTROL\Projects\2026\Projects\UNICEF LBB\Main\Progress\LBB Daily Updates v02.xlsx'
     OPERATION=CREATESHEET sheet="VI Learners Achievements"
     LOCATION=LASTCOLUMN  NOTESCAPTIONS=YES.
OUTPUT CLOSE *.

***NON VIs SURVEY

get stata file = "C:\Users\oyoo\OneDrive - Dalberg Global Development Advisors\QUALITY CONTROL\Projects\2026\Projects\UNICEF LBB\Main\Data\Raw\Student\Non VI\LBB Baseline Survey Processed data NON-VIs.dta".

************************************************************************************************************************************************************************************.
VARIABLE LEVEL INT_DATE(NOMINAL).

*Output Tally.
OUTPUT NEW.

*Daily Achievements Output for Student Survey.

* Custom Tables.
CTABLES
  /VLABELS VARIABLES=SUP_NAME ENUM_NAME INT_DATE DISPLAY=NONE
  /TABLE SUP_NAME > ENUM_NAME BY INT_DATE [C][COUNT F40.0]
  /CATEGORIES VARIABLES=SUP_NAME ENUM_NAME ORDER=A KEY=VALUE EMPTY=EXCLUDE
  /CATEGORIES VARIABLES=INT_DATE ORDER=A KEY=VALUE EMPTY=EXCLUDE TOTAL=YES POSITION=AFTER
    /SLABELS VISIBLE=NO
  /CRITERIA CILEVEL=95
  /TITLES TITLE="Daily Team Achievements".

* Custom Tables.
CTABLES
  /VLABELS VARIABLES=County School DISPLAY=NONE
  /TABLE County > School [COUNT F40.0]
  /CATEGORIES VARIABLES=County School ORDER=A KEY=VALUE EMPTY=EXCLUDE
  /CRITERIA CILEVEL=95
  /TITLES TITLE="Schools visited".

* Export Output.
OUTPUT EXPORT
  /CONTENTS  EXPORT=VISIBLE  LAYERS=PRINTSETTING  MODELVIEWS=PRINTSETTING
  /XLSX  DOCUMENTFILE='C:\Users\oyoo\OneDrive - Dalberg Global Development Advisors\QUALITY CONTROL\Projects\2026\Projects\UNICEF LBB\Main\Progress\LBB Daily Updates v02.xlsx'
     OPERATION=CREATESHEET sheet="NON-VI Learners Achievements"
     LOCATION=LASTCOLUMN  NOTESCAPTIONS=YES.
OUTPUT CLOSE *.

***TEACHERS SURVEY

get stata file = "C:\Users\oyoo\OneDrive - Dalberg Global Development Advisors\QUALITY CONTROL\Projects\2026\Projects\UNICEF LBB\Main\Data\Raw\Teachers\Teacher LBB Baseline Processed data.dta".

************************************************************************************************************************************************************************************.
VARIABLE LEVEL INT_DATE(NOMINAL).

*Output Tally.
OUTPUT NEW.

*Daily Achievements Output for Student Survey.

* Custom Tables.
CTABLES
  /VLABELS VARIABLES=SUP_NAME ENUM_NAME INT_DATE DISPLAY=NONE
  /TABLE SUP_NAME > ENUM_NAME BY INT_DATE [C][COUNT F40.0]
  /CATEGORIES VARIABLES=SUP_NAME ENUM_NAME ORDER=A KEY=VALUE EMPTY=EXCLUDE
  /CATEGORIES VARIABLES=INT_DATE ORDER=A KEY=VALUE EMPTY=EXCLUDE TOTAL=YES POSITION=AFTER
    /SLABELS VISIBLE=NO
  /CRITERIA CILEVEL=95
  /TITLES TITLE="Daily Team Achievements".

* Custom Tables.
CTABLES
  /VLABELS VARIABLES=County School_name DISPLAY=NONE
  /TABLE County > School_name [COUNT F40.0]
  /CATEGORIES VARIABLES=County School_name ORDER=A KEY=VALUE EMPTY=EXCLUDE
  /CRITERIA CILEVEL=95
  /TITLES TITLE="Schools visited".

* Export Output.
OUTPUT EXPORT
  /CONTENTS  EXPORT=VISIBLE  LAYERS=PRINTSETTING  MODELVIEWS=PRINTSETTING
  /XLSX  DOCUMENTFILE='C:\Users\oyoo\OneDrive - Dalberg Global Development Advisors\QUALITY CONTROL\Projects\2026\Projects\UNICEF LBB\Main\Progress\LBB Daily Updates v02.xlsx'
     OPERATION=CREATESHEET sheet="Teachers Achievements"
     LOCATION=LASTCOLUMN  NOTESCAPTIONS=YES.
OUTPUT CLOSE *.

***CLASSROOM SURVEY

get stata file = "C:\Users\oyoo\OneDrive - Dalberg Global Development Advisors\QUALITY CONTROL\Projects\2026\Projects\UNICEF LBB\Main\Data\Raw\Classroom\Classroom LBB Baseline Processed data.dta".

************************************************************************************************************************************************************************************.
VARIABLE LEVEL INT_DATE(NOMINAL).

*Output Tally.
OUTPUT NEW.

*Daily Achievements Output for Student Survey.

* Custom Tables.
CTABLES
  /VLABELS VARIABLES=SUP_NAME ENUM_NAME INT_DATE DISPLAY=NONE
  /TABLE SUP_NAME > ENUM_NAME BY INT_DATE [C][COUNT F40.0]
  /CATEGORIES VARIABLES=SUP_NAME ENUM_NAME ORDER=A KEY=VALUE EMPTY=EXCLUDE
  /CATEGORIES VARIABLES=INT_DATE ORDER=A KEY=VALUE EMPTY=EXCLUDE TOTAL=YES POSITION=AFTER
    /SLABELS VISIBLE=NO
  /CRITERIA CILEVEL=95
  /TITLES TITLE="Daily Team Achievements".

* Custom Tables.
CTABLES
  /VLABELS VARIABLES=County School_name DISPLAY=NONE
  /TABLE County > School_name [COUNT F40.0]
  /CATEGORIES VARIABLES=County School_name ORDER=A KEY=VALUE EMPTY=EXCLUDE
  /CRITERIA CILEVEL=95
  /TITLES TITLE="Schools visited".

* Export Output.
OUTPUT EXPORT
  /CONTENTS  EXPORT=VISIBLE  LAYERS=PRINTSETTING  MODELVIEWS=PRINTSETTING
  /XLSX  DOCUMENTFILE='C:\Users\oyoo\OneDrive - Dalberg Global Development Advisors\QUALITY CONTROL\Projects\2026\Projects\UNICEF LBB\Main\Progress\LBB Daily Updates v02.xlsx'
     OPERATION=CREATESHEET sheet="Classroom Achievements"
     LOCATION=LASTCOLUMN  NOTESCAPTIONS=YES.
OUTPUT CLOSE *.
