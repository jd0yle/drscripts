include libsel.cmd

if ("$zoneid" = "1") then {
    put #walk w gate
    waitfor YOU HAVE ARRIVED
}

if ("$zoneid" = "4") then {
    put #walk 450
    waitfor YOU HAVE ARRIVED
}

gosub prep rf
put .armor remove
waitfor ARMOR DONE
gosub cast

put .burgle
waitfor BURGLE DONE

put .armor wear
waitfor ARMOR DONE

gosub release rf

put #walk crossing
waitfor YOU HAVE ARRIVED

put #walk 258
waitfor YOU HAVE ARRIVED

put #parse SELBURGLE DONE
