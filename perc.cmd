include libmaster.cmd

if (!($lastPercGametime > 0)) then put #var lastPercGametime 1
evalmath nextPercGametime $lastPercGametime + 90

if ($gametime > %nextPercGametime) then {
    gosub perc mana
    put #var lastPercGametime $gametime
}

pause .2
put #parse PERC DONE
exit