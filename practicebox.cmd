include libmaster.cmd
###############
# Lockpicking Practice Boxes
###############
action var newBox 1 when ^The lock looks weak
action put close %box when ^Maybe you should close the (.*) first\.$

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
    gosub stow my $char.locks.boxType
    gosub open my $char.locks.boxContainer
    gosub get $char.locks.boxType from my $char.locks.boxContainer
    var newBox 0
    if ($righthandnoun = null) then {
        goto practiceBoxExit
    }
    goto practiceBoxLoop