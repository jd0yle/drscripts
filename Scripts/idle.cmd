include libsel.cmd

action goto buffInauri when ^Inauri whispers, "MT
action put exit when eval $health < 20
action put exit when eval $dead = 1
#action send stand when eval $standing = 0

action put .teach $1 Inauri when ^Inauri whispers, "teach (\S+)

var nextAlarmAt 0
timer start

loop:
    if (%t > %nextAlarmAt) then {
        evalmath nextAlarmAt %t + 240
        gosub look my blade
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
