* John Paul E. Kapp // G21860132

clear all

global path "/Users/g21860132/Desktop/stataData/part2"
import delimited "$path/2-landData/landData.csv"

describe

label var objectid "Object Identifier"
label var parcelidentifier "Parcel Identifier"
label var taxyear "Tax Year"
label var linenumber "Line Number"
label var landsizeinsquarefeet "Size of Land in Square Feet"
label var landsizeinacres "Size of Land in Acres"
label var numberofunits "Number of Units"
label var landdescription "Description of Land"

save "$path/2-landData/dwellingData.dta", replace

duplicates tag parcelidentifier, gen(ndup)
tab ndup
* ndup = number of duplicates

* Drop the duplicates
drop if ndup > 0

drop ndup
* Run the report again...
duplicates tag parcelidentifier, gen(ndup)
tab ndup
* No duplicates left.

* save space, drop vars we don't need (anymore)...
drop ndup objectid
* Carrillo's file also had us drop "creator" "editdate" "editor" "iobjectid" (COPIED FROM dwellingData.do)

compress
sort parcelidentifier
save "$path/2-landData/dwellingData.dta", replace
clear all
global path "/Users/g21860132/Desktop/stataData/part2"
