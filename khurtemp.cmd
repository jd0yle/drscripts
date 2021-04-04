include libmaster.cmd

if ($stunned = 1) then {
    pause 5
    goto moveToHunt
    }

##########
# Variables
##########
var huntRoom 118

##########
# Main
##########
gosub automove west gate
moveToHunt:
    gosub automove %huntRoom
    put .khurcombat
    exit