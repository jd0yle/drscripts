include libsel.cmd

action goto logout when eval $health < 50
action goto logout when eval $dead = 1

timer start

var useBurgle 1
var burgleCooldown 0
var nextBurgleCheck -1

var isFullyPrepped 0
action var isFullyPrepped 1 when ^You feel fully prepared to cast your spell.
action var isFullyPrepped 1 when ^Your concentration slips for a moment, and your spell is lost.$
action var isFullyPrepped 0 when ^You trace an angular sigil in the air

action var burgleCooldown $1 when ^You should wait at least (\d+) roisaen
action var numBolts $1 when ^You count some basilisk bolts in the sheath and see there are (\S+) left\.$

action put #var galleyDocked 1 when ^The galley \S+ reaches the dock
action put #var galleyDocked 1 when glides into the dock
action put #var galleyDocked 1 when ^The Captain stops you and requests a transportation fee
action put #var galleyDocked 0 when Cast off
action put #var galleyDocked 0 when ^You look around in vain for the galley.
action put #var galleyDocked 0 when ^The galley has just left the harbor.
action put #var galleyDocked 0 when ^The galley (\S+) pulls away from the dock.
action put #var galleyDocked 0 when ^You see no dock.

var lastBoardedGalley 0
action var lastBoardedGalley $gametime when ^The Captain stops you and requests a transportation fee

action put #var lastSetGalleyDocked $gametime; echo new lastSetGalleyDocked is $lastSetGalleyDocked when eval $galleyDocked

if (!($lastSetGalleyDocked > 0)) then put #var lastSetGalleyDocked 0

gosub stow right
gosub stow left
gosub release rog
gosub release usol
gosub retrieveBolts
gosub stow hhr'ata
gosub stow bola

main:
    if (%useBurgle = 1 && %nextBurgleCheck < %t) then gosub checkBurgleCd

    if (%useBurgle = 1 &&  %burgleCooldown = 0) then {
        put #echo >Log #cc99ff Train: Going to burgle

        if ($SpellTimer.EyesoftheBlind.active != 1 || $SpellTimer.EyesoftheBlind.duration < 5) then {
            gosub prep eotb
            pause 5
            gosub cast
        }

        if ($SpellTimer.RiteofContrition.active != 1) then {
            gosub prep roc
            gosub waitForPrep
            gosub cast
        }

        gosub moveToBurgle
        gosub release spell


        put .armor remove
        waitforre ^ARMOR DONE$

        gosub cast

        put .burgle
        waitforre ^BURGLE DONE$

        gosub devourIfNeeded

        put .armor wear
        waitforre ^ARMOR DONE$

        gosub automove n gate

        gosub automove portal
        if ($SpellTimer.EyesoftheBlind.active = 1) then gosub release eotb
        gosub move go meeting portal

        if ($SpellTimer.EyesoftheBlind.active = 1) then gosub release eotb

        gosub automove bundle
        gosub remove my bundle
        gosub sell my bundle
        gosub stow right
        gosub stow left
        gosub get bundle from my skull
        gosub sell my bundle
        gosub stow right
        gosub stow left
        gosub get bundle from my skull
        gosub sell my bundle
        gosub stow right
        gosub stow left
        gosub get bundle from my portal
        gosub sell my bundle
        gosub stow right
        gosub stow left
        gosub get bundle from my portal
        gosub sell my bundle
        gosub stow right
        gosub stow left

        put .dep
        waitforre ^DEP DONE$
        pause 1
        put .qiztrainshard

    }

    if ($Arcana.LearningRate < 30 || $Utility.LearningRate < 30 || $Warding.LearningRate < 30) then {
        put #echo >Log #cc99ff Going to magic
        gosub moveToMagic
        put .qizhmur
        gosub waitForMagic
    }

    #if ($Thanatology.LearningRate < 5 || $Parry_Ability.LearningRate < 20 || $Shield_Usage.LearningRate < 20 || $Evasion.LearningRate < 0 || $Heavy_Thrown.LearningRate < 15 || $Targeted_Magic.LearningRate < 0) then {
        put #echo >Log #cc99ff Going to main combat
        gosub moveToYellowGremlin
        #gosub moveToRedGremlin
        put .fight
        gosub waitForMainCombat
        goto main
    #}


    goto main



