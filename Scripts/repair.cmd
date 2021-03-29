include libsel.cmd

var weapons nightstick|diamondique hhr'ata|triple-weighted bola|assassin's blade

if ("$zoneid" != "1" && "$zoneid" != "150") then {
    echo "***** NOT IN VALID START (CROSSING, FC) *****"
    exit
}

gosub stow right
gosub stow left


getTicket:
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
    matchre pickupArmor2 (Catrox|Randal|Lakyan|Osmandikar)
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
        gosub give ticket to Lakyan
        put .armor wear
        waitforre ^ARMOR DONE$
        gosub stow right

        if ($righthandnoun = "sack") then {
	        put .armor wear
	        waitforre ^ARMOR DONE$
	        gosub stow right
        } else {
	        gosub stow right
	        gosub stow left
        }
        gosub get my lakyan ticket
        if ("$righthandnoun" = "ticket") then {
            gosub pickupArmor2 Lakyan
        }
    }
    if ("%vendor" = "Osmandikar") then {
        gosub automove repair metal
        gosub give ticket to osmandikar
        if ($righthandnoun = "sack") then {
	        put .armor wear
	        waitforre ^ARMOR DONE$
	        gosub stow right
        } else {
	        gosub stow right
	        gosub stow left
        }
        gosub get my osmandikar ticket
        if ("$righthandnoun" = "ticket") then {
            gosub pickupArmor2 Osmandikar
        }

    }

    gosub get my ticket
    if ("$righthandnoun" = "ticket") then goto pickupArmor

    gosub automove 106
    put .armor wear
    waitforre ^ARMOR DONE$
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

    gosub automove repair metal
    gosub stow right
    gosub stow left

    gosub get my nightstick
    gosub give osmandikar
    gosub give osmandikar
    gosub stow ticket
    gosub stow nightstick

    gosub get my assassin's blade
    gosub give osmandikar
    gosub give osmandikar
    gosub stow ticket
    gosub stow my blade

    gosub get my bola
    gosub give osmandikar
    gosub give osmandikar
    gosub stow ticket
    gosub stow my bola

    gosub get my hhr'ata
    gosub give osmandikar
    gosub give osmandikar
    gosub stow ticket
    gosub stow my hhr

    gosub remove my shield
    if ("$righthand" = "Empty") then gosub swap
    gosub give osmandikar
    gosub give osmandikar
    gosub stow ticket
    gosub wear my shield

    put .dep
    waitforre ^DEP DONE$
    gosub automove 106
    return



done:
    pause .2
    put #parse REPAIR DONE
    exit
