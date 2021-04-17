include libmaster.cmd
###################
# Idle Action Triggers
###################
if ("$charactername" = "Inauri") then {
    action put #var heal 1 ; put #var target $1 when ^(Khurnaarti|Selesthiel|Vohraus|Inahk|Estius) whispers, "heal
    action put #var openDoor 1 when ^(Qizhmur|Selesthiel|Khurnaarti)'s face appears in the
    action put #var openDoor 2 when ^(Vohraus|Inahk|Estius)'s face appears in the
    action put #var poison 1 when ^(Khurnaarti|Selesthiel) whispers, "poison
    action put #var poison 1 when ^(He|She) has a (dangerously|mildly|critically) poisoned
    action put #var poisonHeal 1 when ^You feel a slight twinge in your|^You feel a (sharp|terrible) pain in your
    action put #var poisonHeal 0 when ^A sudden wave of heat washes over you as your spell flushes all poison from your body\.
}
action put #var teach 1; put #var topic $2 ; put #var target $1 when ^(Khurnaarti|Selesthiel|Qizhmur) whispers, "teach (.*)"$

###################
# Variable Inits
###################
if ("$charactername" = "Inauri") then {
    if (!($heal >0)) then put #var heal 0
    if (!($poison >0)) then put #var poison 0
    if (!($poisonHeal >0)) then put #var poisonHeal 0
}
if (!($target >0)) then put #var target 0
if (!($teach >0)) then put #var teach 0
if (!($lastLookGametime >0)) then put #var lastLookGametime 0

###################
# Main
###################
loop:
    if ($teach = 1) then gosub waitTeach
    if ($standing = 0) then gosub stand
    if ($charactername = "Inauri") then {
        if ($heal = 1) then {
            gosub redirect all to left leg
            gosub touch $target
            gosub take $target ever quick
            put #var heal 0
        }
        if ($poison = 1) then {
            gosub touch $target
            gosub take $target poison quick
            put #var poison 0
        }
        if ($poisonHeal = 1) then {
            gosub runScript cast fp
        }
        if ($mana > 30) then {
            if ($SpellTimer.Regenerate.duration < 1) then gosub refreshRegen
        }
    }
    if ($openDoor = 1) then {
        if !(contains("$roomplayers", "Selesthiel") || contains("$roomplayers", "Inauri")) then {
            gosub unlock door
            gosub open door
        }
    }
    if ($openDoor = 2) then {
        gosub unlock door
        gosub open door
    }
    put #var openDoor 0
    pause 2
    gosub waitLook
    goto loop

###################
# Wait Methods
###################
waitLook:
  evalmath nextLookAt $lastLookGametime + 240
  if (%nextLookAt < $gametime) then {
    gosub look
    put #var lastLookGametime $gametime
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