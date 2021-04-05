include libmaster.cmd
include var_engineer.cmd
########################
# Engineering
# USAGE: .eng <number> <item> [design]
#    EX: .eng 3 bead weasel
########################
action var $eng.craft.nextTool shaper when ^Shaping with a wood shaper is needed to further smooth the material's surface\.
action var $eng.craft.nextTool rasp when ^A bulbous knot will make continued shaping difficult unless rubbed out with a rasp\.
action var $eng.craft.nextTool knife when ^The wood is ready to have more fine detail carved with a carving knife\.
action var $eng.craft.nextTool engDone when ^Applying the final touches
action goto stunPause when ^You are stunned|^After a brief flare of pain, your senses go numb and you lose all muscular control

########################
#  Variables
########################
var chapter $eng.book.chapter.%2
var cut $eng.book.cut.%2
var defaultContainer $char.eng.default.container
var engineeringContainer $char.eng.container
var page 0
var $eng.craft.numberCrafted 0
var $eng.craft.numberNeeded %1
var $eng.craft.item %2
if_3 then {
    var $eng.craft.item.design %3
}

put #script abort all except eng
put .look


########################
#  Setup
########################
if ("$righthand" <> "Empty") then {
    matchre
    put analyze $eng.craft.item
    goto checkForPartial


findCarvingDesign:
    if ($chapter = 1) then var option.length 8
    if ($chapter = 6) then var option.length 7
    if ($chapter = 7) then var option.length 30
    if ($chapter = 8) then var option.length 13
    if ($chapter = 9) then var option.length 8
    put turn my book to chapter $chapter
    var option.index 0


findCarvingDesignLoop:	  
    math option.index add 1
    if (%option.index < %option.length) then {
	    matchre matchFound %2
	    matchre findCarvingDesignLoop ^(You turn your book to page|You are already on page)
	    put turn my book to page %option.index
	    matchwait 5
    }
    goto engExit


matchFound:
    put #var page option.index
    goto engStudy


########################
# Codex Variables
########################
setDesign:
    if "%2" = "bead" then put #setvariable chapter 8;#setvariable page 2;#setvariable cut 1
    if "%2" = "totem" then put #setvariable chapter 8;#setvariable page 3;#setvariable cut 2
    if "%2" = "figurine" then put #setvariable chapter 8;#setvariable page 5;#setvariable cut 3


setDesignRace:
    var race.list human|elf|dwarf|elothean|gor'tog|halfling|s'kra mur|rakash|prydaen|gnome|kaldar
    eval race.len count("%race.list", "|")
    var race.index 0

    designRaceLoop:
        if ("%3" = "%race.list(%race.index)") then {
            put #setvariable codexChapter 1
            math race.index add 1
            put #setvariable codexPage %race.index
            goto setStore
        }
        math race.index add 1
        if (%race.index > %race.len) then {
            goto setDesignImmortal
        }
        goto designRaceLoop


setDesignImmortal:
    var immortal.list welkin|cow|owl|nightingale|wolverine|magpie|kingsnake|albatross|donkey|dove|phoenix|mongoose|jackal|raven|unicorn|wolf|panther|boar|ox|cobra|dolphin|ram|cat|wren|lion|scorpion|raccoon|adder|shrew|shrike|centaur|weasel|viper|shark|coyote|spider|heron|goshawk|vulture
    eval immortal.len count ("%immortal.list", "|")
    var immortal.index 1

    designImmortalLoop:
        if ("%3" = "%immortal.list(%immortal.index)") then {
            put #setvariable codexChapter 2
            math immortal.index add 1
            put #setvariable codexPage %immortal.index
            goto setStore
        }
        math immortal.index add 1
        if (%immortal.index > %immortal.len) then {
            goto setDesignAnimal
        }
        goto designImmortalLoop


setDesignAnimal:
    var animal.list ship's rat|boobrie|bear|wind hound|bobcat|cougar|hog|beetle|silverfish|grass eel|blood wolf|beisswurm
    eval animal.len count ("%animal.list", "|")
    var animal.index 1

    designAnimalLoop:
        if ("%3" = "%animal.list(%animal.index)") then {
            put #setvariable codexChapter 3
            math animal.index add 1
            put #setvariable codexPage %animal.index
            goto setStore
        }
        math animal.index add 1
        if (%animal.index > %animal.len) then {
            put #echo >log red Could not find that design.  Exiting.
            exit
        }
        goto designAnimalLoop


########################
# Main
########################
checkForPartial:    
    if ($nextTool <> 0) then {
	    var %2 $righthandnoun
        goto $nextTool
	    }
    }


setStore:
    put #var craftNeed %1
    put store default %engineeringContainer


engGetLumber:
    matchre engGetLumberStack ^You pick up
    matchre engMarkLumber ^You get
    matchre engExit ^What were you referring
    matchre engMarkLumber ^You are already
    put get my lumber
    matchwait 5


engGetLumberStack:
    matchre engCombine ^You get
    matchre engExit ^What were you referring
    put get my lumber from %engineeringContainer
    matchwait 5


engCombine:
    matchre engMarkLumber ^You combine the stacks
    matchre engExit ^(You need|Combine)
    put combine
    matchwait 5

