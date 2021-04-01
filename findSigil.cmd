include libsel.cmd
####################################################################################################
# .findSigil
# Selesthiel - justin@jmdoyle.com
# USAGE
# .findSigil [args]
# .findSigil [sigilType] [list] [store]
# sigilType: The type of sigil to find...
# list: Compile a list of the number of each type of sigil
# store: Put loose sigils into their appropriate sigil books
#
# Parse out FOUND SIGIL when completed
#
# NOTE: This assumes you have you 15 sigil books with the colors in the `colors` array!
####################################################################################################

echo .findSigil %0

var sigil %1

if ("%sigil" = "any" || "%sigil" = "primary") then var sigil induction

var types abolition|congruence|induction|permutation|rarefaction|antipode|ascension|clarification|decay|integration|metamorphosis|nurture|paradox|unity|evolution
eval typesLength count("%types", "|")

var colors shadowy-black|platinum-hued|fiery-red|icy-blue|bone-white|pitch-black|gold-hued|blood-red|ash-grey|twilight-blue|blue|black|copper-hued|red|white
var colorsIndex 0
eval colorsLength count("%colors", "|")

if (%sigil = list) then goto listLoopStart

if (%sigil = store) then goto storeLoop

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
    if ("$righthand" = "white backpack" || "$lefthand" = "white backpack") then {
        gosub put my book in my white backpack
    } else {
        gosub put my book in my shadows
    }
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
    if ("$righthand" = "white backpack" || "$lefthand" = "white backpack") then {
        gosub put my book in my white backpack
    } else {
        gosub put my book in my shadows
    }
    gosub stow right
    math colorsIndex add 1
    if %colorsIndex > %colorsLength then goto listDone
    goto listLoop


listDone:
    #echo %list
    eval listLen count("%list", "|")
    var idx 0

    listDoneLoop:
        math %list(%idx) add 1
        math idx add 1
        if %idx > %listLen then goto echoTypes
    goto listDoneLoop


echoTypes:
    var typesIndex 0
    echoTypesLoop:
        echo %types(%typesIndex) %%types(%typesIndex)
        put #var sigilCounts.%types(%typesIndex) %%types(%typesIndex)
        math typesIndex add 1
        if (%typesIndex > %typesLength) then goto doneList
        goto echoTypesLoop


storeLoop:
    gosub get my %colors(%colorsIndex) book
    if ("$righthand" = "Empty") then {
        gosub get my %colors(%colorsIndex) book from my white backpack
    }
storeLoop1:
    gosub get my %types(%colorsIndex) sigil
    if ("$lefthand" = "Empty") then {
        gosub put my book in my white backpack
        gosub put my book in my shadows
        gosub stow right
        math colorsIndex add 1
        if (%colorsIndex > %colorsLength) then goto doneStore
        goto storeLoop
    }
    gosub put my sigil in my book
    if ("$lefthand" != "Empty") then {
        gosub put my sigil in my haversack
        gosub put my book in my shadows
        gosub stow right
        math colorsIndex add 1
        if (%colorsIndex > %colorsLength) then goto doneStore
        goto storeLoop
    }
    goto storeLoop1


doneList:
doneStore:
    put #parse FINDSIGIL DONE

exit:
   #echo %listLen sigils
    exit
