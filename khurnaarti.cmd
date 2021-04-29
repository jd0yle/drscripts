include libmaster.cmd
###############################
###    IDLE ACTION TRIGGERS
###############################
action var khurnaarti.houseOpen 1 when ^A sandalwood door suddenly opens\!$
action var khurnaarti.houseRetry 1 ; goto moveToHouse when ^A sandalwood door suddenly closes\!$|^A sandalwood door seems to be closed\.$
action var khurnaarti.needHeal 0 when ^You have no significant injuries\.$
action var khurnaarti.needHeal 1 when ^The pain is too much\.$|^You are unable to hold the .* telescope steady, and give up\.$
action var khurnaarti.openDoor 1 when ^(Qizhmur|Selesthiel)'s face appears in the
action var khurnaarti.openDoor 2 when ^(Vohraus|Inahk|Estius)'s face appears in the
action put #var lib.student 0 when ^Inauri stops teaching\.$

action put #var lastTrainerGametime $gametime when ^The leather looks frayed, as if worked too often recently
###############################
###    VARIABLES
###############################
if (!($khurnaarti.student >0)) then put #var khurnaarti.student 0
if (!($char.burgle.cooldown >0)) then put #var char.burgle.cooldown 0
if (!($lastAppGametime >0)) then put #var lastAppGametime 0
if (!($lastLookGametime >0)) then put #var lastLookGametime 0
if (!($lastMagicGametime >0)) then put #var lastMagicGametime 0
if (!($lastPercGametime >0)) then put #var lastPercGametime 0
if (!($lastPracticeBoxGametime >0)) then put #var lastPracticeBoxGametime 0
if (!($lastTrainerGametime >0)) then put #var lastTrainerGametime 0

var khurnaarti.class Sorcery
var khurnaarti.houseOpen 0
var khurnaarti.houseRetry 0
var khurnaarti.needHeal 0
var khurnaarti.openDoor 0


put #script abort all except khurnaarti


###############################
###    MAIN
###############################
khurnaarti.loop:
    gosub clear
    if ($standing = 0) then gosub stand
    pause 1
    gosub khurnaarti.healthCheck
    pause 1
    if (%khurnaarti.openDoor = 1) then gosub khurnaarti.door
    pause 1
    gosub khurnaarti.class
    pause 1
    gosub khurnaarti.appraisal
    pause 1
    gosub khurnaarti.faSkin
    pause 1
    gosub khurnaarti.perc
    pause 1
    if ($Astrology.LearningRate < 30) then gosub khurnaarti.astrology
    pause 1
    gosub khurnaarti.arcana
    pause 1
    gosub khurnaarti.burgle
    pause 1
    gosub khurnaarti.magic
    pause 1
    gosub khurnaarti.play
    pause 1
    gosub khurnaarti.lock
    pause 1
    gosub khurnaarti.forage
    pause 1
    gosub khurnaarti.combatCheck
    pause 1
    gosub khurnaarti.look
    pause 1
    goto khurnaarti.loop


###############################
###    SKILL METHODS
###############################
khurnaarti.appraisal:
    if ($Appraisal.LearningRate < 33) then gosub appraise.onTimer
    return


khurnaarti.arcana:
    if ($Arcana.LearningRate > 15) then {
        return
    }
    if ($concentration > 99) then {
        gosub gaze my sano crystal
    }
    return


khurnaarti.astrology:
    if ($Astrology.LearningRate < 33) then gosub observe.onTimer
    return


khurnaarti.burgle:
    if ($Stealth.LearningRate > 10) then {
        return
    }
    put burgle recall
    if ($char.timers.nextBurgleAt < $gametime) then {
        gosub burgle.onTimer
    }
    if ($char.timers.nextBurgleAt < $gametime) then {
        put #echo >Log #cc99ff [khurnaarti] Going to burgle
        put #var lib.student 0
        gosub moveToBurgle
        put .burgle
        waitforre ^BURGLE DONE
        gosub release rf
        gosub movetoHouse
        put #script abort all except khurnaarti
        put .train
        put #script abort all except train
        exit
    }


khurnaarti.class:
    if ($lib.student = 1) then {
        return
    } else {
        if (contains("$roomplayers", "Inauri")) then {
            matchre khurnaarti.classSetClass Enchanting|Sorcery|Targeted Magic
            matchre khurnaarti.classNewClass ^No one seems to be teaching\.$
            put assess teach
            matchwait 5
        }
    }
    return


khurnaarti.classNewClass:
    gosub whisper inauri teach %khurnaarti.class
    pause 8
    goto khurnaarti.class


khurnaarti.classSetClass:
    var classTopic $1
    if ("$lib.instructor" = "Inauri") then {
        gosub listen $lib.instructor observe
        put #var lib.student 1
    } else {
        gosub listen $lib.instructor
        put #var lib.student 1
    }
    goto khurnaarti.Class


khurnaarti.combatCheck:
    if ($Brawling.LearningRate < 10) then {
        put #echo >Log Green [khurnaarti] Going to combat.
        put #var lib.student 0
        gosub moveToHunt
        put .fight
        put .afk
        goto khurnaarti.combatLoop
    }
    return


khurnaarti.combatLoop:
    pause 15
    if ($bleeding = 1 || $Warding.LearningRate < 10 || $Utility.LearningRate < 10 || $Augmentation.LearningRate < 10) then {
        put #script abort all except khurnaarti
        put #echo >Log Green [khurnaarti] Combat complete.
        gosub stow
        gosub stow left
        gosub moveToHouse
        put #script abort all except khurnaarti
        put .train
        put #script abort all except train
        exit
   }
   goto khurnaarti.combatLoop


