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
action var khurnaarti.armor 0 when You aren't wearing anything like that\.
action var khurnaarti.armor 1 when All of your armor
action var khurnaarti.bagContent $1 when ^In .* you see (.*)\.$
action var khurnaarti.bagHasContent 1 when ^Inside a writhing eddy of silvery light caught in a ka\'hurst sun, you see\:
action var khurnaarti.bagHasContent 0 when ^There's nothing inside (.*)\!$
action var khurnaarti.needHeal 0 when ^You have no significant injuries\.$
action var khurnaarti.needHeal 1 when ^You have.*(blank stare|bleeding|bloated|bruises|bruising|chunks|clouded|cracked|cuts|death pallor|difficulty|emaciated|eye socket|gashes|horrendous|mangled|numbness|open|painful|paralysis|paralyzed|rash|severe|severely|slashes|stump|swelling|swollen|twitch|twitching)
action var khurnaarti.needHeal 1 when ^The pain is too much\.|You are unable to hold the .* telescope steady, and give up\.|You cannot play the .* in your current physical condition\.|Will alone cannot conquer the paralysis that has wracked your body\.
action var khurnaarti.needHeal 1 ; goto khurnaarti-loop when eval $bleeding = 1
action var khurnaarti.openDoor 1 when ^(Qizhmur|Selesthiel|Izqhhrzu)'s face appears in the
action var khurnaarti.openDoor 0 when ^(\S+) opens the door\.
action put #var lib.student 0 when ^Inauri stops teaching\.$
action put #var lastTrainerGametime $gametime when ^The leather looks frayed, as if worked too often recently
action (health) goto khurnaarti-getHealedTrigger when eval $health < 85
action (health) goto khurnaarti-getHealedTrigger when eval $bleeding = 1
action put store box purse;put stow;put stow left when There isn't any more room in the eddy for that\.|You just can't get the (.*) to fit in the writhing eddy, no matter how you arrange it\.
#action put store box backpack;put stow;put stow left when There isn't any more room in the purse for that\.|You just can't get the (.*) to fit in the leather purse, no matter how you arrange it\.
#action put store box shadows;put stow;put stow left when There isn't any more room in the backpack for that\.|You just can't get the (.*) to fit in the indigo backpack, no matter how you arrange it\.
action goto khurnaarti-fullBags when There isn't any more room in the purse for that\.|You just can't get the (.*) to fit in the leather purse, no matter how you arrange it\.|That's too heavy to go in there\!
action goto khurnaarti-fullPouch when ^You think the black gem pouch is too full to fit another gem into\.$
action send tie my $char.inv.gemPouch when ^You've already got a wealth of gems in there\!  You'd better tie it up before putting more gems inside\.


if ($health < 80 && "$roomname" <> "Private Home Interior") then goto khurnaarti-getHealedTrigger

if_1 then {
    if ("%1" = "fight") then {
        var khurnaarti.mode fight
        put .fight
        put .afk
        goto khurnaarti-combatLoop
    }
    if ("%1" = "idle") then {
        var khurnaarti.mode idle
        goto khurnaarti-idle
    }
}


###############################
###    VARIABLES
###############################
if (!($char.inv.refillGemPouches >0)) then put #tvar char.inv.refillGemPouches 0
if (!($lastAppGametime >0)) then put #var lastAppGametime 0
if (!($lastCompendiumGametime >0)) then put #var lastCompendiumGametime 0
if (!($lastHealedGametime >0)) then put #var lastHealedGametime 0
if (!($lastLookGametime >0)) then put #var lastLookGametime 0
if (!($lastPercGametime >0)) then put #var lastPercGametime 0
if (!($lastLocksGametime >0)) then put #var lastLocksGametime 0
if (!($lastRefreshGametime >0)) then put #var lastRefreshGametime 0
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
var khurnaarti.armor 0
var khurnaarti.bagContent 0
var khurnaarti.bagHasContent 0
var khurnaarti.combatReturn 0
var khurnaarti.forageRoom 44
var khurnaarti.mode normal
var khurnaarti.needHeal 0


