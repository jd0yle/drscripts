###################################################################################################
# stow.cmd
# Selesthiel [Justin Doyle <justin@jmdoyle.com>]
# Wraps the STOW command to automatically wear items that can't be stowed,
# and to put specific items into specific containers
###################################################################################################

include libmaster.cmd

gosub stow %0

## This is a POC for a more comprehensive, variable-based stowing system
#var my
#
#if_1 then {
#    if ("%1" = "my") then {
#        var my "my"
#        var item %2
#    } else {
#        var item %1
#    }
#} else {
#    var item right
#}
#
#if ("%item" = "right") then var item $righthand
#if ("%item" = "left") then var item $lefthand
#
## If there are more than 2 words in the item's name, discard all but the last word
#if (count("%item", " ") > 1) then {
#    eval item replacere("%item", ^.*\s, " ")
#    eval item trim("%item")
#}
#
#if ("%item" = "compendium") then gosub put %my compendium in my thigh bag
#else if (contains("%item", "staff")) then gosub wear %my %item
