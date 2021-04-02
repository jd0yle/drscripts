include libmaster.cmd


gosub moveToBurgleSpot

gosub release spell
gosub prep eotb
put .armor remove
waitforre ^ARMOR DONE$
gosub cast

put .burgle
waitfor BURGLE DONE

put .armor wear
waitfor ARMOR DONE

gosub release eotb

gosub moveToCrossing
gosub automove pawn

put .pawn
waitforre ^PAWN DONE$

put .dep
waitforre ^DEP DONE$

gosub moveToNGate
gosub moveToLounge

put #parse QIZBURGLE DONE
exit


moveToNGate:
    if ($zoneid = 6) then return
    gosub automove n gate
    pause .2
    goto moveToNGate

moveToLounge:
    if ($zoneid = 6 && $roomid = 262) then return
    gosub automove lounge
    pause .2
    goto moveToLounge

moveToCrossing:
    if ($zoneid = 1) then return
    gosub automove crossing
    pause .2
    goto moveToCrossing


moveToBurgleSpot:
    # Outside N Gate
    if ("$zoneid" = "6") then {
        gosub automove path

        if ($roomid = 172) then {
            gosub move go path
            pause
        }

        gosub automove w gate
    }

    # Crossing
    if ("$zoneid" = "1") then {
        gosub automove w gate
    }

    #West Gate
    if ("$zoneid" = "4" && $roomid != 450) then {
    pause
        gosub automove 450
    }

    return
