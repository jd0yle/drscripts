include libsel.cmd


var nextAlarmAt 0
timer start

loop:
    if (%t > %nextAlarmAt) then {
        evalmath nextAlarmAt %t + 61
        if ($Attunement.LearningRate < 33) then gosub perc mana
    }
    pause 2
    goto loop
