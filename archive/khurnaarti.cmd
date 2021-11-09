include libmaster.cmd

put .afk



#action goto logout when eval $health < 50
action goto logout when eval $dead = 1

action (health) goto getHealedTrigger when eval $health < 85
action (health) goto getHealedTrigger when eval $bleeding = 1
action (health) goto getHealedTrigger when ^TESTHEAL

action send unlock door; send open door when ^($friend)'s face appears in the

action (checkTeach) var isInClass 1 when You are in this class
action send stop teach when ^Inauri stops listening to you.
action send listen to $1 when ^($friend) begins to lecture
action put whisper inauri teach $1 when ^Inauri stops trying to teach (.*) to you\.$

action send release rf;send go meeting portal when ^But no one can see you
action send release rf;send rummage my shadows when ^You feel about some dark encompassing shadows of twilight dreamweave\.$
action send release rf when ^You can't move in that direction while unseen\.$

#action (duskruinCheck) if (contains("$roomname", "Duskruin") || contains("$roomobjs", "a palisade gate")) then goto escapeDuskruin when eval $roomname

action put exp mods when ^Your spell.*backfire.*
action goto khurnaarti.arrested when ^"Stop right there!"

var expectedNumBolts two hundred forty-seven
action var numBolts $1 when ^You count some .* bolts in the \S+ and see there are (\S+) left\.$
#action var numArrows $1 when ^You count some arrows in the \S+ and see there are (\S+) left\.$
action send stand when ^You'll have to move off the sandpit first\.




if_1 then {
    if ("%1" = "fight") then var startAt fight
    if ("%1" = "magic") then var startAt magic
}


# debug 10


var injured 0

timer start

if ($health < 80 && "$roomname" != "Private Home Interior") then goto getHealedTrigger

if ("%startAt" = "fight") then goto startFight
if ("%startAt" = "magic") then
	echo starting at magic
	goto startMagic
}

##############################
##### main
##############################
main:
    gosub abortScripts
    gosub resetState
    gosub burgle.setNextBurgleAt
    pause 2

    if ($lib.timers.nextBurgleAt < $gametime) then {
        put #echo >Log #009933 [khurnaarti] Going to burgle.
		put exp 0 all

        gosub moveToBurgle

        if ($SpellTimer.InvocationoftheSpheres.active != 1) then {
            gosub release rf
            gosub runScript iots ref
        }

        gosub prep rf
        gosub runScript armor remove
        gosub cast

        gosub runScript burgle
        gosub runScript armor wear

		put #echo >Log #009933 [khurnaarti] Burgle complete. ATH:($Athletics.LearningRate/34) Locks:($Locksmithing.LearningRate/34) Stealth:($Stealth.LearningRate/34)
		gosub afterBurgle
    }



    # Magic
    startMagic:
    if ($bleeding = 1 || $Warding.LearningRate < 10 || $Utility.LearningRate < 10 || $Augmentation.LearningRate < 10 || %startMagic = 1) then {
        var startMagic 0
        put #echo >Log #6600ff [khurnaarti] Moving to magic
        gosub moveToMagic
        gosub getHealed


        if ($Sorcery.LearningRate < 2 && $char.magic.train.revSorcery != 1) then {
            put #echo >Log #6600ff [khurnaarti] Sorcery start.
            gosub runScript research sorcery
            put #echo >Log #6600ff [khurnaarti] Sorcery complete. Sorcery: $Sorcery.LearningRate/34
            gosub getHealed            
        }        

        put #echo >Log #6600ff [khurnaarti] Magic start.
        put .magic
        gosub waitForMagic
        put #echo >Log #6600ff [khurnaarti] Magic complete. Aug:($AugmentationWarding.LearningRate/34)
        put #echo >Log #6600ff [khurnaarti] Magic complete. Utility:($Utility.LearningRate/34)
        put #echo >Log #6600ff [khurnaarti] Magic complete. Ward:($Warding.LearningRate/34).
        goto main
    }

	# Main Combat
    startFight:
	    put #echo >Log #FF8080 [khurnaarti] Moving to combat
	    gosub moveToGremlins
	    put #tvar char.fight.backtrain 0
	    put .fight
	    gosub waitForMainCombat
	    goto main


    gosub abortScripts
    gosub resetState

    goto main





