include libsel.cmd


var isFullyPrepped 0

action var isFullyPrepped 1 when ^You feel fully prepared to cast your spell.
action var isFullyPrepped 1 when ^Your concentration slips for a moment, and your spell is lost.$

action put #echo >Log Almanac: $1 when You believe you've learned something significant about (.*)!$

var nextPercAt 0
timer start

loop:
    evalmath nextStudyAt $lastAlmanacGametime + 600

    if (%nextStudyAt < $gametime) then {
        if ("$lefthandnoun" != "almanac" && "$righthandnoun" != "almanac") then {
            gosub get my almanac
        }
        gosub study my almanac
        gosub put my almanac in my thigh bag
        put #var lastAlmanacGametime $gametime
    }

    if (%t > %nextPercAt) then {
         gosub perc mana
         evalmath nextPercAt (60 + %t)
         if ($Appraisal.LearningRate < 33) then gosub app my bundle
    }
    if ($Warding.LearningRate < 33) then {
        if ($preparedspell != None) then gosub release spell
        var isFullyPrepped 0
        gosub prep symbiosis
        gosub prep shear 20
        gosub charge my calf 20
        gosub invoke my calf
        if (%isFullyPrepped != 1) then gosub waitForPrep
        gosub cast
        gosub release shear
    }

    if ($Utility.LearningRate < 33) then {
        if ($preparedspell != None) then gosub release spell
        var isFullyPrepped 0
        gosub prep symbiosis
        gosub prep sm 20
        gosub charge my calf 20
        gosub invoke my calf
        if (%isFullyPrepped != 1) then gosub waitForPrep
        gosub cast
    }

    if ($Augmentation.LearningRate < 33) then {
        if ($preparedspell != None) then gosub release spell
        var isFullyPrepped 0
        gosub prep symbiosis
        gosub prep cv 20
        gosub charge my calf 20
        gosub invoke my calf
        if (%isFullyPrepped != 1) then gosub waitForPrep
        gosub cast
    }
   
    gosub waitMana
    pause .5

goto loop

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
