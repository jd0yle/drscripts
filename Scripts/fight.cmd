include var_mobs.cmd
include libsel.cmd
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

# debug 5

# DEFAULTS
var arrangeForPart 0
var debil.use 0
var useApp 1
var useBuffs 1
var useHunt 1
var usePerc 1
var usePhp 0
var useQe 0
var useRog 0
var useSkin 1
var useSls 0
var useStealth 1
var useAlmanac 0


####################################################################################################
# CONFIG
var opts %1

if ("%opts" = "backtrain") then {
    var arrangeForPart 0
    var debil.use 0
    var forceShield 1
    var useApp 0
    var useBuffs 0
    var useHunt 0
    var usePerc 0
    var useQe 0
    var useRog 0
    var useSkin 0
    var useSls 0
    var useStealth 0
}

if ($charactername = Selesthiel && "%opts" != "backtrain") then {
    var weapons.skills Targeted_Magic|Brawling|Small_Edged|Light_Thrown|Crossbow
    var weapons.items Empty|Empty|haralun scimitar|hunting bola|competition crossbow
    var cambrinth mammoth calf
    var useSls 0
    var tmSpell pd
    var tmPrep 30
    var debil.use 1
    var debil.spell mb
    var debil.prepAt 20
    var ignoreCoL 0
    var arrangeForPart 1
    var useAlmanac 1
    var doObserve 0
}

if ($charactername = Selesthiel && "%opts" = "backtrain") then {
    var weapons.skills Heavy_Thrown|Offhand_Weapon|Small_Blunt|Large_Blunt|Bow|Staves|Twohanded_Edged|Twohanded_Blunt|Polearms|Slings|Large_Edged
    var weapons.items ka'hurst hhr'ata|Empty|hunting bola|ka'hurst hhr'ata|competition shortbow|nightstick|bastard sword|footman's flail|narrow-bladed halberd|leather sling|bastard sword
    var cambrinth mammoth calf
    var useSls 0
    var tmSpell pd
    var tmPrep 30
    var debil.use 1
    var debil.spell mb
    var debil.prepAt 10
    var useBuffs 1
    var ignoreCoL 1
    var arrangeForPart 0
    var useAlmanac 1
    var doObserve 1
    var useStealth 0
    var useSkin 0
}

if ($charactername = Qizhmur && "%opts" != "backtrain") then {
    var weapons.skills Targeted_Magic|Brawling|Small_Edged|Heavy_Thrown|Light_Thrown|Crossbow|Staves
    var weapons.items Empty|Empty|assassin's blade|diamondique hhr'ata|triple-weighted bola|spiritwood lockbow|white nightstick
    var cambrinth aoustone muhenta
    var tmSpell acs
    var tmPrep 10
    var useIvm 0
    var debil.use 1
    var debil.spell pv
    var debil.prepAt 3
    var usePhp 1
    var useRog 0
    var necroRitual dissection
    var useQe 0
    var arrangeForPart 0
}

if ($charactername = Qizhmur && "%opts" = "backtrain") then {
    var weapons.skills Crossbow|Staves
    var weapons.items spiritwood lockbow|white nightstick
    var cambrinth aoustone muhenta
    var useBuffs 0
    var debil.use 1
    var debil.spell pv
    var debil.prepAt 2
    var necroRitual dissection
}

####################################################################################################


var doAppraisal 0

var attacks
var doAnalyze 1
var lastAnalyzeTime 0

var nextHuntAt 0
var nextAppAt 0
var nextPercAt 0
var nextRogCastAt 0

var stance.current null

var weapons.index 0
eval weapons.length count("%weapons.skills", "|")
var weapons.lastChangeAt 0
var weapons.targetLearningRate 5

var stances.list shield|parry
var stances.skills Shield_Usage|Parry_Ability
var stances.targetLearningRate 5
eval stances.length count("%stances.list", "|")
var stances.index 0

var lootables throwing blade|coin