###############################
###    MAIN
###############################
khurnaarti-loop:
    gosub clear
    if ($standing = 0) then gosub stand
    pause 1
    gosub khurnaarti-locationCheck
    gosub khurnaarti-healthCheck
    gosub khurnaarti-refreshCheck
    gosub khurnaarti-scriptCheck
    if ("%khurnaarti.mode" = "fight") then {
        gosub khurnaarti-armorCheck
        gosub khurnaarti-combatCheck
    }
    if ("%khurnaarti.mode" = "idle") then {
        goto khurnaarti-idle
    }
    gosub almanac.onTimer
    gosub khurnaarti-burgle
    gosub khurnaarti-forage
    gosub khurnaarti-class
    pause 1
    if ($Astrology.LearningRate < 30) then gosub khurnaarti-astrology
    pause 1
    if ($lib.magicInert <> 1) then {
#        if ($lib.magicInert <> 1) then gosub khurnaarti-research
        if ($Attunement.LearningRate < 33 && $lib.magicInert <> 1) then gosub perc.onTimer
        gosub khurnaarti-arcana
        if ($mana > 30 && $lib.magicInert <> 1) then gosub khurnaarti-magic
#        if ($lib.magicInert <> 1) then gosub khurnaarti-research
        gosub khurnaarti-healthCheck
    }
    pause 1
    if ($Appraisal.LearningRate < 33) then gosub appraise.onTimer
    gosub khurnaarti-caracal
    gosub khurnaarti-compendium
    gosub khurnaarti-play
    gosub khurnaarti-openBoxes
    gosub khurnaarti-lock
    gosub khurnaarti-combatCheck
    pause 1
    gosub khurnaarti-idle
    goto khurnaarti-loop


khurnaarti-idleLoop:
    pause 5
    gosub khurnaarti-healthCheck
    gosub tdp
    goto khurnaarti-idleLoop


###############################
###    SKILL METHODS
###############################
khurnaarti-arcana:
    if ($Arcana.LearningRate > 15) then {
        return
    }
    if ($concentration > 99) then {
        gosub gaze my sano crystal
    }
    return


khurnaarti-armorCheck:
    gosub inventory armor
    if ("%khurnaarti.armor" = "0") then {
        gosub runscript armor wear
    }
    return


khurnaarti-astrology:
    gosub khurnaarti-clearHands
    if ($Astrology.LearningRate < 33) then {
        put #echo >Log #6600ff [khurnaarti] Beginning Astrology.
        gosub observe.onTimer
        put #echo >Log #6600ff [khurnaarti] Astrology complete. ASTR: ($Astrology.LearningRate/34)
    }
    return


khurnaarti-burgle:
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
        gosub moveToFangCove
        gosub runScript deposit
        pause 1
        if (%khurnaarti.combatReturn = 1) then {
            gosub moveToCombat
            var khurnaarti.combatReturn 0
            goto khurnaarti-combatLoop
        } else {
            gosub runScript house
            gosub khurnaarti-restart
        }
    }


khurnaarti-caracal:
    evalmath nextTrainerAt $lastTrainerGametime + 3600
    if (%nextTrainerAt > $gametime) then {
        return
    }
    gosub khurnaarti-clearHands
    if ($First_Aid.LearningRate < 15 && $Skinning.LearningRate < 15) then {
        put #echo >Log #009933 [khurnaarti] Beginning trainer.
        gosub runScript caracal
    	put #echo >Log #009933 [khurnaarti] Trainer complete. FA:($First_Aid.LearningRate/34) SK:($Skinning.LearningRate/34)
    	put #var lastTrainerGametime $gametime
    }
    return


khurnaarti-class:
    if ($lib.student = 1) then {
        return
    } else {
        if (contains("$roomplayers", "Inauri")) then {
            gosub assess teach

            if ("$lib.topic" = "0") then {
                gosub whisper inauri teach %khurnaarti.class
                pause 11
                goto khurnaarti-class
            } else {
                if ("$lib.topic" = "Enchanting" && (contains("$roomplayers", "Selesthiel"))) then {
                    gosub listen $lib.instructor observe
                    put #var lib.student 1
                } else {
                    if ("$lib.instructor" = "Inauri") then {
                        gosub whisper inauri teach %khurnaarti.class
                        pause 11
                        goto khurnaarti-class
                    } else {
                        gosub listen $lib.instructor
                    }
                }
            }
        }
    }
    return


khurnaarti-clearHands:
    if ("$righthand" <> "Empty") then {
        gosub stow
    }
    if ("$lefthand" <> "Empty") then {
        gosub stow left
    }
    return


