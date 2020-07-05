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
    var weapons.items Empty|Empty|haralun scimitar|Empty|competition crossbow
    var useSls 0
    var tmSpell pd
    var tmPrep 20
    var debil.use 1
    var debil.spell mb
    var debil.prepAt 20
}

if ($charactername = Qizhmur) then {
    var weapons.skills Targeted_Magic|Brawling|Small_Edged|Light_Thrown|Heavy_Thrown|Large_Blunt
    var weapons.items Empty|Empty|scimitar|hand mallet|throwing hammer|throwing hammer
    var useSls 0
    var tmSpell stra
    var tmPrep 1
    var debil.use 0
    var debil.spell pv
    var debil.prepAt 1
    var creature rat
}

if ($charactername = Nyarlathotep) then {
    var weapons.skills Targeted_Magic|Brawling|Small_Edged|Light_Thrown|Crossbow|Small_Blunt|Polearms
    var weapons.items Empty|Empty|silver-edged scimitar|Empty|light crossbow|granite mace|bone-white scythe
    var useSls 0
    var useQe 0
    var tmSpell acs
    var tmPrep 1
    var debil.use 1
    var debil.spell pv
    var debil.prepAt 1
}
####################################################################################################

if_1 then var creature %1

var doAppraisal 0

var attacks
var doAnalyze 1
var lastAnalyzeTime 0

var nextHuntAt 0
var nextAppAt 0
var nextPercAt 0

var stance.current null

var weapons.index 0
eval weapons.length count("%weapons.skills", "|")
var weapons.lastChangeAt 0
var weapons.targetLearningRate 5

var lootables throwing blade|coin

action send adv when ^You must be closer to use tactical abilities on your opponent.
action var doAnalyze 1 when ^Utilizing \S+ tactics
action var doAnalyze 0; var attacks $2 when ^(Balance reduction|Armor reduction|A chance for a stun) can be inflicted.* by landing (.*)
action var doAnalyze 1 when ^You can no longer see openings
action var doAnalyze 1 when You fail to find any
action var doAnalyze 1 when ^ then lies still\.$

action send circle when ^Analyze what

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

    #var weapons.index 4

    goto loop


loop:
    if $monsterdead > 0 then {
        if ($guild = Necromancer && $Thanatology.LearningRate < 33) then gosub perform preserve on %creature
        #gosub Skinning
        #gosub arrange
        gosub skin
        gosub loot
    }

    if ($charactername = Nyarlathotep) then {
        if ($Debilitation.LearningRate > 33) then {
            var useDebil 0
        } else {
            var useDebil 1
        }
    }

    gosub pickupLoot
    gosub checkStances
    gosub buffs
    gosub huntApp
    gosub checkWeaponSkills

    if $monstercount > 0 then {
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

        if ("%weapons.skills(%weapons.index)" = "Light_Thrown" || "%weapons.skills(%weapons.index)" = "Heavy_Thrown") then {
            if ("%weapons.items(%weapons.index)" != "Empty") then {
                if ("$righthand" != "%weapons.items(%weapons.index)" ) then gosub get my %weapons.items(%weapons.index)
                gosub attack lob
                gosub get %weapons.items(%weapons.index)
                goto loop
            } else {
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
        }

        if ("%weapons.skills(%weapons.index)" = "Crossbow") then {
            var crossbowRetreat 0
            gosub stance shield
            gosub get my bolt
            if %crossbowRetreat = 1 then gosub retreat
            gosub load
            gosub stow left
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
            goto loop
        }
    } else {
        gosub collect rocks
        gosub kick pile
        pause
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
    if ($charactername = Selesthiel) then {
        if ($SpellTimer.SeersSense.active = 0 || $SpellTimer.SeersSense.duration < 3) then {
            put .cast n seer
            waitforre ^CAST DONE
            return
        }

        if ($SpellTimer.ManifestForce.active = 0 || $SpellTimer.ManifestForce.duration < 3) then {
            put .cast n maf
            waitforre ^CAST DONE
            return
        }

        if ($SpellTimer.CageofLight.active = 0 || $SpellTimer.CageofLight.duration < 3) then gosub buffCol

        return
    }
    if ($charactername = Qizhmur) then {
        #es, substratum, tw, sw, ys, maf
        #mof rit
        if ($SpellTimer.ManifestForce.active = 0) then {
            gosub prep maf 3
            pause 10
            gosub cast
            return
        }
        if ($SpellTimer.Obfuscation.active != 1) then {
            gosub prep obf 3
            pause 10
            gosub cast
            return
        }
        if ($SpellTimer.EaseBurden.active != 1) then {
            gosub prep ease 1
            pause 10
            gosub cast
            return
        }
        return
    }

     if ($charactername = Nyarlathotep) then {
        if ($SpellTimer.ManifestForce.active = 0) then {
            gosub prep maf 5
            pause 10
            gosub cast
            return
        }
        if ($SpellTimer.Obfuscation.active != 1) then {
            gosub prep obf 5
            pause 10
            gosub cast
            return
        }
        if (1 = 0 && $SpellTimer.EaseBurden.active != 1) then {
            gosub prep ease 5
            pause 10
            gosub cast
            return
        }
        if ($SpellTimer.IvoryMask.active != 1) then {
            gosub prep ivm 5
            pause 10
            gosub cast
            return
        }
        if (($SpellTimer.QuickentheEarth.active != 1) && (%useQe = 1)) then {
            echo useQe = %useQe
            gosub prep qe 1
            gosub stow left
            gosub get my dirt
            gosub perform cut
            pause 15
            gosub cast
            return
        }
        return
    }

    if ($charactername = Discordia) then {
        #es, substratum, tw, sw, ys, maf
        #mof rit
        if ($SpellTimer.Substratum.active = 0) then {
            put .cast n substratum
            waitforre ^CAST DONE
            return
        }
        if ($SpellTimer.SureFooting.active = 0) then {
            put .cast n suf
            waitforre ^CAST DONE
            return
        }
        if ($SpellTimer.Tailwind.active = 0) then {
            put .cast n tw
            waitforre ^CAST DONE
            return
        }
        if ($SpellTimer.EtherealShield.active = 0) then {
            put .cast n es
            waitforre ^CAST DONE
            return
        }
        if ($SpellTimer.SwirlingWinds.active = 0) then {
            put .cast n sw
            waitforre ^CAST DONE
            return
        }

        return
    }


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
    if (%doAppraisal = 1 && %t > %nextAppAt && $Appraisal.LearningRate < 33) then {
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
    if (%t > %nextPercAt && $Attunement.LearningRate < 33) then {
        gosub perc mana
        evalmath nextPercAt 90 + %t
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
