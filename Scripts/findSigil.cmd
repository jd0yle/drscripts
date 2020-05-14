var sigil %1

include libsel.cmd

var colors shadowy-black|platinum-hued|fiery-red|icy-blue|bone-white|pitch-black|gold-hued|blood-red|ash-grey
var colorsIndex 0
eval len count("%colors", "|")

loop:
    gosub get my %colors(%colorsIndex) book
    if "$righthand" != "Empty" then {
        gosub turn my book to sigil %sigil
        matchre goPage (\d+) -- %sigil
        matchre goNext You can turn the book
        put read my book
        matchwait
    } else {
        goto goNext
    }
    goto goNext


goNext:
    gosub stow right
    math colorsIndex add 1
    if %colorsIndex > %len then goto done
    goto loop

goPage:
    var page $1
    gosub turn my book to page %page
    put read my book
    goto done


done:
    put #parse FOUND SIGIL
    exit
