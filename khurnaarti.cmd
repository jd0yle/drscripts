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
action var khurnaarti.justice 0 when ^You're fairly certain this area is lawless and unsafe\.$
action var khurnaarti.justice 1 when ^After assessing the area, you think local law enforcement keeps an eye on what's going on here\.$
action var khurnaarti.needHeal 0 when ^You have no significant injuries\.$
action var khurnaarti.needHeal 1 when ^You have.*(blank stare|bleeding|bloated|bruises|bruising|chunks|clouded|cracked|cuts|death pallor|difficulty|emaciated|eye socket|gashes|horrendous|mangled|numbness|open|painful|paralysis|paralyzed|rash|severe|severely|slashes|stump|swelling|swollen|twitch|twitching)
action var khurnaarti.needHeal 1 when ^The pain is too much\.$|^You are unable to hold the .* telescope steady, and give up\.$|You cannot play the voodoo priest's rattle in your current physical condition\.$
action var khurnaarti.needHeal 1 ; goto khurnaarti.loop when eval $bleeding = 1
action var khurnaarti.openDoor 1 when ^(Qizhmur|Selesthiel|Izqhhrzu)'s face appears in the
action var khurnaarti.openDoor 0 when ^(\S+) opens the door\.
action put #var lib.student 0 when ^Inauri stops teaching\.$
action put #var lastTrainerGametime $gametime when ^The leather looks frayed, as if worked too often recently
action (health) goto getHealedTrigger when eval $health < 85
action (health) goto getHealedTrigger when eval $bleeding = 1

if ($health < 80 && "$roomname" <> "Private Home Interior") then goto getHealedTrigger

var khurnaarti.mode normal
if_1 then {
    if ("%1" = "fight") then {
        var khurnaarti.mode fight
        put .fight
        put .afk
        goto khurnaarti.combatLoop
    }
    if ("%1" = "idle") then {
        var khurnaarti.mode idle
        goto khurnaarti.idle
    }
}
###############################
###    VARIABLES
###############################
if (!($khurnaarti.student >0)) then put #var khurnaarti.student 0
if (!($lastAppGametime >0)) then put #var lastAppGametime 0
if (!($lastCompendiumGametime >0)) then put #var lastCompendiumGametime 0
if (!($lastLookGametime >0)) then put #var lastLookGametime 0
if (!($lastPercGametime >0)) then put #var lastPercGametime 0
if (!($lastLocksGametime >0)) then put #var lastLocksGametime 0
if (!($lastTrainerGametime >0)) then put #var lastTrainerGametime 0

put exp magic all
if ($Targeted_Magic.Ranks = $Debilitation.Ranks) then {
    var khurnaarti.class sorcery
}
if ($Targeted_Magic.Ranks < $Debilitation.Ranks) then {
    var khurnaarti.class target
} else {
    var khurnaarti.class debilitation
}
var khurnaarti.combatReturn 0
var khurnaarti.forageRoom 44
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
    gosub khurnaarti.healthCheck
    gosub khurnaarti.scriptCheck
    if ("%khurnaarti.mode" = "fight") then {
        gosub moveToCombat
        gosub khurnaarti.combatLoop
    }
    if ("%khurnaarti.mode" = "idle") then {
        goto khurnaarti.idle
    }
    gosub almanac.onTimer
    gosub khurnaarti.burgle
    gosub khurnaarti.forage
    gosub khurnaarti.class
    pause 1
    if ($Astrology.LearningRate < 30) then gosub khurnaarti.astrology
    pause 1
    if ($lib.magicInert <> 1) then {
        if ($Attunement.LearningRate < 33 && $lib.magicInert <> 1) then gosub perc.onTimer
        gosub khurnaarti.arcana
        if ($mana > 30 && $lib.magicInert <> 1) then gosub khurnaarti.magic
        if (&& $lib.magicInert <> 1) then gosub khurnaarti.research
        gosub khurnaarti.healthCheck
    }
    pause 1
    gosub khurnaarti.appraisal
    gosub khurnaarti.caracal
    gosub khurnaarti.compendium
    gosub khurnaarti.play
    gosub khurnaarti.lock
    gosub khurnaarti.combatCheck
    pause 1
    gosub khurnaarti.idle
    goto khurnaarti.loop


