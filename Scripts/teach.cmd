var class $1

eval names replace($roomplayers, " ", "|")
eval len count(%names, "|")
var i 0

loop:
    if (%i > %len) then exit
    ; send teach %class to %names(%i)
    echo teach %class to %names(%i)
    pause .2
    math i add 1
    goto loop
