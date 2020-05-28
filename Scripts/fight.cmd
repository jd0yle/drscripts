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

####################################################################################################
# CONFIG
if ($charactername = Selesthiel) then {
    var weapons.skills Targeted_Magic|Brawling|Small_Edged|Light_Thrown|Crossbow
    #var weapons.items Empty|Empty|haralun scimitar|Empty|competition crossbow
    var weapons.items Empty|Empty|assassin's blade|Empty|competition crossbow
    var useSls 1
    var tmSpell pd
    var tmPrep 20
    var debil.use 1
    var debil.spell mb
    var debil.prepAt 20
}

if ($charactername = Qizhmur) then {
    var weapons.skills Targeted_Magic|Brawling|Small_Edged
    var weapons.items Empty|Empty|scimitar
    var useSls 0
    var tmSpell stra
    var tmPrep 1
    var debil.use 0
    var debil.spell pv
    var debil.prepAt 1
}
####################################################################################################

var attacks
var doAnalyze 1
var lastAnalyzeTime 0

var nextHuntAt 0
var nextAppAt 0

var stance.current null

var lootables throwing blade|arrow|bolt|quadrello|brazier
var toLoot null
action (invFeet) var toLoot %toLoot|$1 when (%lootables)
action (invFeet) off

var weapons.index 0
eval weapons.length count("%weapons.skills", "|")
var weapons.lastChangeAt 0
var weapons.targetLearningRate 5

var lootables throwing blade|coin


#action var attacks $2; goto doAnalyzedAttacks when ^(Balance reduction|Armor reduction|A chance for a stun) can be inflicted.* by landing (.*)

action send adv when ^You must be closer to use tactical abilities on your opponent.
action var doAnalyze 1 when ^Utilizing \S+ tactics
action var doAnalyze 0; var attacks $2 when ^(Balance reduction|Armor reduction|A chance for a stun) can be inflicted.* by landing (.*)
action var doAnalyze 1 when ^You can no longer see openings
action var doAnalyze 1 when You fail to find any
action var doAnalyze 1 when ^ then lies still\.$

action send circle when ^Analyze what

action send get my scimitar when ^Wouldn't it be better if you used a melee weapon\?$

action goto newBundle when ^Where did you intend to put that\?  You don't have any bundles or they're all full or too tightly packed!

timer start


init:
    put #class combat on
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


loop:
    if $monsterdead > 0 then {
        if ($guild = Necromancer && $Thanatology.LearningRate < 33) then gosub perform preserve on rat
        gosub Skinning
        gosub loot

    }

    gosub pickupLoot
    gosub checkStances
    gosub buffs
    gosub huntApp
    gosub checkWeaponSkills

    if ("%weapons.skills(%weapons.index)" = "Targeted_Magic") then {
        if (%useSls = 1 && $Time.isDay != 1) then {
            if ($SpellTimer.StarlightSphere.active != 1) then {
                gosub prep sls 15
                pause 20
                gosub cast heart
            } else {
                math weapons.index add 1
            }
        }
        gosub prep %tmSpell %tmPrep
        gosub target
        gosub checkHide
        pause 4
        gosub cast
        goto loop
    }

    if ("%weapons.skills(%weapons.index)" = "Light_Thrown") then {
        if (!contains("$righthand", "throwing blade")) then gosub stow right
        gosub get throwing blades
        if (%debil.use = 1 && $mana > 80 && !contains("$monsterlist", "sleeping")) then {
            gosub prep %debil.spell %debil.prepAt
            pause 4
            gosub cast
        }
        gosub checkHide
        gosub attack throw
        if ("$righthand" != "Empty") then {
            gosub attack throw
        }
        goto loop
    }

    if ("%weapons.skills(%weapons.index)" = "Crossbow") then {
        gosub get my bolt
        gosub retreat
        gosub load
        gosub stow left
        gosub retreat
        gosub aim
        if (%debil.use = 1) then gosub prep %debil.spell %debil.prepAt
        gosub retreat
        pause 2
        gosub retreat
        pause 2
        gosub retreat
        pause 2
        gosub cast
        gosub fire
        goto loop
    }

    if $monstercount > 0 then {
        gosub analyze
        var lastAnalyzeTimeAt %t
    } else {
        pause 10
    }

    if (evalmath(%t - %lastAnalyzeTime) > 60) then gosub analyze

    if %doAnalyze = 0 then {
        gosub doAnalyzedAttacks
    }
    goto loop


