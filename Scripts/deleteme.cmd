


action goto log when ^(This is text.*)
action goto logother when ^(That was text.*)


put #echo This is text stuff
put #parse This is text stuff

put #echo This is text more stuff
put #parse This is text more stuff
pause 10
exit



log:
    echo LOG $0
    exit

logother:
    echo LOG $0
    exit
