include libmaster.cmd

put .afk

var expectedNumBolts twelve

#action goto logout when eval $health < 50
action goto logout when eval $dead = 1
action goto logout when ^You are a ghost

action (health) goto getHealedTrigger when eval $health < 85
action (health) goto getHealedTrigger when eval $bleeding = 1
action (health) goto getHealedTrigger when ^TESTHEAL

action send unlock door; send open door when ^(?:Qizhmur's|Khurnaarti's|Izqhhrzu's) face appears in the

action send stop teach when ^Inauri stops listening to you.

action send listen to $1 when ^(\S+) begins to lecture

action send release rf;send go meeting portal when ^But no one can see you
action send release rf;send rummage my shadows when ^You feel about some dark encompassing shadows of twilight dreamweave\.$

action (duskruinCheck) if (contains("$roomname", "Duskruin") || contains("$roomobjs", "a palisade gate")) then goto escapeDuskruin when eval $roomname

action (taisidonCheck) if (contains("$roomname", "A'baya") || contains("$roomobjs", "shimmering ocean-blue moongate")) then goto escapeTaisidon when eval $roomname

action (checkTeach) var isInClass 1 when You are in this class

action put exp mods when ^Your spell.*backfire.*

action send release rf when ^You can't move in that direction while unseen\.$

action goto selesthiel.arrested when ^"Stop right there!"

if_1 then {
    if ("%1" = "fight") then var startAt fight
    if ("%1" = "magic") then var startAt magic
}


# debug 10


action send pat inauri when ^A soft crackle briefly comes from Inauri's direction.

var injured 0

action var numBolts $1 when ^You count some basilisk bolts in the \S+ and see there are (\S+) left\.$
action var numArrows $1 when ^You count some basilisk arrows in the \S+ and see there are (\S+) left\.$
action send stand when ^You'll have to move off the sandpit first.

action put whisper inauri teach $1 when ^Inauri stops trying to teach (.*) to you.$


action var playerName $1; var buffSpell $2; goto buffPlayer when ^(Inauri|Qizhmur|Khurnaarti) whispers, "(?:C|c)ast (\S+)"

put #var char.instrument.song concerto

timer start

gosub burgle recall

gosub look in my portal

gosub awake

if ($standing != 1) then gosub stand

if (contains("$roomname", "A'baya")) then goto escapeTaisidon

if ($health < 80 && "$roomname" != "Private Home Interior") then goto getHealedTrigger

if ("%startAt" = "fight") then goto startFight
if ("%startAt" = "backtrain") then goto startBacktrain
if ("%startAt" = "magic") then {
	echo starting at magic
	goto startMagic
}



main:
    gosub abortScripts
    gosub resetState

    gosub burgle recall
    pause 1
    pause 1
    gosub awake

    echo $lib.timers.nextBurgleAt < $gametime

    if ($lib.timers.nextBurgleAt < $gametime) then {
        put #echo >Log #838700 Train: Going to burgle
		put exp 0 all

        gosub moveToBurgle

        if ($SpellTimer.InvocationoftheSpheres.active != 1) then {
            gosub release rf
            gosub runScript iots ref
        }

        gosub prep rf
        gosub runScript armorremove
        gosub cast

        gosub runScript burgle
        #gosub runScript armor wear wyvern
        gosub runScript armor wear

        gosub automove n gate
        gosub automove portal
        gosub prep rf

        if ($SpellTimer.RefractiveField.active = 1) then gosub release rf
        gosub move go meeting portal

        gosub cast
        gosub prep rf

        gosub automove bundle

        gosub release rf

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
        gosub get bundle from my portal
        gosub sell my bundle
        gosub stow right
        gosub stow left
        gosub get bundle from my portal
        gosub sell my bundle
        gosub stow right
        gosub stow left

        gosub runScript deposit
        gosub move up
        gosub move out
        gosub cast
        gosub moveToMagic
        #gosub checkForRepairs
        gosub runScript fixInventory
        gosub checkGemPouches
    }





    # Magic
    startMagic:
    #if ($bleeding = 1 || $Warding.LearningRate < 20 || $Utility.LearningRate < 20 || $Augmentation.LearningRate < 20 || $Arcana.LearningRate < 25 || $Sorcery.LearningRate < 5) then {
    if ($bleeding = 1 || $Warding.LearningRate < 20 || $Utility.LearningRate < 0 || $Augmentation.LearningRate < 0 || %startMagic = 1) then {
        var startMagic 0
        put #echo >Log #838700 Moving to magic
        gosub awake
        gosub moveToMagic
        gosub getHealed

        gosub remove my flame
        gosub clean my flame
        gosub wear my flame

		#if ($Astrology.LearningRate < 28) then gosub runScript predict
		#gosub runScript observe
		#gosub runScript tarantula --skill=astrology
		#gosub runScript tarantula --skill=locksmithing

        if ($char.magic.train.revSorcery != 1) then {
            gosub runScript research sorcery
            gosub getHealed
        }


        if (1 = 0 && $First_Aid.LearningRate < 10 && $lib.timers.nextBurgleAt > $gametime) then {
            put #echo >Log #00ffff First Aid start - First Aid: $First_Aid.LearningRate/34
            gosub release cyclic
            gosub runScript cast rev
            gosub runScript caracal
            if ($First_Aid.LearningRate < 10 && $lib.timers.nextBurgleAt > $gametime) then {
                #gosub waitForTextbook
                #gosub runScript textbook
            }
            put #echo >Log #00ffff First Aid end - First Aid: $First_Aid.LearningRate/34
        }


        put #echo >Log #00ffff Magic start - Warding: $Warding.LearningRate/34
        put .magic
        gosub waitForMagic
        gosub awake
        put #echo >Log #00ffff Magic End - Warding: $Warding.LearningRate/34


        if ($Performance.LearningRate < 10 && $lib.timers.nextBurgleAt > $gametime) then {
	        put #echo >Log #009999 Play start - Performance $Performance.LearningRate/34
	        gosub release cyclic
	        gosub runScript cast rev
	        gosub runScript play
	        put #echo >Log #009999 Play end   - Performance: $Performance.LearningRate/34
        }
        goto main
    }

    put #tvar char.fight.backtrain 0

    gosub getLowestLearningRateFromList $char.fight.weapons.skills|Evasion|Parry_Ability|Shield_Usage
    var lowestMainCombatSkillRate %returnVal

    gosub getLowestLearningRateFromList $char.backtrain.skills|$First_Aid
    var lowestBacktrainCombatSkillRate %returnVal

    var shouldDoBacktrain null

    # If main combats are low or less than backtrain, do main
    if (%lowestMainCombatSkillRate < 10 || %lowestMainCombatSkillRate < %lowestBacktrainCombatSkillRate) then var shouldDoBacktrain 0

    # If backtrain is low, do backtrain
    if ("%shouldDoBacktrain" = "null" && %lowestBacktrainCombatSkillRate < 10) then var shouldDoBacktrain 1

    # If main combat is not maxed, do main
    if ("%shouldDoBacktrain" = "null" && %lowestMainCombatSkillRate < 30) then var shouldDoBacktrain 0

    # if backtrain is not maxed, do backtrain
    if ("%shouldDoBacktrain" = "null" && %lowestBacktrainCombatSkillRate < 33) then var shouldDoBacktrain 1

    # Default to main combat if none of the previous apply
    if ("%shouldDoBacktrain" = "null") then var shouldDoBacktrain 0

    if ("%shouldDoBacktrain" = 1) then {
        goto startBacktrain
    } else {
        goto startFight
    }

    # Backtrain
    startBacktrain:
    if ($First_Aid.LearningRate < 10) then {
        put #echo >Log #838700 Moving to backtrain
        gosub moveToWyverns
        put #tvar char.fight.backtrain 1
        put .fight backtrain
        gosub waitForBacktrain
        put #tvar char.fight.backtrain 0
        goto main
    }

	# Main Combat
    startFight:
    if (%tmpLowestLearningRate < 25) then {
    }

	    put #echo >Log #838700 Moving to combat
	    gosub moveToAdultWyverns
	    #if ("$predictPool.$char.predict.preferred.skillset" = "complete") then gosub runScript predict
	    put #tvar char.fight.backtrain 0
	    put .fight
	    gosub waitForMainCombat
	    goto main




    #if ($Crossbow.LearningRate < 30 || $Small_Edged.LearningRate < 30 || $Targeted_Magic.LearningRate < 30 || $Brawling.LearningRate < 30 || $Light_Thrown.LearningRate < 30 || $Evasion.LearningRate < 0 || $Parry_Ability.LearningRate < 30 || $Shield_Usage.LearningRate < 30) then {


    #}

    gosub abortScripts
    gosub resetState

    goto main


sorceryCont:
    put #script abort all except selesthiel
    put .reconnect
    put .afk
    pause 1
    put #script abort all except selesthiel
    put .reconnect
    put .afk
    goto magicCont


abortScripts:
    put #script abort all except selesthiel
    put .reconnect
    put .afk
    pause 1
    put #script abort all except selesthiel
    put .reconnect
    put .afk
    pause .2
    gosub stow right
    gosub stow left
    return


checkTeaching:
	if (contains("$roomplayers", "Inauri") then {
		action (checkTeach) on
		var isInClass 0
		put assess teach
		pause 6
		if (%isInClass != 1) then {
			if (contains("$roomplayers", "Inauri") then {
		        if ($Enchanting.LearningRate < 30) then {
		            gosub whisper inauri teach enchanting
		        } else {
		            gosub stop teach
		            gosub stop listen
		            gosub teach tm to inauri
		        }
		        gosub listen to Inauri
		        pause 2
	        }
		}
		action (checkTeach) off
	}
	return


escapeTaisidon:
	action (taisidonCheck) off
    put #echo >Log #FF0000 ATTEMPTING TO ESCAPE TAISIDON
	put #script abort all except %scriptname
	if ("$roomname" = "A'baya Esplanade, Central Walkway") then {
		gosub move go moongate
		gosub move go meeting portal
		gosub move west
	} else {
	    echo LOST IN TAISIDON! EXITING
	    put #echo >Log #FF0000 LOST IN TAISIDON! EXITING
	    exit
	    put #script abort all
	    exit
	}
	put #echo >Log #00FF00 Back in Fang Cove!
	put .selesthiel

escapeDuskruin:
    action (duskruinCheck) off
    put #echo >Log #FF0000 ATTEMPTING TO ESCAPE DUSKRUIN
	put #script abort all except %scriptname
	if ("$roomname" = "Duskruin, Central Parade") then {
		gosub move go gate
		gosub move go meeting portal
		gosub move west
	} else {
		put south
		pause
		put south
        pause
		put south
        pause
		put southeast
        pause
		put southeast
        pause
		put southeast
        pause
		put southwest
        pause
		put southwest
        pause
		put southwest
        pause
		put east
		pause
		put east
		pause
		put east
		pause
		gosub move west
		if ("$roomname" != "Duskruin, Central Parade") then {
		    echo LOST IN DUSKRUIN! EXITING
		    put #echo >Log #FF0000 LOST IN DUSKRUIN! EXITING
		    put #script abort all
		    exit
		}
		goto escapeDuskruin
	}
	put #echo >Log #00FF00 Back in Fang Cove!
	put .selesthiel


getHealedTrigger:
    put #script abort all except selesthiel
    put .afk
    put .reconnect
    action (health) off
    put #echo >Log #FF5501 [selesthiel.cmd] GETTING HEALED
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

    put #script abort all except selesthiel
    put .reconnect
    put .afk
    pause .2
    put .selesthiel


getHealed:
    gosub checkHealth
    if (%injured = 1) then {
        gosub moveToMagic

        if (contains("$roomplayers", "Inauri")) then {
	        gosub whisper inauri heal
	        pause 30
        }

        if (!($lastHealedGametime > -1)) then put #var lastHealedGametime 0
        eval nextHealTime (300 + $lastHealedGametime)

        if ($bleeding = 1) then {
            gosub runScript house
            #gosub automove portal
            #if ($SpellTimer.RefractiveField.active = 1) then gosub release rf
            #gosub move go meeting portal

            gosub automove heal
            put join list
            matchre getHealedCont Yrisa crosses Selesthiel's name from the list.
            matchwait 120

            gosub getHealedCont

        }
    }
    return

getHealedCont:
	put #var lastHealedGametime $gametime
	gosub automove portal
	gosub move go exit portal
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



checkGemPouches:
    gosub runScript fixInventory
    gosub runScript count --item=gem pouch --container=steelsilk backpack --echo=1
    var numPouches $char.countResult
    put #echo >Debug We have %numPouches pouches available
    if (%numPouches < 5) then gosub getGemPouches
    return


getGemPouches:
    put #echo >Debug Fetching more gem pouches
    gosub stow right
    gosub stow left
    gosub moveToGemShop
    var npc wick
    if (matchre("$roomobjs", "gembuyer")) then var npc gembuyer
    var gemPouchIndex 0

    getGemPouches.loop:
        put ask %npc for gem pouch
        gosub stow my gem pouch
        math gemPouchIndex add 1
        if (%gemPouchIndex > 4) then {
            gosub runScript count --item=gem pouch --container=steelsilk backpack --echo=1
            var numPouches $char.countResult
            put #echo >Debug We have %numPouches pouches available
            gosub get my gem pouch
            gosub fill my gem pouch with my backpack
            gosub tie my gem pouch
            gosub fill my gem pouch with my backpack
            gosub wear my gem pouch
            gosub stow right
            gosub stow left
            return
        }
        goto getGemPouches.loop


checkForRepairs:
    if ("$roomname" = "Private Home Interior") then gosub runScript house
    if ($zoneid != 150) then {
        gosub moveToMagic
        goto checkForRepairs
    }
    if ($roomid != 50) then {
        gosub automove 50
        goto checkForRepairs
    }
    gosub runScript repair --noWait=1
    gosub stow right
    gosub stow left
    gosub get my ticket
    if ("$righthand" = "Empty") then {
        gosub runScript armorremove
        gosub runScript armor wear
        return
    }
    gosub stow my ticket
    put #echo >Log Waiting on repairs...
    gosub moveToMagic
    gosub runScript play
    put #script abort idle
    goto checkForRepairs



buffPlayer:
    put #script abort all except selesthiel
    put .reconnect
    put .afk
    gosub release spell
    gosub runScript cast %buffSpell %playerName
    put .selesthiel



moveToBurgle:
    if ("$roomname" = "Private Home Interior") then {
        gosub runScript house
        goto moveToBurgle
    }

    if ($SpellTimer.RefractiveField.duration < 2) then {
        gosub prep rf
        pause 3
        gosub cast
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

    # FC
    if ("$zoneid" = "150") then {
        gosub automove portal
        gosub move go exit portal
        goto moveToBurgle
    }

    goto moveToBurgle



moveToMagic:
    #if (contains("$roomplayers", "Inauri") then {
    #    if ($Enchanting.LearningRate < 30) then {
    #        gosub whisper inauri teach enchanting
    #    } else {
    #        gosub stop teach
    #        gosub stop listen
    #        gosub teach tm to inauri
    #    }
    #    gosub listen to Inauri
    #    pause 2
    #}

    gosub checkTeaching

    if ("$roomname" = "Private Home Interior") then {
        return
    }

    if ($SpellTimer.RefractiveField.duration < 2) then {
        gosub prep rf
        pause 3
        gosub cast
    }

    # FC
    if ("$zoneid" = "150") then {
        if ($roomid = 50) then {
            gosub runScript house
            goto moveToMagic
        }
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



moveToShardBulls:
    if ("$roomname" = "Private Home Interior") then {
        if ($SpellTimer.SeersSense.active = 0 || $SpellTimer.SeersSense.duration < 10) then gosub runScript cast seer
        if ($char.fight.useCol = 1 && ($SpellTimer.CageofLight.active = 0 || $SpellTimer.CageofLight.duration < 10)) then gosub runScript cast col
        if ($char.fight.useTksh = 1 && ($SpellTimer.TelekineticShield.active = 0 || $SpellTimer.TelekineticShield.duration < 10)) then gosub runScript cast tksh
        gosub runScript house
        goto moveToShardBulls
    }

    if ($SpellTimer.RefractiveField.duration < 2) then {
        gosub prep rf
        pause 3
        gosub cast
    }


    # Shard West Gate Area
    if ("$zoneid" = "69") then {
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
    if ("$zoneid" = "150") then {
        gosub automove portal
        gosub move go exit portal
        goto moveToShardBulls
    }

    goto moveToShardBulls



moveToAdultWyverns:
    if ("$roomname" = "Private Home Interior") then {
        if ($SpellTimer.SeersSense.active = 0 || $SpellTimer.SeersSense.duration < 10) then gosub runScript cast seer
        if ($char.fight.useCol = 1 && ($SpellTimer.CageofLight.active = 0 || $SpellTimer.CageofLight.duration < 10)) then gosub runScript cast col
        if ($char.fight.useTksh = 1 && ($SpellTimer.TelekineticShield.active = 0 || $SpellTimer.TelekineticShield.duration < 10)) then gosub runScript cast tksh
        if ($char.fight.useLgv = 1 && ($SpellTimer.LastGiveofVithwokIV.active = 0 || $SpellTimer.LastGiveofVithwokIV.duration < 10)) then gosub runScript cast lgv
        gosub runScript house
        if ($SpellTimer.InvocationoftheSpheres.active != 1 || $SpellTimer.InvocationoftheSpheres.duration < 20) then {
            gosub release iots
            gosub runScript iots ref
        }
        goto moveToAdultWyverns
    }

    if ($SpellTimer.RefractiveField.duration < 2) then {
        gosub prep rf
        pause 1
        gosub cast
    }


    # Shard West Gate Area
    if ("$zoneid" = "69") then {
        if ($roomid >= 468 && $roomid <= 479 && "$roomplayers" = "") then return
        gosub runScript findSpot adultwyvern
        goto moveToAdultWyverns
    }

    # Shard East Gate Area
    if ("$zoneid" = "66") then {
        gosub automove w gate
        goto moveToAdultWyverns
    }

    # Shard
    if ("$zoneid" = "67") then {
        gosub automove 132
        goto moveToAdultWyverns
    }

    # FC
    if ("$zoneid" = "150") then {
        gosub automove portal
        gosub move go exit portal
        goto moveToAdultWyverns
    }

    goto moveToAdultWyverns




moveToWyverns:
    if ("$roomname" = "Private Home Interior") then {
        #if ($SpellTimer.SeersSense.active = 0 || $SpellTimer.SeersSense.duration < 10) then gosub runScript cast seer
        #if ($SpellTimer.ManifestForce.active = 0 || $SpellTimer.ManifestForce.duration < 10) then gosub runScript cast maf
        #if ($SpellTimer.CageofLight.active = 0 || $SpellTimer.CageofLight.duration < 10) then gosub runScript cast col
        gosub runScript house
        goto moveToWyverns
    }

    if ($SpellTimer.RefractiveField.duration < 2) then {
        gosub prep rf
        pause 3
        gosub cast
    }


    # Shard West Gate Area
    if ("$zoneid" = "69") then {
        if ($roomid >= 480 && $roomid <= 487 && "$roomplayers" = "") then return
        if ($roomid >= 567 && $roomid <= 572 && "$roomplayers" = "") then return
        gosub runScript findSpot wyvern
        goto moveToWyverns
    }

    # Shard East Gate Area
    if ("$zoneid" = "66") then {
        gosub automove w gate
        goto moveToWyverns
    }

    # Shard
    if ("$zoneid" = "67") then {
        gosub automove 132
        goto moveToWyverns
    }

    # FC
    if ("$zoneid" = "150") then {
        gosub automove portal
        gosub move go exit portal
        goto moveToWyverns
    }

    goto moveToWyverns
    
    

moveToTelgas:
    if ("$roomname" = "Private Home Interior") then {
        if ($SpellTimer.SeersSense.active = 0 || $SpellTimer.SeersSense.duration < 10) then gosub runScript cast seer
        if ($SpellTimer.ManifestForce.active = 0 || $SpellTimer.ManifestForce.duration < 10) then gosub runScript cast maf
        #if ($SpellTimer.CageofLight.active = 0 || $SpellTimer.CageofLight.duration < 10) then gosub runScript cast col
        gosub runScript house
        goto moveToTelgas
    }

    # Shard West Gate Area
    if ("$zoneid" = "69") then {
        if ($roomid >= 515 && $roomid <= 525 && "$roomplayers" = "") then return
        gosub runScript findSpot telga
        goto moveToTelgas
    }

    if ($SpellTimer.RefractiveField.duration < 2) then {
        gosub prep rf
        pause 3
        gosub cast
    }

    # Shard East Gate Area
    if ("$zoneid" = "66") then {
        gosub automove w gate
        goto moveToTelgas
    }

    # Shard
    if ("$zoneid" = "67") then {
        gosub automove 132
        goto moveToTelgas
    }

    # FC
    if ("$zoneid" = "150") then {
        gosub automove portal
        gosub move go exit portal
        goto moveToTelgas
    }

    goto moveToTelgas




###############################
###    moveToGemShop
###############################
moveToGemShop:
	if ($SpellTimer.HydraHex.active = 1) then gosub release hyh


    if ("$roomname" = "Private Home Interior") then {
        gosub runScript house
        goto moveToGemShop
    }

    # FC
    if ("$zoneid" = "150") then {
        if ("$roomname" = "Private Home Interior") then {
            gosub runScript house
            goto moveToGemShop
        }
        if ("$roomid" = "127") then {
            if ($SpellTimer.RefractiveField.active = 1) then gosub release rf
            return
        }
        gosub automove 127
        put #tvar powerwalk 0
        goto moveToGemShop
    }

    # Shard S Gate
    if ("%zone" = "68") then {
        gosub automove e gate
        goto moveToGemShop
    }

    # Abandoned Mine
    if ("%zone" = "10") then {
        gosub automove ntr
        goto moveToGemShop
    }

    # NTR
    if ("%zone" = "7") then {
        gosub automove n gate
        goto moveToGemShop
    }

    # Vineyard
    if ("%zone" = "7a") then {
        gosub automove ntr
        goto moveToGemShop
    }

    # Crossing Temple
    if ("%zone" = "2a") then {
        gosub automove crossing
        goto moveToGemShop
    }

    # Crossing N Gate
    if ("%zone" = "6") then {
        gosub automove crossing
        goto moveToGemShop
    }

    # Crossing W Gate
    if ("%zone" = "4") then {
        gosub automove crossing
        goto moveToGemShop
    }

    # Crossing
    if ("%zone" = "1") then {
        gosub automove portal
        gosub move go meeting portal
        goto moveToGemShop
    }

    # Shard East Gate Area
    if ("%zone" = "66") then {
        gosub automove portal
        gosub move go meeting portal
        goto moveToGemShop
    }

    # Shard
    if ("%zone" = "67") then {
        gosub automove 132
        goto moveToGemShop
    }

    # Shard West Gate Area
    if ("%zone" = "69") then {
        gosub automove n gate
        goto moveToGemShop
    }

    # Boar Clan / Asketi's Mount
    if ("%zone" = "127" || "%zone" = "126") then {
        gosub runScript travel hib portal
        goto moveToGemShop
    }

    # Hib
    if ("%zone" = "116") then {
        put #tvar powerwalk 0
        if ($Attunement.LearningRate < 34) then put #tvar powerwalk 1
        if ("$roomid" != "96") then gosub automove portal
        gosub move go meeting portal
        put #tvar powerwalk 0
        goto moveToGemShop
    }

    goto moveToGemShop




moveToHeal:
    gosub resetState
    gosub prep rf
    pause 3
    gosub cast
    gosub moveToMagic
    gosub getHealed
    put #script abort all except selesthiel
    put .reconnect
    put .afk
    put .selesthiel
    exit


resetState:
    put #script abort all except selesthiel
    put .reconnect
    put .afk
    #pause .2
    #put #script abort all except selesthiel
    #put .reconnect
    #put .afk
    if ("$righthandnoun" = "compendium" || "$lefthandnoun" = "compendium") then gosub put my compendium in my bag
    if ("$righthandnoun" = "telescope" || "$lefthandnoun" = "telescope") then gosub put my telescope in my bag
    gosub stow right
    gosub stow left
    gosub release spell
    gosub release mana
    #gosub release symbi
    gosub release shear
    gosub release cyclic
    gosub stow hhr'ata
    gosub stow bola
    gosub retrieveBolts
    return


retrieveArrows:
    gosub count my basilisk arrows
    if ("%numArrows" = "seven") then {
        gosub stow right
        return
    }
    if ("$righthandnoun" != "scimitar") then {
        gosub stow right
        gosub get my haralun scimitar
    }
    gosub attack slice
    gosub attack draw
    gosub loot treasure
    put .loot
    waitforre ^LOOT DONE$
    goto retrieveArrows

var expectedNumBolts forty-four
retrieveBolts:

return

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
    gosub attack slice
    gosub attack draw
    gosub loot treasure
    put .loot
    waitforre ^LOOT DONE$
    math retrieveAttempts add 1
    if (%retrieveAttempts < 10 && $monstercount > 0) then goto retrieveBoltsLoop
    var expectedNumBolts %numBolts
    return



waitForBacktrain:
    pause 2
    put #script abort all except selesthiel
    put .reconnect
    put .afk
    pause 1
    put #script abort all except selesthiel
    put .reconnect
    put .afk
    gosub stow right
    gosub stow left
    gosub burgle.setNextBurgleAt
    put #tvar char.fight.backtrain 1
    put .fight
    pause 1

waitForBacktrainLoop:
    gosub getLowestLearningRateFromList $char.fight.weapons.skills|$First_Aid
    var tmpLowestLearningRate %returnVal

    if ($lib.timers.nextBurgleAt < $gametime || %tmpLowestLearningRate > 32) then {
        put #tvar char.fight.backtrain 0
        gosub resetState
        if ($bleeding = 1) then goto moveToHeal
        return
    }
    put #tvar char.fight.backtrain 1
    if (!contains("$scriptlist", "fight.cmd")) then put .fight
    pause 2
    goto waitForBacktrainLoop


waitForMagic:
    pause 2
    if ($lib.timers.nextBurgleAt > $gametime) then {
        put #script abort all except selesthiel
        put .reconnect
        put .afk
        gosub stow right
        gosub stow left
        gosub burgle.setNextBurgleAt
        put .magic
        pause 1
    }

waitForMagicLoop:
    #if ($lib.timers.nextBurgleAt < $gametime || ($Warding.LearningRate > 29 && $Utility.LearningRate > 29 && $Augmentation.LearningRate > 29 && $Arcana.LearningRate > 29)) then {
    if ($lib.timers.nextBurgleAt < $gametime || ($Warding.LearningRate > 29 && $Augmentation.LearningRate > 10 && $Utility.LearningRate > 10)) then {
        put #script abort all except selesthiel
        put .reconnect
        put .afk
        gosub resetState
        return
    }
    pause 2
    if (!contains("$scriptlist", "magic.cmd")) then put .magic
    goto waitForMagicLoop



waitForMainCombat:
    pause 2
    if ("$zoneid" != "69") then put .selesthiel
    put #script abort all except selesthiel
    put .reconnect
    put .afk
    pause 1
    put #script abort all except selesthiel
    put .reconnect
    put .afk
    gosub stow right
    gosub stow left
    gosub burgle.setNextBurgleAt
    put #tvar char.fight.backtrain 0
    put .fight
    pause 1

    var roomPlayerCheckCount 0

waitForMainCombatLoop:
	var forceEndCombat 0
	if ("$roomplayers" != "") then {
		math roomPlayerCheckCount add 1
	} else {
		var roomPlayerCheckCount 0
	}

	if (%roomPlayerCheckCount > 15) then {
		var forceEndCombat 1
		put #echo >Log #FF0000 ROOM OCCUPIED, FORCING MAINCOMBAT END
	}

    if ($lib.timers.nextBurgleAt < $gametime || %forceEndCombat = 1 || ($Crossbow.LearningRate > 29 && $Small_Edged.LearningRate > 29 && $Brawling.LearningRate > 29 && $Light_Thrown.LearningRate > 29 && $Parry_Ability.LearningRate > 29 && $Shield_Usage.LearningRate > 29 && $Targeted_Magic.LearningRate > 29 && $Evasion.LearningRate > 29 && $Twohanded_Blunt.LearningRate > 29 && $Staves.LearningRate > 29)) then {
        gosub resetState
        if ($bleeding = 1) then goto moveToHeal
        return
    }
    put #tvar char.fight.backtrain 0
    if (!contains("$scriptlist", "fight.cmd")) then put .fight
    pause 2
    goto waitForMainCombatLoop


waitForTextbook:
    pause 2
    if ($lib.timers.nextBurgleAt > $gametime) then {
        put #script abort all except selesthiel
        put .reconnect
        put .afk
        gosub stow right
        gosub stow left
        gosub burgle.setNextBurgleAt
        put .textbook
        pause 1
    }

waitForTextbookLoop:
    if ($lib.timers.nextBurgleAt < $gametime || $First_Aid.LearningRate > 29) then {
        put #script abort all except selesthiel
        put .reconnect
        put .afk
        gosub resetState
        return
    }
    pause 2
    if (!contains("$scriptlist", "textbook.cmd")) then put .textbook
    goto waitForTextbookLoop


waitForOutdoorsmanship:
    pause 2
    if ($lib.timers.nextBurgleAt > $gametime) then {
        put #script abort all except selesthiel
        put .reconnect
        put .afk
        gosub stow right
        gosub stow left
        gosub burgle.setNextBurgleAt
        put .collect
        pause 1
    }

waitForOutdoorsmanshipLoop:
    if ($lib.timers.nextBurgleAt < $gametime || $Outdoorsmanship.LearningRate > 10) then {
        put #script abort all except selesthiel
        put .reconnect
        put .afk
        gosub resetState
        return
    }
    pause 2
    if (!contains("$scriptlist", "collect.cmd")) then put .collect
    goto waitForOutdoorsmanshipLoop



selesthiel.arrested:
	echo
	echo ****************************
	echo ** ARRESTED
	echo ****************************
	echo
	put #echo >Log #FF0000 ARRESTED!
	put exit
	put #script abort all except selesthiel
	put exit
    put #script abort all except selesthiel
    exit

logout:
    put exit
    put #script abort all except selesthiel
    put .reconnect
    put .afk
    pause 1
    put #script abort all except selesthiel
    put .reconnect
    put .afk
    put exit
    exit