include libsel.cmd

if_1 then {
    var mob %1
} else {
    echo *** findSpot error! No mob parameter given! ***
    echo .findSpot <mob>
    goto doneFail
}



if ($roomid > 79 && $roomid < 97 && "$roomplayers" = "") then {
    pause
    goto done
}

var checkRoomId 80

findRoom:
    if ($roomid != %checkRoomId) then {
        gosub automove %checkRoomId
        gosub checkThisRoom
    }
    goto findRoom


checkThisRoom:
    if ("$roomplayers" != "") then {
        math checkRoomId add 1
        if (%checkRoomId > 97) then {
            put #walk telescope
            waitfor YOU HAVE ARRIVED
            echo ******************************
            echo * COULD NOT FIND OPEN ROOM
            echo ******************************
            goto doneFail
        }
        return
    } else {
        goto done
    }


done:
    put #parse FINDSPOT DONE
    exit


doneFail:
    put #parse FINDSPOT FAIL
    exit