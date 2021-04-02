include libmaster.cmd

var act %1

############
# Variables
############
if ("$charactername" = "Inauri") then {
    var armor balaclava|gloves|shirt|pants|shield|knee spikes|elbow spikes|knuckles|footwraps|armguard
}

if ("$charactername" = "Khurnaarti") then {
    var armor balaclava|gloves|hauberk|targe|armguard|knee spikes|elbow spikes|knuckles|footwraps
}

if ("$charactername" = "Qizhmur") then {
    var armor demonscale leathers|demonscale gloves|gladiator's shield|demonscale helm|demonscale mask|calcified femur
}

if ("$charactername" = "Selesthiel") then {
    var armor moonsilk pants|moonsilk hood|moonsilk mask|moonsilk shirt|moonsilk gloves|steelsilk handwraps|steelsilk footwraps|demonscale shield|stick
}

############
# Main
############
eval length count("%armor", "|")
var index 0

if ("%act" = "wear") then {
    var verbOne get
    var verbTwo wear
    goto armorLoop
}

if ("%act" = "remove") then {
   var verbOne remove
   var verbTwo stow
   goto armorLoop
}

gosub stow right
gosub stow left

if ("%act" = "repair") then goto repairArmorLoop

if ("%act" = "get") then goto getArmorFromRepairLoop

armorLoop:
    gosub %verbOne my %armor(%index)
    if ("$righthand" != "Empty" || "$lefthand" != "Empty") then {
        gosub %verbTwo my %armor(%index)
    }
    math index add 1
    if (%index > %length) then goto armorDone
    goto armorLoop


repairArmorLoop:
    gosub remove my %armor(%index)
    gosub give my %armor(%index) to randal
    gosub give my %armor(%index) to randal
    gosub stow my ticket
    math index add 1
    if (%index > %length) then exit
    goto repairArmorLoop


getArmorFromRepairLoop:
    gosub get my randal ticket
    if ("$righthand" = "Empty") then exit
    gosub give my ticket to randal
    gosub wear right
    goto getArmorFromRepairLoop

armorDone:
    pause .2
    put #parse ARMOR DONE
    exit
