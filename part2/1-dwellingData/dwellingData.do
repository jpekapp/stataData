* John Paul E. Kapp // G21860132

clear all

global path "/Users/g21860132/Desktop/stataData/part2/1-dwellingData"
import delimited "$path/dwellingData.csv"

describe

label var objectid "Object Identifier"
label var parcelidentifier "Parcel Identifier"
label var style "Style"
label var yearbuilt "Year Built"
label var effectiveyearbuiltfromremodel "Effective Year House Remodeled"
label var yearhouseremodeled "Year House Remodeled"
label var bedroomcount "Count of Bedrooms"
label var fullbathcount "Count of Full Bathrooms"
label var halfbathcount "Count of Half Bathrooms"
label var basementrecroomsizesqft "Recreation Room in Basement; Size in Square Feet"
label var numberoffireplaces "Count of Fireplaces"
label var basementgarageofcars "Basement Garage of Cars"
label var modelname "Model Name"
label var basementbedroomsdenscount "Count of Basement Bedrooms, Dens"
label var constructionqualitygrade "Grade of Construction Quality"
label var abovegradelivingareatotalsqft "Total Square Feet of Living Area Above Grade"
label var basementdescription "Description of Basement"
label var physicalconditiondescription "Description of Physical Condition" 
label var exteriorwallmaterial "Material of Exterior Wall" 
label var heatingdescription "Description of Heating" 
label var rooftypedescription "Description of Roof Type"
label var dormertypedescription "Description of Dormer Type"
label var basementtypedescription "Description of Basement Type"

save "$path/dwellingData.dta", replace

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
save "$path/dwellingData.dta", replace
clear all
global path "/Users/g21860132/Desktop/stataData/part2"
