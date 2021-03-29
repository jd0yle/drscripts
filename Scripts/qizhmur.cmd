include libsel.cmd

var cambrinth cambrinth calf

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

gosub release cyclic

loop:
    if ($SpellTimer.RiteofContrition.active = 1) then {
        gosub release roc
    }

    gosub almanac.onTimer

    if ($Attunement.LearningRate < 33) then gosub perc.onTimer

    if ($Appraisal.LearningRate < 33) then gosub appraise.onTimer careful

    if ($Arcana.LearningRate < 33 && $concentration = 100) then {
        if ($SpellTimer.EyesoftheBlind.active = 1) then gosub release eotb
        gosub gaze my sanowret crystal
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
       gosub prep symbiosis
       gosub prep eotb 1
       gosub charge my %cambrinth 6
       gosub invoke my %cambrinth 6
       gosub harness 5
       if (%isFullyPrepped != 1) then gosub waitForPrep
       gosub cast
   }
    if ($Warding.LearningRate < 33) then {
        if ($preparedspell != None) then gosub release spell
        var isFullyPrepped 0
        gosub prep symbiosis
        gosub prep maf 1
        gosub charge my %cambrinth 7
        gosub invoke my %cambrinth 7
        gosub harness 6
        if (%isFullyPrepped != 1) then gosub waitForPrep
        gosub cast
    }
    if ($Augmentation.LearningRate < 33) then {
        if ($preparedspell != None) then gosub release spell
        var isFullyPrepped 0
        gosub prep symbiosis
        gosub prep obf 1
        gosub charge my %cambrinth 6
        gosub invoke my %cambrinth 6
        gosub harness 5
        if (%isFullyPrepped != 1) then gosub waitForPrep
        gosub cast
    }
    gosub waitForMana 80
    pause .2

goto loop


