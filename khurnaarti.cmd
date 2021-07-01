include libmaster.cmd
#
# Log Colors
# ------------
# Combat - #FF8080
# Core Script - Gray
# Health - Pink
# Lore - #ffcc00
# Magic - #6600ff
# Survival - #009933
#
###############################
###    IDLE ACTION TRIGGERS
###############################
action goto khurnaarti.houseEnter when ^(.*)suddenly opens\!$
action var khurnaarti.houseOpen 1 when ^(.*)suddenly rattles\!$
action var khurnaarti.justice 0 when ^You're fairly certain this area is lawless and unsafe\.$
action var khurnaarti.justice 1 when ^After assessing the area, you think local law enforcement keeps an eye on what's going on here\.$
action var khurnaarti.needHeal 0 when ^You have no significant injuries\.$
action var khurnaarti.needHeal 1 when ^The pain is too much\.$|^You are unable to hold the .* telescope steady, and give up\.$
action var khurnaarti.needHeal 1 ; goto khurnaarti.loop when eval $vitality < 60
action var khurnaarti.openDoor 1 when ^(Qizhmur|Selesthiel|Izqhhrzu)'s face appears in the
action var khurnaarti.openDoor 0 when ^(\S+) opens the door\.
action put #var lib.student 0 when ^Inauri stops teaching\.$
action put #var lastTrainerGametime $gametime when ^The leather looks frayed, as if worked too often recently


###############################
###    VARIABLES
###############################
if (!($khurnaarti.student >0)) then put #var khurnaarti.student 0
if (!($lastAppGametime >0)) then put #var lastAppGametime 0
if (!($lastCompendiumGametime >0)) then put #var lastCompendiumGametime 0
if (!($lastLookGametime >0)) then put #var lastLookGametime 0
if (!($lastPercGametime >0)) then put #var lastPercGametime 0
if (!($lastPracticeBoxGametime >0)) then put #var lastPracticeBoxGametime 0
if (!($lastTrainerGametime >0)) then put #var lastTrainerGametime 0

var khurnaarti.class tm
var khurnaarti.houseOpen 0
var khurnaarti.houseRetry 0
var khurnaarti.houseType 0
var khurnaarti.needHeal 0
var khurnaarti.openDoor 0
put #tvar khurnaarti.subScript 0


###############################
###    MAIN
###############################
khurnaarti.loop:
    gosub clear
    if ($standing = 0) then gosub stand
    pause 1
    gosub khurnaarti.locationCheck
    pause 1
    gosub khurnaarti.healthCheck
    pause 1
    if ($khurnaarti.subScript > 0) then goto khurnaarti.resumeScript
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
    gosub khurnaarti.compendium
    pause 1
    gosub khurnaarti.lock
    pause 1
    gosub khurnaarti.burgle
    pause 1
    gosub khurnaarti.magic
    pause 1
    gosub khurnaarti.play
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
    if ($Appraisal.LearningRate < 33) then {
        gosub appraise.onTimer
    }
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
    if !matchre("$righthand|$lefthand", "Empty") then {
        gosub stow
        gosub stow left
    }
    if ($Astrology.LearningRate < 33) then {
        put #echo >Log #6600ff [khurnaarti] Beginning Astrology.
        gosub observe.onTimer
        put #echo >Log #6600ff [khurnaarti] Astrology complete. ASTR: ($Astrology.LearningRate/34)
    }
    return


khurnaarti.burgle:
    gosub burgle.setNextBurgleAt
    if ($lib.timers.nextBurgleAt < $gametime) then {
        put #echo >Log #009933 [khurnaarti] Going to burgle
        put #var lib.student 0
        gosub moveToBurgle
        put .burgle
        waitforre ^BURGLE DONE
        gosub release rf
        gosub moveToPawn
        put .pawn
        waitforre ^PAWN DONE
        gosub automove portal
        gosub move go meeting portal
        put .deposit
        waitforre ^DEPOSIT DONE
        gosub moveToHouse
        put #echo >Log #009933 [khurnaarti] Burgle complete. ATH:($Athletics.LearningRate/34) Locks:($Locksmithing.LearningRate/34) Stealth:($Stealth.LearningRate/34)
        gosub khurnaarti.restart
    }


