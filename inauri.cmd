include libmaster.cmd
###############################
###    IDLE ACTIONS
###############################
action put #tvar inauri.heal 1 ; put #tvar inauri.healTarget $1 ; goto inauri.healWound when ^($friends) whispers, "heal
action put #tvar inauri.heal 0 when \.\.\. no injuries to speak of\.
action var inauri.disease 1 when ^(?:His|Her) wounds are (?:badly )?infected
action var inauri.disease 2 ; goto inauri.healDisease when The presence of disturbing black streaks about yourself\.$
action var inauri.poison 1 when ^(?:He|She) has a (?:dangerously|mildly|critically) poisoned
action var inauri.poison 2 ; goto inauri.healPoison when The presence of a faint greenish tinge about yourself\.$|^You feel a slight twinge in your|^You feel a (?:sharp|terrible) pain in your
action var inauri.poison 0 when ^A sudden wave of heat washes over you as your spell flushes all poison from your body\.
action var inauri.vitality 1 when (\S+) is suffering from a .+ loss of vitality.*$
action var inauri.vitality 2 ; goto inauri.healVitality when eval $health < 30
action goto inauri.unity when ^Selesthiel crumples to the ground and is still\.$

action goto inauri.engbolt when ^($friends) whispers, "(.*)bolts(.*)"$/i
action var inauri.openDoor 1 ; goto inauri.door when ^($friends)'s face appears in the
action var inauri.openDoor 0 when ^(\S+) opens the door\.
action goto inauri.houseMove when ^($friends) whispers, "inside|^($friends) whispers, "outside
action var inauri.topic $2 ; var inauri.target $1 ; goto inauri.teach when ^($friends) whispers, "teach (\S+)"$
action put #tvar lastTrainerGametime $gametime when ^The leather looks frayed, as if worked too often recently


###############################
###    CHAR VARIABLES
###############################
if (!($inauri.heal >0)) then put #tvar inauri.heal 0
if (!($inauri.healTarget >0)) then put #tvar inauri.healTarget 0
if (!($inauri.subScript >0)) then put #tvar inauri.subScript 0
if (!($lastAlmanacGametime >0)) then put #tvar lastAlmanacGametime 0
if (!($lastAppGametime >0)) then put #tvar lastAppGametime 0
if (!($lastCompendiumGametime >0)) then put #tvar lastCompendiumGametime 0
if (!($lastLookGametime >0)) then put #tvar lastLookGametime 0
if (!($lastMagicGametime >0)) then put #tvar lastMagicGametime 0
if (!($lastPercHealthGametime >0)) then put #tvar lastPercHealthGametime 0
if (!($lastPrivacyGametime >0)) then put #tvar lastPrivacyGametime 0
if (!($lastTrainerGametime >0)) then put tvar lastTrainerGametime 0

var inauri.disease 0
var inauri.openDoor 0
var inauri.poison 0
var inauri.target 0
var inauri.teach 0
var inauri.topic 0
var inauri.vitality 0


###############################
###    MAIN
###############################
inauri.loop:
    gosub inauri.locationCheck
    gosub inauri.scriptCheck
    if ($standing = 0) then gosub stand
    if ($inauri.subScript <> 0) then gosub inauri.subScriptResume
    if ($lib.magicInert <> 1) then {
        if ($mana > 30 && $SpellTimer.Regenerate.duration < 1) then gosub refreshRegen
        if ($Empathy.LearningRate < 33) then gosub percHealth.onTimer
        if ($Attunement.LearningRate < 30) then gosub perc.onTimer
        if ($Arcana.LearningRate < 10) then gosub inauri.arcana
    }
    if ($Appraisal.LearningRate < 33) then gosub appraise.onTimer
    gosub almanac.onTimer
    gosub inauri.burgle
    gosub inauri.caracal
    gosub inauri.compendium
    gosub inauri.engineer
    gosub inauri.forage
    gosub inauri.idle
    pause 2
    goto inauri.loop


###############################
###    WAIT METHODS
###############################
inauri.arcana:
    if ($concentration > 99) then {
        gosub gaze my sano crystal
    }
    return


