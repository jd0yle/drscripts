include libsel.cmd

var cambrinth aoustone muhenta

var useRog 0

var isFullyPrepped 0

action var isFullyPrepped 1 when ^You feel fully prepared to cast your spell.
action var isFullyPrepped 1 when ^Your concentration slips for a moment, and your spell is lost.$

var nextAppAt 0
var nextPercAt 0
var nextRogAt 0
timer start

gosub stow right
gosub stow left

loop:
    if (%t > %nextPercAt && $Attunement.LearningRate < 33) then {
         gosub perc mana
         evalmath nextPercAt (60 + %t)
    } else if (%t > %nextAppAt && $Appraisal.LearningRate < 33) then {
        gosub app my bundle
        evalmath nextAppAt (90 + %t)
    }
    if (%useRog = 1 && %t > %nextRogAt) then {
        if ($preparedspell != None) then gosub release spell
        gosub release rog
        var isFullyPrepped 0
        gosub prep rog
        if (%isFullyPrepped != 1) then gosub waitForPrep
        gosub cast
        evalmath nextRogAt (300 + %t)
    }

    if (%useRog = 0 && $SpellTimer.RiteofGrace.active = 1) then gosub release rog

    if (%useRog = 0 && $Utility.LearningRate < 33) then {
       if ($preparedspell != None) then gosub release spell
       var isFullyPrepped 0
       gosub prep eotb 5
       gosub charge my %cambrinth 20
       gosub charge my %cambrinth 20
       gosub invoke my %cambrinth
       if (%isFullyPrepped != 1) then gosub waitForPrep
       gosub cast
   }
    if ($Warding.LearningRate < 33) then {
        if ($preparedspell != None) then gosub release spell
        var isFullyPrepped 0
        gosub prep maf 5
        gosub charge my %cambrinth 30
        gosub charge my %cambrinth 30
        gosub invoke my %cambrinth
        if (%isFullyPrepped != 1) then gosub waitForPrep
        gosub cast
    }
    if ($Augmentation.LearningRate < 33) then {
        if ($preparedspell != None) then gosub release spell
        var isFullyPrepped 0
        gosub prep obf 5
        gosub charge my %cambrinth 25
        gosub charge my %cambrinth 25
        gosub invoke my %cambrinth
        if (%isFullyPrepped != 1) then gosub waitForPrep
        gosub cast
    }
    gosub waitMana
    pause .2
    if ($Augmentation.LearningRate > 32 && $Utility.LearningRate > 32 && $Warding.LearningRate > 32) then {
        # put #parse QIZHMUR DONE
    }
goto loop

waitForPrep:
    pause 1
    if (%isFullyPrepped = 1) then return
    goto waitForPrep

waitMana:
    pause 1
    if ($mana > 80) then return
    goto waitMana
