include libmaster.cmd

var spells null

action var spells %spells|$1 when ^It is labeled "(.*)\."$


var scrolls tablet|scroll|vellum|ostracon|bark|roll
var typeIndex 0
eval typeLength count("%scrolls", "|")

loop:
    gosub get my %scrolls(%typeIndex) from my skull
    if ("$righthand" = "Empty") then {
        math typeIndex add 1
        if (%typeIndex > %typeLength) then goto done
        goto loop
    }
    matchre doStow ^It is labeled
    matchre doRead Illustrations
    put look %scrolls(%typeIndex)
    matchwait 5
    goto doRead

doRead:
    gosub read my %scrolls(%typeIndex)
    goto doStow

doStow:
    gosub put my %scrolls(%typeIndex) in my satchel
    goto loop



done:
    eval spells replacere("%spells", "null|", "")
    echo %spells
    pause .2
    put #parse SCROLL DONE
    exit