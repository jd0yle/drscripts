include libsel.cmd
#debug 3

##################################################
# USAGE
# .enchant <command> [args]
# Commands:
#     make  Enchants an item
#     get:  Flips to the page of a sigil book containing <sigil>
#     list: Lists all sigils in your sigil books
# .enchant make <chapter> <page> <baseItem> <sigilOne> [sigilTwo]
# .enchant get <sigilType>
# .enchant list
##################################################

var command %1

var colors shadowy-black|platinum-hued|fiery-red|icy-blue|bone-white|pitch-black|gold-hued
var colorsIndex 0
eval len count("%colors", "|")

var sigilCollection
var chapter
var page
var baseItem
var sigilOne
var sigilTwo

if "%command" = "list" then goto listLoopStart

if "%command" = "get" then {
    gosub findSigil %2
    exit
}

if "%command" = "make" then {
    var chapter %2
    var page %3
    var baseItem %4
    var sigilOne %5
    var sigilTwo %6
    gosub enchant
}

# artificing book

gosub stow left
gosub stow right


enchant:
    gosub get my artificing book
    gosub turn my artificing book to chapter %chapter
    gosub turn my artificing book to page %page
    gosub read my artificing book
    gosub study my artificing book
    gosub stow my book

    gosub get my %baseItem
    gosub put my %baseItem on brazier
    gosub put my %baseItem on brazier

    gosub get my fount
    gosub wave my fount at %baseItem

    gosub get my %cambrinth
    gosub prep imbue 20
    gosub charge my %cambrinth 20
    gosub charge my %cambrinth 20
    gosub charge my %cambrinth 20
    gosub charge my %cambrinth 20
    gosub focus my %cambrinth
    gosub invoke my %cambrinth
    pause 5
    gosub cast %baseItem on brazier
    gosub stow my %cambrinth

    gosub findSigil %sigilOne


findSigil:
    var sigil $1
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
    gosub goNext
    goto goNext


goNext:
    gosub stow right
    math colorsIndex add 1
    if %colorsIndex > %len then goto done
    return

goPage:
    var page $1
    gosub turn my book to page %page
    put read my book
    return




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
    var sigilCollection %list
    eval listLen count("%list", "|")
    var idx 0

    listDoneLoop:
        echo %list(%idx)
        math idx add 1
        if %idx > %listLen then goto exit
    goto listDoneLoop


exit:
    exit


done:
    echo "All done"
    exit
