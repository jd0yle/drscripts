include libmaster.cmd

var parts none

#You have a small red blood mite on your right leg, a small red blood mite on your right arm.

action var parts %parts|$1 when blood mite on your (.*?)(?:,|\.)


tend.top:
    var parts none
	gosub health
	pause 1
	var index 0
	eval len count("%parts", "|")

echo %parts

if ("%parts" = "none") then goto done

loop:
    echo thispart: %parts(%index)
    if ("%parts(%index)" != "none") then {
        gosub tend my %parts(%index)
    }
    math index add 1
    if (%index > %len) then goto tend.top
    goto loop

done:
    pause .2
    put #parse TEND DONE
    exit