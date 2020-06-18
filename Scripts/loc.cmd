include libsel.cmd

var target %1
var prepAt 50
if_2 then {
    var prepAt %1
    var target %2
}



if ($SpellTimer.ClearVision.active = 0 || $SpellTimer.ClearVision.duration < 3) then {
    put .cast cv
    waitforre ^CAST DONE
}

gosub prep locate %prepAt
waitfor You feel fully prepared to cast your spell.
gosub cast %target
