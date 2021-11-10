####################################################################################################
# commune.cmd
# Cleric Commune
#
# Performs the commune of the specified deity.
#
# Args:
#    --deity The commune to perform
#
# Example:
# .commune --deity=meraud
#
####################################################################################################
include libmaster.cmd
include args.cmd

gosub stow right
gosub stow left

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
        gosub get my incense from my $char.inv.container.incense
        if ("$righthandnoun" != "incense") then gosub commune.doneNoIncense
        gosub drop my incense
        goto commune.lightIncense
    }
    gosub get my orichalcum phoenix
    put point my phoenix at incense
    pause
    gosub stow my phoenix
    goto commune.lightIncense


commune.sprinkleHolyWater:
    var commune.sprinkleTarget $0
	gosub get water from my $char.storage.holyWater
	if ("$righthand" = "water") then gosub runScript cast bless my water
	if ("$righthand" != "holy water") then goto commune.doneNoWater
	gosub sprinkle water at %commune.sprinkleTarget
	gosub put my water in my $char.storage.holyWater
	return


###############################
###      DONE
###############################
commune.doneNoIncense:
    put #echo >Log Red [commune] No incense!
    goto commune.done

commune.doneNoWater:
    put #echo >Log Red [commune] No water!
    goto commune.done

commune.done:
    put #parse COMMUNE DONE
    pause .2
    exit