khurnaarti.class:
    if ($lib.student = 1) then {
        return
    } else {
        if (contains("$roomplayers", "Inauri")) then {
            matchre khurnaarti.classSetClass Enchanting|Sorcery|Targeted Magic|Debilitation
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
    if ($Brawling.LearningRate < 10 && $Warding.LearningRate > 20) then {
        put #echo >Log #FF8080 [khurnaarti] Going to combat.
        put #var lib.student 0
        gosub moveToHunt
        put .fight
        put .afk
        goto khurnaarti.combatLoop
    }
    return


khurnaarti.combatLoop:
    pause 15
    if ($bleeding = 1) then {
        put #script abort fight
        put #echo >Log Pink [khurnaarti] Leaving combat to be healed.
        gosub stow
        gosub stow left
        gosub moveToHouse
        var khurnaarti.needHeal 1
        gosub khurnaarti.loop
    }

    if ($Warding.LearningRate < 10 || $Utility.LearningRate < 10 || $Augmentation.LearningRate < 10) then {
        put #script abort fight
        put #echo >Log #FF8080 [khurnaarti] Combat complete. Brawl:($Brawling.LearningRate/34)
        gosub stow
        gosub stow left
        gosub moveToHouse
        gosub khurnaarti.restart
   }
   goto khurnaarti.combatLoop


khurnaarti.compendium:
    evalmath nextCompendiumAt $lastCompendiumGametime + 1200
    if (%nextCompendiumAt > $gametime) then {
        return
    }
    if !matchre("$righthand|$lefthand", "Empty") then {
        gosub stow
        gosub stow left
    }
    put #echo >Log #ffcc00 [khurnaarti] Beginning compendium.
    put .compendium
    waitforre ^COMPENDIUM DONE
    put #var lastCompendiumGametime $gametime
    put #echo >Log #ffcc00 [khurnaarti] Compendium complete.  FA: ($First_Aid.LearningRate/34) SCH: ($Scholarship.LearningRate/34)
    return


khurnaarti.door:
    if (%khurnaarti.openDoor = 1) then {
        if !(contains("$roomplayers", "Selesthiel") || contains("$roomplayers", "Inauri")) then {
            if matchre("$scriptlist", "magic|research|compendium") then {
                put #tvar khurnaarti.subScript $1
                put #script abort $khurnaarti.subScript
            }
            gosub unlock door
            gosub open door
        }
    }
    var khurnaarti.openDoor 0
    goto khurnaarti.loop


khurnaarti.faSkin:
     evalmath nextTrainerAt $lastTrainerGametime + 3600
    if (%nextTrainerAt > $gametime) then {
        return
    }
    if !matchre("$righthand|$lefthand", "Empty") then {
        gosub stow
        gosub stow left
    }
    if ($First_Aid.LearningRate < 15 && $Skinning.LearningRate < 15) then {
        put #echo >Log #009933 [khurnaarti] Beginning trainer.
        gosub get my $char.trainer.firstaid
    	gosub skin my $char.trainer.firstaid
    	gosub repair my $char.trainer.firstaid
    	gosub skin my $char.trainer.firstaid
        gosub repair my $char.trainer.firstaid
    	gosub stow my $char.trainer.firstaid
    	put #echo >Log #009933 [khurnaarti] Trainer complete. FA:($First_Aid.LearningRate/34) SK:($Skinning.LearningRate/34)
    }
    return


khurnaarti.forage:
    if ($Outdoorsmanship.LearningRate < 10) then {
        put #echo >Log #009933 [khurnaarti] Going to forage.
        put #var lib.student 0
        gosub moveToForage
        put .forage
        waitforre ^FORAGE DONE
        put #script abort all except khurnaarti
        put #echo >Log #009933 [khurnaarti] Forage complete. Outdoor:($Outdoorsmanship.LearningRate/34) Perc:($Perception.LearningRate/34)
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


khurnaarti.locationCheck:
    if ("$roomname" = "Private Home Interior") then {
        return
    }
    # Shard
    if ($zoneid = 66 || $zoneid = 67) then {
        gosub automove portal
        gosub move go meeting portal
        gosub move 50
    }
    # Fang Cove
    if ($zoneid = 150) then {
        if ($roomid = 50) then return
        gosub automove portal
        gosub automove 50
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
        put #echo >Log #009933 [khurnaarti] Beginning locksmithing.
        put .practicebox
        waitforre ^LOCKS DONE
        put #echo >Log #009933 [khurnaarti] Locksmithing done Lock:($Locksmithing.LearningRate/34).
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
       put #echo >Log #6600ff [khurnaarti] Beginning magic.
       put .magic noLoop
       waitforre ^MAGIC DONE
       put #echo >Log #6600ff [khurnaarti] Magic complete Ward:($Warding.LearningRate/34).
    }
    return


khurnaarti.play:
    if ($Performance.LearningRate > 15) then {
        return
    }
    put #echo >Log #ffcc00 [khurnaarti] Beginning performance.
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
    put #echo >Log #ffcc00 [khurnaarti] Performance complete. Perf:($Performance.LearningRate/34)
    return


khurnaarti.research:
    if ($lib.magicInert = 1) then {
        put #echo >Log #6600ff [khurnaarti] Skipping research due to being magically inert.
        return
    }
    if ($Sorcery.LearningRate < 5) then {
        put justice
        if (%khurnaarti.justice = 1) then {
            put #echo >Log #6600ff [khurnaarti] Skipping research due to justice.
            return
        }
        put .look
        put #echo >Log #6600ff [khurnaarti] Beginning research.
        put .research sorcery
        waitforre ^RESEARCH DONE
        put #echo >Log #6600ff [khurnaarti] Research complete. Sorc:($Sorcery.LearningRate/34)
    }
    return


khurnaarti.resumeScript:
    if ("$khurnaarti.subScript" = "magic") then {
        put .magic noLoop
    }
    if ("$khurnaarti.subScript" = "research") then {
        put .research sorcery
    }
    if ("$khurnaarti.subScript" = "compendium") then {
        if ("$righthandnoun" <> "$char.compendium") then {
            gosub stow
            gosub get my $char.compendium
            put .compendium
        }
    }
    put #tvar khurnaarti.subScript 0
    return


khurnaarti.restart:
    put #echo >log Gray [khurnaarti] Restarting script..
    put #script abort all except khurnaarti
    put .reconnect
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
            goto khurnaarti.restart
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
        if ($roomid = 50) then {
            gosub peer bothy
            pause 20
            if (%khurnaarti.houseOpen = 0) then {
                goto moveToFangCove
            }
        }
        gosub automove 50
        goto moveToHouse
    }
    goto moveToHouse


khurnaarti.houseEnter:
    put .house
    waitforre ^HOUSE DONE$
    var khurnaarti.houseOpen 0
    goto khurnaarti.restart


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


moveToPawn:
    # Shard - East Gate
    if ($zoneid = 66) then {
        gosub automove portal
        gosub move go gate
        goto moveToPawn
    }
    # Shard - City
    if ($zoneid = 67) then {
        if ($roomid = 158) then return
        gosub automove pawn
        goto moveToPawn
    }
    goto moveToPaw