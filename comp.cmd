include libsel.cmd

action put #echo >Log Almanac: $1 when You believe you've learned something significant about (.*)!$

var numberOfCompendiums third
var container thigh bag

var timeStudied 0

if ($righthandnoun != compendium && $righthand != Empty) then gosub stow right

loop:
    if ("$righthandnoun" != "compendium") then {
        gosub stow right
        gosub get my %numberOfCompendiums compendium
        if ($Appraisal.LearningRate < 33) then gosub app my gem pouch
    }
    gosub studyPages
    gosub put my compendium in my %container
    var timeStudied 0
    goto loop


studyPages:
    evalmath nextStudyAt $lastAlmanacGametime + 600

    if (%nextStudyAt < $gametime) then {
        if ("$lefthandnoun" != "almanac" && "$righthandnoun" != "almanac") then {
            gosub get my almanac
        }
        gosub study my almanac
        gosub put my almanac in my thigh bag
        put #var lastAlmanacGametime $gametime
    }
    gosub turn my compendium
    gosub study my compendium
    math timeStudied add 1
    if (%timeStudied > 9) then return
    goto studyPages


