include libmaster.cmd

if_1 then {
    var mob %1
} else {
    echo *** findSpot error! No mob parameter given! ***
    echo .findSpot <mob>
    goto doneFail
}


init:

if ("%mob" = "adanf") then {
    var minRoomId 13
    var maxRoomId 16
    var waitroomid 31
}

if ("%mob" = "beisswurms") then {
    var minRoomId 31
    var maxRoomId 37
    var waitroomid 1
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

if ("%mob" = "eel") then {
    var minRoomId 234
    var maxRoomId 237
    var waitroomid 220
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
}

if ("%mob" = "leucro") then {
    var minRoomId 12
    var maxRoomId 22
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

if ("%mob" = "warklin") then {
    var minRoomId 117
    var maxRoomId 121
    var waitroomid 38
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


findRoom:
    if ($roomid = 0) then {
        gosub moveRandom
        goto findRoom
    }
    if ($roomid != %minRoomId) then {
        gosub automove %minRoomId
        gosub checkThisRoom
    }
    goto findRoom


checkThisRoom:
    if (("$roomplayers" != "" || $monstercount >= 2 || contains("$roomobjs", "dirt construct")) && !matchre("$roomplayers", "Maori")) then {
        math minRoomId add 1
        if (%minRoomId > %maxRoomId) then {
            if ("%mob" = "wyvern") then {
                put .findSpot wyvern2
                exit
            }
            gosub automove %waitroomid
            gosub hide
            put #echo >Log #FFCC01 [findSpot] No open %mob room
            echo ******************************
            echo * COULD NOT FIND OPEN ROOM
            echo * WAITING 120 SECONDS
            echo ******************************
            pause 120
            gosub shiver
            if ("%mob" = "wyvern2") then {
                put .findSpot wyvern
                exit
            }
            goto init
        }
        return
    } else {
        goto done
    }


done:
    echo FINDSPOT DONE
    put #parse FINDSPOT DONE
    exit


doneFail:
    echo FINDSPOT FAIL
    put #parse FINDSPOT FAIL
    exit