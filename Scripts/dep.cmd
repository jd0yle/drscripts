include libsel.cmd

var startRoom $roomid

gosub automove exchange
put exchange all dok for kron
pause .5
put exchange all lir for kron
pause .5
gosub automove teller
put deposit all
pause

put #parse DEP DONE
exit
