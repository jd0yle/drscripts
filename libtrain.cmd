include libmaster.cmd


action goto train.logout when eval $health < 50
action goto train.logout when eval $dead = 1

action (health) goto train.getHealedTrigger when eval $health < 85
action (health) goto train.getHealedTrigger when eval $bleeding = 1
action (health) goto train.getHealedTrigger when ^GETHEALED

action send $lastcommand when ^You can't move in that direction while unseen.

action send listen to $1 observe when ^(\S+) begins to lecture
action send listen to $2 observe when ^(\S+) begins to listen to (\S+)

action send load when ^But your.*isn't loaded!

action put #tvar powerwalk 0 when eval $Attunement.LearningRate = 34

action goto train.arrested when ^"Stop right there!"
action goto train.arrested when ^The guardsman stares in your direction for a long moment, then charges straight for you!

action goto train.arrested when eval contains("$roomname", "Jail Cell")

action (taisidonCheck) if (contains("$roomname", "A'baya") || contains("$roomobjs", "shimmering ocean-blue moongate")) then goto train.escapeTaisidon when eval $roomnameaction (taisidonCheck) if (contains("$roomname", "A'baya") || contains("$roomobjs", "shimmering ocean-blue moongate")) then goto train.escapeTaisidon when eval $roomname

if (contains("$roomname", "A'baya")) then goto train.escapeTaisidon


goto train.endOfFile

gosub awake
var useBurgle 1
put #tvar powerwalk 0
put .reconnect
put .afk


###############################
###    train.arrested
###############################
train.arrested:
	echo
	echo ****************************
	echo ** ARRESTED
	echo ****************************
	echo
	put #echo >Log #FF0000 ARRESTED!
	put exit
	put #script abort all except %scriptname
	put exit
    put #script abort all except %scriptname
    exit


###############################
###    train.burgle
###############################
train.burgle:
    #if (%useBurgle = 1 && $lib.timers.nextBurgleAt < $gametime) then gosub burgle.setNextBurgleAt

    if (%useBurgle = 1 &&  $lib.timers.nextBurgleAt < $gametime) then {
        put #echo >Log #cc99ff Train: Going to burgle
		put exp 0 all

        gosub train.moveToBurgle
        gosub release spell

        gosub runScript armor remove

        gosub cast

        gosub runScript burgle
        gosub runScript armor wear

		gosub train.moveToHouse

		if ("$roomname" = "Private Home Interior") then gosub runScript house
		pause
		if ("$roomname" = "Private Home Interior") then gosub runScript house

        gosub automove bundle
        gosub remove my bundle
        gosub sell my bundle
        gosub stow right
        gosub stow left
        gosub get bundle from my $char.inv.defaultContainer
        gosub sell my bundle
        gosub stow right
        gosub stow left
        gosub get bundle from my $char.inv.defaultContainer
        gosub sell my bundle
        gosub stow right
        gosub stow left
        gosub stow right
        gosub stow left

        gosub runScript deposit

		gosub train.getHealed

        pause 1
        #put .%scriptname
        #put .reconnect
        #put .afk
    }
    return


###############################
###    train.castSpellsForMove
###############################
train.castSpellsForMove:
	return
    if ("$preparedspell" != "None") then gosub release spell
    if ($Warding.LearningRate < $Utility.LearningRate) then {
        if ($SpellTimer.GhostShroud.active != 1) then {
            gosub release cyclic
            gosub runScript cast ghs
        }
    } else {
        if ($SpellTimer.Revelation.active != 1) then {
            gosub release cyclic
            gosub runScript cast rev
        }
    }
    return


###############################
###    train.checkHealth
###############################
train.checkHealth:
    var injured 1
    matchre train.checkHealthInjured ^You have.*(skin|head|neck|chest|abdomen|back|tail|hand|arm|leg|eye|twitching|paralysis)
    matchre train.checkHealthNotInjured ^You have no significant injuries.
    put health
    matchwait 5
    return


###############################
###    train.checkHealthInjured
###############################
train.checkHealthInjured:
    var injured 1
    return


###############################
###    train.checkHealthNotInjured
###############################
train.checkHealthNotInjured:
    var injured 0
    return



###############################
###    train.compendium
###############################
train.compendium:
	var train.tmp.targetCompendiumLearningRate $0
	if (!(%train.tmp.targetCompendiumLearningRate > 0)) then var train.tmp.targetCompendiumLearningRate 10
    if ($First_Aid.LearningRate > %train.tmp.targetCompendiumLearningRate) then {
        unvar train.tmp.targetCompendiumLearningRate
        goto train.compendium.done
    }
    put #echo >Log #cc99ff Moving to house for compendium
    gosub train.moveToHouse
    put #echo >Log Start compendium ($First_Aid.LearningRate/34)

	if ("$roomname" = "Private Home Interior") then {
		#gosub whisper inauri teach sorcery
		gosub listen to inauri observe
    }

    gosub stow right
    gosub stow left


