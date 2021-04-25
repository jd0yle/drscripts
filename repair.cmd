include libmaster.cmd
action var repair.emptySack 0 when ^There is nothing in there\.$
action var repair.emptySack 1 ; var repair.sackItems $1 when ^In the large sack you see (.*)\.$
action var repair.waitTimeMin $1 ;evalmath repair.waitTimeSec %repair.waitTimeMin * 60 + 60 when ^.*be ready for another (\d+) roisaen\.$
action var repair.waitTimeMin 0 ; var repair.waitTimeSec 0 when ^.* be ready by now\.$
action var repair.waitTimeMin 2 ; var repair.waitTimeSec 60 when ^.* be ready any moment now\.$
action var repair wornArmor 1 when ^You aren't wearing anything like that\.$

###############################
###      VARIABLES
###############################
var leatherList $char.repair.leather
var metalList $char.repair.metal

var repair.metalList %armorMetal|%toolMetal
var repair.index 0
var repair.length 0
var repair.npc 0
var repair.npcs Catrox|Randal|Lakyan|Osmandikar|Granzer|repairman|clerk
var repair.sackItems 0
var repair.ticketName 0
var repair.trash 0
var repair.waitTimeMin 0
var repair.waitTimeSec 0
var repair.wornArmor 0

# Note:  No support for Ylono Leather Repair in Shard because of no NPC and broken automapper.
###############################
###      NECROMANCER
###############################
var repair.forceFangCove false
var repair.skipMetalRepair false

if ("$guild" = "Necromancer") then {
    var repair.forceFangCove true
    if ($Time.isDay = 0) then {
        var repair.skipMetalRepair true
        put #echo >Log Orange [repair] Metal repair skipped due to night.
    }
}


###############################
###      SUPPORTED ZONES
###############################
if ($zoneid <> 1 && $zoneid <> 150 && $zoneid <> 66 && $zoneid <> 67) then {
    put #echo >Log Orange [repair] Not in a supported zone.  Must be in Crossing, Fang Cove, or Shard.
    goto repair.exit
}


gosub stow right
gosub stow left
goto repair.checkForTicket
###############################
###      MAIN
###############################
repair.checkForTicket:
    gosub get my ticket
    if ("$righthandnoun" <> "ticket") then goto repair.main
    else {
        goto repair.fetchItems
    }


repair.main:
    if (%repair.forceFangCove = true) then {
        if ($zoneid <> 150) then {
            gosub moveToFangCove
        }
        gosub moveToFangCove
    }
    gosub repair.checkMoney
    # Begin Metal Repair unless skipping for Fang Cove.
    if !(%repair.skipMetalRepair) then {
        gosub moveToRepairMetal
        gosub repair.repairAll
        gosub repair.repairSingle %metalList
    }
    # Begin Leather Repair.
    gosub moveToRepairLeather
    gosub repair.repairAll
    gosub repair.repairSingle %leatherList

    # Deposit left over money.
    gosub moveToBank
    put .deposit
    waitforre ^DEPOSIT DONE$

    # Determine wait time.
    gosub look my ticket
    if (%repair.waitTimeSec <> 0) then {
        evalmath %repair.waitTimeMin %repair.waitTimeMin + 1
        put #echo >Log Orange [repair] Waiting %repair.waitTimeMin min to pick up.
        put .look
        pause %repair.waitTimeSec
        put #script abort look
    }

    goto repair.fetchItems


repair.fetchItems:
    gosub get my ticket
    if ("$righthandnoun" <> "ticket") then goto repair.exit
    if (matchre("$righthand", "(%repair.npcs)")) then {
        var repair.ticketName $1
    } else {
        var repair.ticketName clerk
    }
    if ("%repair.ticketName" = "Catrox" || "%repair.ticketName" = "Granzer") then {
        gosub moveToRepairMetal
    }
    if ("%repair.ticketName" = "Osmandikar" && repair.skipMetalRepair) then {
        gosub moveToRepairLeather
    }
    if ("%repair.ticketName" = "Osmandikar") then {
        gosub moveToRepairMetal
    }
    if ("%repair.ticketName" = "clerk") then {
        gosub moveToCraftHall
    }


    repair.fetchItemsLoop:
        gosub get my %repair.ticketName ticket
        if ("$righthandnoun" = "ticket") then {
            gosub give %repair.ticketName
            if ("$righthand" <> "large sack") then {
                gosub wear $righthandnoun
                gosub stow $righthandnoun
            }
            if ("$righthandnoun" = "sack") then gosub repair.sack
            gosub look in my large sack
            if (%repair.emptySack = 0) then {
                if (contains("$roomobjs", "bucket")) then var repair.trash bucket
                if (contains("$roomobjs", "bin")) then var repair.trash bin
                if (%repair.trash = 0) then gosub drop my sack
                else gosub put my sack in %repair.trash
            } else {
                put #echo >Log Red [repair] There is something left in the sack.  Stowing it.
                gosub stow
            }
        } else {
            goto repair.fetchItems
        }
        goto repair.fetchItemsLoop


