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

put #var afk 1

eval characterScript tolower($charactername)

loop:
    if (!contains("$scriptlist", "%characterScript")) then {
        put #echo >Log [train] Starting character script
        put .$charactername
    }
    if (!contains("$scriptlist", "reconnect.cmd")) then {
        put #echo >Log [train] Starting reconnect
        put .reconnect
    }
    pause 30
    goto loop
