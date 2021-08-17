include libmaster.cmd

put awake

#put .var_Qizhmur
#waitforre ^CHARVARS DONE

var expectedNumBolts fifty-six

action goto logout when eval $health < 50
action goto logout when eval $dead = 1

action (health) goto getHealedTrigger when eval $health < 85
action (health) goto getHealedTrigger when eval $bleeding = 1
action (health) goto getHealedTrigger when ^TESTHEAL

action send $lastcommand when ^You can't move in that direction while unseen.

action send listen to $1 observe when ^(\S+) begins to lecture
action send listen to $2 observe when ^(\S+) begins to listen to (\S+)

#action send stop listen; send teach sorcery to izqhhrzu when eval contains("$roomplayers", "Izqhhrzu")
#action send stop listen;send stop teach; send listen to inauri observe; send 3 listen to selesthiel observe when eval !contains("$roomplayers", "Izqhhrzu")

action send unlock door; send open door when ^(?:Qizhmur's|Khurnaarti's|Izqhhrzu's) face appears in the
action goto houseDelay when ^\.\.\.All this activity is beginning to make you tired\.$

action put #tvar powerwalk 0 when eval $Attunement.LearningRate = 34

timer start

var useBurgle 1

put #tvar powerwalk 0

var isFullyPrepped 0
action var isFullyPrepped 1 when ^You feel fully prepared to cast your spell.
action var isFullyPrepped 1 when ^Your concentration slips for a moment, and your spell is lost.$
action var isFullyPrepped 0 when ^You trace an angular sigil in the air

action var numBolts $1 when ^You count some basilisk bolts in the.*and see there are (\S+) left\.$

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

put .afk

gosub stow right
gosub stow left
#gosub release rog
gosub release usol
gosub release symbiosis
gosub retrieveBolts
gosub stow hhr'ata
gosub stow frying pan


#matchre startRepair ^You tap a
#matchre main ^I could not find
#gosub tap my ticket
#matchwait

#startRepair:
#    gosub moveToMagic
#    gosub waitForRepair

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

gosub burgle.setNextBurgleAt

main:
    if (%useBurgle = 1 && $lib.timers.nextBurgleAt < $gametime) then gosub burgle.setNextBurgleAt

    if (%useBurgle = 1 &&  $lib.timers.nextBurgleAt < $gametime) then {
        put exp 0 all
        put #echo >Log #cc99ff Going to burgle

        gosub moveToBurgle
        gosub runScript tend
        gosub release spell


        gosub runScript armor remove

        gosub cast

        put .burgle
        waitforre ^BURGLE DONE$

        put .armor wear
        waitforre ^ARMOR DONE$

        #gosub automove crossing
        if ($SpellTimer.RiteofGrace.active != 1) then {
            gosub prep rog 20
            gosub waitForPrep
            gosub cast
        }
        #gosub automove leth
        #gosub automove portal

        put #tvar powerwalk 0
        if ($Attunement.LearningRate < 34) then put #tvar powerwalk 1
        gosub automove n gate
        gosub automove portal

        gosub release eotb
        gosub move go meeting portal

        gosub runScript tend

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

        #gosub runScript repair
        #gosub waitForRepair

        gosub automove 50
        put #tvar powerwalk 0
        pause 1
        put .qizhmur
        put .reconnect
        put .afk
    }

    startFight:        
    #if ($Parry_Ability.LearningRate < 29 || $Shield_Usage.LearningRate < 29 || $Evasion.LearningRate < 25 || $Heavy_Thrown.LearningRate < 29 || $Targeted_Magic.LearningRate < 29 || $Staves.LearningRate < 29 || $Brawling.LearningRate < 29 || $Crossbow.LearningRate < 29 || $Small_Edged.LearningRate < 29) then {
    if ($Parry_Ability.LearningRate < 29 || $Shield_Usage.LearningRate < 29 || $Evasion.LearningRate < 0 || $Targeted_Magic.LearningRate < 29 || $Brawling.LearningRate < 29 || $Small_Edged.LearningRate < 29 || $Heavy_Thrown.LearningRate < 29 || $Light_Thrown.LearningRate < 29 || $Crossbow.LearningRate < 29 || $Staves.LearningRate < 29 || $Twohanded_Blunt.LearningRate < 29) then {
		echo GONNA GO FIGHT
		echo $Parry_Ability.LearningRate < 29 || $Shield_Usage.LearningRate < 29 || $Evasion.LearningRate < 0 || $Heavy_Thrown.LearningRate < 29 || $Targeted_Magic.LearningRate < 29 || $Staves.LearningRate < 29 || $Brawling.LearningRate < 29 || $Crossbow.LearningRate < 29 || $Small_Edged.LearningRate < 29
        gosub waitForRepair
        put #echo >Log #cc99ff Going to main combat
        #gosub moveToBulls
        gosub moveToShardBulls
        gosub runScript tend
        put .fight
        gosub waitForMainCombat
        goto main
    }

    startMagic:
    #if ($Attunement.LearningRate < 5 || $Arcana.LearningRate < 20 || $Utility.LearningRate < 25 || $Warding.LearningRate < 25 || $Augmentation.LearningRate < 25 || $Sorcery.LearningRate < 3) then {
    #if (%startResearch = 1) then {
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
		        gosub listen to inauri observe
		        gosub teach tm to inauri
		    }
		}
