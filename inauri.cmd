include libmaster.cmd
###################
# Idle Action Triggers
###################
action var inauri.disease 1 when ^(?:His|Her) wounds are (?:badly )?infected
action var inauri.diseaseSelf 1 when The presence of disturbing black streaks about yourself\.$
action put #var inauri.heal 1 ; put #var inauri.healTarget $1 when ^(Khurnaarti|Selesthiel|Vohraus|Inahk|Estius) whispers, "heal
action var inauri.openDoor 1 when ^(Qizhmur|Selesthiel|Khurnaarti)'s face appears in the
action var inauri.openDoor 2 when ^(Vohraus|Inahk|Estius)'s face appears in the
action var inauri.poison 1 when ^(Khurnaarti|Selesthiel) whispers, "poison
action var inauri.poison 1 when ^(She|He) has a (dangerously|mildly|critically) poisoned
action var inauri.poisonSelf 1 when The presence of a faint greenish tinge about yourself\.$|^You feel a slight twinge in your|^You feel a (sharp|terrible) pain in your|The presence of a faint greenish tinge about yourself\.
action var inauri.poisonSelf 0 when ^A sudden wave of heat washes over you as your spell flushes all poison from your body\.
action var inauri.privacyFamiliarOn 0 when ^Familiars may now enter your home\.$|^You have unbarred your home for familiars but they will still be unable to locate you while your home's locate block is on\.$
action var inauri.privacyFamiliarOn 1 when ^Familiars will be barred from your home\.$
action var inauri.privacyLocateOn 0 when ^Others may now find you\.$
action var inauri.privacyLocateOn 1 when ^Others will be unable to locate you\.$
action var inauri.teach 1; var inauri.topic $2 ; var inauri.target $1 when ^(Khurnaarti|Selesthiel|Qizhmur) whispers, "teach (.*)"$
action var inauri.justice 0 when ^You're fairly certain this area is lawless and unsafe\.$
action var inauri.justice 1 when ^After assessing the area, you think local law enforcement keeps an eye on what's going on here\.$
action put #var lastTrainerGametime $gametime when ^The leather looks frayed, as if worked too often recently
action goto inauri.vitalityHeal when eval $health < 30

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
if (!($lastEngineerGametime >0)) then put #var lastEngineerGametime 0
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


###############################
###    MAIN
###############################
inauri.loop:
    if (!contains("$scriptlist", "reconnect.cmd")) then {
        put #echo >Log [inauri] Starting reconnect
        put .reconnect
    }
    if (%inauri.teach = 1) then gosub inauri.teach
    if ($standing = 0) then gosub stand
    if ($inauri.heal = 1) then gosub inauri.healWound
    if (%inauri.openDoor = 1) then gosub inauri.door
    if (%inauri.poison = 1 || %inauri.poisonSelf = 1) then gosub inauri.healPoison
    if (%inauri.disease = 1 || %inauri.diseaseSelf = 1) then gosub inauri.healDisease
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
    gosub inauri.privacy
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


inauri.door:
   #if !(contains("$roomplayers", "Selesthiel")) then {
        gosub unlock door
        gosub open door
   #}
   if (%inauri.openDoor = 2) then {
        gosub unlock door
        gosub open door
   }
   var inauri.openDoor 0
   return


inauri.engineer:
    evalmath nextTrainer $lastEngineerGametime + 3600
    if (%nextTrainer > $gametime) then {
        return
    } else {
        if ($Engineering.LearningRate = 0) then {
            if ($eng.repairNeeded = 1) then {
                put #echo >Log Yellow [inauri] Need to repair crafting tools.
                gosub stop teach
                gosub moveToEngineer
                gosub automove engineering book
                put .repairtool
                waitforre ^REPAIRTOOL DONE$
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
                put .deposit
                waitforre ^DEPOSIT DONE$
                gosub moveToHouse
                put .house
                waitforre ^HOUSE DONE$
            }
            put #var inauri.subScript eng
            put #echo >Log Yellow [inauri] Beginning engineering.
            put #var lastEngineerGametime $gametime
            put .eng 5 $char.craft.item
            waitforre ^ENG DONE
            put #var inauri.subScript 0
            put #script abort all except inauri
        }
    }
    return


inauri.faSkin:
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


inauri.healDisease:
    if (%inauri.disease) then {
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
    gosub redirect all to left leg
    gosub touch $inauri.healTarget
    gosub take $inauri.healTarget ever quick
    put #var inauri.heal 0
    return


inauri.healPoison:
    if (%inauri.poison) then {
        gosub touch $inauri.healTarget
        gosub take $inauri.healTarget poison quick
        var inauri.poison 0
    }
    if (%inauri.poisonSelf = 1) then {
        put runScript cast fp
        var inauri.poisonSelf 0
    }
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
            put #echo >Log Purple [inauri] Magic complete.
            put #script abort all except inauri
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
        put #echo >Log Purple [inauri] Research complete.
        put #script abort all except inauri
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


inauri.vitalityHeal:
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
    #Shard - City
    if ($zoneid = 67) then {
        if ("$roomname" = "Shard Engineering Society, Tool Store") then return
        gosub automove engineer
        goto moveToEngineer
    }
    goto moveToEngineer


moveToHouse:
    # Crossing - City
    if ($zoneid = 1) then {
        if ($roomid = 258) then return
        gosub automove 258
        goto moveToHouse
    }
    # Shard - East Gate
    if ($zoneid = 66 ) then {
        if ($roomid = 252) then return
        gosub automove 252
        goto moveToHouse
    }
    # Shard - City
    if ($zoneid = 67) then {
        gosub automove portal
        goto moveToHouse
    }
    # Fang Cove
    if ($zoneid = 150) then {
        gosub automove portal
        gosub move go portal
        gosub moveToHouse
    }

    goto moveToHouse