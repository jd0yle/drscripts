include libmaster.cmd
###################
# Idle Action Triggers
###################
action var heal 1 ; put #var healTarget $1 when ^(Khurnaarti|Selesthiel|Vohraus|Inahk|Estius) whispers, "heal
action var justice 0 when ^You're fairly certain this area is lawless and unsafe\.
action var justice 1 when ^After assessing the area, you think local law enforcement keeps an eye on what's going on here\.
action put #var lastTrainerGametime $gametime when ^The leather looks frayed, as if worked too often recently
action put #var openDoor 1 when ^(Qizhmur|Selesthiel|Khurnaarti|Vohraus|Inahk|Estius)'s face appears in the
action put #var poison 1 when ^(Khurnaarti|Selesthiel) whispers, "poison
action put #var poison 1 when ^(She|He) has a (dangerously|mildly|critically) poisoned
action put #var poisonHeal 1 when ^You feel a slight twinge in your|^You feel a (sharp|terrible) pain in your|The presence of a faint greenish tinge about yourself\.
action put #var poisonHeal 0 when ^A sudden wave of heat washes over you as your spell flushes all poison from your body\.
action put #var teach 1; put #var topic $2 ; put #var target $1 when ^(Khurnaarti|Selesthiel|Qizhmur) whispers, "teach (.*)"$

###################
# Variable Inits
###################
if (!($activeResearch >0)) then put #var activeResearch 0
if (!($expSleep >0)) then put #var expSleep 0
if (!($heal >0)) then put #var heal 0
if (!($poison >0)) then put #var poison 0
if (!($poisonHeal >0)) then put #var poisonHeal 0
if (!($teach >0)) then put #var teach 0
if (!($lastAlmanacGametime >0)) then put #var lastAlmanacGametime 0
if (!($lastAppGametime >0)) then put #var lastAppGametime 0
if (!($lastEngineerGametime >0)) then put #var lastEngineerGametime 0
if (!($lastLookGametime >0)) then put #var lastLookGametime 0
if (!($lastMagicGametime >0)) then put #var lastMagicGametime 0
if (!($lastTrainerGametime >0)) then put #var lastTrainerGametime 0

var disease $char.healing.disease
var diseaseSelf $char.healing.diseaseSelf
var heal $char.healing.heal
var healTarget $char.healing.healTarget
var poison $char.healing.poison
var poisonSelf $char.healing.poisonSelf


###################
# Main
###################
loop:
    if ($teach = 1) then gosub waitTeach
    if ($standing = 0) then gosub stand
    if ($heal = 1) then {
        gosub redirect all to left leg
        gosub touch $target
        gosub take $target ever quick
        put #var heal 0
    }
    if ($openDoor = 1) then {
        gosub unlock door
        gosub open door
        put #var openDoor 0
    }
    if ($poison = 1) then {
        gosub touch $target
        gosub take $target poison quick
        put #var poison 0
    }
    if ($poisonHeal = 1) then {
        gosub runScript cast fp
    }
    if ($SpellTimer.Regenerate.duration < 1) then gosub runScript cast regen
    gosub waitAlmanac
    pause 1
    if ($Appraisal.LearningRate < 33) then gosub appraise.onTimer
    pause 1
    gosub waitFaSkin
    pause 1
    if ($Attunement.LearningRate < 33) then gosub perc.onTimer
    pause 1
    if ($Empathy.LearningRate < 33) then gosub percHealth.onTimer
    pause 1
    gosub waitArcana
    pause 1
    gosub waitEngineer
    pause 1
    gosub waitMagic
    pause 1
    gosub waitResearch
    pause 1
    gosub waitLook
    goto loop


###################
# Wait Methods
###################
waitAlmanac:
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


waitArcana:
    if ($Arcana.LearningRate > 15) then {
        return
    }
    if ($concentration > 99) then {
        gosub gaze my sano crystal
        waitforre ^The light and crystal sound of your sanowret crystal fades slightly
    }
    return


waitEngineer:
    evalmath nextTrainer $lastEngineerGametime + 3600
    if (%nextTrainer > $gametime) then {
        return
    } else {
        if ($Engineering.LearningRate = 0) then {
            put #var lastEngineerGametime $gametime
            put .eng 5 $char.craft.item
            exit
        }
    }
    return


waitFaSkin:
    if (contains($time, "(\d+)(.*)AM")) then {
        if ($1 < 12) then {
            put #var lastTrainerGametime 0
        }
    }
    if ($lastTrainerGametime <> 0) then {
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
            put .magic noLoop
            waitforre ^MAGIC DONE
            put #abort all except inaidle
        }
    }
    return


waitResearch:
    if ($Sorcery.LearningRate < 5) then {
        put justice
        if (%justice <> 0) then {
            return
        }
        put .research sorcery
        waitforre ^RESEARCH DONE
        put #script abort all except inaidle
    }
    return


waitTeach:
    if ($class <> 0) then {
        put stop teach
        put #var class 0
    }
    pause 2
    if ($student <> 0) then {
        put stop listen
        put #var student 0
    }
    gosub teach $topic to $target
    put #var teach 0
    return