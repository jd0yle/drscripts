####################################################################################################
# .train.cmd
# Selesthiel - Justin Doyle - justin@jmdoyle.com
# 2021/04/01
#
# USAGE
# .train
#
# Ensures that the script with your charactername is running, and .reconnect
####################################################################################################

include libmaster.cmd

put #var afk 1

action put #script abort all except %scriptname; goto restartScript when eval $libmaster.retryAttempts > 10

eval characterScript tolower($charactername)

loop:
    if ($dead = 1 || $health < 50) then goto doneDead

    if (1 = 0 && "$charactername" = "Qizhmur") then {
        if (!contains("$scriptlist", "magic")) then {
            put #echo >Log [train] Starting magic
            put .magic
        }
    } else {
        if (!contains("$scriptlist", "%characterScript")) then {
            put #echo >Log [train] Starting character script
            put .$charactername
        }
    }
    if (!contains("$scriptlist", "reconnect.cmd")) then {
        put #echo >Log [train] Starting reconnect
        put .reconnect
    }
    pause 30
    goto loop


doneDead:
    put #var afk 0
    echo [train] EXITING BECAUSE DEAD!
    put #script abort all
    exit