var waitTime $timeTillSleep
if_1 then var waitTime %1


echo Waiting %waitTime seconds before sleeping
waiting:
    pause 2
    math waitTime subtract 2
    put #var timeTillSleep %waitTime
    if (%waitTime <= 0) then {
        put #script abort all except logafter
        pause
        put .idle
        pause
        put sleep
        pause
        put sleep
        pause
        exit
    }
    goto waiting