##############################
##### abortScripts
##############################
abortScripts:
    put #script abort all except khurnaarti
    put .reconnect
    put .afk
    pause 1
    put #script abort all except khurnaarti
    put .reconnect
    put .afk
    pause .2
    gosub stow right
    gosub stow left
    return


##############################
##### afterBurgle
##############################
afterBurgle:
    gosub automove n gate
    gosub automove portal
    gosub move go gate
    gosub automove pawn

    gosub runScript pawn
    gosub prep rf
    gosub automove portal

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
    gosub get bundle from my $char.inv.defaultContainer
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
    gosub get bundle from my $char.inv.defaultContainer
    gosub sell my bundle
    gosub stow right
    gosub stow left

    gosub runScript dep
    gosub move up
    gosub move out
    gosub cast
    return
    

##############################
##### checkHealth
##############################
checkHealth:
    var injured 1
    matchre checkHealthInjured ^You have.*(skin|head|neck|chest|abdomen|back|tail|hand|arm|leg|eye|twitching|paralysis)
    matchre checkHealthNotInjured ^You have no significant injuries.
    put health
    matchwait 5
    return


##############################
##### checkHealthInjured
##############################
checkHealthInjured:
    var injured 1
    return


##############################
##### checkHealthNotInjured
##############################
checkHealthNotInjured:
    var injured 0
    return


##############################
##### checkTeaching
##############################
checkTeaching:
	if (contains("$roomplayers", "Inauri") then {
		action (checkTeach) on
		var isInClass 0
        matchre checkTeaching.setClass a class on (\S+)
        matchre checkTeaching.newClass ^No one seems to be teaching\.$
        put assess teach
        matchwait 5
    }

		checkTeaching.newClass:
		    if ($lib.student != 1) then {
		        if ($Targeted_Magic.LearningRate < 30) then {
		            gosub whisper inauri teach tm
		        } else {
		            gosub whisper inauri teach debil
		        }
		        gosub listen to Inauri
	        }
		    action (checkTeach) off
		    return


        checkTeaching.setClass:
            var classTopic $1
            if ("$lib.instructor" = "Inauri") then {
                gosub listen $lib.instructor observe
                put #var lib.student 1
            } else {
                gosub listen $lib.instructor
                put #var lib.student 1
            }
            action (checkTeach) off
            return



##############################
##### escapeDuskruin
##############################
escapeDuskruin:
    action (duskruinCheck) off
    put #echo >Log #FF0000 [khurnaarti] ATTEMPTING TO ESCAPE DUSKRUIN
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
		    put #echo >Log #FF0000 [khurnaarti] LOST IN DUSKRUIN! EXITING
		    put #script abort all
		    exit
		}
		goto escapeDuskruin
	}
	put #echo >Log #00FF00 Back in Fang Cove!
	put .khurnaarti


##############################
##### getHealedTrigger
##############################
getHealedTrigger:
    put #script abort all except khurnaarti
    put .afk
    put .reconnect
    action (health) off
    put #echo >Log pink [khurnaarti] GETTING HEALED [$roomname] (health=$health bleeding=$bleeding)
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

    put #script abort all except khurnaarti
    put .reconnect
    put .afk
    pause .2
    put .khurnaarti


##############################
##### getHealed
##############################
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
            matchre getHealedCont Yrisa crosses Khurnaarti's name from the list.
            matchwait 120

            gosub getHealedCont

        }
    }
    return

##############################
##### getHealedCont
##############################
getHealedCont:
	put #var lastHealedGametime $gametime
	gosub automove portal
	gosub move go exit portal
	gosub moveToMagic
	if ($bleeding = 1) then goto getHealed



##############################
##### moveToBurgle
##############################
moveToBurgle:
    if ("$roomname" = "Private Home Interior") then {
        gosub runScript house
        waitforre ^HOUSE DONE
        goto moveToBurgle
    }
    # Crossing - City
    if ($zoneid = 1) then {
        if ($roomid = 258) then return
        gosub automove 258
        goto moveToBurgle
    }
    # Crossing - North Gate
    if ($zoneid = 6) then {
        gosub automove crossing
        goto moveToBurgle
    }
    # Shard - East Gate
    if ($zoneid = 66) then {
        if ($roomid = 91) then return
        gosub automove 91
        goto moveToBurgle
    }
    # Shard - City
    if ($zoneid = 67) then {
        gosub automove portal
        goto moveToBurgle
    }
    # Shard - South of City
    if ($zoneid = 68) then {
        gosub automove 3
        gosub move go path
        goto moveToBurgle
    }
    # Fang Cove
    if ($zoneid = 150) then {
        gosub automove portal
        gosub move go exit portal
        goto moveToBurgle
    }
    goto moveToBurgle


