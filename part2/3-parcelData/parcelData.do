* John Paul E. Kapp // G21860132

clear all

global path "/Users/g21860132/Desktop/stataData/part2/3-parcelData"
import delimited "$path/parcelData.csv"

describe

label var parcelidentifier "Parcel Identifier"
label var taxyear "Tax Year"
label var livableunits "Livable Units"
label var locationdescription "Location Description"
label var streetdescription "Street Description"
label var landusetypedescription "Land Use Type Description"
label var waterutilitydescription "Water Utility Description"
label var sewerutilitydescription "Sewer Utility Description"
label var gasutilitydescription "Gas Utility Description"
label var zoningdescription "Zoning Descripton"

save "$path/parcelData.dta", replace

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
save "$path/parcelData.dta", replace
clear all
global path "/Users/g21860132/Desktop/stataData/part2"