###############################
###    train.compendium.cont
###############################
train.compendium.cont:
	var startCompendiumTime $gametime
	put .compendium
	
	train.compendium.cont1:
	    if ($First_Aid.LearningRate >= %train.tmp.targetCompendiumLearningRate) then goto train.compendium.done
        pause 2
        goto train.compendium.cont1


###############################
###    train.compendium.done
###############################
train.compendium.done:
	put #script abort compendium
	unvar train.tmp.targetCompendiumLearningRate
    put #echo >Log End compendium ($First_Aid.LearningRate/34)
    gosub stow right
    gosub stow left
    return



###############################
###    train.enterHouse
###############################
train.enterHouse:
    matchre train.enterHouseCont suddenly rattles
    matchre train.enterHouseCont suddenly opens
    put peer bothy
    matchwait 5
    gosub collect rock
    gosub kick pile
    gosub stow right
    gosub open bothy
    gosub move go bothy
    return



###############################
###    train.enterHouseCont
###############################
train.enterHouseCont:
    gosub open bothy
    gosub move go bothy
    gosub close door
    gosub lock door
    return


###############################
###    train.escapeTaisidon
###############################
train.escapeTaisidon:
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
	put .%scriptname


###############################
###    train.getHealed
###############################
train.getHealed:
    gosub train.checkHealth
    if (%injured = 1) then {
        gosub train.moveToHouse

        if (contains("$roomplayers", "Inauri")) then {
	        gosub whisper inauri heal
	        pause 30
        }

        if (!($lastHealedGametime > -1)) then put #var lastHealedGametime 0
        eval nextHealTime (300 + $lastHealedGametime)

        #if ($bleeding = 1) then {
        gosub train.checkHealth
        if (%injured = 1) then {
            if ("$roomname" = "Private Home Interior") then gosub runScript house

            gosub automove heal
            put join list
            matchre train.getHealedCont Yrisa crosses $charactername's name from the list.
            matchwait 120

            gosub train.getHealedCont

        }
    }
    return


###############################
###    train.getHealedCont
###############################
train.getHealedCont:
	put #var lastHealedGametime $gametime
	gosub train.moveToHouse
	if ($bleeding = 1) then goto train.getHealed


