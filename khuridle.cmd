include libmaster.cmd
###################
# Idle Action Triggers
###################
action put #var lastTrainerGametime $gametime when ^The leather looks frayed, as if worked too often recently


###################
# Variable Inits
###################
if (!($observeOffCooldown >0)) then put #var observeOffCooldown 0
if (!($lastAppGametime >0)) then put #var lastAppGametime 0
if (!($lastLookGametime >0)) then put #var lastLookGametime 0
if (!($lastMagicGametime >0)) then put #var lastMagicGametime 0
if (!($lastPercGametime >0)) then put #var lastPercGametime 0
if (!($lastTrainerGametime >0)) then put #var lastTrainerGametime 0


put #script abort all except khuridle
###################
# Main
###################
loop:
    if ($standing = 0) then gosub stand
    pause 1
    gosub waitAppraisal
    pause 1
    gosub waitFaSkin
    pause 1
    gosub waitPerc
    pause 1
    gosub waitAstrology
    pause 1
    gosub waitArcana
    pause 1
    gosub waitMagic
    pause 1
    gosub waitPlay
    pause 1
    gosub waitLook
    goto loop


###################
# Wait Methods
###################
waitAppraisal:
    evalmath nextAppAt $lastAppGametime + 60
    if (%nextAppAt > $gametime) then {
        return
    }
    if ($Appraisal.LearningRate < 15) then {
        gosub appraise $char.appraise.item careful
    	put #var lastAppGametime $gametime
    }
    return


waitArcana:
    if ($Arcana.LearningRate > 15) then {
        return
    }
    if ($concentration > 99) then {
        gosub get my sano crystal
        gosub gaze my sano crystal
        waitforre ^The light and crystal sound of your sanowret crystal fades slightly
        gosub stow my sano crystal
    }
    return


waitAstrology:
    if ($Astrology.LearningRate > 30) then {
        return
    }
    if ($observeOffCooldown = false) then {
        return
    } else {
        put .observe
        waitforre ^OBSERVE DONE
        return
    }


waitFaSkin:
    evalmath nextTrainer $lastTrainerGametime + 3600
    if (%nextTrainer > $gametime) then {
        return
    }
    if ($First_Aid.LearningRate < 15 && $Skinning.LearningRate < 15) then {
        gosub get my $char.trainer.firstaid
    	gosub skin my $char.trainer.firstaid
    	pause 2
    	gosub repair my $char.trainer.firstaid
    	pause 2
    	gosub stow my $char.trainer.firstaid
    }
    return


waitLook:
    evalmath nextLookAt $lastLookGametime + 240
    if (%nextLookAt < $gametime) then {
        gosub look
        put #var lastLookGametime $gametime
    }
    return


waitMagic:
    evalmath nextMagic $lastMagicGametime + 3600
    if (%nextMagic < $gametime) then {
        if ($Augmentation.LearningRate < 5) then {
          put #var lastMagicGametime $gametime
          put .magic noLoop
          waitforre ^MAGIC DONE
        }
    }
    return


waitPerc:
    if ($Attunement.LearningRate > 15) then {
        return
    }
    evalmath nextPerc $lastPercGametime + 60
    if ($gametime > %nextPerc) then {
        gosub perc mana
        put #var lastPercGametime $gametime
    }
    return


waitPlay:
    if ($Performance.LearningRate > 15) then {
        return
    }
    gosub get my $char.performance.instrument
    gosub play $char.performance.song $char.performance.mood
    waitforre ^You finish playing
    gosub stow my $char.performance.instrument
    return