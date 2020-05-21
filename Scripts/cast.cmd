include libsel.cmd

####### CONFIG #######

var cambrinth yoakena globe

######################

var useCambrinth 1

if ("%1" = "n") then {
    var useCambrinth 0
    shift
}

var spell %1

if_2 then {
    var target %2
} else {
    var target $charactername
}

var isFullyPrepped 0
var stowedItemNoun null

action var isFullyPrepped 1 when ^You feel fully prepared to cast your spell.

if ("$righthand" != "Empty" && "$lefthand" != "Empty") then {
    var stowedItemNoun $lefthandnoun
    gosub stow left
}

if ("$preparedspell" != "None") then gosub release spell
gosub prep %1 20
if (%useCambrinth = 1) then {
    gosub get my %cambrinth
    gosub charge my %cambrinth 20
    gosub charge my %cambrinth 20
    gosub charge my %cambrinth 20
    gosub charge my %cambrinth 10
    gosub focus my %cambrinth
    gosub invoke my %cambrinth
} else {
    gosub harness 20
    gosub harness 20
    gosub harness 20
    gosub harness 10
}
goto waitPrep

waitPrep:
pause 1
if %isFullyPrepped != 1 then goto waitPrep
gosub cast %target
gosub stow my %cambrinth

if ("%stowedItemNoun" != "null") then gosub get my %stowedItemNoun

put #parse CAST DONE
