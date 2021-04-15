include libmaster.cmd
##########
# Variables
##########

##########
# Main
##########

goto moveToShard

moveToHunt:
    gosub automove west gate
    gosub automove raven
    gosub automove 87
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
    gosub automove 282
    gosub automove west gate
    gosub automove portal
    exit