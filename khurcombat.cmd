include libmaster.cmd
####################
# Combat
####################
action goto combatAnalyze when ^You fail to find any holes
action goto combatFaceNext when ^Analyze what
action var doAnalyze 0; var attacks $2 when ^(Balance reduction|Armor reduction|A chance for a stun) can be inflicted.* by landing (.*)
action pause 60 ; goto combatSkillCheck when ^Wouldn't it be better if you used a melee weapon\?

####################
# Variable Inits
####################
if (!($currentWeapon >0)) then put #var currentWeapon 0
if (!($heavyThrownWeapon >0)) then put #var heavyThrownWeapon 0
if (!($lastAnalyzeTimeAt >0)) then put #var lastAnalyzeTimeAt 0
if (!($lastHuntGametime >0)) then put #var lastHuntGametime 0
if (!($lightThrownWeapon >0)) then put #var lightThrownWeapon 0
if (!($observeOffCooldown >0)) then put #var observeOffCooldown 0
if (!($smallEdgeWeapon >0)) then put #var smallEdgeWeapon 0
if (!($staveWeapon >0)) then put #var staveWeapon 0

var weaponIndex 0
var weaponItems 0
var weaponSkills 0
var useApp 0
var useAstrology 0
var useForage 0
var useHunt 1
var usePerc 1
var useSano 0

var opts %1
if ("%opts" = "backtrain") then {
    var useApp 0
    var useForage 0
    var useHunt 0
    var usePerc 0
}
####################
# Character Specific
####################
if ("$charactername" = "Inauri") then {
    var weaponSkills Brawling|Light_Thrown|Heavy_Thrown|Small_Edged|Polearms|Targeted_Magic
    var weaponItems Empty|frying pan|hhr'ata|blade|scythe|Empty
}


if ("$charactername" = "Khurnaarti") then {
    var weaponSkills Staves|Brawling|Light_Thrown|Heavy_Thrown|Targeted_Magic
    var weaponItems nightstick|Empty|naphtha|wand|Empty

    if ("%opts" = "backtrain") then {
        var weaponSkills Light_Thrown|Heavy_Thrown
        var weaponItems naphtha|wand
        var useAstrology 0
    }
}


if ("$charactername" = "Sakhhtaw") then {
    var weaponSkills Brawling|Heavy_Thrown|Small_Edged|Targeted_Magic
    var weaponItems Empty|hhr'ata|pelletbow|fan|Empty
}


goto combatSkillCheck
combatSkillCheck:
    eval weaponLength count("%weaponSkills", "|")
    if (%weaponIndex > %weaponLength) then {
        goto combatExit
    }
    if ($%weaponSkills(%weaponIndex).LearningRate < 30) then {
        # Need a weapon in hand.
        if ("%weaponItems(%weaponIndex)" <> "Empty") then {
            # Hand is not empty and not the weapon we need.
            if ("$righthand" <> "Empty" && "$righthandnoun" <> "%weaponItems(%weaponIndex)" then {
                gosub stow
                gosub stow left
            }
            gosub get my %weaponItems(%weaponIndex)
        }
        # Brawling and Targeted Magic
        if ("%weaponItems(%weaponIndex)" = "Empty") then {
            gosub stow
            gosub stow left
        }
        # Found a skill to train.
        if ("%weaponSkills(%weaponIndex)" = "Light_Thrown" || "%weaponSkills(%weaponIndex)" = "Heavy_Thrown") then {
            goto combatAttack
        }
        if ("%weaponSkills(%weaponIndex" = "Targeted_Magic") then {
            put .target
            exit
        }
        goto combatAnalyze
    }
    # Check a different skill.
    math weaponIndex add 1
    goto combatSkillCheck


##############
# Main
##############
combatAnalyze:
    if ($stamina < 85) then {
        pause 5
        goto combatAnalyze
    }


combatAnalyze1:
    gosub analyze
    var lastAnalyzeTimeAt %t
    if (evalmath(%t - %lastAnalyzeTime) > 60) then gosub analyze
    if (%doAnalyze = 0) then {
        goto combatAnalyzed
    }


combatAnalyzed:
    eval attacks replace("%attacks", " and", ",")
    eval attacks replace("%attacks", "a ", "")
    eval attacks replace("%attacks", "an ", "")
    eval attacks replace("%attacks", ",", "|")
    eval attacks replace("%attacks", ".", "")
    eval attacks replace("%attacks", " ", "")
    eval length count("%attacks", "|")
    var index 0


combatAttack:
    gosub combatCheckDeadMob
    if (%useApp = 1) then gosub combatApp
    if (%useForage = 1) then gosub combatForage
    if (%useHunt = 1) then gosub combatHunt
    if (%usePerc = 1) then gosub combatPerc
    if (%useAstrology = 1) then gosub combatAstrology
    if ("%weaponSkills(%weaponIndex)" = "Light_Thrown" || "%weaponSkills(%weaponIndex)" = "Heavy_Thrown") then {
        if ("$righthand" = "Empty") then {
              gosub get my %weaponItems(%weaponIndex)
        }
        gosub attack lob
        gosub get my %weaponItems(%weaponIndex)
        goto combatSkillCheck
    } else {
        gosub attack %attacks(%index)
        math index add 1
        if (%index > %length) then goto combatSkillCheck
    }
    goto combatAttack

##############
# Utilities
##############
combatAstrology:
    if ($Astrology.LearningRate < 33) then gosub observe.onTimer
    return


combatApp:
    if ($Appraisal.LearningRate < 33) then gosub appraise.onTimer
    return


combatCheckDeadMob:
    if (matchre ("$roomobjs", "(%critters) ((which|that) appears dead|(dead))") then {
        var mobName $1

        if (%useSkin = 1 && matchre("%skinnablecritters", "%mobName")) then {
            if (%arrangeForPart = 1) then gosub arrange for part
            if (%arrangeFull = 1) then gosub arrange full
            gosub skin
        }
        gosub loot
    }
    return


combatEngage:
    gosub advance
    pause 5
    goto combatAttack


combatExit:
    put .look
    put #script abort all except look
    exit


combatFaceNext:
    matchre combatExit nothing
    matchre combatAnalyze ^You turn
    put face next
    matchwait 5


combatForage:
    if (%monstercount <> 0) then return
    if ($Outdoorsmanship.LearningRate < 30) then {
        gosub runScript forage
        waitforre ^FORAGE DONE
    }
    return


combatHunt:
    if ($Perception.LearningRate > 15) then {
        return
    }
    evalmath nextHuntAt $lastHuntGametime + 75
    if (%nextHuntAt < $gametime) then {
        return
    }
    gosub hunt
    put #var lastHuntGametime $gametime
    return


combatPerc:
    if ($Attunement.LearningRate < 33) then gosub perc.onTimer

    return
