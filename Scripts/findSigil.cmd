var sigil %1

include libsel.cmd

var types abolition|congruence|induction|permutation|rarefaction|antipode|ascension|clarification|decay|integration|metamorphosis|nurture|paradox|unity|evolution
eval typesLength count("%types", "|")

var colors shadowy-black|platinum-hued|fiery-red|icy-blue|bone-white|pitch-black|gold-hued|blood-red|ash-grey|twilight-blue|blue|black|copper-hued|red
var colorsIndex 0
eval len count("%colors", "|")

if (%sigil = list) then goto listLoopStart

var index 0
findLoop:
    if ("%types(%index)" = "%sigil") then {
        gosub get my %colors(%index) book
        gosub turn my book to contents
        gosub turn my book to page 1
        gosub read my book
        goto done
    }
    math index add 1
    if (%index > %len) then {
        echo Couldn't find %sigil
        exit
    }
    goto findLoop

loop:
    gosub get my %colors(%colorsIndex) book
    if "$righthand" != "Empty" then {
        gosub turn my book to sigil %sigil
        matchre goPage (\d+) -- %sigil
        matchre goNext You can turn the book
        matchre goNext You page
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
