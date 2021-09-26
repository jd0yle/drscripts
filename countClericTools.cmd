include libmaster.cmd

var numIncense 0
var numHolyWater 0
var numHolyWaterParts 0

action evalmath numIncense (%numIncense + 1) when a stick of fragrant incense
action evalmath numHolyWater (%numHolyWater + 1) when Your holy water is in a
action var numHolyWaterParts $1 when ^There are (.*) parts left of the holy water\.$

gosub runScript count --item=incense --container=$char.inv.defaultContainer
var numIncense $char.countResult
put #echo >Log Incense: %numIncense

gosub runScript count --item=holy water --container=witch jar
var numHolyWater $char.countResult

gosub count holy water in my witch jar
pause
put #echo >Log Holy Water: %numHolyWater -- Parts: %numHolyWaterParts

put #var char.inventory.numIncense %numIncense
put #var char.inventory.numHolyWater %numHolyWater
put #var char.inventory.numHolyWaterParts %numHolyWaterParts

pause .2
put #parse COUNTCLERICTOOLS DONE
exit