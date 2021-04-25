include libmaster.cmd


var expectedNumBolts thirty-four

action goto logout when eval $health < 50
action goto logout when eval $dead = 1

action send unlock door; send open door when ^(?:Qizhmur's|Khurnaarti's) face appears in the Demrris window.



if_1 then {
    if ("%1" = "fight") then var startAt fight
}


# debug 10


action send pat inauri when ^A soft crackle briefly comes from Inauri's direction.

var burgleCooldown 0
var nextBurgleCheck 0
var injured 0

action var burgleCooldown $1 when ^You should wait at least (\d+) roisaen
action var burgleCooldown 0 when ^A tingling on the back of your neck draws attention to itself by disappearing, making you believe the heat is off from your last break in\.$
action var numBolts $1 when ^You count some basilisk bolts in the \S+ and see there are (\S+) left\.$
action var numArrows $1 when ^You count some basilisk arrows in the \S+ and see there are (\S+) left\.$
action send stand when ^You'll have to move off the sandpit first.

action put whisper inauri teach $1 when ^Inauri stops trying to teach (.*) to you.$


action var playerName $1; var buffSpell $2; goto buffPlayer when ^(Inauri|Qizhmur|Khurnaarti) whispers, "(?:C|c)ast (\S+)"


timer start

if ("%startAt" = "fight") then goto startFight

