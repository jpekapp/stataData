* John Paul E. Kapp // G21860132

clear all
global path "/Users/g21860132/Desktop/stataData/part2"

run "$path/1-dwellingData/dwellingData.do"
run "$path/2-landData/landData.do"
run "$path/3-parcelData/parcelData.do"
* run"$path/4-ownerData/ownerData.do"
run "$path/5-assessedValues/assessedValues.do"
run "$path/6-legalData/legalData.do"
run "$path/7-addressPoints/addressPoints.do"
run "$path/8-salesData/salesData.do"
