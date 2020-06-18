include libsel.cmd

var act %1

var armor moonsilk pants|moonsilk hood|moonsilk mask|moonsilk shirt|moonsilk gloves|steelsilk handwraps|steelsilk footwraps|shield
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
    gosub %verbTwo my %armor(%index)
    math index add 1
    if (%index > %length) then exit
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