##############################
##### moveToHeal
##############################
moveToHeal:
    gosub resetState
    gosub prep rf
    pause 3
    gosub cast
    gosub moveToMagic
    gosub getHealed
    put #script abort all except khurnaarti
    put .reconnect
    put .afk
    put .khurnaarti
    exit
    

##############################
##### moveToMagic
##############################
moveToMagic:
    gosub checkTeaching

    if ("$roomname" = "Private Home Interior") then return

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


##############################
##### moveToRedGremlins
##############################
moveToRedGremlins:
    if ("$roomname" = "Private Home Interior") then {
        if ($SpellTimer.SeersSense.active = 0 || $SpellTimer.SeersSense.duration < 10) then gosub runScript cast seer
        if ($SpellTimer.ManifestForce.active = 0 || $SpellTimer.ManifestForce.duration < 10) then gosub runScript cast maf
        if ($SpellTimer.CageofLight.active = 0 || $SpellTimer.CageofLight.duration < 10) then gosub runScript cast col
        gosub runScript house
        goto moveToRedGremlins
    }

    if ($SpellTimer.RefractiveField.duration < 2) then {
        gosub prep rf
        pause 3
        gosub cast
    }


    # Shard West Gate Area
    if ("$zoneid" = "69") then {
        gosub automove portal
        goto moveToGremlins
    }

    # Shard East Gate Area
    if ("$zoneid" = "66") then {
        if ($roomid >= 621 && $roomid <= 635) then {
            if ("$roomplayers" = "") then {
                return
            } else {
                gosub runScript findSpot redgremlin
            }
        } else {
            gosub automove 635
        }
        goto moveToRedGremlins
    }

    # Shard
    if ("$zoneid" = "67") then {
        gosub automove portal
        goto moveToRedGremlins
    }

    # FC
    if ("$zoneid" = "150") then {
        gosub automove portal
        gosub move go exit portal
        goto moveToRedGremlins
    }

    goto moveToRedGremlins


