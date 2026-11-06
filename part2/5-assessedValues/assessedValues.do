* John Paul E. Kapp // G21860132

clear all

global path "/Users/g21860132/Desktop/stataData/part2/5-assessedValues"
import delimited "$path/assessedValues.csv"

describe

label var parcelidentifier "Parcel Identifier"
label var taxyear "Tax Year"
label var finalappraisedvalueforland "Final Appraised Value for Land"
label var finalappraisedvalueforbuilding "Final Appraised Value for Building"
label var finalappraisedvaluefortotal "Final Appraised Value for Total"
label var prioryearappraisedvalueforland "Prior Year Appraised Value for Land"
label var prioryearappraisedvalueforbuildi "Prior Year Appraised Value for Building"
label var prioryearappraisedvaluetotal "Prior Year Appraised Value Total"
label var taxexemptcodedescription "Tax Exempt Code Description"

save "$path/assessedValues.dta", replace

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
save "$path/assessedValues.dta", replace
clear all
global path "/Users/g21860132/Desktop/stataData/part2"
