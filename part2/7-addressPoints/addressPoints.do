* John Paul E. Kapp // G21860132

clear all

global path "/Users/g21860132/Desktop/stataData/part2"
import delimited "$path/7-addressPoints/addressPoints.csv", clear

capture confirm variable parcelidentificationnumber, exact
if !_rc {
    rename parcelidentificationnumber parcelidentifier
    display "Renamed parcelidentificationnumber to parcelidentifier"
}
else {
	display "parcelidentificationnumber not present; skipping."
}

capture confirm variable x, exact
if !_rc {
    rename x lon
    display "Renamed x to lon"
}
else {
	display "x not present; skipping."
}

capture confirm variable y, exact
if !_rc {
    rename y lat
    display "Renamed y to lat"
}
else {
	display "y not present; skipping."
}

describe

label var primaryaddresskey "Primary Address Key"
label var siteaddressid "Site Address ID"
label var transportationpointid "Transportation Point ID"
label var addresslocationx "Address Location Lon"
label var addresslocationy "Address Location Lat"
label var parcelidentifier "Parcel Identifier"
label var addressnumber "Address Number"
label var addressnumbersuffix "Address Number Suffix"
label var streetprefix "Street Prefix"
label var streetname "Street Name"
label var streettype "Street Type"
label var streetsuffix "Street Suffix"
label var fullroadname "Full Road Name"
label var unittype "Unit Type"
label var unitnumber "Unit Number"
label var city "City"
label var state "State"
label var zipcode "ZIP Code"
label var addressline1 "Address Line 1"
label var addresscreateddate "Address Created Date"
label var addressstatus "Address Status"
label var jurisdiction "Jurisdiction"
label var supervisordistrict "Supervisor District"
label var subdivisionname "Subdivision Name"
label var subdivisionsection "Subdivision Section"
label var subdivisionblock "Subdivision Block"
label var subdivisionphase "Subdivision Phase"
label var cadmunicipality "CAD Municipality"
label var cadarea "CAD Area"
label var transportationid "Transportation ID"
label var segmentid "Segment ID"
label var addresstype "Address Type"
label var addressdatasource "Address Data Source"
label var plannumber "Plan Number"
label var pointtype "Point Type"
label var esn "ESN"
label var addresschangedate "Address Change Date"
label var addressexpireddate "Address Expired Date"
label var citystatezip "City, State, and ZIP"
label var globalid "Global ID"
label var fulladdressnumber "Full Address Number"
label var lon "Longitude"
label var lat "Latitude"

save "$path/7-addressPoints/addressPoints.dta", replace

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

keep lat lon parcelidentifier zipcode

sort parcelidentifier
compress
save "$path/7-addressPoints/addressPoints.dta", replace
clear all
global path "/Users/g21860132/Desktop/stataData/part2"
