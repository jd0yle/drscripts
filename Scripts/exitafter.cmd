var waitTime $timeTillExit
if_1 then var waitTime %1


echo Waiting %waitTime seconds before exiting game
waiting:
    pause 2
    math waitTime subtract 2
    put #var timeTillExit %waitTime
    if (%waitTime <= 0) then {
        put #script pause all except exitafter
        put #echo >Log [exitafter] Timer reached: Exiting game
        pause
        put exit
        exit
    }
    goto waiting
