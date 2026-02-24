*Region
lab define regi 1"Louga" 2"Fatick" 3"Kaffrine"

replace SampleIA_label = "1" if SampleIA =="YL27zAUz"
replace SampleIA_label = "2" if SampleIA =="RnJi1V52"
replace SampleIA_label = "3" if SampleIA =="6pdkRXny"

destring SampleIA_label,replace
lab values SampleIA_label regi
ren SampleIA_label IA
order IA,after(interviewer_type)

*IEF
lab define ief 1"Fatick" 2"Foundiougne" 3"Birkelane" 4"Kaffrine" 5"Kebemer" 6"Linguere"

replace SampleIEF_label = "1" if SampleIEF =="070coyjE"
replace SampleIEF_label = "2" if SampleIEF =="hA7xL4Yi"
replace SampleIEF_label = "3" if SampleIEF =="PsKrM21A"
replace SampleIEF_label = "4" if SampleIEF =="Tqdu8sDe"
replace SampleIEF_label = "5" if SampleIEF =="hzgp6w6n"
replace SampleIEF_label = "6" if SampleIEF =="GPRFqJfQ"

destring SampleIEF_label,replace
lab values SampleIEF_label ief
ren SampleIEF_label IEF
order IEF,after(IA)

*Arrondissement
lab define arrond 1 "Art Niakhar" 2 "Ville Diakhao" 3 "Art Ndiob" 4 "Ville Fatick" 5 "Art Djilor" 6 "Ville Soum" 7 "Art Toubacouta" 8 "Art keur Mbouki" 9 "Art Mabo" 10 "Ville Birkelane" 11 "Ville Kaffrine" 12 "Art Katakel" 13 "Art Gniby" 14 "Ville Kébémer" 15 "Art Ndande" 16 "Ville Dahra" 17 "Art Barkedji" 18 "Art Yang Yang"

replace SampleArrondissement_label="1" if SampleArrondissement=="y4NRTzvs"
replace SampleArrondissement_label="2" if SampleArrondissement=="KljFMemY"
replace SampleArrondissement_label="3" if SampleArrondissement=="WWDedkBa"
replace SampleArrondissement_label="4" if SampleArrondissement=="74BGFw88"
replace SampleArrondissement_label="5" if SampleArrondissement=="tYxdHXa3"
replace SampleArrondissement_label="6" if SampleArrondissement=="pn9Nds6o"
replace SampleArrondissement_label="7" if SampleArrondissement=="ugtSCAOq"
replace SampleArrondissement_label="8" if SampleArrondissement=="orO6CFLu"
replace SampleArrondissement_label="9" if SampleArrondissement=="2Ad94fVn"
replace SampleArrondissement_label="10" if SampleArrondissement=="M8ZZOguH"
replace SampleArrondissement_label="11" if SampleArrondissement=="AWqiHrld"
replace SampleArrondissement_label="12" if SampleArrondissement=="8gIp4RGT"
replace SampleArrondissement_label="13" if SampleArrondissement=="9vhnrvO2"
replace SampleArrondissement_label="14" if SampleArrondissement=="PBj8KZho"
replace SampleArrondissement_label="15" if SampleArrondissement=="nwRvOX1r"
replace SampleArrondissement_label="16" if SampleArrondissement=="aq6lHB0t"
replace SampleArrondissement_label="17" if SampleArrondissement=="KDTEUfvC"
replace SampleArrondissement_label="18" if SampleArrondissement=="pgNffrZJ"

destring SampleArrondissement_label,replace
lab values SampleArrondissement_label arrond
ren SampleArrondissement_label Arrondissement
order Arrondissement,after(IEF)

