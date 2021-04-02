include libina.cmd
action var needPredict true when ^Too many futures cloud your mind - you learn nothing\.
action send retreat when ^You are far too occupied
action var tooInjured true when ^You are unable to hold the
action var tooInjured true when ^The pain is too much

##########
# Variables
##########
if (!($lastObserveAt > 0)) then put #var lastObserveAt 0
var previousLastObserveAt $lastObserveAt
evalmath timeSinceLastObserve $gametime - $lastObserveAt
if (%timeSinceLastObserve > 240) then var force true

var force false
if_1 then {
    if (%1 = force) then {
        var force true
    }
}

##########
# CONSTELLATIONS AND PLANETS TO OBSERVE PER SKILLSET
##########
var skillset null
var skillsets defens|offens|survival|magic|lore
eval len count("%skillsets", "|")
var index 0

var defens Katamba
var lore Xibar|Raven
var magic Yavash|
var offens Cat
var survival Heart|Lion
var objindex 0
var objlength 0


##########
# Main
##########
observeMain:
    if (%force = false && $isObsOnCd = true) then goto done
    gosub checkPredState
    gosub findSkillSet
    if (%skillset = null) then goto observeDoneAllFull
    if ($monstercount > 0) then gosub stance shield
    var objects %%skillset
    eval objlength count("%objects", "|")
    if ($SpellTimer.AuraSight.active = 0 || $SpellTimer.AuraSight.duration < 2) then {
         gosub prep aus 10
         waitforre ^You feel fully prepared to cast your spell
         gosub cast
    }
    if ($SpellTimer.PiercingGaze.active = 0 || $SpellTimer.PiercingGaze.duration < 2) then {
        gosub prep pg 10
        waitforre ^You feel fully prepared to cast your spell
        gosub cast
    }

observeMainain.loop:
    if ("$lefthandnoun" != "telescope") then {
        gosub stow right
        gosub stow left
        gosub get my telescope
        gosub swap
    }
    gosub this.retreat
    if (%tooInjured = true) then {
        gosub observe %objects(%objindex) in sky
    } else {
        gosub center my telescope on %objects(%objindex)
        gosub this.retreat
        gosub peer my telescope
    }
    math objindex add 1
    if (%objindex > %objlength) then {
        gosub nextSkillSet
        var objindex 0
        var objects %%skillset
        eval objlength count("%objects", "|")
    }
    if (%needPredict = true) then {
        put .khurpredict
        waitforre ^PREDICT DONE
        var nextPredict false
    }
    if ($lastObserveAt != %previousLastObserveAt || %objindex > %objlength) then goto observeDone
    goto observeMainain.loop

##########
# Check Prediction State
##########
checkPredState:
    if ($lastPredictionAt > $lastPredStateAllAt) then {
        gosub predict state all
    } else {
        # echo "predictPool.* is accurate"
        return
    }
    goto checkPredState

##########
# Find Skill Set
##########
findSkillSet:
    # echo findSkillSet Checking index = %index %skillsets(%index) $predictPool.%skillsets(%index)
    if ($predictPool.%skillsets(%index) != complete) then {
        var skillset %skillsets(%index)
        return
    }
    math index add 1
    if (%index > %len) then return
    goto findSkillSet

this.retreat:
    if ($monstercount > 0) then gosub retreat
    return

nextSkillSet:
    math index add 1
    if (%index > %len) then goto observeDone
    var skillset %skillsets(%index)
    return

observeDoneAllFull:
    if (!($lastEchoPredStateAllAt > 0)) then put #var lastEchoPredStateAllAt 0
    evalmath timeSinceLastEchoPredStateAll $gametime - $lastEchoPredStateAllAt
    if (%timeSinceLastEchoPredStateAll > 3600) then {
        put #echo >Log #f6d1ff [observe] All Pools Full
        put #var lastEchoPredStateAllAt $gametime
    }
    put #var lastObserveAt $gametime
    goto observeDone

observeDoneInjured:
    goto observeDone

observeDone:
    if ("$righthandnoun" = "telescope" || "$lefthandnoun" = "telescope") then {
      gosub close my telescope
      gosub stow my telescope
    }
    pause .2
    put #parse OBSERVE DONE
    exit