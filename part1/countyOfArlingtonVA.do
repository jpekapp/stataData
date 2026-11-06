clear all

cd "/Users/g21860132/Desktop/stataData/part1/PopDataVA"  
// write the directory where your data are located

global outdir "/Users/g21860132/Desktop/stataData/part1/resultsMaps"
capture mkdir "$outdir"

import delimited "PopDataVA.csv", clear

label var pop100 "Total population"
label var p003002 "Total population: White alone"
label var p003003 "Total population: Black or African American"
label var p003001 "Total population"


browse name p003001 p003002 p003003

gen pblack= p003003/p003001
label var pblack "Percentage of Blacks"

gen pwhite= p003002/p003001
label var pwhite "Percentage of Whites"

sum pwhite, de
sum pblack, de

* now let me compute the dissimilarity indices

* I NEED TO SELECT ONLY Arlington COUNTY; DO NOT NEED THE REST OF COUNTIES
* NOTICE THAT Arlington COUNTY FIPS CODE IS "059"

keep if county==13

* FIRST WE NEED TO KNOW WHAT THE TOTAL WHITE AND BLACK POPULATION ARE:

egen TotB=sum(p003003)
egen TotW=sum(p003002)

browse TotB p003003 TotW p003002

* WE CAN NOW COMPUTE THE CONTRIBUTIONS TO THE DISS. INDEX

gen Di=0.5*abs(p003003/TotB-p003002/TotW)

* THE INDEX IS THE SUM OF THE INDIVIDUAL CONTRIBUTIONS

egen D=sum(Di)

sum D

* NOW WE SAVE THE RELEVANT VARIABLES FOR THE MAPS WE WILL DRAW

keep geoid pwhite pblack p003001 p003002 p003003 Di D

sort geoid
save ArlingtonStatsCT.dta, replace


* WE ARE NOW READY TO CREATE MAPS

*1] FIRST WE NEED TO INSTALL/UPDATE THE RELEVANT STATA COMMANDS

ssc install spmap, replace
ssc install shp2dta, replace
ssc install mif2dta, replace

*2] TRANSLATING THE SHAPE FILES INTO STATA (NOTE THAT I NEED TO USE VA FILES)


shp2dta using tl_2010_51_tract10, database(VA_tractdb) coordinates(VA_tractcoord) genid(id) replace

*3] DETERMINE WHAT CODING IS USED BY THE MAP

use VA_tractdb, clear

*4] CREATE A VARIABLE THAT I CAN USE TO MATCH THIS FILE TO THE DESCRIPTIVE STATS

gen double geoid=real(GEOID10)
sort geoid

* WE FOCUS ON Arlington COUNTY!

keep if COUNTYFP10=="013"

*5] LET'S MERGE BOTH DATASETS

merge 1:1 geoid using "ArlingtonStatsCT.dta"
tab _merge
keep if _merge==3

*6] WE ARE NOW READY TO CREATE MAPS WITH STATA


* LET'S DRAW A MAP SHOWING THE PERCENTAGE OF THE POPULATION THAT IS WHITE

spmap pwhite using VA_tractcoord, id(id) fcolor(Reds) ///
    title("Percentage of Whites, Arlington County")

graph export "$outdir/arlington_pwhite.png", replace width(2000)


* LET'S DRAW A MAP SHOWING THE PERCENTAGE OF THE POPULATION THAT IS BLACK

spmap pblack using VA_tractcoord, id(id) fcolor(Blues) ///
    title("Percentage of Blacks, Arlington County")

graph export "$outdir/arlington_pblack.png", replace width(2000)

* WE CAN ALSO COMPUTE A MAP OF POPULATION DENSITY (POP / SQ METER)

gen density=p003001/ALAND10
spmap density using VA_tractcoord, id(id) fcolor(Greens) ///
    title("Population Density (per Square Meter), Arlington County")

graph export "$outdir/arlington_pwhite.png", replace width(2000)

