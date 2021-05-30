include libmaster.cmd
###############################
###    IDLE ACTION TRIGGERS
###############################
action var khurnaarti.houseOpen 1 when ^A sandalwood door suddenly opens\!$
action var khurnaarti.houseOpen 1 when ^A sandalwood door's handle suddenly rattles\!$
#action var khurnaarti.houseRetry 1 ; goto moveToHouse when ^A sandalwood door suddenly closes\!$|^A sandalwood door seems to be closed\.$
action var khurnaarti.needHeal 0 when ^You have no significant injuries\.$
action var khurnaarti.needHeal 1 when ^The pain is too much\.$|^You are unable to hold the .* telescope steady, and give up\.$
action var khurnaarti.openDoor 1 when ^(Qizhmur|Selesthiel)'s face appears in the
action put #var lib.student 0 when ^Inauri stops teaching\.$
action put #var lastTrainerGametime $gametime when ^The leather looks frayed, as if worked too often recently


###############################
###    VARIABLES
###############################
if (!($khurnaarti.student >0)) then put #var khurnaarti.student 0
if (!($char.burgle.cooldown >0)) then put #var char.burgle.cooldown 0
if (!($lastAppGametime >0)) then put #var lastAppGametime 0
if (!($lastLookGametime >0)) then put #var lastLookGametime 0
if (!($lastPercGametime >0)) then put #var lastPercGametime 0
if (!($lastPracticeBoxGametime >0)) then put #var lastPracticeBoxGametime 0
if (!($lastTrainerGametime >0)) then put #var lastTrainerGametime 0

var khurnaarti.class debil
var khurnaarti.houseOpen 0
var khurnaarti.houseRetry 0
var khurnaarti.houseType 0
var khurnaarti.needHeal 0
var khurnaarti.openDoor 0


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
    if ($Attunement.LearningRate < 33) then gosub perc.onTimer
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
    #gosub khurnaarti.combatCheck
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
    gosub burgle.setNextBurgleAt
    if ($lib.timers.nextBurgleAt < $gametime) then {
        put #echo >Log Red [khurnaarti] Going to burgle
        put #var lib.student 0
        gosub moveToBurgle
        put .burgle
        waitforre ^BURGLE DONE
        gosub release rf
        gosub movetoHouse
        put #echo >Log Red [khurnaarti] Burgle complete. ATH:($Athletics.LearningRate/34) Locks:($Locksmithing.LearningRate/34) Stealth:($Stealth.LearningRate/34)
        gosub khurnaarti.restart
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
        gosub listen $lib.instructor observe
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
        put #echo >Log Green [khurnaarti] Combat complete. Brawl:($Brawling.LearningRate/34)
        gosub stow
        gosub stow left
        gosub moveToHouse
        gosub khurnaarti.restart
   }
   goto khurnaarti.combatLoop


khurnaarti.door:
    if (%khurnaarti.openDoor = 1) then {
        if !(contains("$roomplayers", "Selesthiel") || contains("$roomplayers", "Inauri")) then {
            put #script pause all except khurnaarti
            gosub unlock door
            gosub open door
            put #script resume all
        }
    }
    var khurnaarti.openDoor 0
    return


khurnaarti.faSkin:
     evalmath nextTrainerAt $lastTrainerGametime + 3600
    if (%nextTrainerAt > $gametime) then {
        return
    }
    if ($First_Aid.LearningRate < 15 && $Skinning.LearningRate < 15) then {
        put #echo >Log Cyan [khurnaarti] Beginning trainer.
        gosub get my $char.trainer.firstaid
    	gosub skin my $char.trainer.firstaid
    	gosub repair my $char.trainer.firstaid
    	gosub skin my $char.trainer.firstaid
        gosub repair my $char.trainer.firstaid
    	gosub stow my $char.trainer.firstaid
    	put #echo >Log Cyan [khurnaarti] Trainer complete. FA:($First_Aid.LearningRate/34) SK:($Skinning.LearningRate/34)
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
        put #echo >Log Orange [khurnaarti] Forage complete. Outdoor:($Outdoorsmanship.LearningRate/34) Perc:($Perception.LearningRate/34)
        gosub moveToHouse
        gosub khurnaarti.restart
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
            put #echo >Log Pink [khurnaarti] Need healing, Inauri unavailable.
            put exit
            put #script abort all
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
        put #echo >Log Teal [khurnaarti] Beginning locksmithing.
        put .practicebox
        waitforre ^LOCKS DONE
        put #echo >Log Teal [khurnaarti] Locksmithing done Lock:($Locksmithing.LearningRate/34).
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
       put #echo >Log Purple [khurnaarti] Beginning magic.
       put .magic noLoop
       waitforre ^MAGIC DONE
       put #echo >Log Purple [khurnaarti] Magic complete Ward:($Warding.LearningRate/34).
    }
    return


