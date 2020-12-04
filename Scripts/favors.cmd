include libsel.cmd

var orbIsReady 0

action var orbIsReady 0 when You sense, though, that your sacrifice is not yet fully prepared.
action var orbIsReady 1 when You sense that your sacrifice is properly prepared.

if ("$righthandnoun" != "orb") then gosub stow right
gosub stow left


favorLoop:
    if ("$righthandnoun" != "orb") then gosub getFavorOrb
    put hug my orb
    pause
    if (%orbIsReady = 1) then {
        gosub placeOrb
        goto favorLoop
    }
    gosub collectRocks
    goto favorLoop



getFavorOrb:
    #gosub get my prayer chain
    gosub get my bead
    #gosub stow chain
    gosub put my bead on mistwood altar
    gosub pray
    waitforre ^An overwhelming sense of contentment fills you
    gosub get orb
    return


placeOrb:
    gosub put my orb on mistwood altar
    var orbIsReady 0
    return

collectRocks:
    put research fundamental 300
    gosub collect rock
    gosub kick pile

    return
