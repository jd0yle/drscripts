include libsel.cmd

####### CONFIG #######

var cambrinth yoakena globe

######################

var utility pg|seer|shadows
var aug seer
var warding maf



var spells.abbr maf|aus|pg
var spells.names ManifestForce|AuraSight|PiercingGaze
var spells.prepAt 20|20|20|20
var spells.addMana 20|20|20|20
var spells.addTimes 20|20|20|20
var index 0
eval spells.len count("%spells.abbr", "|")

init:
    var index 0
    initLoop:
    var curr %spells(%index).abbr
    if (!%spells.%curr.prepAt) then var %spells.%curr.prepAt 20
    if (!%spells.%curr.addMana) then var %spells.%curr.addMana 20
    if (!%spells.%curr.addTimes) then var %spells.%curr.prepAt 4
    math index add 1
    if (%index <= %spells.len) then goto initLoop

temp:
    var index 0
    tempLoop:
    var curr %spells(%index).abbr
    echo %spells.%curr.prepAt
    echo %spells.%curr.addMana
    echo %spells.%curr.addTimes
    math index add 1
    if (%index <= %spells.len) then goto tempLoop

exit

action var isFullyPrepped 1 when ^You feel fully prepared to cast your spell.

loop:
    if (%index > %len) then var index 0

    if ($mana < 80) then gosub waitMana
    gosub buff %combatSpells(%index)

    math index add 1
    goto loop

 buff:
    var spell $1
    var target $charactername
    var isFullyPrepped 0

    if ("$preparedspell" != "None") then gosub release spell

    if ("%combatSpells(%index)" = "col") then {
        if ($Time.isYavashUp = 1) then var target yavash
        if ($Time.isXibarUp = 1) then var target xibar
        if ($Time.isKatambaUp = 1) then var target katamba
        if ("%target" = "$charactername") then return
    }
    gosub prep %spell 20
    if ("$righthandnoun" != "globe") then gosub get %cambrinth
    gosub charge my %cambrinth 20
    gosub charge my %cambrinth 20
    if ("%spell" != "seer") then {
        gosub charge my %cambrinth 20
        gosub charge my %cambrinth 20
    }
    gosub focus my %cambrinth
    gosub invoke my %cambrinth
    if (%isFullyPrepped != 1) then gosub waitForPrep
    gosub cast %target
    return

waitForPrep:
    pause 1
    if (%isFullyPrepped = 1) then return
    goto waitForPrep

waitMana:
    pause 1
    if ($mana > 80) then return
    goto waitMana


 done:
     gosub stow my %cambrinth
     exit