devourIfNeeded:
    if ($bleeding = 1) then {
        if ($SpellTimer.Devour.active = 1) then gosub waitToDevour
        gosub stow right
        gosub stow left
        if ("$preparedspell" != "none") then gosub release spell

        gosub get my material
        if ("$righthandnoun"  != "material") then {
            put #echo >Log #FFFF00 OUT OF MATERIAL
            return
        }

        put #echo >Log #FFFF00 HEALING WITH DEVOUR
        put .devour
        waitforre ^DEVOUR DONE$
        goto devourIfNeeded
    }
    return


waitToDevour:
    if ($bleeding != 1 || $SpellTimer.Devour.active != 1) then return
    pause 1
    goto waitToDevour



moveToBurgle:
    gosub setZone

    if ("$preparedspell" != "None") then gosub release spell
    if ($SpellTimer.RiteofGrace.active = 1) then gosub release rog
    if ($SpellTimer.UniversalSolvent.active = 1) then gosub release usol
    if ($SpellTimer.PhilosophersPreservation.active = 1 || $SpellTimer.CalcifiedHide.active = 1 || $SpellTimer.ButchersEye.active = 1 || $SpellTimer.IvoryMask.active = 1) then {
        if ($SpellTimer.RiteofContrition.active != 1) then {
            gosub prep roc
            gosub waitForPrep
            gosub cast
        }
    }

    # Shard West Gate Area
    if ("%zone" = "69") then {
        if ("$roomid" = "204") then return
        gosub automove 204
        goto moveToBurgle
    }

    # Shard East Gate Area
    if ("%zone" = "66") then {
        gosub automove 217
        goto moveToBurgle
    }

    # Shard
    if ("%zone" = "67") then {
        gosub automove 132
        goto moveToBurgle
    }

    # FC
    if ("%zone" = "150") then {
        gosub automove portal
        gosub move go exit portal
        goto moveToBurgle
    }

    goto moveToBurgle


moveToMagic:
    gosub setZone
    #545
    # Shard East Gate Area
    if ("%zone" = "66") then {
        gosub automove portal
        gosub move go meeting portal
        goto moveToMagic
    }

    # Shard
    if ("%zone" = "67") then {
        gosub automove 132
        goto moveToMagic
    }

    # Shard West Gate Area
    if ("%zone" = "69") then {
        gosub automove n gate
        goto moveToMagic
    }

    # FC
    if ("%zone" = "150") then {
        if ("$roomid" = "106") then return
        gosub automove 106
        goto moveToMagic
    }

    goto moveToMagic




moveToRedGremlin:
    gosub setZone

    # Shard East Gate Area
    if ("%zone" = "66") then {

        echo
        echo ** MOVE FROM EAST GATE TO ROOM 626 (gremlins) **
        echo

        if ("$roomid" != "626") then gosub automove 626
        put .findSpot redgremlin
        waitforre ^FINDSPOT DONE$
        return
    }

    # Shard
    if ("%zone" = "67") then {
        gosub automove 132
        goto moveToRedGremlin
    }

    # Shard West Gate Area
    if ("%zone" = "69") then {
        echo
        echo ** MOVE FROM WEST GATE TO ROOM 1 (east gate) **
        echo
        gosub automove n gate
        goto moveToRedGremlin
    }

    # FC
    if ("%zone" = "150") then {
        gosub automove portal
        gosub move go exit portal
        goto moveToRedGremlin
    }

    goto moveToRedGremlin
    
    
    
