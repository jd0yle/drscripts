include libmaster.cmd

action var jarFull 1 when There is no more room in the witch doctor's jar for some water.

var i 0

put #var char.inventory.numHolyWater 0
put #var char.inventory.numIncense 0
gosub runScript countClericTools

if ($char.inventory.numHolyWaterParts = 0) then {
	put #echo >Log [getClericTools] Fetching water
	#gosub getClericTools.getWater
	gosub getClericTools.getWaterP5
}
if ($char.inventory.numIncense < 40) then {
	put #echo >Log [getClericTools] Fetching Incense
	gosub getClericTools.getIncenseP5
}

if ($char.inventory.numHolyWaterParts = 0 || $char.inventory.numIncense < 10) then gosub runScript countClericTools

goto getClericTools.done




getClericTools.getIncense:
	if ("$roomname" = "Private Home Interior") then gosub runScript house
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
    gosub put my incense in my $char.inv.container.incense
    pause .1
    math i add 1
    if (%i > 100) then return
    goto getClericTools.buyIncense



getClericTools.getIncenseP5:
	if ("$roomname" = "Private Home Interior") then gosub runScript house
	if ("$zoneid" != "116") then gosub runScript travel hib teller
	gosub runScript deposit
	gosub automove teller
	gosub withdraw 1 plat
	var i 0

getClericTools.buyIncenseP5:
    if ("$roomid" != "219") then gosub automove 219
    put buy incense
    gosub put my incense in my $char.inv.container.incense
    pause .1
    math i add 1
    if (%i > 50) then {
        gosub runScript deposit
        return
    }
    goto getClericTools.buyIncenseP5



getClericTools.getWater:
	#if ("$zoneid" != "66") then gosub runScript travel steel 11
	#if ("$roomid" != "11") then gosub automove 11
	if ("$roomname" = "Private Home Interior") then gosub runScript house
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



getClericTools.getWaterP5:
	if ("$roomname" = "Private Home Interior") then gosub runScript house
	if ("$zoneid" != "127") then {
		gosub runScript travel boar 230
		goto getClericTools.getWaterP5
	}
    if ("$roomid" != 221) then gosub automove 230
	gosub stow right
	gosub stow left
	var i 0

getClericTools.fillJarP5:
	if ("$righthandnoun" != "jar") then gosub get my jar
	put fill my jar with water from cistern
	put fill my jar with water from cistern
	pause .1
	math i add 1
	if (%jarFull = 1 || %i > 100) then {
		gosub release spell
		gosub prepare bless
		pause 3
		gosub cast water in my jar
		gosub stow my jar
		return
	}
	goto getClericTools.fillJarP5




getClericTools.done:
	pause .2
	put #parse GETCLERICTOOLS DONE
	exit