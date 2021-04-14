include libmaster.cmd
include var_mobs.cmd
action put #tvar noObserveRoom $roomid when (can|can't|cannot) see the sky\.$
action goto targetLoop when ^Your concentration slips for a moment|^Your concentration lapses
action goto targetFaceNext when ^Target what|^Your pattern dissipates with the loss of your target\.

#####################
# Variables
#####################
if (!($lastHuntGametime >0)) then put #var lastHuntGametime 0

var useApp 0
var useHunt 1
var usePerc 1
var useAstrology 0

#####################
# Main
#####################
targetSkillCheck:
    gosub targetCheckDeadMob
    if ($Targeted_Magic.LearningRate < 30) then goto targetLoop
    goto targetExit

    targetLoop:
    if ($mana < 80) then {
        pause 10
    }
    if (%useApp = 1) then gosub targetApp
    if (%useHunt = 1) then gosub targetHunt
    if (%usePerc = 1) then gosub targetPerc
    if (%useAstrology = 1) then gosub targetAstrology
    if ($Debilitation.LearningRate < 30) then {
        gosub prep $char.combat.spell.Debilitation $char.combat.prep.Debilitation
        if ($char.combat.harness.Debilitation <> 0) then {
            gosub harness $char.combat.prep.Debilitation
        }
        waitforre ^You feel fully prepared
        gosub cast
    }
    gosub target $char.combat.spell.Targeted_Magic $char.combat.prep.Targeted_Magic
    pause 6
    #waitforre ^Your formation of a targeting pattern around
    gosub cast
    goto targetSkillCheck


#####################
# Utilities
#####################
targetAstrology:
    if ($Astrology.LearningRate < 33) then gosub observe.onTimer
    return


targetApp:
    if ($Appraisal.LearningRate < 33) then gosub appraise.onTimer
    return


targetCheckDeadMob:
    if (matchre ("$roomobjs", "(%critters) ((which|that) appears dead|(dead))")) then {
        var mobName $1

        if (%useSkin = 1 && matchre("%skinnablecritters", "%mobName")) then {
            if (%arrangeForPart = 1) then gosub arrange for part
            if (%arrangeFull = 1) then gosub arrange full
            gosub skin
        }
        gosub loot
    }
    return


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
    if ($Attunement.LearningRate < 33) then gosub perc.onTimer
    return


targetExit:
    if ("$charactername" = "Khurnaarti") then {
        put .magic
    }
    exit