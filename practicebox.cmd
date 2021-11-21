include libmaster.cmd
###############################
# Lockpick Practice Boxes
###############################


###############################
###    IDLE ACTIONS
###############################
action var pb.newBox 1 when ^The lock looks weak, and rather than risk breaking it, you stop your attempt to pick it\.
action put close my %pb.box when ^Maybe you should close the (.*) first\.$
action put lock my %pb.box when ^But the (.*) isn't locked\!$
action goto pb.errorLockpick when ^Pick the .+ box with what\?$
action var pb.boxUses $2 when You believe the (.*) could be picked (\d+) more times before the wear would risk breaking the lock\.


###############################
###    VARIABLES
###############################
put #var pb.haveBox 0
var pb.box box
var pb.boxTypes keepsake box|jewelry box
var pb.boxUses 0
var pb.newBox 0

###############################
###    SETUP
###############################
pb.findBox:
    matchre pb.getBox ^.*(%pb.boxTypes).*$
    matchre pb.errorBox ^\[Use INVENTORY HELP for more options\.\]$
    gosub inventory $char.inv.boxContainer
    matchwait 5


pb.getBox:
    gosub get my %pb.box from my $char.inv.boxContainer
    if (matchre("$righthand|$lefthand", "(%pb.boxTypes)")) then {
            var pb.box $0
            if ("$righthand" != "%pb.box") then {
                gosub swap
            }
        }
        goto pb.study
    } else {
        if ((matchre("$righthand", "Empty")) && (matchre("$lefthand", "Empty"))) then {
            gosub stow
            gosub stow left
            goto pb.getBox
        }
        gosub open my $char.inv.boxContainer
        goto pb.getBox
    }


pb.study:
    gosub study my %pb.box
    if (%pb.boxUses > 0) then {
        goto pb.main
    } else {
        if ("$char.locks.bucket" <> "0") then {
            gosub put my %pb.box in my $char.locks.bucket
            gosub tap my $char.locks.bucket
            gosub tap my $char.locks.bucket
            goto pb.findBox
        } else {
            if (matchre("$roomobjs", "bin|statue|bucket")) then {
                put my %pb.box in $0
                goto pb.findBox
            } else {
                gosub stow my %pb.box
                goto pb.findBox
            }
        }
    }


###############################
###    MAIN
###############################
pb.main:
    if ("$char.locks.lockpickType" <> "ring") then {
        if ("$lefthand" = "Empty") then {
            gosub stow left
        }
        if ("$lefthandnoun" <> "lockpick") then {
            gosub get my lockpick
            if ("$lefthandnoun" <> "lockpick" then {
                goto pb.errorLockpick
            }
        }
    }


    pb.mainLoop:
        gosub lock my %pb.box
        gosub pick my %pb.box
        if (%pb.newBox = 1) then goto pb.study
        if ($Locksmithing.LearningRate < 30) then goto pb.mainLoop
        goto pb.exit


pb.errorBox:
    put #echo >Log [practicebox] Cannot find any boxes!
    goto pb.exit


pb.errorLockpick:
    put #echo >Log [practicebox]  Cannot find your lockpick!
    goto pb.exit


pb.exit:
    if ("$righthand" <> "Empty" || "$lefthand" <> "Empty") then {
        gosub stow
        gosub stow left
    }

    pause .2
    put #parse LOCKS DONE
    exit
