include libmaster.cmd
###############################
###    ACTIONS
###############################
action var compendiumStage 0 when ^You begin|^You continue
action var compendiumStage 1 when ^In a sudden|with sudden|^With a sudden|^You attempt
action var compendiumStage 2 when ^Why do you


###############################
###    CHAR VARIABLES
###############################
# 1 = Turn to new page.
# 2 = Done with all pages.
var compendiumStage 0


###############################
###    MAIN
###############################
    compendium:
    gosub get my $char.compendium
    if ("$righthandnoun" <> "$char.compendium") then goto compendiumError
    gosub open my $char.compendium

    compendiumLoop:
        gosub study my $char.compendium
        if (%compendiumStage = 0) then goto compendiumLoop
        if (%compendiumStage = 1) then {
            if ($Scholarship.LearningRate > 30 && $First_Aid.LearningRate > 30) then {
                goto compendiumDone
            } else {
                gosub turn my $char.compendium
            }
            goto compendiumLoop
        }
        if (%compendiumStage = 2) then {
            goto compendiumDone
        }


###############################
###    EXIT
###############################
compendiumDone:
    gosub close my $char.compendium
    gosub stow my $char.compendium
    goto compendiumExit


compendiumError:
    if ("$char.compendium" <> NULL) then {
        put #echo >Log Yellow [compendium] Your $char.compendium is missing!
    } else {
        put #echo >Log Yellow [compendium] Your $char.compendium variable is not set!
    }
    goto compendiumExit


compendiumExit:
    pause .2
    put #parse COMPENDIUM DONE
    exit