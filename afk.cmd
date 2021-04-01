action goto logout when eval $health < 50
action goto logout when eval $dead = 1
action send stand when eval $standing = 0


loop:
pause 2
goto loop


logout:
    put exit
    put #script abort all except qiztrainshard
    pause 1
    put #script abort all except qiztrainshard
    put exit
    exit

