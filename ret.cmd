############################################################################
# .ret
# Selesthiel - justin@jmdoyle.com
# Keeps you out of combat
############################################################################
include libsel.cmd

var doRetreat 1
action var doRetreat 1 when closes to pole weapon range on you!$
action var doRetreat 1 when closes to melee range on you!$
action var doRetreat 1 when begins to advance on you!$

loop:
    pause .2
    if (%doRetreat = 1) then {
        gosub retreat
        var doRetreat 0
    }
    goto loop
