include libsel.cmd

#action goto buffInauri when ^Inauri whispers, "MT
action put exit when eval $health < 20
action put exit when eval $dead = 1
action put exit when eval $stunned = 1
action put exit when eval $bleeding = 1
#action send stand when eval $standing = 0

action put #script abort all except idle; put exit when ^Inauri whispers, "!exit
action put #script abort all except idle when ^Inauri whispers, "!stop
action put awake when ^Inauri whispers, "!awake
action send awake; send sleep; send sleep when ^Inauri whispers, "!sleep
action put #script pause all except idle; send unlock house; send open house; send go house when ^Inauri whispers, "!house
action put when ^Inauri whispers, "!tellexp (.*)


var nextAlarmAt 0
var nextEchoAt 0
timer start

loop:
    if (%t > %nextAlarmAt) then {
        evalmath nextAlarmAt %t + 240
        gosub look my blades
    }

    if (%t > %nextEchoAt) then {
        evalmath nextEchoAt %t + 300
        echo [$time]
    }

    pause 2
    goto loop


buffInauri:
    put #script pause all except idle
    var stowedItem null
    if ("$righthand" != "Empty") then {
        var stowedItem $righthandnoun
        gosub stow right
    }
    put .cast mt Inauri
    waitforre ^CAST DONE
    if (%stowedItem != null) then gosub get my %stowedItem
    put #script resume all
    goto loop
