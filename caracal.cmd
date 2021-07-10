####################################################################################################
# .caracal
# Selesthiel - justin@jmdoyle.com
#
# USAGE
# .caracal
#
####################################################################################################
include libmaster.cmd


var loopsRemaining 10

caracal.main:
	if ($First_Aid.LearningRate > 33) then goto caracal.done

    if ("$righthand" != "fuzzy caracal") then {
        gosub stow right
        gosub stow left
        gosub get my caracal
    }
    gosub skin my caracal
    gosub repair my caracal
    evalmath loopsRemaining (%loopsRemaining - 1)
    if (%loopsRemaining < 1) then goto caracal.done
    goto caracal.main


caracal.done:
	if ("$righthand" = "fuzzy caracal" || "$lefthand" = "fuzzy caracal") then gosub stow my caracal
	pause .2
	put #parse CARACAL DONE
	exit