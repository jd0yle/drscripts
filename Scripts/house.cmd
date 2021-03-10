include libsel.cmd



if ($roomid = 258 || "$roomname" != "Private Home Interior") then {
    var obj house
}
if ($roomid = 640) then {
    var obj third farmstead
}

if ("$roomname" = "Private Home Interior") then var obj door

gosub unlock %obj
gosub open %obj
gosub move go %obj

if ("%obj" != "door") then {
    gosub close door
    gosub lock door
} else {
    var closeObj house
    if (contains("$roomobjs", "farmstead") then var closeObj farmstead
    gosub close %closeObj
    gosub lock %closeObj
}

pause .2
put #parse HOUSE DONE
exit
