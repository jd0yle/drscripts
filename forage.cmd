include libmaster.cmd
###############
# Foraging
###############
action put stand when eval $standing = 0
action put #var forageCleanRoom 0 when ^I could not find what you
action put #var forageCleanRoom 1 when ^The room is too cluttered to find anything here\!

###############
# Variable Inits
###############
if (!($forageTarget >0)) then put #var forageTarget 0
if (!($forageCleanRoom >0)) then put #var forageCleanRoom 0
# Shard home
var homeRoom 252
# Crossing home
# var homeRoom 258

###############
# Main
###############
foragePrelim:
    put #var forageTarget dirt
    put .look
    goto forageCollect

forageCollect:
    if ($forageCleanRoom = 1) then {
        goto forageClearRoom
    }
    gosub collect $forageTarget
    gosub kick pile
    goto forageCheckExp


forageStand:
    gosub stand
    goto forageCollect


forageCheckExp:
    if ($Perception.LearningRate < 30) then goto forageCollect
    goto forageExit


forageClearRoom:
    gosub kick pile
    if ($forageCleanRoom = 1) then {
        goto forageClearRoom
    }
    goto forageCollect


forageExit:
    if ("$charactername" = "Inauri") then {
        gosub automove %homeRoom
        put .house
        waitforre ^HOUSE DONE
        pause 3
        if ($Engineering.LearningRate < 25) then {
            put .eng 5 tiara
        } else {
            put .inamagic
        }
    }
    if ("$charactername" = "Khurnaarti") then {
        gosub automove %homeRoom
        put peer door
        waitforre ^A sandalwood door suddenly opens\!
        put .house
        waitforre ^HOUSE DONE
        pause 3
        put .khuridle
    }
    exit


