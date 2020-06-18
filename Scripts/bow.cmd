include libsel.cmd

top:
    if $monsterdead > 0 then {
        gosub loot
        put .loot
        waitforre LOOT DONE
    }
    gosub load
    gosub aim
    pause 3
    gosub fire
    gosub load
    gosub aim
    pause 3
    gosub fire
    gosub load
    gosub aim
    pause 3
    gosub fire
goto top
