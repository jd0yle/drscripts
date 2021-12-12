include libmaster.cmd
action send retreat when ^You are far too occupied by present matters to immerse yourself in matters of the future.

###############################
###      Variables
###############################
var skillset null
var predictOn $charactername

if_1 then {
    var skillset %1
}

if_2 then {
    var predictOn %2
}


###############################
###      Main
###############################
if ($monstercount = 0 && $char.predict.useDc = 1 && ($SpellTimer.DestinyCipher.active = 0 || $SpellTimer.DestinyCipher.duration < 2)) then {
      if ($monstercount > 0) then {
          gosub stance shield
          gosub stow right
          gosub retreat
      }
      gosub runScript cast dc
}

# Pretty sure PG doesn't need to be up for predictions...
#if ($SpellTimer.PiercingGaze.active = 0 || $SpellTimer.PiercingGaze.duration < 2) then gosub runScript cast pg

if ($SpellTimer.AuraSight.active = 0 || $SpellTimer.AuraSight.duration < 2) then gosub runScript cast aus

# If no skill or skillset was specified, find a skillset with full pool then use these specified skills for each skillset
if (%skillset = null) then gosub findSkillSet

if ("%skillset" = "lore") then var skillset tactics
if ("%skillset" = "survival") then var skillset first aid
if ("%skillset" = "defens") then var skillset parry
if ("%skillset" = "magic") then var skillset sorcery
if ("%skillset" = "offens") then var skillset offhand



if ("%skillset" = "null" && "$char.predict.preferred.skill" != "") then {
	if ("$predictPool.$char.predict.preferred.skillset" = "complete") then var skillset $char.predict.preferred.skill
}

if (%skillset != null) then {
    if ($monstercount > 0) then gosub stance shield
    if ($monstercount > 0) then gosub retreat
    gosub align %skillset
    gosub get my $char.predict.tool

    if ($monstercount > 0) then gosub retreat
    gosub roll $char.predict.tool at %predictOn
    gosub put my $char.predict.tool in my $char.predict.tool.container
}
goto done


###############################
###      findSkillSet
###############################
findSkillSet:
    var skillset null
    var skillsets defens|survival|magic|lore|offens
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
        if (%index > %len) then return
    goto findSkillSetLoop


###############################
###      checkPredState
###############################
checkPredState:
    if (!($lastPredictionAt > -1)) then put #var lastPredictionAt 1
    if ($lastPredictionAt > $lastPredStateAllAt || $lastObserveAt > $lastPredStateAllAt) then {
        #echo "No PRED STATE ALL since last PREDICTION, do predstateall"
        gosub predict state all
    }
    return


done:
    pause .2
    put #parse PREDICT DONE
    exit