engMarkLumber:
    matchre engCount ^There is not enough of the lumber
    matchre engGetScissors ^(You mark|You count)
    put mark my lumber at $cut
    matchwait 5

engCount:
    match engGetBook $cut
    matchre engNeedLumber ^You count out
    put count my lumber
    matchwait 5


engGetScissors:
    matchre engStow ^You need a free hand
    matchre engExit ^What were you
    matchre engCut ^You get
    put get my scissor
    matchwait 5


engStow:
    gosub stow left
    gosub stow right
    if ($nextTool <> 0) then {
        goto $nextTool
    }
    goto engGetLumberStack


engCut:
    put cut my lumber with my scissor
    gosub stow right
    gosub stow left
    pause
    matchre checkPageSetting ^You pick up
    matchre engExit ^What were you
    put get my lumber
    matchwait 5


checkPageSetting:
    if (%page <> 0) then {
        gosub get my shap book
        goto engStudy
    }


engGetBook:
    matchre findCarvingDesign ^(You get|You are already)
    matchre engExit ^What were you
    put get my shap book
    matchwait 5


engStudy:
    matchre engStowBook ^(You scan|You review)
    put study my book
    matchwait 5


engStowBook:
    gosub stow book
    gosub stow codex
    goto drawknife


drawknife:
    matchre engScrapeLumber ^You untie
    matchre engExit ^What were you
    put untie my drawknife on my toolbelt
    matchwait 5


codex:
    gosub tieTool
    codex2:
    matchre turnCodexChapter ^You get
    matchre engExit ^What were
    put get my codex
    matchwait 5


turnCodexChapter:
    matchre turnCodexPage ^(You turn|The codex)
    put turn my codex to chapter $codexChapter
    matchwait 5


turnCodexPage:
    matchre studyCodex ^(You turn|The codex)
    put turn my codex to page $codexPage
    matchwait 5


studyCodex:
    matchre engStowBook ^You study the codex until you
    matchre engExitxit ^What were you
    put study my codex
    matchwait 5


engScrapeLumber:
    put #var nextTool 0
    engScrapeLumber1:
    matchre codex ^You must study a design
    matchre findNextTool ^Roundtime
    put scrape my lumber with my drawknife
    matchwait 5


findNextTool:  
    if ($nextTool <> 0 ) then {
        goto $nextTool
    }
    goto errorExit


knife:
    gosub tieTool
    pause
    knife2:
    matchre engStow ^You need a free hand
    matchre carve ^You untie
    matchre engExit ^What were you
    put untie my carving knife on my toolbelt
    matchwait 5


carve:
    matchre findNextTool ^Roundtime
    matchre engDone ^Applying the final touches
    put carve my %2 with my knife
    matchwait 5

rasp:
    gosub tieTool
    pause
    rasp2:
    matchre rasp2 ^You need a free hand
    matchre scrape ^You untie
    matchre engExit ^What were you
    put untie my rasp on my toolbelt
    matchwait 5


scrape:
    matchre findNextTool ^Roundtime
    put scrape my %2 with my rasp
    matchwait 5


shaper:
    gosub tieTool
    pause
    shaper2:
    matchre engStow ^You need a free hand
    matchre shape ^You untie
    matchre engExit ^What were you
    put untie my shaper on my toolbelt
    matchwait 5


shape:
    matchre findNextTool ^Roundtime
    matchre shortCord ^You need another finished short leather cord
    matchre strips ^You need another finished leather strips
    put shape my %2 with my shaper
    matchwait 5


shortCord:
    matchre engStow ^You need a free hand
    matchre engAssemble ^You get
    matchre engExit ^What were you
    put get my short cord
    matchwait 5


strips:
    matchre engStow ^You need a free hand
    matchre engAssemble ^You get
    matchre engExit ^What were you
    put get my strips
    matchwait 5


engAssemble:
    matchre shaper ^You place your
    matchre engExit ^What were you
    put assemble my %2 with my $lefthandnoun
    matchwait 5


tieTool:
    pause
    if ("$lefthandnoun" = "shaper") then {
        put tie my $lefthandnoun to my toolbelt
    }
    else {
        put tie my $lefthand to my toolbelt
    }
    pause
    return


engStunPause:
    if ($stunned <> 0) then {
        pause 2
        goto engStunPause
    }
    if ($nextTool <> 0) then {
        gosub get my nextTool
        gosub get my %1
    }
    goto checkForPartial


########################
# Exit
########################
engDone:
    put #var nextTool 0
    gosub tieTool
    put analyze my %2
    waitfor Roundtime:
    pause
    put stow
    evalmath crafted (%crafted + 1)
    if (%crafted < $craftNeed) then {
        put #echo >log yellow [eng] Progress %crafted/$craftNeed
	    goto setStore
    }


engExit:
    put #echo >log yellow [eng] Engineering done.  Beginning .inamagic
    put store default in %defaultContainer
    put .inamagic
    exit


errorExit:
    put #echo >log red Next Tool was not found.  Exiting.
    exit


engNeedLumber:
    if ("$righthand" <> "Empty") then gosub stow
    if ("$lefthand" <> "Empty") then gosub stow left
    put #echo >log yellow [eng] Need more lumber.  Beginning .inaidle
    put store default in %defaultContainer
    put .inaidle
    put #script abort all except inaidle
    exit
