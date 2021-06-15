include libmaster.cmd
###################
# Idle Action Triggers
###################
action var inauri.disease 1 when ^(?:His|Her) wounds are (?:badly )?infected
action var inauri.diseaseSelf 1 when The presence of disturbing black streaks about yourself\.$
action put #var inauri.heal 1 ; put #var inauri.healTarget $1 ; goto inauri.healWound when ^(Khurnaarti|Selesthiel|Izqhhrzu) whispers, "heal
action var inauri.openDoor 1 when ^(Qizhmur|Selesthiel|Khurnaarti|Izqhhrzu)'s face appears in the
action var inauri.poison 1 when ^(She|He) has a (dangerously|mildly|critically) poisoned
action var inauri.poisonSelf 1 when The presence of a faint greenish tinge about yourself\.$|^You feel a slight twinge in your|^You feel a (sharp|terrible) pain in your|The presence of a faint greenish tinge about yourself\.
action var inauri.poisonSelf 0 when ^A sudden wave of heat washes over you as your spell flushes all poison from your body\.
action var inauri.privacyFamiliarOn 0 when ^Familiars may now enter your home\.$|^You have unbarred your home for familiars but they will still be unable to locate you while your home's locate block is on\.$
action var inauri.privacyFamiliarOn 1 when ^Familiars will be barred from your home\.$
action var inauri.privacyLocateOn 0 when ^Others may now find you\.$
action var inauri.privacyLocateOn 1 when ^Others will be unable to locate you\.$
action var inauri.teach 1; var inauri.topic $2 ; var inauri.target $1 when ^(Khurnaarti|Selesthiel|Qizhmur|Izqhhrzu) whispers, "teach (.*)"$
action var inauri.justice 0 when ^You're fairly certain this area is lawless and unsafe\.$
action var inauri.justice 1 when ^After assessing the area, you think local law enforcement keeps an eye on what's going on here\.$
action var inauri.vitality 1 when ^(\S+) is suffering from a .+ loss of vitality.*$
action put #var lastTrainerGametime $gametime when ^The leather looks frayed, as if worked too often recently
action goto inauri.vitalityHealSelf when eval $health < 30
action goto inauri.unity when ^Selesthiel crumples to the ground and is still\.$


###############################
###    CHAR VARIABLES
###############################
if (!($activeResearch >0)) then put #var activeResearch 0
if (!($expSleep >0)) then put #var expSleep 0
if (!($inauri.heal >0)) then put #var inauri.heal 0
if (!($inauri.healTarget >0)) then put #var inauri.healTarget 0
if (!($inauri.subScript >0)) then put #var inauri.subScript 0
if (!($lastAlmanacGametime >0)) then put #var lastAlmanacGametime 0
if (!($lastAppGametime >0)) then put #var lastAppGametime 0
if (!($lastLookGametime >0)) then put #var lastLookGametime 0
if (!($lastMagicGametime >0)) then put #var lastMagicGametime 0
if (!($lastPercHealthGametime >0)) then put #var lastPercHealthGametime 0
if (!($lastPrivacyGametime >0)) then put #var lastPrivacyGametime 0
if (!($lastTrainerGametime >0)) then put #var lastTrainerGametime 0

var inauri.disease 0
var inauri.diseaseSelf 0
var inauri.justice 0
var inauri.openDoor 0
var inauri.poison 0
var inauri.poisonSelf 0
var inauri.target 0
var inauri.teach 0
var inauri.topic 0
var inauri.vitality 0


###############################
###    MAIN
###############################
inauri.loop:
    gosub inauri.locationCheck
    if ("$lefthand" <> "Empty") then {
        gosub stow left
    }
    if (contains("$scriptlist", "look")) then {
        put #script abort look
    }
    if (!contains("$scriptlist", "reconnect.cmd")) then {
        put #echo >Log [inauri] Starting reconnect
        put .reconnect
    }
    if (%inauri.teach = 1) then gosub inauri.teach
    if ($standing = 0) then gosub stand
    if (%inauri.openDoor = 1) then gosub inauri.door
    if (%inauri.poison = 1 || %inauri.poisonSelf = 1) then gosub inauri.healPoison
    if (%inauri.disease = 1 || %inauri.diseaseSelf = 1) then gosub inauri.healDisease
    if (%inauri.vitality = 1) then gosub inauri.healVitality
    if ($mana > 30) then {
        if ($SpellTimer.Regenerate.duration < 1) then gosub refreshRegen
    }
    gosub inauri.almanac
    pause 1
    if ($Appraisal.LearningRate < 33) then gosub appraise.onTimer
    pause 1
    gosub inauri.faSkin
    pause 1
    if ($Attunement.LearningRate < 33 && $lib.magicInert <> 1) then gosub perc.onTimer
    pause 1
    if ($Empathy.LearningRate < 33  && $lib.magicInert <> 1) then gosub percHealth.onTimer
    pause 1
    gosub inauri.arcana
    pause 1
    gosub inauri.engineer
    pause 1
    if ($mana > 30) then {
        gosub inauri.magic
        pause 1
        gosub inauri.research
        pause 1
    }
    gosub inauri.look
    pause 1
    gosub inauri.forage
    pause 1
    gosub inauri.burgle
    goto inauri.loop


