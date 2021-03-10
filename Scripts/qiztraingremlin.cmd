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
action var isFullyPrepped 0 when ^You mutter

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
gosub release eotb
gosub release rog
gosub release roc
gosub release usol
gosub retrieveBolts
gosub stow hhr'ata
gosub stow bola

main:
    if (%useBurgle = 1 && %nextBurgleCheck < %t) then gosub checkBurgleCd

    if (%useBurgle = 1 &&  %burgleCooldown = 0) then {
        put #echo >Log #cc99ff Train: Going to burgle
        gosub moveToBurgle
        gosub release spell
        gosub prep eotb

        put .armor remove
        waitforre ^ARMOR DONE$

        gosub cast

        put .burgle
        waitforre ^BURGLE DONE$

        put .armor wear
        waitforre ^ARMOR DONE$

        gosub release eotb

        gosub automove pawn

        put .pawn
        waitforre ^PAWN DONE$

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

        put withdraw 1 gold
        pause 1

    }

    if ($Thanatology.LearningRate < 5 || $Parry_Ability.LearningRate < 20 || $Shield_Usage.LearningRate < 20 || $Evasion.LearningRate < 5 || $Heavy_Thrown.LearningRate < 20 || $Targeted_Magic.LearningRate < 20) then {
        put #echo >Log #cc99ff Going to main combat
        gosub moveToPeccary
        put .fight
        gosub waitForMainCombat
        goto main
    }

    put #echo >Log #cc99ff Going to magic
    gosub moveToMagic
    put .qizhmur
    gosub waitForMagic

    goto main


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
    } else {
        if ($SpellTimer.RiteofContrition.active = 1) then gosub release roc
    }


    # West Gate
    if ("%zone" = "7") then {
        if ($roomid = 450) then return
        gosub automove 450
        goto moveToBurgle
    }

    # M'Riss
    if ("%zone" = "108") then {
        if ("$roomname" = "Belarritaco Bay, The Galley Dock") then {
            evalmath timeSinceSetGalleyDocked $gametime - $lastSetGalleyDocked
            if (%timeSinceSetGalleyDocked > 70 || $galleyDocked = 1) then {
                gosub move go galley
                gosub hide
                pause 5
            } else {
                if ($hidden = 0) then gosub hide
                pause 5
            }
            goto moveToBurgle
        } else {
            gosub automove 151
            goto moveToBurgle
        }
    }

    # Galley
    if ("%zone" = "107a" || "%zone" = "107b") then {
        evalmath timeSinceLastBoardedGalley $gametime - %lastBoardedGalley
        if (%timeSinceLastBoardedGalley > 60 && "$galleyDocked" = "1") then {
            gosub move go dock
            if ("$roomname" = "Mer'Kresh, The Galley Dock") then put sw
            pause
        } else {
            if ($hidden = 0) then gosub hide
            pause 5
        }
        goto moveToBurgle
    }

    if ("%zone" = "107") then {
        if ($roomid = "299") then return
        gosub automove 299
        goto moveToBurgle
    }

    # Fang Cove
    if ("%zone" = "150") then {
        gosub automove portal
        gosub move go portal
        goto moveToBurgle
    }

    # Crossing
    if ("%zone" = "1") then {
        gosub automove w gate
        goto moveToBurgle
    }

    goto moveToBurgle



moveToGremlins:
    if ("$roomname" = "Private Home Interior") then {
        gosub moveToLawn
        goto moveToGremlins
    }

    # Fang Cove
    if ($zoneid = 150) then {
        if ($roomid < 108 || $roomid > 117) then {
            put .findSpot gremlin
            waitforre ^FINDSPOT DONE$
            goto moveToGremlins
        }
        return
    }

    # Ilaya Taipa
    if ($zoneid = 112) then {
        gosub automove leth
        goto moveToGremlins
    }

    # Leth
    if ($zoneid = 61) then {
        gosub automove portal
        gosub move go portal
        goto moveToGremlins
    }

    # Crossing
    if ($zoneid = 1) then {
        gosub automove portal
        gosub move go portal
        goto moveToGremlins
    }

    # North Gate
    if ($zoneid = 6) then {
        gosub automove crossing
        goto moveToGremlins
    }

    # West Gate
    if ($zoneid = 7) then {
        gosub automove crossing
        goto moveToGremlins
    }

    goto moveToGremlins