khurnaarti.idleLoop:
    pause 5
    gosub khurnaarti.healthCheck
    gosub tdp
    goto khurnaarti.idleLoop


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
    gosub khurnaarti.clearHands
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
        gosub runScript burgle
        put #echo >Log #009933 [khurnaarti] Burgle complete. ATH:($Athletics.LearningRate/34) Locks:($Locksmithing.LearningRate/34) Stealth:($Stealth.LearningRate/34)
        gosub release rf
        gosub moveToPawn
        gosub runScript pawn
        gosub runScript deposit
        pause 1
        if (%khurnaarti.combatReturn = 1) then {
            gosub moveToCombat
            var khurnaarti.combatReturn 0
            goto khurnaarti.combatLoop
        } else {
            gosub moveToHouse
            gosub khurnaarti.restart
        }
    }


khurnaarti.caracal:
    evalmath nextTrainerAt $lastTrainerGametime + 3600
    if (%nextTrainerAt > $gametime) then {
        return
    }
    gosub khurnaarti.clearHands
    if ($First_Aid.LearningRate < 15 && $Skinning.LearningRate < 15) then {
        put #echo >Log #009933 [khurnaarti] Beginning trainer.
        gosub runScript caracal
    	put #echo >Log #009933 [khurnaarti] Trainer complete. FA:($First_Aid.LearningRate/34) SK:($Skinning.LearningRate/34)
    	put #var lastTrainerGametime $gametime
    }
    return


