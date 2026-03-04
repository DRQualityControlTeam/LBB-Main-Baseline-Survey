* Encoding: UTF-8.
**************************************************************************************************************************************************************************************
*LBB PROJECT*********************************************************************************************************************************************
*********************************************************************************************************************************************
***SCREENER SURVEY

get stata file = "C:\Users\oyoo\OneDrive - Dalberg Global Development Advisors\QUALITY CONTROL\Projects\2026\Projects\UNICEF LBB\Main\Data\Raw\Screener\Long format\LBB Screener Headteacher dataset.dta".

************************************************************************************************************************************************************************************.
VARIABLE LEVEL INT_DATE(NOMINAL).

*Output Tally.
OUTPUT NEW.

*Daily Achievements Output for Student Survey.

SORT CASES BY PARENT_KEY ENUM_NAME.
MATCH FILES /FILE=* /BY PARENT_KEY ENUM_NAME /FIRST=first.
SELECT IF first=1.
EXECUTE.

* Custom Tables.
CTABLES
  /VLABELS VARIABLES=SUP_NAME ENUM_NAME INT_DATE DISPLAY=LABEL
  /TABLE SUP_NAME > ENUM_NAME BY INT_DATE [C][COUNT F40.0]
  /CATEGORIES VARIABLES=SUP_NAME ENUM_NAME ORDER=A KEY=VALUE EMPTY=EXCLUDE
  /CATEGORIES VARIABLES=INT_DATE ORDER=A KEY=VALUE EMPTY=EXCLUDE TOTAL=YES POSITION=AFTER
    /SLABELS VISIBLE=NO
  /CRITERIA CILEVEL=95
  /TITLES TITLE="Daily Team Achievements".

* Custom Tables.
CTABLES
  /VLABELS VARIABLES=County Sub_county School_name DISPLAY=LABEL
  /TABLE County > Sub_county > School_name [COUNT F40.0]
  /CATEGORIES VARIABLES=County Sub_county School_name ORDER=A KEY=VALUE EMPTY=EXCLUDE
  /CRITERIA CILEVEL=95
  /TITLES TITLE="Schools visited".

* Export Output.
OUTPUT EXPORT
  /CONTENTS  EXPORT=VISIBLE  LAYERS=PRINTSETTING  MODELVIEWS=PRINTSETTING
  /XLSX  DOCUMENTFILE='C:\Users\oyoo\OneDrive - Dalberg Global Development Advisors\QUALITY CONTROL\Projects\2026\Projects\UNICEF LBB\Main\Progress\LBB Screener Daily Updates v01.xlsx'
     OPERATION=CREATEFILE sheet="Screener Achievements"
     LOCATION=LASTCOLUMN  NOTESCAPTIONS=YES.
OUTPUT CLOSE *.
