include libmaster.cmd
#include args.cmd



var scrollItems scroll|ostracon|roll|leaf|vellum|tablet|parchment|bark|papyrus
var scrollindex 0

theloop:
    gosub get my %scrollItems(%scrollindex) from my skull
    if ("$righthand" = "Empty") then {
        math scrollindex add 1
        if (%scrollindex > count("%scrollItems", "|")) then goto done
        goto theloop
    }
    put give selesthiel
    pause .5
    goto theloop