###############################
###    train.getHealedTrigger
###############################
train.getHealedTrigger:
	echo
	echo GETHEALEDTRIGGER FIRED!
	echo
	eval thisScriptName tolower($charactername)
    put #script abort all except %scriptname
    put .afk
    put .reconnect
    action (health) off
    put #echo >Log #FF5501 GETTING HEALED
    put #echo >Log #FF5501 [$roomname]
    put #echo >Log #FF5501 (health=$health bleeding=$bleeding)
    if ($health < 50) then {
        goto train.logout
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

    gosub train.getHealed

    gosub train.moveToMagic

    action (health) on

    put #script abort all except %scriptname
    put .reconnect
    put .afk
    pause .2
    put .%scriptname
    
    
###############################
###    train.healWithRats
###############################
train.healWithRats:
    gosub train.checkHealth
    if ($injured = 1 || $bleeding = 1) then {
        if ("$roomname" = "Private Home Interior") then gosub runScript house
        gosub runScript findSpot fcrat
        gosub runScript devourfcrat
        pause 10
        goto train.healWithRats
    }
    pause .01
    return    



###############################
###    train.moveToBlackGargoyles
###############################
train.moveToBlackGargoyles:
    gosub train.setZone

    if ("$roomname" = "Private Home Interior") then {
        gosub runScript house
        goto train.moveToBlackGargoyles
    }

    # FC
    if ("%zone" = "150") then {
        gosub automove portal
        gosub move go exit portal
        goto train.moveToBlackGargoyles
    }

	# Hawstkaal Road
	if ("%zone" = "126") then {
		gosub runScript travel boar
		goto train.moveToBlackGargoyles
	}

    # Boar Clan / Asketi's Mount
    if ("%zone" = "127" ) then {
        if ($roomid >= 380 && $roomid <= 418 && "$roomplayers" = "") then return
        gosub runScript findSpot blackgargoyle
        goto train.moveToBlackGargoyles
    }

    # Hib
    if ("%zone" = "116") then {
        put #tvar powerwalk 0
        if ($Attunement.LearningRate < 34) then put #tvar powerwalk 1
        gosub runScript travel boar
        put #tvar powerwalk 0
        goto train.moveToBlackGargoyles
    }

    echo No move target found, zoneid = $zoneid  zone = %zone
    goto train.moveToBlackGargoyles



###############################
###    train.moveToBurgle
###############################
train.moveToBurgle:
    gosub train.setZone

	if ($SpellTimer.HydraHex.active = 1) then gosub release hyh

    if ("$roomname" = "Private Home Interior") then {
        echo MOVING TO BURGLE, LEAVING HOUSE
        gosub runScript house
        goto train.moveToBurgle
    }

	if ("%zone" = "108") then {
		gosub automove portal
		if ($Attunement.LearningRate < 30) then put #tvar powerwalk 1
		gosub move go meeting portal
		gosub move west

		gosub train.castSpellsForMove

		gosub runScript deposit
		gosub automove teller
		gosub withdraw 1 gold
		gosub automove excha
		gosub exchange all dok for lirum
		gosub automove portal
		gosub runScript play --noWait=1
		gosub runScript travel kresh 299
		put #tvar powerwalk 0
		goto train.moveToBurgle
	}

	if ("%zone" = "107") then {
		if ("$roomid" = "299") then return
		if ($Attunement.LearningRate < 30) then put #tvar powerwalk 1
		gosub automove 299
		put #tvar powerwalk 0
		# 299 = telescope
		goto train.moveToBurgle
	}

	if ("%zone" = "107a") then {
		gosub runScript play --noWait=1
		gosub runScript travel kresh
		goto train.moveToBurgle
	}

	if ("%zone" = "150") then {
		if ($Attunement.LearningRate < 30) then put #tvar powerwalk 1
		gosub automove portal
		put #tvar powerwalk 0
		gosub move go portal
		goto train.moveToBurgle
	}

    # Crossing W Gate
    if ("%zone" = "4") then {
        put #tvar powerwalk 0
        if ("$roomid" = "450") then return
        if ($Attunement.LearningRate < 30) then put #tvar powerwalk 1
        gosub automove 450
        put #tvar powerwalk 0
        goto train.moveToBurgle
    }

    if ("$roomname" = "Private Home Interior") then {
        gosub runScript house
        goto train.moveToBurgle
    }

    if ("$roomid" = "0") then {
        gosub moveRandom
        gosub runScript house
        goto train.moveToBurgle
    }

    # Crossing Temple
    if ("%zone" = "2a") then {
        gosub automove crossing
        goto train.moveToBurgle
    }

    # NTR
    if ("%zone" = "7") then {
        gosub automove n gate
        goto train.moveToBurgle
    }

    # LEUCROS
    if ("%zone" = "11") then {
        gosub automove ntr
        goto train.moveToBurgle
    }

    # Vineyard
    if ("%zone" = "7a") then {
        gosub automove ntr
        goto train.moveToBurgle
    }

    # Crossing N Gate
    if ("%zone" = "6") then {
        gosub automove w gate
        goto train.moveToBurgle
    }

    # Crossing
    if ("%zone" = "1") then {
        gosub automove w gate
        goto train.moveToBurgle
    }

    # Abandoned Mine
    if ("%zone" = "10") then {
        gosub automove ntr
        goto train.moveToBurgle
    }

    # Shard West Gate Area
    if ("$zoneid" = "69") then {
        if ("$roomid" = "204") then return
        gosub automove 204
        goto train.moveToBurgle
    }

    # Shard East Gate Area
    if ("$zoneid" = "66") then {
        gosub automove 217
        goto train.moveToBurgle
    }

    # Shard
    if ("$zoneid" = "67") then {
        gosub automove 132
        goto train.moveToBurgle
    }

	# Hawstkaal Road
	if ("%zone" = "126") then {
		gosub runScript travel boar
		goto train.moveToBurgle
	}

    # Boar Clan / Asketi's Mount
    if ("%zone" = "127" ) then {
        if ($roomid = 29) then return
        gosub automove 29
        goto train.moveToBurgle
    }

    # Hib
    if ("%zone" = "116") then {
		gosub runScript travel boar
		goto train.moveToBurgle
    }

    goto train.moveToBurgle


###############################
###    train.moveToCaracals
###############################
train.moveToCaracals:
    gosub train.setZone

	if ($SpellTimer.HydraHex.active = 1) then gosub release hyh

    if ("$roomname" = "Private Home Interior") then {
		gosub runScript house
        goto train.moveToCaracals
    }

    # FC
    if ("%zone" = "150") then {
        put #tvar powerwalk 0
        gosub train.castSpellsForMove
        if ($Attunement.LearningRate < 32) then put #tvar powerwalk 1
        gosub automove portal
        put #tvar powerwalk 0
        gosub move go portal
        goto train.moveToCaracals
    }

	# M'RISS
	if ("%zone" = "108") then {
		if ("$roomid" != "193") then gosub automove 193
		gosub runScript findSpot caracal
		return
	}

	# MER'KRESH
	if ("%zone" = "107") then {
		gosub train.castSpellsForMove
		gosub runScript play --noWait=1
		gosub runScript travel mriss
		goto train.moveToCaracals
	}

	# GALLEY
	if ("%zone" = "107a") then {
		gosub runScript play --noWait=1
		gosub runScript travel mriss
		goto train.moveToCaracals
	}

	goto train.moveToCaracals
	

###############################
###    train.moveToCloudRats
###############################
train.moveToCloudRats:
	gosub train.setZone

    if ("$roomname" = "Private Home Interior") then {
        gosub runScript house
        goto train.moveToCloudRats
    }

    # Shard West Gate Area
    if ("$zoneid" = "69") then {
        if ($roomid >= 606 && $roomid <= 612 && "$roomplayers" = "") then return
        gosub runScript findSpot cloudrat
        return
    }

    # Shard East Gate Area
    if ("$zoneid" = "66") then {
        gosub automove w gate
        goto train.moveToCloudRats
    }

    # Shard
    if ("$zoneid" = "67") then {
        gosub automove 132
        goto train.moveToCloudRats
    }

    # FC
    if ("%zone" = "150") then {
        if ($Attunement.LearningRate < 25) then put #tvar powerwalk 1
        gosub automove portal
        put #tvar powerwalk 0
        gosub move go exit portal
        goto train.moveToCloudRats
    }

    goto train.moveToCloudRats


###############################
###    train.moveToGargoyles
###############################
train.moveToGargoyles:
    gosub train.setZone

    if ("$roomname" = "Private Home Interior") then {
        gosub runScript house
        goto train.moveToGargoyles
    }

    # FC
    if ("%zone" = "150") then {
        gosub runScript findSpot gargoyle
        return
    }

    # Shard S Gate
    if ("%zone" = "68") then {
        gosub automove e gate
        goto train.moveToGargoyles
    }

    # Abandoned Mine
    if ("%zone" = "10") then {
        gosub automove ntr
        goto train.moveToGargoyles
    }

    # NTR
    if ("%zone" = "7") then {
        gosub automove n gate
        goto train.moveToGargoyles
    }

    # Vineyard
    if ("%zone" = "7a") then {
        gosub automove ntr
        goto train.moveToGargoyles
    }

    # Crossing Temple
    if ("%zone" = "2a") then {
        gosub automove crossing
        goto train.moveToGargoyles
    }

    # Crossing N Gate
    if ("%zone" = "6") then {
        gosub automove crossing
        goto train.moveToGargoyles
    }

    # Crossing W Gate
    if ("%zone" = "4") then {
        gosub automove crossing
        goto train.moveToGargoyles
    }

    # Crossing
    if ("%zone" = "1") then {
        gosub automove portal      
        gosub move go meeting portal     
        goto train.moveToGargoyles
    }

    # Shard East Gate Area
    if ("%zone" = "66") then {
        gosub automove portal
        gosub move go portal
        goto train.moveToGargoyles
    }

    # Shard
    if ("%zone" = "67") then {
        gosub automove 132
        goto train.moveToGargoyles
    }

    # Shard West Gate Area
    if ("%zone" = "69") then {
        gosub automove n gate
        goto train.moveToGargoyles
    }

    goto train.moveToGargoyles


###############################
###    train.moveToGerbils
###############################
train.moveToGerbils:
    put #echo Yellow Moving to gerbils
    gosub train.setZone

    if ("$roomname" = "Private Home Interior") then {
        gosub runScript house
        goto train.moveToGerbils
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
        goto train.moveToGerbils
    }

    # Crossing Temple
    if ("%zone" = "2a") then {
        gosub automove crossing
        goto train.moveToGerbils
    }

    # NTR
    if ("%zone" = "7") then {
        gosub automove vineyard
        goto train.moveToGerbils
    }

    # Crossing N Gate
    if ("%zone" = "6") then {
        gosub automove ntr
        goto train.moveToGerbils
    }

    # Crossing W Gate
    if ("%zone" = "4") then {
        gosub automove n gate
        goto train.moveToGerbils
    }

    # Crossing
    if ("%zone" = "1") then {
        gosub automove n gate
        goto train.moveToGerbils
    }

    goto train.moveToGerbils


###############################
###    train.moveToHouse
###############################
train.moveToHouse:
    gosub train.setZone

	if ($SpellTimer.HydraHex.active = 1) then gosub release hyh

    if ("$roomname" = "Private Home Interior") then {
		#if ("$roomplayers" = "Also here: Blight Bringer Inauri.") then gosub whisper inauri teach forging
        return
    }

    # FC
    if ("%zone" = "150") then {
        if ("$roomname" = "Private Home Interior") then return
        if ("$roomid" = "50") then {
            gosub train.enterHouse
        } else {
            gosub train.castSpellsForMove
            if ($Attunement.LearningRate < 30) then put #tvar powerwalk 1
            gosub automove 50
            put #tvar powerwalk 0
            goto train.moveToHouse
        }
        return
        #goto train.moveToHouse
    }

	# M'RISS
	if ("%zone" = "108") then {
		gosub automove portal
		gosub move go meeting portal
		goto train.moveToHouse
	}

	# MER'KRESH
	if ("%zone" = "107") then {
		gosub train.castSpellsForMove

		if ($Attunement.LearningRate < 30) then put #tvar powerwalk 1
		gosub runScript play --noWait=1
		gosub runScript travel mriss
		put #tvar powerwalk 0
		goto train.moveToHouse
	}

	# GALLEY
	if ("%zone" = "107a") then {
		gosub runScript play --noWait=1
		gosub runScript travel mriss
		goto train.moveToHouse
	}

    # LEUCROS
    if ("%zone" = "11") then {
        gosub automove ntr
        goto train.moveToHouse
    }

    # Storm Bulls
    if ("%zone" = "112") then {
        gosub automove leth
        goto train.moveToHouse
    }

    # Leth
    if ("%zone" = "61") then {
        gosub automove portal
        gosub move go meeting portal
        goto train.moveToHouse
    }

    # Ice Caves
    if ("%zone" = "68a") then {
        gosub automove 30
        goto train.moveToHouse
    }

    # Shard S Gate
    if ("%zone" = "68") then {
        gosub automove e gate
        goto train.moveToHouse
    }

    # Abandoned Mine
    if ("%zone" = "10") then {
        gosub automove ntr
        goto train.moveToHouse
    }

    # NTR
    if ("%zone" = "7") then {
        gosub automove n gate
        goto train.moveToHouse
    }

    # Vineyard
    if ("%zone" = "7a") then {
        gosub automove ntr
        goto train.moveToHouse
    }

    # Crossing Temple
    if ("%zone" = "2a") then {
        gosub automove crossing
        goto train.moveToHouse
    }

    # Crossing N Gate
    if ("%zone" = "6") then {
        gosub automove crossing
        goto train.moveToHouse
    }

    # Crossing W Gate
    if ("%zone" = "4") then {
        gosub automove crossing
        goto train.moveToHouse
    }

    # Crossing
    if ("%zone" = "1") then {
        gosub automove portal
        gosub move go meeting portal
        goto train.moveToHouse
    }

    # Shard East Gate Area
    if ("%zone" = "66") then {
        gosub automove portal
        gosub move go portal
        goto train.moveToHouse
    }

    # Shard
    if ("%zone" = "67") then {
        gosub automove 132
        goto train.moveToHouse
    }

    # Shard West Gate Area
    if ("%zone" = "69") then {
        gosub automove n gate
        goto train.moveToHouse
    }

    # Boar Clan / Asketi's Mount
    if ("%zone" = "127" || "%zone" = "126") then {
        gosub runScript travel hib portal
        goto train.moveToHouse
    }

    # Hib
    if ("%zone" = "116") then {
        put #tvar powerwalk 0
        if ($Attunement.LearningRate < 34) then put #tvar powerwalk 1
        if ("$roomid" != "96") then gosub automove portal
        gosub move go meeting portal
        put #tvar powerwalk 0
        goto train.moveToHouse
    }

    goto train.moveToHouse
    
    
###############################
###    train.moveToLeucros
###############################
train.moveToLeucros:
    gosub train.setZone

    # Leucros
    if ("%zone" = "11") then {
        if ($roomid >= 12 && $roomid <= 22 && "$roomplayers" = "") then return
        gosub runScript findSpot leucro
        goto train.moveToLeucros
    }

    # Crossing W Gate
    if ("%zone" = "4") then {
        put #tvar powerwalk 0
        gosub automove crossing
        goto train.moveToLeucros
    }

    if ("$roomname" = "Private Home Interior") then {
        gosub runScript house
        goto train.moveToLeucros
    }

    # Crossing Temple
    if ("%zone" = "2a") then {
        gosub automove crossing
        goto train.moveToLeucros
    }

    # NTR
    if ("%zone" = "7") then {
        gosub automove leucro
        goto train.moveToLeucros
    }

    # Vineyard
    if ("%zone" = "7a") then {
        gosub automove ntr
        goto train.moveToLeucros
    }

    # Crossing N Gate
    if ("%zone" = "6") then {
        gosub automove ntr
        goto train.moveToLeucros
    }

    # Crossing
    if ("%zone" = "1") then {
        gosub automove n gate
        goto train.moveToLeucros
    }

    # FC
    if ("%zone" = "150") then {
        if ($Attunement.LearningRate < 20) then put #tvar powerwalk 1
        gosub automove portal
        put #tvar powerwalk 0
        gosub move go exit portal
        goto train.moveToLeucros
    }

    # Abandoned Mine
    if ("%zone" = "10") then {
        gosub automove ntr
        goto train.moveToLeucros
    }

    goto train.moveToLeucros    


###############################
###    train.moveToMagic
###############################
train.moveToMagic:
    gosub train.setZone

	if ($SpellTimer.HydraHex.active = 1) then gosub release hyh

    if ("$roomname" = "Private Home Interior") then return

    # FC
    if ("%zone" = "150") then {
        put #tvar powerwalk 0
        if ("$roomid" = "50") then return
        if ($Attunement.LearningRate < 30) then put #tvar powerwalk 1
        gosub automove 50
        put #tvar powerwalk 0
        goto train.moveToMagic
    }

	# M'RISS
	if ("%zone" = "108") then {
		gosub automove portal
		gosub move go meeting portal
		goto train.moveToHouse
	}

	# MER'KRESH
	if ("%zone" = "107") then {
		gosub train.castSpellsForMove

		if ($Attunement.LearningRate < 30) then put #tvar powerwalk 1
		gosub runScript play --noWait=1
		gosub runScript travel mriss
		put #tvar powerwalk 0
		goto train.moveToHouse
	}

	# GALLEY
	if ("%zone" = "107a") then {
		gosub runScript play --noWait=1
		gosub runScript travel mriss
		goto train.moveToHouse
	}

    # LEUCROS
    if ("%zone" = "11") then {
        gosub automove ntr
        goto train.moveToMagic
    }

    # Ice Caves
    if ("%zone" = "68a") then {
        gosub automove 30
        goto train.moveToMagic
    }

    # Shard S Gate
    if ("%zone" = "68") then {
        gosub automove e gate
        goto train.moveToMagic
    }

    # Abandoned Mine
    if ("%zone" = "10") then {
        gosub automove ntr
        goto train.moveToMagic
    }

    # NTR
    if ("%zone" = "7") then {
        gosub automove crossing
        goto train.moveToMagic
    }

    # Vineyard
    if ("%zone" = "7a") then {
        gosub automove ntr
        goto train.moveToMagic
    }

    # Crossing Temple
    if ("%zone" = "2a") then {
        gosub automove crossing
        goto train.moveToMagic
    }

    # Crossing N Gate
    if ("%zone" = "6") then {
        gosub automove crossing
        goto train.moveToMagic
    }

    # Crossing W Gate
    if ("%zone" = "4") then {
        gosub automove crossing
        goto train.moveToMagic
    }

    # Crossing
    if ("%zone" = "1") then {
        gosub automove portal
        gosub move go meeting portal
        goto train.moveToMagic
    }

    # Shard East Gate Area
    if ("%zone" = "66") then {
        gosub automove portal
        gosub move go meeting portal
        goto train.moveToMagic
    }

    # Shard
    if ("%zone" = "67") then {
        gosub automove 132
        goto train.moveToMagic
    }

    # Shard West Gate Area
    if ("%zone" = "69") then {
        gosub automove n gate
        goto train.moveToMagic
    }

    # Storm Bulls
    if ("%zone" = "112") then {
        gosub automove leth
        goto train.moveToMagic
    }

    # Leth
    if ("%zone" = "61") then {
        gosub automove portal
        gosub move go meeting portal
        goto train.moveToMagic
    }

    goto train.moveToMagic



###############################
###    train.moveToMaulers
###############################
train.moveToMaulers:
    gosub train.setZone

    if ("$roomname" = "Private Home Interior") then {
        gosub runScript house
        goto train.moveToMaulers
    }

    # FC
    if ("%zone" = "150") then {
        gosub automove portal
        gosub move go exit portal
        goto train.moveToMaulers
    }

	# Hawstkaal Road
	if ("%zone" = "126") then {
		gosub runScript travel boar
		goto train.moveToMaulers
	}

    # Boar Clan / Asketi's Mount
    if ("%zone" = "127" ) then {
        if ($roomid >= 566 && $roomid <= 571 && "$roomplayers" = "") then return
        gosub runScript findSpot mauler
        goto train.moveToMaulers
    }

    # Hib
    if ("%zone" = "116") then {
        put #tvar powerwalk 0
        if ($Attunement.LearningRate < 34) then put #tvar powerwalk 1
        gosub runScript travel boar
        put #tvar powerwalk 0
        goto train.moveToMaulers
    }

    echo No move target found, zoneid = $zoneid  zone = %zone
    goto train.moveToMaulers



###############################
###    train.moveToPeccaries
###############################
train.moveToPeccaries:
    gosub train.setZone

	if ($SpellTimer.HydraHex.active = 1) then gosub release hyh

    if ("$roomname" = "Private Home Interior") then {
		gosub runScript house
        goto train.moveToPeccaries
    }

    # FC
    if ("%zone" = "150") then {
        put #tvar powerwalk 0
        gosub train.castSpellsForMove
        if ($Attunement.LearningRate < 32) then put #tvar powerwalk 1
        gosub automove portal
        put #tvar powerwalk 0
        gosub move go portal
        goto train.moveToPeccaries
    }

	# M'RISS
	if ("%zone" = "108") then {
		gosub runScript findSpot peccary
		return
	}

	# MER'KRESH
	if ("%zone" = "107") then {
		gosub train.castSpellsForMove
		gosub runScript play --noWait=1
		gosub runScript travel mriss
		goto train.moveToPeccaries
	}

	# GALLEY
	if ("%zone" = "107a") then {
		gosub runScript play --noWait=1
		gosub runScript travel mriss
		goto train.moveToPeccaries
	}

	goto train.moveToPeccaries
	
	
###############################
###    train.moveToStompers
###############################
train.moveToStompers:
    gosub train.setZone

    if ("$roomname" = "Private Home Interior") then {
        gosub runScript house
        goto train.moveToStompers
    }

    # FC
    if ("%zone" = "150") then {
        gosub automove portal
        gosub move go exit portal
        goto train.moveToStompers
    }

	# Hawstkaal Road
	if ("%zone" = "126") then {
		gosub runScript travel boar
		goto train.moveToStompers
	}

    # Boar Clan / Asketi's Mount
    if ("%zone" = "127" ) then {
        if ($roomid >= 560 && $roomid <= 565 && "$roomplayers" = "") then return
        gosub runScript findSpot stomper
        goto train.moveToStompers
    }

    # Hib
    if ("%zone" = "116") then {
        put #tvar powerwalk 0
        if ($Attunement.LearningRate < 34) then put #tvar powerwalk 1
        gosub runScript travel boar
        put #tvar powerwalk 0
        goto train.moveToStompers
    }

    echo No move target found, zoneid = $zoneid  zone = %zone
    goto train.moveToStompers	


###############################
###    train.moveToYellowGremlins
###############################
train.moveToYellowGremlins:
    gosub train.setZone

	if ($SpellTimer.HydraHex.active = 1) then gosub release hyh

    if ("$roomname" = "Private Home Interior") then {
        gosub runScript house
        goto train.moveToYellowGremlins
    }

    # FC
    if ("%zone" = "150") then {
        if ("$roomname" = "Private Home Interior") then {
            gosub runScript house
            goto train.moveToYellowGremlins
        }
        gosub runScript findSpot gremlin
        return
    }

    # Shard S Gate
    if ("%zone" = "68") then {
        gosub automove e gate
        goto train.moveToYellowGremlins
    }

    # Shard East Gate Area
    if ("%zone" = "66") then {
        gosub automove portal
        gosub move go portal
        goto train.moveToYellowGremlins
    }

    # Shard
    if ("%zone" = "67") then {
        gosub automove 132
        goto train.moveToYellowGremlins
    }

    # Shard West Gate Area
    if ("%zone" = "69") then {
        gosub automove n gate
        goto train.moveToYellowGremlins
    }

    goto train.moveToYellowGremlins


###############################
###    train.moveToWarklin
###############################
train.moveToWarklin:
    gosub train.setZone

    if ("$roomname" = "Private Home Interior") then {
        gosub runScript house
        goto train.moveToWarklin
    }

    # Abandoned Mine
    if ("%zone" = "10") then {
        if ($roomid >= 117 && $roomid <= 121 and "$roomplayers" = "") then return
        gosub automove 46
        gosub runScript findSpot warklin
        return
    }

    # NTR
    if ("%zone" = "7") then {
        gosub automove 396
        goto train.moveToWarklin
    }

    # Crossing N Gate
    if ("%zone" = "6") then {
        gosub automove ntr
        goto train.moveToWarklin
    }

    # Crossing W Gate
    if ("%zone" = "4") then {
        gosub automove n gate
        goto train.moveToWarklin
    }

    # Crossing
    if ("%zone" = "1") then {
        gosub automove n gate
        pause 2
        goto train.moveToWarklin
    }

    # FC
    if ("%zone" = "150") then {
        gosub automove portal
        gosub move go exit portal
        goto train.moveToWarklin
    }

    echo No move target found, zoneid = $zoneid  zone = %zone
    goto train.moveToWarklin


###############################
###    train.performance
###############################
train.performance:
	var train.tmp.targetPerformanceLearningRate $0
	if (!(%train.tmp.targetPerformanceLearningRate > 0)) then var train.tmp.targetPerformanceLearningRate 10
    if ($Performance.LearningRate > %train.tmp.targetPerformanceLearningRate) then {
        unvar train.tmp.targetPerformanceLearningRate
        return
    }
    put #echo >Log #cc99ff Moving to house for performance
    gosub train.moveToHouse
    put #echo >Log Start perform ($Performance.LearningRate/34)

	if ("$roomname" = "Private Home Interior") then {
		#gosub whisper inauri teach sorcery
		gosub listen to inauri observe
    }

    gosub stow right
    gosub stow left


###############################
###    train.performance.cont
###############################
train.performance.cont:
	var startPerformanceTime $gametime
	put #tvar char.isPerforming 0
	
	train.performance.cont1:
	    if ($SpellTimer.Revelation.active != 1) then {
	        gosub release cyclic
	        gosub runScript cast rev
	    }
	    if ($Performance.LearningRate < %train.tmp.targetPerformanceLearningRate) then {
	        if ($monstercount > 0) then gosub retreat
	        gosub runScript play
	        goto train.performance.cont1
	    }
	    goto train.performance.done


###############################
###    train.performance.done
###############################
train.performance.done:
	unvar train.tmp.targetPerformanceLearningRate
    put #echo >Log End perform ($Performance.LearningRate/34)
    gosub stow right
    gosub stow left
    return


###############################
###    train.resetState
###############################
train.resetState:
	put .reconnect
	put .afk
	gosub stow right
	gosub stow left
	gosub release symbiosis
	if ("$preparedspell" != "None") then gosub release spell
	gosub stow hhr'ata
	gosub stow sphere
	gosub stow bola
	gosub stow frying pan
	gosub stow right
	gosub stow left
	return


###############################
###    train.setZone
###############################
train.setZone:
    var zone $zoneid

	if ($standing != 1) then gosub stand

    if ("$roomname" = "Belarritaco Bay, The Galley Dock") then var zone 108
    if ("$roomname" = "Mer'Kresh, The Galley Dock") then var zone 107
    if ("$roomname" = "The Galley Sanegazat") then var zone 107a
    if ("$roomname" = "The Galley Cercorim") then var zone 107b
    if ("$roomname" = "Mer'Kresh, The Galley Dock") then var zone 107


    if ("%zone" = "0" && "$roomname" != "Private Home Interior") then {
        put n
        pause .2
        put sw
        pause
        goto train.setZone
    }

    return


###############################
###    train.waitForRepair
###############################
train.waitForRepair:
    matchre train.waitForRepairLoop won't be ready for another (\d+) roisaen.
    matchre train.waitForRepairLoop any moment
    matchre train.repairDone ready by now
    matchre return ^I could not find
    put look at my ticket
    matchwait 3
    goto train.waitForRepair


###############################
###    train.waitForRepairLoop
###############################
train.waitForRepairLoop:
    var minutesToWait $1
    if (!(%minutesToWait > 0)) then var minutesToWait 1
    evalmath nextCheckTicketGametime (%minutesToWait * 60 + $gametime)

    train.waitForRepairLoop1:
    if (%nextCheckTicketGametime < $gametime) then goto train.waitForRepair
    echo Waiting to check ticket again
    gosub collect dirt
    gosub kick pile
    pause
    goto train.waitForRepairLoop1


###############################
###    train.repairDone
###############################
train.repairDone:
    gosub train.moveToMagic
    gosub runScript repair --noWait=1
    gosub automove 50
    put .%scriptname


###############################
###    train.logout
###############################
train.logout:
    put exit
    put #script abort all except %scriptname
	put .reconnect
    pause 1
    put #script abort all except %scriptname
	put .reconnect
    put exit
    exit
	

###############################
###    train.endOfFile
###############################
train.endOfFile:
