include libmaster.cmd
include var_engineer.cmd
##############################
### Engineering
### USAGE: .eng <number> <item> [design]
###    EX: .eng 3 bead weasel
###############################
###############################
###    IDLE ACTION VARIABLES
###############################
action var eng.craft.nextTool shaper when ^Shaping with a wood shaper is needed to further smooth the material's surface\.
action var eng.craft.nextTool rasp when ^A bulbous knot will make continued shaping difficult unless rubbed out with a rasp\.
action var eng.craft.nextTool knife when ^The wood is ready to have more fine detail carved with a carving knife\.
action var eng.craft.nextTool engDone when ^Applying the final touches
action var eng.lumber $1 when ^You count out (\d+) pieces of lumber remaining\.$
action goto eng.cord when ^You need another finished short leather cord
action goto eng.strip when ^You need another finished leather strips
action goto eng.analyze when ^Applying the final touches
action goto eng.repairTools when ^The stamp is too badly damaged to be used for that\.$
action goto stunPause when ^You are stunned|^After a brief flare of pain, your senses go numb and you lose all muscular control


###############################
###    VARIABLES
###############################
put #tvar eng.craft.item %2
put #tvar eng.craft.item.design 0
if_3 then {
    put #tvar eng.craft.item.design %3
}

var eng.chapter 0
var eng.chapterLength 0
var eng.craft.nextTool 0
var eng.craft.numberCrafted 0
var eng.craft.numberNeeded %1
var eng.cut 0
var eng.page 0

put .look
gosub store default $char.craft.container
goto eng.finishItem


###############################
###    SETUP
###############################
eng.finishItem:
    if ("$righthand" <> "Empty" && "$righthandnoun" = "$eng.craft.item") then {
        matchre eng.exitError ^Roundtime
        matchre eng.setNextTool (shaper|rasp|knife|cord|strap)
        put analyze $eng.craft.item
        matchwait 5
    }
    goto eng.checkLumber


eng.setNextTool:
    var eng.craft.nextTool $1
    if (%eng.craft.nextTool = 0) then {
        put #echo >Log Yellow [eng] Unable to determine next tool for $righthand, exiting.
        gosub stow
        goto eng.exit
    }
    gosub eng.mainLoop


eng.checkLumber:
    matchre eng.lumberCount ^In the.*\b(lumber)\b.*$
    matchre eng.needLumberExit ^In the.*?you see (.*)\.$
    gosub look in my $char.craft.container
    matchwait 5


eng.lumberCount:
    gosub count my lumber
    if (%eng.cut = 0) then {
        var eng.cut $eng.book.cut.$eng.craft.item
    }
    if (%eng.lumber < %eng.cut) then {
        goto eng.needLumberExit
    }
    goto eng.prepareLumber


eng.prepareLumber:
    gosub get my lumber
    if (%eng.lumber <> %eng.cut) then {
        gosub mark my lumber at %eng.cut
        gosub get my scissors
        if ("$lefthandnoun" <> "scissors") then {
            put #echo >Log Orange [eng] Scissors are missing, exiting.
            gosub stow
            goto eng.exit
        }
        gosub cut my lumber with my scissor
        gosub stow
        gosub stow left
        gosub get my lumber
    }
    goto eng.prepareItem


eng.prepareItem:
    gosub get my shaping book
    if ("$lefthandnoun" <> "book") then {
        echo lefthandnoun: $lefthandnoun
        put #echo >Log Orange [eng] Missing our shaping book, exiting.
        gosub stow
        goto eng.exit
    }
    gosub eng.findChapter
    gosub turn my book to chapter %eng.chapter
    # Action for finding book page because genie is dumb.
    if ("$eng.craft.item" = "burin") then {
        action var eng.page $1 when ^.*?Page (\d+)\: (a|an|some) fine wood $eng.craft.item(.*)$
    } else {
        action var eng.page $1 when ^.*?Page (\d+)\: (a|an|some) (articulated|detailed|pair of)? wood $eng.craft.item(.*)$
    }
    gosub read my book
    if (%eng.page = 0) then {
        put #echo >Log Yellow [eng] Could not locate page for $eng.craft.item, exiting.
        goto eng.exit
    }
    gosub turn my book to page %eng.page
    gosub study my book
    gosub stow my book
    if ($eng.craft.item.design <> 0) then {
        goto eng.prepareDesign
    }
    goto eng.main


