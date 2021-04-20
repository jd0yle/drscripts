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
action var inauri.poisonSelf 1 when ^You feel a slight twinge in your|^You feel a (sharp|terrible) pain in your|The presence of a faint greenish tinge about yourself\.
action var inauri.poisonSelf 0 when ^A sudden wave of heat washes over you as your spell flushes all poison from your body\.
action var inauri.teach 1; var inauri.topic $2 ; var inauri.target $1 when ^(Khurnaarti|Selesthiel|Qizhmur) whispers, "teach (.*)"$
action var justice 0 when ^You're fairly certain this area is lawless and unsafe\.$
action var justice 1 when ^After assessing the area, you think local law enforcement keeps an eye on what's going on here\.$
action put #var lastTrainerGametime $gametime when ^The leather looks frayed, as if worked too often recently


###############################
###    CHAR VARIABLES
###############################
if (!($activeResearch >0)) then put #var activeResearch 0
if (!($expSleep >0)) then put #var expSleep 0
if (!($inauri.heal >0)) then put #var inauri.heal 0
if (!($inauri.healTarget >0)) then put #var inauri.healTarget 0
if (!($lastAlmanacGametime >0)) then put #var lastAlmanacGametime 0
if (!($lastAppGametime >0)) then put #var lastAppGametime 0
if (!($lastEngineerGametime >0)) then put #var lastEngineerGametime 0
if (!($lastLookGametime >0)) then put #var lastLookGametime 0
if (!($lastMagicGametime >0)) then put #var lastMagicGametime 0
if (!($lastPercHealthGametime >0)) then put #var lastPercHealthGametime 0
if (!($lastTrainerGametime >0)) then put #var lastTrainerGametime 0

var inauri.disease 0
var inauri.diseaseSelf 0
var inauri.openDoor 0
var inauri.poison 0
var inauri.poisonSelf 0
var inauri.teach 0
var inauri.topic 0
var inauri.target 0


###############################
###    MAIN
###############################
inauri.loop:
    if (!contains("$scriptlist", "reconnect.cmd")) then {
        put #echo >Log [inauri] Starting reconnect
        put .reconnect
    }
    if (%inauri.teach = 1) then gosub waitTeach
    if ($standing = 0) then gosub stand
    if ($inauri.heal = 1) then {
        gosub redirect all to left leg
        gosub touch $inauri.healTarget
        gosub take $inauri.healTarget ever quick
        put #var inauri.heal 0
    }
    if (%inauri.openDoor = 1) then {
        if !(contains("$roomplayers", "Selesthiel")) then {
            gosub unlock door
            gosub open door
        }
    }
    if (%inauri.openDoor = 2) then {
        gosub unlock door
        gosub open door
    }
    var inauri.openDoor 0
    if (%inauri.poison = 1) then {
        gosub touch $inauri.healTarget
        gosub take $inauri.healTarget poison quick
        var inauri.poison 0
    }
    if (%inauri.poisonHeal = 1) then {
        gosub runScript cast fp
    }
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
    if ($mana > 30) then {
        if ($SpellTimer.Regenerate.duration < 1) then gosub refreshRegen
    }
    gosub waitAlmanac
    pause 1
    if ($Appraisal.LearningRate < 33) then gosub appraise.onTimer
    pause 1
    gosub waitFaSkin
    pause 1
    if ($Attunement.LearningRate < 33 && $lib.magicInert <> 1) then gosub perc.onTimer
    pause 1
    if ($Empathy.LearningRate < 33  && $lib.magicInert <> 1) then gosub percHealth.onTimer
    pause 1
    gosub waitArcana
    pause 1
    gosub waitEngineer
    pause 1
    if ($mana > 30) then {
        gosub waitMagic
        pause 1
        gosub waitResearch
        pause 1
    }
    gosub waitLook
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


inauri.engineer:
    evalmath nextTrainer $lastEngineerGametime + 3600
    if (%nextTrainer > $gametime) then {
        return
    } else {
        if ($Engineering.LearningRate = 0) then {
            if ($eng.needLumber = 1) then {
                goto moveToEngineer
            }
            put #var lastEngineerGametime $gametime
            put .eng 5 $char.craft.item
            waitforre ^ENG DONE
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


inauri.look:
    evalmath nextLookAt $lastLookGametime + 240
    if (%nextLookAt < $gametime) then {
        gosub look
        put #var lastLookGametime $gametime
    }
    return


inauri.magic:
    if ($lib.magicInert = 1) then {
        return
    }
    evalmath nextMagic $lastMagicGametime + 3600
    if (%nextMagic < $gametime) then {
        if ($Augmentation.LearningRate < 5) then {
            put .look
            put .magic noLoop
            waitforre ^MAGIC DONE
            put #script abort all except inauri
        }
    }
    return


inauri.research:
    if ($lib.magicInert = 1) then {
        return
    }
    if ($Sorcery.LearningRate < 5) then {
        put justice
        if (%justice <> 0) then {
            return
        }
        put .look
        put .research sorcery
        waitforre ^RESEARCH DONE
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


###############################
###    MOVE TO UTIL
###############################
moveToEngineer:
    if ("$roomname" = "Private Home Interior") then {
        put .house
        waitforre ^HOUSE DONE
        gosub moveToEngineer
    }
    # Shard - East Gate
    if ($zoneid = 66) then {
        gosub automove east gate
        gosub automove engineer
        put .workorder
        waitforre ^WORKORDER DONE
        put #var eng.needLumber 0
        put .deposit
        waitforre ^DEPOSIT DONE
        gosub moveToHouse
        put .house
        waitforre ^HOUSE DONE
    }
    goto inauri.loop


moveToHouse:
    # Fang Cove
    if ($zoneid = 150) then {
        gosub automove portal
        gosub move go portal
        gosub moveToHouse
    }
    # Shard - East Gate
    if ($zoneid = 66) then {
        gosub automove portal
        gosub automove 252
    }
    return