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
    gosub automove 282
    gosub move go rock shard
    gosub automove 45
    gosub automove 198
    gosub automove 210
    put .khurcombat
    exit

moveToShard:
    gosub automove 198
    gosub automove 60
    gosub automove 282
    gosub automove west gate
    gosub automove portal
    exit
