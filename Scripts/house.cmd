var lock 1
if "$roomplayers" != "" then var lock 0
if "$1" != "" then var lock 1

if $roomid = 258 then {
    var obj house
} else {
    var obj door
}

send unlock %obj
send open %obj
pause .2
move go %obj

if "%obj" = "house" then {
    var obj door
} else {
    var obj house
}

if %lock = 1 then {
    send close %obj
    send lock %obj
}