###############################
###    WAIT METHODS
###############################
inauri.almanac:
    evalmath nextStudyAt $lastAlmanacGametime + 600
    if (%nextStudyAt < $gametime) then {
    if ("$lefthandnoun" != "chronicle" && "$righthandnoun" != "chronicle") then {
        gosub get my $char.trainer.almanacItem
    }
        gosub study my $char.trainer.almanacItem
	    pause 2
        gosub stow my $char.trainer.almanacItem
        put #var lastAlmanacGametime $gametime
    }
    return


inauri.arcana:
    if ($lib.magicInert = 1) then {
        return
    }
    if ($Arcana.LearningRate > 15) then {
        return
    }
    if ($concentration > 99) then {
        gosub gaze my sano crystal
    }
    return


inauri.burgle:
    gosub burgle.setNextBurgleAt
    if ($lib.timers.nextBurgleAt < $gametime) then {
    put #echo >Log Red [inauri] Going to burgle
    put stop teach
    gosub moveToBurgle
    put .burgle
    waitforre ^BURGLE DONE
    gosub moveToHouse
    put .house
    waitforre ^HOUSE DONE
    put #echo >Log Red [inauri] Burgle complete. ATH:($Athletics.LearningRate/34) Locks:($Locksmithing.LearningRate/34) Stealth:($Stealth.LearningRate/34)
    return
    }


inauri.door:
   put #script pause all except inauri
   gosub unlock door
   gosub open door
   var inauri.openDoor 0
   put #script resume all
   return


inauri.engineer:
    if ($Engineering.LearningRate = 0) then {
        if ($eng.repairNeeded = 1) then {
            put #echo >Log Yellow [inauri] Need to repair crafting tools.
            gosub stop teach
            gosub moveToEngineer
            gosub moveToEngineerRepair
            put .repairtool
            waitforre ^REPAIRTOOL DONE$
            put #var eng.repairNeeded 0
            put .deposit
            waitforre ^DEPOSIT DONE$
            gosub moveToHouse
            put .house
            waitforre ^HOUSE DONE$
        }

        if ($eng.needLumber = 1) then {
            put #echo >Log Yellow [inauri] Need lumber for engineering.
            gosub stop teach
            gosub moveToEngineer
            put .workorder
            waitforre ^WORKORDER DONE$
            put #var eng.needLumber 0
            put .deposit
            waitforre ^DEPOSIT DONE$
            gosub moveToHouse
            put .house
            waitforre ^HOUSE DONE$
        }
        put #var inauri.subScript engineer
        put #echo >Log Yellow [inauri] Beginning engineering.
        put .engineer 5 $char.craft.item
        waitforre ^ENGINEER DONE
        put #echo >Log Yellow [inauri] Engineering complete.  ENG:($Engineering.LearningRate/34)
        put #var inauri.subScript 0
    }
    return


inauri.faSkin:
    evalmath nextTrainerAt $lastTrainerGametime + 3600
    if (%nextTrainerAt > $gametime) then {
        return
    }
    if ($First_Aid.LearningRate < 15 && $Skinning.LearningRate < 15) then {
        put #echo >Log Cyan [inauri] Beginning trainer.
        gosub get my $char.trainer.firstaid
    	gosub skin my $char.trainer.firstaid
    	gosub repair my $char.trainer.firstaid
    	gosub skin my $char.trainer.firstaid
        gosub repair my $char.trainer.firstaid
    	gosub stow my $char.trainer.firstaid
    	put #echo >Log Cyan [inauri] Trainer complete. FA:($First_Aid.LearningRate/34) SK:($Skinning.LearningRate/34)
    }
    return


inauri.forage:
    if ($Outdoorsmanship.LearningRate < 10) then {
        put #echo >Log Orange [inauri] Going to forage.
        put stop teach
        gosub moveToForage
        put .forage
        waitforre ^FORAGE DONE
        put #echo >Log Orange [inauri] Forage complete. Outdoor:($Outdoorsmanship.LearningRate/34) Perc:($Perception.LearningRate/34)
        gosub moveToHouse
    }
    return


