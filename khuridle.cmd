include libmaster.cmd
###################
# Idle Action Triggers
###################
action put #var lastTrainerGametime $gametime when ^The leather looks frayed, as if worked too often recently
action put #var openDoor 1 when ^(Qizhmur|Selesthiel|Vohraus|Inahk|Estius)'s face appears in the

###################
# Variable Inits
###################
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
    if !(contains("$roomplayers", "Inauri")) then {
        if ($openDoor = 1) then {
            gosub unlock door
            gosub open door
            put #var openDoor 0
        }
    }
    pause 1
    gosub waitAppraisal
    pause 1
    gosub waitFaSkin
    pause 1
    gosub waitPerc
    pause 1
    if ($Astrology.LearningRate < 30) then gosub waitAstrology
    pause 1
    gosub waitArcana
    pause 1
    gosub waitMagic
    pause 1
    gosub waitPlay
    pause 1
    gosub waitForage
    pause 1
    gosub waitLook
    goto loop


###################
# Wait Methods
###################
waitAppraisal:
    if ($Appraisal.LearningRate < 33) then gosub appraise.onTimer
    return


waitArcana:
    if ($Arcana.LearningRate > 15) then {
        return
    }
    if ($concentration > 99) then {
        gosub gaze my sano crystal
        waitforre ^The light and crystal sound of your sanowret crystal fades slightly
    }
    return


waitAstrology:
    if ($Astrology.LearningRate < 33) then gosub observe.onTimer
    return


waitFaSkin:
    if (contains($time, "(\d+)(.*)AM")) then {
        if ($1 < 12) then {
            put #var lastTrainerGametime 0
        }
    }
    if ($lastTrainerGametime <> 0) then {
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


waitForage:
    if ($Outdoorsmanship.LearningRate < 10) then {
        put .house
        waitforre ^HOUSE DONE
        gosub automove 555
        put .forage
        waitforre ^FORAGE DONE
        gosub automove 252
        gosub peer door
        waitforre %A sandalwood door suddenly opens\!
        put .house
        waitforre ^HOUSE DONE
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
    if ($Attunement.LearningRate < 33) then gosub perc.onTimer
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