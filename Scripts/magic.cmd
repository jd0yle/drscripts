include libsel.cmd

####### CONFIG #######

var cambrinth yoakena globe

######################

var utility pg|seer|shadows
var aug seer
var warding maf



var spells.abbr maf|aus|pg
var spells.names ManifestForce|AuraSight|PiercingGaze

var index 0
eval len count("%spells.abbr", "|")



action var isFullyPrepped 1 when ^You feel fully prepared to cast your spell.

loop:
    if (%index > %len) then {
        var index 0
        gosub perc
    }

    if ($mana < 80) then gosub waitMana
    gosub buff %spells.abbr(%index)

    math index add 1
    goto loop

 buff:
    var spell $1
    var target $charactername
    var isFullyPrepped 0

    if ("$preparedspell" != "None") then gosub release spell

    if ("%spells.abbr(%index)" = "col") then {
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