inauri.burgle:
    gosub burgle.setNextBurgleAt
    if ($lib.timers.nextBurgleAt < $gametime) then {
        put #echo >Log #009933 [inauri] Going to burgle
        put stop teach
        gosub moveToBurgle
        put #tvar inauri.subScript burgle
        put .burgle
        waitforre ^BURGLE DONE
        put #echo >Log #009933 [inauri] Burgle complete. ATH:($Athletics.LearningRate/34) Locks:($Locksmithing.LearningRate/34) Stealth:($Stealth.LearningRate/34)
        put #tvar inauri.subScript 0

        gosub moveToPawn
        put #tvar inauri.subScript pawn
        put .pawn
        waitforre ^PAWN DONE
        put #tvar inauri.subScript 0

        gosub automove portal
        gosub move go meeting portal
        put #tvar inauri.subScript deposit
        put .deposit
        waitforre ^DEPOSIT DONE
        put #tvar inauri.subScript 0
        gosub moveToHouse
        put .house
        waitforre ^HOUSE DONE
        put #tvar inauri.subScript 0
        return
    }


inauri.caracal:
    evalmath nextTrainerAt $lastTrainerGametime + 3600
    if (%nextTrainerAt > $gametime) then {
        return
    }
    if ($First_Aid.LearningRate < 15 && $Skinning.LearningRate < 15) then {
        put #echo >Log #009933 [inauri] Beginning trainer.
        put #tvar inauri.subScript caracal
        put .caracal
        waitforre ^CARACAL DONE
    	put #echo >Log #009933 [inauri] Trainer complete. FA:($First_Aid.LearningRate/34) SK:($Skinning.LearningRate/34)
    	put #tvar inauri.subScript 0
    }
    return


inauri.compendium:
    evalmath nextCompendiumAt $lastCompendiumGametime + 1200
    if (%nextCompendiumAt > $gametime) then {
        return
    }
    if !(matchre("$righthand|$lefthand", "Empty")) then {
        gosub stow
        gosub stow left
    }
    put #echo >Log Yellow [inauri] Beginning compendium.
    put #tvar inauri.subScript compendium
    put .compendium
    waitforre ^COMPENDIUM DONE
    put #var lastCompendiumGametime $gametime
    put #echo >Log Yellow [inauri] Compendium complete.  FA: ($First_Aid.LearningRate/34) SCH: ($Scholarship.LearningRate/34)
    put #tvar inauri.subScript 0
    return


inauri.door:
    if (matchre("$scriptlist", "($char.common.scripts)")) then {
        put #tvar inauri.subScript $0
        put #script abort $inauri.subScript
        put #echo >Log [inauri] Aborting $inauri.subScript to open the door.
    }
    if (%inauri.openDoor = 0) then goto inauri.loop
    gosub unlock door
    gosub open door
    var look.openDoor 0
    goto inauri.loop


inauri.engbolt:
    if ($eng.repairNeeded = 1) then {
        gosub inauri.engineerRepair
    }
    if ($eng.needLumber = 1) then {
        gosub inauri.engineerLumber
    }
    put #tvar inauri.subScript engbolt
    put #echo >Log #ffcc00 [inauri] Beginning engbolt.
    put .engbolt 5
    waitforre ^ENGBOLT DONE
    put #echo >Log #ffcc00 [inauri] Engbolt complete.  ENG:($Engineering.LearningRate/34)
    put #tvar inauri.subScript 0
    gosub get my bolts
    gosub put my bolts on bookcase
    goto inauri.loop


inauri.engineer:
    if ($Engineering.LearningRate = 0) then {
        if ($eng.repairNeeded = 1) then {
            gosub inauri.engineerRepair
        }
        if ($eng.needLumber = 1) then {
            gosub inauri.engineerLumber
        }
        put #tvar inauri.subScript engineer
        put #echo >Log #ffcc00 [inauri] Beginning engineering.
        put .engineer 5 $char.craft.item
        waitforre ^ENGINEER DONE
        put #echo >Log #ffcc00 [inauri] Engineering complete.  ENG:($Engineering.LearningRate/34)
        put #tvar inauri.subScript 0
    }
    return


inauri.engineerLumber:
    put #echo >Log #ffcc00 [inauri] Need lumber for engineering.
    gosub stop teach
    gosub moveToEngineer
    put #tvar inauri.subScript workorder
    put .workorder
    waitforre ^WORKORDER DONE$
    put #tvar inauri.subScript 0
    put #var eng.needLumber 0
    put #tvar inauri.subScript deposit
    put .deposit
    waitforre ^DEPOSIT DONE$
    put #tvar inauri.subScript 0
    gosub moveToHouse
    put .house
    waitforre ^HOUSE DONE$
    return


inauri.engineerRepair:
    put #echo >Log #ffcc00 [inauri] Need to repair crafting tools.
    gosub stop teach
    put .house
    waitforre ^HOUSE DONE
    put #tvar inauri.subScript repair
    put .repair
    waitforre ^REPAIR DONE$
    put #tvar inauri.subScript 0
    put #var eng.repairNeeded 0
    gosub moveToHouse
    put .house
    waitforre ^HOUSE DONE$
    return