*Commune
lab define comm 1 "Niakhar" 2 "Ngayokhene" 3 "Diakhao" 4 "Ndiob" 5 "Mbellacadiao" 6 "Diaoule" 7 "Fatick" 8 "Djilor" 9 "Mbam" 10 "Diagane Barka" 11 "Soum" 12 "Toubacouta" 13 "Touba Mbella" 14 "Diamal" 15 "Keur Mbouki" 16 "Ndiognick" 17 "Birkelane" 18 "Kaffrine" 19 "Medinatoul Salam 2" 20 "Boulel" 21 "Kahi" 22 "Kébémer" 23 "Ndande" 24 "Diokoul Diawrigne" 25 "Dahra" 26 "Thiargny" 27 "Barkédji" 28 "Kambe"

replace SampleCommune_label="1" if SampleCommune=="RWG9bhCR"
replace SampleCommune_label="2" if SampleCommune=="RMRvxNR6"
replace SampleCommune_label="3" if SampleCommune=="q55mWR3v"
replace SampleCommune_label="4" if SampleCommune=="uZMberIb"
replace SampleCommune_label="5" if SampleCommune=="6rAMfsoP"
replace SampleCommune_label="6" if SampleCommune=="qitbnRsf"
replace SampleCommune_label="7" if SampleCommune=="zHmS6Cbe"
replace SampleCommune_label="8" if SampleCommune=="JGSU5l9T"
replace SampleCommune_label="9" if SampleCommune=="ZoP3jUjC"
replace SampleCommune_label="10" if SampleCommune=="w6mK9ln2"
replace SampleCommune_label="11" if SampleCommune=="5seeIMlr"
replace SampleCommune_label="12" if SampleCommune=="r6xSxzgb"
replace SampleCommune_label="13" if SampleCommune=="78EKwdEl"
replace SampleCommune_label="14" if SampleCommune=="TC2iWYb1"
replace SampleCommune_label="15" if SampleCommune=="4Mb8DhnQ"
replace SampleCommune_label="16" if SampleCommune=="LOzMKpvB"
replace SampleCommune_label="17" if SampleCommune=="y7icWbvN"
replace SampleCommune_label="18" if SampleCommune=="id7VZcz9"
replace SampleCommune_label="19" if SampleCommune=="Dap6wbkj"
replace SampleCommune_label="20" if SampleCommune=="Z3Jvi8Pp"
replace SampleCommune_label="21" if SampleCommune=="9KBI9sCJ"
replace SampleCommune_label="22" if SampleCommune=="TpYuORhQ"
replace SampleCommune_label="23" if SampleCommune=="CuC0Mm6Z"
replace SampleCommune_label="24" if SampleCommune=="IyEkHg0R"
replace SampleCommune_label="25" if SampleCommune=="2WjVGNFJ"
replace SampleCommune_label="26" if SampleCommune=="JGyCj8Ly"
replace SampleCommune_label="27" if SampleCommune=="jhbnBRlx"
replace SampleCommune_label="28" if SampleCommune=="0gR8zEns"

destring SampleCommune_label, replace
ren SampleCommune_label Commune
lab values Commune comm
order Commune,after(Arrondissement)

*Enchantallion
lab define echa 1 "Échantillon" 2 "Remplacement"

replace SampleEchantillon_label="1" if inlist(SampleEchantillon_label,"Échantillon","Ãchantillon")
replace SampleEchantillon_label="2" if SampleEchantillon_label=="Remplacement"

destring SampleEchantillon_label, replace
ren SampleEchantillon_label Echantillon
lab values Echantillon echa
order Echantillon,after(Commune)

