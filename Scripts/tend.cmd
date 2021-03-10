include libsel.cmd

var parts none

action var parts %parts|$1 when blood mite on your (.*?)(?:,|\.)
#action var parts %tendParts|$1 when blood mite on your (.*?)

gosub health

var index 0
eval len count("%parts", "|")

echo parts: %parts %len

loop:
    echo thispart: %parts(%index)
    if ("%parts(%index)" != "none") then {
        gosub tend my %parts(%index)
    }
    math index add 1
    if (%index > %len) then goto done
    goto loop

done:
    pause .2
    put #parse TEND DONE
    exit