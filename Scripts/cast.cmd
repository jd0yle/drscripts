include libsel.cmd

####### CONFIG #######

var cambrinth yoakena globe

######################

var spell %1
var isFullyPrepped 0
var stowedItemNoun null

action var isFullyPrepped 1 when ^You feel fully prepared to cast your spell.

if ("$righthand" != "Empty" && "$lefthand" != "Empty") then {
    var stowedItemNoun $lefthandnoun
    gosub stow left
}

if ("$preparedspell" != "None") then gosub release spell
gosub prep %1 20
gosub get my %cambrinth
gosub charge my %cambrinth 20
gosub charge my %cambrinth 20
gosub charge my %cambrinth 20
gosub charge my %cambrinth 20
gosub focus my %cambrinth
gosub invoke my %cambrinth
goto waitPrep

waitPrep:
pause 1
if %isFullyPrepped != 1 then goto waitPrep
gosub cast
gosub stow my %cambrinth

if ("%stowedItemNoun" != "null") then gosub get my %stowedItemNoun

put #parse CAST DONE
