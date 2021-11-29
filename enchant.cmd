include libmaster.cmd

##################################################
# USAGE
# .enchant [args]
# .enchant make <chapter> <page> <baseItem>
##################################################

####### CONFIG #######

var cambrinth mammoth calf
var burin silversteel burin
var brazier silversteel brazier
var loop augmenting loop

#var enchantingContainer shadows
var enchantingContainer white haversack
var defaultContainer steelsilk backpack


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
action var doScribe 1 when ^You can't tell anything else
action var doScribe 1; var useMeditate 1 when ^The sigil pattern has shifted and the fount requires alignment through meditation before scribing can continue.

action var useLoop 1 when ^You notice many of the scribed sigils are slowly merging back into
action var useMeditate 1 when ^The traced sigil pattern blurs before your eyes, making it difficult to follow
action var useFocus 1 when struggles to accept the sigil
#action var useFocus 1 when ^You estimate that it is
action var doScribe 1 when ^You estimate that it is

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
action var doStoreProducts 1 when You collect the fount and place it at your feet.

action var sigilsNeeded %sigilsNeeded|$2 when (primary|secondary) sigil \((\S+)\)$

action goto alreadyEnchanted when ^The.* is already enchanted, and further manipulation could damage it.

#put store default %enchantingContainer

gosub enchant.stow left
gosub enchant.stow right

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
        gosub enchant.stow right
        gosub enchant.stow left

        gosub get my %sigilToScribe book
        gosub turn my book to page 1
        gosub pull my book

        if ("$lefthandnoun" != "sigil-scroll") then {
            echo MISSING %sigilToScribe SIGIL, CANNOT CONTINUE
            exit
        }

        gosub study my sigil-scroll
        gosub trace %baseItem on brazier
        gosub enchant.stow my book
    }

    if (%doImbue != 1) then {
        gosub enchantScribe
    }

    if (%doImbue = 1) then {
        gosub enchant.stow right
        put .cast imbue "%baseItem on brazier"
        waitforre ^CAST DONE
    }

    if (%doStoreProducts = 1) then {
        gosub get my fount
        gosub enchant.stow fount
        gosub get my brazier
        gosub enchant.stow brazier
        put store default %defaultContainer
        gosub get my %baseItem
        gosub focus my %baseItem
        put #parse ENCHANT DONE
        pause .3
        exit
    }

    goto enchantLoop


checkSigils:
    eval len count("%sigilsNeeded", "|")
    var index 0
    gosub enchant.stow right
    gosub enchant.stow left
    echo CHECKING SIGILS %len %sigilsNeeded
checkSigilsLoop:
    if (%index > %len) then return
    if ("%sigilsNeeded(%index)" != "null") then {
        gosub get my %sigilsNeeded(%index) book
        gosub turn my book to contents

        matchre checkSigils.foundSigil (\d+) -- (\S+),
        matchre checkSigils.noSigil ^\[You can turn
        put read my book
        matchwait 10

        echo SKIPPED A MATCHWAIT
        gosub enchant.stow right
        goto checkSigilsLoop
    }
    math index add 1
    goto checkSigilsLoop

checkSigils.foundSigil:
	math index add 1
	#gosub enchant.stow my %sigilsNeeded(%index) book
	gosub enchant.stow my book
	goto checkSigilsLoop

checkSigils.noSigil:
    echo MISSING %sigilToScribe SIGIL, CANNOT CONTINUE
    exit


setArtificingBook:
    gosub enchant.stow right
    gosub get my artificing book
    gosub turn my book to chapter %chapter
    gosub turn my book to page %page
    #gosub read my book
    gosub study my book
    gosub enchant.stow my book
    return


setBaseItem:
    gosub get my %baseItem from my tort sack
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
    gosub enchant.stow right
    gosub enchant.stow left
    gosub get my %brazier
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

    if ("$righthandnoun" != "burin" && "$righthand" != "Empty") then gosub enchant.stow right
    if ("$righthandnoun" != "burin") then gosub get my %burin

    gosub scribe %baseItem on brazier with my burin
    if (%doImbue = 1 || %doSigil = 1) then return
    return
    goto enchantScribe


useLoopTool:
    if ("$righthandnoun" != "loop" && "$righthand" != "Empty") then gosub enchant.stow right
    if ("$righthandnoun" != "loop") then gosub get my %loop
    gosub push %baseItem on brazier with my loop
    #gosub enchant.stow my loop
    gosub put my loop in my shadows
    return

useMeditate:
    gosub meditate fount on brazier
    return

useFocus:
    gosub focus %baseItem on brazier
    return


enchant.stow:
    var enchantingThings book|brazier|fount|loop|burin|sigil|sigil-scrolls
    var item $0
    eval item replacere("%item", "my ", "")
    if ("%item" = "right" || "%item" = "") then var item $righthandnoun
    if (matchre("%item", "(%enchantingThings)")) then {
        gosub put my %item in my %enchantingContainer
    } else {
        gosub stow %item
    }
    unvar item
    return


alreadyEnchanted:
    put store default %defaultContainer
    echo %baseItem is already enchanted!
    exit
