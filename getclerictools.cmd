include libmaster.cmd

action var jarFull 1 when There is no more room in the witch doctor's jar for some water.

var i 0

gosub getClericTools.getWater
gosub getClericTools.getIncense

goto getClericTools.done




getClericTools.getIncense:
	if ("$zoneid" != "67") then gosub runScript travel shard teller
	gosub runScript dep
	gosub automove teller
	gosub withdraw 1 plat
	var i 0

getClericTools.buyIncense:
    if ("$roomid" != "436") then gosub automove 436
    put order incense
    put offer 45
    gosub stow my incense
    pause .1
    math i add 1
    if (%i > 100) then return
    goto getClericTools.buyIncense



getClericTools.getWater:
	if ("$zoneid" != "66") then gosub runScript travel steel 11
	if ("$roomid" != "11") then gosub automove 11
	gosub stow right
	gosub stow left
	var i 0

getClericTools.fillJar:
	if ("$righthandnoun" != "jar") then gosub get my jar
	put fill my jar with water from well
	put fill my jar with water from well
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

	goto getClericTools.fillJar


getClericTools.done:
	pause .2
	put #parse GETCLERICTOOLS DONE
	exit