khurnaarti.class:
    if ($lib.student = 1) then {
        return
    } else {
        if (contains("$roomplayers", "Inauri")) then {
            matchre khurnaarti.classSetClass a class on (\S+)
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
    if !(contains("$roomplayers", "Selesthiel")) then {
        if ("%classTopic" = "Enchanting") then {
            goto khurnaarti.classNewClass
        }
    }
    if ("$lib.instructor" = "Inauri") then {
        gosub listen $lib.instructor observe
        put #var lib.student 1
    } else {
        gosub listen $lib.instructor
        put #var lib.student 1
    }
    goto khurnaarti.class


khurnaarti.clearHands:
    if ("$righthand" <> "Empty") then {
        gosub stow
    }
    if ("$lefthand" <> "Empty") then {
            gosub stow left
    }
    return


khurnaarti.combatCheck:
    if ($Brawling.LearningRate < 10) then {
        put #echo >Log #FF8080 [khurnaarti] Going to combat.
        gosub moveToCombat
        put .fight
        put .afk
        goto khurnaarti.combatLoop
    }
    return


khurnaarti.combatLoop:
    pause 5
    gosub health
    gosub burgle.setNextBurgleAt
    if ($lib.timers.nextBurgleAt < $gametime) then {
        put #echo >Log #009933 [khurnaarti] Leaving combat to burgle.
        put #script abort fight
        gosub stance shield
        gosub khurnaarti.clearHands
        if ("$preparedspell" <> "None") then {
            gosub release
        }
        if ($SpellTimer.ShadowWeb.duration <> 0) then {
            gosub release shw
        }
        var khurnaarti.combatReturn 1
        goto khurnaarti.burgle
    }
    if (%khurnaarti.needHeal = 1 || $bleeding = 1) then {
        put #script abort fight
        gosub stance shield
        put #echo >Log Pink [khurnaarti] Leaving combat to be healed.
        gosub khurnaarti.clearHands
        gosub moveToHouse
        var khurnaarti.needHeal 1
        gosub khurnaarti.loop
    }
    if !(matchre("$scriptlist", "fight")) then {
        put .fight
    }
    if !(matchre("$scriptlist", "afk")) then {
        put .afk
    }
   goto khurnaarti.combatLoop


khurnaarti.compendium:
    if ($First_Aid.LearningRate < 10) then {
        evalmath nextCompendiumAt $lastCompendiumGametime + 1200
        if (%nextCompendiumAt > $gametime) then {
            return
        }
        gosub khurnaarti.clearHands
        put #echo >Log #ffcc00 [khurnaarti] Beginning compendium.
        gosub runScript compendium
        put #var lastCompendiumGametime $gametime
        put #echo >Log #ffcc00 [khurnaarti] Compendium complete.  FA: ($First_Aid.LearningRate/34) SCH: ($Scholarship.LearningRate/34)
    }
    return


khurnaarti.forage:
    if ($Outdoorsmanship.LearningRate < 10) then {
        put #echo >Log #009933 [khurnaarti] Going to forage.
        put #var lib.student 0
        gosub moveToForage
        gosub runScript forage
        put #echo >Log #009933 [khurnaarti] Forage complete. Outdoor:($Outdoorsmanship.LearningRate/34) Perc:($Perception.LearningRate/34)
        gosub moveToHouse
        gosub khurnaarti.restart
    }
    return


khurnaarti.healthCheck:
    gosub health
    if (%khurnaarti.needHeal = 1|$bleeding = 1) then {
        if ("$roomname" <> "Private Home Interior") then {
            gosub moveToHouse
        }
        if (contains("$roomplayers", "Inauri")) then {
            gosub whisper inauri heal
            pause 10
            if ($bleeding = 0) then {
                var khurnaarti.needHeal 0
            } else {
                gosub whisper inauri heal
                pause 10
            }
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
    # Crossing
    if ($zoneid = 1) then {
        gosub automove portal
        gosub move go meeting portal
        gosub move 50
    }
    # Shard
    if ($zoneid = 66 || $zoneid = 67) then {
        gosub automove portal
        gosub move go meeting portal
        gosub move 50
    }
    # Fang Cove
    if ($zoneid = 150) then {
        if ($roomid = 50) then {
            return
        }
        gosub automove portal
        gosub automove 50
    }
    return


khurnaarti.lock:
    # Limit how often we're looking for locksmithing practice boxes.
    if ($lastLocksGametime > 0) then
        evalmath nextPracticeBoxAt $lastLocksGametime + 3600
        if (%nextPracticeBoxAt > $gametime) then {
            return
        }
    }
    if ($Locksmithing.LearningRate < 10) then {
        put #echo >Log #009933 [khurnaarti] Beginning locksmithing.
        gosub runScript practicebox
        put #echo >Log #009933 [khurnaarti] Locksmithing done Lock:($Locksmithing.LearningRate/34).
        put #var lastLocksGametime $gametime
    }
    return


khurnaarti.idle:
    evalmath nextLookAt $lastLookGametime + 240
    if (%nextLookAt < $gametime) then {
        gosub tdp
        put #var lastLookGametime $gametime
    }
    if ("%khurnaarti.mode" = "idle") then {
        pause 240
        goto khurnaarti.idle
    }
    return


khurnaarti.magic:
    if ($Augmentation.LearningRate < 10 || $Warding.LearningRate < 10 || $Utility.LearningRate < 10) then {
        put #echo >Log #6600ff [khurnaarti] Beginning magic.
        gosub runScript magic noLoop
        put #echo >Log #6600ff [khurnaarti] Magic complete. Aug:($AugmentationWarding.LearningRate/34)
        put #echo >Log #6600ff [khurnaarti] Magic complete. Utility:($Utility.LearningRate/34)
        put #echo >Log #6600ff [khurnaarti] Magic complete. Ward:($Warding.LearningRate/34)
    }
    return


khurnaarti.play:
    if ($Performance.LearningRate > 15) then {
        return
    }
    put #echo >Log #ffcc00 [khurnaarti] Beginning performance.
    gosub khurnaarti.clearHands
    gosub runScript play
    gosub khurnaarti.clearHands
    put #echo >Log #ffcc00 [khurnaarti] Performance complete. Perf:($Performance.LearningRate/34)
    return


khurnaarti.research:
    if ($lib.magicInert = 1) then {
        put #echo >Log #6600ff [khurnaarti] Skipping research due to being magically inert.
        return
    }
    if ($Sorcery.LearningRate < 5) then {
        gosub justice
        if ($lib.justice <> 0) then {
            put #echo >Log #6600ff [khurnaarti] Skipping research due to justice.
            return
        }
        put #echo >Log #6600ff [khurnaarti] Beginning research.
        gosub runScript research sorcery
        put #echo >Log #6600ff [khurnaarti] Research complete. Sorc:($Sorcery.LearningRate/34)
    }
    return


khurnaarti.restart:
    put #echo >log Gray [khurnaarti] Restarting script..
    put #script abort all except khurnaarti
    put .reconnect
    put .khurnaarti
    exit


khurnaarti.scriptCheck:
    if !(matchre("$scriptlist", "reconnect")) then {
        put .reconnect
    }

    if !(matchre("$scriptlist", "afk")) then {
        put .afk
    }
    return


###############################
###    MOVE TO
###############################
moveToBurgle:
    if ("$roomname" = "Private Home Interior") then {
        gosub runScript house
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


moveToCombat:
    if ("$roomname" = "Private Home Interior") then {
        gosub runScript house
        goto moveToCombat
    }
    # Crossing - City
    if ($zoneid = 1) then {
        if ($roomid = 258) then return
        put #echo >log red [khurnaarti] Trying to move to combat in the wrong zone.
        var khurnaarti.mode normal
        goto khurnaarti.loop
    }
    # Crossing - North Gate
    if ($zoneid = 6) then {
        put #echo >log red [khurnaarti] Trying to move to combat in the wrong zone.
        var khurnaarti.mode normal
        goto khurnaarti.loop
    }
    # Shard - East Gate
    if ($zoneid = 66) then {
        if ($roomid = 635) then return
        gosub automove 635
        goto moveToCombat
    }
    # Shard - City
    if ($zoneid = 67) then {
        gosub automove portal
        goto moveToCombat
    }
    # Shard - South of City
    if ($zoneid = 68) then {
        gosub automove 3
        gosub move go path
        goto moveToCombat
    }
    # Fang Cove
    if ($zoneid = 150) then {
        gosub automove portal
        gosub move go exit portal
        goto moveToCombat
    }
    goto moveToCombat


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
        gosub runScript house
        gosub automove %khurnaarti.forageRoom
        return
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
        if ($roomid = %khurnaarti.forageRoom) then return
        gosub automove %khurnaarti.forageRoom
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
    # Shard - City
    if ($zoneid = 67) then {
        gosub automove portal
        gosub move go meeting portal
        goto moveToHouse
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
            gosub runScript house
            return
        }
        gosub automove 50
        goto moveToHouse
    }
    goto moveToHouse


moveToPawn:
    # Crossing - City
    if ($zoneid = 1) then {
        if ($roomid= 433) then return
        gosub automove pawn
        goto moveToPawn
    }
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
    goto moveToPawn


moveToHeal:
    gosub resetState
    gosub prep rf
    pause 3
    gosub cast
    gosub moveToMagic
    gosub getHealed
    put #script abort all except khurnaarti
    put .reconnect
    put .afk
    put .khurnaarti
    exit



###############################
###    HEALTH
###############################
getHealedTrigger:
    put #script abort all except khurnaarti
    put .afk
    put .reconnect

    action (health) off
    put #echo >Log Pink [khurnaarti] Health Trigger activated in [$roomname]. Health = $health Bleeding=$bleeding
    if ($health < 50) then {
        goto logout
    }

    # Leave combat.
    gosub retreat
    gosub stance shield
    gosub stow right
    gosub stow left
    gosub release cyclic
    gosub stow hhr'ata
    gosub stow frying pan
    gosub runScript loot

    # Go to house
    gosub moveToHouse
    gosub getHealed

    # Reset
    gosub khurnaarti.restartScript
    action (health) on


getHealed:
    gosub checkHealth
    if (%injured = 1) then {
        gosub runScript house

        if (contains("$roomplayers", "Inauri")) then {
            gosub whisper inauri heal
            pause 30
        }

        if (!($lastHealedGametime > -1)) then put #var lastHealedGametime 0
        eval nextHealTime (300 + $lastHealedGametime)

        if ($bleeding = 1) then {
            gosub runScript house
            gosub automove heal
            put join list
            matchre getHealedCont Yrisa crosses Khurnaarti's name from the list.
            matchwait 120

            gosub getHealedCont

        }
    }
    return


getHealedCont:
    put #var lastHealedGametime $gametime
    gosub automove meeting portal
    gosub move go exit portal
    if ($bleeding = 1) then goto getHealed


checkHealth:
    var injured 1
    matchre checkHealthInjured ^You have.*(skin|head|neck|chest|abdomen|back|tail|hand|arm|leg|eye|twitching|paralysis)
    matchre checkHealthNotInjured ^You have no significant injuries.
    put health
    matchwait 5
    return


checkHealthInjured:
    var injured 1
    return


checkHealthNotInjured:
    var injured 0
    return
