include libmaster.cmd
include args.cmd

gosub stow right
gosub stow left

echo %args.deity

if ("%args.deity" = "meraud") then gosub commune.meraud
if ("%args.deity" = ".deity") then {
    put #echo Orange [commune] NO DEITY SPECIFIED
    put #echo Orange [commune] USAGE: .commune <deity>
    put #echo Orange [commune] Ex: .commune meraud
    goto commune.done
}

goto commune.done


###############################
###      MERAUD
###############################
commune.meraud:
	gosub commune.lightIncense
	gosub wave incense at $charactername
	gosub stow my incense
	gosub commune.sprinkleHolyWater $charactername
    gosub commune meraud
	gosub stand
	gosub stow right
	gosub stow left
	return


###############################
###      UTILITIES
###############################
commune.lightIncense:
    if (matchre("$roomobjs", "burning.*incense")) then {
        gosub stow right
        gosub stow left
        gosub get incense
        return
    }
    if (!contains("$roomobjs", "incense")) then {
        gosub get my incense
        if ("$righthandnoun" != "incense") then gosub commune.doneNoIncense
        gosub drop my incense
        goto commune.lightIncense
    }
    gosub get my sword
    gosub get my flint
    gosub light incense with my flint
    goto commune.lightIncense


commune.sprinkleHolyWater:
    var commune.sprinkleTarget $0
	gosub get my water from witch jar
	if ("$righthand" = "water") then gosub runScript cast bless my water
	if ("$righthand" != "holy water") then goto commune.doneNoWater
	gosub sprinkle water at %commune.sprinkleTarget
	gosub put water in my witch jar
	return


###############################
###      DONE
###############################
commune.doneNoIncense:
    put #echo >Log Red [commune] No incense!
    goto done

commune.doneNoWater:
    put #echo >Log Red [commune] No water!
    goto done

commune.done:
    put #parse COMMUNE DONE
    pause .2
    exit