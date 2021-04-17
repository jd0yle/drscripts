include libmaster.cmd
##########
# Variables
##########

##########
# Main
##########

goto moveToHuntFC

moveToHuntFC:
    gosub automove portal
    gosub move go portal
    gosub automove 80
    put .khurcombat
    exit

moveToHuntShard:
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
    gosub automove 87
    gosub automove 282
    gosub move go rock wall
    gosub automove west gate
    gosub automove portal
    exit
