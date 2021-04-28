include libmaster.cmd
action var repair.waitTimeMin $1 ;evalmath repair.waitTimeSec %repair.waitTimeMin * 60 when ^.*be ready for another (\d+) roisaen\.$
action var repair.waitTimeMin 0 ; var repair.waitTimeSec 0 when ^.* be ready by now\.$
action var repair.waitTimeMin 2 ; var repair.waitTimeSec 60 when ^.* be ready any moment now\.$

################
# Variables Init
################
var craftTools carving knife|shaper|rasp|drawknife|stamp
var craftToolsLength 4
var craftToolsIndex 0
var repair.npc clerk
var repair.TargetRoom engineering books
var repair.waitTimeMin 0
var repair.waitTimeSec 0


goto repairNeedMoney
################
# Money
################
repairNeedMoney:
    put wealth
    if ($Dokoras < 30000) then {
        put .deposit
        waitforre ^DEPOSIT DONE
        put withdraw 3 plat
    }
    if ($zoneid = 67) then {
        if ($roomid <> 718) then gosub automove engineering book
    }
    goto repairRoomCheck


################
# Checks
################
repairRoomCheck:
    if ("$roomname" = "Catrox's Forge, Entryway") then var repair.npc Catrox
    if ("$roomname" = "Shard Engineering Society, Bookstore") then var repair.npc clerk


repairCheckTicket:
    gosub get my ticket
    if ("$righthandnoun" <> "ticket") then {
        goto repairGetTool
    }


    repairCheckTicketLoop:
    gosub get my ticket
    if ($righthandnoun = "ticket") then {
        gosub give %repair.npc
        if ("$righthandnoun" = "ticket") then {
            gosub stow ticket
            goto repair.checkTime
        }
        if ("$righthandnoun" = "stamp") then {
            gosub put my stamp in my workbag
        } else gosub tie my $righthandnoun to my toolbelt
        pause
        goto repairCheckTicketLoop
    } else {
        goto repairExit
    }


################
# Repair
################
repairGetTool:
    if (%craftTools(%craftToolsIndex) = null || %craftToolsIndex >= $craftToolsLength) then {
        goto repair.checkTime
    }
    if ("%craftTools(%craftToolsIndex)" = "stamp") then {
        gosub get my stamp
    } else gosub untie %craftTools(%craftToolsIndex) from my toolbelt

    if ($righthandnoun <> null) then {
        gosub give %repair.npc
        gosub give %repair.npc
        gosub stow my ticket
        goto repairNextTool
    } else {
        math craftToolsIndex add 1
        goto repairGetTool
    }


repairToolSkip:
    matchre repairNextTool ^You tie
    gosub tie my $righthandnoun to my toolbelt
    matchwait 5


repairNextTool:
    math craftToolsIndex add 1
    if (%craftToolsIndex > %craftToolsLength) then goto repair.checkTime
    goto repairGetTool


repair.checkTime:
    gosub look my ticket
    put .look
    if (%repair.waitTimeMin <> 0) then {
        evalmath %repair.waitTimeSec %repair.waitTimeSec + 60
        evalmath %repair.waitTimeMin %repair.waitTimeMin + 1
    }
    pause %repair.waitTimeSec
    put #echo >Log Yellow [repairtool] Waiting %repair.waitTimeMin minutes (%repair.waitTimeSec seconds) for tools.
    put #script abort look
    goto repairCheckTicket


repairExit:
    if ($Dokoras <> 0) then {
        put .deposit
        waitforre ^DEPOSIT DONE$
    }
    put #var eng.repairNeeded 0
    pause .2
    put #parse REPAIRTOOL DONE
    put #echo >Log Yellow [repairtool] Tools repaired.
    exit