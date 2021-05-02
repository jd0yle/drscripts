include libmaster.cmd

###############################
###      VARIABLES
###############################
var armor.act %1
var armor.index 0
var armor.length 0
var armor.list $char.armor
var armor.verbOne 0
var armor.verbTwo 0


###############################
###      INIT
###############################
eval armor.length count("%armor.list", "|")
var armor.index 0

if ("%armor.act" = "wear") then {
    var armor.verbOne get
    var armor.verbTwo wear
    goto armor.loop
}

if ("%armor.act" = "remove") then {
   var armor.verbOne remove
   var armor.verbTwo stow
   goto armor.loop
}

gosub stow right
gosub stow left

if ("%armor.act" = "repair") then goto armor.repairArmorLoop

if ("%armor.act" = "get") then goto armor.getFromRepairLoop


###############################
###      MAIN
###############################
armor.loop:
    gosub %armor.verbOne my %armor.list(%armor.index)
    if ("$righthand" != "Empty" || "$lefthand" != "Empty") then {
        gosub %armor.verbTwo my %armor.list(%armor.index)
    }
    math armor.index add 1
    if (%armor.index > %armor.length) then goto armor.done
    goto armor.loop


armor.repairArmorLoop:
    gosub remove my %armor.list(%armor.index)
    gosub give my %armor.list(%armor.index) to randal
    gosub give my %armor.list(%armor.index) to randal
    gosub stow my ticket
    math armor.index add 1
    if (%armor.index > %armor.length) then goto armor.done
    goto armor.repairArmorLoop


armor.getFromRepairLoop:
    gosub get my randal ticket
    if ("$righthand" = "Empty") then goto armor.done
    gosub give my ticket to randal
    gosub wear right
    goto armor.getFromRepairLoop


armor.done:
    gosub stow right
    gosub stow left
    pause .2
    put #parse ARMOR DONE
    exit
