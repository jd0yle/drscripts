#include libsel.cmd

var cancelReconnect 0

var reconnecting 0
var nextAttemptAt 0
var attemptInterval 15

var restartScripts 0

action var stillWaiting 1 + %stillWaiting when eval $connected = 0

timer start

loopWait:
    if ($health < 80 || $dead = 1 || $bleeding = 1 || $stunned = 1) then {
        var cancelReconnect 1
        echo EXITING BECAUSE YOU ARE HURT OR DEAD
        put #echo >Log EXITING BECAUSE YOU ARE HURT OR DEAD
        put #script pause all
        put exit
        exit
    }
    if ($connected = 0) then {
        put #script pause all except reconnect
        var restartScripts 1
        if (%t > %nextAttemptAt) then {
            echo $datetime ATTEMPTING TO RECONNECT...
            put #echo >Log ATTEMPTING TO RECONNECT...
            put #connect
            evalmath nextAttemptAt (%attemptInterval * 2 + %t)
            math attemptInterval add %attemptInterval
            if (%attemptInterval > 60) then var attemptInterval 60
            pause 2
        } else {
            evalmath timeLeft (%nextAttemptAt - %t)
            pause .5
        }
    } else {
        var reconnecting 0
        var nextAttemptAt 0
        var attemptInterval 15
        if (%restartScripts = 1) then put #script resume all
    }
    pause 2
    goto loopWait


