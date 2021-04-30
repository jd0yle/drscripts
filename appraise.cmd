include libmaster.cmd
###############################
###    INIT
###############################
var force 0

if_1 then {
    if (%1 = careful) then var appraiseArgs %appraiseArgs careful
    if (%1 = force) then var force 1
}


###############################
###    MAIN
###############################
appraise.main:
    if (!($lastAppGametime > 0)) then put #var lastAppGametime 1
    evalmath nextAppGametime $lastAppGametime + 120

    if ($gametime > %nextAppGametime || %force = 1) then {
        if ($char.appraise.container <> 0) then {
            gosub get $char.appraise.item from my $char.appraise.container
        }
        if ($monstercount > 0) then gosub retreat

        gosub appraise $char.appraise.item
        if ($char.appraise.container <> 0) then {
            if ("$righthandnoun" = "pouch" || "$lefthandnoun" = "pouch" || "$righthand" = "$char.appraise.item" || "$lefthand" = "$char.appraise.item") then {
                gosub put $char.appraise.item in my $char.appraise.container
            }
        }

        put #var lastAppGametime $gametime
    }

    pause .2
    put #parse APPRAISE DONE
    exit