inauri.forage:
    if ($Outdoorsmanship.LearningRate < 10) then {
        put #echo >Log #009933 [inauri] Going to forage.
        put #tvar inauri.subScript forage
        put stop teach
        gosub moveToForage
        put .forage
        waitforre ^FORAGE DONE
        put #echo >Log #009933 [inauri] Forage complete. Outdoor:($Outdoorsmanship.LearningRate/34) Perc:($Perception.LearningRate/34)
        put #tvar inauri.subScript 0
        gosub moveToHouse
    }
    return


inauri.healDisease:
    if (%inauri.disease = 1) then {
        gosub touch $inauri.healTarget
        gosub take $inauri.healTarget disease quick
        var inauri.disease 0
        var inauri.disease 2
    }

    if (%inauri.disease = 2) then {
        gosub runScript cast cd
        if (%inauri.disease = 2) then {
            goto inauri.healDisease
        }
    }
    goto inauri.loop


inauri.healWound:
    if (matchre("$scriptlist", "($char.common.scripts)")) then {
        put #tvar inauri.subScript $0
        put #script abort $inauri.subScript
        put #echo >Log [inauri] Aborting $inauri.subScript to heal $inauri.healTarget.
    }
    if ($inauri.healTarget = 0) then {
        put #var inauri.heal 0
        return
    }
    gosub redirect all to left leg
    gosub touch $inauri.healTarget
    gosub take $inauri.healTarget ever quick
    put #var inauri.heal 0
    if (%inauri.vitality = 1) then {
        gosub touch $inauri.healTarget
        gosub take $inauri.healTarget vitality quick
        var inauri.vitality 0
    }
    goto inauri.loop


inauri.healPoison:
    if (%inauri.poison = 1) then {
        gosub touch $inauri.healTarget
        gosub take $inauri.healTarget poison quick
        var inauri.poison 0
    }
    if (%inauri.poison = 2) then {
        gosub runScript cast fp
        var inauri.poison 0
    }
    goto inauri.loop


