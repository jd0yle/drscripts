####################################################################################################
# .astro
# Puts up all MM astrology buffs
# Selesthiel - justin@jmdoyle.com
# USAGE
# .astro
#
####################################################################################################

include libsel.cmd

if ($SpellTimer.Shadowling.active = 0 || $SpellTimer.Shadowling.duration < 5) then {
    gosub release shadowling
    put .cast shadowling
    waitforre ^CAST DONE
}

gosub waitConcentration

if ($SpellTimer.BraunsConjecture.active = 0 || $SpellTimer.BraunsConjecture.duration < 5) then {
    put .cast bc
    waitforre ^CAST DONE
}

gosub waitConcentration

if ($SpellTimer.DestinyCipher.active = 0 || $SpellTimer.DestinyCipher.duration < 5) then {
    put .cast dc
    waitforre ^CAST DONE
}

gosub waitConcentration

if ($SpellTimer.AuraSight.active = 0 || $SpellTimer.AuraSight.duration < 5) then {
    put .cast aus
    waitforre ^CAST DONE
}

gosub waitConcentration

if ($SpellTimer.PiercingGaze.active = 0 || $SpellTimer.PiercingGaze.duration < 5) then {
    put .cast pg
    waitforre ^CAST DONE
}

gosub stow right
gosub stow left
pause
put #parse ASTRO DONE
exit


waitConcentration:
    if ($concentration > 30) then return
    pause 1
    goto waitConcentration
