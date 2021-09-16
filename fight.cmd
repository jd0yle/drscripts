####################################################################################################
# .fight
# Selesthiel - Justin Doyle - justin@jmdoyle.com
# 2020/05/07
#
# USAGE
# .fight
#
# DEPENDENCIES: libsel.cmd, cast.cmd, loot.cmd
####################################################################################################
include var_mobs.cmd
include libmaster.cmd
include args.cmd


####################################################################################################
# CONFIG
####################################################################################################
var opts %1

var ammo.Crossbow $char.fight.ammo.Crossbow
var ammo.Bow $char.fight.ammo.Bow
var ammo.Sling $char.fight.ammo.Sling

var arrangeForPart $char.fight.arrangeForPart
var arrangeFull $char.fight.arrangeFull

var useArmor $char.fight.useArmor

var avoidDivineOutrage $char.fight.avoidDivineOutrage

var debil.use $char.fight.debil.use
var debil.spell $char.fight.debil.spell
var debil.prepAt $char.fight.debil.prepAt
var forceDebil $char.fight.forceDebil

var forceShield $char.fight.forceShield

var lootType $char.fight.lootType

var necroRitual $char.fight.necroRitual

var opts $char.fight.opts

var tmSpell $char.fight.tmSpell
var tmPrep $char.fight.tmPrep
var tmPause $char.fight.tmPause

var weapons.items $char.fight.weapons.items
var weapons.skills $char.fight.weapons.skills

var useAlmanac $char.fight.useAlmanac
var useAppraise $char.fight.useAppraise
var useBuffs $char.fight.useBuffs
var useHunt $char.fight.useHunt
var usePerc $char.fight.usePerc
var useSanowret $char.fight.useSanowret
var useSkin $char.fight.useSkin
var useStealth $char.fight.useStealth

var useCol $char.fight.useCol
var useMaf $char.fight.useMaf
var useObserve $char.fight.useObserve
var useSeer $char.fight.useSeer
var useShadowling $char.fight.useShadowling
var useShadows $char.fight.useShadows
var useShw $char.fight.useShw
var useSls $char.fight.useSls

var useCh $char.fight.useCh
var useIvm $char.fight.useIvm
var usePhp $char.fight.usePhp
var useQe $char.fight.useQe
var useUsol $char.fight.useUsol


####################################################################################################


var attacks
var doAnalyze 1
var lastAnalyzeTime 0

var nextHuntAt 0
var nextAppAt 0
var nextPercAt 0
var nextRogCastAt 0

var weapons.index 0
eval weapons.length count("%weapons.skills", "|")
var weapons.lastChangeAt 0
var weapons.targetLearningRate 5

var weapons.lastChangeAt $gametime

var armor.index 0
var armor.lastChangeAt 0
var armor.targetLearningRate 5

var stances.list shield|parry
var stances.skills Shield_Usage|Parry_Ability
var stances.targetLearningRate 5
eval stances.length count("%stances.list", "|")
var stances.index 0

var skillsToUseShield Crossbow|Slings|Bow|Twohanded_Blunt|Twohanded_Edged

var debilConditions sleeping|immobilized|writhing|webbed|stunned

#action send adv when ^You must be closer to use tactical abilities on your opponent.
action var doAnalyze 1 when ^Utilizing \S+ tactics
action var doAnalyze 0; var attacks $2 when ^(Balance reduction|Armor reduction|A chance for a stun) can be inflicted.* by landing (.*)
action var doAnalyze 1 when ^You can no longer see openings
action var doAnalyze 1 when You fail to find any
action var doAnalyze 1 when ^ then lies still\.$

action put get my scimitar;put get my assassin blade;put get my sword when ^Wouldn't it be better if you used a melee weapon

action send circle when ^Analyze what

action goto newBundle when ^Where did you intend to put that\?  You don't have any bundles or they're all full or too tightly packed!

timer start

# Sometimes fails to get crossbow? Not sure, hack fix for now. - JD, 4/1/21
action send get %weapons.items(%weapons.index); send load when ^You need to hold the.*in your right hand to load it.

action var useHunt 0 when ^You find yourself unable to hunt in this area.

action var useCollect 0 when any collecting efforts would be futile\.$

action var noAmmo 1 when ^You don't have the proper ammunition readily available

put #trigger {^You are now set to use your (\S+) stance} {#var lastStanceGametime \$gametime;#var stance \$1} {stance}
put #trigger {e/\$stance/} {#statusbar 7 Stance: \$stance} {stance}

action (expMods) var debuffSkills %debuffSkills|$2 when ^--(\d+)\(\d+%\) (.*?) \(\d+ effective ranks\)

###############################
###      init
###############################
init:
    put #class combat on

    #gosub runScript armor wear

    gosub sortWeaponRanks
    gosub sortArmorRanks

    var weapons.lowestLearningRateIndex 0

    ## Start with the weapon with the lowest learning rate
    initLoop:
        # Start with the weapon specified by the command line args, if present
        eval args.startWeapon replace("%args.startWeapon", " ", "_")
        if ("%weapons.skills(%weapons.index)" = "%args.startWeapon") then {
            var weapons.lowestLearningRateIndex %weapons.index
            goto initContinue
        }
        if ($%weapons.skills(%weapons.index).LearningRate < $%weapons.skills(%weapons.lowestLearningRateIndex).LearningRate) then {
            var weapons.lowestLearningRateIndex %weapons.index
        }
        math weapons.index add 1
        if (%weapons.index <= %weapons.length) then goto initLoop
        goto initContinue

    initContinue:
	    var weapons.index %weapons.lowestLearningRateIndex
	    var weapons.targetLearningRate $%weapons.skills(%weapons.index).LearningRate
	    math weapons.targetLearningRate add 5
	    if (%weapons.targetLearningRate > 34) then var weapons.targetLearningRate 34
    goto loop