doAnalyzedAttacks:
    if ($monstercount < 2) then {
        gosub attack circle
        gosub attack bob
        return
    }
    eval attacks replace("%attacks", " and", ",")
    eval attacks replace("%attacks", "a ", "")
    eval attacks replace("%attacks", "an ", "")
    eval attacks replace("%attacks", ",", "|")
    eval attacks replace("%attacks", ".", "")
    eval attacks replace("%attacks", " ", "")
    eval length count("%attacks", "|")
    var index 0

    if (%debil.use = 1 && $mana > 80 && !contains("$monsterlist", "sleeping")) then {
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


buffs:
    if ($charactername != Selesthiel) then {
        if ($SpellTimer.ManifestForce.active = 0) then {
            gosub prep maf 3
            pause 10
            gosub cast
            return
        }
        if ($SpellTimer.Obfuscation.active = 0) then {
            gosub prep obf 3
            pause 10
            gosub cast
            return
        }
        return
    }

    if ($SpellTimer.SeersSense.active = 0) then {
        put .cast n seer
        waitforre ^CAST DONE
        return
    }

    if ($SpellTimer.ManifestForce.active = 0) then {
        put .cast n maf
        waitforre ^CAST DONE
        return
    }

    if ($SpellTimer.CageofLight.active = 0) then gosub buffCol
    return

buffCol:
    if ($Time.isKatambaUp = 1) then {
        put .cast n col katamba
        waitforre ^CAST DONE
        return
    }

    if ($Time.isXibarUp = 1) then {
        put .cast n col xibar
        waitforre ^CAST DONE
        return
    }

    if ($Time.isYavashUp = 1) then {
        put .cast n col yavash
        waitforre ^CAST DONE
        return
    }
    return


checkWeaponSkills:
    if ($%weapons.skills(%weapons.index).LearningRate >= %weapons.targetLearningRate) then {
        # By default, don't switch weapons faster than once every 30 seconds.
        # But if all the weapon skills are moving, wait 120 seconds before swapping
        var timeBetweenWeaponSwaps 30
        if (%weapons.targetLearningRate > 10) then var timeBetweenWeaponSwaps 120
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

    if ("$righthand" != "%weapons.items(%weapons.index)") then {
        gosub stow right
        if ("%weapons.items(%weapons.index)" != "Empty") then gosub get my %weapons.items(%weapons.index)
    }

    put #statusbar 6 Weapon: %weapons.skills(%weapons.index) $%weapons.skills(%weapons.index).LearningRate/%weapons.targetLearningRate

    return

##
# Assumes, all other things being equal, that shield stance is preferable
##
checkStances:
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


checkHide:
    if ($Stealth.LearningRate < 33) then {
        gosub hide
        evalmath nextHideAt 30 + %t
    }
    return


huntApp:
    if (%t > %nextHuntAt && $Perception.LearningRate < 33) then {
        gosub hunt
        evalmath nextHuntAt 120 + %t
        echo nextHuntAt: %nextHuntAt
        return
    }
    if (%t > %nextAppAt && $Appraisal.LearningRate < 33) then {
        gosub retreat
        gosub retreat
        gosub app my bundle
        evalmath nextAppAt 90 + %t
        echo nextAppAt: %nextAppAt
        pause
        put adv
        pause 5
        return
    }

    return


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


newBundle:
    if ($charactername = Selesthiel) then {
        put .ret
        if ($preparedspell != None) then gosub release spell
        gosub prep ss

        var storedItem $righthandnoun
        gosub stow right
        if ("$lefthand" != "Empty") then gosub stow left

        pause 10
        gosub cast
        pause
        gosub ask servant for haversack
        gosub open my haversack
        gosub remove my bundle
        gosub put my bundle in my haversack
        gosub close my haversack
        pause
        put give haversack to servant
        pause
        gosub release servant
        gosub get my rope
        gosub get my %storedItem
        gosub bundle my %storedItem with my rope
        pause
        put tie my bundle
        pause
        put tie my bundle
        pause
        gosub wear my bundle
        put adjust my bundle
        put #script abort ret
        goto loop
    }