repair.checkMoney:
    evalmath repair.currencyTotal $char.repair.money * 10000
    if ($zoneid = 1) then {
        evalmath repair.currencyKronars $Kronars + 0
        if (%repair.currencyKronars >= %repair.currencyTotal) then return
    }
    if ($zoneid = 66 || $zoneid = 67 || $zoneid = 150) then {
        evalmath repair.currencyDokoras $Dokoras + 0
        if (%repair.currencyDokoras >= %repair.currencyTotal) then return
    }
    gosub moveToBank
    put .deposit
    waitforre ^DEPOSIT DONE$
    put withdraw $char.repair.money plat
    return


repair.repairAll:
    gosub repair.getNpc
    if (%repair.npc = 0) then {
        put #echo >Log [repair] Cannot find NPC for repairs.
        goto repair.exit
    }
    gosub ask %repair.npc about repair all
    gosub ask %repair.npc about repair all
    gosub stow my ticket
    return


repair.getNpc:
    # Check the npc for the location.
    if (matchre("$monsterlist", "(%repair.npcs)")) then {
        var repair.npc $1
    }
    return


repair.repairSingle:
    var repair.group $0
    if (%repair.group = 0) then return
    eval repair.length count("%repair.group", "|")
    var repair.index 0
    gosub repair.getNpc
    if (%repair.npc = 0) then {
        put #echo >Log [repair] Cannot find NPC for repairs.
        goto repair.exit
    }


    repair.repairSingleLoop:
        gosub get my %repair.group(%repair.index)
        if ("$righthand" = "%repair.group(%repair.index)") then {
            gosub give %repair.npc
            gosub give %repair.npc
            gosub stow
        }
        math repair.index add 1
        if (%repair.index > %repair.length) then return
        goto repair.repairSingleLoop


repair.sack:
    put .empty large sack
    waitforre ^EMPTY DONE$
    return


repair.exit:
    pause .2
    put #parse REPAIR DONE
    exit


###############################
###      MOVE TO
###############################
moveToFangCove:
    if ("$roomname" = "Private Home Interior") then {
        put .house
        waitforre ^HOUSE DONE$
        goto moveToFangCove
    }
    # Crossing, Shard - City, East Gate
    if ($zoneid = 1 || $zoneid = 66 || $zoneid = 67) then {
        gosub automove portal
        if ($SpellTimer.EyesoftheBlind.active = 1) then gosub release eotb
        if ($SpellTimer.RefractiveField.active = 1) then gosub release rf
        gosub move go meeting portal
        goto moveToFangCove
    }
    if ($zoneid = 150) then return
    goto moveToFangCove


moveToRepairLeather:
    if (%repair.forceFangCove = true && $zoneid <> 150) then gosub moveToFangCove
    if ("$roomname" = "Private Home Interior") then {
        put .house
        waitforre ^HOUSE DONE$
        goto moveToRepairLeather
    }
    # Crossing - City
    if ($zoneid = 1) then {
        gosub automove west gate
        if ($roomid = TODO) then return
        gosub automove repair leather
        goto moveToRepairLeather
    }
    # Shard - East Gate
    if ($zoneid = 66) then {
        gosub automove portal
        gosub move go meeting portal
        goto moveToRepairLeather
    }
    # Shard - City
    if ($zoneid = 67) then {
        gosub automove portal
        goto moveToRepairLeather
    }
    # Fang Cove
    if ($zoneid = 150) then {
        if ($roomid = 55) then return
        gosub automove repair leather
        goto moveToRepairLeather
    }
    goto moveToRepairLeather


moveToRepairMetal:
    if (%repair.forceFangCove = true && $zoneid <> 150) then gosub moveToFangCove
    if ("$roomname" = "Private Home Interior") then {
        put .house
        waitforre ^HOUSE DONE$
        gosub moveToRepairMetal
    }
    # Crossing - City
    if ($zoneid = 1) then {
        #TODO FIX ROOM
        if ($roomid = 159) then return
        gosub automove repair metal
        goto moveToRepairMetal
    }
    # Shard - East Gate
    if ($zoneid = 66) then {
        if ($roomid = 212) then return
        gosub automove repair metal
        goto moveToRepairMetal
    }
    # Shard - City
    if ($zoneid = 67) then {
        gosub automove portal
        goto moveToRepairMetal
    }
    # Fang Cove
    if ($zoneid = 150) then {
        if (%repair.skipMetalRepair = true) then {
            gosub automove repair leather
            return
        }
        if ($roomid = 54) then return
        gosub automove repair metal
        goto moveToRepairMetal
    }
    goto moveToRepairMetal


moveToBank:
    if (%repair.forceFangCove = true && $zoneid <> 150) then gosub moveToFangCove
    # Crossing - City
    if ($zoneid = 1) then {
        if ($roomid = 231) then return
        gosub automove bank
        goto moveToBank
    }
    # Shard - East Gate
    if ($zoneid = 66) then {
        gosub automove east gate
        goto moveToBank
    }
    # Shard - City
    if ($zoneid = 67) then {
        if ($roomid = 145) then return
        gosub automove bank
        goto moveToBank
    }
    # Fang Cove
    if ($zoneid = 150) then {
        if ($roomid = 76) then return
        gosub automove bank
        goto moveToBank
    }
