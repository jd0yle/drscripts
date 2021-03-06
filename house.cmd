include libmaster.cmd
action goto closeDoor when ^You must wait a few hours before entering this home again\.
########################
# Housing Doors
########################

if ($roomid = 258 || "$roomname" != "Private Home Interior") then {
    var obj house
}
if ($roomid = 640) then {
    var obj farmstead
}
if ($roomid = 252) then {
    var obj sandalwood door
}
if ($roomid = 50) then {
    var obj fieldstone bothy
}

if ("$roomname" = "Private Home Interior") then var obj door

if ($SpellTimer.RefractiveField.active = 1) then gosub release rf

gosub unlock %obj
gosub open %obj
gosub move go %obj

if ("%obj" != "door") then {
    gosub close door
    gosub lock door
} else {
    var closeObj house
    if (contains("$roomobjs", "farmstead") then var closeObj farmstead
    if (contains("$roomobjs", "sandalwood door") then var closeObj door
    if (contains("$roomobjs", "bothy") then var closeObj bothy
    gosub close %closeObj
    gosub lock %closeObj
}

pause .2
put #parse HOUSE DONE
exit


closeDoor:
  gosub close %closeObj
  gosub lock %closeObj
  exit