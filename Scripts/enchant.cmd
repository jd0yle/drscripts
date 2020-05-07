#debug 3
var sigil %1

include libsel.cmd

# artificing book

var colors shadowy-black|platinum-hued|fiery-red|icy-blue|bone-white|pitch-black|gold-hued
var colorsIndex 0
eval len count("%colors", "|")

gosub stow left
gosub stow right

if "%sigil" = "list" then goto listLoopStart


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
    echo "All done"
    exit



listLoopStart:
    var list Sigils
    action var list %list|$1 when \d+ -- (\S+),.*
    goto listLoop

listLoop:
    gosub get my %colors(%colorsIndex) book
    gosub turn my book to index
    put read my book
    gosub stow right
    math colorsIndex add 1
    if %colorsIndex > %len then goto listDone
    goto listLoop

listDone:
    echo %list
    eval listLen count("%list", "|")
    var idx 0


    listDoneLoop:
        echo %list(%idx)
        math idx add 1
        if %idx > %listLen then goto exit
    goto listDoneLoop

exit:
    exit
