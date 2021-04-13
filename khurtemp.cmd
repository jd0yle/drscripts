include libmaster.cmd
##########
# Variables
##########

##########
# Main
##########
goto moveToHunt

moveToHunt:
    gosub automove west gate
    gosub automove raven
    put go gate
    waitforre ^A fur-clad Dwarven guard bellows, \"The gear gate is open, second guard take up a defensive position and stand ready\!\"$
    gosub move go gate
    gosub automove 60
    # Icy road
    gosub automove 45
    gosub automove 198
    gosub automove 210
    put .khurcombat
    exit

moveToShard:
    gosub automove 198
    gosub automove 45
    # Icy Road
    gosub automove 60
    put go gate
    waitforre ^A fur-clad Dwarven guard bellows, \"The gear gate is open, second guard take up a defensive position and stand ready\!\"$
    gosub move go gate
    gosub automove west gate
    gosub automove portal
    exit