echo tending
		gosub runScript tend

        if ($Sorcery.LearningRate < 2 || %startResearch = 1) then {
            put #echo >Log #cc99ff Starting research
            var startResearch 0
            gosub release cyclic

            gosub release devour
            gosub sorceryDevour
            gosub moveToHouse

	        if ("$roomname" != "Private Home Interior") then {
	            put #echo >Log #cc99ff House won't open, going to FC
	            gosub moveToMagic
	        }

            gosub release cyclic

            var startResearch 0
            gosub stow right
            gosub stow left
            if ($Sorcery.LearningRate < 10 ) then gosub runScript research sorcery
            if ($standing != 1) then gosub stand
            gosub release cyclic
            #if ($bleeding = 1) then gosub runScript devour all
            gosub healWithRats
        }
        put .reconnect
        put .afk
        put .magic
        gosub waitForMagic
        goto main
    #}

    goto main



sorceryCont:
    put #script abort all except qizhmur
    put .reconnect
    put .afk
    pause 1
    put #script abort all except qizhmur
    put .reconnect
    put .afk
    goto magicCont



getHealedTrigger:
    put #script abort all except qizhmur
    put .afk
    put .reconnect
    action (health) off
    put #echo >Log #FF5501 [qizhmur.cmd] GETTING HEALED
    put #echo >Log #FF5501 [$roomname]
    put #echo >Log #FF5501 (health=$health bleeding=$bleeding)
    if ($health < 50) then {
        goto logout
    }

    gosub retreat
    gosub stance shield
    gosub stow right
    gosub stow left
    gosub release cyclic
    gosub stow hhr'ata
    gosub stow bola
    gosub runScript loot

    if ("$zoneid" = "69") then gosub automove 15

    gosub getHealed

    gosub moveToMagic

    action (health) on

    put #script abort all except qizhmur
    put .reconnect
    put .afk
    pause .2
    put .qizhmur


getHealed:
    gosub checkHealth
    if (%injured = 1) then {
        gosub moveToMagic
        if ("$roomname" = "Private Home Interior") then gosub runScript house
        gosub runScript findSpot fcrat
        gosub runScript devourfcrat
        gosub getHealedCont
    }
    return

getHealedCont:
	put #var lastHealedGametime $gametime
	gosub moveToMagic
	if ($bleeding = 1) then goto getHealed




checkHealth:
    var injured 1
    matchre checkHealthInjured ^You have.*(skin|head|neck|chest|abdomen|back|tail|hand|arm|leg|eye|twitching|paralysis)
    matchre checkHealthNotInjured ^You have no significant injuries.
    put health
    matchwait 5
    return


checkHealthInjured:
    var injured 1
    return


checkHealthNotInjured:
    var injured 0
    return


healWithRats:
    gosub checkHealth
    if ($injured = 1 || $bleeding = 1) then {
        if ("$roomname" = "Private Home Interior") then gosub runScript house
        if ($zoneid != 150) then {
            gosub moveToMagic
            goto healWithRats
        }
        gosub runScript findSpot fcrat
        #if ($SpellTimer.Devour.active = 0) then gosub runScript devourfcrat
        gosub runScript devourfcrat
        pause 10
        goto healWithRats
    }
    pause .01
    return


sorceryDevour:
    if ($SpellTimer.Devour.duration > 20) then return
    echo GOING TO DEVOUR FCRAT
    if ("$roomname" = "Private Home Interior") then gosub runScript house

    gosub runScript findSpot fcrat
    gosub runScript devourfcrat
    goto sorceryDevour



castSpellsForMove:
    #gosub release symbiosis

    if ("$preparedspell" != "None") then gosub release spell
    #if ($SpellTimer.RiteofGrace.active = 1) then gosub release rog
    if ($SpellTimer.UniversalSolvent.active = 1) then gosub release usol
    if ($SpellTimer.RiteofGrace.active != 1) then {
        gosub prep rog 20
        gosub waitForPrep
        gosub release cyclic
        gosub cast
    }

    if ($SpellTimer.EyesoftheBlind.active = 0 || $SpellTimer.EyesoftheBlind.duration < 3) then {
        gosub prep eotb
        pause 3
        gosub cast
    }
    return


