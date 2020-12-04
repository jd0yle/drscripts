include libsel.cmd

var isFullyPrepped 0
action var isFullyPrepped 1 when ^You feel fully prepared

if_1 then {
    var moon %1
}

var target %2

gosub prep fm 40
pause 5
gosub cast %moon

if ($SpellTimer.ClearVision.active != 1 || $SpellTimer.ClearVision.duration < 5) then {
    gosub prep cv 40
    pause 5
    gosub cast
}

if ($SpellTimer.ShiftMoonbeam.active != 1 || $SpellTimer.ShiftMoonbeam.duration < 2) then {
    gosub prep sm 40
    pause 5
    gosub cast
}

gosub prep loc 40
pause 5
gosub cast %target

var isFullyPrepped 0
gosub prep mg 20

gosub gesture %moon %target

gosub waitForPrep

gosub cast %moon

gosub move go moongate

gosub gesture %moon moongate

gosub release mg

exit




waitForPrep:
    if (%isFullyPrepped = 1) then return
    pause 1
    goto waitForPrep

