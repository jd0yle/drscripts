###############################
###    IDLE ACTIONS
###############################
action goto afk.logout when eval $health < 50
action goto afk.logout when eval $dead = 1
action send stand when eval $standing = 0


###############################
###    MAIN
###############################
afk.loop:
    pause 2
    goto afk.loop


afk.logout:
    put #var afk 0
    put exit
    put #script abort all
    pause 1
    put #script abort all
    put exit
    exit

