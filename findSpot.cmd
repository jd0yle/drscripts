include libmaster.cmd

if_1 then {
    var mob %1
} else {
    echo *** findSpot error! No mob parameter given! ***
    echo .findSpot <mob>
    goto doneFail
}

if_2 then {
    var nowait 1
}


init:

if ("%mob" = "adanf") then {
    var minRoomId 13
    var maxRoomId 16
    var waitroomid 31
}

if ("%mob" = "adultwyvern") then {
    var minRoomId 468
    var maxRoomId 479
    var waitroomid 388
    var preferredRoomId 468
}

if ("%mob" = "beisswurms") then {
    var minRoomId 31
    var maxRoomId 37
    var waitroomid 1
}

if ("%mob" = "blackgargoyle") then {
    var minRoomId 380
    var maxRoomId 418
    var waitroomid 370
    var preferredRoomId 415
}

if ("%mob" = "bobcat") then {
    var minRoomId 79
    var maxRoomId 84
    var waitroomid 50
}

if ("%mob" = "bull") then {
    var minRoomId 82
    var maxRoomId 97
    var waitroomid telescope
}

if ("%mob" = "caracal") then {
    var minRoomId 189
    var maxRoomId 202
    var waitroomid 163
}

if ("%mob" = "cloudrat") then {
    var minRoomId 611
    var maxRoomId 612
    var waitroomid 435
}

if ("%mob" = "eel") then {
    var minRoomId 234
    var maxRoomId 237
    var waitroomid 220
}

if ("%mob" = "fuliginmoth") then {
    var minRoomId 213
    var maxRoomId 219
    var waitroomid 185
    var preferredRoomId 217
}

if ("%mob" = "gargoyle") then {
    var minRoomId 65
    var maxRoomId 75
    var waitroomid 50
}

if ("%mob" = "gerbil") then {
    var minRoomId 35
    var maxRoomId 40
    var waitroomid 1
}

if ("%mob" = "shardbull") then {
    var minRoomId 597
    var maxRoomId 605
    var waitroomid 435
}

if ("%mob" = "telga") then {
    var minRoomId 515
    var maxRoomId 525
    var waitroomid 435
}

if ("%mob" = "fcrat") then {
    var minRoomId 162
    var maxRoomId 164
    var waitroomid 106
}

if ("%mob" = "gremlin") then {
    var minRoomId 109
    var maxRoomId 117
    var waitroomid 89
}

if ("%mob" = "kobold") then {
    var minRoomId 289
    var maxRoomId 294
    var waitroomid 198
}

if ("%mob" = "juvenilewyvern") then {
    var minRoomId 454
    var maxRoomId 463
    var waitroomid 388
    var preferredRoomId 454
}

if ("%mob" = "leucro") then {
    var minRoomId 12
    var maxRoomId 22
}

if ("%mob" = "mauler") then {
    var minRoomId 566
    var maxRoomId 571
    var waitroomid 370
    var preferredRoomId 571
}

if ("%mob" = "peccary") then {
    var minRoomId 255
    var maxRoomId 263
    var waitroomid 163
}

if ("%mob" = "redgremlin") then {
    var minRoomId 622
    var maxRoomId 632
    var waitroomid 545
}

if ("%mob" = "stomper") then {
    var minRoomId 560
    var maxRoomId 565
    var waitroomid 370
}

if ("%mob" = "warklin") then {
    var minRoomId 117
    var maxRoomId 121
    var waitroomid 38
    var preferredRoomId 119
}

if ("%mob" = "wyvern") then {
    var minRoomId 567
    var maxRoomId 572
    var waitroomid 388
}

if ("%mob" = "wyvern2") then {
    var minRoomId 480
    var maxRoomId 487
    var waitroomid 435
}


if ($roomid >= %minRoomId && $roomid <= %maxRoomId && "$roomplayers" = "" && !contains("$roomobjs", "dirt construct")) then {
    pause 1
    goto done
}

if ("%mob" = "wyvern" || "%mob" = "wyvern2" && "$roomplayers" = "") then {
    if ( ($roomid >= 567 && $roomid <= 572) || ($roomid >= 480 && $roomid <= 487)) then {
        pause .2
        goto done
    }
}

evalmath numRooms (%maxRoomId - %minRoomId)
var currentRoomId %minRoomId
if (%preferredRoomId > 0) then var currentRoomId %preferredRoomId


checkThisRoom:
	if ("$roomid" != "%currentRoomId") then {
		if ($roomid = 0) then gosub moveRandom
		gosub automove %currentRoomId
		goto checkThisRoom
	}

	if ("$roomplayers" = "" && $monstercount < 2 && !contains("$roomobjs", "dirt construct") ) then goto done

	if ("$roomplayers" != "") then put #echo >Debug Room $roomid full: $roomplayers

    math currentRoomId add 1
    math numRooms subtract 1
    if (%numRooms <= 0) then goto waitForRoom

    if (%currentRoomId > %maxRoomId) then var currentRoomId %minRoomId
	goto checkThisRoom


waitForRoom:
	if ("%mob" = "wyvern") then put .findSpot wyvern2
    gosub automove %waitroomid
    #gosub hide
    put #echo >Log #FFCC01 [findSpot] No open %mob room
    echo ******************************
    echo * COULD NOT FIND OPEN ROOM
    echo * WAITING 120 SECONDS
    echo ******************************
    evalmath waitForRoomUntilTime ($gametime + 120)
    gosub waitForRoomLoop
    gosub shiver
    if ("%nowait" = "1") then goto done
    if ("%mob" = "wyvern2") then put .findSpot wyvern

    goto init


waitForRoomLoop:
	if ($gametime > %waitForRoomUntilTime) then {
		put #script abort play
		gosub stow right
		gosub stow left
		return
	}

	if ($Performance.LearningRate < $Outdoorsmanship.LearningRate) then {
		gosub runScript play
	} else {
		gosub collect dirt
		gosub kick pile
	}

	goto waitForRoomLoop


done:
    echo FINDSPOT DONE
    put #parse FINDSPOT DONE
    exit


doneFail:
    echo FINDSPOT FAIL
    put #parse FINDSPOT FAIL
    exit