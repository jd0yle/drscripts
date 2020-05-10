include libsel.cmd

var spell %1
var isFullyPrepped 0

action var isFullyPrepped 1 when ^You feel fully prepared to cast your spell.

gosub stow right
gosub prep %1 20
gosub get my globe
gosub charge my globe 20
gosub charge my globe 20
gosub charge my globe 20
gosub charge my globe 20
gosub focus my globe
gosub invoke my globe
goto waitPrep

waitPrep:
pause 1
if %isFullyPrepped != 1 then goto waitPrep
gosub cast
gosub stow my globe
