include libsel.cmd

var startRoom $roomid

gosub automove exchange
if ($zoneid = 1) then {
    put exchange all dok for kron
    pause .5
    put exchange all lir for kron
    pause .5
}

if ($zoneid = 107) then {
    put exchange all kron for lir
    pause .5
    put exchange all dok for lir
    pause .5
}
gosub automove teller
put deposit all
pause

put #parse DEP DONE
exit
