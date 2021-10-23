include libmaster.cmd

action var jarFull 1 when There is no more room in the witch doctor's jar for some water.

var i 0

put #var char.inventory.numHolyWater 0
put #var char.inventory.numIncense 0
gosub runScript countClericTools

if ($char.inventory.numHolyWaterParts = 0) then {
	put #echo >Log [getClericTools] Fetching water
	gosub getClericTools.getWater
}
if ($char.inventory.numIncense < 11) then {
	put #echo >Log [getClericTools] Fetching Incense
	gosub getClericTools.getIncense
}

if ($char.inventory.numHolyWaterParts = 0 || $char.inventory.numIncense < 10) then gosub runScript countClericTools

goto getClericTools.done




getClericTools.getIncense:
	#if ("$zoneid" != "67") then gosub runScript travel shard teller
	if ("$zoneid" != "1") then gosub runScript travel crossing teller
	gosub runScript deposit
	gosub automove teller
	gosub withdraw 1 plat
	var i 0

getClericTools.buyIncense:
	# 436 is for shard
    #if ("$roomid" != "436") then gosub automove 436
    # 407 is for crossing
    if ("$roomid" != "407") then gosub automove 407
    put order incense
    put offer 62
    gosub stow my incense
    pause .1
    math i add 1
    if (%i > 100) then return
    goto getClericTools.buyIncense



getClericTools.getWater:
	#if ("$zoneid" != "66") then gosub runScript travel steel 11
	#if ("$roomid" != "11") then gosub automove 11
	if ("$zoneid" != "2a") then {
		gosub runScript travel crossing 43
		gosub automove temple
		goto getClericTools.getWater
	}
    if ("$roomid" != "67") then gosub automove 67
	gosub stow right
	gosub stow left
	var i 0

getClericTools.fillJar:
	if ("$righthandnoun" != "jar") then gosub get my jar
	#put fill my jar with water from well
	#put fill my jar with water from well
	put fill my jar with water from basin
	put fill my jar with water from basin
	pause .1
	math i add 1
	if (%jarFull = 1 || %i > 100) then {
		gosub release spell
		gosub prepare bless
		pause 3
		gosub cast water in my jar
		gosub stow my jar
		gosub runScript travel crossing portal
		return
	}

	goto getClericTools.fillJar


getClericTools.done:
	pause .2
	put #parse GETCLERICTOOLS DONE
	exit