include libmaster.cmd
###############################
###    IDLE ACTION TRIGGERS
###############################
if ("$charactername" = "Inauri") then {
    action var look.heal 1 ; put #var target $1 when ^(Khurnaarti|Selesthiel|Vohraus|Inahk|Estius) whispers, "heal
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
    var look.heal 0
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
    if ($charactername = "Inauri") then {
        if (%look.heal = 1) then {
            gosub redirect all to left leg
            gosub touch %look.target
            gosub take %look.target ever quick
            var %look.heal 0
        }
        if (%look.poison = 1) then {
            gosub touch %look.target
            gosub take %look.target poison quick
            var look.poison 0
        }
        if (%look.poisonSelf = 1) then {
            gosub runScript cast fp
        }
        if ($mana > 30) then {
            if ($SpellTimer.Regenerate.duration < 1) then gosub refreshRegen
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
   if !(contains("$roomplayers", "Selesthiel")) then {
        gosub unlock door
        gosub open door
   }
   if (%inauri.openDoor = 2) then {
        gosub unlock door
        gosub open door
   }
   var look.openDoor 0
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