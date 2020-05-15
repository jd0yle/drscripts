include libsel.cmd

var nextAlarmAt 0
timer start

loop:
    if (%t > %nextAlarmAt) then {
        evalmath nextAlarmAt %t + 90
        gosub app my bundle
    }
    pause 2
    goto loop
