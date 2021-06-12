#debug 5

var cancelReconnect 0
var forceReconnect 0

var reconnecting 0
var nextAttemptAt 0
var attemptInterval 15

var restartScripts 0

action var stillWaiting 1 + %stillWaiting when eval $connected = 0
action put #var connected 0 when ConnectionResetByPeer
action put #var connected 0 when ConnectionTimedOut


timer start
var calculatedGametime $gametime

loopWait:
    if ($health < 50 || $dead = 1) then {
        var cancelReconnect 1
    }
    if ($connected = 0 && %cancelReconnect != 1) then {
        var restartScripts 1
        var forceReconnect 0
        if (%t > %nextAttemptAt) then {
            echo $datetime ATTEMPTING TO RECONNECT...
            put #echo >Log #00FF00 ATTEMPTING TO RECONNECT...

            put #queue clear 
            put #connect
            send 5 look

            evalmath nextAttemptAt (%attemptInterval * 2 + %t)
            math attemptInterval add %attemptInterval
            if (%attemptInterval > 15) then var attemptInterval 15
            pause 2
        } else {
            evalmath timeLeft (%nextAttemptAt - %t)
            pause .5
        }
    } else {
        var reconnecting 0
        var nextAttemptAt 0
        var attemptInterval 15
        if (%restartScripts = 1) then {
            put #script abort all except reconnect
            if ("$charactername" = "Qizhmur") then put .qizhmur
            if ("$charactername" = "Selesthiel") then put .selesthiel
            if ("$charactername" = "Izqhhrzu") then put .izqhhrzu
            #if ("$charactername" = "Qizhmur" || "$charactername" = "Selesthiel" || "$charactername" = "Inauri" || "$charactername" = "Khurnaarti") then put .train
            var restartScripts 0
            put .reconnect
        }
    }



    if (%elapsedGametime > 30) then {
        #echo %elapsedGametime since gametime updated (%elapsedGametime - $gametime > %calculatedGametime + 30)
        #put #var connected 0
    }
    math calculatedGametime add 2

    if (!(%storedGameTime > 0)) then var storedGameTime 1
    if (%storedGameTime = $gametime) then {
        put #var connected 0
        var forceReconnect 1
    } else {
        var storedGametime $gametime
    }

    pause 2
    goto loopWait


