include libmaster.cmd

if_1 then {
    if (%1 = careful) then var appraiseArgs %appraiseArgs careful
}

var fromContainer portal

if (!($lastAppGametime > 0)) then put #var lastAppGametime 1
evalmath nextAppGametime $lastAppGametime + 120

if ($gametime > %nextAppGametime) then {
    if ($char.appraise.container <> 0) then {
        gosub get $char.appraise.item from my $char.appraise.container
    }
    if ($monstercount > 0) then gosub retreat

    gosub appraise $char.appraise.item
    if ($char.appraise.container <> 0) then {
        if ("$righthandnoun" = "pouch" || "$lefthandnoun" = "pouch") then {
            gosub put %char.appraise.item in my %fromContainer
        }
    }

    if ($monstercount > 0) then gosub advance
    put #var lastAppGametime $gametime
}

pause .2
put #parse APPRAISE DONE
exit