moveToYellowGremlin:
    gosub setZone

    # Shard East Gate Area
    if ("%zone" = "66") then {
        gosub automove portal
        gosub move go meeting portal
        goto moveToYellowGremlin
    }

    # Shard
    if ("%zone" = "67") then {
        gosub automove 132
        goto moveToYellowGremlin
    }

    # Shard West Gate Area
    if ("%zone" = "69") then {
        echo
        echo ** MOVE FROM WEST GATE TO ROOM 1 (east gate) **
        echo
        gosub automove n gate
        goto moveToYellowGremlin
    }

    # FC
    if ("%zone" = "150") then {
        if ("$roomid" != "111") then gosub automove 111
        put .findSpot gremlin
        waitforre ^FINDSPOT DONE$
        return
    }

    goto moveToYellowGremlin
        


setZone:
    var zone $zoneid

    if ("$roomname" = "Belarritaco Bay, The Galley Dock") then var zone 108
    if ("$roomname" = "Mer'Kresh, The Galley Dock") then var zone 107
    if ("$roomname" = "The Galley Sanegazat") then var zone 107a
    if ("$roomname" = "The Galley Cercorim") then var zone 107b
    if ("$roomname" = "Mer'Kresh, The Galley Dock") then var zone 107


    if ("%zone" = "0") then {
        put n
        pause .2
        put sw
        pause
        goto setZone
    }

    return


waitForMagic:
    pause 2
    if (%useBurgle = 1 && %nextBurgleCheck < %t) then {
        put #script abort all except qiztrainshard
        pause 1
        put #script abort all except qiztrainshard
        gosub checkBurgleCd
        put .qizhmur
        pause 1
    }
    #if (%burgleCooldown = 0 || $Thanatology.LearningRate < -1 || $Evasion.LearningRate < -1 || $Parry_Ability.LearningRate < 5 || $Shield_Usage.LearningRate < 5 ) then {
    if (%burgleCooldown = 0 || $Thanatology.LearningRate < -1 || $Evasion.LearningRate < -1 || $Warding.LearningRate > 30 ) then {
        put #script abort all except qiztrainshard
        pause 1
        put #script abort all except qiztrainshard
        gosub stow right
        gosub stow left
        gosub release eotb
        gosub retrieveBolts
        gosub stow hhr'ata
        gosub stow bola
        return
    }
    goto waitForMagic


waitForMainCombat:
    pause 2
    if (%useBurgle = 1 && %nextBurgleCheck < %t) then {
        put #script abort all except qiztrainshard
        pause 1
        put #script abort all except qiztrainshard
        gosub checkBurgleCd
        put .fight
        pause 1
    }
    if (%burgleCooldown = 0 || ($Thanatology.LearningRate > 3 && $Evasion.LearningRate > 0 && $Shield_Usage.LearningRate > 20 && $Parry_Ability.LearningRate > 20 && $Heavy_Thrown.LearningRate > 25 && $Targeted_Magic.LearningRate > 0)) then {
        put #script abort all except qiztrainshard
        pause 1
        put #script abort all except qiztrainshard
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
    if ("%numBolts" = "seventeen") then return
    gosub attack kick
    gosub loot
    put .loot
    waitforre ^LOOT DONE$
    goto retrieveBolts



checkBurgleCd:
    var burgleCooldown 0
    gosub burgle recall
    pause
    evalmath nextBurgleCheck (%burgleCooldown * 60) + 60 + %t
    put #echo >Log #adadad Next burgle check in %burgleCooldown minutes
    return


waitForBurgleCd:
    if (%nextBurgleCheck < %t) then {
        gosub checkBurgleCd
    }
    if (%burgleCooldown = 0) then return
    pause 2
    goto waitForBurgleCd


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


waitForPrep:
    if (%isFullyPrepped = 1 || "$preparedspell" = "None") then return
    pause .5
    goto waitForPrep


logout:
    put exit
    put #script abort all except qiztrainshard
    pause 1
    put #script abort all except qiztrainshard
    put exit
    exit
