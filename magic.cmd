include libmaster.cmd
action var lastSpellBackfired 1 when ^Your spell.*backfire

###############################
###      INIT
###############################
#if (!($char.magic.train.charge.Augmentation > 0)) then gosub doneNoVars
#if (!($char.magic.train.charge.Utility > 0)) then gosub doneNoVars
#if (!($char.magic.train.charge.Warding > 0)) then gosub doneNoVars

if ("$charactername" = "Qizhmur") then put #tvar char.magic.train.charge.Utility 1

var noLoop 0
if_1 then {
    if ("%1" = "noLoop") then {
        var noLoop 1
    }
}

var lastSpellBackfired 0
var magic.skills Augmentation|Warding|Utility

# TODO: Expand this to not be specific to Utility and Rite of Contrition
if ($char.magic.train.cyclic.Utility = 1) then {
    #var magic.skills Augmentation|Warding
}


eval magic.length count("%magic.skills", "|")
if (!($magic.index > -1)) then put #tvar magic.index 0

if ($SpellTimer.Regenerate.active != 1 && $SpellTimer.RiteofContrition.active != 1) then gosub release cyclic

if ($SpellTimer.RiteofContrition.active = 1 || $SpellTimer.RiteofGrace.active = 1) then gosub release cyclic

###############################
###      MAIN
###############################
loop:
    if ($SpellTimer.RiteofGrace.active = 1) then gosub release cyclic

    if ($char.magic.train.useAlmanac = 1) then {
        gosub almanac.onTimer
    }

    if ($char.magic.train.usePray = 1) then gosub pray.onTimer $char.magic.train.prayTarget

    if ($char.magic.train.usePom = 1 && ($SpellTimer.PersistenceofMana.active != 1 || $SpellTimer.PersistenceofMana.duration < 3)) then gosub runScript cast pom

    if ("$guild" = "Empath" && $Empathy.LearningRate < 30) then gosub percHealth.onTimer


    if ("$guild" = "Moon Mage" && $Astrology.LearningRate < 33) then gosub observe.onTimer
    if ("$guild" = "Moon Mage" && $Astrology.LearningRate < 25) then gosub runScript predict
    if ($SpellTimer.Shear.active = 1 || $SpellTimer.Shear.duration > 0) then gosub release shear


    if ("$guild" = "Moon Mage" && $char.magic.train.useShadowling = 1) then {
        if ($SpellTimer.Shadowling.active = 0 || $SpellTimer.Shadowling.duration < 5) then {
            gosub release shadowling
            gosub runScript cast shadowling
        }
    }

    if ($Attunement.LearningRate < 33) then gosub perc.onTimer

    if ($Appraisal.LearningRate < 33) then gosub appraise.onTimer

    if ($Arcana.LearningRate < 33 && $concentration = 100) then {
        if ($SpellTimer.EyesoftheBlind.active = 1) then gosub release eotb
        if ($SpellTimer.RefractiveField.active = 1) then gosub release rf
        if ($hidden = 1) then gosub shiver
        gosub gaze my sanowret crystal
    }

    if ($char.magic.train.cyclic.Utility = 1) then {
        var shouldCastRoc 1

        if ($SpellTimer.RiteofContrition.active = 1) then var shouldCastRoc 0
        if ($mana < 75) then var shouldCastRoc 0
        if ($Utility.LearningRate > 32) then var shouldCastRoc 0

        if (%shouldCastRoc = 1) then {
            gosub prep $char.magic.train.cyclic.spell.Utility $char.magic.train.cyclic.prep.Utility
            gosub waitForPrep
            gosub cast
        }

        if ($SpellTimer.RiteofContrition.active = 1) then {
			var shouldReleaseRoc 0

	        evalmath nextCastCyclicGametime (300 + $char.cast.cyclic.lastCastGametime.roc)

	        if (%nextCastCyclicGametime < $gametime) then var shouldReleaseRoc 1
            if ($mana < 50) then var shouldReleaseRoc 1
            if ($Utility.LearningRate > 33) then var shouldReleaseRoc 1

            if (%shouldReleaseRoc = 1) then gosub release roc
        }
    }

    gosub findMinLearnRate
    var skill %magic.skills($magic.index)

    if ($%skill.LearningRate < 34) then {
        if ($preparedspell != None) then gosub release spell
        var lastSpellBackfired 0
        if ($char.magic.train.useSymbiosis = 1) then gosub prep symbiosis
        gosub prep $char.magic.train.spell.%skill $char.magic.train.prep.%skill
        if ($char.wornCambrinth != 1) then {
            gosub remove my $char.cambrinth
            if ("$righthand" = "Empty") then {
                gosub get my $char.cambrinth
            }
        }
        gosub charge my $char.cambrinth $char.magic.train.charge.%skill
        if ($char.magic.train.useInvokeSpell = 1) then {
            gosub invoke my $char.cambrinth $char.magic.train.charge.%skill spell
        } else {
            gosub invoke my $char.cambrinth $char.magic.train.charge.%skill
        }
        if ($char.magic.train.harness.%skill > 0) then gosub harness $char.magic.train.harness.%skill
        if ($char.wornCambrinth <> 1) then {
            gosub wear my $char.cambrinth
            if ("$righthand" <> "Empty") then {
                gosub get my $char.cambrinth
            }
        }
        gosub waitForPrep
        gosub waitForConcentration $char.magic.train.minimumConcentration
        if ("$char.magic.train.spell.%skill" = "col") then {
            gosub checkMoons
            if ($moon = null) then {
                put #echo >log #FF0000 [magic] NO MOON AVAILABLE for Cage of Light!
                goto done
            }
            gosub cast $moon
        } else {
            gosub cast
        }
        if (%lastSpellBackfired = 1) then {
            evalmath tmp ($char.magic.train.charge.%skill - 1)
            put #tvar char.magic.train.charge.%skill %tmp
            put #tvar char.magic.train.lastBackfireGametime.%skill $gametime
        }
        if ("$char.magic.train.spell.%skill" = "shear") then gosub release shear
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
        var minLearnRateIndex $magic.index
    }

    evalmath tmp ($magic.index + 1)
    put #tvar magic.index %tmp

    if ($magic.index > %magic.length) then {
        put #tvar magic.index %minLearnRateIndex
        return
    }
    goto findMinLearnRateLoop


doneNoVars:
     echo CHARACTER GLOBALS AREN'T SET!
     exit


done:
    if ("$righthandnoun" = "$char.cambrinth") then {
        if ($char.wornCambrinth <> 1) then {
            gosub wear my $char.cambrinth
            if ("$righthand" <> "Empty") then {
                gosub stow my $char.cambrinth
            }
        }
    }
    pause .2
    put #parse MAGIC DONE
    exit

