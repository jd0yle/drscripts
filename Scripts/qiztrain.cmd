include libsel.cmd

var burgleCooldown 0

action var burgleCooldown $1 when ^You should wait at least (\d+) roisaen
action var numBolts $1 when ^You count some basilisk bolts in the sheath and see there are (\S+) left\.$



main:
    gosub checkBurgleCd
    echo burgleCooldown is %burgleCooldown
    if (%burgleCooldown = 0) then {
        put #echo >Log Train: Going to burgle
        gosub moveToNGate
        put .qizburgle
        waitforre ^QIZBURGLE DONE$
        gosub release eotb
    }

    if ($Crossbow.LearningRate < 18 || $Staves.LearningRate < 18) then {
        put #echo >Log Train: Going to backtrain
        if ($zoneid != 11 || $roomid != 45) then {
            gosub moveToNGate
            gosub automove ntr
            gosub automove viper
            gosub automove 45
        }
        put .fight backtrain
        gosub waitForBacktrain
        goto main
    }

    put #echo >Log Train: Going to magic
    gosub moveToNGate
    gosub automove lounge
    put .qizhmur
    gosub waitForMagic

    goto main




waitForMagic:
    pause 2
    if ($Crossbow.LearningRate < 5 || $Staves.LearningRate < 5 || $Athletics.LearningRate < 5) then {
        put #script abort qizhmur
        gosub stow right
        gosub stow left
        gosub release eotb
        return
    }
    goto waitForMagic


waitForBacktrain:
    pause 2
    if ($Crossbow.LearningRate < 32 || $Staves.LearningRate < 32) then goto waitForBacktrain
    put #script abort fight
    if ("$righthandnoun" = "lockbow") then gosub unload my lockbow
    gosub stow right
    gosub stow left
    gosub retrieveBolts
    return



retrieveBolts:
    gosub count my basilisk bolts
    if ("%numBolts" = "twenty") then return
    gosub attack kick
    gosub loot
    put .loot
    waitforre ^LOOT DONE$
    goto retrieveBolts



checkBurgleCd:
    var burgleCooldown 0
    gosub burgle recall
    pause
    return


moveToNGate:
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
    }

    # Vipers / Leucros
    if ($zoneid = 11) then {
        gosub automove ntr
    }

    # Crossing
    if ($zoneid = 1) then {
        gosub automove n gate
    }

    goto moveToNGate