inauri.healDisease:
    if (%inauri.disease = 1) then {
        gosub touch $inauri.healTarget
        gosub take $inauri.healTarget disease quick
        var inauri.disease 0
        var inauri.diseaseSelf 1
    }
    if (%inauri.diseaseSelf = 1) then {
        gosub runScript cast cd
        var inauri.diseaseSelf 0
    }
    return


inauri.healWound:
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
        gosub take $inauri.healTarget vitality
        var inauri.vitality 0
    }
    goto inauri.loop


inauri.healPoison:
    if (%inauri.poison = 1) then {
        gosub touch $inauri.healTarget
        gosub take $inauri.healTarget poison quick
        var inauri.poison 0
    }
    if (%inauri.poisonSelf = 1) then {
        gosub runScript cast fp
        var inauri.poisonSelf 0
    }
    return


inauri.healVitality:
    if (%inauri.vitality = 1) then {
        gosub touch $inauri.healTarget
        gosub take $inauri.healTarget vitality
        var inauri.vitality 0
    }
    return


inauri.locationCheck:
    if ("$roomname" = "Private Home Interior") then return
    gosub movetoHouse
    put .house
    waitforre ^HOUSE DONE
    return


inauri.look:
    evalmath nextLookAt $lastLookGametime + 240
    if (%nextLookAt < $gametime) then {
        gosub look
        put #var lastLookGametime $gametime
    }
    return


inauri.magic:
    if ($lib.magicInert = 1) then {
        put #echo >Log Purple [inauri] Skipping magic due to being magically inert.
        return
    }
    evalmath nextMagic $lastMagicGametime + 3600
    if (%nextMagic < $gametime) then {
        if ($Augmentation.LearningRate < 5) then {
            put #var inauri.subScript magic
            put .look
            put #echo >Log Purple [inauri] Beginning magic.
            put .magic noLoop
            waitforre ^MAGIC DONE
            put #var inauri.subScript 0
            put #echo >Log Purple [inauri] Magic complete. Ward:($Warding.LearningRate/34)
            gosub clear
            put .train
            put #script abort all except train
        }
    }
    return


inauri.privacy:
    if ("$roomname" <> "Private Home Interior") then return
    evalmath nextPrivacyAt $lastPrivacyGametime + 3600
    if (%nextPrivacyAt > $gametime) then {
        if (%inauri.privacyFamiliarOn = 0) then {
            gosub home privacy familiar
        }
        if (%inauri.privacyLocateOn = 0) then {
            gosub home privacy locate
        }
        put #var lastPrivacyGametime $gametime
    }
    return


inauri.research:
    if ($lib.magicInert = 1) then {
        put #echo >Log Purple [inauri] Skipping research due to being magically inert.
        return
    }
    if ($Sorcery.LearningRate < 5) then {
        put justice
        if (%inauri.justice = 1) then {
            put #echo >Log Purple [inauri] Skipping research due to justice.
            return
        }
        put .look
        put #echo >Log Purple [inauri] Beginning research.
        put .research sorcery
        waitforre ^RESEARCH DONE
        put #echo >Log Purple [inauri] Research complete. Sorc:($Sorcery.LearningRate/34)
    }
    return


inauri.teach:
    if ($lib.class = 1) then {
        if ("$class" = "Enchanting") then {
            var inauri.teach 0
            return
        }
        gosub stop teach
    }
    if ($lib.student = 1) then {
        gosub stop listen
    }
    gosub teach %inauri.topic to %inauri.target
    var inauri.teach 0
    return


inauri.unity:
    put #script pause all except inauri
    put unity Selesthiel
    var inauri.targetAwake 0

    inauri.unityLoop:
        gosub prep awaken
        pause 3
        gosub cast Selesthiel
        action var inauri.targetAwake 1 when ^(Selesthiel slowly opens his eyes\.|Selesthiel's mind is already awake as can be the spell pattern fails\.)$
        if (%inauri.targetAwake = 0) then goto inauri.unityLoop
        put #script resume all
        goto inauri.loop


inauri.vitalityHealSelf:
    put #script pause all except inauri


    inauri.vitalityHealLoop:
        pause .2
        gosub prep vh
        pause 2
        gosub cast
        if ($health < 60) then {
            goto inauri.vitalityHealLoop
        } else {
            put #script resume all
        }
        return


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


moveToEngineerRepair:
    # Shard - City
    if ($zoneid = 67) then {
        if ($roomid = 717) then return
        gosub automove engineering book
        goto moveToEngineerRepair
    }
    # Fang Cove
    if ($zoneid = 150) then {
        if ($roomid = 205) then return
        gosub automove engineering clerk
        goto moveToEngineerRepair
    }
    goto moveToEngineerRepair


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