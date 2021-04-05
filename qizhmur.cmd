include libmaster.cmd

#put .var_Qizhmur
#waitforre ^CHARVARS DONE

var expectedNumBolts thirty-four

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

put .reconnect

gosub stow right
gosub stow left
gosub release rog
gosub release usol
gosub release symbiosis
gosub retrieveBolts
gosub stow hhr'ata
gosub stow bola


matchre startRepair ^You tap a
matchre main ^I could not find
gosub tap my ticket
matchwait

startRepair:
    gosub moveToMagic
    gosub waitForRepair

if_1 then {
    if ("%1" = "research") then {
        var startResearch 1
        goto startMagic
    }
    if ("%1" = "fight") then {
        goto startFight
    }
    if ("%1" = "magic") then {
        goto startMagic
    }
}

main:
    if (%useBurgle = 1 && %nextBurgleCheck < %t) then gosub checkBurgleCd

    if (%useBurgle = 1 &&  %burgleCooldown = 0) then {
        put #echo >Log #cc99ff Train: Going to burgle

        if ($SpellTimer.EyesoftheBlind.active != 1 || $SpellTimer.EyesoftheBlind.duration < 5) then {
            gosub prep eotb
            pause 2
            gosub cast
        }

        if ($SpellTimer.RiteofContrition.active != 1) then {
            gosub release usol
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

        put .armor wear
        waitforre ^ARMOR DONE$

        gosub automove n gate
        gosub automove portal

        gosub release eotb
        gosub move go meeting portal

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

        gosub runScript repair
        gosub waitForRepair

        gosub automove 106
        pause 1
        put .qizhmur
        put .reconnect
    }


    startMagic:
    if ($Arcana.LearningRate < 30 || $Utility.LearningRate < 30 || $Warding.LearningRate < 30 || $Sorcery.LearningRate < 2) then {
        put #echo >Log #cc99ff Going to magic
        gosub moveToHouse

        if ("$roomname" != "Private Home Interior") then {
            put #echo >Log #cc99ff House won't open, going to FC
            gosub moveToMagic
        }

		if (contains("$roomplayers", "Selesthiel") && contains("$roomplayers", "Inauri")) then {
		    gosub listen to Selesthiel
		    gosub listen to Inauri observe
		    gosub teach tm to Inauri
		    gosub teach tm to Selesthiel
		} else {
		    if (contains("$roomplayers", "Inauri")) then {
		        gosub teach tm to inauri
		        gosub listen to inauri observe
		    }
		}

        if ($Sorcery.LearningRate < 2 || %startResearch = 1) then {
            var startResearch 0
            put .research sorcery
            waitforre ^RESEARCH DONE$
            if ($standing != 1) then gosub stand
            gosub release roc
            if ($bleeding = 1) then gosub runScript devour all
        }
        put .reconnect
        put .magic
        gosub waitForMagic
    }

    startFight:
    #if ($Thanatology.LearningRate < 5 || $Parry_Ability.LearningRate < 20 || $Shield_Usage.LearningRate < 20 || $Evasion.LearningRate < 0 || $Heavy_Thrown.LearningRate < 15 || $Targeted_Magic.LearningRate < 0) then {
        gosub waitForRepair
        put #echo >Log #cc99ff Going to main combat
        gosub moveToAdanf
        put .fight
        gosub waitForMainCombat
        goto main
    #}
    goto main



sorceryCont:
    put #script abort all except qizhmur
    put .reconnect
    pause 1
    put #script abort all except qizhmur
    put .reconnect
    goto magicCont



moveToAdanf:
    gosub setZone

    if ("$roomname" = "Private Home Interior") then {
        gosub runScript house
        goto moveToAdanf
    }

    # Shard South Gate Area
    if ("%zone" = "68") then {
        gosub automove 214
        goto moveToAdanf
    }

    # Ice Caves
    if ("%zone" = "68a") then {
        put .findSpot adanf
        waitforre ^FINDSPOT DONE$
        return
    }

    # Shard East Gate Area
    if ("%zone" = "66") then {
        gosub automove s gate
        goto moveToAdanf
    }

    # Shard
    if ("%zone" = "67") then {
        gosub automove 132
        goto moveToAdanf
    }

    # Shard West Gate Area
    if ("%zone" = "69") then {
        echo
        echo ** MOVE FROM WEST GATE TO ROOM 1 (east gate) **
        echo
        gosub automove n gate
        goto moveToAdanf
    }

    # FC
    if ("%zone" = "150") then {
        gosub automove portal
        gosub release eotb
        gosub move go portal
        goto moveToAdanf
    }

    goto moveToAdanf


moveToBurgle:
    gosub setZone



    if ("$preparedspell" != "None") then gosub release spell
    if ($SpellTimer.RiteofGrace.active = 1) then gosub release rog
    if ($SpellTimer.UniversalSolvent.active = 1) then gosub release usol
    if ($SpellTimer.PhilosophersPreservation.active = 1 || $SpellTimer.CalcifiedHide.active = 1 || $SpellTimer.ButchersEye.active = 1 || $SpellTimer.IvoryMask.active = 1) then {
        if ($SpellTimer.RiteofContrition.active != 1) then {
            gosub release usol
            gosub prep roc
            gosub waitForPrep
            gosub release usol
            gosub cast
        }
    }

    if ("$roomname" = "Private Home Interior") then {
        gosub runScript house
        goto moveToBurgle
    }

    # Ice Caves
    if ("%zone" = "68a") then {
        gosub automove 30
        goto moveToBurgle
    }

    # Shard S Gate
    if ("%zone" = "68") then {
        gosub automove e gate
        goto moveToBurgle
    }

    # Abandoned Mine
    if ("%zone" = "10") then {
        gosub automove ntr
        goto moveToBurgle
    }

    # NTR
    if ("%zone" = "7") then {
        gosub automove n gate
        goto moveToBurgle
    }

    # Crossing N Gate
    if ("%zone" = "6") then {
        gosub automove w gate
        goto moveToBurgle
    }

    # Crossing W Gate
    if ("%zone" = "4") then {
        if ("$roomid" = "450") then return
        gosub automove 450
        goto moveToBurgle
    }

    # Crossing
    if ("%zone" = "1") then {
        gosub automove w gate
        goto moveToBurgle
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



moveToHouse:
    gosub setZone

    if ("$roomname" = "Private Home Interior") then return

    # Ice Caves
    if ("%zone" = "68a") then {
        gosub automove 30
        goto moveToHouse
    }

    # Shard S Gate
    if ("%zone" = "68") then {
        gosub automove e gate
        goto moveToHouse
    }

    # Abandoned Mine
    if ("%zone" = "10") then {
        gosub automove ntr
        goto moveToHouse
    }

    # NTR
    if ("%zone" = "7") then {
        gosub automove crossing
        goto moveToHouse
    }

    # Crossing N Gate
    if ("%zone" = "6") then {
        gosub automove crossing
        goto moveToHouse
    }

    # Crossing W Gate
    if ("%zone" = "4") then {
        gosub automove crossing
        goto moveToHouse
    }

    # Crossing
    if ("%zone" = "1") then {
        gosub automove portal
        if ($SpellTimer.EyesoftheBlind.active = 1) then gosub release eotb
        gosub move go meeting portal
        if ($SpellTimer.EyesoftheBlind.active = 1) then gosub release eotb
        goto moveToHouse
    }

    # Shard East Gate Area
    if ("%zone" = "66") then {
        if ("$roomname" = "Private Home Interior") then return
        if ("$roomid" = "252") then {
            gosub release eotb
            gosub peer door
            pause 10
            gosub open door
            gosub move go door
            gosub close door
            gosub lock door
            return
        } else {
            gosub automove 252
        }
        goto moveToHouse
    }

    # Shard
    if ("%zone" = "67") then {
        gosub automove 132
        goto moveToHouse
    }

    # Shard West Gate Area
    if ("%zone" = "69") then {
        gosub automove n gate
        goto moveToHouse
    }

    # FC
    if ("%zone" = "150") then {
        gosub automove portal
        gosub release eotb
        gosub move go portal
        goto moveToHouse
    }

    goto moveToHouse
    

moveToMagic:
    gosub setZone

    if ("$roomname" = "Private Home Interior") then {
        gosub runScript house
        goto moveToMagic
    }

    # Ice Caves
    if ("%zone" = "68a") then {
        gosub automove 30
        goto moveToMagic
    }

    # Shard S Gate
    if ("%zone" = "68") then {
        gosub automove e gate
        goto moveToMagic
    }

    # Abandoned Mine
    if ("%zone" = "10") then {
        gosub automove ntr
        goto moveToMagic
    }

    # NTR
    if ("%zone" = "7") then {
        gosub automove crossing
        goto moveToMagic
    }

    # Crossing N Gate
    if ("%zone" = "6") then {
        gosub automove crossing
        goto moveToMagic
    }

    # Crossing W Gate
    if ("%zone" = "4") then {
        gosub automove crossing
        goto moveToMagic
    }

    # Crossing
    if ("%zone" = "1") then {
        gosub automove portal
        if ($SpellTimer.EyesoftheBlind.active = 1) then gosub release eotb
        gosub move go meeting portal
        if ($SpellTimer.EyesoftheBlind.active = 1) then gosub release eotb
        goto moveToMagic
    }

    # Shard East Gate Area
    if ("%zone" = "66") then {
        gosub automove portal
        gosub release eotb
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
        gosub release eotb
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



moveToWarklin:
    gosub setZone

    # Abandoned Mine
    if ("%zone" = "10") then {
        gosub automove 46
        put .findSpot warklin
        waitforre ^FINDSPOT DONE$
        return
    }

    # NTR
    if ("%zone" = "7") then {
        gosub automove 396
        goto moveToWarklin
    }

    # Crossing N Gate
    if ("%zone" = "6") then {
        gosub automove ntr
        goto moveToWarklin
    }

    # Crossing W Gate
    if ("%zone" = "4") then {
        gosub automove n gate
        goto moveToWarklin
    }

    # Crossing
    if ("%zone" = "1") then {
        gosub automove ne gate
        goto moveToWarklin
    }

    # FC
    if ("%zone" = "150") then {
        gosub automove portal
        gosub move go exit portal
        goto moveToWarklin
    }

    echo No move target found, zoneid = $zoneid  zone = %zone
    goto moveToWarklin


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
        put #script abort all except qizhmur
put .reconnect
        pause 1
        put #script abort all except qizhmur
put .reconnect
        gosub checkBurgleCd
        put .qizhmur
        pause 1
    }
    #if (%burgleCooldown = 0 || $Thanatology.LearningRate < -1 || $Evasion.LearningRate < 5 || $Parry_Ability.LearningRate < 5 || $Shield_Usage.LearningRate < 5 || $Targeted_Magic.LearningRate < 5 || $Heavy_Thrown.LearningRate < 5 || $Crossbow.LearningRate < 5 ) then {
    if (%burgleCooldown = 0 || ($Warding.LearningRate > 31 && $Augmentation.LearningRate > 31 && $Utility.LearningRate > 31 && $Arcana.LearningRate > 31)) then {
        put #script abort all except qizhmur
put .reconnect
        pause 1
        put #script abort all except qizhmur
put .reconnect
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
        put #script abort all except qizhmur
put .reconnect
        pause 1
        put #script abort all except qizhmur
put .reconnect
        gosub checkBurgleCd
        put .fight
        pause 1
    }
    if (%burgleCooldown = 0 || ($Thanatology.LearningRate > 3 && $Evasion.LearningRate > 30 && $Shield_Usage.LearningRate > 30 && $Parry_Ability.LearningRate > 30 && $Heavy_Thrown.LearningRate > 30 && $Targeted_Magic.LearningRate > 30)) then {
        put #script abort all except qizhmur
put .reconnect
        pause 1
        put #script abort all except qizhmur
put .reconnect
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
    var retrieveAttempts 0
retrieveBoltsLoop:
    gosub count my basilisk bolts
    if ("%numBolts" = "%expectedNumBolts") then {
        gosub stow right
        return
    } else {
        echo WRONG NUMBER OF BOLTS, found %numBolts expected %expectedNumBolts
    }
    if ("$righthandnoun" != "scimitar") then {
        gosub stow right
        gosub get my haralun scimitar
    }
    gosub attack kick
    gosub loot treasure
    put .loot
    waitforre ^LOOT DONE$
    math retrieveAttempts add 1
    if (%retrieveAttempts < 10 && $monstercount > 0) then goto retrieveBoltsLoop
    var expectedNumBolts %numBolts
    return



checkBurgleCd:
    var burgleCooldown 0

    if ($Stealth.LearningRate > 0) then var burgleCooldown $Stealth.LearningRate
    if ($Athletics.LearningRate < %burgleCooldown) then var burgleCooldown $Athletics.LearningRate
    if ($Locksmithing.LearningRate < %burgleCooldown) then var burgleCooldown $Locksmithing.LearningRate

    if (%burgleCooldown = 0) then {
        gosub burgle recall
        pause
    }

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


waitForRepair:
    matchre waitForRepairLoop You recall that the repairs won't be ready for another (\d+) roisaen.
    matchre waitForRepairLoop any moment
    matchre repairDone ready by now
    matchre return ^I could not find
    put look at ticket
    matchwait 3
    goto waitForRepair

waitForRepairLoop:
    var minutesToWait $1
    if (!(%minutesToWait > 0)) then var minutesToWait 1
    evalmath nextCheckTicketGametime (%minutesToWait * 60 + $gametime)

    waitForRepairLoop1:
    if (%nextCheckTicketGametime < $gametime) then goto waitForRepair
    pause 10
    goto waitForRepairLoop1


repairDone:
    gosub moveToMagic
    gosub runScript repair
    gosub automove 106
    put .qizhmur

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



logout:
    put exit
    put #script abort all except qizhmur
put .reconnect
    pause 1
    put #script abort all except qizhmur
put .reconnect
    put exit
    exit
