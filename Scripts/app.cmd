include libsel.cmd

var nextAlarmAt 0
timer start

loop:
    if (%t > %nextAlarmAt && $Appraisal.LearningRate < 34) then {
        evalmath nextAlarmAt %t + 90
        gosub app my bundle
    }
    pause 2
    goto loop
