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

var cambrinth Yoakena globe

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
    put .findSigil %2
    exit
}

if "%command" = "make" then {
    var chapter %2
    var page %3
    var baseItem %4
    var sigilOne %5
    var sigilTwo %6
    var sigilThree %7
    gosub enchant
}

# artificing book

gosub stow left
gosub stow right

action goto enchantScribe when ^The.* structure looks ready for additional scribing
action goto enchantScribe when ^You do not see anything that would prevent scribing additional sigils onto
action goto enchantScribe when free of problems that would impede further sigil scribing.


var useLoop 0
var useMeditate 0
var useFocus 0
action var useLoop 1 when ^You notice many of the scribed sigils are slowly merging back into
action var useMeditate 1 when ^The traced sigil pattern blurs before your eyes, making it difficult to follow
action var useFocus 1 when struggles to accept the sigil

gosub analyze %baseItem on brazier

enchant:
    gosub get my brazier
    gosub lower ground

    gosub get my artificing book
    gosub turn my book to chapter %chapter
    gosub turn my book to page %page
    #gosub read my book
    gosub study my book
    gosub stow my book

    put analyze %baseItem on brazier
    pause

    gosub get my %baseItem from my sack
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

    put .findSigil %sigilOne
    waitfor FOUND SIGIL
    if ("$righthand" = "Empty") then {
        echo MISSING %sigilOne SIGIL, CANNOT CONTINUE
        exit
    }
    gosub study my book

    gosub trace %baseItem on brazier
    gosub stow
    gosub get my unfocused burin
    gosub scribe %baseItem on brazier with my burin

    put .findSigil %sigilTwo
    waitfor FOUND SIGIL
    if ("$righthand" = "Empty") then {
        echo MISSING %sigilTwo SIGIL, CANNOT CONTINUE
        exit
    }

    gosub study my book

    gosub trace %baseItem on brazier
    gosub stow
    gosub enchantScribe


    exit

enchantScribe:
    if ("$righthandnoun" != "burin" && "$righthand" != "Empty") then gosub stow right
    if ("$righthandnoun" != "burin") then gosub get my unfocused burin

    if (%useLoop = 1) then gosub useLoopTool
    if (%useMeditate = 1) then gosub useMeditate
    if (%useFocus = 1) then gosub useFocus

    var useLoop 0
    var useMeditate 0
    var useFocus 0

    gosub scribe %baseItem on brazier with my burin
    goto enchantScribe


useLoopTool:
    if ("$righthandnoun" != "loop" && "$righthand" != "Empty") then gosub stow right
    if ("$righthandnoun" != "loop") then gosub get my loop
    gosub push %baseItem on brazier with my loop
    gosub stow my loop
    return

useMeditate:
    gosub meditate fount on brazier
    return

useFocus:
    gosub focus %baseItem on brazier
    return







findSigil:
    var sigil $1
findSigil1:
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
    #gosub goNext
    goto goNext


goNext:
    gosub stow right
    math colorsIndex add 1
    if %colorsIndex > %len then goto done
    goto findSigil1

goPage:
    var page $1
    gosub turn my book to page %page
    put read my book
    exit
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
