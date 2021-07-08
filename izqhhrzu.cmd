include libmaster.cmd

#put .var_izqhhrzu
#waitforre ^CHARVARS DONE

var expectedNumBolts one hundred thirty-nine

action goto logout when eval $health < 50
action goto logout when eval $dead = 1

action (health) goto getHealedTrigger when eval $health < 85
action (health) goto getHealedTrigger when eval $bleeding = 1

action send $lastcommand when ^You can't move in that direction while unseen.

action send listen to $1 when ^(\S+) begins to lecture
action send listen to $2 when ^(\S+) begins to listen to (\S+)

action var numBolts $1 when ^You count some.*bolts in the.*and see there are (.*) left\.$

action put #tvar powerwalk 0 when eval $Attunement.LearningRate = 34


timer start

var useBurgle 1

put #tvar powerwalk 0

put .reconnect
put .afk

gosub stow right
gosub stow left
gosub release symbiosis
gosub retrieveBolts
gosub stow hhr'ata
gosub stow bola
gosub stow right
gosub stow left

if ($health < 80 && "$roomname" != "Private Home Interior") then goto getHealedTrigger

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
        put #echo >Log #cc99ff Train: Going to burgle

        gosub moveToBurgle
        gosub release spell


        gosub runScript armor remove

        gosub cast

        put .burgle
        waitforre ^BURGLE DONE$

        put .armor wear
        waitforre ^ARMOR DONE$

        #gosub automove n gate
        gosub automove crossing
        gosub automove portal        
        gosub move go meeting portal

        gosub automove bundle
        gosub remove my bundle
        gosub sell my bundle
        gosub stow right
        gosub stow left
        gosub get bundle from my backpack
        gosub sell my bundle
        gosub stow right
        gosub stow left
        gosub get bundle from my backpack
        gosub sell my bundle
        gosub stow right
        gosub stow left
        gosub stow right
        gosub stow left

        put .dep
        waitforre ^DEP DONE$

        #gosub moveToHouse
        #gosub runScript devotion
        pause 1
        put .izqhhrzu
        put .reconnect
        put .afk
    }

    if ($Theurgy.LearningRate < 10 && ($SpellTimer.PersistenceofMana.active != 1 || $SpellTimer.PersistenceofMana.duration < 4)) then {
        put #echo >Log #cc99ff Moving to house for rituals
        gosub moveToHouse
        gosub runScript countClericTools

        if ($char.inventory.numIncense < 10) then {
            put #echo >Log #cc99ff Buying incense
            if ("$roomname" = "Private Home Interior") then gosub runScript house
            gosub runScript travel crossing
            gosub automove teller
            gosub withdraw 1 silver
            gosub automove brother
            #gosub automove teller
            #gosub withdraw 1 silver
            #gosub runScript travel shard
            #gosub automove cleric
            put order incense
            pause
            #put offer 45
            put offer 62
            pause
            gosub put my incense in my $char.storage.incense
        }

        if ($char.inventory.numHolyWater < 1) then {
            put #echo >Log #cc99ff Buying holy water
            if ("$roomname" = "Private Home Interior") then gosub runScript house
            gosub runScript travel crossing
            gosub automove temple
            gosub automove holy water
            gosub get my witch jar
            put fill my witch jar with water from basin
            gosub stow my witch jar
            gosub automove crossing

            #gosub automove teller
            #gosub withdraw 1 silver
            #gosub automove chiz
            #gosub runScript travel shard
            #gosub automove teller
            #gosub withdraw 1 silver
            #gosub automove alchemy supplies
            #put order 1
            #pause
            #put order 1
            #gosub prep bless
            #pause 5
            #gosub cast my water
            #gosub get my water from my $char.storage.holyWater
            #put combine water
            #gosub put my water in my $char.storage.holyWater
            #gosub runScript dep
        }
        put #echo >Log #cc99ff Moving to cast PoM
		gosub moveToHouse
        gosub runScript cast pom
        gosub stand
        gosub runScript devotion
        gosub stand
    }

    startFight:
    if ($Targeted_Magic.LearningRate < 25 || $Brawling.LearningRate < 25 || $Polearms.LearningRate < 25 || $Large_Edged.LearningRate < 25 || $Crossbow.LearningRate < 25 || $Heavy_Thrown.LearningRate < 25 || $Light_Thrown.LearningRate < 25 || $Staves.LearningRate < 25 || $Slings.LearningRate < 25 || $Evasion.LearningRate < 25 || $Shield_Usage.LearningRate < 25 || $Parry_Ability.LearningRate < 25) then {
        #gosub getHealed
        #gosub waitForRepair
        put #echo >Log #cc99ff Going to main combat
        gosub moveToGargoyles
        put .fight
        gosub waitForMainCombat
        goto main
    }



    startMagic:
    #if ($Attunement.LearningRate < 5 || $Arcana.LearningRate < 25 || $Utility.LearningRate < 25 || $Warding.LearningRate < 25 || $Augmentation.LearningRate < 25) then {
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
		} else {
		    if (contains("$roomplayers", "Inauri")) then {
		        gosub whisper inauri teach sorcery
		    }
		}

	    gosub listen to Selesthiel
	    gosub listen to Inauri observe
	    gosub whisper inauri teach sorcery

        if (1 = 0 && ($Sorcery.LearningRate < 2 || %startResearch = 1)) then {
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
    put #script abort all except izqhhrzu
    put .reconnect
    put .afk
    pause 1
    put #script abort all except izqhhrzu
    put .reconnect
    put .afk
    goto magicCont


getHealedTrigger:
    put #script abort all except izqhhrzu
    put .afk
    put .reconnect
    action (health) off
    put #echo >Log #FF5501 GETTING HEALED
    put #echo >Log #FF5501 [$roomname]
    put #echo >Log #FF5501 (health=$health bleeding=$bleeding)
    if ($health < 50) then {
        goto logout
    }

    gosub retreat
    #gosub resetState
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

    put #script abort all except izqhhrzu
    put .reconnect
    put .afk
    pause .2
    put .izqhhrzu


getHealed:
    gosub checkHealth
    if (%injured = 1) then {
        put #echo >Log Moving to get healed (moveToHouse)
        gosub moveToHouse

        if (contains("$roomplayers", "Inauri")) then {
	        gosub whisper inauri heal
	        pause 30
        }

        if (!($lastHealedGametime > -1)) then put #var lastHealedGametime 0
        eval nextHealTime (300 + $lastHealedGametime)

        if ($bleeding = 1) then {
            gosub runScript house

            gosub automove heal
            put join list
            matchre getHealedCont Yrisa crosses Izqhhrzu's name from the list.
            matchwait 120

            gosub getHealedCont

        }
    }
    return

getHealedCont:
	put #var lastHealedGametime $gametime
	#gosub automove portal
	#gosub move go exit portal
	gosub moveToHouse
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
        gosub prep rog 15
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



moveToGargoyles:
    put #echo >Debug #cc99ff moveToGargoyles (zoneid=$zoneid roomid=$roomid)
    gosub setZone

    if ("$roomname" = "Private Home Interior") then {
        gosub runScript house
        goto moveToGargoyles
    }

    # FC
    if ("%zone" = "150") then {
        gosub runScript findSpot gargoyle
        return
    }

    # Shard S Gate
    if ("%zone" = "68") then {
        gosub automove e gate
        goto moveToGargoyles
    }

    # Abandoned Mine
    if ("%zone" = "10") then {
        gosub automove ntr
        goto moveToGargoyles
    }

    # NTR
    if ("%zone" = "7") then {
        gosub automove n gate
        goto moveToGargoyles
    }

    # Vineyard
    if ("%zone" = "7a") then {
        gosub automove ntr
        goto moveToGargoyles
    }

    # Crossing Temple
    if ("%zone" = "2a") then {
        gosub automove crossing
        goto moveToGargoyles
    }

    # Crossing N Gate
    if ("%zone" = "6") then {
        gosub automove crossing
        goto moveToGargoyles
    }

    # Crossing W Gate
    if ("%zone" = "4") then {
        gosub automove crossing
        goto moveToGargoyles
    }

    # Crossing
    if ("%zone" = "1") then {
        gosub automove portal      
        gosub move go meeting portal     
        goto moveToGargoyles
    }

    # Shard East Gate Area
    if ("%zone" = "66") then {
        gosub automove portal
        gosub move go portal
        goto moveToGargoyles
    }

    # Shard
    if ("%zone" = "67") then {
        gosub automove 132
        goto moveToGargoyles
    }

    # Shard West Gate Area
    if ("%zone" = "69") then {
        gosub automove n gate
        goto moveToGargoyles
    }

    goto moveToGargoyles



moveToGerbils:
    put #echo Yellow Moving to gerbils
    gosub setZone

    if ("$roomname" = "Private Home Interior") then {
        gosub runScript house
        goto moveToGerbils
    }

    # Vineyard
    if ("%zone" = "7a") then {
        gosub runScript findSpot gerbil
        return
    }

    # FC
    if ("%zone" = "150") then {
        put #tvar powerwalk 0
        if ($Attunement.LearningRate < 25) then put #tvar powerwalk 1
        gosub automove portal
        put #tvar powerwalk 0
        if (contains("$roomobjs", "portal")) then gosub move go portal
        goto moveToGerbils
    }

    # Crossing Temple
    if ("%zone" = "2a") then {
        gosub automove crossing
        goto moveToGerbils
    }

    # NTR
    if ("%zone" = "7") then {
        gosub automove vineyard
        goto moveToGerbils
    }

    # Crossing N Gate
    if ("%zone" = "6") then {
        gosub automove ntr
        goto moveToGerbils
    }

    # Crossing W Gate
    if ("%zone" = "4") then {
        gosub automove n gate
        goto moveToGerbils
    }

    # Crossing
    if ("%zone" = "1") then {
        gosub automove n gate
        goto moveToGerbils
    }

    goto moveToGerbils
    


moveToBurgle:
    gosub setZone

    # Crossing W Gate
    if ("%zone" = "4") then {
        put #tvar powerwalk 0
        if ("$roomid" = "450") then return
        if ($Attunement.LearningRate < 30) then put #tvar powerwalk 1
        gosub automove 450
        put #tvar powerwalk 0
        goto moveToBurgle
    }

    if ("$roomname" = "Private Home Interior") then {
        gosub runScript house
        goto moveToBurgle
    }

    # Crossing Temple
    if ("%zone" = "2a") then {
        gosub automove crossing
        goto moveToBurgle
    }

    # NTR
    if ("%zone" = "7") then {
        gosub automove n gate
        goto moveToBurgle
    }

    # Vineyard
    if ("%zone" = "7a") then {
        gosub automove ntr
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

    # FC
    if ("%zone" = "150") then {
        if ($Attunement.LearningRate < 20) then put #tvar powerwalk 1
        gosub automove portal
        put #tvar powerwalk 0
        gosub move go exit portal
        goto moveToBurgle
    }

    # Abandoned Mine
    if ("%zone" = "10") then {
        gosub automove ntr
        goto moveToBurgle
    }

    # Shard West Gate Area
    if ("$zoneid" = "69") then {
        if ("$roomid" = "204") then return
        gosub automove 204
        goto moveToBurgle
    }

    # Shard East Gate Area
    if ("$zoneid" = "66") then {
        gosub automove 217
        goto moveToBurgle
    }

    # Shard
    if ("$zoneid" = "67") then {
        gosub automove 132
        goto moveToBurgle
    }

    goto moveToBurgle




moveToHouse:
    put #echo >Debug #cc99ff moveToHouse (zoneid=$zoneid roomid=$roomid)
    gosub setZone

    if ("$roomname" = "Private Home Interior") then return

    # FC
    if ("%zone" = "150") then {
        if ("$roomname" = "Private Home Interior") then return
        if ("$roomid" = "50") then {
            gosub enterHouse
        } else {
            gosub automove 50
            goto moveToHouse
        }
        return
        #goto moveToHouse
    }

    if (matchre("$roomobjs", "portal")) then {
        #gosub move go portal
        #goto moveToHouse
    } else {
        #gosub runScript travel crossing portal
        #goto moveToHouse
    }

    # Storm Bulls
    if ("%zone" = "112") then {
        gosub automove leth
        goto moveToHouse
    }

    # Leth
    if ("%zone" = "61") then {
        gosub automove portal
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
        gosub automove n gate
        goto moveToHouse
    }

    # Vineyard
    if ("%zone" = "7a") then {
        gosub automove ntr
        goto moveToHouse
    }

    # Crossing Temple
    if ("%zone" = "2a") then {
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
        gosub move go meeting portal     
        goto moveToHouse
    }

    # Shard East Gate Area
    if ("%zone" = "66") then {
        gosub automove portal
        gosub move go portal
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
    matchre enterHouseCont suddenly rattles
    matchre enterHouseCont suddenly opens
    gosub peer bothy
    matchwait 20
    gosub open bothy
    gosub move go bothy
    return



enterHouseCont:
    gosub open bothy
    gosub move go bothy
    gosub close door
    gosub lock door
    return


moveToMagic:
    gosub setZone

    if ("$roomname" = "Private Home Interior") then return

    # FC
    if ("%zone" = "150") then {
        put #tvar powerwalk 0
        if ("$roomid" = "50") then return
        gosub automove 50
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

    # Vineyard
    if ("%zone" = "7a") then {
        gosub automove ntr
        goto moveToMagic
    }

    # Crossing Temple
    if ("%zone" = "2a") then {
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
        gosub move go meeting portal      
        goto moveToMagic
    }

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

    # Storm Bulls
    if ("%zone" = "112") then {
        gosub automove leth
        goto moveToMagic
    }

    # Leth
    if ("%zone" = "61") then {
        gosub automove portal
        gosub move go meeting portal
        goto moveToMagic
    }

    goto moveToMagic



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
    put #script abort all except izqhhrzu
    put .reconnect
    put .afk
    pause 1
    put #script abort all except izqhhrzu
    put .reconnect
    put .afk
    gosub burgle.setNextBurgleAt
    put .magic
    pause 1

waitForMagicLoop:
    if ($lib.timers.nextBurgleAt < $gametime || ($Theurgy.LearningRate < 10 && ($SpellTimer.PersistenceofMana.active != 1 || $SpellTimer.PersistenceofMana.duration < 4)) || ($Warding.LearningRate > 31 && $Augmentation.LearningRate > 31 && $Utility.LearningRate > 31 && $Arcana.LearningRate > 31)) then {
        put #script abort all except izqhhrzu
        put .reconnect
        put .afk
        pause 1
        put #script abort all except izqhhrzu
        put .reconnect
        put .afk
        gosub stow right
        gosub stow left
        gosub retrieveBolts
        gosub stow hhr'ata
        gosub stow bola
        gosub stow right
        gosub stow left
        return
    }
    pause 2
    goto waitForMagicLoop


waitForMainCombat:
    pause 2
    put #script abort all except izqhhrzu
    put .reconnect
    put .afk
    pause 1
    put #script abort all except izqhhrzu
    put .reconnect
    put .afk
    gosub burgle.setNextBurgleAt
    put .fight
    pause 1

waitForMainCombatLoop:
    if ($lib.timers.nextBurgleAt < $gametime || ($Targeted_Magic.LearningRate > 25 && $Polearms.LearningRate > 30 && $Brawling.LearningRate > 30 && $Large_Edged.LearningRate > 30 && $Crossbow.LearningRate > 30 && $Heavy_Thrown.LearningRate > 30 && $Light_Thrown.LearningRate > 30 && $Staves.LearningRate > 30 && $Slings.LearningRate > 30 && $Twohanded_Edged.LearningRate > 30 && $Evasion.LearningRate > 30 && $Shield_Usage.LearningRate > 30 && $Parry_Ability.LearningRate > 30)) then {
        put #script abort all except izqhhrzu
        put .reconnect
        put .afk
        pause 1
        put #script abort all except izqhhrzu
        put .reconnect
        put .afk
        if ("$righthandnoun" = "lockbow") then gosub unload my lockbow
        gosub stow right
        gosub stow left
        gosub retrieveBolts
        gosub stow hhr'ata
        gosub stow bola
        gosub stow right
        gosub stow left
        return
    }
    pause 2
    goto waitForMainCombatLoop



retrieveBolts:
    var retrieveAttempts 0
retrieveBoltsLoop:
    return

    gosub count my bolts
    if ("%numBolts" = "%expectedNumBolts") then {
        gosub stow right
        return
    } else {
        echo WRONG NUMBER OF BOLTS, found %numBolts expected %expectedNumBolts
    }
    if ("$righthandnoun" != "sword") then {
        gosub stow right
        gosub get my sword
    }
    gosub attack kick
    gosub loot treasure
    put .loot
    waitforre ^LOOT DONE$
    math retrieveAttempts add 1
    if (%retrieveAttempts < 1 && $monstercount > 0) then goto retrieveBoltsLoop
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
    put .izqhhrzu

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
    put #script abort all except izqhhrzu
put .reconnect
    pause 1
    put #script abort all except izqhhrzu
put .reconnect
    put exit
    exit
