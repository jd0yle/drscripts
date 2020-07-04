include libsel.cmd

action put exit when eval $health < 50
action put exit when eval $dead = 1
#action put exit when eval $bleeding = 1
#action put exit when eval $stunned = 1


action put #script abort all except idle; put exit when ^Inauri whispers, "!quit
action put #script abort all except idle when ^Inauri whispers, "!stop
action send awake when ^Inauri whispers, "!awake
action send awake; send sleep; send sleep when ^Inauri whispers, "!sleep
action goto goHouse when ^Inauri whispers, "!house
action put tellexp Inauri $1 when ^Inauri whispers, "!tellexp (.*)

action put ooc inauri I know teach, quit, stop, awake, sleep, house, and tellexp when ^Inauri whispers, "!help

var nextAlarmAt 0
timer start

loop:
    if (%t > %nextAlarmAt) then {
        evalmath nextAlarmAt %t + 240
        echo [$time]
        gosub look my blades
    }
    pause 2
    goto loop

goHouse:
    put #script pause all except idle
    pause
    send unlock house
    pause
    send open house
    pause
    send go house
    goto loop

