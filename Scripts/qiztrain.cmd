include libsel.cmd

timer start

var burgleCooldown 0
var nextBurgleCheck -1

action var burgleCooldown $1 when ^You should wait at least (\d+) roisaen
action var numBolts $1 when ^You count some basilisk bolts in the sheath and see there are (\S+) left\.$



main:
    if (%nextBurgleCheck < %t) then gosub checkBurgleCd

    if (%burgleCooldown = 0) then {
        put #echo >Log Train: Going to burgle
        gosub moveToNGate
        put .qizburgle
        waitforre ^QIZBURGLE DONE$
        gosub release eotb
    }

    #if ($Crossbow.LearningRate < 5 || $Staves.LearningRate < 5) then {
    #    put #echo >Log Train: Going to backtrain
    #    if ($zoneid != 11 || $roomid != 45) then {
    #        gosub moveToNGate
    #        gosub automove ntr
    #        gosub automove viper
    #        gosub automove 45
    #    }
    #    put .fight backtrain
    #    gosub waitForBacktrain
    #    goto main
    #}

    if ($Thanatology.LearningRate < 18 || $Crossbow.LearningRate < 5 || $Parry_Ability.LearningRate < 18) then {
        put #echo >Log Train: Going to main combat
        if ($zoneid != 11 || $roomid < 12 || $roomid > 22 || "$roomplayers" != "") then {
            gosub moveToNGate
            gosub automove ntr
            gosub automove viper
            gosub moveToLeucro
        }
        put .fight
        gosub waitForMainCombat
        goto main
    }

    put #echo >Log Train: Going to magic
    gosub moveToNGate
    gosub automove lounge
    put .qizhmur
    gosub waitForMagic

    goto main


moveToLeucro:
    if ($roomid = 0) then {
        gosub moveRandom
    }
    if ($roomid < 12 || $roomid > 20 || "$roomplayers" != "") then {
        put .findSpot leucro
        waitforre ^FINDSPOT DONE
    }
    return


waitForMagic:
    pause 2
    if (%nextBurgleCheck < %t) then {
        put #script abort all except qiztrain
        pause 1
        put #script abort all except qiztrain
        gosub checkBurgleCd
        put .qizhmur
    }
    if (%burgleCooldown = 0 || $Crossbow.LearningRate < 5 || $Staves.LearningRate < 5 || $Thanatology.LearningRate < 18) then {
        put #script abort all except qiztrain
        pause 1
        put #script abort all except qiztrain
        gosub stow right
        gosub stow left
        gosub release eotb
        return
    }
    goto waitForMagic



waitForBacktrain:
    pause 2
    if (%nextBurgleCheck < %t) then {
        put #script abort all except qiztrain
        pause 1
        put #script abort all except qiztrain
        gosub checkBurgleCd
        put .fight backtrain
        pause 1
    }
    if (%burgleCooldown = 0 || ($Crossbow.LearningRate > 32 && $Staves.LearningRate > 32) then {
        put #script abort all except qiztrain
        pause 1
        put #script abort all except qiztrain
        if ("$righthandnoun" = "lockbow") then gosub unload my lockbow
        gosub stow right
        gosub stow left
        gosub retrieveBolts
        return
    }
    goto waitForBacktrain



waitForMainCombat:
    pause 2
    if (%nextBurgleCheck < %t) then {
        put #script abort all except qiztrain
        pause 1
        put #script abort all except qiztrain
        gosub checkBurgleCd
        put .fight
        pause 1
    }
    if (%burgleCooldown = 0) then {
        put #script abort all except qiztrain
        pause 1
        put #script abort all except qiztrain
        if ("$righthandnoun" = "lockbow") then gosub unload my lockbow
        gosub stow right
        gosub stow left
        gosub retrieveBolts
        gosub stow hhr'ata
        gosub stow bola
        return
    }
    goto waitForMainCombat



retrieveBolts:
    gosub count my basilisk bolts
    if ("%numBolts" = "nineteen") then return
    gosub attack kick
    gosub loot
    put .loot
    waitforre ^LOOT DONE$
    goto retrieveBolts



checkBurgleCd:
    var burgleCooldown 0
    gosub burgle recall
    pause
    evalmath nextBurgleCheck (%burgleCooldown * 60) + %t
    put #echo >Log Next burgle check in %burgleCooldown minutes (%nextBurgleCheck s)
    return


waitForBurgleCd:
    if (%nextBurgleCheck < %t) then {
        gosub checkBurgleCd
    }
    if (%burgleCooldown = 0) then return
    pause 2
    goto waitForBurgleCd


moveToNGate:
    if ($roomid = 0) then {
        gosub moveRandom
        goto moveToNGate
    }
    # North Gate
    if ($zoneid = 6) then {
        gosub automove path
        if ($roomid != 106) then {
            gosub move go path
            pause
        }
        return
    }

    # NTR
    if ($zoneid = 7) then {
        gosub automove n gate
        goto moveToNGate
    }

    # Vipers / Leucros
    if ($zoneid = 11) then {
        gosub automove ntr
        goto moveToNGate
    }

    # Crossing
    if ($zoneid = 1) then {
        gosub automove n gate
        goto moveToNGate
    }

    gosub look
    gosub moveRandom
    goto moveToNGate


moveAny:
    if ($north) then {
        gosub move north
        goto moveToLeucro
    }
    if ($south) then {
        gosub move south
        goto moveToLeucro
    }
    if ($west) then {
        gosub move west
        goto moveToLeucro
    }
    if ($east) then {
        gosub move east
        goto moveToLeucro
    }
    if ($northeast) then {
        gosub move northeast
        goto moveToLeucro
    }
    if ($southeast) then {
        gosub move southeast
        goto moveToLeucro
    }
    if ($northwest) then {
        gosub move northwest
        goto moveToLeucro
    }
    if ($southwest) then {
        gosub move southwest
        goto moveToLeucro
    }
    return