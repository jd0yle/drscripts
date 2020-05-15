var sigil %1

include libsel.cmd

var colors shadowy-black|platinum-hued|fiery-red|icy-blue|bone-white|pitch-black|gold-hued|blood-red|ash-grey
var colorsIndex 0
eval len count("%colors", "|")

if (%sigil = list) then goto listLoopStart

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


listLoopStart:
    var list Sigils
    action var list %list|$1 when \d+ -- (\S+),.*

    var types abolition|congruence|induction|permutation|rarefaction|antipode|ascension|clarification|decay|evolution|integration|metamorphosis|nurture|paradox|unity
    eval typesLength count("%types", "|")
    var typesIndex 0


initTypesLoop:
    var %types(%typesIndex) 0
    math typesIndex add 1
    if (%typesIndex > %typesLength) then goto listLoop
    goto initTypesLoop


listLoop:
    gosub get my %colors(%colorsIndex) book
    gosub turn my book to index
    put read my book
    gosub stow right
    math colorsIndex add 1
    if %colorsIndex > %len then goto listDone
    goto listLoop


listDone:
    #echo %list
    eval listLen count("%list", "|")
    var idx 0

    listDoneLoop:
        #echo %list(%idx)
        put #log >sigils.txt %list(%idx)
        math %list(%idx) add 1
        math idx add 1
        if %idx > %listLen then goto echoTypes
    goto listDoneLoop


echoTypes:
    var typesIndex 0
    echoTypesLoop:
        echo %types(%typesIndex) %%types(%typesIndex)
        math typesIndex add 1
        if (%typesIndex > %typesLength) then exit
        goto echoTypesLoop

exit:
   #echo %listLen sigils
    exit
