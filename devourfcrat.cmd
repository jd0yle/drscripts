include libmaster.cmd
include var_mobs.cmd

gosub stow right
gosub stow left
gosub release spell

loop:
    if ($SpellTimer.Devour.active = 1) then goto done
    if (matchre ("$roomobjs", "(%critters) ((which|that) appears dead|(dead))")) then {
        var mobName $1
        gosub prep devour 30
        gosub perform preserve on %mobName
        gosub perform consume on %mobName
        gosub prep devour 30
        gosub charge calf 30
        gosub invoke calf 30 spell
        gosub waitForPrep
        gosub cast
        gosub loot
        pause .5
    } else if ($monstercount > 0) then {
        gosub attack kick
    }
    pause .5
    goto loop



done:
    pause .2
    put #parse DEVOURFCRAT DONE
    exit