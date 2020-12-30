include libsel.cmd


var isFullyPrepped 0

action var isFullyPrepped 1 when ^You feel fully prepared to cast your spell.
action var isFullyPrepped 1 when ^Your concentration slips for a moment, and your spell is lost.$

action var observeOffCooldown true when ^You feel you have sufficiently pondered your latest observation\.$
action var observeOffCooldown true when ^Although you were nearly overwhelmed by some aspects of your observation
action var observeOffCooldown false when ^You learned something useful from your observation\.$
action var observeOffCooldown false when ^You have not pondered your last observation sufficiently\.$
action var observeOffCooldown false when ^You are unable to make use of this latest observation



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

    if ($Astrology.LearningRate < 32) then {
        if ($Astrology.LearningRate < 22) then {
            put .predict
            waitforre ^PREDICT DONE$
        }
        put .observe
        waitforre ^OBSERVE DONE$
    }

    if (%t > %nextPercAt) then {
         gosub perc mana
         evalmath nextPercAt (60 + %t)
         if ($Appraisal.LearningRate < 33) then gosub app my gem pouch
    }
    if ($Warding.LearningRate < 33) then {
        if ($preparedspell != None) then gosub release spell
        var isFullyPrepped 0
        gosub prep symbiosis
        gosub prep psy 10
        gosub charge my calf 50
        gosub invoke my calf
        if (%isFullyPrepped != 1) then gosub waitForPrep
        gosub cast
        #gosub release shear
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
        gosub prep cv 10
        gosub charge my calf 40
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
