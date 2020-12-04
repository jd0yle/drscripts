var secondsToWait %1
var command %2

loop:
    math secondsToWait subtract 2
    if (%secondsToWait < 0) then {
        put %command
        pause
        exit
    }
    pause 2
    goto loop

