include libmaster.cmd
###############################
###    IDLE ACTION TRIGGERS
###############################
if ("$charactername" = "Inauri") then {
    action put #var inauri.heal 1 ; put #var inauri.target $1 when ^(Khurnaarti|Selesthiel|Vohraus|Inahk|Estius) whispers, "heal
    action put #var inauri.heal 0 when ^(\S+) is not wounded in that location\.$
    action var look.openDoor 1 when ^(Qizhmur|Selesthiel|Khurnaarti)'s face appears in the
    action var look.openDoor 2 when ^(Vohraus|Inahk|Estius)'s face appears in the
    action var look.poison 1 when ^(Khurnaarti|Selesthiel) whispers, "poison
    action var look.poison 1 when ^(He|She) has a (dangerously|mildly|critically) poisoned
    action var look.poisonSelf 1 when ^You feel a slight twinge in your|^You feel a (sharp|terrible) pain in your
    action var look.poisonSelf 0 when ^A sudden wave of heat washes over you as your spell flushes all poison from your body\.
}
action var look.teach 1; var look.topic $2 ; var look.target $1 when ^(Khurnaarti|Selesthiel|Qizhmur) whispers, "teach (.*)"$


###############################
###    VARIABLES
###############################
if (!($lastLookGametime >0)) then put #var lastLookGametime 0
if ("$charactername" = "Inauri") then {
    var look.poison 0
    var look.poisonSelf 0
}

var look.target 0
var look.teach 0
var look.topic 0


###############################
###    MAIN
###############################
look.loop:
    if (%look.teach = 1) then gosub look.teach
    if ($standing = 0) then gosub stand
    if ("$charactername" = "Inauri") then {
        if ($inauri.heal = 1) then gosub look.healWound
        if (%look.poison = 1 || %look.poisonSelf = 1) then gosub look.healPoison
        if (%look.disease = 1 || %look.diseaseSelf = 1) then gosub look.healDisease
        if ($mana > 30 && $SpellTimer.Regenerate.duration < 1) then gosub refreshRegen
        if ($inauri.subScript <> 0) then {
            if (!contains("$scriptlist", "$inauri.subScript")) then {
                put #echo >Log [look] $inauri.subScript crashed, restarting it..

                if ("$inauri.subScript" = "eng") then {
                    if ("$righthand" <> "Empty" && "$nextTool" <> 0) then {
                        put .eng 1 necklace
                    } else put .eng 2 necklace
                }

                if ("$inauri.subScript" = "magic" then {
                    put .magic noLoop
                }
            }
        }
    }
    if (%look.openDoor = 1) then gosub look.door
    var look.openDoor 0
    pause 2
    gosub look.look
    goto look.loop


###############################
###    METHODS
###############################
look.door:
   #if !(contains("$roomplayers", "Selesthiel")) then {
        gosub unlock door
        gosub open door
   #}
   if (%inauri.openDoor = 2) then {
        gosub unlock door
        gosub open door
   }
   var look.openDoor 0
   return


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
    gosub redirect all to left leg
    gosub touch $inauri.healTarget
    gosub take $inauri.healTarget ever quick
    put #var inauri.heal 0
    return


look.healPoison:
    if (%look.poison) then {
        gosub touch $inauri.healTarget
        gosub take $inauri.healTarget poison quick
        var look.poison 0
    }
    if (%look.poisonSelf = 1) then {
        put runScript cast fp
        var look.poisonSelf 0
    }
    return


look.look:
  evalmath nextLookAt $lastLookGametime + 240
  if (%nextLookAt < $gametime) then {
    gosub look
    put #var lastLookGametime $gametime
  }
return


look.teach:
    if ($lib.class = 1) then {
        if ("$class" = "Enchanting") then {
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