**Ecole
lab define sch 1 "ee bibane" 2 "ee sanghaie" 3 "ee sorokh" 4 "ee amady barro diouf" 5 "ee nghonine" 6 "ee ngayokheme" 7 "ee toucar 2" 8 "ee barry sine" 9 "ee sass ndiafadji" 10 "ee boure ngom" 11 "ee diakhao 4" 12 "ee ndioudiouf (ndiob)" 13 "ee ngouloul peulh" 14 "mbellacadio 2" 15 "ee mbotil coop" 16 "ee ouyal sande serere" 17 "ee sakhao" 18 "ee tene toubab" 19 "ee application" 20 "ee ngor ndame ndiaye ndiaye" 21 "ee poukham ndieme" 22 "ee baaye" 23 "ee boly" 24 "ee lambaye" 25 "ee keur oumar" 26 "ee keur yoro" 27 "ee lathilor ndong" 28 "ee djilor 2" 29 "ee keur mor diop" 30 "ee pethie" 31 "ee mbam 1" 32 "ee mbam 2" 33 "ee thiare" 34 "ee gague mody" 35 "ee mbassis 2" 36 "ee ndiomborel" 37 "keur mamadou fatouma" 38 "ee babacar ndene diop" 39 "ee medina santhie" 40 "ee dianko mane" 41 "ee djinack bara" 42 "ee diacke samba" 43 "ee yalal diacke" 44 "ee lougol" 45 "ee ngambou" 46 "ee dara nguer" 47 "ee keur mboucki" 48 "ee keur magaye" 49 "ee ndiayene waly" 50 "ee goback" 51 "ee ndrame" 52 "ee segre secco" 53 "ee keur babou" 54 "ee ndiayene bagana" 55 "ee daga birame" 56 "ee ngouye" 57 "efa ndiamacolong" 58 "ee birkelane 4" 59 "ee el h. thiendella fall" 60 "ee diamaguene tp" 61 "ee kaffrine 2 sud" 62 "efa diamaguene tp" 63 "ee de kathiote" 64 "ee elhadji ndene diodio ndiaye" 65 "ee kaffrine 10" 66 "ee kaffrine 6" 67 "ee elhadji aliou fana cisse" 68 "ee kelimane gouye" 69 "ee medina kebe" 70 "efa touba saloum" 71 "efa boulel" 72 "ee boucar diouf" 73 "ee diouthnguel" 74 "ee kheinde" 75 "ee lanel" 76 "ee elhadji andala wilane" 77 "ee kebemer 9" 78 "ee ndiaby fall" 79 "ee mbaye fatma kebe" 80 "ee ndande 4" 81 "ee niokhoul fall" 82 "ee ndande 3" 83 "ee ndiaye boumi" 84 "ee gade kebe" 85 "ee ndiawrigne mamousse" 86 "ee saly" 87 "ee thienaba seck" 88 "ee 3 wagons" 89 "ee angle islam" 90 "ee ngome" 91 "ee sidy alboury ndiaye" 92 "ee dahra montagne" 93 "ee lol lol" 94 "ee thiargny" 95 "ee linde" 96 "ee loumbal lana" 97 "ee niaka soringha" 98 "ee barkedji montagne" 99 "ee kamb" 100 "ee legne" 101"ee belel aere" 102"ee fouthity" 103"ee loumbi dobe" 104"efa kodiolele" 105"ee rotto" 106"ee thicogne"