##############################
##### moveToShardBulls
##############################
moveToShardBulls:
    if ("$roomname" = "Private Home Interior") then {
        if ($SpellTimer.SeersSense.active = 0 || $SpellTimer.SeersSense.duration < 10) then gosub runScript cast seer
        if ($SpellTimer.ManifestForce.active = 0 || $SpellTimer.ManifestForce.duration < 10) then gosub runScript cast maf
        if ($SpellTimer.CageofLight.active = 0 || $SpellTimer.CageofLight.duration < 10) then gosub runScript cast col
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



##############################
##### moveToWyverns
##############################
moveToWyverns:
    if ("$roomname" = "Private Home Interior") then {
        if ($SpellTimer.SeersSense.active = 0 || $SpellTimer.SeersSense.duration < 10) then gosub runScript cast seer
        if ($SpellTimer.ManifestForce.active = 0 || $SpellTimer.ManifestForce.duration < 10) then gosub runScript cast maf
        if ($SpellTimer.CageofLight.active = 0 || $SpellTimer.CageofLight.duration < 10) then gosub runScript cast col
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
        if ($roomid >= 454 && $roomid <= 463 && "$roomplayers" = "") then return
        gosub runScript findSpot juvenilewyvern
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





##############################
##### resetState
##############################
resetState:
    put #script abort all except khurnaarti
    put .reconnect
    put .afk
    #pause .2
    #put #script abort all except khurnaarti
    #put .reconnect
    #put .afk
    if ("$righthandnoun" = "compendium" || "$lefthandnoun" = "compendium") then gosub put my compendium in my $char.inv.defaultContainer
    if ("$righthandnoun" = "telescope" || "$lefthandnoun" = "telescope") then gosub put my telescope in my $char.observe.telescope.container
    gosub stow right
    gosub stow left
    gosub release spell
    gosub release mana
    #gosub release symbi
    gosub release shear
    gosub release cyclic
    gosub stow hhr'ata
    gosub stow frying pan
    gosub retrieveBolts
    return


##############################
##### retrieveArrows
##############################
retrieveArrows:
    gosub count my basilisk arrows
    if ("%numArrows" = "seven") then {
        gosub stow right
        return
    }
    if ("$righthandnoun" != "nightstick") then {
        gosub stow right
        gosub get my nightstick
    }
    gosub attack slice
    gosub attack draw
    gosub loot treasure
    put .loot
    waitforre ^LOOT DONE$
    goto retrieveArrows


##############################
##### retrieveBolts
##############################
retrieveBolts:
	return

    var retrieveAttempts 0
	retrieveBoltsLoop:
	    gosub count my bolts
	    if ("%numBolts" = "%expectedNumBolts") then {
	        gosub stow right
	        return
	    } else {
	        echo WRONG NUMBER OF BOLTS, found %numBolts expected %expectedNumBolts
	    }
        if ("$righthandnoun" != "nightstick") then {
            gosub stow right
            gosub get my nightstick
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


##############################
##### sorceryCont
##############################
sorceryCont:
    put #script abort all except khurnaarti
    put .reconnect
    put .afk
    pause 1
    put #script abort all except khurnaarti
    put .reconnect
    put .afk
    goto magicCont


##############################
##### waitForBacktrain
##############################
waitForBacktrain:
    pause 2
    put #script abort all except khurnaarti
    put .reconnect
    put .afk
    pause 1
    put #script abort all except khurnaarti
    put .reconnect
    put .afk
    gosub stow right
    gosub stow left
    gosub burgle.setNextBurgleAt
    put #tvar char.fight.backtrain 1
    put .fight
    pause 1


##############################
##### waitForBacktrainLoop
##############################
waitForBacktrainLoop:
    if ($lib.timers.nextBurgleAt < $gametime || ($Heavy_Thrown.LearningRate > 29 && $Staves.LearningRate > 29 )) then {
        put #tvar char.fight.backtrain 0
        gosub resetState
        if ($bleeding = 1) then goto moveToHeal
        return
    }
    put #tvar char.fight.backtrain 1
    if (!contains("$scriptlist", "fight.cmd")) then put .fight
    pause 2
    goto waitForBacktrainLoop


##############################
##### waitForMagic
##############################
waitForMagic:
    pause 2
    if ($lib.timers.nextBurgleAt > $gametime) then {
        put #script abort all except khurnaarti
        put .reconnect
        put .afk
        gosub stow right
        gosub stow left
        gosub burgle.setNextBurgleAt
        put .magic
        pause 1
    }


waitForMagicLoop:    
    if ($lib.timers.nextBurgleAt < $gametime || ($Warding.LearningRate > 15 && $Augmentation.LearningRate > 15 && $Utility.LearningRate > 15)) then {
        put #script abort all except khurnaarti
        put .reconnect
        put .afk
        gosub resetState
        return
    }
    pause 2
    if (!contains("$scriptlist", "magic.cmd")) then put .magic
    goto waitForMagicLoop



##############################
##### waitForMainCombat
##############################
waitForMainCombat:
    pause 2
    if ("$zoneid" != "66") then put .khurnaarti
    put #script abort all except khurnaarti
    put .reconnect
    put .afk
    pause 1
    put #script abort all except khurnaarti
    put .reconnect
    put .afk
    gosub stow right
    gosub stow left
    gosub burgle.setNextBurgleAt
    put #tvar char.fight.backtrain 0
    put .fight
    pause 1

    var roomPlayerCheckCount 0

##############################
##### waitForMainCombatLoop
##############################
waitForMainCombatLoop:
	var forceEndCombat 0
	if ("$roomplayers" != "") then {
		math roomPlayerCheckCount add 1
	} else {
		var roomPlayerCheckCount 0
	}

	if (%roomPlayerCheckCount > 15) then {
		var forceEndCombat 1
		put #echo >Log #FF0000 [khurnaarti] ROOM OCCUPIED, FORCING MAINCOMBAT END
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


##############################
##### khurnaarti.arrested
##############################
khurnaarti.arrested:
	echo
	echo ****************************
	echo ** ARRESTED
	echo ****************************
	echo
	put #echo >Log #FF0000 [khurnaarti] ARRESTED!
	put exit
	put #script abort all except khurnaarti
	put exit
    put #script abort all except khurnaarti
    exit


##############################
##### logout
##############################
logout:
    put exit
    put #script abort all except khurnaarti
    put .reconnect
    put .afk
    pause 1
    put #script abort all except khurnaarti
    put .reconnect
    put .afk
    put exit
    exit