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
            pause .01
        }
    } else {
        var reconnecting 0
        var nextAttemptAt 0
        var attemptInterval 15
        if (%restartScripts = 1) then {
            put #script abort all except reconnect
            if ("$charactername" = "Inauri") then put .look
            if ("$charactername" = "Izqhhrzu") then put .izqhhrzu
            if ("$charactername" = "Khurnaarti") then put .khurnaartinew
            if ("$charactername" = "Qizhmur") then put .qizhmur
            if ("$charactername" = "Selesthiel") then put .selesthiel
            var restartScripts 0
            put .reconnect
        }
    }

	# We want to store the current gametime in storedGameTime, then compare it gametime later. If they're the same, then
	# we haven't received any ticks from the server and can assume we're not connected.
    if (!(%storedGameTime > 0)) then var storedGameTime 1

    if (!(%lastCompareGametimeAt > 0)) then var lastCompareGametimeAt 1

	evalmath nextCompareGametimeAt (%lastCompareGametimeAt + 30)
    if (%nextCompareGametimeAt < $gametime) then {
	    #echo [reconnect] $time Stored gametime is %storedGameTime actual gametime is $gametime
	    if (%storedGameTime = $gametime) then {
	        put #echo >Log #FF0000 [reconnect] GAMETIME NOT UPDATED (%storedGameTime vs $gametime), FORCING connected=0
	        put #var connected 0
	        #var forceReconnect 1
	    } else {
	        var storedGameTime $gametime
	    }
	    var lastCompareGametimeAt $gametime
    }

    pause 2
    pause
    goto loopWait


