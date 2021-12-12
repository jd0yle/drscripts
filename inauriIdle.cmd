include libmaster.cmd
###############################
###    IDLE ACTION TRIGGERS
###############################
action put #var inauri.heal 1 ; put #var inauri.healTarget $1 ; goto inauriIdle-healWound when ^($friends) whispers, "heal
#action put #var inauri.heal 0 when ^(\S+) is not wounded in that location\.$
action var inauriIdle.openDoor 1 when ^($friends)'s face appears in the
action goto moveToHouse when ^($friends) whispers, "inside|^($friends) whispers, "outside
action var inauriIdle.wounds 0 when \.\.\. no injuries to speak of\.
action var inauriIdle.openDoor 0 when ^(\S+) opens the door\.
action var inauriIdle.disease 1 when (Her|His) wounds are infected\.|(Her|His) wounds are badly infected\.|(He|She) has a dormant infection that could make wounds worse\.
action var inauriIdle.poison 1 when ^(He|She) has a (dangerously|mildly|critically) poisoned
action var inauriIdle.poisonSelf 1 when ^You fall to your knees as the world spins around and around\!|You feel a slight twinge in your|^You feel a (sharp|terrible) pain in your|The presence of a faint greenish tinge about yourself\.
action var inauriIdle.poisonSelf 0 when ^A sudden wave of heat washes over you as your spell flushes all poison from your body\.
action var inauriIdle.teachTrigger 1; var inauriIdle.topic $2 ; var inauriIdle.target $1 when ^($friends) whispers, \"teach (\S+)\"$
action var inauriIdle.vitality 1 when ^(\S+) is suffering from a .+ loss of vitality.*$
action var inauriIdle.vitality 0 when ^(\S+) has normal vitality\.$
action var inauriIdle.wounds 0 when /./././ no injuries to speak of/.$
action var inauriIdle.wounds 1 when Wounds to the.*$
action goto inauriIdle-vitalityHeal when eval $health < 80


###############################
###    VARIABLES
###############################
if (!($lastLookGametime >0)) then put #var lastLookGametime 0
if (!($lastTrainerGametime >0)) then put #var lastTrainerGametime 0

var inauriIdle.disease 0
var inauriIdle.diseaseSelf 0
var inauriIdle.openDoor 0
var inauriIdle.poison 0
var inauriIdle.poisonSelf 0
var inauriIdle.target 0
var inauriIdle.teach 0
var inauriIdle.teachTrigger 0
var inauriIdle.topic 0


if !(matchre("$scriptlist", "reconnect")) then {
    put .reconnect
}
if !(matchre("$scriptlist", "afk")) then {
put .afk
}
###############################
###    MAIN
###############################
inauriIdle-loop:
    gosub inauriIdle-locationCheck
    if (%inauriIdle.teachTrigger = 1) then {
        gosub inauriIdle-teach
    }
    if ($standing = 0) then gosub stand
    if ($health < 80) then gosub inauriIdle-vitalityHeal
    if (%inauriIdle.poison = 1 || %inauriIdle.poisonSelf = 1) then gosub inauriIdle-healPoison
    if (%inauriIdle.disease = 1 || %inauriIdle.diseaseSelf = 1) then gosub inauriIdle-healDisease
    if ($mana > 30 && $SpellTimer.Regenerate.duration < 1) then gosub refreshRegen
    if ($Empathy.LearningRate < 33  && $lib.magicInert <> 1) then gosub percHealth.onTimer
    if ($Attunement.LearningRate < 33 && $lib.magicInert <> 1) then gosub perc.onTimer
    if (%inauriIdle.openDoor = 1) then gosub inauriIdle-door
    gosub almanac.onTimer
    pause 2
    gosub inauriIdle-look
    goto inauriIdle-loop


###############################
###    METHODS
###############################
inauriIdle-caracal:
    evalmath nextTrainerAt $lastTrainerGametime + 3600
    if (%nextTrainerAt > $gametime) then {
        return
    }
    gosub inauriIdle.clearHands
    if ($First_Aid.LearningRate < 15 && $Skinning.LearningRate < 15) then {
        put #echo >Log #009933 [inauriIdle] Beginning trainer.
        gosub runScript caracal
    	put #echo >Log #009933 [inauriIdle] Trainer complete. FA:($First_Aid.LearningRate/34) SK:($Skinning.LearningRate/34)
    	put #var lastTrainerGametime $gametime
    }
    return


inauriIdle-clearHands:
    if ("$righthand" <> "Empty") then {
        gosub stow
    }
    if ("$lefthand" <> "Empty") then {
        gosub stow left
    }
    return


inauriIdle-door:
    if (%inauriIdle.openDoor = 0) then goto inauriIdle-loop
    gosub unlock door
    gosub open door
    var inauriIdle.openDoor 0
    goto inauriIdle-loop


inauriIdle-forage:
    if ($Outdoorsmanship.LearningRate < 10) then {
        put #echo >Log #009933 [inauriIdle] Going to forage.
        gosub moveToForage
        gosub automove 49
        gosub runScript forage
        put #echo >Log #009933 [inauriIdle] Forage complete. Outdoor:($Outdoorsmanship.LearningRate/34) Perc:($Perception.LearningRate/34)
        gosub runScript house
        gosub inauriIdle.restart
    }
    return



