####################################################################################################
# compendium.cmd
# Study compendium(s)
#
# Performs the commune of the specified deity.
#
# Args:
#    --item  The short tap of the compendium to use (overrides $char.compendium and $char.compendiums)
#    --forceTurn 1|0  Force turning the compendium page after every STUDY (overrides $char.compendium.forceTurn)
#    --target   1-34  Target learning rate to stop at
#
# Character Variables
#    $char.compendium The compendium item to use
#    $char.compendiums If you want to use multiple compeniums
#    $char.compendium.forceTurn sets --forceTurn
#
# Example:
# .compendium --item=pale compendium
# .compendium --item=bloodstained compendium --forceTurn=1
#
####################################################################################################
include libmaster.cmd
include args.cmd


###############################
###    ACTIONS
###############################
action var compendiumStage 0 when ^You begin|^You continue
action var compendiumStage 1 when ^In a sudden|with sudden|^With a sudden|^You attempt
action var compendiumStage 2 when ^Why do you
action goto compendiumOpen when ^You carefully examine a.*but see nothing special\.|You need to open the textbook to read it\.


###############################
###    CHAR VARIABLES
###############################
# 1 = Turn to new page.
# 2 = Done with all pages.
var compendiumStage 0

# If the item is specified in the args; --item=my compendium
if ("%args.item" != ".item") then {
	var compendiumItem %args.item
} else {
	# if $char.compendiums is defined, then we want to do this for multiple compendiums, otherwise just the one
	if (contains("$char.compendiums", "|")) then {
		var compendiumMultiple 1
		var compendiumIndex 0
		var compendiumItem $char.compendiums(%compendiumIndex)
	} else {
		var compendiumItem $char.compendium
	}
}

var targetLearningRate 34
if (%args.targetLearningRate > 0) then var targetLearningRate %args.targetLearningRate

var compendiumForceTurn 0
if (%args.forceTurn = 1 || $char.compendium.forceTurn = 1) then var compendiumForceTurn 1

var compendiumTurns 0


###############################
###    MAIN
###############################
compendium:
    gosub stow left
    if ("$righthandnoun" != "%compendiumItem") then {
        gosub stow right
        gosub get my %compendiumItem
    }
    if ("$righthandnoun" != "%compendiumItem") then goto compendiumError
    gosub read my %compendiumItem

    compendiumLoop:
        var compendiumStage -1
        gosub study my %compendiumItem
		if ($Scholarship.LearningRate > %targetLearningRate && $First_Aid.LearningRate > %targetLearningRate) then goto compendiumDone
        if (%compendiumStage = 1 || %compendiumForceTurn = 1) then {
            gosub turn my %compendiumItem
            math compendiumTurns add 1
            if (%compendiumTurns > 9) then goto compendiumNext
            goto compendiumLoop
        }
        if (%compendiumStage = 0) then goto compendiumLoop

        goto compendiumNext


###############################
###    compendiumNext
###############################
compendiumNext:
	if (%compendiumMultiple != 1) then goto compendiumDone
	math compendiumIndex add 1
	if (%compendiumIndex > count("$char.compendiums", "|")) then goto compendiumDone
	var compendiumItem $char.compendiums(%compendiumIndex)
	gosub stow right
	var compendiumTurns 0
	goto compendium


###############################
###    compendiumOpen
###############################
compendiumOpen:
	gosub open my %compendiumItem
	goto compendium


###############################
###    EXIT
###############################
compendiumDone:
    gosub close my %compendiumItem
    gosub stow my %compendiumItem
    goto compendiumExit


compendiumError:
    if ("%compendiumItem" != NULL) then {
        put #echo >Log Yellow [compendium] Your %compendiumItem is missing!
    } else {
        put #echo >Log Yellow [compendium] Your %compendiumItem variable is not set!
    }
    goto compendiumExit


compendiumExit:
    pause .2
    put #parse COMPENDIUM DONE
    exit