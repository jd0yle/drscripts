include libmaster.cmd
###################
# Idle Action Triggers
###################
action put #var lastTrainerGametime $gametime when ^The leather looks frayed, as if worked too often recently
action put #var openDoor 1 when ^(Qizhmur|Selesthiel)'s face appears in the
action put #var openDoor 2 when ^(Vohraus|Inahk|Estius)'s face appears in the
action put #var khurnaarti.student 0 ; put #var khurnaarti.instructor $1 when ^(Selesthiel|Inauri|Qizhmur) is teaching a class on .* which is still open to new students\.$
action var houseRetry 1 ; goto moveToHouse when ^A sandalwood door suddenly closes\!$|^A sandalwood door seems to be closed\.$
action var houseOpen 1 when ^A sandalwood door suddenly opens\!$

###################
# Variable Inits
###################
if (!($khurnaarti.student >0)) then put #var khurnaarti.student 0
if (!($lastAppGametime >0)) then put #var lastAppGametime 0
if (!($lastLookGametime >0)) then put #var lastLookGametime 0
if (!($lastMagicGametime >0)) then put #var lastMagicGametime 0
if (!($lastPercGametime >0)) then put #var lastPercGametime 0
if (!($lastPracticeBoxGametime >0)) then put #var lastPracticeBoxGametime 0
if (!($lastTrainerGametime >0)) then put #var lastTrainerGametime 0


put #script abort all except khuridle
###################
# Main
###################
loop:
    if ($standing = 0) then gosub stand
    if ($openDoor = 1) then {
        if !(contains("$roomplayers", "Selesthiel") || contains("$roomplayers", "Inauri")) then {
            gosub unlock door
            gosub open door
        }
    }
    if ($openDoor = 2) then {
        gosub unlock door
        gosub open door
    }
    put #var openDoor 0
    pause 1
    gosub waitClass
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
    gosub waitBurgle
    pause 1
    gosub waitMagic
    pause 1
    gosub waitPlay
    pause 1
    gosub waitLock
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
    }
    return


waitAstrology:
    if ($Astrology.LearningRate < 33) then gosub observe.onTimer
    return


waitBurgle:
    if ($Stealth.LearningRate > 10) then {
        return
    }
    put burgle recall
    if ($char.burgle.cooldown <> 0) then {
        gosub burgle.onTimer
    }
    if ($char.burgle.cooldown = 0) then {
        put #echo >Log #cc99ff Train: Going to burgle
        put .house
        waitforre ^HOUSE DONE
        gosub moveToBurgle
        put .burgle
        waitforre ^BURGLE DONE
        gosub release rf
        gosub movetoHouse
    }
    return


waitClass:
    if ($khurnaarti.student = 1) then {
        return
    } else {
        if (contains("$roomplayers", "Inauri")) then {
            matchre waitClassSetClass Crossbow|Enchanting|Sorcery|Targeted Magic
            matchre waitClassNewClass ^No one seems to be teaching\.$
            put assess teach
            matchwait 5
        }
    }
    return


waitClassNewClass:
    gosub whisper inauri teach cross
    pause 2
    goto waitClass


waitClassSetClass:
    var classTopic $1
    echo %classTopic
    if ("$instructor" = "Inauri") then {
        gosub listen $khurnaarti.instructor observe
        put #var khurnaarti.student 1
    } else {
        gosub listen $khurnaarti.instructor
        put #var khurnaarti.student 1
    }
    goto waitClass


waitFaSkin:
     evalmath nextTrainerAt $lastTrainerGametime + 3600
    if (%nextTrainerAt > $gametime) then {
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
        gosub moveToForage
        put .forage
        waitforre ^FORAGE DONE
        put #script abort all except khuridle
        gosub moveToHouse
    }
    return


waitLock:
    # Limit how often we're looking for locksmithing practice boxes.
    if ($practicebox.haveBox = 1) then
        evalmath nextPracticeBoxAt $lastPracticeBoxGametime + 3600
        if (%nextPracticeBoxAt > $gametime) then {
            return
        }
    }
    if ($Locksmithing.LearningRate < 10) then {
        put .practicebox
        waitforre ^LOCKS DONE
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


###################
# Move to Methods
###################
moveToBurgle:
    # Fang Cove
    if ($zoneid = 150) then {
        gosub automove portal
        gosub move go portal
        gosub moveToBurgle
    }
    # Shard - East Gate
    if ($zoneid = 66) then {
        gosub automove steelclaw
        gosub automove 91
    }
    return


moveToFangCove:
    # Shard - East Gate
    if ($zoneid = 66) then {
        gosub automove portal
        gosub move go portal
        gosub automove 106
        goto loop
    }
    return


moveToForage:
    # Shard - East Gate
    if ($zoneid = 66) then {
        gosub automove 555
    }
    return


moveToHouse:
    # Fang Cove
    if ($zoneid = 150) then {
        gosub automove portal
        gosub move go portal
        gosub moveToHouse
    }
    # Shard - East Gate
    if ($zoneid = 66) then {
        gosub automove 252
    }

    var lastHouseGametime $gametime
    moveToHouse1:
    gosub peer door
    pause 5
    if (%houseOpen <> 1) then {
        pause 5
        evalmath maxHouseTime %lastHouseGametime + 300
        if (%maxHouseTime < $gametime) then {
            goto moveToHouseRetry
        } else {
            goto moveToFangCove
    } else {
        put .house
        waitforre ^HOUSE DONE$
        var houseOpen 0
    }
    if (%houseRetry = 1) then {
        goto loop
    }
    return
