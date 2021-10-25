#include libmaster.cmd
include libtrain.cmd

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

gosub burgle.setNextBurgleAt

#gosub train.waitForRepair

if (%startPerform = 1) then {
    gosub moveToHouse
    gosub performance
}

main:
    if (%useBurgle = 1 && $lib.timers.nextBurgleAt < $gametime) then gosub burgle.setNextBurgleAt

    if (%useBurgle = 1 &&  $lib.timers.nextBurgleAt < $gametime) then {
        put #echo >Debug BURGLE TIMER, GOING BURGLE
		gosub train.burgle
		gosub train.getHealed
		gosub runScript house
		#gosub runScript repair --noWait=1
		gosub runScript getClericTools
        gosub clericRituals
        gosub train.moveToHouse
        gosub train.performance
        if ($First_Aid.LearningRate < 20) then gosub runScript compendium
        gosub train.getHealed

        pause 1
        put .izqhhrzu
        put .reconnect
        put .afk
    }

    if ($SpellTimer.PersistenceofMana.active != 1) then {
        gosub train.moveToHouse
        gosub clericRituals
    }

    if ($Performance.LearningRate < 10) then gosub train.performance


    startFight:
    if ($Targeted_Magic.LearningRate < 25 || $Brawling.LearningRate < 25 || $Polearms.LearningRate < 25 || $Large_Edged.LearningRate < 25 || $Crossbow.LearningRate < 25 || $Heavy_Thrown.LearningRate < 25 || $Light_Thrown.LearningRate < 25 || $Staves.LearningRate < 25 || $Slings.LearningRate < 25 || $Evasion.LearningRate < 25 || $Shield_Usage.LearningRate < 25 || $Parry_Ability.LearningRate < 25) then {
        gosub train.getHealed
        if ("$roomname" = "Private Home Interior" || $zoneid = 150) then {
			if ($SpellTimer.MurrulasFlames.active != 1 || $SpellTimer.MurrulasFlames.duration < 45) then gosub runScript cast mf
			if ($SpellTimer.OsrelMeraud.active = 1 && $SpellTimer.OsrelMeraud.duration < 90) then gosub runScript cast om orb
			if ($SpellTimer.MajorPhysicalProtection.active != 1 || $SpellTimer.MajorPhysicalProtection.duration < 30) then gosub runScript cast mapp
			if ($SpellTimer.Benediction.active != 1 || $SpellTimer.Benediction.duration < 30) then gosub runScript cast benediction
			if ($SpellTimer.ShieldofLight.active != 1 || $SpellTimer.ShieldofLight.duration < 30) then gosub runScript cast sol
			if ($SpellTimer.MinorPhysicalProtection.active != 1 || $SpellTimer.MinorPhysicalProtection.duration < 30) then gosub runScript cast mpp
        }
        put #echo >Log #cc99ff Going to main combat
        gosub train.moveToWarklin
        put .fight
        gosub waitForMainCombat
        goto main
    }



    startMagic:
    put #echo >Log #cc99ff Going to magic
    gosub train.moveToHouse

    if ("$roomname" != "Private Home Interior") then {
        put #echo >Log #cc99ff House won't open, going to FC
        gosub train.moveToMagic
    }

    gosub listen to Selesthiel
    gosub listen to Inauri observe
    put .reconnect
    put .afk

    gosub runScript caracal

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
        echo
        echo DONE WITH COMBAT!
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

