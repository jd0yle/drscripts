include libsel.cmd

action send retreat when ^You are far too occupied by present matters to immerse yourself in matters of the future.

var skillset null
var predictOn $charactername

if_1 then {
    var skillset %1
}

if_2 then {
    var predictOn %2
}


if (%skillset = null) then gosub findSkillSet

if (%skillset != null) then {
    if ($monstercount > 0) then gosub stance shield
    if ($monstercount > 0) then gosub retreat
    gosub align %skillset
    gosub get my divination bones

    if ($monstercount > 0) then gosub retreat
    gosub roll bones at %predictOn
    gosub put my bones in my telescope case
}

goto done


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



done:
    pause .2
    put #parse PREDICT DONE
    exit