# Use the defined craft item name to find the chapter and cut number.
eng.findChapter:
    var eng.chapter 0
    var eng.chapterGroup 0
    if (contains("($eng.book.basics)", "$eng.craft.item")) then {
        var eng.chapter 1
        var eng.chapterGroup basics
    }
    if (contains("($eng.book.enhancements)", "$eng.craft.item")) then {
        if (%eng.chapter = 0) then {
            var eng.chapter 6
            var eng.chapterGroup enhancements
        }
    }
    if (contains("($eng.book.accessories)", "$eng.craft.item")) then {
        if (%eng.chapter = 0) then {
            var eng.chapter 7
            var eng.chapterGroup accessories
        }
    }
    if (contains("($eng.book.images)", "$eng.craft.item")) then {
        if (%eng.chapter = 0) then {
            var eng.chapter 8
            var eng.chapterGroup images
        }
    }
    if (contains("($eng.book.weaponry)", "$eng.craft.item")) then {
        if (%eng.chapter = 0) then {
            var eng.chapter 9
            var eng.chapterGroup weaponry
        }
    }
    if (%eng.chapter = 0) then {
        put #echo >Log Yellow [eng] Failed to find design for $eng.craft.item, exiting.
        goto eng.exit
    }
    if (%eng.cut = 0) then {
        var eng.cut $eng.book.cut.$eng.craft.item
    }
    return


eng.prepareDesign:
    var eng.chapter 0
    var eng.page 0
    gosub get my codex
    if ("$lefthandnoun" <> "codex") then {
        put #echo >Log Orange [eng] Design codex is missing, exiting.
        gosub stow
        goto eng.exit
    }
    if (contains("($eng.codex.races)", "$eng.craft.item.design")) then {
        var eng.chapter 1
    }
    if (contains("($eng.codex.immortals)", "$eng.craft.item.design")) then {
        if (%eng.chapter = 0) then {
            var eng.chapter 2
        }
    }
    if (contains("($eng.codex.animals)", "$eng.craft.item.design")) then {
        if (%eng.chapter = 0) then {
            var eng.chapter 3
        }
    }
    if (%eng.chapter = 0) then {
        put #echo >Log [eng] Failed to find design $eng.craft.item.design.
        goto eng.exit
    }    
    gosub turn my codex to chapter %eng.chapter
    # Action for finding codex page because genie is dumb.
    action var eng.page $1 when ^.*?Page (\d+)\: $eng.craft.item.design(.*)$
    gosub read my codex
    if (%eng.page = 0) then {
        put #echo >Log Yellow [eng] Could not locate page for $eng.craft.item.design, exiting.
        goto eng.exit
    }
    gosub turn my codex to page %eng.page
    gosub study my codex
    gosub stow my codex
    goto eng.main


###############################
###    MAIN
###############################
eng.main:
    if ("$lefthandnoun" <> "drawknife") then {
        gosub stow left
        gosub get my drawknife
    }
    if ("$lefthandnoun" <> "drawknife") then {
        put #echo >Log Orange [eng] Drawknife missing!
        gosub stow left
        goto eng.exit
    }
    gosub scrape my lumber with my drawknife
    gosub stow my drawknife


    eng.mainLoop:
        var eng.lastTool 0
        if (%eng.craft.nextTool = 0) then {
            put #echo >Log Yellow [eng] Unable to determine what the next tool is.  Please fix script.
            gosub stow
            gosub stow left
            goto eng.exit
        }
        if ("$lefthand" <> "Empty") then {
            gosub stow left
        }
        if ("%eng.craft.nextTool" = "knife") then {
            gosub get my carving knife
        } else {
            gosub get my %eng.craft.nextTool
        }
        if ("$lefthandnoun" = "Empty") then {
            put #echo >Log Orange [eng] Tool missing!  (%eng.craft.nextTool)
            gosub stow left
            goto eng.exit
        }
        var eng.lastTool %eng.craft.nextTool
        var eng.craft.nextTool 0
        gosub eng.%eng.lastTool
        goto eng.mainLoop


