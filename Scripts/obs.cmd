
include libsel.cmd

#debug 4

####### CONFIG #######
var cambrinth yoakena globe
######################

var checkPredState 1
var isObsOnCd 0


var objects.magic Ismenia|Durgaulda|Dawgolesh|Toad
var objects.lore forge|Amlothi|Verena|Phoenix
#var objects.offense Er'qutra|Estrilda|Szeldia|forge|Spider
var objects.offense Estrilda|Szeldia|forge|Spider
var objects.defense Merewalda|Dawgolesh|Penhetia|Giant
var objects.survival Morleena|Yoakena|Er'qutra|Ram

var magicPredState null
var lorePredState null
var offensePredState null
var defensePredState null
var survivalPredState null

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

#action math objIndex add 1 when ^What did you want to center the telescope on
action math objIndex add 1 when ^You peer aimlessly through your telescope

var skillsets magic|lore|offense|defense|survival
eval skillsets.len count("%skillsets", "|")
var skillsets.index 0

var objIndex 0

loop:
    if "%magicPredState" = "null" then gosub predState
    gosub checkBuffs
    if %checkPredState = 1 then gosub predState
    if %isObsOnCd = 0 then {
        gosub obs
    } else {
        #gosub runestone
        gosub waiting
    }
    goto loop
    #goto waiting

runestone:
    if ("$lefthandnoun" != "runestone") then {
        gosub stow left
        gosub get my sunstone runestone
    }
    gosub focus my runestone
    pause 2
    return

waiting:
    pause 2
    return

obs:
    var skillset %skillsets(%skillsets.index)

    if "%%skillsetPredState" = "powerful" OR "%%skillsetPredState" = "complete" then {
        var objIndex 0
        math skillsets.index add 1
        if %skillsets.index > %skillsets.len then var skillsets.index 0
         return
    }

    var objList %objects.%skillset

    eval len count("%objList", "|")

    if (%objIndex > %len) then var objIndex 0

    if ("$righthandnoun" != "telescope") then {
        if ("$righthand" != "Empty") then gosub stow right
        gosub get my telescope
    }

    gosub stow left

    #gosub open my telescope
    gosub center my telescope on %objList(%objIndex)
    gosub peer my telescope

    #math objIndex add 1
    return


predState:
    gosub predict state all
    var checkPredState 0
    return


checkBuffs:
    var buffs cv|pg|aus
    var buffVars ClearVision|PiercingGaze|AuraSight

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
