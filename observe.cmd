include libsel.cmd

var force false
if_1 then {
    if (%1 = force) then {
        var force true
    }
}

var telescope clockwork telescope
var telescopeContainer telescope case


var skillset null
var skillsets magic|offens|defens|survival|lore
eval len count("%skillsets", "|")
var index 0

#####
# CONSTELLATIONS AND PLANETS TO OBSERVE PER SKILLSET
#####
var magic Ismenia|Durgaulda|Dawgolesh|Toad|Yavash
var lore forge|Amlothi|Verena|Phoenix|Xibar
var offens Estrilda|Szeldia|forge|Spider
var defens Merewalda|Dawgolesh|Penhetia|Giant|Katamba
var survival Morleena|Yoakena|Er'qutra|Ram
var objindex 0
var objlength 0

action send retreat when ^You are far too occupied
action var tooInjured true when ^You are unable to hold the
action var tooInjured true when ^The pain is too much


#
# Initialize $lastObserveAt if it doesn't have a valid value
#
if (!($lastObserveAt > 0)) then put #var lastObserveAt 0

var previousLastObserveAt $lastObserveAt

#
# The timer on observations is random from 2-4 minutes. If it has been longer than that, force it.
#
evalmath timeSinceLastObserve $gametime - $lastObserveAt
if (%timeSinceLastObserve > 240) then var force true



###############################
###      main
###############################
main:
    if (%force = false && $isObsOnCd = true) then goto done
    gosub checkPredState
    gosub findSkillSet

    if (%skillset = null) then goto doneAllFull

    if ($monstercount > 0) then gosub stance shield

    var objects %%skillset
    eval objlength count("%objects", "|")

    if ($SpellTimer.AuraSight.active = 0 || $SpellTimer.AuraSight.duration < 2) then {
        put .cast aus
        waitforre ^CAST DONE$
    }
    if ($SpellTimer.PiercingGaze.active = 0 || $SpellTimer.PiercingGaze.duration < 2) then {
        put .cast pg
        waitforre ^CAST DONE$
    }

    ###############################
    ###      main.loop
    ###############################
    main.loop:
        if ("$lefthandnoun" != "telescope") then {
            gosub stow right
            gosub stow left
            gosub get my %telescope
            gosub swap
        }
        gosub this.retreat
        #
        # If we can't use the telescope, just OBSERVE without it
        #
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
        if ($lastObserveAt != %previousLastObserveAt || %objindex > %objlength) then goto done
    goto main.loop



###############################
###      checkPredState
###############################
checkPredState:
    if ($lastPredictionAt > $lastPredStateAllAt) then {
        #echo "No PRED STATE ALL since last PREDICTION, do predstateall"
        gosub predict state all
    } else {
        # echo "predictPool.* is accurate"
        return
    }
    goto checkPredState



###############################
###      findSkillSet
###############################
findSkillSet:
    if ($predictPool.%skillsets(%index) != complete) then {
        var skillset %skillsets(%index)
        return
    }
    math index add 1
    if (%index > %len) then return
    goto findSkillSet



nextSkillSet:
    math index add 1
    if (%index > %len) then goto done
    var skillset %skillsets(%index)
    return



this.retreat:
    if ($monstercount > 0) then gosub retreat
    return


doneAllFull:
    if (!($lastEchoPredStateAllAt > 0)) then put #var lastEchoPredStateAllAt 0
    evalmath timeSinceLastEchoPredStateAll $gametime - $lastEchoPredStateAllAt
    if (%timeSinceLastEchoPredStateAll > 3600) then {
        put #echo >Log #f6d1ff [observe] All Pools Full
        put #var lastEchoPredStateAllAt $gametime
    }
    put #var lastObserveAt $gametime
    goto done


doneInjured:
    goto done

done:
    if ("$righthandnoun" = "telescope" || "$lefthandnoun" = "telescope") then gosub put my telescope in my %telescopeContainer
    pause .2
    put #parse OBSERVE DONE
    exit


