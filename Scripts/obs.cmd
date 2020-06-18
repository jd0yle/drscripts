############################################################################
# .obs
# Selesthiel - justin@jmdoyle.com
# Observes relevant objects on a timer, keeps buffed with PG and AUS
############################################################################

include libsel.cmd

####### CONFIG #######

var cambrinth yoakena globe

######################

var checkPredState 1
var isObsOnCd 0
var doPred 0

var objects.magic Ismenia|Durgaulda|Dawgolesh|Toad|Yavash
var objects.lore forge|Amlothi|Verena|Phoenix|Xibar
var objects.offense Estrilda|Szeldia|forge|Spider
var objects.defense Merewalda|Dawgolesh|Penhetia|Giant|Katamba
var objects.survival Morleena|Yoakena|Er'qutra|Ram

var magicPredState null
var lorePredState null
var offensePredState null
var defensePredState null
var survivalPredState null

var skillsets magic|lore|offense|defense|survival
eval skillsets.len count("%skillsets", "|")
var skillsets.index 0

action var isObsOnCd 0 when ^You feel you have sufficiently pondered your latest observation
action var isObsOnCd 1 when ^You have not pondered your last observation sufficiently.
action var isObsOnCd 1 when ^You are unable to make use of this latest observation
action var isObsOnCd 1 when ^You learned something useful from your observation.
action var isObsOnCd 1 when ^Although you were nearly overwhelmed by some aspects of your observation

action var checkPredState 1 when ^You feel you have sufficiently pondered your latest observation.

action var magicPredState $1 when (\S+) understanding of the celestial influences over magic.$
action var lorePredState $1 when (\S+) understanding of the celestial influences over lore.$
action var offensePredState $1 when (\S+) understanding of the celestial influences over offensive combat.$
action var defensePredState $1 when (\S+) understanding of the celestial influences over defensive combat.$
action var survivalPredState $1 when (\S+) understanding of the celestial influences over survival.$

action math objIndex add 1 when ^You peer aimlessly through your telescope

var doResearch 1
action var doResearch 1 when ^You make definite progress in your
action var doResearch 1 when ^Distracted by your
action var doResearch 1 when ^Breakthrough
action var doResearch 1 when ^You decide to stop researching

action var doResearch 0 when ^You are already busy at research
action var doResearch 0 when ^You continue to flex the mana streams
action var doResearch 0 when ^You tentatively reach out and begin manipulating the mana streams
action var doResearch 0 when ^Though it is taking much of your attention, you feel your research is going well.

var researchTopics.list warding|augmentation|stream|utility|fundamental
var researchTopics.skills Warding|Augmentation|Attunement|Utility|Primary_Magic
var researchTopics.index 0
eval researchTopics.length count("%researchTopics.list", "|")

var objIndex 0

loop:
    if "%magicPredState" = "null" then gosub predState
    #gosub checkBuffs
    if (%doResearch = 1) then {
        #gosub startResearch
    }

    if %checkPredState = 1 then gosub predState
    if %isObsOnCd = 0 then {
        gosub obs
    } else {
        gosub waiting
    }
    goto loop

waiting:
    if (1 = 0 && $Sorcery.LearningRate < 34) then {
        if ("$righthandnoun" != "runestone" && "$lefthandnoun" != "runestone") then {
            gosub stow right
            gosub get my sunstone runestone
        }
        gosub focus my runestone
    } else {
        pause 2
    }
    return


startResearch:
    var idx 0
    var researchTopics.index 0

    startResearchLoop:
        echo $%researchTopics.skills(%idx).LearningRate < $%researchTopics.skills(%researchTopics.index).LearningRate
        if ($%researchTopics.skills(%idx).LearningRate < $%researchTopics.skills(%researchTopics.index).LearningRate) then {
            var researchTopics.index %idx
        }
        math idx add 1
        if (%idx <= %researchTopics.length) then goto startResearchLoop


    pause
    put research %researchTopics.list(%researchTopics.index) 300
    pause
    return





obs:
    var skillset %skillsets(%skillsets.index)

    if "%%skillsetPredState" = "complete" then {
        var objIndex 0
        math skillsets.index add 1
        if %skillsets.index > %skillsets.len then var skillsets.index 0
        return
    }

    var objList %objects.%skillset

    eval len count("%objList", "|")

    if (%objIndex > %len) then {
        var objIndex 0
        math skillsets.index add 1
        if %skillsets.index > %skillsets.len then var skillsets.index 0
    }

    if ("$righthandnoun" != "telescope") then {
        if ("$righthand" != "Empty") then gosub stow right
        gosub get my telescope
    }

    gosub stow left

    gosub center my telescope on %objList(%objIndex)
    gosub peer my telescope

    if (%isObsOnCd = 1) then {
       # gosub put my tele in my tele case
       # gosub align %skillset
       # gosub predict future $charactername
       # echo predictionCount: $predictionCount
      #  put title pre choose moonm harbin
        pause
    }

    return


predState:
    gosub predict state all
    var checkPredState 0
    var objIndex 0
    math skillsets.index add 1
    if %skillsets.index > %skillsets.len then var skillsets.index 0
    return


checkBuffs:
    var buffs pg|aus|gaf
    var buffVars PiercingGaze|AuraSight|GaugeFlow

    var i 0
    eval len count("%buffs", "|")
    gosub buffLoop
    return

buffLoop:
    if %i > %len then return
    var name %buffVars(%i)

    if $SpellTimer.%name.active != 1 then gosub castBuff %buffs(%i)
    math i add 1
    goto buffLoop


castBuff:
    var spell $0
    if ("$preparedspell" != "None") then gosub rel
    if ($mana < 80) then gosub waitMana
    gosub prep %spell 20
    gosub stowing
    gosub get my %cambrinth
    gosub charge my %cambrinth 20
    gosub charge my %cambrinth 20
    gosub charge my %cambrinth 20
    gosub charge my %cambrinth 20
    gosub focus my %cambrinth
    gosub invoke my %cambrinth
    gosub cast
    gosub stow my %cambrinth
    return

waitMana:
    pause 2
    if ($mana < 80) then goto waitMana
    return