main:
    gosub abortScripts
    gosub resetState
    gosub checkBurgleCd

    if (%burgleCooldown = 0) then {
        put #echo >Log #cc99ff Train: Going to burgle

        gosub moveToBurgle

        if ($SpellTimer.InvocationoftheSpheres.active != 1 || $SpellTimer.InvocationoftheSpheres.duration < 10) then {
            gosub release rf
            gosub runScript iots dis
        }

        gosub prep rf

        put .armor remove
        waitforre ^ARMOR DONE$

        gosub cast

        put .burgle
        waitforre ^BURGLE DONE$

        #gosub release rf

        put .armor wear
        waitforre ^ARMOR DONE$

        gosub automove n gate

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
    if ($bleeding = 1 || $Warding.LearningRate < 20 || $Utility.LearningRate < 20 || $Augmentation.LearningRate < 20 || $Arcana.LearningRate < 20 || $Sorcery.LearningRate < 2) then {
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
    #if ($bleeding = 1) then goto startMagic
    #if ($Evasion.LearningRate < 20 || $Shield_Usage.LearningRate < 20 || $Parry_Ability.LearningRate < 20 || $Targeted_Magic.LearningRate < -1 || $Light_Thrown.LearningRate < 20 || $Brawling.LearningRate < 20 || $Small_Edged.LearningRate < 20) then {
	    put #echo >Log #cc99ff Moving to combat
	    gosub moveToWyverns
	    put .fight
	    gosub waitForMainCombat
	    goto main
    #}


    # Backtrain
    if (false) then {
        #if ($Heavy_Thrown.LearningRate < 10) then {
        put #echo >Log #0099ff Moving to backtrain
        gosub moveToGremlins
        put .fight backtrain
        gosub waitForBacktrain
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
    pause 1
    put #script abort all except selesthiel
    put .reconnect
    goto magicCont


abortScripts:
    put #script abort all except selesthiel
    put .reconnect
    pause 1
    put #script abort all except selesthiel
    put .reconnect
    pause .2
    gosub stow right
    gosub stow left
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



getHealed:
    gosub checkHealth
    if (%injured = 1) then {
        if (contains("$roomplayers", "Inauri")) then {
	        gosub whisper inauri heal
	        pause 30
        } else {
            if (!($lastHealedGametime > -1)) then put #var lastHealedGametime 0
            eval nextHealTime (300 + $lastHealedGametime)

            if ($bleeding = 1 && $gametime > %nextHealTime) then {
	            put .house
	            waitforre ^HOUSE DONE$

	            gosub automove portal
	            if ($SpellTimer.RefractiveField.active = 1) then gosub release rf
	            gosub move go meeting portal

	            gosub automove heal
	            put join list
	            matchre getHealedCont Yrisa crosses Selesthiel's name from the list.
	            matchwait 120

	            getHealedCont:
	            put #var lastHealedGametime $gametime
	            gosub automove portal
	            gosub move go exit portal
	            gosub moveToMagic
            }
        }
    }
    return


checkHealth:
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
    gosub release spell
    gosub runScript cast %buffSpell %playerName
    put .selesthiel



moveToBurgle:
    if ($SpellTimer.RefractiveField.duration < 2) then {
        gosub prep rf
        pause 3
        gosub cast
    }
    if ("$roomname" = "Private Home Interior") then {
        gosub runScript house
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

    # Shard East Gate Area
    if ("$zoneid" = "66") then {
        if ("$roomid" != "252") then gosub automove 252
        gosub runScript house
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

    # FC
    if ("$zoneid" = "150") then {
        gosub automove portal
        gosub move go exit portal
        goto moveToMagic
    }

    goto moveToMagic



moveToWyverns:
    if ($SpellTimer.RefractiveField.duration < 2) then {
        gosub prep rf
        pause 3
        gosub cast
    }
    if ("$roomname" = "Private Home Interior") then {
        gosub runScript house
        goto moveToWyverns
    }

    # Shard West Gate Area
    if ("$zoneid" = "69") then {
        put .findSpot wyvern
        waitforre ^FINDSPOT DONE$
        return
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
    put #script abort all except selesthiel
    put .reconnect
    pause 1
    put #script abort all except selesthiel
    put .reconnect
    if ("$righthandnoun" = "lockbow" || "$righthandnoun" = "crossbow") then gosub unload my $righthandnoun
    gosub stow right
    gosub stow left
    gosub retrieveBolts
    gosub stow hhr'ata
    gosub stow bola
    gosub prep rf
    pause 3
    gosub cast
    gosub moveToMagic
    gosub getHealed
    put #script abort all except selesthiel
    put .reconnect
    put .selesthiel
    exit


resetState:
    if ("$righthandnoun" = "compendium" || "$lefthandnoun" = "compendium") then gosub put my compendium in my bag
    if ("$righthandnoun" = "telescope" || "$lefthandnoun" = "telescope") then gosub put my telescope in my bag
    gosub stow right
    gosub stow left
    gosub release spell
    gosub release mana
    #gosub release symbi
    gosub release shear
    gosub release cyclic
    gosub retrieveBolts
    gosub stow hhr'ata
    gosub stow bola
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


waitForBurgleCd:
    if (%nextBurgleCheck < %t) then {
        put #script abort all except selesthiel
        put .reconnect
        gosub stow right
        gosub stow left
        gosub checkBurgleCd
    }
    if (%burgleCooldown = 0) then return
    pause 2
    goto waitForBurgleCd



waitForMagic:
    pause 2
    if (%nextBurgleCheck < %t) then {
        put #script abort all except selesthiel
        gosub stow right
        gosub stow left
        gosub checkBurgleCd
        put .magic
        pause 1
    }

    if (%burgleCooldown = 0 || ($Warding.LearningRate > 29 && $Utility.LearningRate > 29 && $Augmentation.LearningRate > 29 && $Arcana.LearningRate > 29)) then {
        put #script abort all except selesthiel
        gosub resetState
        return
    }

    goto waitForMagic



waitForMainCombat:
    pause 2
    if ($bleeding = 1) then goto moveToHeal
    if (%nextBurgleCheck < %t) then {
        put #script abort all except selesthiel
        put .reconnect
        pause 1
        put #script abort all except selesthiel
        put .reconnect
        gosub stow right
        gosub stow left
        gosub checkBurgleCd
        put .fight
        pause 1
    }
    if (%burgleCooldown = 0 || ($Crossbow.LearningRate > 29 && $Small_Edged.LearningRate > 29 && $Brawling.LearningRate > 29 && $Light_Thrown.LearningRate > 29 && $Parry_Ability.LearningRate > 29 && $Shield_Usage.LearningRate > 29 && $Evasion.LearningRate > 29)) then {
    #if (%burgleCooldown = 0 || ($Crossbow.LearningRate > 29 && $Small_Edged.LearningRate > 29 && $Targeted_Magic.LearningRate > 29 && $Brawling.LearningRate > 29 && $Light_Thrown.LearningRate > 29 && $Parry_Ability.LearningRate > 29 && $Shield_Usage.LearningRate > 29 && $Evasion.LearningRate > 29)) then {
    #if (%burgleCooldown = 0 || ($Warding.LearningRate < 1 || $Utility.LearningRate < 1 || $Augmentation.LearningRate < 1 || $Arcana.LearningRate < 1)) then {
        put #script abort all except selesthiel
        put .reconnect
        pause 1
        put #script abort all except selesthiel
        if ("$righthandnoun" = "lockbow" || "$righthandnoun" = "crossbow") then gosub unload my $righthandnoun
        gosub stow right
        gosub stow left
        gosub retrieveBolts
        gosub stow hhr'ata
        gosub stow bola
        return
    }
    if (!contains("$scriptlist", "fight.cmd")) then put .fight
    goto waitForMainCombat


logout:
    put exit
    put #script abort all except selesthiel
    put .reconnect
    pause 1
    put #script abort all except selesthiel
    put .reconnect
    put exit
    exit