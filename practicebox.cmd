include libmaster.cmd
###############
# Lockpicking Practice Boxes
###############
action var newBox 1 when ^The lock looks weak
action put close $char.locks.boxType when ^Maybe you should close the (.*) first\.$


pbCount:
    matchre pbDoCount ^You rummage through.*?and see (.*)\.$
    gosub rummage my $char.locks.boxContainer
    matchwait 5
    goto pbCountDone


pbDoCount:
    var contents $1
    eval itemArr replace("%contents", ",", "|")
    eval itemLength count("%itemArr", "|")
    var index 0
    var numCount 0

    pbDoCountLoop:
        if (matchre("%itemArr(%index)", "$char.locks.boxType")) then math numCount add 1
        math index add 1
        if (%index > %itemLength) then goto pbCountDone
        goto pbDoCountLoop

pbCountDone:
    pause .2
    var pbTotalHave %numCount
    if (%pbTotalHave <> 0) then {
        goto practiceBoxLoop
    }
    put #echo >log yellow [practicebox] No boxes found in $char.locks.boxContainer.
    goto practiceBoxExit

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
    gosub stow my $char.locks.boxType

    pause .2
    put #parse LOCKS DONE
    exit

newBox:
    gosub drop my $char.locks.boxType
    gosub open my $char.locks.boxContainer
    gosub get my $char.locks.boxType
    var newBox 0
    if ($righthandnoun = null) then {
        goto practiceBoxExit
    }
    goto practiceBoxLoop