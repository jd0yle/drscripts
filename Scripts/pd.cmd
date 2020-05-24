include libsel.cmd

var isFullyPrepped 0

action var isFullyPrepped 1 when ^You feel fully prepared to cast your spell.
action var isFullyPrepped 1 when ^Your formation of a targeting pattern

gosub prep pd 20
gosub target
gosub harn 20
gosub harn 20
if (%isFullyPrepped != 1) then gosub waitForPrep
gosub cast
exit



waitForPrep:
    pause 1
    if (%isFullyPrepped = 1) then return
    goto waitForPrep
