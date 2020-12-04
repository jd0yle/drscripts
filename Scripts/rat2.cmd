include libsel.cmd

action #send search when ^You notice a small rat scurrying around the area.
action move $1 when A small rat scurries (\S+).$

waiting:
    pause 2
    goto waiting