khurnaarti-combatCheck:
    if ($Brawling.LearningRate < 10 || $Targeted_Magic.LearningRate < 10 || $Small_Edged.LearningRate < 10 $Heavy_Thrown.LearningRate < 10 || $Light_Thrown.LearningRate < 10 || $Crossbow.LearningRate < 10 || $Staves.LearningRate < 10) then {
        put #echo >Log #FF8080 [khurnaarti] Going to combat.
        gosub moveToCombat
        gosub runScript findSpot blackgargoyle
        put .fight
        put .afk
        goto khurnaarti-combatLoop
    }
    return


khurnaarti-combatLoop:
    pause 5
    gosub health
#    gosub burgle.setNextBurgleAt
#    if ($lib.timers.nextBurgleAt < $gametime) then {
#        put #echo >Log #009933 [khurnaarti] Leaving combat to burgle.
#        put #script abort fight
#        gosub stance shield
#        if ("$preparedspell" <> "None") then {
#            gosub release
#        }
#        if ($SpellTimer.ShadowWeb.duration <> 0) then {
#            gosub release shw
#        }
#        var khurnaartiCombatReturn 1
#        goto khurnaarti-burgle
#    }
    evalmath nextLookAt $lastLookGametime + 1800
    if (%nextLookAt < $gametime) then {
        gosub runscript empty --from=pocket --to=portal
        gosub khurnaarti-clearHands
        put #var lastLookGametime $gametime
    }
    if ($Astrology.LearningRate < 5 && $Warding.LearningRate < 5 && $Utility.LearningRate < 5 && $Augmentation.LearningRate < 5) then {
        put #echo >Log [khurnaarti] Leaving combat.
        goto khurnaarti-combatQuit
    }
    if (%khurnaarti.needHeal = 1 || $bleeding = 1) then {
        put #echo >Log Pink [khurnaarti] Leaving combat to be healed.
        goto khurnaarti-combatQuit
    }
    if ($char.inv.refillGemPouches = 1) then {
        put #echo >Log [khurnaarti] Out of empty gem pouches, restocking.
        goto khurnaarti-combatQuit
    }
    if !(matchre("$scriptlist", "fight")) then {
        put .fight
    }
    if !(matchre("$scriptlist", "afk")) then {
        put .afk
    }
   goto khurnaarti-combatLoop


khurnaarti-combatQuit:
    put #script abort fight
    gosub stance shield
    gosub khurnaarti-clearHands
    gosub moveToHouse
    var khurnaarti.needHeal 1
    goto khurnaarti-loop


khurnaarti-compendium:
    if ($First_Aid.LearningRate < 10) then {
        evalmath nextCompendiumAt $lastCompendiumGametime + 1200
        if (%nextCompendiumAt > $gametime) then {
            return
        }
        gosub khurnaarti-clearHands
        put #echo >Log #ffcc00 [khurnaarti] Beginning compendium.
        gosub runScript compendium --target=34
        put #var lastCompendiumGametime $gametime
        put #echo >Log #ffcc00 [khurnaarti] Compendium complete.  FA: ($First_Aid.LearningRate/34) SCH: ($Scholarship.LearningRate/34)
    }
    return


khurnaarti-forage:
    if ($Outdoorsmanship.LearningRate < 10) then {
        put #echo >Log #009933 [khurnaarti] Going to forage.
        put #var lib.student 0
        gosub moveToForage
        gosub runScript forage
        put #echo >Log #009933 [khurnaarti] Forage complete. Outdoor:($Outdoorsmanship.LearningRate/34) Perc:($Perception.LearningRate/34)
        gosub moveToHouse
        gosub khurnaarti-restart
    }
    return


khurnaarti-fullBags:
    put #echo >Log Red [khurnaarti] All of your bags are full of boxes you idiot.
    gosub store box shadows
    gosub khurnaarti-clearHands
    gosub store box eddy
    gosub stow sphere
    gosub stow hhr'ata
    gosub stow pan
    gosub runScript house
    goto khurnaarti-openBoxes


khurnaarti-fullPouch:
    if (matchre("$scriptlist", "fight|loot|newbox")) then {
        goto khurnaarti-combatLoop
    }

    if !(matchre("$lefthand", "Empty")) then {
        gosub put my $lefthandnoun in my $char.inv.container.default
    }
    gosub remove my $char.inv.gemPouch
    gosub put my $char.inv.gemPouch in my $char.inv.container.fullGemPouch
    gosub get my $char.inv.gemPouch from my $char.inv.containeremptyGemPouch

    if (matchre("$lefthandnoun", "pouch")) then {
        gosub fill my $char.inv.gemPouch with my $char.inv.containerdefault
        gosub tie my $char.inv.gemPouch
        gosub wear my $char.inv.gemPouch
    } else {
        put #echo >Log [khurnaarti] NO MORE EMPTY POUCHES FOUND, setting STORE GEM to $char.inv.containerdefault
        put #tvar char.inv.refillGemPouches 1
        gosub store gem $char.inv.container.default
    }
    goto khurnaarti-combatLoop



