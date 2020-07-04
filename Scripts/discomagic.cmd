include libsel.cmd


var isFullyPrepped 0

action var isFullyPrepped 1 when ^You feel fully prepared to cast your spell.

var nextPercAt 0
timer start

loop:
    if (%t > %nextPercAt) then {
         gosub perc mana
         evalmath nextPercAt (60 + %t)
         pause
         put summon admit
         pause
         put path focus quick
         pause
    }
    if ($Warding.LearningRate < 34) then {
        if ($preparedspell != None) then gosub release spell
        var isFullyPrepped 0
        gosub prep symbiosis
        gosub prep es 20
        gosub charge my arm 20
        gosub focus my arm
        gosub invoke my arm
        if (%isFullyPrepped != 1) then gosub waitForPrep
        gosub cast
    }

    if ($Utility.LearningRate < 34) then {
        if ($preparedspell != None) then gosub release spell
        var isFullyPrepped 0
        gosub prep symbiosis
        gosub prep zep 20
        gosub charge my arm 20
        gosub focus my arm
        gosub invoke my arm
        if (%isFullyPrepped != 1) then gosub waitForPrep
        gosub cast air
    }

    if ($Augmentation.LearningRate < 34) then {
        if ($preparedspell != None) then gosub release spell
        var isFullyPrepped 0
        gosub prep symbiosis
        gosub prep sw 20
        gosub charge my arm 30
        gosub focus my arm
        gosub invoke my arm
        if (%isFullyPrepped != 1) then gosub waitForPrep
        gosub cast
    }
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