include libmaster.cmd
###################
# Idle Action Triggers
###################
action put #var heal 1 ; put #var target $1 when ^(Khurnaarti|Selesthiel) whispers, "heal
action put #var lastTrainerGametime $gametime when ^The leather looks frayed, as if worked too often recently
action put #var openDoor 1 when ^(Qizhmur|Selesthiel|Khurnaarti)'s face appears in the
action put #var poison 1 when ^(Khurnaarti|Selesthiel) whispers, "poison
action put #var poison 1 when ^(She|He) has a (dangerously|mildly|critically) poisoned
action put #var poisonHeal 1 when ^You feel a slight twinge in your|^You feel a (sharp|terrible) pain in your 
action put #var poisonHeal 0 when ^A sudden wave of heat washes over you as your spell flushes all poison from your body\.
action put #var teach 1; put #var topic $2 ; put #var target $1 when ^(Khurnaarti|Selesthiel|Qizhmur) whispers, "teach (.*)"$
action put

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
if (!($lastLookGametime >0)) then put #var lastLookGametime 0
if (!($lastPercGametime >0)) then put #var lastPercGametime 0
if (!($lastTrainerGametime >0)) then put #var lastTrainerGametime 0


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
    if ($poisonHeal = 1) then gosub healPoisonSelf
    if ($SpellTimer.Regenerate.duration < 1) then gosub refreshRegen
    gosub waitAlmanac
    pause 1
    gosub waitAppraisal
    pause 1
    gosub waitFaSkin
    pause 1
    gosub waitPerc
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
        gosub get my chronicle
        }
        gosub study my chronicle
	    pause 2
        gosub stow my chronicle
        put #var lastAlmanacGametime $gametime
    }
    return


waitAppraisal:
    evalmath nextAppAt $lastAppGametime + 60
    if (%nextAppAt > $gametime) then {
        return
    }
    if ($Appraisal.LearningRate < 15) then {
        gosub appraise my pouch careful
	    put #var lastAppGametime $gametime
    }
    return


waitFaSkin:
    evalmath nextTrainer $lastTrainerGametime + 3600
    if (%nextTrainer > $gametime) then {
        return
    }
    if ($First_Aid.LearningRate < 15 && $Skinning.LearningRate < 15) then {
        gosub get my $trainer
    	gosub skin my $trainer
	    pause 2
    	gosub repair my $trainer
    	pause 2
    	gosub stow my $trainer
    }
    return


waitLook:
    evalmath nextLookAt $lastLookGametime + 240
    if (%nextLookAt < $gametime) then {
        gosub look
        put #var lastLookGametime $gametime
    }
    return


waitPerc:
    if ($Attunement.LearningRate > 15) then {
        return
    }
    evalmath nextPerc $lastPercGametime + 60
    if ($gametime > %nextPerc) then {
        gosub perc mana
        put #var lastPercGametime $gametime
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