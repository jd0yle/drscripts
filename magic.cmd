include libmaster.cmd
action var lastSpellBackfired 1 when ^Your spell.*backfire

###############################
###      INIT
###############################
#if (!($char.magic.train.charge.Augmentation > -1)) then gosub doneNoVars
#if (!($char.magic.train.charge.Utility > -1)) then gosub doneNoVars
#if (!($char.magic.train.charge.Warding > -1)) then gosub doneNoVars

var noLoop 0
if_1 then {
    if ("%1" = "noLoop") then {
        var noLoop 1
    }
}

var lastSpellBackfired 0
var magic.skills Augmentation|Warding|Utility

eval magic.length count("%magic.skills", "|")
if (!($magic.index > -1)) then put #tvar magic.index 0

gosub release cyclic


###############################
###      MAIN
###############################
loop:
    if ($char.magic.train.useAlmanac = 1) then {
        gosub almanac.onTimer
    }

    if ("$guild" = "Moon Mage" && $Astrology.LearningRate < 33) then gosub observe.onTimer

    if ("$guild" = "Moon Mage" && $Astrology.LearningRate < 25) then gosub runScript predict

    if ($Attunement.LearningRate < 33) then gosub perc.onTimer

    if ($Appraisal.LearningRate < 33) then gosub appraise.onTimer

    if ($Arcana.LearningRate < 33 && $concentration = 100) then {
        if ($SpellTimer.EyesoftheBlind.active = 1) then gosub release eotb
        if ($SpellTimer.RefractiveField.active = 1) then gosub release rf
        if ($hidden = 1) then gosub shiver
        if ($char.magic.train.wornSanowret = 0) then {
            gosub get my sanowret crystal
            gosub gaze my sanowret crystal
            waitforre ^The light and crystal sound of your sanowret crystal fades slightly
            gosub stow my sano crystal
        } else {
           gosub gaze my sanowret crystal
        }
    }

    gosub findMinLearnRate

    var skill %magic.skills($magic.index)

    if ($%skill.LearningRate < 34) then {
        if ($char.magic.train.spell.isCyclic.%skill = 1) then {
            gosub manageCyclic
        } else {
	        if ($preparedspell != None) then gosub release spell
	        var lastSpellBackfired 0
	        if ($char.magic.train.useSymbiosis = 1) then gosub prep symbiosis
	        gosub prep $char.magic.train.spell.%skill $char.magic.train.prep.%skill
	        if ($char.wornCambrinth != 1) then {
	            gosub remove my $char.cambrinth
	            gosub get my $char.cambrinth
	        }
	        gosub charge my $char.cambrinth $char.magic.train.charge.%skill
	        gosub invoke my $char.cambrinth $char.magic.train.charge.%skill
	        if ($char.magic.train.harness.%skill > 0) then gosub harness $char.magic.train.harness.%skill
	        gosub waitForPrep
	        gosub cast
	        if (%lastSpellBackfired = 1) then {
	            evalmath tmp ($char.magic.train.charge.%skill - 1)
	            put #tvar char.magic.train.charge.%skill %tmp
	        }
        }
    }

    gosub waitForMana 80
    pause .5
    if (%noLoop = 1 && $Warding.LearningRate > 32 && $Utility.LearningRate > 32 && $Augmentation.LearningRate > 32) then goto done
    goto loop


findMinLearnRate:
    put #tvar magic.index 0
    var minLearnRateIndex 0

    findMinLearnRateLoop:
    if ($%magic.skills($magic.index).LearningRate < $%magic.skills(%minLearnRateIndex).LearningRate) then {
        var tmp %magic.skills(%minLearnRateIndex)
        if ($char.magic.train.spell.isCyclic.%tmp = 1) then {
            if (!($char.magic.train.spell.lastCastCyclicGametime.%tmp > 0)) then put #tvar char.magic.train.spell.lastCastCyclicGametime.%tmp 1
            evalmath nextCastCyclic (300 + $char.magic.train.spell.lastCastCyclicGametime.%tmp)
            echo findMin nextCastCyclic is %nextCastCyclic  game time is $gametime
            if (%nextCastCyclic < $gametime) then var minLearnRateIndex $magic.index
        } else {
            var minLearnRateIndex $magic.index
        }
    }

    evalmath tmp ($magic.index + 1)
    put #tvar magic.index %tmp

    if ($magic.index > %magic.length) then {
        put #tvar magic.index %minLearnRateIndex
        return
    }
    goto findMinLearnRateLoop


manageCyclic:
    echo managing cyclic
    if (!($char.magic.train.spell.lastCastCyclicGametime.%skill > -1)) then put #tvar char.magic.train.spell.lastCastCyclicGametime.%skill 0
    evalmath nextCastCyclic (300 + $char.magic.train.spell.lastCastCyclicGametime.%skill)
    if ($SpellTimer.%spellName.active = 1 && (%nextCastCyclic < $gametime || $mana < 60)) then {
        gosub release cyclic
    } else {
        var spellName $char.magic.train.spell.fullName.Utility
        if ($SpellTimer.%spellName.active != 1) then {
            gosub waitForMana 80
            gosub prep $char.magic.train.spell.Utility $char.magic.train.prep.Utility
            gosub waitForPrep
            gosub cast
            put #tvar char.magic.train.spell.lastCastCyclicGametime.%skill $gametime
        }
    }
    return




doneNoVars:
     echo CHARACTER GLOBALS AREN'T SET!
     echo char.magic.train.charge.Augmentation $char.magic.train.charge.Augmentation
     echo char.magic.train.charge.Utility $char.magic.train.charge.Utility
     echo char.magic.train.charge.Warding $char.magic.train.charge.Warding
     exit


done:
    if ($char.wornCambrinth = 1) then {
        gosub wear my $char.cambrinth
    }
    gosub stow my $char.cambrinth
    pause .2
    put #parse MAGIC DONE
    exit

