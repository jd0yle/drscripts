include libsel.cmd

var nonCombatSkills.list stealth|perception|appraisal
eval nonCombatSkills.length count("%nonCombatSkills.list", "|")
var nonCombatSkills.index 0

var stance shield

gosub stance shield

loop:
    if ($monstercount > 1) then {
        if (%stance != shield) then gosub stance shield
        var stance shield
    } else {
        if (%stance != parry) then gosub stance parry
        var stance parry
    }



    if ($monstercount > 1 && $mana > 80) then {
        if ($Targeted_Magic.LearningRate < 34 || $monstercount > 2) then {
            gosub tm
        } else {
            gosub brawl
        }
    } else {
        if $mana > 80 then gosub prep mb 20
        #if ($Appraisal.LearningRate < 34) then gosub app celpeze
        #if ($Perception.LearningRate < 34) then gosub hunt
        #if ($Stealth.LearningRate < 34) then gosub hide
        gosub doNonCombatSkill
        if "$preparedspell" != "None" then gosub cast
        gosub attack bob
        gosub attack circle
        gosub attack weave
    }
    if $monsterdead > 0 then gosub Skinning
goto loop


tm:
    if ($mana < 80) then gosub waitMana
    gosub prep pd 20
    gosub target
    #if ($Appraisal.LearningRate < 34) then gosub app celpeze
    #if ($Perception.LearningRate < 34) then gosub hunt
    #if ($Stealth.LearningRate < 34) then gosub hide
    gosub doNonCombatSkill
    gosub cast
return


brawl:
    gosub prep mb 20
    #if ($Appraisal.LearningRate < 34) then gosub app celpeze
    #if ($Perception.LearningRate < 34) then gosub hunt
    #if ($Stealth.LearningRate < 34) then gosub hide
    gosub doNonCombatSkill
    gosub cast
    gosub attack punch
    gosub attack elbow
    gosub attack circle
return


waitMana:
    pause 1
    if $mana < 80 then goto waitMana
    return


doNonCombatSkill:
    put #echo #888800 Doing %nonCombatSkills.list(%nonCombatSkills.index)
    if (%nonCombatSkills.list(%nonCombatSkills.index) = stealth) then {
        if ($Stealth.LearningRate < 34) then {
            gosub hide
        } else {
            pause 3
        }
    }

    if (%nonCombatSkills.list(%nonCombatSkills.index) = perception) then {
        if ($Perception.LearningRate < 34) then {
            gosub hunt
        } else {
            pause 3
        }
    }

    if (%nonCombatSkills.list(%nonCombatSkills.index) = appraisal) then {
        if ($Appraisal.LearningRate < 34) then {
            gosub app celpeze
        } else {
            pause 3
        }
    }

    math nonCombatSkills.index add 1
    if (%nonCombatSkills.index > %nonCombatSkills.length) then var nonCombatSkills.index 0
    return