khurnaarti.door:
    if (%khurnaarti.openDoor = 1) then {
        if !(contains("$roomplayers", "Selesthiel") || contains("$roomplayers", "Inauri")) then {
            gosub unlock door
            gosub open door
        }
    }
    if (%khurnaarti.openDoor = 2) then {
        gosub unlock door
        gosub open door
    }
    var khurnaarti.openDoor 0
    return


khurnaarti.faSkin:
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


khurnaarti.forage:
    if ($Outdoorsmanship.LearningRate < 10) then {
        put #echo >Log Orange [khurnaarti] Going to forage.
        put #var lib.student 0
        gosub moveToForage
        put .forage
        waitforre ^FORAGE DONE
        put #script abort all except khurnaarti
        put #echo >Log Orange [khurnaarti] Forage complete.
        gosub moveToHouse
    }
    return


khurnaarti.healthCheck:
    if (%khurnaarti.needHeal = 1) then {
        if (contains("$roomplayers", "Inauri")) then {
            gosub whisper inauri heal
            var khurnaarti.needHeal 0
        }
    }
    if ($bleeding = 1) then {
        if (contains("$roomplayers", "Inauri")) then {
            gosub whisper inauri heal
            var khurnaarti.needHeal 0
        } else {
            put #echo >Log [khurnaarti] Need healing, Inauri unavailable.
            put #script abort all
            put exit
        }
    }
    return


khurnaarti.lock:
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


khurnaarti.look:
    evalmath nextLookAt $lastLookGametime + 240
    if (%nextLookAt < $gametime) then {
        gosub look
        put #var lastLookGametime $gametime
    }
    return


khurnaarti.magic:
    if ($Augmentation.LearningRate < 5) then {
       put #var lastMagicGametime $gametime
       put .magic noLoop
       waitforre ^MAGIC DONE
    }
    return


khurnaarti.perc:
    if ($Attunement.LearningRate < 33) then gosub perc.onTimer
    return


khurnaarti.play:
    if ($Performance.LearningRate > 15) then {
        return
    }
    gosub get my $char.performance.instrument
    gosub play $char.performance.song $char.performance.mood
    waitforre ^You finish playing
    gosub stow my $char.performance.instrument
    return


###############################
###    MOVE TO
###############################
moveToBurgle:
    if ("$roomname" = "Private Home Interior") then {
        put .house
        waitforre ^HOUSE DONE
        goto moveToBurgle
    }
    # Fang Cove
    if ($zoneid = 150) then {
        gosub automove portal
        gosub move go exit portal
        goto moveToBurgle
    }
    # Shard - South of City
    if ($zoneid = 68) then {
        gosub automove 3
        gosub move go path
        goto moveToBurgle
    }
    # Shard - City
    if ($zoneid = 67) then {
        gosub automove portal
    }
    # Shard - East Gate
    if ($zoneid = 66) then {
        if ($roomid = 91) then return
        gosub automove 91
    }
    goto moveToBurgle


moveToFangCove:
    # Shard - East Gate
    if ($zoneid = 66) then {
        if ($roomid = 51) then {
            put #script abort all except khurnaarti
            put .train
            put #script abort all except train
            exit
        }
        gosub automove portal
        gosub move go meeting portal
        gosub automove 51
        goto moveToFangCove
    }
    goto moveToFangCove


moveToForage:
    if ("$roomname" = "Private Home Interior") then {
        put .house
        waitforre ^HOUSE DONE
        goto moveToForage
    }
    # Shard - East Gate
    if ($zoneid = 66) then {
        if ($roomid = 555) then return
        gosub automove 555
    }
    # Fang Cove
    if ($zoneid = 150) then return
    goto movetoForage


moveToHouse:
    if ("$roomname" = "Private Home Interior") then {
        gosub clear
        put #script abort all except khurnaarti
        put .train
        put #script abort all except train
        exit
    }
    # Fang Cove
    if ($zoneid = 150) then {
        gosub automove portal
        gosub move go portal
        goto moveToHouse
    }
    # Shard - South of City
    if ($zoneid = 68) then {
        gosub automove 3
        gosub move go path
        goto moveToHunt
    }
    # Shard - East Gate
    if ($zoneid = 66) then {
        if ($roomid <> 252) then gosub automove 252
    }
    var lastHouseGametime $gametime


    moveToHouse1:
    gosub peer door
    pause 10
    if (%khurnaarti.houseOpen = 0) then {
        pause 5
        evalmath maxHouseTime %lastHouseGametime + 30
        if (%maxHouseTime > $gametime) then {
            goto moveToHouse1
        } else {
            goto moveToFangCove
        }
    }
    if (%khurnaarti.houseOpen = 1) then {
        put .house
        waitforre ^HOUSE DONE$
        var khurnaarti.houseOpen 0
        goto moveToHouse
    }
    if (%khurnaarti.houseRetry = 1) then {
        var khurnaarti.houseRetry 0
        goto khurnaarti.loop
    }
    goto moveToHouse


moveToHunt:
    if ("$roomname" = "Private Home Interior") then {
        put .house
        waitforre ^HOUSE DONE
        goto moveToHunt
    }
    # Fang Cove
    if ($zoneid = 150) then {
        gosub automove portal
        gosub move go exit portal
        goto moveToHunt
    }
    # Shard - South of City
    if ($zoneid = 68) then {
        if ($roomid = 36) then return
        gosub automove 36
        goto moveToHunt
    }
    #Shard - East Gate
    if ($zoneid = 66) then {
        if ($roomid = 163) then return
        gosub automove 163
        goto moveToHunt
    }
    goto moveToHunt