khurnaarti.play:
    if ($Performance.LearningRate > 15) then {
        return
    }
    put #echo >Log Maroon [khurnaarti] Beginning performance.
    if ("$lefthand" <> "Empty" || "$righthand" <> "Empty") then {
        gosub stow
        gosub stow left
        gosub wear $righthandnoun
        gosub wear $lefthandnoun
    }
    gosub get my $char.performance.instrument
    gosub play $char.performance.song $char.performance.mood
    waitforre ^You finish playing
    gosub stow my $char.performance.instrument
    put #echo >Log Maroon [khurnaarti] Performance complete. Perf:($Performance.LearningRate/34)
    return


khurnaarti.restart:
    put #echo >log Orange [khurnaarti] Restarting script..
    put #script abort all except khurnaarti
    put .train
    put .khurnaarti
    exit
###############################
###    MOVE TO
###############################
moveToBurgle:
    if ("$roomname" = "Private Home Interior") then {
        put .house
        waitforre ^HOUSE DONE
        goto moveToBurgle
    }
    # Crossing - City
    if ($zoneid = 1) then {
        if ($roomid = 258) then return
        gosub automove 258
        goto moveToBurgle
    }
    # Crossing - North Gate
    if ($zoneid = 6) then {
        gosub automove crossing
        goto moveToBurgle
    }
    # Shard - East Gate
    if ($zoneid = 66) then {
        if ($roomid = 91) then return
        gosub automove 91
        goto moveToBurgle
    }
    # Shard - City
    if ($zoneid = 67) then {
        gosub automove portal
        goto moveToBurgle
    }
    # Shard - South of City
    if ($zoneid = 68) then {
        gosub automove 3
        gosub move go path
        goto moveToBurgle
    }
    # Fang Cove
    if ($zoneid = 150) then {
        gosub automove portal
        gosub move go exit portal
        goto moveToBurgle
    }
    goto moveToBurgle


moveToFangCove:
    # Crossing - City
    if ($zoneid = 1) then {
        gosub automove portal
        gosub move go meeting portal
        goto moveToFangCove
    }
    # Crossing - North Gate
    if ($zoneid = 6) then {
        gosub automove crossing
        goto moveToFangCove
    }
    # Shard - East Gate
    if ($zoneid = 66) then {
        gosub automove portal
        gosub move go meeting portal
        goto moveToFangCove
    }
    # Fang Cove
    if ($zoneid = 150) then {
        if ($roomid = 50) then {
            put #script abort all except khurnaarti
            put .train
            put .khurnaarti
        }
        gosub automove 50
        goto moveToFangCove
    }
    goto moveToFangCove


moveToForage:
    if ("$roomname" = "Private Home Interior") then {
        put .house
        waitforre ^HOUSE DONE
        goto moveToForage
    }
    # Crossing - City
    if ($zoneid = 1) then {
        if ($roomid = 258) then return
        gosub automove 258
        goto moveToForage
    }
    # Crossing - North Gate
    if ($zoneid = 6) then {
        gosub automove crossing
        goto moveToForage
    }
    # Shard - East Gate
    if ($zoneid = 66) then {
        if ($roomid = 555) then return
        gosub automove 555
    }
    # Fang Cove
    if ($zoneid = 150) then return
    goto moveToForage


moveToHouse:
    if ("$roomname" = "Private Home Interior") then {
        gosub clear
        gosub khurnaarti.restart
    }
    # Crossing - City
    if ($zoneid = 1) then {
        gosub automove portal
        goto moveToHouse
    }
    # Crossing - North Gate
    if ($zoneid = 6) then {
        gosub automove crossing
        goto moveToHouse
    }
    # Shard - East Gate
    if ($zoneid = 66) then {
        gosub automove portal
        gosub move go meeting portal
    }
    # Shard - South of City
    if ($zoneid = 68) then {
        gosub automove 3
        gosub move go path
        goto moveToHouse
    }
    # Fang Cove
    if ($zoneid = 150) then {
        if ($roomid = 50) then return
        gosub automove 50
        goto moveToHouse
    }


    moveToHouse1:
    gosub peer bothy
    pause 15
    if (%khurnaarti.houseOpen = 0) then {
        goto moveToFangCove
    } else {
        put .house
        waitforre ^HOUSE DONE$
        var khurnaarti.houseOpen 0
        goto moveToHouse
    }
    goto moveToHouse


moveToHunt:
    if ("$roomname" = "Private Home Interior") then {
        put .house
        waitforre ^HOUSE DONE
        goto moveToHunt
    }
    # Crossing - City
    if ($zoneid = 1) then {
        gosub automove portal
        gosub move go meeting portal
        goto moveToHunt
    }
    # Crossing - North Gate
    if ($zoneid = 6) then {
        gosub automove crossing
        goto moveToHunt
    }
    #Shard - East Gate
    if ($zoneid = 66) then {
        gosub automove portal
        gosub move go meeting portal
        goto moveToHunt
    }
    # Shard - South of City
    if ($zoneid = 68) then {
        if ($roomid = 36) then return
        gosub automove 36
        goto moveToHunt
    }
    # Fang Cove
    if ($zoneid = 150) then {
        if ($roomid = 93) then return
        gosub automove 93
        goto moveToHunt
    }
    goto moveToHunt