####################################################################################################
# .astro
# Puts up all MM astrology buffs
# Selesthiel - justin@jmdoyle.com
# USAGE
# .astro
#
####################################################################################################

if ($SpellTimer.BraunsConjecture.active = 0 || $SpellTimer.BraunsConjecture.duration < 20) then {
    put .cast bc
    waitforre ^CAST DONE
}

if ($SpellTimer.DestinyCipher.active = 0 || $SpellTimer.DestinyCipher.duration < 20) then {
    put .cast dc
    waitforre ^CAST DONE
}

if ($SpellTimer.AuraSight.active = 0 || $SpellTimer.AuraSight.duration < 20) then {
    put .cast aus
    waitforre ^CAST DONE
}

if ($SpellTimer.PiercingGaze.active = 0 || $SpellTimer.PiercingGaze.duration < 20) then {
    put .cast pg
    waitforre ^CAST DONE
}

put #parse ASTRO DONE
