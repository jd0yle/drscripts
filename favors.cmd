include libmaster.cmd

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
        put favor
        goto favorLoop
    }
    gosub collectRocks
    goto favorLoop



getFavorOrb:
    gosub get my huldah orb
    if ("$righthandnoun" = "orb") then return
    #gosub get my prayer chain
    gosub get my weasel bead
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
    if ($SpellTimer.GaugeFlow.duration < 10) then gosub runScript cast gaf
    put research fundamental 300

    gosub appraise.onTimer

    gosub observe.onTimer

    gosub perc.onTimer

    if ($Astrology.LearningRate < 15) then {
        gosub runScript predict
    }

    gosub collect rock
    gosub kick pile

    return
