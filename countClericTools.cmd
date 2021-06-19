include libmaster.cmd

var numIncense 0
var numHolyWater 0

action evalmath numIncense (%numIncense + 1) when Your fragrant incense
action evalmath numHolyWater (%numHolyWater + 1) when Your holy water is in a large jar

gosub inv search incense
pause
put #echo >Log Incense: %numIncense

gosub inv search holy water
pause
put #echo >Log Holy water: %numHolyWater

put #var char.tools.numIncense %numIncense
put #var char.tools.numHolyWater %numHolyWater

pause .2
put #parse COUNTCLERICTOOLS DONE
exit