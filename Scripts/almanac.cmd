include libsel.cmd

var noloop %1

var almanacContainer thigh bag

if ("$charactername" = "Qizhmur") then var almanacContainer skull

var isAsleep 0
action var isAsleep 1 when ^You awaken from your reverie

if (!($lastAlmanacGametime >0)) then put #var lastAlmanacGametime 0

main:
    evalmath nextStudyAt $lastAlmanacGametime + 600

    if (%nextStudyAt < $gametime) then {
        put #script pause all except almanac
        if ("$lefthandnoun" != "almanac" && "$righthandnoun" != "almanac") then {
            gosub get my almanac
            gosub awake
        }
        if ("$lefthandnoun" != "almanac") then gosub swap
        gosub study my almanac
        gosub put my almanac in my %almanacContainer
        if (%isAsleep = 1) then {
            gosub sleep
            gosub sleep
            var isAsleep 0
        }
        put #var lastAlmanacGametime $gametime
        put #script resume all
    }
    pause 2
    if ("%noloop" = "noloop") then goto done
    goto main



done:
    put #parse ALMANAC DONE
    exit