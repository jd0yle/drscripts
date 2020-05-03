

loop:
    if $monstercount > 1 then
    {
        send slice
        pause

        send draw
        pause
    }

    #if matchre("$roomobjs", "dead") then
    if $monsterdead > 0 then
    {
        send skin
        send loot
        var loot 0
    }
    pause 4
goto loop
