include libmaster.cmd
action put stand when eval $standing = 0
action goto forageError when You survey the area and realize that any collecting efforts would be futile\.$


###############################
###    INIT
###############################
var noLoop false
if_1 then {
    if ("%1" = "noLoop") then var noLoop true
}

if !matchre("$righthand|$lefthand", "Empty") then {
    gosub stow
    gosub stow left
    if !matchre("$righthand|$lefthand", "Empty") then {
        put #echo >Log [forage] Error:  Unable to empty hands, skipping foraging.
        goto forageExit
    }
}


###############################
###    MAIN
###############################
forageCollect:
    if ($monstercount > 0) then goto forageExit
    gosub collect rock
    if (contains("$roomobjs", "a pile of")) then {
        gosub kick pile
    }
    if (%noLoop = true) then {
        goto forageExit
    } else {
        if ($Outdoorsmanship.LearningRate < 30) then {
            goto forageCollect
        } else {
            goto forageExit
        }
    }


forageError:
    put #echo >Log [forage] $roomname (r$roomid) is not forageable.  Correct whatever script tried to use this room.
    goto forageExit


forageExit:
    pause .2
    put #parse FORAGE DONE
    exit
