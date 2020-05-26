include libsel.cmd

####### CONFIG #######

var ritualFocus S'kra totem
var isFocusWorn 0
var defaultMana 700

######################

var stat %1
if_2 {
    var mana %2
} else {
    var mana %defaultMana
}

var cha Durgaulda|Yoakena|Ismenia|Er'qutra
var wis %cha
var dis Estrilda|Penhetia|Morleena|Amlothi
var int %dis
var ref Verena|Szeldia|Dawgolesh|Merewalda
var agi %ref

var stats cha|wis|dis|int|ref|agi
var isFullyPrepped 0

var isPlanetUp 0
var planetName

action var isFullyPrepped 1 when ^You feel fully prepared to cast your spell.

action var isPlanetUp 0 when ^checkPlanetUpFalse ^Your search for the planet (\S+) turns up fruitless\.$
action var isPlanetUp 1 when ^The planet (\S+) is too faint for you to pick out with your naked eye.
action var isPlanetUp 1 when ^You focus your enhanced sight
action var isPlanetUp 1 when ^You learned something useful from your observation.
action var isPlanetUp 1 when ^You are unable to make use of this latest observation.
action var isPlanetUp 1 when ^You see nothing regarding the future.
action var isPlanetUp 1 when ^Clouds obscure the sky


if (!contains("%stats", "%stat")) then {
    put #echo #FF0000 [.iots] ERROR: `%stat` not a valid option, must be one of: %stats
    exit
}

gosub stowing

if (0) then {
    if ($SpellTimer.AuraSight.active != 1) then {
        put .cast aus
        waitforre ^CAST DONE
    }

    if ($SpellTimer.PiercingGaze.active != 1) then {
        put .cast pg
        waitforre ^CAST DONE
    }
}

echo %%stat

#action echo $1 when (%%stat)

var planets %%stat
eval length count("%planets", "|")
var index 0


gosub findPlanet
gosub iotsCast


iotsCast:
    gosub prep iots %mana
    if (%isFocusWorn = 1) then {
        gosub remove my %ritualFocus
    } else {
        gosub get my %ritualFocus
    }
    gosub invoke my %ritualFocus
    if (%isFullyPrepped != 1) then gosub waitPrep
    gosub cast %planetName
    if (%isFocusWorn = 1) then {
        gosub wear my %ritualFocus
    } else {
        gosub stow my %ritualFocus
    }

    put invoke circle
    exit


waitPrep:
    pause 1
    if (%isFullyPrepped = 1) then return
    goto waitPrep


findPlanet:
    var planetName %planets(%index)
    gosub observe %planetName in sky
    if (%isPlanetUp = 1) then return
    math index add 1
    if (%index > %length) then goto noPlanet
    goto findPlanet


noPlanet:
    put #echo #BB7700 No planets are up for %stat (%planets)
    exit
