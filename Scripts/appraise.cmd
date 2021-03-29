include libsel.cmd
include var_characters.cmd

var appraiseArgs my gem pouch

if_1 then {
    if (%1 = careful) then var appraiseArgs %appraiseArgs careful
}

var fromContainer portal

if (!($lastAppGametime > 0)) then put #var lastAppGametime 1
evalmath nextAppGametime $lastAppGametime + 120

if ($gametime > %nextAppGametime) then {
    gosub get my gem pouch from my portal
    if ($monstercount > 0) then gosub retreat

    gosub appraise %appraiseArgs

    if ("$righthandnoun" = "pouch" || "$lefthandnoun" = "pouch") then gosub put my gem pouch in my %fromContainer

    if ($monstercount > 0) then gosub advance
    put #var lastAppGametime $gametime
}

pause .2
put #parse APPRAISE DONE
exit