###############################
###    UTILITY
###############################
eng.analyze:
    gosub stow left
    if ("$righthandnoun" = "$char.craft.workorder.item") then {
        gosub eng.stamp
    }
    gosub analyze $righthandnoun
    gosub stow
    evalmath eng.craft.numberCrafted (%eng.craft.numberCrafted + 1)
    if (%eng.craft.numberNeeded > %eng.craft.numberCrafted) then {
        put #echo >log Yellow [eng] Progress %eng.craft.numberCrafted/%eng.craft.numberNeeded
        goto eng.checkLumber
    }
    goto eng.exit


eng.cord:
    if ("$lefthand" <> "cord") then {
        gosub stow left
        gosub get my cord
    }
    if ("$lefthandnoun" <> "cord") then {
        put #echo >Log Yellow [eng] Need cord to finish $eng.craft.item, exiting.
        gosub stow
        goto eng.exit
    }
    gosub assemble my $eng.craft.item with cord
    return


eng.knife:
    if ("$lefthand" <> "knife") then {
        gosub stow left
        gosub get my carving knife
    }
    if ("$lefthandnoun" <> "knife") then {
        put #echo >Log Orange [eng] Carving knife missing!
        gosub stow
        goto eng.exit
    }
    gosub carve my $eng.craft.item with my carving knife
    gosub stow left
    return


eng.rasp:
    if ("$lefthandnoun" <> "rasp") then {
        gosub stow left
        gosub get my rasp
    }
    if ("$lefthandnoun" <> "rasp") then {
        put #echo >Log Orange [eng] Rasp missing!
        gosub stow
        goto eng.exit
    }
    gosub scrape my $eng.craft.item with my rasp
    gosub stow left
    return


eng.repairTools:
    if ("$lefthand" <> "Empty" || "$righthand" <> "Empty") then {
        gosub stow
        gosub stow left
    }
    put #var eng.repairNeeded 1
    put #echo >log Pink [eng] Stamp is broken.  Repair your tools.
    goto eng.exit


eng.shaper:
    if ("$lefthandnoun" <> "shaper") then {
        gosub stow left
        gosub get my wood shaper
    }
    if ("$lefthandnoun" <> "shaper") then {
        put #echo >Log Orange [eng] Wood shaper missing!
        gosub stow
        goto eng.exit
    }
    gosub shape my $eng.craft.item with my shaper
    gosub stow left
    return


eng.stamp:
    if ($eng.repairNeeded = 1) then {
        return
    }
    if ("$lefthand" <> "stamp") then {
        gosub stow left
        gosub get my stamp
    }
    if ("$lefthand" = "Empty") then {
        put #echo >Log Orange [eng] Stamp is missing!
        return
    }
    gosub mark my $eng.craft.item with my stamp
    gosub stow stamp
    return


eng.strap:
    if ("$lefthand" <> "strap") then {
        gosub stow left
        gosub get my strap
    }
    if ("$lefthandnoun" <> "strap") then {
        put #echo >Log Yellow [eng] Need strap to finish $eng.craft.item, exiting.
        gosub stow
        goto eng.exit
    }
    gosub assemble my $eng.craft.item with strap
    return


eng.stunPause:
    if ($stunned <> 0) then {
        pause 2
        goto engStunPause
    }
    if (%eng.craft.nextTool <> 0) then {
        gosub get my %eng.craft.nextTool
        gosub get my $eng.craft.item
    }
    goto eng.finishItem


###############################
###    EXIT
###############################
eng.exit:
    put #var inauri.subScript 0
    if ("$righthand" <> "Empty" || "$lefthand" <> "Empty") then {
        gosub stow
        gosub stow left
    }
    put #echo >log yellow [eng] Engineering done.
    gosub store default $char.craft.default.container

    pause .2
    put #parse ENGINEER DONE
    exit


eng.exitError:
    put #echo >Log Yellow [eng] Unable to determine next tool for $righthand.
    goto eng.exit


eng.needLumberExit:
    if ("$righthand" <> "Empty" || "$lefthand" <> "Empty") then {
        gosub stow
        gosub stow left
    }
    put #var eng.needLumber 1
    put #echo >log yellow [eng] Need more lumber.
    gosub store default $char.craft.default.container
    goto eng.exit