replace SampleEcole_label="1" if SampleEcole=="TBLKZsVo"
replace SampleEcole_label="2" if SampleEcole=="1NWRRAmX"
replace SampleEcole_label="3" if SampleEcole=="iZuo3lch"
replace SampleEcole_label="4" if SampleEcole=="h84yX5dN"
replace SampleEcole_label="5" if SampleEcole=="kQfMGky0"
replace SampleEcole_label="6" if SampleEcole=="agasnTZC"
replace SampleEcole_label="7" if SampleEcole=="bxe6ByJz"
replace SampleEcole_label="8" if SampleEcole=="WbZStlJo"
replace SampleEcole_label="9" if SampleEcole=="E9xgOVyT"
replace SampleEcole_label="10" if SampleEcole=="YFWMrrYn"
replace SampleEcole_label="11" if SampleEcole=="XBlGnaRK"
replace SampleEcole_label="12" if SampleEcole=="83stKaPE"
replace SampleEcole_label="13" if SampleEcole=="f7DKAz59"
replace SampleEcole_label="14" if SampleEcole=="sF2q8vrD"
replace SampleEcole_label="15" if SampleEcole=="FL82ZPXL"
replace SampleEcole_label="16" if SampleEcole=="2UxMdmsB"
replace SampleEcole_label="17" if SampleEcole=="wwQE86lD"
replace SampleEcole_label="18" if SampleEcole=="I4MBRGNW"
replace SampleEcole_label="19" if SampleEcole=="HfESaiEu"
replace SampleEcole_label="20" if SampleEcole=="DziJHsSO"
replace SampleEcole_label="21" if SampleEcole=="MXG1ay9Q"
replace SampleEcole_label="22" if SampleEcole=="esDdv8Sh"
replace SampleEcole_label="23" if SampleEcole=="qtLZnA1u"
replace SampleEcole_label="24" if SampleEcole=="pP4VKSEo"
replace SampleEcole_label="25" if SampleEcole=="jUPvxwSy"
replace SampleEcole_label="26" if SampleEcole=="qJ1jpq9q"
replace SampleEcole_label="27" if SampleEcole=="VKHPtzUK"
replace SampleEcole_label="28" if SampleEcole=="5XCXvfp0"
replace SampleEcole_label="29" if SampleEcole=="jgTJ2g7O"
replace SampleEcole_label="30" if SampleEcole=="JbtmZrKX"
replace SampleEcole_label="31" if SampleEcole=="HvmKUTH0"
replace SampleEcole_label="32" if SampleEcole=="J19cVSxs"
replace SampleEcole_label="33" if SampleEcole=="B8yo6DML"
replace SampleEcole_label="34" if SampleEcole=="yQdtisON"
replace SampleEcole_label="35" if SampleEcole=="B4OnD6Rx"
replace SampleEcole_label="36" if SampleEcole=="LL1XXMLc"
replace SampleEcole_label="37" if SampleEcole=="01OKzBdM"
replace SampleEcole_label="38" if SampleEcole=="rgvA8P0T"
replace SampleEcole_label="39" if SampleEcole=="YrAWj5yG"
replace SampleEcole_label="40" if SampleEcole=="G8VeaCM9"
replace SampleEcole_label="41" if SampleEcole=="HyXRDQmi"
replace SampleEcole_label="42" if SampleEcole=="AOSBT7Wj"
replace SampleEcole_label="43" if SampleEcole=="46UlJGsT"
replace SampleEcole_label="44" if SampleEcole=="ngaDzz0r"
replace SampleEcole_label="45" if SampleEcole=="oNkDvPPT"
replace SampleEcole_label="46" if SampleEcole=="FmU1o5WV"
replace SampleEcole_label="47" if SampleEcole=="XWEs0Cxx"
replace SampleEcole_label="48" if SampleEcole=="qfJE7bOs"
replace SampleEcole_label="49" if SampleEcole=="cQagRFvL"
replace SampleEcole_label="50" if SampleEcole=="cRLa4tIA"
replace SampleEcole_label="51" if SampleEcole=="cY4N2mlZ"
replace SampleEcole_label="52" if SampleEcole=="Mq1xwtBH"
replace SampleEcole_label="53" if SampleEcole=="2VhJlXNj"
replace SampleEcole_label="54" if SampleEcole=="XvDBge2Q"
replace SampleEcole_label="55" if SampleEcole=="45qRkhFA"
replace SampleEcole_label="56" if SampleEcole=="U6Di2Y6K"
replace SampleEcole_label="57" if SampleEcole=="YZRPpRTZ"
replace SampleEcole_label="58" if SampleEcole=="5gdHHfAl"
replace SampleEcole_label="59" if SampleEcole=="S2HT3exn"
replace SampleEcole_label="60" if SampleEcole=="TAFZCSwK"
replace SampleEcole_label="61" if SampleEcole=="HgIPTWRV"
replace SampleEcole_label="62" if SampleEcole=="7A317Dp0"
replace SampleEcole_label="63" if SampleEcole=="ZPgLSZaG"
replace SampleEcole_label="64" if SampleEcole=="talIbQ34"
replace SampleEcole_label="65" if SampleEcole=="uyuQp5ct"
replace SampleEcole_label="66" if SampleEcole=="OtuU8Wvd"
replace SampleEcole_label="67" if SampleEcole=="bZSxvz03"
replace SampleEcole_label="68" if SampleEcole=="0WaUUMne"
replace SampleEcole_label="69" if SampleEcole=="HfodxGIY"
replace SampleEcole_label="70" if SampleEcole=="god4lHbr"
replace SampleEcole_label="71" if SampleEcole=="TkTTaxra"
replace SampleEcole_label="72" if SampleEcole=="i9ugdwCn"
replace SampleEcole_label="73" if SampleEcole=="7Q2VVVuc"
replace SampleEcole_label="74" if SampleEcole=="7wPbUnpw"
replace SampleEcole_label="75" if SampleEcole=="DkpDT6kz"
replace SampleEcole_label="76" if SampleEcole=="qyRdQ8fk"
replace SampleEcole_label="77" if SampleEcole=="gz9pOMNx"
replace SampleEcole_label="78" if SampleEcole=="jvaGxGXX"
replace SampleEcole_label="79" if SampleEcole=="yWNHuKPS"
replace SampleEcole_label="80" if SampleEcole=="HzldObuU"
replace SampleEcole_label="81" if SampleEcole=="6D0QHi5B"
replace SampleEcole_label="82" if SampleEcole=="xZVZTPKK"
replace SampleEcole_label="83" if SampleEcole=="RaXtPZDa"
replace SampleEcole_label="84" if SampleEcole=="6stvAaqY"
replace SampleEcole_label="85" if SampleEcole=="kuygIi1O"
replace SampleEcole_label="86" if SampleEcole=="Sx3TRSxf"
replace SampleEcole_label="87" if SampleEcole=="hKCQvlkI"
replace SampleEcole_label="88" if SampleEcole=="0AuvFTQX"
replace SampleEcole_label="89" if SampleEcole=="2iZ0cyWw"
replace SampleEcole_label="90" if SampleEcole=="kt7aNBoW"
replace SampleEcole_label="91" if SampleEcole=="4UkZYsjk"
replace SampleEcole_label="92" if SampleEcole=="HerT5vTH"
replace SampleEcole_label="93" if SampleEcole=="Wy3FcWCm"
replace SampleEcole_label="94" if SampleEcole=="sqOv9Fce"
replace SampleEcole_label="95" if SampleEcole=="OBMXFWJa"
replace SampleEcole_label="96" if SampleEcole=="j5aeadji"
replace SampleEcole_label="97" if SampleEcole=="fqSMsdmr"
replace SampleEcole_label="98" if SampleEcole=="daYCx262"
replace SampleEcole_label="99" if SampleEcole=="ZU9HbpHT"
replace SampleEcole_label="100" if SampleEcole=="yBHpUNRY"
replace SampleEcole_label="101" if SampleEcole=="OB2XFWJa"
replace SampleEcole_label="102" if SampleEcole=="j3aeadji"
replace SampleEcole_label="103" if SampleEcole=="fqSMs4mr"
replace SampleEcole_label="104" if SampleEcole=="daY5x262"
replace SampleEcole_label="105" if SampleEcole=="ZU6HbpHT"
replace SampleEcole_label="106" if SampleEcole=="yBHp7NRY"

destring SampleEcole_label, replace
ren SampleEcole_label Ecole
lab values Ecole sch
order Ecole,after(Commune)

*Group
lab def grp 1 "Traitement" 2 "Comparaison"

replace SampleGroupe_label="1" if SampleGroupe_label=="Traitement"
replace SampleGroupe_label="2" if SampleGroupe_label=="Comparaison" 

destring SampleGroupe_label, replace
ren SampleGroupe_label Groupe
lab values Groupe grp
order Groupe,after(Ecole)

*Language
lab define lan 1"French" 2 "Wolof" 3 "Serer" 4"Pulaar"

replace SampleLangue_label="2" if SampleLangue_label=="Wolof"
replace SampleLangue_label="3" if SampleLangue_label=="Seereer"
replace SampleLangue_label="4" if SampleLangue_label=="Pulaar"

destring SampleLangue_label, replace
ren SampleLangue_label Language
lab values Language lan
order Language,after(Groupe)








