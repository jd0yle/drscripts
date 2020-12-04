include libsel.cmd

var noloop %1

action put #echo >Log Almanac: $1 when You believe you've learned something significant about (.*)!$

if (!($lastAlmanacGametime >0)) then put #var lastAlmanacGametime 0

main:
    evalmath nextStudyAt $lastAlmanacGametime + 600

    if (%nextStudyAt < $gametime) then {
        put #script pause all except almanac
        if ("$lefthandnoun" != "almanac" && "$righthandnoun" != "almanac") then {
            gosub get my almanac
        }
        if ("$lefthandnoun" != "almanac") then gosub swap
        gosub study my almanac
        gosub put my almanac in my thigh bag
        put #var lastAlmanacGametime $gametime
        put #script resume all
    }
    pause 2
    if ("%noloop" = "noloop") then goto done
    goto main



done:
    put #parse ALMANAC DONE
    exit