var class %1
if_3 then {
    var target %3
} else {
    var target %2
}

include libsel.cmd
pause
put awake
pause
put awake
pause
send awake
gosub stop teach
gosub stop listen
gosub teach %class to %target

exit