action send adv when ^You must be closer to use tactical abilities on your opponent.
action var doAnalyze 1 when ^Utilizing \S+ tactics
action var doAnalyze 0; var attacks $2 when ^(Balance reduction|Armor reduction|A chance for a stun) can be inflicted.* by landing (.*)
action var doAnalyze 1 when ^You can no longer see openings
action var doAnalyze 1 when You fail to find any
action var doAnalyze 1 when ^ then lies still\.$

action put get my scimitar;put get my blade when ^Wouldn't it be better if you used a melee weapon


action send circle when ^Analyze what

action goto newBundle when ^Where did you intend to put that\?  You don't have any bundles or they're all full or too tightly packed!

action put #echo >Log Almanac: $1 when You believe you've learned something significant about (.*)!$

var isFullyPrepped 0
action var isFullyPrepped 1 when ^You feel fully prepared to cast your spell.
action var isFullyPrepped 1 when ^Your concentration slips for a moment, and your spell is lost.$
action var isFullyPrepped 0 when ^You trace an angular sigil in the air

timer start


var magicSkills Warding|Utility|Augmentation
eval magicSkillsLength count("%magicSkills", "|")
var magicSkillsIndex 0


###############################
###      init
###############################
init:
    put #class combat on

    # put .armor wear
    # waitforre ^ARMOR DONE$

    gosub sortWeaponRanks

    var weapons.lowestLearningRateIndex 0

    ## Start with the weapon with the lowest learning rate
    initLoop:
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
    gosub checkDeadMob
    gosub pickupLoot
    if ("$charactername" = "Qizhmur") then {
        gosub checkStancesNEW
    } else {
        gosub checkStances
    }
    gosub buffs

    # OBSERVE
    if (%doObserve = 1 && $Astrology.LearningRate < 32) then {
        if ($Astrology.LearningRate < 22) then {
            put .predict
            waitforre ^PREDICT DONE$
        }
        put .observe
        waitforre ^OBSERVE DONE$
    }

    # TRAIN MAGICS
    gosub trainMagics


    gosub huntApp
    gosub checkWeaponSkills

    # ALMANAC
    if (%useAlmanac = 1) then {
        evalmath nextStudyAt $lastAlmanacGametime + 600

        if (%nextStudyAt < $gametime) then {
            if ("$lefthandnoun" != "almanac" && "$righthandnoun" != "almanac") then {
                gosub get my almanac
            }
            if ("$lefthandnoun" != "almanac") then gosub swap
            gosub retreat
            gosub retreat
            gosub study my almanac
            gosub put my almanac in my thigh bag
            put #var lastAlmanacGametime $gametime
        }
    }

    if ("$charactername" = "Qizhmur") then {
        #gosub qizhmurIdle
    }

    var attackContinue 1
    if (%attackContinue = 1 && $monstercount < 2) then {
        #if ("$charactername" = "Qizhmur") then {
            gosub qizhmurIdle
        #}


        if ($monstercount = 1) then {
            gosub attack circle
            gosub attack bob
        }

        if ($monstercount = 0) then {
            gosub collect dirt
            if (contains("$roomobjs", "a pile of")) then {
                gosub kick pile
            }
        }
        var attackContinue 0
    }

    if (%attackContinue = 1 && $monstercount > 0) then {
        var continue = 1
        if (%continue = 1 && "%weapons.skills(%weapons.index)" = "Targeted_Magic") then {
            if ($mana > 80) then {
                gosub attackTm
            } else {
                pause 2
            }
            var continue 0
        }
        if (%continue = 1 && "%weapons.skills(%weapons.index)" = "Light_Thrown" || "%weapons.skills(%weapons.index)" = "Heavy_Thrown") then {
            gosub attackThrownWeapon
            var continue 0
        }
        if (%continue = 1 && ("%weapons.skills(%weapons.index)" = "Crossbow" || "%weapons.skills(%weapons.index)" = "Bow")) then {
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
            if (%debil.use = 1 && $mana > 80 && !contains("$monsterlist", "sleeping") && !contains("$monsterlist", "immobilized") then {
                gosub prep %debil.spell %debil.prepAt
                pause 4
                gosub cast
            }
            gosub attack slice left
            var continue 0
        }

        if (%continue = 1 && "%weapons.skills(%weapons.index)" = "Slings") then {
            if (%debil.use = 1 && $mana > 80 && !contains("$monsterlist", "sleeping") && !contains("$monsterlist", "immobilized") then {
                gosub prep %debil.spell %debil.prepAt
            }
            gosub load
            gosub aim
            pause 6
            gosub cast
            gosub fire
            put .loot
            waitforre ^LOOT DONE
            var continue 0
        }

        if (%continue = 1) then {
            gosub analyze
            var lastAnalyzeTimeAt %t
            if (evalmath(%t - %lastAnalyzeTime) > 60) then gosub analyze
            if (%doAnalyze = 0) then {
                gosub attackAnalyzed
            }
        }

        var attackContinue 0
    }

    if (1=0 && "$charactername" = "Selesthiel") then {
        gosub waitForPrep
        gosub cast
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

    if (%debil.use = 1 && $mana > 80 && !contains("$monsterlist", "sleeping") && !contains("$monsterlist", "immobilized") then {
        gosub prep %debil.spell %debil.prepAt
        pause 4
        gosub cast
    }
    gosub checkHide

    attackLoop:
        gosub attack %attacks(%index)
        math index add 1
        if (%index > %length) then return
        goto attackLoop



###############################
###      attackCrossbow
###############################
attackCrossbow:
    var crossbowRetreat 0
    gosub stance shield

    if ("%weapons.skills(%weapons.index)" = "Crossbow") then {
        var ammo basilisk bolt
    }

    if ("%weapons.skills(%weapons.index)" = "Bow") then {
        var ammo basilisk arrow
    }

    if %crossbowRetreat = 1 then gosub retreat
    gosub load my %weapons.items(%weapons.index) with my %ammo
    if %crossbowRetreat = 1 then gosub retreat
    gosub aim
    if (%debil.use = 1) then gosub prep %debil.spell %debil.prepAt
    if %crossbowRetreat = 1 then gosub retreat
    pause 2
    if %crossbowRetreat = 1 then gosub retreat
    pause 2
    if %crossbowRetreat = 1 then gosub retreat
    pause 2
    gosub cast
    gosub checkHide
    gosub fire
    return



###############################
###      attackThrownWeapon
###############################
attackThrownWeapon:
    if ("%weapons.items(%weapons.index)" != "Empty") then { # Empty thrown weapons means using throwing blades
        if ("$righthand" != "%weapons.items(%weapons.index)" ) then {
            gosub get my %weapons.items(%weapons.index)
        }

        if ("$righthandnoun" = "bola" || "$righthandnoun" = "hammer" || "$righthandnoun" = "hhr'ata") then {
            if (%debil.use = 1 && $mana > 80 && (!contains("$monsterlist", "sleeping") || !contains("$monsterlist", "immobilized")) then {
                gosub prep %debil.spell %debil.prepAt
                pause 4
                gosub cast
            }
            gosub checkHide
            gosub attack throw
            gosub get %weapons.items(%weapons.index)
            gosub attack throw
            gosub get %weapons.items(%weapons.index)

        } else {
            if (%debil.use = 1 && $mana > 80 && (!contains("$monsterlist", "sleeping") || !contains("$monsterlist", "immobilized")) then {
                gosub prep %debil.spell %debil.prepAt
                pause 4
                gosub cast
            }
            gosub checkHide
            gosub attack lob
        }
        if ("$righthand" != "%weapons.items(%weapons.index)" ) then {
            gosub get my %weapons.items(%weapons.index)
        }
    } else {
        if (!contains("$righthand", "throwing blade")) then gosub stow right
        gosub get throwing blades
        if (%debil.use = 1 && $mana > 80 && (!contains("$monsterlist", "sleeping") || !contains("$monsterlist", "immobilized")) then {
            gosub prep %debil.spell %debil.prepAt
            pause 4
            gosub cast
        }
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
    if (%useSls = 1 && $Time.isDay != 1) then {
        if ($SpellTimer.StarlightSphere.active != 1) then {
            gosub prep sls 15
            pause 20
            gosub cast heart
        } else {
            math weapons.index add 1
        }
    }

    if (%useSls != 1 && $SpellTimer.StarlightSphere.active = 1) then {
        gosub release sls
    }

    gosub target %tmSpell %tmPrep
    gosub checkHide
    pause 5
    gosub cast
    return



###############################
###      buffs
###############################
buffs:
    if (%useBuffs = 0) then return
    if ($charactername = Selesthiel) then {
        if ($SpellTimer.SeersSense.active = 0 || $SpellTimer.SeersSense.duration < 3) then {
            put .cast seer
            waitforre ^CAST DONE
            return
        }

        if ($SpellTimer.ManifestForce.active = 0 || $SpellTimer.ManifestForce.duration < 3) then {
            put .cast maf
            waitforre ^CAST DONE
            return
        }

        if ($SpellTimer.CageofLight.active = 0 || $SpellTimer.CageofLight.duration < 3) then gosub buffCol

        return
    }
    if ($charactername = Qizhmur) then {
        #es, substratum, tw, sw, ys, maf
        #mof rit
        if ($SpellTimer.ManifestForce.active = 0 || $SpellTimer.ManifestForce.duration < 2) then {
            gosub prep maf 10
            gosub charge %cambrinth 30
            gosub invoke %cambrinth
            gosub waitForPrep
            gosub cast
            return
        }
        if ($SpellTimer.Obfuscation.active != 1 || $SpellTimer.Obfuscation.duration < 2) then {
            gosub prep obf 10
            gosub charge %cambrinth 30
            gosub invoke %cambrinth
            gosub waitForPrep
            gosub cast
            return
        }
        if (%usePhp = 1 && $SpellTimer.PhilosophersPreservation.active != 1 || $SpellTimer.PhilosophersPreservation.duration < 3) then {
            gosub prep php 10
            gosub charge %cambrinth 30
            gosub invoke %cambrinth
            gosub waitForPrep
            gosub cast
            return
        }
        if (false && ($SpellTimer.CalcifiedHide.active != 1 || $SpellTimer.CalcifiedHide.duration < 3)) then {
            gosub prep ch 10
            pause 20
            gosub cast
            return
        }
        if ($SpellTimer.IvoryMask.active != 1 && "%weapons.skills(%weapons.index)" = "Targeted_Magic" && %useIvm = 1) then {
            gosub prep ivm 10
            pause 10
            gosub cast
            return
        }
        if (%useQe = 1 && $SpellTimer.QuickentheEarth.active != 1) then {
            return
            gosub prep qe 12
            pause 10
            gosub stance shield
            gosub stow left
            put push my vial
            pause
            gosub perform cut
            gosub cast
            return
        }

        if (%useRog = 1) then {
            if (!($lastCastRogAt > 0)) then put #var lastCastRogAt 1

            if ($Utility.LearningRate > 32 || "%weapons.skills(%weapons.index)" = "Targeted_Magic" || $mana < 80) then {
                if ($SpellTimer.RiteofGrace.active = 1) then gosub release rog
            } else {
                evalmath nextRogAt $lastCastRogAt + 300
                if ($gametime > %nextRogAt) then {
                    if ($SpellTimer.RiteofGrace.active = 1) then gosub release rog
                    gosub prep rog 8
                    gosub stance shield
                    gosub waitForPrep
                    gosub cast
                    put #var lastCastRogAt $gametime
                    return
                }
            }
        }

        return
    }


    return



###############################
###      buffCol
###############################
buffCol:
    if (%ignoreCoL = 1) then return
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
###      checkWeaponSkills
###############################
checkWeaponSkills:
    if ($%weapons.skills(%weapons.index).LearningRate >= %weapons.targetLearningRate) then {
        # By default, don't switch weapons faster than once every 30 seconds.
        # But if all the weapon skills are moving, wait 120 seconds before swapping
        var timeBetweenWeaponSwaps 30
        if (%weapons.targetLearningRate > 10) then var timeBetweenWeaponSwaps 60
        evalmath changeWeaponAt %weapons.lastChangeAt + %timeBetweenWeaponSwaps
        if (%t > %changeWeaponAt) then {
            math weapons.index add 1
            if (%weapons.index > %weapons.length) then {
                var weapons.index 0
                math weapons.targetLearningRate add 5
                if (%weapons.targetLearningRate > 34) then var weapons.targetLearningRate 34
            }
            var weapons.lastChangeAt %t
        }
    }

    var handItem $righthand
    if ("%handItem" = "white ironwood nightstick") then var handItem white nightstick
    # if ("$righthand" != "%weapons.items(%weapons.index)") then {
    if ("%handItem" != "%weapons.items(%weapons.index)") then {
        gosub stow right
        if ("%weapons.items(%weapons.index)" != "Empty") then gosub get my %weapons.items(%weapons.index)
    }

    if ("%weapons.items(%weapons.index)" = "bastard sword") then {
        if ("%weapons.skills(%weapons.index)" = "Large_Edged" && "%weapon_hand" != "he") then gosub swap my sword
        if ("%weapons.skills(%weapons.index)" = "Twohanded_Edged" && "%weapon_hand" != "The") then gosub swap my sword
    }

    put #statusbar 6 Weapon: %weapons.skills(%weapons.index) $%weapons.skills(%weapons.index).LearningRate/%weapons.targetLearningRate

    return



##
# Trains shield and parry in 5s
# Assumes, all other things being equal, that shield stance is preferable
##
###############################
###      checkStancesNEW
###############################
checkStancesNEW:
    if ($healh < 90 || %weapons.skills(%weapons.index) = Crossbow || "$righthandnoun" = "crossbow" || "$righthand" = "spiritwood lockbow" || $Parry_Ability.LearningRate > 32 || %forceShield = 1) then {
        gosub stance shield
        var stance.current shield
        return
    }

    if ($%stances.skills(%stances.index).LearningRate > %stances.targetLearningRate) then {
        math stances.index add 1
        if (%stances.index > %stances.length) then {
            var stances.index 0
            match stances.targetLearningRate add 5
            if (%stances.targetLearningRate > 32) then var stances.targetLearningRate = 32
        }
    }
    if ("%stance.current" != "%stances.list(%stances.index)" || "$stance" != "%stances.list(%stances.index)") then {
        gosub stance %stances.list(%stances.index)
        var stance.current %stances.list(%stances.index)
    }
    return



##
# Locks shield before training parry at all.
# Defaults to shield under every circumstance.
##
###############################
###      checkStances
###############################
checkStances:
    if (%forceShield = 1) then {
        if ("%stance.current" != "shield" || "$stance" != "shield") then {
            gosub stance shield
            var stance.current shield
        }
        return
    }

    if ($Shield_Usage.LearningRate < 33 || $Parry_Ability.LearningRate > 32 || $health < 100 || %weapons.skills(%weapons.index) = Crossbow || "$righthandnoun" = "crossbow") then {
        if ("%stance.current" != "shield" || "$stance" != "shield") then {
            gosub stance shield
            var stance.current shield
        }
    } else {
        if ("%stance.current" != "parry" || "$stance" != "parry") then {
            gosub stance parry
            var stance.current parry
        }
    }
    return



###############################
###      checkDeadMob
###############################
checkDeadMob:
    if (matchre ("$roomobjs", "(%critters) ((which|that) appears dead|(dead))")) then {
        var mobName $1
        if ("$guild" = "Necromancer" && matchre("%ritualcritters", "%mobName") then {
            put .devour %mobName
            waitforre ^DEVOUR DONE$

            gosub performRitual %mobName
        }
        if (%useSkin = 1 && matchre("%skinnablecritters", "%mobName")) then {
            if (%arrangeForPart = 1) then {
                gosub arrange for part
            }

            var preSkinRightHand $righthand
            gosub skin
            var skinType null
            if ("%preSkinRightHand" = "Empty" && "$righthand" != "Empty") then var skinType $righthandnoun
            if ("%preSkinRightHand" != "Empty" && "$lefthand" != "Empty") then var skinType $lefthandnoun

            if ("$charactername" = "Selesthiel" && "%skinType" != "null") then {
                put #echo >Log #a89b32 Making new bundle
                gosub stow right
                gosub stow left
                put .stowbundle
                waitforre ^STOWBUNDLE DONE$
                gosub get my bundling rope
                if ("$righthand" != "bundling rope") then {
                    gosub stow right
                    put .braidrope
                    waitforre ^BRAIDROPE DONE$
                    gosub get my rope
                }
                gosub get my %skinType
                gosub bundle
                gosub tie bundle
                gosub tie bundle
                gosub adjust bundle
                gosub wear bundle
            }
        }
        gosub loot treasure
    }
    return


###############################
###      checkHide
###############################
checkHide:
    if (%useStealth = 1 && $Stealth.LearningRate < 33) then {
        gosub hide
        evalmath nextHideAt 30 + %t
    }
    return



###############################
###      huntApp
###############################
huntApp:
    if (%useHunt = 1 && %t > %nextHuntAt && $Perception.LearningRate < 33) then {
        gosub hunt
        evalmath nextHuntAt 120 + %t
        return
    }
    if (%useApp = 1 && %doAppraisal = 1 && %t > %nextAppAt && $Appraisal.LearningRate < 33) then {
        gosub retreat
        gosub retreat
        gosub app my bundle
        evalmath nextAppAt 90 + %t
        pause
        put adv
        pause 5
        return
    }
    if (%usePerc = 1 && %t > %nextPercAt && $Attunement.LearningRate < 33) then {
        gosub perc mana
        evalmath nextPercAt 90 + %t
        return
    }

    return



qizhmurIdle:
    if (!(%qizMagicIndex > -1)) then var qizMagicIndex 0
    if (%useRog = 1) then {
        if (!($lastCastRogAt > 0)) then put #var lastCastRogAt 1

        if ($Utility.LearningRate > 32) then {
            if ($SpellTimer.RiteofGrace.active = 1) then gosub release rog
        } else {
            evalmath nextRogAt $lastCastRogAt + 300
            if ($gametime > %nextRogAt) then {
                if ($SpellTimer.RiteofGrace.active = 1) then gosub release rog
                gosub prep rog 8
                gosub stance shield
                gosub waitForPrep
                gosub cast
                put #var lastCastRogAt $gametime
            }
        }
    }
    if (%qizMagicIndex = 0 && %useRog = 0 && $mana > 80 && $Utility.LearningRate < 10) then {
        gosub prep eotb 10
        gosub charge my %cambrinth 30
        gosub invoke my %cambrinth
        gosub waitForPrep
        gosub cast
        gosub release eotb
        return
    }
    if (%qizMagicIndex = 1 && $mana > 80 && $Warding.LearningRate < 10) then {
        gosub prep maf 10
        gosub charge my %cambrinth 30
        gosub invoke my %cambrinth
        gosub waitForPrep
        gosub cast
        return
    }
    if (%qizMagicIndex = 2 && $mana > 80 && $Augmentation.LearningRate < 10) then {
        gosub prep obf 10
        gosub charge my %cambrinth 30
        gosub invoke my %cambrinth
        gosub waitForPrep
        gosub cast
        goto loop
    }

    math qizMagicIndex add 1
    if (%qizMagicIndex > 2) then var qizMagicIndex 0

    return



###############################
###      performRitual
###############################
performRitual:
    var ritualTarget $1
    # Use dissection to train up First Aid and Skinning
    if ($Skinning.LearningRate < 33 || $First_Aid.LearningRate < 33) then {
        gosub arrange
        gosub arrange
        gosub arrange
        gosub arrange
        gosub stow right
        gosub stow left
        gosub perform preserve on %ritualTarget
        gosub perform butchery on %ritualTarget leg
        gosub drop my leg
        gosub stow right
        gosub perform dissection on %ritualTarget
    } else {
        # Otherwise level up that butchery hidden number!
        gosub stow right
        gosub stow left
        gosub perform preserve on %ritualTarget
        gosub perform butchery on %ritualTarget
        if ("$righthand" != "Empty") then {
            gosub put my $righthandnoun in my eddy
        }
    }
    return



###############################
###      pickupLoot
###############################
pickupLoot:
    put .loot
    waitforre ^LOOT DONE

    eval numItems count("%lootables", "|")
    var loot.index 0

    pickupLootLoop:
        eval preLootLen len("$roomobjs")
        if (contains("$roomobjs", "%lootables(%loot.index)")) then {
            gosub stow %lootables(%loot.index)
        }
        if (len("$roomobjs") != %preLootLen) then {
            goto pickupLootLoop
        }

        math loot.index add 1
        if (%loot.index > %numItems) then return
        goto pickupLootLoop



###############################
###      pickupLootAtFeet
###############################
pickupLootAtFeet:
    action (invFeet) on
    var toLoot null
    pause .2
    put inv atfeet
    pause
    action (invFeet) off
    eval invLength count("%toLoot", "|")
    var invIndex 0

    pickupLootAtFeetLoop:
        if ("%toLoot(%invIndex)" != "null") then gosub stow %toLoot(%invIndex)
        math invIndex add 1
        if (%invIndex > %invLength) then return
        goto pickupLootAtFeetLoop



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


trainMagics:
    if (1 = 0 && $charactername = Selesthiel && "%weapons.skills(%weapons.index)" != "Targeted_Magic" && $mana > 80) then {
        math magicSkillsIndex add 1
        if (%magicSkillsIndex >= %magicSkillsLength) then var magicSkillsIndex 0

        var magicSkill %magicSkills(%magicSkillsIndex)
        if ("%magicSkill" = "Warding") then {
            gosub prep maf 40
            gosub charge my %cambrinth 60
        }
        if ("%magicSkill" = "Utility") then {
            gosub prep sm 40
            gosub charge my %cambrinth 60
        }
        if ("%magicSkill" = "Augmentation") then {
            gosub prep cv 40
            gosub charge my %cambrinth 60
        }
        gosub invoke my %cambrinth
    }
    return





waitForPrep:
    if (%isFullyPrepped = 1 || "$preparedspell" = "None") then return
    pause .5
    goto waitForPrep


exit

## TEMP ARCHIVE

if ($monsterdead > 0) then {
        if ($guild = Necromancer) then {
            put .cf %deadMonsterName
            waitfor CF DONE
        }
        if ($guild = Necromancer && $Thanatology.LearningRate < 33) then {
            if ("%necroRitual" = "dissection" && $Skinning.LearningRate < 33) then {
                gosub arrange
                gosub arrange
                gosub arrange
                gosub arrange
                gosub perform %necroRitual on %deadMonsterName
            } else if ("%necroRitual" = "butchery") then {
                gosub stow right
                gosub stow left
                gosub perform preserve on %deadMonsterName
                gosub perform butchery on %deadMonsterName
                if ("$righthand" != "Empty") then {
                    gosub put my $righthandnoun in my eddy
                }
            } else {
                gosub perform %necroRitual on %deadMonsterName
            }
        }
        if (%arrangeForPart = 1) then {
            gosub arrange for part
        }

        gosub skin
        gosub loot treasure
    }
