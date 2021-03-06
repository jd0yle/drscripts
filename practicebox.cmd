include libmaster.cmd
###############################
# Lockpick Practice Boxes
#
# Used by .khurnaarti (30APR2021)
###############################

###############################
###    IDLE ACTIONS
###############################
action var pb.newBox 1 when ^The lock looks weak
action put close my $char.locks.boxType when ^Maybe you should close the (.*) first\.$
action goto practiceBoxExit when ^Pick the .+ box with what\?$


###############################
###    VARIABLES
###############################
put #var pb.haveBox 0
var pb.contents 0
var pb.index 0
var pb.itemArr 0
var pb.itemLength 0
var pb.newBox 0
var pb.numCount 0
var pb.totalHave 0


###############################
###    SETUP
###############################
pb.count:
    matchre pb.doCount ^In the.*?you see (.*)\.$
    gosub look in my $char.locks.boxContainer
    matchwait 5
    goto pb.countDone


pb.doCount:
    var pb.contents $1
    eval pb.itemArr replace("%pb.contents", ",", "|")
    eval pb.itemLength count("%pb.itemArr", "|")
    var pb.index 0
    var pb.numCount 0


    pb.doCountLoop:
        if (matchre("%pb.itemArr(%pb.index)", "\b$char.locks.boxType\b")) then {
            math pb.numCount add 1
        }
        math pb.index add 1
        if (%pb.index > %pb.itemLength) then {
            goto pb.countDone
        }
        goto pb.doCountLoop


pb.countDone:
    pause .2
    var pb.totalHave %pb.numCount
    if (%pb.totalHave = 0) then {
        put #echo >log yellow [practicebox] No boxes found in $char.locks.boxContainer.
        put #var pb.haveBox 1
        put #var lastPracticeBoxGametime $gametime
        goto pb.exit
    }
    if (%pb.totalHave > 0) then {
        goto pb.main
    }


###############################
###    MAIN
###############################
pb.main:
    if (%pb.newBox = 1) then {
        gosub put my $char.locks.boxType in my bucket
        gosub tap my bucket
        gosub tap my bucket
    }
    gosub get my $char.locks.boxType
    if ("$righthand" <> "$char.locks.boxType") then {
        put #echo >log yellow [practicebox] No boxes found in $char.locks.boxContainer.
        put #var pb.haveBox 1
        put #var lastPracticeBoxGametime $gametime
        goto pb.exit
    }
    if ("$char.locks.lockpickType" <> "ring") then {
        if ("$lefthandnoun" <> "lockpick") then {
            gosub get my lockpick
        }
    }
    gosub lock my $char.locks.boxType
    gosub pick my $char.locks.boxType
    if ($Locksmithing.LearningRate < 30) then goto pb.main
    goto pb.exit


pb.exit:
    if ("$righthand" <> "Empty" || "$lefthand" <> "Empty") then {
        gosub stow
        gosub stow left
    }

    pause .2
    put #parse LOCKS DONE
    exit
