include libmaster.cmd

if (!($lastPercGameTime > 0)) then put #var lastPercGameTime 1
evalmath nextPercGametime $lastPercGameTime + 90

if ($gametime > %nextPercGametime) then {
    gosub perc mana
    put #var lastPercGameTime $gametime
}

pause .2
put #parse PERC DONE
exit