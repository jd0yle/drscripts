include libmaster.cmd
###############################
###    Darkbox
###############################


###############################
###    IDLE ACTIONS
###############################
if ("$guild" <> "Empath") then {
    action goto darkbox.getHealed when ^Unfortunately, your wounds make it impossible for you to play the Darkbox\.$
} else {
    action goto darkbox.pauseForRegen when ^Unfortunately, your wounds make it impossible for you to play the Darkbox\.$
}
action put #echo >Log [darkbox] Found $1; put #log >darkbox_prizes.log [$datetime] $1 when ^As you remove your hand from the Darkbox you see (.*?) in your grasp!
action goto darkbox.getCoins when ^You try to play the Darkbox, but realize you don't have the


###############################
###    VARIABLES
###############################
var trashItems sharkskin|rockweed

###############################
###    LOCATION CHECK
###############################
if (!matchre("$roomobjs", "the Darkbox")) then {
	gosub darkbox.moveToDarkbox
} else {
	put #tvar darkbox.lastKnownRoomId $roomid
}

goto darkbox.loop


###############################
###    MAIN
###############################
darkbox.loop:
	if ("$righthand" != "Empty") then gosub put my $righthandnoun in my $char.inv.defaultContainer
	if ("$lefthand" != "Empty") then gosub put my $lefthandnoun in my $char.inv.defaultContainer
	put play darkbox
	pause
	goto darkbox.loop


darkbox.getCoins:
	gosub automove bank
	gosub withdraw 10 plat
	gosub darkbox.moveToDarkbox
	put .darkbox


darkbox.pauseForRegen:
    pause 10
    goto darkbox.loop


darkbox.getHealed:
	if (!(%darkbox.lastKnownRoom) > 0) then var darkbox.lastKnownRoom $roomid
	gosub darkbox.moveToHouse
	gosub whisper inauri heal
	pause 10
	if ($bleeding = 1) then goto darkbox.healingError
	gosub darkbox.moveToDarkbox
	goto darkbox.loop


darkbox.getHealedCont:
	gosub automove portal
	gosub move go portal
	gosub automove 50
	gosub runScript house
	gosub whisper inauri heal
	pause 20
	gosub runScript house
	gosub automove portal
	gosub move go portal
	gosub automove dock

	matchre darkbox.findDarkbox Andreshlew, South Dock
	put whistle for dolphin transport
	matchwait 20
	goto done.error


darkbox.findDarkbox:
		gosub automove %darkbox.lastKnownRoom
		gosub runScript findDarkbox
		goto darkbox.loop


darkbox.moveToDarkbox:
	if (matchre("$roomobjs", "the Darkbox")) then return

	if ("$roomname" = "Private Home Interior") then {
		gosub runScript house
		goto darkbox.moveToDarkbox
	}

	if ($zoneid = 0) then {
		if (%darkbox.lastKnownRoom > 0) then {
			if ($roomid = %darkbox.lastKnownRoom) then {
				var darkbox.lastKnownRoom -1
				goto darkbox.moveToDarkbox
			}
			gosub automove %darkbox.lastKnownRoom
			goto darkbox.moveToDarkbox
		}
		gosub runScript findDarkbox
		goto darkbox.moveToDarkbox
	}

	if ($zoneid = 1) then {
		pause
		if ($zoneid != 1) then goto darkbox.moveToDarkbox
		if (contains("$roomname", "Andreshlew")) then goto darkbox.moveToDarkbox
		pause
		gosub automove dock
        pause
		put whistle for dolphin transport
		pause 10
		goto darkbox.moveToDarkbox
	}

	if ($zoneid = 150) then {
		if ($zoneid != 150) then goto darkbox.moveToDarkbox
		if ($roomid != 2) then gosub automove 2
		put whistle for dolphin transport
		pause 10
		goto darkbox.moveToDarkbox
	}

	goto darkbox.moveToDarkbox


darkbox.moveToHouse:
	if ("$roomname" = "Private Home Interior") then return

	if ($zoneid = 0) then {
		if (contains("$roomname", "Fang Cove")) then goto darkbox.moveToHouse
		gosub automove dolphin
		put go corral
		pause 10
		goto darkbox.moveToHouse
	}

	if ($zoneid = 1) then {
		gosub automove portal
		gosub move go portal
		goto darkbox.moveToHouse
	}

	if ($zoneid = 150) then {
		if ($roomid = 50) then {
			gosub runScript house
		} else {
			gosub automove 50
		}
		goto darkbox.moveToHouse
	}

	goto darkbox.moveToHouse