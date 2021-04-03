include libmaster.cmd
action put #tvar noObserveRoom $roomid when (can|can't|cannot) see the sky\.$
action goto targetLoop when ^Your concentration slips for a moment|^Your concentration lapses
action goto targetSkin when eval $skin = 1
action goto targetFaceNext when ^Target what|^Your pattern dissipates with the loss of your target\.

#####################
# Variables
#####################
if (!($lastAppGametime >0)) then put #var lastAppGametime 0
if (!($lastHuntGametime >0)) then put #var lastHuntGametime 0
if (!($lastPercGametime >0)) then put #var lastPercGametime 0


#####################
# Main
#####################
targetSkillCheck:
    if ($Targeted_Magic.LearningRate < 30) then goto targetLoop
    goto targetExit

    targetLoop:
    if ($mana < 80) then {
        pause 10
    }
    gosub targetApp
    gosub targetHunt
    gosub targetPerc
    if ("$charactername" = "Khurnaarti") then {
        if ($roomid <> $noObserveRoom) then {
            if ($Astrology.LearningRate < 33) then gosub observe.onTimer
        }
    }
    gosub prep $char.combat.spell.Debilitation $char.combat.prep.Debilitation
    if ($char.combat.harness.Debilitation <> 0) then {
        gosub harness $char.combat.prep.Debilitation
    }
    waitforre ^You feel fully prepared
    gosub cast
    gosub target $char.combat.spell.Targeted_Magic $char.combat.prep.Targeted_Magic
    waitforre ^Your formation of a targeting pattern around
    gosub cast
    goto targetSkillCheck


#####################
# Utilities
#####################
targetApp:
    if ($Appraisal.LearningRate > 15) then {
        return
    }
    evalmath nextAppAt $gametime + 60
    if (%nextAppAt < $gametime) then {
        return
    }
    gosub retreat
    gosub app $char.appraise.item
    put #var lastAppGametime $gametime
    return


targetAstrology:
    if ($Astrology.LearningRate > 30) then {
        return
    }
    gosub observe.onTimer
    waitforre ^OBSERVE DONE
    goto targetSkillCheck


targetFaceNext:
    put face next
    goto targetLoop


targetHunt:
    if ($Perception.LearningRate > 15) then {
        return
    }
    evalmath nextHuntAt $gametime + 75
    if (%nextHuntAt < $gametime) then {
        return
    }
    gosub hunt
    put #var lastHuntGametime $gametime
    return


targetPerc:
    if ($Attunement.LearningRate > 15) then {
        return
    }
    evalmath nextPercAt $gametime + 60
    if (%nextPercAt < $gametime) then {
        return
    }
    gosub perc mana
    put #var lastPercGametime $gametime
    return


targetSkin:
    pause 1
    gosub skin
    pause 1
    gosub loot
    goto targetLoop


targetExit:
    if ("$charactername" = "Khurnaarti") then {
        put .magic
    }
    exit