moveToMriss:
    gosub setZone

    if ("%zone" = "108") then {
        if ($SpellTimer.RiteofGrace.active = 1) then gosub release rog
        if ($SpellTimer.RiteofContrition.active = 1) then gosub release roc
        if ($SpellTimer.UniversalSolvent.active = 1) then gosub release usol
        return
    }
    if ("%zone" = "107") then {
        if ("$roomname" = "Mer'Kresh, The Galley Dock") then {
            evalmath timeSinceSetGalleyDocked $gametime - $lastSetGalleyDocked
            if (%timeSinceSetGalleyDocked > 70 || "$galleyDocked" = "1") then {
                gosub move go galley
                gosub hide
                pause 5
            } else {
                if ($hidden = 0) then gosub hide
                pause 5
            }
            goto moveToMriss
        } else {
            gosub automove 113
            goto moveToMriss
        }
    }
    if ("%zone" = "107a" || "%zone" = "107b") then {
        evalmath timeSinceLastBoardedGalley $gametime - %lastBoardedGalley
        if (%timeSinceLastBoardedGalley > 60 && "$galleyDocked" = "1") then {
            gosub move go dock
            if ("$roomname" = "Belarritaco Bay, The Galley Dock") then {
                put n
                pause
            }
        } else {
            if ($hidden = 0) then gosub hide
            pause 5
        }
        goto moveToMriss
    }

    goto moveToMriss


moveToMagic:
    # North Gate
    if ($zoneid = 6) then {
        gosub automove lounge
        if ($roomid != 106) then {
            gosub move go path
            pause
        }
        return
    }

    # MRISS
    if ($zoneid = 108) then {
        if ($roomid = 163) then return
        gosub automove 163
        goto moveToMagic
    }

    if ($zoneid = 1) then {
        gosub automove n gate
        goto moveToMagic
    }

    goto moveToMagic


moveToPeccary:
    if ("$zoneid" != "108") then gosub moveToMriss
    if ($roomid = 195) then return
    gosub automove 195
   # if ($roomid = 257) then return
 #   gosub automove 257
    goto moveToPeccary


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
        put #script abort all except qiztrainmriss
        pause 1
        put #script abort all except qiztrainmriss
        gosub checkBurgleCd
        put .qizhmur
        pause 1
    }
    if (%burgleCooldown = 0 || $Thanatology.LearningRate < -1 || $Evasion.LearningRate < 0 || $Parry_Ability.LearningRate < 5 || $Shield_Usage.LearningRate < 5 ) then {
        put #script abort all except qiztrainmriss
        pause 1
        put #script abort all except qiztrainmriss
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
        put #script abort all except qiztrainmriss
        pause 1
        put #script abort all except qiztrainmriss
        gosub checkBurgleCd
        put .fight
        pause 1
    }
    if (%burgleCooldown = 0 || ($Thanatology.LearningRate > 3 && $Evasion.LearningRate > 30 && $Shield_Usage.LearningRate > 30 && $Parry_Ability.LearningRate > 30 && $Heavy_Thrown.LearningRate > 30 && $Targeted_Magic.LearningRate > 30)) then {
        put #script abort all except qiztrainmriss
        pause 1
        put #script abort all except qiztrainmriss
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
    put #echo >Log #adadad Next burgle check in %burgleCooldown minutes (%nextBurgleCheck s)
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
    put #script abort all except seltrain
    pause 1
    put #script abort all except seltrain
    put exit
    exit
