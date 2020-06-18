include libsel.cmd

top:
    if $monsterdead > 0 then {
        gosub loot
        put .loot
        waitforre LOOT DONE
    }
    gosub get hhr'ata
    gosub attack throw
    goto top
