include libsel.cmd

if_1 then {
    var mob %1
} else {
    echo *** findSpot error! No mob parameter given! ***
    echo .findSpot <mob>
    goto doneFail
}



if ("%mob" = "bull" && $roomid > 81 && $roomid < 97 && "$roomplayers" = "") then {
    pause
    goto done
}

init:

if ("%mob" = "bull") then {
    var checkRoomId 82
    var maxRoomId 97
    var waitroomid telescope
}

if ("%mob" = "leucro") then {
    var checkRoomId 16
    var maxRoomId 22
}

if ("%mob" = "gremlin") then {
    var checkRoomId 109
    var maxRoomId 117
    var waitroomid 89
}

if ("%mob" = "redgremlin") then {
    var checkRoomId 622
    var maxRoomId 632
    var waitroomid 545
}

if ("%mob" = "peccary") then {
    var checkRoomId 257
    var maxRoomId 263
    var waitroomid 163
}

if ("%mob" = "warklin") then {
    var checkRoomId 39
    var maxRoomId 47
    var waitroomid 8
}

if ("%mob" = "wyvern") then {
    var checkRoomId 567
    var maxRoomId 572
    var waitroomid 436
}


if ($roomid >= %checkRoomId && $roomid <= %maxRoomId && "$roomplayers" = "") then {
    pause 1
    goto done
}


findRoom:
    if ($roomid = 0) then {
        gosub moveRandom
        goto findRoom
    }
    if ($roomid != %checkRoomId) then {
        gosub automove %checkRoomId
        gosub checkThisRoom
    }
    goto findRoom


checkThisRoom:
    if (("$roomplayers" != "" || $monstercount >= 2) && !matchre("$roomplayers", "Maori")) then {
        math checkRoomId add 1
        if (%checkRoomId > %maxRoomId) then {
            gosub automove %waitroomid
            gosub hide
            echo ******************************
            echo * COULD NOT FIND OPEN ROOM
            echo * WAITING 120 SECONDS
            echo ******************************
            pause 120
            gosub shiver
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