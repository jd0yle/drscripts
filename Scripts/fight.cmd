include libsel.cmd


var attacks
var doAnalyze 1
var lastAnalyzeTime 0

var nextHuntAt 0
var nextHideAt 0
var nextAppAt 0

var weapons.skills Brawling|Small_Edged
var weapons.items Empty|haralun scimitar
var weapons.index 0
eval weapons.length count("%weapons.skills", "|")
var weapons.lastChangeAt 0


#action var attacks $2; goto doAnalyzedAttacks when ^(Balance reduction|Armor reduction|A chance for a stun) can be inflicted.* by landing (.*)

action send adv when ^You must be closer to use tactical abilities on your opponent.
action var doAnalyze 1 when ^Utilizing \S+ tactics
action var doAnalyze 0; var attacks $2 when ^(Balance reduction|Armor reduction|A chance for a stun) can be inflicted.* by landing (.*)
action var doAnalyze 1 when ^You can no longer see openings
action var doAnalyze 1 when You fail to find any
action var doAnalyze 1 when ^ then lies still\.$

action send circle when ^Analyze what


timer start


loop:
    if $monsterdead > 0 then {
        gosub Skinning
        gosub loot
    }

    gosub buffs

    gosub checkWeaponSkills

    gosub huntHide

    #if ("$righthandnoun" != "scimitar") then gosub get my scimitar

    #if $monstercount > 0 && %doAnalyze = 1 then {
    if $monstercount > 0 then {
        gosub analyze
        var lastAnalyzeTimeAt %t
    }

    if (evalmath(%t - %lastAnalyzeTime) > 60) then gosub analyze

    if %doAnalyze = 0 then {
        goto doAnalyzedAttacks
    }
    goto loop


doAnalyzedAttacks:
    if ($monstercount < 2) then {
        pause 4
        goto loop
    }
    eval attacks replace("%attacks", " and", ",")
    eval attacks replace("%attacks", "a ", "")
    eval attacks replace("%attacks", "an ", "")
    eval attacks replace("%attacks", ",", "|")
    eval attacks replace("%attacks", ".", "")
    eval attacks replace("%attacks", " ", "")
    eval length count("%attacks", "|")
    var index 0

    #echo %attacks
    if (!contains("$monsterlist", "sleeping")) then gosub prep mb
    pause 4
    gosub cast

attackLoop:
    gosub attack %attacks(%index)
    math index add 1
    if (%index > %length) then goto loop
    goto attackLoop


buffs:
    if ($SpellTimer.SeersSense.active = 0) then {
        put .cast seer
        waitforre ^CAST DONE
        return
    }

    if ($SpellTimer.ManifestForce.active = 0) then {
        put .cast maf
        waitforre ^CAST DONE
        return
    }
    return


checkWeaponSkills:
    echo Checking Weapons... %weapons.skills(%weapons.index) - $%weapons.skills(%weapons.index).LearningRate
    echo Checking timer... evalmath(%weapons.lastChangeAt + 60) < %t
    if ($%weapons.skills(%weapons.index).LearningRate > 20) then {
        #if (evalmath(%weapons.lastChangeAt + 60) < %t ) then {
            math weapons.index add 1
            if (%weapons.index > %weapons.length) then var weapons.index 0
            var weapons.lastChangeAt %t
        #}
    }

    if ("$righthand" != "%weapons.items(%weapons.index)") then {
        gosub stow right
        if ("%weapons.items(%weapons.index)" != "Empty") then gosub get my %weapons.items(%weapons.index)
    }

    return


huntHide:
    if (%t > %nextHuntAt) then {
        gosub hunt
        evalmath nextHuntAt 120 + %tg
        return
    }
    if (%t > %nextHideAt) then {
        gosub hide
        evalmath nextHide 90 + %tg
        return
    }
    return
