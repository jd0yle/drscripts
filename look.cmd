include libmaster.cmd
###############################
###    IDLE ACTION TRIGGERS
###############################
if ("$charactername" = "Inauri") then {
    action put #var inauri.heal 1 ; put #var inauri.healTarget $1 ; goto look.healWound when ^($friends) whispers, "heal
    #action put #var inauri.heal 0 when ^(\S+) is not wounded in that location\.$
    action var look.openDoor 1 when ^($friends)'s face appears in the
    action goto look.houseMove when ^($friends) whispers, "inside|^($friends) whispers, "outside
    action var look.wounds 0 when \.\.\. no injuries to speak of\.
    action var look.openDoor 0 when ^(\S+) opens the door\.
    action var look.disease 1 when ^(Her|His) wounds are infected\.$
    action var look.poison 1 when ^(He|She) has a (dangerously|mildly|critically) poisoned
    action var look.poisonSelf 1 when ^You feel a slight twinge in your|^You feel a (sharp|terrible) pain in your|The presence of a faint greenish tinge about yourself\.
    action var look.poisonSelf 0 when ^A sudden wave of heat washes over you as your spell flushes all poison from your body\.
    action var look.teach 1; var look.topic $2 ; var look.target $1 when ^($friends) whispers, \"teach (\S+)\"$
    action var look.vitality 1 when ^(\S+) is suffering from a .+ loss of vitality.*$
    action goto look.vitalityHeal when eval $health < 30
}

###############################
###    VARIABLES
###############################
if (!($inauri.subScript >0)) then put #tvar inauri.subScript 0
if (!($lastLookGametime >0)) then put #var lastLookGametime 0
if ("$charactername" = "Inauri") then {
    var look.poison 0
    var look.poisonSelf 0
    var look.disease 0
    var look.diseaseSelf 0
}

var look.target 0
var look.teach 0
var look.topic 0
var look.openDoor 0


if !(matchre("$scriptlist", "reconnect")) then {
    put .reconnect
}
###############################
###    MAIN
###############################
look.loop:
    if (%look.teach = 1) then {
        gosub look.teach
    }
    if ($standing = 0) then gosub stand
    if ("$charactername" = "Inauri") then {
        if (%look.poison = 1 || %look.poisonSelf = 1) then gosub look.healPoison
        if (%look.disease = 1 || %look.diseaseSelf = 1) then gosub look.healDisease
        if ($mana > 30 && $SpellTimer.Regenerate.duration < 1) then gosub refreshRegen
        if ($Empathy.LearningRate < 33  && $lib.magicInert <> 1) then gosub percHealth.onTimer
        pause 1
        if ($inauri.subScript > 0) then gosub look.resumeScript
    }
    if ("$charactername" = "Khurnaarti") then {
        if !(matchre("$scriptlist", "khurnaarti")) then {
            put .khurnaarti
        }
    }
    if (%look.openDoor = 1) then gosub look.door
    pause 2
    gosub look.look
    goto look.loop


###############################
###    METHODS
###############################
look.door:
    if (matchre("$scriptlist", "($char.common.scripts)")) then {
        put #tvar inauri.subScript $0
        put #script abort $inauri.subScript
    }
    if (%look.openDoor = 0) then goto look.loop
    gosub unlock door
    gosub open door
    var look.openDoor 0
    goto look.loop


look.healDisease:
    if (%look.disease) then {
        gosub touch $inauri.healTarget
        gosub take $inauri.healTarget disease quick
        var look.disease 0
        var look.diseaseSelf 1
    }
    if (%look.diseaseSelf = 1) then {
        gosub runScript cast cd
        var look.diseaseSelf 0
    }
    return


look.healWound:
    if ($inauri.healTarget = 0) then {
        put #var inauri.heal 0
        goto look.loop
    }
    if (matchre("$scriptlist", "($char.common.scripts)")) then {
        put #tvar inauri.subScript $0
        put #script abort $inauri.subScript
    }
    var look.wounds 1
    gosub redirect all to left leg
    gosub touch $inauri.healTarget
    if (%look.wounds = 1 || %look.vitality = 1) then {
        if (%look.vitality = 1) then {
            gosub take $inauri.healTarget vitality quick
            var look.vitality 0
        }
        gosub take $inauri.healTarget ever quick
        put #var inauri.heal 0
        var look.wounds 0
    } else {
        gosub whisper $inauri.healTarget You have no wounds.
    }
    goto look.loop


look.healPoison:
    if (%look.poison) then {
        gosub touch $inauri.healTarget
        gosub take $inauri.healTarget poison quick
        var look.poison 0
    }
    if (%look.poisonSelf = 1) then {
        gosub runScript cast fp
        var look.poisonSelf 0
    }
    return


look.houseMove:
    put .house
    waitforre ^HOUSE DONE
    goto look.loop


look.look:
  evalmath nextLookAt $lastLookGametime + 240
  if (%nextLookAt < $gametime) then {
    gosub tdp
    put #var lastLookGametime $gametime
  }
return


look.resumeScript:
    if ("$inauri.subScript" = "engineer" && "$righthand" <> "Empty") then {
        if ("$lefthand" = "Empty") then gosub stow left
            put .engineer 1 $righthandnoun
        } else {
            put .engineer 2 $char.craft.item
        }
    }
    if ("$inauri.subScript" = "engbolt" && "$righthand" <> "Empty") then {
        if ("$lefthand" = "Empty") then gosub stow left
            put .engbolt 1
        } else {
            put .engbolt 2
        }
    }
    if ("$inauri.subScript|$khurnaarti.subScript" = "magic") then {
        put .magic noLoop
    }
    if ("$inauri.subScript|$khurnaarti.subScript" = "research") then {
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
    put #tvar inauri.subScript 0
    return


look.teach:
    if (matchre("$scriptlist", "($char.common.scripts)")) then {
        put #tvar inauri.subScript $0
        put #script abort $inauri.subScript
    }
    if ($lib.class = 1) then {
        gosub assess teach
        if ("$class" = "Enchanting") then {
            if ("%look.target" = "Selesthiel") then {
                put kiss Selesthiel forehead
            } else {
                put stare %look.target
                put shake head inauri
            }
            var look.teach 0
            return
        }
        if contains("$class", "%look.topic") then {
            put whisper %look.target I am already teaching you $class.
            var look.teach 0
            return
        }
        gosub stop teach
    }
    if ($lib.student = 1) then {
        gosub stop listen
    }
    gosub teach %look.topic to %look.target
    var look.teach 0
    return


look.vitalityHeal:
    if (matchre("$scriptlist", "($char.common.scripts)")) then {
        put #tvar inauri.subScript $0
        put #script abort $inauri.subScript
    }
    gosub link all cancel
    if ($lib.magicInert = 1 && $bleeding = 1) then {
        put #echo >Log [look] Bleeding, low vitality, and magically inert.
        put exit
        exit
    }

    look.vitalityHealLoop:
        pause .2
        gosub prep vh
        pause 2
        gosub cast
        if ($health < 60) then {
            goto look.vitalityHealLoop
        }
        goto look.loop
