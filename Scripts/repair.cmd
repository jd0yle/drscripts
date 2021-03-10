include libsel.cmd


if ("$zoneid" != "1" && "$zoneid" != "150") then {
    echo "***** NOT IN VALID START (CROSSING, FC) *****"
    exit
}

gosub stow right
gosub stow left

gosub get my ticket
if ("$righthandnoun" = "ticket") then goto pickupArmor

put .armor wear
waitforre ^ARMOR DONE

gosub automove teller
put withdraw 50 plat
pause

if ($zoneid = 1) then gosub repair.crossing
if ($zoneid = 150) then gosub repair.fangcove
goto done



pickupArmor:
    matchre pickupArmor2 (Catrox|Randal|Lakyan)
    put read my ticket
    matchwait 5
    gosub stow ticket
    goto done

pickupArmor2:
    var vendor $0
    if ("%vendor" = "Catrox") then {
        gosub automove catrox
        gosub give ticket to catrox
        put .armor wear
        waitforre ^ARMOR DONE$
        gosub stow right
        gosub get my ticket
    }
    if ("%vendor" = "Randal") then {
        gosub automove w gate
        gosub automove repair
        gosub give ticket to randal
        put .armor wear
        waitforre ^ARMOR DONE$
        gosub automove crossing
        gosub automove 258
        goto done
    }
    if ("%vendor" = "Lakyan") then {
        gosub automove repair leather
        gosub give ticket to repairman
        put .armor wear
        waitforre ^ARMOR DONE$
        gosub stow right
        gosub automove 106
        goto done
    }
    goto done



repair.crossing:
    gosub automove catrox
    put ask catrox about repair all
    pause
    put ask catrox about repair all
    pause
    gosub stow ticket

    gosub automove w gate
    gosub automove repair

    put ask randal about repair all
    pause
    put ask randal about repair all
    pause
    gosub stow ticket

    gosub automove crossing
    put .dep
    waitforre ^DEP DONE$
    gosub automove 258

    return


repair.fangcove:
    gosub automove repair leather
    if (contains("$roomobjs", "apprentice repairman")) then {
        put ask repairman about repair all
        pause
        put ask repairman about repair all
        pause
        gosub stow ticket
    } else {
        put ask lakyan about repair all
        pause
        put ask lakyan about repair all
        pause
        gosub stow ticket
    }

    put .dep
    waitforre ^DEP DONE$
    gosub automove 106
    return



done:
    pause .2
    put #parse REPAIR DONE
    exit
