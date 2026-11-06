* John Paul E. Kapp // G21860132

clear all

global path "/Users/g21860132/Desktop/stataData/part2/6-legalData"
import delimited "$path/legalData.csv"

describe

label var parcelidentifier "Parcel Identifier"
label var taxyear 
label var deededlandareainacres 
label var legaladdressprefix 
label var legaladdressnumber 
label var legaladdressnumbersuffix 
label var legaladdressstreetdirectional 
label var legaladdressstreetname 
label var legaladdressstreettype 
label var legaladdresssecondsuffix 
label var cityname 
label var zipcode 
label var deededlandareainsqfeet 
label var taxdistrict 
label var legalinfoline1 
label var legalinfoline2 
label var legalinfoline3 
label var taxdistrictdescription

save "$path/legalData.dta", replace

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
* Carrillo's file also had us drop "creator" "editdate" "editor" "iobjectid"

compress
sort parcelidentifier
save "$path/legalData.dta", replace
clear all
global path "/Users/g21860132/Desktop/stataData/part2"
