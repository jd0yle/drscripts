include libmaster.cmd

action var lastSpellBackfired 1 when ^Your spell.*backfire
action (expMods) var debuffSkills %debuffSkills|$2 when ^--(\d+)\(\d+%\) (.*?) \(\d+ effective ranks\)

###############################
###      INIT
###############################
#if (!($char.magic.train.charge.Augmentation > 0)) then gosub doneNoVars
#if (!($char.magic.train.charge.Utility > 0)) then gosub doneNoVars
#if (!($char.magic.train.charge.Warding > 0)) then gosub doneNoVars

#if ("$charactername" = "Qizhmur") then put #tvar char.magic.train.charge.Utility 1

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

if ($char.magic.train.revSorcery = 1) then {
	#var magic.skills Warding
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

    if ("$guild" = "Empath" && $Empathy.LearningRate < 30) then gosub percHealth.onTimer

    if ($Attunement.LearningRate < 33) then gosub perc.onTimer

    if ($Appraisal.LearningRate < 33) then gosub appraise.onTimer

    if ($lib.magicInert = 1) then {
        if (%messageInert != 1) then {
            put #echo >Log [magic] Inert! Waiting for it to recover
            var messageInert 1
        }
        pause 5
        goto loop
    } else {
        var messageInert 0
    }


    if ($Arcana.LearningRate < 33 && $concentration = 100) then {
        if ($SpellTimer.EyesoftheBlind.active = 1) then gosub release eotb
        if ($SpellTimer.RefractiveField.active = 1) then gosub release rf
        if ($hidden = 1) then gosub shiver
        gosub gaze my sanowret crystal
    }

	if ($char.magic.train.usePom = 1 && ($SpellTimer.PersistenceofMana.active != 1 || $SpellTimer.PersistenceofMana.duration < 3)) then gosub runScript cast pom

    if ("$guild" = "Moon Mage") then {
        if ($Astrology.LearningRate < 31) then gosub observe.onTimer
        if ($Astrology.LearningRate < 25) then gosub runScript predict
    }

    if ("$guild" = "Moon Mage" && $char.magic.train.useShadowling = 1) then {
        if ($SpellTimer.Shadowling.active = 0 || $SpellTimer.Shadowling.duration < 5) then {
            gosub release shadowling
            gosub runScript cast shadowling
        }
    }
    if ("$guild" = "Moon Mage" && $char.magic.train.useServant = 1) then {
        if ($SpellTimer.ShadowServant.active = 0 || $SpellTimer.ShadowServant.duration < 5) then {
            gosub release servant
        }
    }

    if ($char.magic.train.revSorcery = 1) then {
        if ($SpellTimer.Revelation.active != 1) then {
            var shouldCastRev 1
            if ($Sorcery.LearningRate > 33 && $Augmentation.LearningRate > 33 && $Utility.LearningRate > 33) then var shouldCastRev 0
            if ($mana < 80) then var shouldCastRev 0

            if (%shouldCastRev = 1) then {
                var debuffSkills null
                action (expMods) on
                put exp mods
                pause 2
                action (expMods) off
                #if (!contains("%debuffSkills", "Sorcery")) then {
                    gosub release cyclic
                    #gosub runScript cast rev
                    gosub invoke tattoo
                    gosub waitForPrep
                    gosub cast
                #}
            }
        } else {
            var shouldReleaseRev 0
            if ($mana < 60) then var shouldReleaseRev 1
            if ($Sorcery.LearningRate > 33 && $Augmentation.LearningRate > 33 && $Utility.LearningRate > 33) then var shouldReleaseRev 1
			if (!($char.cast.cyclic.lastCastGametime.rev > -1)) then put #tvar char.cast.cyclic.lastCastGametime.rev 1
            evalmath nextCastRevGametime (300 + $char.cast.cyclic.lastCastGametime.rev)
            if (%nextCastRevGametime < $gametime) then var shouldReleaseRev 1

            if (%shouldReleaseRev = 1) then gosub release rev
        }
    }

    if ($char.magic.train.cyclic.Utility = 1) then {
        var shouldCastRoc 1

        if ($SpellTimer.RiteofContrition.active = 1) then var shouldCastRoc 0
        if ($mana < 90) then var shouldCastRoc 0
        if ($Utility.LearningRate > 20) then var shouldCastRoc 0

        if (%shouldCastRoc = 1) then {
            if ($char.magic.train.cyclic.useSymbiosis = 1) then gosub prep symbiosis
            gosub prep $char.magic.train.cyclic.spell.Utility $char.magic.train.cyclic.prep.Utility
            gosub waitForPrep $char.magic.train.minPrepTime.Utility
            gosub cast
        }

        if ($SpellTimer.RiteofContrition.active = 1) then {
			var shouldReleaseRoc 0

	        evalmath nextCastCyclicGametime (300 + $char.cast.cyclic.lastCastGametime.roc)

	        if (%nextCastCyclicGametime < $gametime) then var shouldReleaseRoc 1
            if ($mana < 70) then var shouldReleaseRoc 1
            if ($Utility.LearningRate > 29) then var shouldReleaseRoc 1

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
        gosub waitForPrep $char.magic.train.minPrepTime.%skill
        gosub waitForConcentration $char.magic.train.minimumConcentration
        if ($SpellTimer.Shear.active = 1 || $SpellTimer.Shear.duration > 0) then gosub release shear
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
            if ($lib.symbiosis = 1) then
                gosub release symbiosis
            }
            evalmath tmp ($char.magic.train.charge.%skill - 1)
            put #tvar char.magic.train.charge.%skill %tmp
            put #tvar char.magic.train.lastBackfireGametime.%skill $gametime
        }
        if ($SpellTimer.Shear.active = 1 || $SpellTimer.Shear.duration > 0) then gosub release shear
    }

    gosub waitForMana 80
    pause .5
    if (%noLoop = 1 && $Warding.LearningRate > 32 && $Utility.LearningRate > 32 && $Augmentation.LearningRate > 32) then goto done
    if (%lastSpellBackfired = 1) then gosub magic.waitForBacklash
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


magic.waitForBacklash:

    magic.waitForBacklashLoop:
        gosub checkForBacklashDebuff
        if ($lib.backlashDebuff = 1) then {
            put #echo >Log [magic] Still waiting for backlash to wear off...
            if (%magic.sleepingForBacklash != 1) then {
                put awake
                pause .5
                put sleep
                pause .5
                put sleep
                var magic.sleepingForBacklash 1
            }
            pause 60
            goto magic.waitForBacklashLoop
        }
        if (%magic.sleepingForBacklash != 0) then {
            put awake
            pause .5
            var magic.sleepingForBacklash 0
        }
        return

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

