include libmaster.cmd
###################
# Idle Action Triggers
###################

###################
# Variable Inits
###################
var burgleRoom 91
var forageRoom 555
var homeRoom 252

goto engineerLoop
###################
# Main
###################
engineerLoop:
    put .house
    waitforre ^HOUSE DONE
    gosub automove east gate
    gosub automove engineer
    put .workorder
    waitforre ^WORKORDER DONE
    put .deposit
    waitforre ^DEPOSIT DONE
    gosub automove portal
    gosub automove %homeRoom
    put .house
    waitforre ^HOUSE DONE
    put .inaidle
    put #script abort all except inaidle
    exit

shardLoop:
    gosub automove steelclaw
    put #walk %burgleRoom
    put .burgle
    waitforre ^You take a moment to reflect on the caper you just pulled as you slip out the kitchen window\.\.\.
    pause 2
    gosub automove east gate
    gosub automove pawn
    waitforre ^PAWN DONE
    put .deposit
    waitforre ^DEPOSIT DONE
    gosub automove portal
    gosub automove %forageRoom
    put .forage
    waitforre ^FORAGE DONE
    gosub automove %homeRoom
    put .house
    waitforre ^HOUSE DONE
    if ("$charactername" = "Inauri") then {
        put .inaidle
    }
    if ("$charactername" = "Khurnaarti") then {
        put .khuridle
    }
    exit