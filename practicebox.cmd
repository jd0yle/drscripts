include libmaster.cmd
###############
# Lockpicking Practice Boxes
###############
action var newBox 1 when ^The lock looks weak
action put close $char.locks.boxType when ^Maybe you should close the (.*) first\.$


pbCount:
    matchre pbDoCount ^In the.*?you see (.*)\.$
    gosub look in my $char.locks.boxContainer
    matchwait 5
    goto pbCountDone


pbDoCount:
    var contents $1
    eval itemArr replace("%contents", ",", "|")
    eval itemLength count("%itemArr", "|")
    var index 0
    var numCount 0

    pbDoCountLoop:
        if (matchre("%itemArr(%index)", "\b$char.locks.boxType\b")) then math numCount add 1
        math index add 1
        if (%index > %itemLength) then goto pbCountDone
        goto pbDoCountLoop

pbCountDone:
    pause .2
    var pbTotalHave %numCount
    if (%pbTotalHave = null || %pbTotalHave = 0) then {
        put #echo >log yellow [practicebox] No boxes found in $char.locks.boxContainer.
        goto practiceBoxExit
    }
    if (%pbTotalHave > 0) then {
        goto practiceBoxLoop
    }

###############
# Main
###############
practiceBoxLoop:
    if (%newBox = 1) then goto newBox
    gosub get my $char.locks.boxType
    if ("$char.locks.lockpickType" <> "ring") then {
        if ("$lefthandnoun" <> "lockpick") then {
            gosub get my lockpick
        }
    }
    gosub lock my $char.locks.boxType
    gosub pick my $char.locks.boxType
    if ($Locksmithing.LearningRate < 30) then goto practiceBoxLoop
    goto practiceBoxExit
  
practiceBoxExit:
    if ("$char.locks.lockpickType" <> "ring") then {
        gosub stow my lockpick
    }
    if ("$righthand" <> "Empty") then {
        gosub stow my $char.locks.boxType
    }

    pause .2
    put #parse LOCKS DONE
    exit

newBox:
    gosub drop my $char.locks.boxType
    put dump junk
    goto pbCount