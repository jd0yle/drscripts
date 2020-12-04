include libsel.cmd

if ("$zoneid" = "6") then {
    put #walk path
    waitfor YOU HAVE ARRIVED
    if ($roomid != 106) then {
        move go path
        pause
    }
    put #walk w gate
    waitfor YOU HAVE ARRIVED
}

if ("$zoneid" = "1") then {
    put #walk w gate
    waitfor YOU HAVE ARRIVED
}

if ("$zoneid" = "4") then {
    put #walk 450
    waitfor YOU HAVE ARRIVED
}

gosub prep eotb
put .armor remove
waitfor ARMOR DONE
gosub cast

put .burgle
waitfor BURGLE DONE

put .armor wear
waitfor ARMOR DONE

put #walk n gate
waitfor YOU HAVE ARRIVED

put #walk necro
waitfor YOU HAVE ARRIVED

put #walk lounge
waitfor YOU HAVE ARRIVED

put #parse QIZBURGLE DONE
