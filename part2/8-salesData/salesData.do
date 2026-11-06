* John Paul E. Kapp // G21860132

clear all

global path "/Users/g21860132/Desktop/stataData/part2"

cd "$path/8-salesData"

unzipfile "salesData.csv.zip", replace

import delimited "$path/8-salesData/salesData.csv", clear

describe

label var objectid "Object Identifier"
label var parcelidentifier "Parcel Identifier"
label var taxyear "Tax Year"
label var saledate "Sale Date"
label var saleprice "Sale Price"
label var deedbook "Deed Book"
label var deedpage "Deed Page"
label var salenotes "Sale Notes"

save "$path/salesData.dta", replace

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

drop ndup

* BEGIN: Lifted from Carrillo's Empirical Project Pt II PDF

** LET ' S FIND THE DATE OF SALE

gen yy=substr(saledate ,1 ,4)
gen mm=substr(saledate ,6 ,2)
gen dd=substr(saledate ,9 ,2)

gen date_text =yy+"/"+mm+"/"+dd

gen t=date(date_text,"YMD")
format t %td

* WE DO NOT NEED THESE V AR I AB LE S ANYMORE :
drop yy mm dd date_text saledate

gen yy=year(t)
gen mm=month(t)
gen qq=quarter(t)

* END: Lifted from Carrillo's Empirical Project Pt II PDF

* ENDING CODE, "WIND DOWN"
save "$path/8-salesData/salesData.dta", replace
clear all
cd "$path"
