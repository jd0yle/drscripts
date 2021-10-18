####################################################################################################
# .caracal
# Selesthiel - justin@jmdoyle.com
#
# USAGE
# .caracal
#
####################################################################################################
include libmaster.cmd


action goto caracal.done when ^The leather looks frayed, as if worked too often recently, so you stop your attempt to skin it\.$
action goto caracal.done when ^A small fuzzy caracal with tufted ears and double-stitched seams isn't in need of repair\.$

var loopsRemaining 30

caracal.main:
	if ($First_Aid.LearningRate > 32 && $Skinning.LearningRate > 32) then goto caracal.done

    gosub almanac.onTimer
    if ($char.magic.train.usePray = 1) then gosub pray.onTimer $char.magic.train.prayTarget
    if ("$guild" = "Moon Mage" && $Astrology.LearningRate < 31) then gosub observe.onTimer
    if ("$guild" = "Moon Mage" && $Astrology.LearningRate < 25) then gosub runScript predict
    if ($Attunement.LearningRate < 33) then gosub perc.onTimer

    if ($Appraisal.LearningRate < 33) then gosub appraise.onTimer

    if ($Arcana.LearningRate < 33 && $concentration = 100) then {
        if ($SpellTimer.EyesoftheBlind.active = 1) then gosub release eotb
        if ($SpellTimer.RefractiveField.active = 1) then gosub release rf
        if ($hidden = 1) then gosub shiver
        gosub gaze my sanowret crystal
    }

    if ("$righthand" != "fuzzy caracal") then {
        gosub stow right
        gosub stow left
        gosub get my caracal
    }
    gosub skin my caracal
    gosub repair my caracal
    evalmath loopsRemaining (%loopsRemaining - 1)
    if (%loopsRemaining < 1) then goto caracal.done
    goto caracal.main


caracal.done:
	if ("$righthand" = "fuzzy caracal" || "$lefthand" = "fuzzy caracal") then gosub stow my caracal
	pause .2
	put #parse CARACAL DONE
	exit