houseDelay:
	put #echo >log #99FF01 TOO MUCH HOUSE, DELAYING
	gosub release cyclic
	gosub runScript cast rog
	gosub prep eotb
	pause 3
	gosub cast
	pause 60
	gosub perc
	pause 60
    gosub perc
    pause 60
    gosub perc
	pause 60
	gosub perc
	put .qizhmur


moveToAdanf:
    gosub setZone

    # Ice Caves
    if ("%zone" = "68a") then {
        put .findSpot adanf
        waitforre ^FINDSPOT DONE$
        return
    }

    gosub castSpellsForMove

    if ("$roomname" = "Private Home Interior") then {
        gosub runScript house
        goto moveToAdanf
    }

    # Shard South Gate Area
    if ("%zone" = "68") then {
        gosub automove 214
        goto moveToAdanf
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

    # Shard West Gate Area
    if ("%zone" = "69") then {
        if ("$roomid" = "204") then return
        gosub automove 204
        goto moveToBurgle
    }

    # Crossing W Gate
    if ("%zone" = "4") then {
        put #tvar powerwalk 0
        if ("$roomid" = "450") then return
        if ($Attunement.LearningRate < 30) then put #tvar powerwalk 1
        gosub automove 450
        goto moveToBurgle
    }

    gosub castSpellsForMove

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



    # Crossing
    if ("%zone" = "1") then {
        gosub automove w gate
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
        put #tvar powerwalk 0
        if ($Attunement.LearningRate < 30) then put #tvar powerwalk 1
        gosub automove portal
        put #tvar powerwalk 0
        gosub move go exit portal
        goto moveToBurgle
    }

    # Storm Bulls (Ilaya)
    if ("%zone" = "112") then {
        if ("$roomid" = "39") then return
        gosub automove 39
        goto moveToBurgle
    }

    # Leth
    if ("%zone" = "61") then {
        gosub automove 126
        goto moveToBurgle
    }

    goto moveToBurgle



moveToBulls:
    gosub setZone

    # Storm Bulls (Ilaya)
    if ("%zone" = "112") then {
        gosub runScript findSpot bull
        return
    }

    gosub castSpellsForMove

    if ("$roomname" = "Private Home Interior") then {
        gosub runScript house
        goto moveToBulls
    }

    # Leth
    if ("%zone" = "61") then {
        gosub automove 126
        goto moveToBulls
    }

    # FC
    if ("%zone" = "150") then {
        if ($Attunement.LearningRate < 25) then put #tvar powerwalk 1
        gosub automove portal
        put #tvar powerwalk 0
        gosub move go exit portal
        goto moveToBulls
    }

    goto moveToBulls


moveToShardBulls:
	gosub setZone

    if ("$roomname" = "Private Home Interior") then {
        gosub runScript house
        goto moveToShardBulls
    }

    # Shard West Gate Area
    if ("$zoneid" = "69") then {
        if ($roomid >= 597 && $roomid <= 695 && "$roomplayers" = "" && !contains("$roomobjs", "dirt construct")) then return
        gosub runScript findSpot shardbull
        return
    }

    # Shard East Gate Area
    if ("$zoneid" = "66") then {
        gosub automove w gate
        goto moveToShardBulls
    }

    # Shard
    if ("$zoneid" = "67") then {
        gosub automove 132
        goto moveToShardBulls
    }

    # FC
    if ("%zone" = "150") then {
        if ($Attunement.LearningRate < 25) then put #tvar powerwalk 1
        gosub automove portal
        put #tvar powerwalk 0
        gosub move go exit portal
        goto moveToShardBulls
    }

    goto moveToShardBulls


moveToHouse:
    gosub setZone

    if ("$roomname" = "Private Home Interior") then return

    # FC
    if ("%zone" = "150") then {
        if ("$roomname" = "Private Home Interior") then return
        if ("$roomid" = "50") then {
            gosub enterHouse
        } else {
            if ($Attunement.LearningRate < 30) then put #tvar powerwalk 1
            gosub automove 50
            put #tvar powerwalk 0
            goto moveToHouse
        }
        return
        #goto moveToHouse
    }

    gosub castSpellsForMove

    # Storm Bulls
    if ("%zone" = "112") then {
        gosub automove leth
        goto moveToHouse
    }

    # Leth
    if ("%zone" = "61") then {
        gosub automove portal
        gosub release eotb
        gosub move go meeting portal
        goto moveToHouse
    }

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
        gosub automove portal
        if ($SpellTimer.EyesoftheBlind.active = 1) then gosub release eotb
        gosub move go meeting portal
        if ($SpellTimer.EyesoftheBlind.active = 1) then gosub release eotb

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



    goto moveToHouse


enterHouse:
    gosub release eotb
    matchre enterHouseCont suddenly rattles
    matchre enterHouseCont suddenly opens
    put peer bothy
    matchwait 20
    gosub open bothy
    gosub move go bothy
    return

enterHouseCont:
    gosub open bothy
    gosub move go bothy
    gosub close door
    #gosub lock door
    return


moveToMagic:
    gosub setZone

    if ("$roomname" = "Private Home Interior") then return

    gosub castSpellsForMove

    # FC
    if ("$zoneid" = "150") then {
        put #tvar powerwalk 0
        if ($roomid = 50) then {
            gosub enterHouse
            #goto moveToMagic
            return
        }
        if ($Attunement.LearningRate < 30) then put #tvar powerwalk 1
        gosub automove 50
        goto moveToMagic
    }

    # Shard East Gate Area
    if ("$zoneid" = "66") then {
        gosub automove portal
        gosub release rf
        gosub move go meeting portal
        goto moveToMagic
    }

    # Shard
    if ("$zoneid" = "67") then {
        gosub automove 132
        goto moveToMagic
    }

    # Shard West Gate Area
    if ("$zoneid" = "69") then {
        gosub automove n gate
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
        gosub runScript findSpot warklin
        return
    }

    gosub castSpellsForMove

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
        gosub automove n gate
        pause 2
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

	if ("$roomname" = "Private Home Interior") then return

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
    put #script abort all except qizhmur
    put .reconnect
    put .afk
    pause 1
    put #script abort all except qizhmur
    put .reconnect
    put .afk
    gosub burgle.setNextBurgleAt
    put .magic
    pause 1

waitForMagicLoop:
    if ($lib.timers.nextBurgleAt < $gametime || ($Warding.LearningRate > 31 && $Augmentation.LearningRate > 31 && $Utility.LearningRate > 31 && $Arcana.LearningRate > 31)) then {
        put #script abort all except qizhmur
        put .reconnect
        put .afk
        pause 1
        put #script abort all except qizhmur
        put .reconnect
        put .afk
        gosub stow right
        gosub stow left
        gosub release eotb
        gosub retrieveBolts
        gosub stow hhr'ata
        gosub stow frying pan
        return
    }
    pause 2
    goto waitForMagicLoop


waitForMainCombat:
    pause 2
    put #script abort all except qizhmur
    put .reconnect
    put .afk
    pause 1
    put #script abort all except qizhmur
    put .reconnect
    put .afk
    gosub burgle.setNextBurgleAt
    put .fight
    pause 1

waitForMainCombatLoop:
    #if ($lib.timers.nextBurgleAt < $gametime || ($Thanatology.LearningRate > 3 && $Evasion.LearningRate > 0 && $Shield_Usage.LearningRate > 32 && $Parry_Ability.LearningRate > 30 && $Heavy_Thrown.LearningRate > 30 && $Targeted_Magic.LearningRate > 30 && $Staves.LearningRate > 30 && $Small_Edged.LearningRate > 30 && $Brawling.LearningRate > 31 && $Twohanded_Blunt.LearningRate > 30 && $Light_Thrown.LearningRate > 30)) then {
    #var skills $char.fight.weapons.skills|Parry_Ability|Shield_Usage|Evasion
	 if ($lib.timers.nextBurgleAt < $gametime || ($Parry_Ability.LearningRate > 30 && $Shield_Usage.LearningRate > 30 && $Evasion.LearningRate > -1 && $Targeted_Magic.LearningRate > 30 && $Brawling.LearningRate > 30 && $Small_Edged.LearningRate > 30 && $Heavy_Thrown.LearningRate > 30 && $Light_Thrown.LearningRate > 30 && $Crossbow.LearningRate > 30 && $Staves.LearningRate > 30 && $Twohanded_Blunt.LearningRate > 30)) then {
        put #script abort all except qizhmur
        put .reconnect
        put .afk
        pause 1
        put #script abort all except qizhmur
        put .reconnect
        put .afk
        if ("$righthandnoun" = "lockbow") then gosub unload my lockbow
        gosub stow right
        gosub stow left
        gosub retrieveBolts
        gosub stow hhr'ata
        gosub stow frying pan
        return
    }
    pause 2
    goto waitForMainCombatLoop


#checkLearningRates:
#	var checkLearningRatesResult 0
#	var index 0
#	checkLearningRates.loop:


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
    



waitForRepair:
    matchre waitForRepairLoop won't be ready for another (\d+) roisaen.
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
