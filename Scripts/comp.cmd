include libsel.cmd

var numberOfCompendiums third
var container thigh bag

var timeStudied 0

if ($righthandnoun != compendium && $righthand != Empty) then gosub stow right

loop:
    if ("$righthandnoun" != "compendium") then {
        gosub stow right
        gosub get my %numberOfCompendiums compendium
    }
    gosub studyPages
    gosub put my compendium in my %container
    var timeStudied 0
    goto loop


studyPages:
    gosub turn my compendium
    gosub study my compendium
    math timeStudied add 1
    if (%timeStudied > 9) then return
    goto studyPages


