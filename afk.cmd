###############################
###    IDLE ACTIONS
###############################
action var logoutReason health; goto afk.logout when eval $health < 50
action var logoutReason dead; goto afk.logout when eval $dead = 1
action (standTrigger) send stand when eval $standing = 0


###############################
###    VARIABLES
###############################
var logoutReason 0


###############################
###    MAIN
###############################
afk.loop:
	if ($health < 50) then {
		var logoutReason health
		goto afk.logout
	}
	if ($dead = 1) then {
        var logoutReason dead
        goto afk.logout
    }
    pause 2
    pause 2
    goto afk.loop


afk.logout:
    put #var afk 0
    put exit
    put #script abort all except afk
    pause 1
    put #script abort all except afk
    put #echo >Log [afk] Exiting!  Cause:  %logoutReason
    put exit
    exit