inauri.healVitality:
    if (%inauri.vitality = 1) then {
        gosub touch $inauri.healTarget
        gosub take $inauri.healTarget vitality quick
        var inauri.vitality 0
        goto inauri.loop
    }

    if (%inauri.vitality = 2) then {
        gosub link all cancel
        if ($lib.magicInert = 1 && $bleeding = 1) then {
            put #echo >Log [inauri] Bleeding, low vitality, and magically inert.
            put exit
            exit
        }

        inauri.healVitalityLoop:
            pause .2
            gosub prep vh
            pause 2
            gosub cast
            if ($health < 70) then {
                goto inauri.healVitalityLoop
            } else {
                var inauri.vitality 0
            }
            goto inauri.loop


inauri.idle:
    evalmath nextLookAt $lastLookGametime + 240
    if (%nextLookAt < $gametime) then {
        gosub tdp
        put #var lastLookGametime $gametime
    }
    return


inauri.locationCheck:
    if ("$roomname" = "Private Home Interior") then return
    gosub movetoHouse
    put .house
    waitforre ^HOUSE DONE
    return


inauri.magic:
    evalmath nextMagic $lastMagicGametime + 3600
    if (%nextMagic < $gametime) then {
        var inauri.magicRates ($Augmentation.LearningRate + $Warding.LearningRate + $Utility.LearningRate)
        if (%inauri.magicRates < 15 ) then {
            put #echo >Log Purple [inauri] Beginning magic.
            put #tvar inauri.subScript magic
            put .look
            put .magic noLoop
            waitforre ^MAGIC DONE
            put #tvar inauri.subScript 0
            put #echo >Log #6600ff [inauri] Magic complete. Aug:($AugmentationWarding.LearningRate/34)
            put #echo >Log #6600ff [inauri] Magic complete. Utility:($Utility.LearningRate/34)
            put #echo >Log #6600ff [inauri] Magic complete. Ward:($Warding.LearningRate/34)
            put #tvar inauri.subScript 0
        }
    }
    return


inauri.research:
    if ($Sorcery.LearningRate < 5) then {
        gosub justice
        if ($lib.justice <> 0) then {
            put #echo >Log #6600ff [inauri] Skipping research due to justice.
            return
        }
        put #echo >Log #6600ff [inauri] Beginning research.
        put #tvar inauri.subScript magic
        put .look
        put .research sorcery
        waitforre ^RESEARCH DONE
        put #echo >Log #6600ff [inauri] Research complete. Sorc:($Sorcery.LearningRate/34)
        put #tvar inauri.subScript 0
    }
    return


inauri.scriptCheck:
    if (!contains("$scriptlist", "reconnect.cmd")) then {
        put #echo >Log [inauri] Starting reconnect
        put .reconnect
    }
    if (contains("$scriptlist", "look")) then {
        put #script abort look
    }
    return


inauri.subScriptResume:
    put #echo >Log [inauri] Attempting to resume $inauri.subScript...
    if ("$inauri.subScript" = "engineer") then {
        if ("$lefthand" <> "Empty") then gosub stow left
        if ("$righthand" <> "$char.craft.item") then gosub stow
        gosub inauri.engineer
    }

    if ("$inauri.subScript" = "engbolt") then {
        if ("$righthand" <> "bolts") then {
            gosub stow
            gosub stow left
        }
        gosub inauri.engbolt
    }

    if ("$inauri.subScript" = "magic" || "$inauri.subScript" = "research") then {
        put tvar lastMagicGametime 0
    }

    var inauri.scriptQuickResume caracal|compendium|deposit|forage|pawn|workorder|repair
    if (matchre("$inauri.subScript" = "(%inauri.scriptQuickResume)")) then {
        gosub inauri.$inauri.subScript
    }

    if ("$inauri.subScript" = "burgle") then {
        put #tvar inauri.subScript 0
    }

    return


inauri.restart:
    put #echo >log Orange [inauri] Restarting script..
    put #script abort all except inauri
    put .reconnect
    put .inauri
    exit


inauri.teach:
    if (matchre("$scriptlist", "($char.common.scripts)")) then {
        put #tvar inauri.subScript $0
        put #script abort $inauri.subScript
        put #echo >Log [inauri] Aborting $inauri.subScript to teach %inauri.target.
    }
    if ($lib.class = 1) then {
        gosub assess teach
        if ("$class" = "Enchanting") then goto inauri.loop
        if contains("$class", "%inauri.topic") then goto inauri.loop

        gosub stop teach
    }
    if ($lib.student = 1) then {
        gosub stop listen
    }
    gosub teach %inauri.topic to %inauri.target
    goto inauri.loop


inauri.unity:
    put #send unity Selesthiel
    var inauri.targetAwake 0

    inauri.unityLoop:
        gosub prep awaken
        pause 3
        gosub cast Selesthiel
        action var inauri.targetAwake 1 when ^(Selesthiel slowly opens his eyes\.|Selesthiel's mind is already awake as can be the spell pattern fails\.)$
        if (%inauri.targetAwake = 0) then goto inauri.unityLoop
        goto inauri.loop


###############################
###    MOVE TO UTIL
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


moveToEngineer:
    if ("$roomname" = "Private Home Interior") then {
        put .house
        waitforre ^HOUSE DONE
        goto moveToEngineer
    }
    # Shard - East Gate
    if ($zoneid = 66) then {
        gosub automove east gate
        goto moveToEngineer
    }
    # Shard - City
    if ($zoneid = 67) then {
        if ($roomid =  718) then return
        #if ("$roomname" = "Shard Engineering Society, Tool Store") then return
        gosub automove engineer
        goto moveToEngineer
    }
    # Fang Cove
    if ($zoneid = 150) then {
        if ($roomid = 207) then return
        gosub automove portal
        gosub automove engineering book
        goto moveToEngineer
    }
    goto moveToEngineer


moveToFangCove:
    # Crossing - City
    if ($zoneid = 1) then {
        gosub automove portal
        gosub move go meeting portal
        goto moveToFangCove
    }
    # Shard - East Gate
    if ($zoneid = 66) then {
        gosub automove portal
        gosub move go meeting portal
        goto moveToFangCove
    }
    # Shard - City
    if ($zoneid = 67) then {
        gosub automove portal
        goto moveToFangCove
    }
    # Fang Cove
    if ($zoneid = 150) then return
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
    if ($zoneid = 150) then {
        if ($roomid = 50) then return
        gosub automove 50
    }
    goto moveToForage


moveToHouse:
    # Crossing - City
    if ($zoneid = 1) then {
        if ($roomid = 258) then return
        gosub automove 258
        goto moveToHouse
    }
    # Shard - East Gate
    if ($zoneid = 66 ) then {
        gosub automove portal
        gosub move go meeting portal
        goto moveToHouse
    }
    # Shard - City
    if ($zoneid = 67) then {
        gosub automove portal
        goto moveToHouse
    }
    # Fang Cove
    if ($zoneid = 150) then {
        if ($roomid = 50) then return
        gosub automove 50
    }
    goto moveToHouse


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
    goto moveToPawn


moveToRepair:
    if ("$roomname" = "Private Home Interior") then {
        put .house
        waitforre ^HOUSE DONE
    }
    return