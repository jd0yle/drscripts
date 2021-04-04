include libmaster.cmd
action put stand when eval $standing = 0

###############
# Variable Inits
###############
var loop 0
if_1 then {
    if ("%1" = "loop") then var loop 1
}

###############
# Main
###############
forageCollect:
    if ($Outdoorsmanship.LearningRate < 30) then {
        if ($monstercount > 0) then goto forageExit
        gosub collect dirt
        if (contains("$roomobjs", "a pile of")) then {
            gosub kick pile
        }
        if (%loop = 1) then {
            goto forageCollect
        }
    }
    goto forageExit


forageExit:
    pause .2
    put #parse FORAGE DONE
    exit