khurnaarti-healthCheck:
    gosub health
    if (%khurnaarti.needHeal = 1 || $bleeding = 1) then {
        if ("$roomname" <> "Private Home Interior") then {
            gosub moveToHouse
        }
        if (contains("$roomplayers", "Inauri")) then {
            gosub whisper inauri heal
            pause 15
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


khurnaarti-idle:
    evalmath nextLookAt $lastLookGametime + 240
    if (%nextLookAt < $gametime) then {
        gosub tdp
        put #var lastLookGametime $gametime
    }
    if ("%khurnaarti.mode" = "idle") then {
        pause 240
        goto khurnaarti-idle
    }
    return


khurnaarti-locationCheck:
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
    # Inner, Outer Hib
    if ($zoneid = 116) then {
        gosub automove portal
        gosub move go meeting portal
        gosub move 50
    }
    # Road between Hib and Boar Clan
    if ($zoneid = 126) then {
        gosub automove hib
    }
    # Boar Clan
    if ($zoneid = 127) then {
        gosub automove 19
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


khurnaarti-lock:
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


khurnaarti-magic:
    if ($Augmentation.LearningRate < 10 || $Warding.LearningRate < 10 || $Utility.LearningRate < 10) then {
        put #echo >Log #6600ff [khurnaarti] Beginning magic.
        gosub runScript magic noLoop
        put #echo >Log #6600ff [khurnaarti] Magic complete. Aug:($AugmentationWarding.LearningRate/34)
        put #echo >Log #6600ff [khurnaarti] Magic complete. Utility:($Utility.LearningRate/34)
        put #echo >Log #6600ff [khurnaarti] Magic complete. Ward:($Warding.LearningRate/34)
    }
    return


khurnaarti-openBoxes:
    gosub inventory eddy
    if (%khurnaarti.bagHasContent = 1) then {
        gosub look in my portal
    }
    if (matchre("%khurnaarti.bagContent", "$char.empty.boxContainer")) then {
        put #echo >Log #009933 [khurnaarti] Found boxes in eddy. Locks:($Locksmithing.LearningRate/34).
        gosub runScript armor remove
        gosub runScript newbox
        put #echo >Log #009933 [khurnaarti] Done opening boxes. Locks:($Locksmithing.LearningRate/34).
        gosub runScript armor wear
        gosub runScript sellgem
    } else {
        put #echo >Log #009933 [khurnaarti] No boxes to open.
        return
    }
    goto khurnaarti-loop


khurnaarti-play:
    if ($Performance.LearningRate > 15) then {
        return
    }
    put #echo >Log #ffcc00 [khurnaarti] Beginning performance.
    gosub khurnaarti-clearHands
    gosub runScript play
    gosub khurnaarti-clearHands
    put #echo >Log #ffcc00 [khurnaarti] Performance complete. Perf:($Performance.LearningRate/34)
    return


khurnaarti-refreshCheck:
    evalmath nextRefreshAt $lastRefreshGametime + 86400
    if (%nextRefreshAt < $gametime) then {
        put #var lastRefreshGametime $gametime
        gosub runScript sellBundle
        gosub runScript sellGem shadow

        if ($char.inv.refillGemPouches = 1) then {
            gosub automove gem
            if (matchre("$roomobjs", "appraiser|gembuyer|Wickett")) then {
                var npc $0
            }
            var count 0

            khurnaarti-refreshCheckPouchLoop:
                if (%count <> 30) then {
                    gosub ask %npc for pouch
                    gosub put my pouch in my $char.inv.container.emptyGemPouch
                    math count add 1
                    goto khurnaarti-refreshCheckPouchLoop
                }
                goto khurnaarti-loop
        }
   }
return

khurnaarti-research:
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


khurnaarti-restart:
    put #echo >log Gray [khurnaarti] Restarting script..
    put #script abort all except khurnaarti
    put .reconnect
    put .khurnaarti
    exit


khurnaarti-scriptCheck:
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
    # Inner, Outer Hib
    if ($zoneid = 116) then {
        gosub automove boar
        goto movetoBurgle
    }
    # Road between Hib and Boar Clan
    if ($zoneid = 126) then {
        gosub automove boar
        goto movetoBurgle
    }
    # Boar Clan
    if ($zoneid = 127) then {
        if ($roomid = 19) then return
        gosub automove 19
        goto movetoBurgle
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
        gosub runScript astral hib
        goto moveToCombat
    }
    # Crossing - North Gate
    if ($zoneid = 6) then {
        gosub automove crossing
        gosub runScript astral hib
        goto moveToCombat
    }
    # Shard - East Gate
    if ($zoneid = 66) then {
        gosub automove portal
        gosub runScript astral hib
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
    # Inner, Outer Hib
    if ($zoneid = 116) then {
        gosub automove boar
        goto moveToCombat
    }
    # Road between Hib and Boar Clan
    if ($zoneid = 126) then {
        gosub automove boar
        goto moveToCombat
    }
    # Boar Clan
    if ($zoneid = 127) then {
        return
        goto moveToCombat
    }
    # Fang Cove
    if ($zoneid = 150) then {
        gosub automove portal
        gosub move go exit portal
        goto moveToCombat
    }
    # The Ways
    if ($zoneid = 999) then {
        gosub move go archway
        goto moveToCombat
    }
    goto moveToCombat


moveToFangCove:
    pause .002
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
    # Inner, Outer Hib
    if ($zoneid = 116) then {
        gosub automove portal
        gosub move go meeting portal
    }
    # Road Between Hib and Boar Clan
    if ($zoneid = 126) then {
        gosub automove hib
        goto moveToFangCove
    }
    # Boar Clan
    if ($zoneid = 127) then {
        gosub automove hib
        goto moveToFangCove
    }
    # Fang Cove
    if ($zoneid = 150) then {
        if ($roomid = 50) then {
            goto khurnaarti-restart
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
    gosub runScript house
    return


moveToPawn:
    # Crossing - City
    if ($zoneid = 1) then {
        if ($roomid = 433) then return
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
    # Inner, Outer Hib
    if ($zoneid = 116) then {
        if ("$roomname" = "Reliable Pawn and Dry Goods Emporium") then return
        gosub automove pawn
    }
    # Road Between Hib and Boar Clan
    if ($zoneid = 126) then {
        gosub automove hib
        goto moveToPawn
    }
    # Boar Clan
    if ($zoneid = 127) then {
        gosub automove hib
        goto moveToPawn
    }
    goto moveToPawn


moveToHeal:
    gosub resetState
    gosub prep rf
    pause 3
    gosub cast
    gosub runScript house
    gosub khurnaarti-getHealed
    put #script abort all except khurnaarti
    put .reconnect
    put .afk
    put .khurnaarti
    exit



###############################
###    HEALTH
###############################
khurnaarti-getHealedTrigger:
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
    gosub stow matte sphere
    gosub runScript loot

    # Go to house
    gosub runscript house
    gosub khurnaarti-getHealed

    # Reset
    gosub khurnaarti-restart
    action (health) on


khurnaarti-getHealed:
    gosub khurnaarti-checkHealth
    if (%injured = 1) then {
        gosub runScript house

        if (matchre("$roomplayers", "Inauri")) then {
            gosub whisper inauri heal
            pause 30
            goto khurnaarti-getHealed
        }

        if (!($lastHealedGametime > -1)) then put #var lastHealedGametime 0
        eval nextHealTime (300 + $lastHealedGametime)

        if ($bleeding = 1) then {
            gosub runScript house
            gosub automove heal
            matchre khurnaarti-getHealedCont Yrisa crosses Khurnaarti's name from the list.
            put join list
            matchwait 120

            gosub khurnaarti-getHealedCont

        }
    }
    return


khurnaarti-getHealedCont:
    put #var lastHealedGametime $gametime
    gosub automove meeting portal
    gosub move go exit portal
    if ($bleeding = 1) then goto khurnaarti-getHealed


khurnaarti-checkHealth:
    var injured 1
    matchre khurnaarti-checkHealthInjured ^You have.*(skin|head|neck|chest|abdomen|back|tail|hand|arm|leg|eye|twitching|paralysis)
    matchre khurnaarti-checkHealthNotInjured ^You have no significant injuries.
    put health
    matchwait 5
    return


khurnaarti-checkHealthInjured:
    var injured 1
    return


khurnaarti-checkHealthNotInjured:
    var injured 0
    return
