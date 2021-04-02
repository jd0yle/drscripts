include libmaster.cmd
action send retreat when ^You are far too occupied by present matters to immerse yourself in matters of the future.

###############################
# Variables
###############################
var skillset null
var predictTarget $charactername
var focusItem totem

if_1 then {
    var skillset %1
}
if_2 then {
    var predictOn %2
}


if ($SpellTimer.DestinyCipher.active = 0 || $SpellTimer.DestinyCipher.duration < 2) then {
    gosub prep dc
    gosub get my %focusItem
    gosub invoke my %focusItem
    waitforre ^You feel fully prepared to cast your spell
    gosub stow my %focusItem
    gosub cast
}


if (%skillset = null) then gosub findSkillSet


if (%skillset != null) then {
    if ($monstercount > 0) then gosub stance shield
    if ($monstercount > 0) then gosub retreat
    gosub align %skillset
    gosub get my divination bones

    if ($monstercount > 0) then gosub retreat
    gosub roll bones at %predictTarget
    gosub stow my bones
}

goto predictDone


###############################
###      findSkillSet
###############################
findSkillSet:
    var skillset null
    var skillsets lore|survival|defens|offens|magic
    eval len count("%skillsets", "|")
    var index 0

    gosub checkPredState

    findSkillSetLoop:
        if ($predictPool.%skillsets(%index) = complete) then {
        #if ("$predictPool.%skillsets(%index)" != "no") then {
            var skillset %skillsets(%index)
            return
        }
        math index add 1
        if (%index > %len) then {
            put #echo >Log All pred pools empty
            return
        }
    goto findSkillSetLoop



###############################
###      checkPredState
###############################
checkPredState:
    if ($lastPredictionAt > $lastPredStateAllAt || $lastObserveAt > $lastPredStateAllAt) then {
        #echo "No PRED STATE ALL since last PREDICTION, do predstateall"
        gosub predict state all
    }
    return


predictDone:
    pause .2
    put #parse PREDICT DONE
    exit