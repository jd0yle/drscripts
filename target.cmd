include libmaster.cmd
include var_mobs.cmd
action put #tvar noObserveRoom $roomid when (can|can't|cannot) see the sky\.$
action goto targetLoop when ^Your concentration slips for a moment|^Your concentration lapses
action goto targetFaceNext when ^Target what|^Your pattern dissipates with the loss of your target\.

#####################
# Variables
#####################
if (!($lastHuntGametime >0)) then put #var lastHuntGametime 0
if (!($lastCyclicGametime >0)) then put #var lastCyclicGametime 0

var useApp 0
var useHunt 1
var usePerc 1
var useAstrology 0
var useSano 1
var useShadowWeb 0
var useSkin 1


var opts %1
if ("%opts" = "backtrain") then {
    var useApp 1
    var useForage 0
    var useHunt 1
    var usePerc 1
    var useSano 1
    var useShadowWeb 1
    var useSkin 0
}
#####################
# Main
#####################
targetSkillCheck:
    gosub targetCheckDeadMob
    if ("%opts" = "backtrain") then {
        if ($Debilitation.LearningRate < 30) then goto targetLoop
    } else {
        if ($Targeted_Magic.LearningRate < 30) then goto targetLoop
    }
    goto targetExit

    targetLoop:
    if ($mana < 80) then {
        pause 10
    }
    if (%useApp = 1) then gosub targetApp
    if (%useHunt = 1) then gosub targetHunt
    if (%usePerc = 1) then gosub targetPerc
    if (%useAstrology = 1) then gosub targetAstrology
    if (%useSano = 1 && $Arcana.LearningRate < 15 && $concentration > 99) then {
        gosub gaze my sano crystal
    }
    if ($monstercount = 0) then {
        gosub targetForage
    }
    if ($monstercount = 0) then {
        pause 5
        goto targetLoop
    }
    if ($Debilitation.LearningRate < 30) then {
        if (%useShadowWeb = 1) then {
            if ($SpellTimer.ShadowWeb.active = 1) then {
                eval nextCyclicAt $lastCyclicGametime + 300
                if (%nextCyclicAt < $gametime) then {
                    gosub release cyclic
                }
            }
            gosub prep shw
            waitforre ^You feel fully prepared
            gosub cast
            put #var lastCyclicGametime $gametime
        } else {
            gosub prep $char.combat.spell.Debilitation $char.combat.prep.Debilitation
            if ($char.combat.harness.Debilitation <> 0) then {
                gosub harness $char.combat.prep.Debilitation
            }
            waitforre ^You feel fully prepared
            gosub cast
        }
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
        } else gosub skin
        gosub loot
        put .loot
        waitforre ^LOOT DONE
    }
    return


targetFaceNext:
    put face next
    goto targetLoop


targetForage:
    if (%monstercount <> 0) then return
    if ($Outdoorsmanship.LearningRate < 30) then {
        gosub collect dirt
        gosub kick pile
    }
    return


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
        put .khurcombat
    }
    exit