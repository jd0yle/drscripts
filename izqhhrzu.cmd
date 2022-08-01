#include libmaster.cmd
include libtrain.cmd

action put .izqhhrzu when ^A guard appears and says

gosub awake
var useBurgle 1
put #tvar powerwalk 0
put .reconnect
put .afk

if ($standing != 1) then gosub stand

if ($health < 80 && "$roomname" != "Private Home Interior") then goto train.getHealedTrigger

if_1 then {
    if ("%1" = "fight") then {
        goto startFight
    }
    if ("%1" = "magic") then {
        goto startMagic
    }
    if ("%1" = "perform") then {
        var startPerform 1
    }
}

put #tvar char.fight.backtrain 0

gosub burgle.setNextBurgleAt

gosub burgle recall

pause 2

gosub awake

#gosub train.waitForRepair

if (%startPerform = 1) then {
    gosub moveToHouse
    gosub performance
}

main:
    #if (%useBurgle = 1 && $lib.timers.nextBurgleAt < $gametime) then gosub burgle.setNextBurgleAt

    if (%useBurgle = 1 &&  $lib.timers.nextBurgleAt < $gametime) then {
		gosub train.burgle
		gosub runScript getClericTools
        gosub train.getHealed
		gosub runScript house
		#gosub runScript repair --noWait=1

        gosub clericRituals
        gosub train.moveToHouse
        gosub train.performance 5
        if ($First_Aid.LearningRate < 0) then {
            put #echo >Log #0033CC Start First Aid: $First_Aid.LearningRate/34
            gosub runScript compendium --target=10
            put #echo >Log #0033CC End First Aid: $First_Aid.LearningRate/34
        } else {
            put #echo >Log #0033CC SKIPPING First Aid: $First_Aid.LearningRate/34
        }
        #gosub train.compendium 30
        gosub train.getHealed

		#gosub train.moveToHouse

        pause 1
        put .izqhhrzu
        put .reconnect
        put .afk
    }

    if ($SpellTimer.PersistenceofMana.active != 1) then {
        gosub train.moveToHouse
        gosub clericRituals
    }

    var useBacktrain 1

    startFight:
    #if (%useBacktrain = 0 || $Targeted_Magic.LearningRate < 25 || $Brawling.LearningRate < 25 || $Polearms.LearningRate < 25 || $Large_Edged.LearningRate < 25 || $Crossbow.LearningRate < 25 || $Heavy_Thrown.LearningRate < 25 || $Light_Thrown.LearningRate < 25 || $Slings.LearningRate < 25 || $Evasion.LearningRate < 25 || $Shield_Usage.LearningRate < 25 || $Parry_Ability.LearningRate < 25) then {
    # NO Parry
    #if (%useBacktrain = 0 || $Targeted_Magic.LearningRate < 25 || $Brawling.LearningRate < 25 || $Polearms.LearningRate < 25 || $Large_Edged.LearningRate < 25 || $Crossbow.LearningRate < 25 || $Heavy_Thrown.LearningRate < 25 || $Light_Thrown.LearningRate < 25 || $Slings.LearningRate < 25 || $Evasion.LearningRate < 25 || $Shield_Usage.LearningRate < 25) then {
    if (%useBacktrain = 0 || $Targeted_Magic.LearningRate < 20 || $Brawling.LearningRate < 20 || $Polearms.LearningRate < 20 || $Large_Edged.LearningRate < 20 || $Crossbow.LearningRate < 20 || $Heavy_Thrown.LearningRate < 20 || $Light_Thrown.LearningRate < 20 || $Slings.LearningRate < 20 || $Evasion.LearningRate < 20 || $Shield_Usage.LearningRate < 20) then {
        put #echo >Log #0033CC Start combat
        gosub train.getHealed
        if ("$roomname" = "Private Home Interior" || $zoneid = 150) then {
            gosub release cyclic
            if ($mana < 80) then gosub waitForMana 80
			if ($SpellTimer.MurrulasFlames.active != 1 || $SpellTimer.MurrulasFlames.duration < 45) then gosub runScript cast mf

			if ($mana < 80) then gosub waitForMana 80
			if ($SpellTimer.OsrelMeraud.active = 1 && $SpellTimer.OsrelMeraud.duration < 75) then gosub runScript cast om orb

			if ($mana < 80) then gosub waitForMana 80
			if ($SpellTimer.MajorPhysicalProtection.active != 1 || $SpellTimer.MajorPhysicalProtection.duration < 30) then gosub runScript cast mapp

			if ($mana < 80) then gosub waitForMana 80
			if ($SpellTimer.Benediction.active != 1 || $SpellTimer.Benediction.duration < 30) then gosub runScript cast benediction

			if ($mana < 80) then gosub waitForMana 80
			if ($SpellTimer.ShieldofLight.active != 1 || $SpellTimer.ShieldofLight.duration < 30) then gosub runScript cast sol

			if ($mana < 80) then gosub waitForMana 80
			if ($SpellTimer.MinorPhysicalProtection.active != 1 || $SpellTimer.MinorPhysicalProtection.duration < 30) then gosub runScript cast mpp
        }
        put #echo >Log #838700 Going to main combat
        gosub train.moveToWyverns
        #gosub train.moveToJuvenileWyverns
        #gosub train.moveToTelgas
        put .fight
        gosub waitForMainCombat
        goto main
    } else {
        put #echo >Debug SKIPPED FIGHTING! CHECK WTF IS UP
        echo if (%useBacktrain = 0 || %$Targeted_Magic.LearningRate < 25 || $Brawling.LearningRate < 25 || $Polearms.LearningRate < 25 || $Large_Edged.LearningRate < 25 || $Crossbow.LearningRate < 25 || $Heavy_Thrown.LearningRate < 25 || $Light_Thrown.LearningRate < 25 || $Slings.LearningRate < 25 || $Evasion.LearningRate < 25 || $Shield_Usage.LearningRate < 25 || $Parry_Ability.LearningRate < 25) then {
    }


    # Backtrain
    startBacktrain:
    #if ($First_Aid.LearningRate < 30) then {
        put #echo >Log #838700 Moving to backtrain
        #gosub train.moveToCloudRats
        gosub train.moveToShardBulls
        put #tvar char.fight.backtrain 1
        put .fight backtrain
        gosub waitForBacktrain
        put #tvar char.fight.backtrain 0
        goto main
    #}

    goto main


    startMagic:
    put #echo >Log #838700 Going to magic
    gosub train.moveToHouse

    if ("$roomname" != "Private Home Interior") then {
        put #echo >Log #cc99ff House won't open, going to FC
        gosub train.moveToMagic
    }

    gosub listen to Selesthiel
    gosub listen to Inauri observe
    put .reconnect
    put .afk

    #gosub runScript caracal

    put .magic
    gosub waitForMagic
    goto main



clericRituals:
    put #echo >Log #cc99ff Moving to house for rituals
    gosub train.moveToHouse
    gosub runScript countClericTools

	var skipInventory 1

    if (%skipInventory != 1 && $char.inventory.numIncense < 10) then {
        put #echo >Log #cc99ff Buying incense
        gosub stow right
        gosub stow left
        if ("$roomname" = "Private Home Interior") then gosub runScript house
        gosub runScript travel crossing
        gosub automove teller
        gosub withdraw 1 silver
        gosub automove brother
        put order incense
        pause
        put offer 62
        pause
        gosub put my incense in my $char.storage.incense
    }

    if (%skipInventory != 1 && $char.inventory.numHolyWater < 1) then {
        put #echo >Log #cc99ff Buying holy water
        gosub stow right
        gosub stow left
        if ("$roomname" = "Private Home Interior") then gosub runScript house
        gosub runScript travel crossing
        gosub automove temple
        gosub automove holy water
        gosub get my witch jar
        put fill my witch jar with water from basin
        gosub stow my witch jar
        gosub automove crossing
    }
    put #echo >Log #cc99ff Moving to cast PoM
	gosub train.moveToHouse
    gosub stow right
    gosub stow left
    gosub runScript cast pom
    gosub stand
    gosub runScript devotion
    gosub stand

    return


waitForBacktrain:
    pause 2
    put #script abort all except izqhhrzu
    put .reconnect
    put .afk
    pause 1
    put #script abort all except izqhhrzu
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
        put #script abort all except izqhhrzu
        put .reconnect
        put .afk
        pause 1
        put #script abort all except izqhhrzu
        put .reconnect
        put .afk
        if ($bleeding = 1) then goto moveToHeal
        return
    }
    put #tvar char.fight.backtrain 1
    if (!contains("$scriptlist", "fight.cmd")) then put .fight
    pause 2
    goto waitForBacktrainLoop


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
        gosub stow hhr'ata
        gosub stow bola
        gosub stow matte sphere
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
    #gosub getLowestLearningRateFromList $char.fight.weapons.skills|Evasion|Parry_Ability|Shield_Usage
    # NO PARRY
    gosub getLowestLearningRateFromList $char.fight.weapons.skills|Evasion|Shield_Usage
    var tmpLowestLearningRate %returnVal

    #if ($lib.timers.nextBurgleAt < $gametime || ($Targeted_Magic.LearningRate > 25 && $Polearms.LearningRate > 30 && $Brawling.LearningRate > 30 && $Large_Edged.LearningRate > 30 && $Crossbow.LearningRate > 30 && $Heavy_Thrown.LearningRate > 30 && $Light_Thrown.LearningRate > 30 && $Slings.LearningRate > 30 && $Evasion.LearningRate > 30 && $Shield_Usage.LearningRate > 30 && $Parry_Ability.LearningRate > 30)) then {
    if ($lib.timers.nextBurgleAt < $gametime || %tmpLowestLearningRate > 30) then {
        echo
        echo DONE WITH COMBAT!
        put #echo >Log #999900 DONE WITH COMBAT, lowest LR=%tmpLowestLearningRate
        echo burgle $lib.timers.nextBurgleAt < $gametime
        echo ($Targeted_Magic.LearningRate > 25 && $Polearms.LearningRate > 30 && $Brawling.LearningRate > 30 && $Large_Edged.LearningRate > 30 && $Crossbow.LearningRate > 30 && $Heavy_Thrown.LearningRate > 30 && $Light_Thrown.LearningRate > 30 && $Staves.LearningRate > 30 && $Slings.LearningRate > 30 && $Twohanded_Edged.LearningRate > 30 && $Evasion.LearningRate > 30 && $Shield_Usage.LearningRate > 30 && $Parry_Ability.LearningRate > 30)
        echo
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
        gosub stow hhr'ata
        gosub stow bola
        gosub stow matte sphere
        gosub stow right
        gosub stow left
        return
    }
    pause 2
    goto waitForMainCombatLoop




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