inauriIdle-healDisease:
    if (%inauriIdle.disease) then {
        gosub touch $inauri.healTarget
        gosub take $inauri.healTarget disease quick
        var inauriIdle.disease 0
        var inauriIdle.diseaseSelf 1
    }
    if (%inauriIdle.diseaseSelf = 1) then {
        gosub runScript cast cd
        var inauriIdle.diseaseSelf 0
    }
    return


inauriIdle-healWound:
    if ($inauri.healTarget = 0) then {
        put #var inauri.heal 0
        goto inauriIdle-loop
    }
    gosub redirect all to left leg
    gosub touch $inauri.healTarget
    var inauriIdle.injuryCheck (%inauriIdle.wounds + %inauriIdle.vitality + %inauriIdle.disease + %inauriIdle.poison)
    if (%inauriIdle.injuryCheck > 0) then {
        if (%inauriIdle.vitality = 1) then {
            gosub take $inauri.healTarget vitality quick
        }
        if (%inauriIdle.poison) then {
            gosub touch $inauri.healTarget
            gosub take $inauri.healTarget poison quick
            var inauriIdle.poison 0
        }
        if (%inauriIdle.disease) then {
            gosub touch $inauri.healTarget
            gosub take $inauri.healTarget disease quick
            var inauriIdle.disease 0
            var inauriIdle.diseaseSelf 1
        }
        if (%inauriIdle.wounds = 1) then {
            gosub take $inauri.healTarget ever quick
        }
    } else {
        gosub whisper $inauri.healTarget You have no wounds.
    }
    put #var inauri.heal 0
    goto inauriIdle-loop


inauriIdle-healPoison:
    if (%inauriIdle.poison) then {
        gosub touch $inauri.healTarget
        gosub take $inauri.healTarget poison quick
        var inauriIdle.poison 0
    }
    if (%inauriIdle.poisonSelf = 1) then {
        gosub runScript cast fp
        var inauriIdle.poisonSelf 0
    }
    return


inauriIdle-locationCheck:
    if ("$roomname" = "Private Home Interior") then {
        return
    } else {
        gosub runScript house
    }
    return


inauriIdle-look:
    evalmath nextLookAt $lastLookGametime + 240
    if (%nextLookAt < $gametime) then {
        gosub tdp
        put #var lastLookGametime $gametime
    }
return


inauriIdle.restart:
    put #echo >log Gray [inauriIdle] Restarting script..
    goto inauriIdle-loop


inauriIdle-teach:
    if ("$lib.topic" <> "0") then {
        gosub assess teach
        if ("%inauriIdle.target" = "Selesthiel") then {
            if ("$lib.topic" = "Enchanting") then {
                put kiss Selesthiel forehead
                var inauriIdle.teachTrigger 0
                return
            } else {
                if ($lib.student = 1) then {
                    gosub stop listen
                }
                gosub stop teach
                gosub teach %inauriIdle.topic to %inauriIdle.target
                put #echo >Log2 [inauriidle] Swapping to %inauriIdle.topic class.
                var inauriIdle.teachTrigger 0
                return
            }
        } else {
            if contains("$lib.topic", "%inauriIdle.topic") then {
                put whisper %inauriIdle.target I am already teaching you $lib.topic.
                var inauriIdle.teachTrigger 0
                return
            }
            if (contains("$roomplayers", "Selesthiel") && "$lib.topic" = "Enchanting") then {
                var inauriIdle.teachTrigger 0
                return
            } else {
                gosub stop teach
                gosub teach %inauriIdle.topic to %inauriIdle.target
                put #echo >Log2 [inauriidle] Swapping to %inauriIdle.topic class.
                var inauriIdle.teachTrigger 0
                return
            }
        }
    } else {
        if ($lib.student = 1) then {
            gosub stop listen
        }
        gosub stop teach
        gosub teach %inauriIdle.topic to %inauriIdle.target
        var inauriIdle.teachTrigger 0
    }
    return


inauriIdle-vitalityHeal:
    gosub link all cancel
    if ($lib.magicInert = 1 && $bleeding = 1) then {
        put #echo >Log [inauriIdle] Bleeding, low vitality, and magically inert.
        put exit
        exit
    }

    inauriIdle.vitalityHealLoop:
        pause .2
        gosub prep vh
        pause 2
        gosub cast
        if ($health < 98) then {
            goto inauriIdle-vitalityHealLoop
        }
        goto inauriIdle-loop


###############################
###    MOVE TO
###############################
moveToForage:
    if ("$roomname" = "Private Home Interior") then {
        gosub runScript house
        goto moveToForage
    }
    # Crossing - City
    if ($zoneid = 1) then {
        if ($roomid = 258) then return
        gosub automove 259
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
        if ($roomid = 49) then return
        gosub automove 49
    goto moveToForage


moveToHouse:
    gosub runScript house
    return