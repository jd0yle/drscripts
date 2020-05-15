include libsel.cmd

##################################################
# USAGE
# .enchant [args]
# .enchant make <chapter> <page> <baseItem> <sigilOne> [sigilTwo]
##################################################

####### CONFIG #######

var cambrinth yoakena globe

######################

var colors shadowy-black|platinum-hued|fiery-red|icy-blue|bone-white|pitch-black|gold-hued|blood-red|ash-grey
var colorsIndex 0
eval len count("%colors", "|")

var chapter
var page
var baseItem
var sigilOne
var sigilTwo

var useLoop 0
var useMeditate 0
var useFocus 0

var doBook 1
var doFount 1
var doImbue 0
var doScribe 0
var doSigil 0
var doStoreProducts 0
var doItem 1

var sigilsNeeded null

action var doScribe 1 when The.* structure looks ready for additional scribing
action var doScribe 1 when You do not see anything that would prevent scribing additional sigils onto
action var doScribe 1 when free of problems that would impede further sigil scribing.
action var doScribe 1 when The.* appears free of problems that would impede further sigil scribing.
action var doScribe 1; var useMeditate 1 when ^The sigil pattern has shifted and the fount requires alignment through meditation before scribing can continue.

action var useLoop 1 when ^You notice many of the scribed sigils are slowly merging back into
action var useMeditate 1 when ^The traced sigil pattern blurs before your eyes, making it difficult to follow
action var useFocus 1 when struggles to accept the sigil

action var doImbue 1 when ^Once finished you sense an imbue spell will be required to continue enchanting.
action var doImbue 1 when ^The.* requires an application of an imbue spell to advance the enchanting process.
action var doImbue 0 when ^Sparkles of light cascade over
action var doImbue 0 when ^The spell is channeled through the

action var doFount 1 when ^You need another mana fount to continue
action var doFount 0 when ^On the brazier you see.*fount.*
action var doFount 0 when ^That is far too dangerous to remove

action var doSigil 1;var sigilToScribe $1 when ^You need another (\S+).* sigil to continue the enchanting process
action var doSigil 0 when with your finger and prepare to begin scribing it more permanently

action var doStoreProducts 1 when With the enchanting process completed, you believe it is safe to collect your things once more.

action var sigilsNeeded %sigilsNeeded|$2 when (primary|secondary) sigil \((\S+)\)$

action goto alreadyEnchanted when ^The.* is already enchanted, and further manipulation could damage it.

gosub stow left
gosub stow right

var chapter %1
var page %2
var baseItem %3
var sigilOne %4
var sigilTwo %5
var sigilThree %6
gosub enchant


enchant:
    if ($SpellTimer.ArtificersEye.duration < 10) then {
        put .cast art
        waitforre ^CAST DONE
    }
    gosub setBrazier
    gosub analyze %baseItem on brazier
    gosub look on brazier


enchantLoop:
    echo doScribe: %doScribe  doImbue: %doImbue  doFount: %doFount  doSigil: %doSigil
    if (%doBook = 1) then {
        gosub setArtificingBook
        var doBook 0
        gosub checkSigils
    }

    if (%doScribe = 1 || %doImbue = 1 || %doSigil = 1 || %doStoreProducts = 1) then var doItem 0

    if (%doScribe != 1 && %doImbue != 1 && %doSigil != 1 && %doStoreProducts != 1 && %doItem = 1) then {
        gosub setBaseItem
        var doItem 0
    }

    if (%doFount = 1) then {
        gosub setFount
    }

    if (%doSigil = 1) then {
        gosub stow right
        gosub stow left
        put .findSigil %sigilToScribe
        waitfor FOUND SIGIL
        if ("$righthand" = "Empty") then {
            echo MISSING %sigilToScribe SIGIL, CANNOT CONTINUE
            exit
        }
        gosub study my book
        gosub trace %baseItem on brazier
        gosub stow
    }

    if (%doImbue != 1) then {
        gosub enchantScribe
    }

    if (%doImbue = 1) then {
        gosub stow right
        put .cast imbue "%baseItem on brazier"
        waitforre ^CAST DONE
    }

    if (%doStoreProducts = 1) then {
        gosub stow fount
        gosub stow brazier
        gosub get %baseItem
        gosub focus my %baseItem
        exit
    }

    goto enchantLoop


checkSigils:
    eval len count("%sigilsNeeded", "|")
    var index 0
    gosub stow right
    gosub stow left
checkSigilsLoop:
    if (%index > %len) then return
    if ("%sigilsNeeded(%index)" != "null") then {
        put .findSigil %sigilsNeeded(%index)
        waitfor FOUND SIGIL
        if ("$righthand" = "Empty") then {
            echo MISSING %sigilToScribe SIGIL, CANNOT CONTINUE
            exit
        }
        gosub stow right
    }
    math index add 1
    goto checkSigilsLoop


setArtificingBook:
    gosub stow right
    gosub get my artificing book
    gosub turn my book to chapter %chapter
    gosub turn my book to page %page
    #gosub read my book
    gosub study my book
    gosub stow my book
    return


setBaseItem:
    gosub get my %baseItem from my sack
    if ("$righthand" = "Empty") then {
        gosub get my %baseItem
    }
    if ("$righthand" = "Empty") then {
        put #echo FF0000 Can't find %baseItem! Do you have one?
        exit
    }
    gosub put my %baseItem on brazier
    gosub put my %baseItem on brazier
    return


setBrazier:
    gosub stow right
    gosub stow left
    gosub get my brazier
    if ("$righthandnoun" != "brazier") then {
        if ("$lefthandnoun" = "brazier") then {
            gosub swap
        } else if ("$righthand" = "Empty") then {
            gosub get brazier
        }
    }
    gosub lower ground
    return


setFount:
    gosub get my fount
    gosub wave my fount at %baseItem on brazier
    return


enchantScribe:
    if (%useLoop = 1) then gosub useLoopTool
    if (%useMeditate = 1) then gosub useMeditate
    if (%useFocus = 1) then gosub useFocus

    var useLoop 0
    var useMeditate 0
    var useFocus 0

    if ("$righthandnoun" != "burin" && "$righthand" != "Empty") then gosub stow right
    if ("$righthandnoun" != "burin") then gosub get my unfocused burin

    gosub scribe %baseItem on brazier with my burin
    if (%doImbue = 1 || %doSigil = 1) then return
    return
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


alreadyEnchanted:
    echo %baseItem is already enchanted!
    exit
