include libsel.cmd


if ("$roomname" = "Private Home Interior") then {
    gosub unlock door
    gosub open door
    gosub move go door
    gosub close house
    gosub lock house
}

if ("$zoneid" = "1") then {
    gosub automove 258
}


gosub prep rf
put .armor remove
waitforre ^ARMOR DONE$
gosub cast

put .burgle
waitfor BURGLE DONE

put .armor wear
waitfor ARMOR DONE

gosub release rf

put #walk 258
waitfor YOU HAVE ARRIVED

put #parse SELBURGLE DONE
