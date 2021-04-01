put #class characterTracker off

var names Chelinde|Qizhmur|Navesi
eval numNames count("%names", "|")

action put #log >characterTracker [$datetime]: Found $1; put #echo >characterTracker [$datetime]: Found $1 when ^\W+(%names)\.$

main:
    if (!($lastCharCheckGametime > 0)) then var lastCharCheckGametime 1
    evalmath nextCheckTime $lastCharCheckGametime + 300
    if ($gametime > %nextCheckTime) then {
        gosub checkNames
        put #var lastCharCheckGametime $gametime
    }
    pause 2
    goto main


checkNames:
    var index 0
    checkNames1:
    put find %names(%index)
    waitforre Brave|syntax
    math index add 1
    if (%index > %numNames) then goto done
    goto checkNames1


done:
    pause .2
    put #parse CHARACTERTRACKER DONE
    put #class characterTracker on
    exit