###############################
###      loop
###############################
loop:
    if ($standing != 1) then gosub stand
    gosub releaseUnwantedSpells

    gosub checkDeadMob
    if ($char.loot.boxes = 1) then {
        gosub runScript loot --boxes=1
    } else {
        gosub runScript loot
    }

    gosub checkWeaponSkills
    gosub checkStances
    if (%useArmor = 1) then gosub checkArmorSkills

    gosub buffs
    gosub manageCyclics
    gosub fight.observe
    gosub huntApp
    if ("$char.fight.usePray" = "1") then gosub pray.onTimer $char.fight.prayTarget

    if (%useAlmanac = 1) then gosub almanac.onTimer
    if (%useSanowret = 1 && $Arcana.LearningRate < 31 && $concentration = 100) then gosub gaze my sanowret crystal

    # Use numMobs so that we can subtract non-combat "pets" (ex: dirt construct, shadow servant, etc.)
    var numMobs $monstercount
    if (contains("$roomobjs", (dirt construct)) then math numMobs subtract 1

    var attackContinue 1
    if (%attackContinue = 1 && %numMobs < 2) then {
        if (%numMobs = 1) then {
            gosub attack circle
            gosub attack bob
        }
        if (%numMobs = 0) then {
            if (%useCollect != 0) then {
                gosub collect dirt
            } else {
                pause 4
            }

            if (contains("$roomobjs", "a pile of")) then {
                gosub kick pile
            }
        }
        var attackContinue 0
    }

    if (%attackContinue = 1 && %numMobs > 0) then {
        var continue = 1
        if (%continue = 1 && "%weapons.skills(%weapons.index)" = "Targeted_Magic") then {
            gosub attackTm
            var continue 0
        }
        if (%continue = 1 && "%weapons.skills(%weapons.index)" = "Light_Thrown" || "%weapons.skills(%weapons.index)" = "Heavy_Thrown") then {
            gosub attackThrownWeapon
            var continue 0
        }
        if (%continue = 1 && ("%weapons.skills(%weapons.index)" = "Crossbow" || "%weapons.skills(%weapons.index)" = "Bow" || "%weapons.skills(%weapons.index)" = "Slings")) then {
            gosub attackCrossbow
            var continue 0
        }

        if (%continue = 1 && "%weapons.skills(%weapons.index)" = "Offhand_Weapon") then {
            if ("$lefthandnoun" != "nightstick") then {
                if ("$righthandnoun" = "nightstick") then {
                    gosub swap
                } else {
                    gosub stow right
                    gosub get nightstick
                    gosub swap
                }
            }
            gosub debil
            gosub attack slice left
            var continue 0
        }

        if (%continue = 1) then {
            #gosub analyze

            if (evalmath($gametime - %lastAnalyzeTime) > 60) then {
                gosub analyze
                var lastAnalyzeTimeAt $gametime
            }
            if (%doAnalyze = 0) then gosub attackAnalyzed
        }

        var attackContinue 0
    }

    goto loop



###############################
###      attackAnalyzed
###############################
attackAnalyzed:
    eval attacks replace("%attacks", " and", ",")
    eval attacks replace("%attacks", "a ", "")
    eval attacks replace("%attacks", "an ", "")
    eval attacks replace("%attacks", ",", "|")
    eval attacks replace("%attacks", ".", "")
    eval attacks replace("%attacks", " ", "")
    eval length count("%attacks", "|")
    var index 0

    gosub debil
    gosub checkHide

	var doOffhand 0
	var offhandWeapons Small_Edged|Small_Blunt|Staves|Heavy_Thrown|Light_Thrown

	if ($char.fight.trainOffhand = 1 && $Offhand_Weapon.LearningRate < 32 && $Offhand_Weapon.LearningRate <= $%weapons.skills(%weapons.index).LearningRate) then {
		if (matchre("%weapons.skills(%weapons.index)", "(%offhandWeapons)")) then var doOffhand 1
		if (%doOffhand = 1 && "$lefthand" = "Empty") then gosub swap
	}

    attackLoop:
        if (%doOffhand = 1) then {
            if (%doOffhand = 1 && "$lefthand" = "Empty") then gosub swap
            gosub attack %attacks(%index) left
        } else {
            gosub attack %attacks(%index)
        }
        math index add 1
        if (%index > %length) then goto attackAnalyzedDone
        goto attackLoop


attackAnalyzedDone:
	if (%doOffhand = 1 && "$lefthand" != "Empty") then gosub swap
	return

###############################
###      attackCrossbow
###############################
attackCrossbow:
    var crossbowRetreat 0
    gosub stance shield

    if ("%weapons.skills(%weapons.index)" = "Crossbow") then {
        var ammo $char.fight.ammo.Crossbow
    }
    if ("%weapons.skills(%weapons.index)" = "Bow") then {
        var ammo $char.fight.ammo.Bow
    }
    if ("%weapons.skills(%weapons.index)" = "Slings") then {
        var ammo $char.fight.ammo.Slings
    }

    if %crossbowRetreat = 1 then gosub retreat
    gosub load my %weapons.items(%weapons.index) with my %ammo
    if %crossbowRetreat = 1 then gosub retreat
    gosub aim
    gosub debil force
    if (%crossbowRetreat = 1) then {
        gosub retreat
        pause 2
        gosub retreat
        pause 2
        gosub retreat
        pause 2
    } else {
        var tmpAimPause $char.fight.aimPauseMin
        if (!(%tmpAimPause > -1)) then var tmpAimPause 4

        # Assume casting a debilitation spell takes 7 seconds (4 to prep and pause, 3 second RT to cast)
        if (matchre("$monsterlist", "(%debilConditions)")) then {
            evalmath tmpAimPause (%tmpAimPause - 7)
        }
        if (%tmpAimPause < 1) then var tmpAimPause 1
        gosub attackCrossbow.aimPause %tmpAimPause
        #pause %tmpAimPause
        #pause 4
    }
    gosub cast
    gosub checkHide
    gosub fire
    return

attackCrossbow.aimPause:
	var tmpAimPause $1
	echo AIMING FOR %tmpAimPause
	matchre return ^You think you have your best shot possible now\.$
	matchwait %tmpAimPause
	return



###############################
###      attackThrownWeapon
###############################
attackThrownWeapon:
    if ("%weapons.items(%weapons.index)" != "Empty") then { # Empty thrown weapons means using throwing blades
        if ("$righthand" != "%weapons.items(%weapons.index)" ) then {
            gosub stow right
            gosub stow left
            gosub stow my %weapons.items(%weapons.index)
            gosub get my %weapons.items(%weapons.index)
        }

        gosub debil
        gosub checkHide

		var doOffhand 0
		var offhandWeapons Small_Edged|Small_Blunt|Staves|Heavy_Thrown|Light_Thrown



		if ($char.fight.trainOffhand = 1 && $Offhand_Weapon.LearningRate < 32 && $Offhand_Weapon.LearningRate <= $%weapons.skills(%weapons.index).LearningRate) then {
			if (matchre("%weapons.skills(%weapons.index)", "(%offhandWeapons)")) then {
				var doOffhand 1
			}
		}

		var throwCommand throw
		if (%doOffhand = 1) then var throwCommand throw left


        if ("$righthandnoun" = "bola" || "$righthandnoun" = "hammer" || "$righthandnoun" = "hhr'ata" || "$righthandnoun" = "pan" || "$righthandnoun" = "wand" || "$righthandnoun" = "naphtha") then {
            if (%doOffhand = 1 && "$lefthand" = "Empty") then gosub swap
            gosub attack %throwCommand
            gosub get %weapons.items(%weapons.index)

            if (%doOffhand = 1 && "$lefthand" = "Empty") then gosub swap
            gosub attack %throwCommand
            gosub get %weapons.items(%weapons.index)
        } else {
            gosub attack lob
            gosub get %weapons.items(%weapons.index)
            gosub attack lob
            gosub get %weapons.items(%weapons.index)
        }
        if ("$righthand" != "%weapons.items(%weapons.index)" ) then {
            if ("$lefthand" = "%weapons.items(%weapons.index)") then {
                gosub swap
            } else {
                gosub get my %weapons.items(%weapons.index)
            }
        }
    } else {
        if (!contains("$righthand", "throwing blade")) then gosub stow right
        gosub get throwing blades
        gosub debil
        gosub checkHide
        gosub attack throw
        if ("$righthand" != "Empty") then {
            gosub attack throw
        }
    }
    return



###############################
###      attackTm
###############################
attackTm:
    if ($mana > 80) then {
	    gosub target %tmSpell %tmPrep
	    gosub checkHide
	    pause %tmPause
	    gosub cast
    } else {
        pause 2
    }
    return



###############################
###      buffs
###############################
buffs:
    if (%useBuffs = 0) then return
    if ($mana < 30) then return

    # GENERAL
    if ($char.fight.useMaf = 1 && ($SpellTimer.ManifestForce.active = 0 || $SpellTimer.ManifestForce.duration < 3)) then {
        gosub runScript cast maf
        return
    }

    # CLERIC
    if ($char.fight.useOm = 1 && $SpellTimer.OsrelMeraud.active = 1 && $SpellTimer.OsrelMeraud.duration < 50) then {
        gosub runScript cast om orb
        return
    }
    if ($char.fight.useBenediction = 1 && ($SpellTimer.Benediction.active != 1 || $SpellTimer.Benediction.duration < 2)) then {
        gosub runScript cast benediction
        return
    }
    if ($char.fight.useMapp = 1 && ($SpellTimer.MajorPhysicalProtection.active != 1 || $SpellTimer.MajorPhysicalProtection.duration < 3)) then {
        gosub runScript cast mapp
        return
    }
    if ($char.fight.useMpp = 1 && ($SpellTimer.MinorPhysicalProtection.active != 1 || $SpellTimer.MinorPhysicalProtection.duration < 3)) then {
        gosub runScript cast mpp
        return
    }
    if ($char.fight.useMf = 1 && $SpellTimer.MurrulasFlames.active != 1) then {
        gosub runScript cast mf
        return
    }
    if ($char.fight.usePfe = 1 && ($SpellTimer.ProtectionfromEvil.active != 1 || $SpellTimer.ProtectionfromEvil.duration < 3)) then {
        gosub runScript cast pfe
        return
    }
    if ($char.fight.useSap = 1 && ($SpellTimer.SanctifyPattern.active != 1 || $SpellTimer.SanctifyPattern.duration < 2)) then {
        gosub runScript cast sap debilitation
        return
    }
    if ($char.fight.useSol = 1 && ($SpellTimer.ShieldofLight.active != 1 || $SpellTimer.ShieldofLight.duration < 2)) then {
        gosub runScript cast sol
        return
    }


    # MOON MAGE
    if ($char.fight.useSeer = 1 && ($SpellTimer.SeersSense.active = 0 || $SpellTimer.SeersSense.duration < 3)) then {
        gosub runScript cast seer
        return
    }
    if ($char.fight.useCol = 1 && ($SpellTimer.CageofLight.active = 0 || $SpellTimer.CageofLight.duration < 3)) then {
        gosub buffCol
        return
    }
    if ($char.fight.useShadowling = 1 && $SpellTimer.Shadowling.active = 0) then {
        gosub runScript cast shadowling
        return
    }
    if ($char.fight.useShadows = 1 && ($SpellTimer.Shadows.active = 0 || $SpellTimer.Shadows.duration < 2)) then {
        gosub runScript cast shadows
        return
    }

    # NECROMANCER
    if ($char.fight.usePhp = 1 && %avoidDivineOutrage != 1 && ($SpellTimer.PhilosophersPreservation.active != 1 || $SpellTimer.PhilosophersPreservation.duration < 3)) then {
        gosub runScript cast php
        return
    }
    if ($char.fight.useObf = 1 && ($SpellTimer.Obfuscation.active != 1 || $SpellTimer.Obfuscation.duration < 2)) then {
        gosub runScript cast obf
        return
    }
    if ($char.fight.useCh = 1 &&  %avoidDivineOutrage != 1 && ($SpellTimer.CalcifiedHide.active != 1 || $SpellTimer.CalcifiedHide.duration < 3)) then {
        gosub runScript cast ch
        return
    }
    if ($char.fight.useIvm = 1 && %avoidDivineOutrage != 1 && $SpellTimer.IvoryMask.active != 1 && "%weapons.skills(%weapons.index)" = "Targeted_Magic") then {
        gosub runScript cast ivm
        return
    }
    if ($char.fight.useQe = 1 && $SpellTimer.QuickentheEarth.active != 1) then {
        gosub runScript cast qe
        return
    }

    # RANGER
    if ($char.fight.useInst = 1 && ($SpellTimer.Instinct.active != 1 || $SpellTimer.Instinct.duration < 2)) then {
        gosub runScript cast inst
        return
    }
    if ($char.fight.useStw = 1 && $SpellTimer.SeetheWind.active = 0) then {
        gosub runScript cast stw
        return
    }

    return



###############################
###      buffCol
###############################
buffCol:    
    if ($Time.isKatambaUp = 1) then {
        put .cast col katamba
        waitforre ^CAST DONE
        return
    }

    if ($Time.isXibarUp = 1) then {
        put .cast col xibar
        waitforre ^CAST DONE
        return
    }

    if ($Time.isYavashUp = 1) then {
        put .cast col yavash
        waitforre ^CAST DONE
        return
    }
    return



###############################
###      checkArmorSkills
###############################
checkArmorSkills:
    if (!(%armorIndex > -1)) then var armorIndex 0
    var tmpArmorSkill $char.fight.armor.skill.%armorIndex

	if (!($char.fight.lastArmorSwapGametime > -1)) then put #tvar char.fight.lastArmorSwapGametime 1
	evalmath fight.tmp.nextArmorSwapGametime ($char.fight.lastArmorSwapGametime + 300)

    if ($%tmpArmorSkill(0).LearningRate >= %armor.targetLearningRate && (%armor.targetLearningRate < 34 || $gametime > %fight.tmp.nextArmorSwapGametime)) then {
		put #echo >Log [fight] Swap armor %tmpArmorSkill $%tmpArmorSkill(0).LearningRate / 34
		gosub checkArmorSkills.removeArmor $char.fight.armor.items.%armorIndex
		math armorIndex add 1
		if (contains("$char.fight.armor.skill.%armorIndex", "char.fight.armor")) then var armorIndex 0
		var tmpArmorSkill $char.fight.armor.skill.%armorIndex
		gosub checkArmorSkills.wearArmor $char.fight.armor.items.%armorIndex
		evalmath armor.targetLearningRate ($%tmpArmorSkill.LearningRate + 5)
		if (%armor.targetLearningRate > 34) then var armor.targetLearningRate 34
		put #tvar char.fight.lastArmorSwapGametime $gametime
    }

    put #statusbar 8 Armor: %tmpArmorSkill $%tmpArmorSkill(0).LearningRate/%armor.targetLearningRate
    unvar tmpArmorSkill
    unvar fight.tmp.nextArmorSwapGametime

    return


checkArmorSkills.removeArmor:
	var armorItems $0
	var tmpRemoveArmorIndex 0

	checkArmorSkills.removeArmor.loop:
		gosub retreat
		gosub remove my %armorItems(%tmpRemoveArmorIndex)
		gosub stow my %armorItems(%tmpRemoveArmorIndex)
		math tmpRemoveArmorIndex add 1
		if (%tmpRemoveArmorIndex > count("%armorItems", "|")) then {
			unvar armorItems
			unvar tmpRemoveArmorIndex
			return
		}
		goto checkArmorSkills.removeArmor.loop


checkArmorSkills.wearArmor:
	var armorItems $0
	var tmpWearArmorIndex 0

	checkArmorSkills.wearArmor.loop:
		gosub retreat
		gosub get my %armorItems(%tmpWearArmorIndex)
		gosub wear my %armorItems(%tmpWearArmorIndex)
		math tmpWearArmorIndex add 1
		if (%tmpWearArmorIndex > count("%armorItems", "|")) then {
			unvar armorItems
			unvar tmpWearArmorIndex
			return
		}
		goto checkArmorSkills.wearArmor.loop


###############################
###      checkWeaponSkills
###############################
checkWeaponSkills:
    # TM CYCLICS
    if ("%weapons.skills(%weapons.index)" = "Targeted_Magic") then {
        # Figure out if we're using a cyclic for TM, and if so, skip over TM
        var useTmCyclic 0
        if (%useUsol = 1) then var useTmCyclic 1
        if (%useSls = 1 && $Time.isDay = 0) then var useTmCyclic 1

        if ("$charactername" = "Selesthiel") then var useTmCyclic 1

        if (%useTmCyclic = 1) then gosub checkWeaponSkills.nextWeapon
    }

    if (%noAmmo = 1 && "%weapons.skills(%weapons.index)" = "Crossbow") then gosub checkWeaponSkills.nextWeapon

    evalmath timeSinceLastWeaponChange ($gametime - %weapons.lastChangeAt)

    if ($%weapons.skills(%weapons.index).LearningRate >= %weapons.targetLearningRate || %timeSinceLastWeaponChange > 300) then {
        # By default, don't switch weapons faster than once every 30 seconds.
        # But if all the weapon skills are moving, wait 60 seconds before swapping

        #var timeBetweenWeaponSwaps 30
        #if (%weapons.targetLearningRate > 10) then var timeBetweenWeaponSwaps 60
        #evalmath changeWeaponAt %weapons.lastChangeAt + %timeBetweenWeaponSwaps
        #if ($gametime > %changeWeaponAt) then gosub checkWeaponSkills.nextWeapon

        gosub checkWeaponSkills.nextWeapon
    }

    var handItem $righthand
    if ("%handItem" = "white ironwood nightstick") then var handItem white nightstick

    if ("%handItem" != "%weapons.items(%weapons.index)") then {
        gosub stow right
        gosub stow left
        if ("%weapons.items(%weapons.index)" != "Empty" && "%weapons.skills(%weapons.index)" != "Targeted_Magic") then {
            gosub get my %weapons.items(%weapons.index)

            if ("$righthand" = "Empty") then gosub remove my %weapons.items(%weapons.index)

            if ($char.fight.useBless = 1) then {
                gosub prep bless
                gosub charge my $char.cambrinth 5
                gosub invoke my $char.cambrinth 5

                # For ranged weapons, bless the ammo, not the weapon
                var blessTarget none
                if ("%blessTarget" = "none" && "%weapons.skills(%weapons.index)" = "Crossbow") then var blessTarget $char.fight.ammo.Crossbow
                if ("%blessTarget" = "none" && "%weapons.skills(%weapons.index)" = "Bow") then var blessTarget $char.fight.ammo.Bow
                if ("%blessTarget" = "none" && "%weapons.skills(%weapons.index)" = "Slings") then var blessTarget $char.fight.ammo.Slings
                if ("%blessTarget" = "none") then var blessTarget %weapons.items(%weapons.index)
                gosub cast my %blessTarget
                unvar blessTarget
            }
        } else {
            # Bless self for brawling
            if ($char.fight.useBless = 1 && ($SpellTimer.Bless.active !=1 || $SpellTimer.Bless.duration < 3)) then {
                gosub prep bless
                gosub charge my $char.cambrinth 5
                gosub invoke my $char.cambrinth 5
                gosub cast
            }
        }
    }

    if ("%weapons.items(%weapons.index)" = "bastard sword") then gosub checkWeaponSkills.swapWeapon

    if ("%weapons.skills(%weapons.index)" = "Crossbow" && $char.fight.wornCrossbow = 1) then gosub remove my %weapons.items(%weapons.index)

    put #statusbar 6 Weapon: %weapons.skills(%weapons.index) $%weapons.skills(%weapons.index).LearningRate/%weapons.targetLearningRate

    #if ("%weapons.skills(%weapons.index)" = "Crossbow" || "%weapons.skills(%weapons.index)" = "Bow" || "%weapons.skills(%weapons.index)" = "Slings") then gosub stance shield
    if (matchre("%weapons.skills(%weapons.index)", "(%skillsToUseShield)")) then {
        gosub stance shield
    }

    return



checkWeaponSkills.nextWeapon:
    var logMsg [fight.cmd] nextWeapon %weapons.skills(%weapons.index) ($%weapons.skills(%weapons.index).LearningRate/34) ->
    math weapons.index add 1
	if (%weapons.index > %weapons.length) then {
	    var weapons.index 0
	    #evalmath weapons.targetLearningRate (5 + $%weapons.skills(%weapons.index).LearningRate)
	    evalmath weapons.targetLearningRate (5 + %weapons.targetLearningRate)
	    if (%weapons.targetLearningRate > 34) then var weapons.targetLearningRate 34
	}
	var weapons.lastChangeAt $gametime

	if ($%weapons.skills(%weapons.index).LearningRate = 0) then var logMsg #FF0000 %logMsg
	var logMsg %logMsg %weapons.skills(%weapons.index) ($%weapons.skills(%weapons.index).LearningRate/%weapons.targetLearningRate)
	put #echo >Debug %logMsg

	return


checkWeaponSkills.swapWeapon:
    if ("%weapons.skills(%weapons.index)" = "Large_Edged" && "%weapon_hand" != "he") then {
        gosub swap my sword
        goto checkWeaponSkills.swapWeapon
    }
    if ("%weapons.skills(%weapons.index)" = "Twohanded_Edged" && "%weapon_hand" != "The") then {
        gosub swap my sword
        goto checkWeaponSkills.swapWeapon
    }
    return


##
# Trains shield and parry in 5s
# Assumes, all other things being equal, that shield stance is preferable
##
###############################
###      checkStances
###############################
checkStances:
    #if ($health < 90 || "%weapons.skills(%weapons.index)" = "Crossbow" || "%weapons.skills(%weapons.index)" = "Slings" || "%weapons.skills(%weapons.index)" = "Bow" || "%weapons.skills(%weapons.index)" = "Twohanded_Blunt" || "$righthandnoun" = "crossbow" || "$righthandnoun" = "latchbow" || "$righthandnoun" = "lockbow" || $Parry_Ability.LearningRate > 32 || %forceShield = 1) then {
    if ($health < 90 || $Parry_Ability.LearningRate > 32 || %forceShield = 1 || matchre("%weapons.skills(%weapons.index)", "(%skillsToUseShield)")) then {
        var stances.index 0
    } else {
        if ($%stances.skills(%stances.index).LearningRate > %stances.targetLearningRate) then {
            if (!($lastStanceGametime > -1)) then put #var lastStanceGametime 0
            evalmath timeSinceLastStance ($gametime - $lastStanceGametime)

            #delay conditions: currently in shield, shield and parry are over 32, lessthan 300s timeSinceLastStance
            if (%stances.skills(%stances.index) = "shield" && %timeSinceLastStance < 300 && $Shield_Usage.LearningRate > 32 && $Parry_Ability.LearningRate > 32) then {
                return
            }
            math stances.index add 1
            if (%stances.index > %stances.length) then {
                var stances.index 0
                evalmath stances.targetLearningRate (5 + $%stances.skills(%stances.index).LearningRate)
                if (%stances.targetLearningRate > 32) then var stances.targetLearningRate 32
            }
        }
    }

    if ("$stance" != "%stances.list(%stances.index)") then {
        gosub stance %stances.list(%stances.index)
    }
    return



###############################
###      checkDeadMob
###############################
checkDeadMob:
    if (matchre ("$roomobjs", "(%critters) ((which|that) appears dead|(dead))")) then {
        var mobName $1

        if (1 = 0 && "$charactername" = "Qizhmur") then {
            if ("%mobName" = "basilisk") then {
                gosub skin basilisk for part
                gosub put my fang in my satchel
            }
            if ("$righthandnoun" = "hide" || "$lefthandnoun" = "hide") then {
                gosub put my hide in my bundle
                gosub drop hide
            }
            gosub loot %mobName %lootType
            return
        }

        if ("$guild" = "Necromancer" && matchre("%ritualcritters", "%mobName")) then {
            gosub runScript devour %mobName
            gosub performRitual %mobName
        }

        if (%useSkin = 1 && matchre("%skinnablecritters", "%mobName")) then {
            if ($char.fight.useDissect = 1 && $Skinning.LearningRate > $First_Aid.LearningRate && $First_Aid.LearningRate < 33) then {
                gosub dissect %mobName
            }
            if (%arrangeForPart = 1) then {
                gosub arrange for part
            }

            if (%arrangeFull = 1) then {
                gosub arrange full
            }

            var preSkinRightHand $righthand
            gosub skin
            var skinType null
            if ("%preSkinRightHand" = "Empty" && "$righthand" != "Empty") then var skinType $righthandnoun
            if ("%preSkinRightHand" != "Empty" && "$lefthand" != "Empty") then var skinType $lefthandnoun
            if ("%skinType" != "null") then gosub makeNewBundle %skinType
        }
        gosub loot %lootType
    }
    return


###############################
###      checkHide
###############################
checkHide:
    if (%useStealth = 1 && $Stealth.LearningRate < 33) then gosub hide
    return



###############################
###      debil
###############################
debil:
    var force 0
    if ("$1" = "force") then var force 1
    #if (%debil.use = 1 && $mana > 80 && (%force = 1 || !matchre("$monsterlist", "(%debilConditions)")) then {
    if (%debil.use = 1 && $mana > 80 && !matchre("$monsterlist", "(%debilConditions)")) then {
        if ($Debilitation.LearningRate < 32 || %force = 1) then {
            gosub prep %debil.spell %debil.prepAt
            if (!($char.fight.debilPauseTime > 0)) then put #tvar char.fight.debilPauseTime 4
            pause $char.fight.debilPauseTime
            gosub cast
        }
    }
    return



###############################
###      fight.observe
###############################
fight.observe:
    if (%useObserve = 1 && $Astrology.LearningRate < 30 && $monstercount < 4) then gosub runScript observe
    if (%useObserve = 1 && $Astrology.LearningRate < 22 && $monstercount < 4) then gosub runScript predict
    return



###############################
###      huntApp
###############################
huntApp:
    if (%useHunt = 1 && $Perception.LearningRate < 33) then {
       gosub hunt.onTimer
       return
    }
    if (%useAppraise = 1 && $Appraisal.LearningRate < 30 && $monstercount < 4) then {
        gosub appraise.onTimer
        return
    }
    if (%usePerc = 1 && $Attunement.LearningRate < 31) then {
        gosub perc.onTimer
        return
    }

    return



###############################
###      makeNewBundle
###############################
makeNewBundle:
    var skinType $1
    if (%useShadowServant = 1) then {
        put #echo >Log #a89b32 Making new bundle
        gosub stow right
        gosub stow left
        gosub runScript stowbundle
        gosub get my bundling rope
        if ("$righthand" != "bundling rope") then {
            gosub stow right
            gosub runScript braidRope
            gosub get my bundling rope
        }
        # Occasionally end up with throwing blades in hand. No clue why.
        if ("%skinType" = "blades") then var skinType claw
        gosub get my %skinType
        if ("$lefthand" = "throwing blades") then gosub stow my blades
        if ("$lefthand" = "Empty") then gosub get my horn
        if ("$lefthand" = "Empty") then gosub get my claw
        gosub bundle
        gosub tie bundle
        gosub tie bundle
        gosub adjust bundle
        gosub wear bundle
    } else {
        gosub remove my bundle
        gosub put my bundle in my portal
        gosub stow right
        gosub stow left
        gosub get my bundling rope
        if ("$righthand" != "bundling rope") then {
            gosub stow right
            gosub runScript braidRope
            gosub get my rope
        }
        gosub get my %skinType
        gosub bundle
        gosub tie bundle
        gosub tie bundle
        gosub adjust bundle
        gosub wear bundle
    }

    return



###############################
###      manageCyclics
###############################
manageCyclics:
    if ("$guild" = "Cleric") then gosub manageCyclics.cleric
    if ("$guild" = "Moon Mage") then gosub manageCyclics.moonMage
    if ("$guild" = "Necromancer") then gosub manageCyclics.necromancer
	return


manageCyclics.cleric:
	# HYH
	if ($char.fight.useHyh = 1 && $SpellTimer.HydraHex.active != 1 && $mana > 80 && $Debilitation.LearningRate < 30) then {
	#if ($char.fight.useHyh = 1 && $SpellTimer.HydraHex.active != 1 && $mana > 80) then {
		gosub release cyclic
		gosub runScript cast hyh male off
	} else {
		evalmath fight.tmp.nextCastHyhGametime (300 + $char.cast.cyclic.lastCastGametime.hyh)
		#if (%fight.tmp.nextCastHyhGametime < $gametime && $SpellTimer.HydraHex.active = 1) then gosub release hyh
		if ($SpellTimer.HydraHex.active = 1 && (%fight.tmp.nextCastHyhGametime < $gametime || $Debilitation.LearningRate > 33 || $mana < 60)) then gosub release hyh
        unvar fight.tmp.nextCastHyhGametime
	}

	#return

    if ($char.fight.useRev = 1 && $SpellTimer.HydraHex.active != 1 && $SpellTimer.Revelation.active != 1 && $mana > 80 && ($Utility.LearningRate < 10 || ($Utility.LearningRate < 30 && $Warding.LearningRate > 30)) ) then {
        if ($SpellTimer.GhostShroud.active = 1 || $SpellTimer.HydraHex.active = 1) then gosub release cyclic
        gosub release cyclic
        gosub runScript cast rev
    } else {
        evalmath timeSinceLastRev ($gametime - $lastCastRev)
        if ($SpellTimer.Revelation.active = 1 && (%timeSinceLastRev > 300 || $mana < 60 || ($Utility.LearningRate > 20 && $Warding.LearningRate < 30) )) then gosub release rev
    }

    if ($char.fight.useGhs = 1 && $SpellTimer.HydraHex.active != 1 && $SpellTimer.GhostShroud.active != 1 && $SpellTimer.Revelation.active != 1 && $mana > 80) then {
        gosub release cyclic
        gosub runScript cast ghs
    } else {
        evalmath timeSinceLastGhs ($gametime - $lastCastGhs)
        if ($SpellTimer.GhostShroud.active = 1 && %timeSinceLastGhs > 300) then gosub release ghs
    }

    return



manageCyclics.moonMage:
	# SLS
	if (%useSls = 1 && $SpellTimer.StarlightSphere.active != 1 && $mana > 80 && $monstercount > -1 && $Targeted_Magic.LearningRate < 27 && $Time.isDay = 0) then {
	    gosub release cyclic
	    gosub prep sls $char.cast.sls.prep
	    gosub waitForPrep
	    gosub cast spider in sky
	} else {
	    if ($SpellTimer.StarlightSphere.active = 1 && ($Targeted_Magic.LearningRate > 31 || $mana < 60)) then gosub release sls
	}

	# SHW (if SLS is not active)
	if (%useShw = 1 && $SpellTimer.ShadowWeb.active != 1 && $SpellTimer.StarlightSphere.active != 1 && $mana > 80 && $monstercount > -1 && $Debilitation.LearningRate < 27 && $Parry_Ability.LearningRate > 29 && $Shield_Usage.LearningRate > 29 && $Evasion.LearningRate > 29) then {
		gosub release cyclic
		gosub runScript cast shw
	} else {
		if ($SpellTimer.ShadowWeb.active = 1 && ($Debilitation.LearningRate > 30 || $mana < 60)) then gosub release shw
	}

	# REV (if SLS and SHW are not active)
	    # release REV if we last cast it more than 5 minutes ago
	if (!($char.cast.cyclic.lastCastGametime.rev > -1) then put #tvar char.cast.cyclic.lastCastGametime.rev 1
	evalmath fight.tmp.nextCastRevGametime (300 + $char.cast.cyclic.lastCastGametime.rev)
    if (%fight.tmp.nextCastRevGametime < $gametime && $SpellTimer.Revelation.active = 1) then gosub release rev
    unvar fight.tmp.nextCastRevGametime

	if ($char.fight.useRevSorcery = 1 && $SpellTimer.Revelation.active != 1 && $SpellTimer.ShadowWeb.active != 1 && $SpellTimer.StarlightSphere.active != 1 && $mana > 80 && ($Sorcery.LearningRate < 33 || $Augmentation.LearningRate < 33 || $Utility.LearningRate < 33)) then {
		var debuffSkills null
		action (expMods) on
		put exp mods
		pause 2
		action (expMods) off
		if (!matchre("%debuffSkills", "(Sorcery)")) then {
			gosub release cyclic
			gosub invoke my tattoo
			gosub waitForPrep
			gosub cast
		}
	} else {
		if ($SpellTimer.Revelation.active = 1 && $mana < 60) then gosub release rev
	}

	return


manageCyclics.necromancer:
    # USOL
    if (%useUsol = 1) then {
        var shouldCastUsol 1
        if ($SpellTimer.UniversalSolvent.active = 1) then var shouldCastUsol 0
        if ($mana < 80) then var shouldCastUsol 0
        if ($Targeted_Magic.LearningRate > 30) then var shouldCastUsol 0
        if ($monstercount < 2) then var shouldCastUsol 0

        if (%shouldCastUsol = 1) then {
            gosub prep usol
            gosub waitForPrep
            gosub cast creatures
        }

        if ($SpellTimer.UniversalSolvent.active = 1) then {
            var shouldReleaseUsol 0
            if ($mana < 60) then var shouldReleaseUsol 1
            if ("$roomplayers" != "") then var shouldReleaseUsol 1
            if ($Targeted_Magic.LearningRate > 33) then var shouldReleaseUsol 1

            if (%shouldReleaseUsol = 1) then gosub release usol
        }
    } else {
        if ($SpellTimer.UniversalSolvent.active = 1) then gosub release usol
    }

    return


###############################
###      newBundle
###############################
newBundle:
    if ($charactername = Selesthiel) then {
        put .ssstowbundle
        waitforre ^SS STOW BUNDLE DONE
        return
    }
    return



###############################
###      performRitual
###############################
performRitual:
    var ritualTarget $0

    # Make sure we have enough material stocked up
    if (!($necroMaterialCount > -1)) then put #var necroMaterialCount 0
    gosub runScript countNecroMaterial
    if ($necroMaterialCount < 30) then {
        gosub perform preserve on %ritualTarget
        gosub perform harvest on %ritualTarget
        if ("$righthandnoun" = "material" || "$lefthandnoun" = "material") then gosub stow material
        gosub runScript countNecroMaterial
    }

    # Use dissection to train up First Aid and Skinning
    if ($Skinning.LearningRate < 33 || $First_Aid.LearningRate < 33) then {
        if ($Skinning.LearningRate < 32) then {
            gosub arrange full
        }
        gosub stow right
        gosub stow left
        if (%avoidDivineOutrage != 1) then {
            gosub perform preserve on %ritualTarget
            gosub perform butchery on %ritualTarget leg
            gosub drop my leg
            gosub stow right
        }
        gosub perform dissection on %ritualTarget
    } else {
        # Otherwise level up that butchery hidden number!
        gosub stow right
        gosub stow left
        if (%avoidDivineOutrage != 1) then {
            gosub perform butchery on %ritualTarget leg
        }
        if ("$righthand" != "Empty") then {
            gosub drop my leg
            gosub stow right
        }
    }
    return


###############################
###      releaseUnwantedSpells
###############################
releaseUnwantedSpells:
    if (%useRoc != 1 && $SpellTimer.RiteofContrition.active = 1) then gosub release roc
    if (%useRog != 1 && $SpellTimer.RiteofGrace.active = 1) then gosub release rog
    if (%useUsol != 1 && $SpellTimer.UniversalSolvent.active = 1) then gosub release usol
    if (%useSls != 1 && $SpellTimer.StarlightSphere.active = 1) then gosub release sls

    if ($SpellTimer.EyesoftheBlind.active = 1) then gosub release eotb
    if ($SpellTimer.RefractiveField.active = 1) then gosub release rf

    return


###############################
###      sortArmorRanks
###############################
sortArmorRanks:
	var tmpIndex 0
	var armorIndex 0

	sortArmorRanks.loop:
		if ($$char.fight.armor.skill.%tmpIndex.LearningRate < $$char.fight.armor.skill.%armorIndex.LearningRate) then var armorIndex %tmpIndex
		math tmpIndex add 1
		if (contains("$char.fight.armor.skill.%tmpIndex", "char.fight.armor")) then {
			unvar tmpIndex
			return
		}
		goto sortArmorRanks.loop



###############################
###      sortWeaponRanks
###############################
sortWeaponRanks:
    var newWeapons.skills null
    var newWeapons.items null
    sortNext:
        var lowestSkillIndex null
        var currIndex 0
        sortLoop:
            if (!contains("%newWeapons.skills", "%weapons.skills(%currIndex)")) then {
                if (%lowestSkillIndex = null || $%weapons.skills(%currIndex).Ranks < $%weapons.skills(%lowestSkillIndex).Ranks) then {
                    var lowestSkillIndex %currIndex
                }
            }
            math currIndex add 1
            if (%currIndex <= %weapons.length) then goto sortLoop
            if (%newWeapons.skills = null) then {
                var newWeapons.skills %weapons.skills(%lowestSkillIndex)
                var newWeapons.items %weapons.items(%lowestSkillIndex)
            } else {
                var newWeapons.skills %newWeapons.skills|%weapons.skills(%lowestSkillIndex)
                var newWeapons.items %newWeapons.items|%weapons.items(%lowestSkillIndex)
            }
            if (count("%newWeapons.skills", "|") < %weapons.length) then {
                goto sortNext
            }
            var weapons.skills %newWeapons.skills
            var weapons.items %newWeapons.items
            return


###############################
###      DONE
###############################
done:
    pause .2
    put #parse FIGHT DONE
    exit

