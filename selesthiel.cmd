include libmaster.cmd

put .afk

var expectedNumBolts twenty

#action goto logout when eval $health < 50
action goto logout when eval $dead = 1

action (health) goto getHealedTrigger when eval $health < 85
action (health) goto getHealedTrigger when eval $bleeding = 1
action (health) goto getHealedTrigger when ^TESTHEAL

action send unlock door; send open door when ^(?:Qizhmur's|Khurnaarti's|Izqhhrzu's) face appears in the

action send stop teach when ^Inauri stops listening to you.

action send listen to $1 when ^(\S+) begins to lecture

action send release rf;send go portal when ^But no one can see you
action send release rf;send rummage my shadows when ^You feel about some dark encompassing shadows of twilight dreamweave\.$


if_1 then {
    if ("%1" = "fight") then var startAt fight
}


# debug 10


action send pat inauri when ^A soft crackle briefly comes from Inauri's direction.

var injured 0

action var numBolts $1 when ^You count some basilisk bolts in the \S+ and see there are (\S+) left\.$
action var numArrows $1 when ^You count some basilisk arrows in the \S+ and see there are (\S+) left\.$
action send stand when ^You'll have to move off the sandpit first.

action put whisper inauri teach $1 when ^Inauri stops trying to teach (.*) to you.$


action var playerName $1; var buffSpell $2; goto buffPlayer when ^(Inauri|Qizhmur|Khurnaarti) whispers, "(?:C|c)ast (\S+)"


timer start

if ($health < 80 && "$roomname" != "Private Home Interior") then goto getHealedTrigger

if ("%startAt" = "fight") then goto startFight

main:
    gosub abortScripts
    gosub resetState
    gosub burgle.setNextBurgleAt
    pause 2

    if ($lib.timers.nextBurgleAt < $gametime) then {
        put #echo >Log #cc99ff Train: Going to burgle

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

        put .dep
        waitforre ^DEP DONE$
        gosub move up
        gosub move out
        gosub cast
    }





    # Magic
    startMagic:
    if ($bleeding = 1 || $Warding.LearningRate < 25 || $Utility.LearningRate < 25 || $Augmentation.LearningRate < 25 || $Arcana.LearningRate < 25 || $Sorcery.LearningRate < 3) then {
        put #echo >Log #0099ff Moving to magic
        gosub moveToMagic
        gosub getHealed

        gosub runScript fixInventory

        if ($Sorcery.LearningRate < 2) then {
            gosub remove my flame
            gosub clean my flame
            gosub wear my flame

            put .research sorcery
            waitforre ^RESEARCH DONE$
            gosub getHealed
        }

        put #echo >Log #00ffff Magic start - Warding: $Warding.LearningRate/34
        put .magic
        gosub waitForMagic
        put #echo >Log #00ffff Magic End - Warding: $Warding.LearningRate/34
        goto main
    }

    # Main Combat
    startFight:
	    put #echo >Log #cc99ff Moving to combat
	    gosub moveToWyverns
	    put #tvar char.fight.backtrain 0
	    put .fight
	    gosub waitForMainCombat
	    goto main


    # Backtrain
    backtrain:
    if (1 = 0) then {
        put #echo >Log #0099ff Moving to backtrain
        gosub moveToShardBulls
        put #tvar char.fight.backtrain 1
        put .fight backtrain
        gosub waitForBacktrain
        put #tvar char.fight.backtrain 0
        goto main
    }

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
    if (contains("$roomplayers", "Inauri") then {
        if ($Enchanting.LearningRate < 15) then {
            gosub whisper inauri teach enchanting
            #gosub teach tm to inauri
        } else {
            gosub stop teach
            gosub stop listen
            gosub teach tm to inauri
        }
        gosub listen to Inauri
        pause 2
    }

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
        gosub move go portal
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
        gosub runScript findSpot juvenilewyvern
        #gosub runScript findSpot wyvern
        return

        #put .findSpot wyvern
        #waitforre ^FINDSPOT DONE$
        #return
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
    if ($lib.timers.nextBurgleAt < $gametime || ($Warding.LearningRate > 29 && $Utility.LearningRate > 29 && $Augmentation.LearningRate > 29 && $Arcana.LearningRate > 29)) then {
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

waitForMainCombatLoop:
    if ($lib.timers.nextBurgleAt < $gametime || ($Crossbow.LearningRate > 29 && $Small_Edged.LearningRate > 29 && $Brawling.LearningRate > 29 && $Light_Thrown.LearningRate > 29 && $Parry_Ability.LearningRate > 29 && $Shield_Usage.LearningRate > 29 && $Targeted_Magic.LearningRate > 29 && $Evasion.LearningRate > 29)) then {
        gosub resetState
        if ($bleeding = 1) then goto moveToHeal
        return
    }
    put #tvar char.fight.backtrain 0
    if (!contains("$scriptlist", "fight.cmd")) then put .fight
    pause 2
    goto waitForMainCombatLoop


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