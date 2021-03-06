include libmaster.cmd
action var repair.emptySack 0 when ^There is nothing in there\.$
action var repair.emptySack 1 ; var repair.sackItems $1 when ^In the large sack you see (.*)\.$
action var repair.waitTimeMin $1 ;evalmath repair.waitTimeSec %repair.waitTimeMin * 60 + 60 when ^.*be ready for another (\d+) roisaen\.$
action var repair.waitTimeMin 0 ; var repair.waitTimeSec 0 when ^.* be ready by now\.$
action var repair.waitTimeMin 2 ; var repair.waitTimeSec 60 when ^.* be ready any moment now\.$
action var repair.wornArmor 1 when ^You aren't wearing anything like that\.$
action var repair.wornItem 1 when ^But that is already in your inventory\.$
action goto repair.checkForTicket when ^.*\b(not ready)\b.*$
action goto repair.forceNight when ^Bonk\! You smash your nose\.$


###############################
###      VARIABLES
###############################
var leatherList $char.repair.leather
var metalList $char.repair.metal

var repair.emptySack 0
var repair.index 0
var repair.length 0
var repair.npc 0
var repair.npcs Catrox|Randal|Lakyan|Osmandikar|Granzer|repairman|clerk
var repair.sackItems 0
var repair.ticketName 0
var repair.trash 0
var repair.waitRoomId null
var repair.waitTimeMin 0
var repair.waitTimeSec 0
var repair.wornArmor 0
var repair.wornItem 0

if ($char.repair.waitRoomId > 0) then var repair.waitRoomId $char.repair.waitRoomId

# Note:  No support for Ylono Leather Repair in Shard because of no NPC and broken automapper.
###############################
###      NECROMANCER
###############################
var repair.forceFangCove $char.repair.forceFangCove
var repair.forceRepairman false
var repair.forceNight false

if ("$guild" = "Necromancer") then {
    var repair.forceFangCove true
    if ($Time.isDay = 0) then {
        if ("$Time.timeOfDay" <> "sunrise") then {
            var repair.forceRepairman true
        }
    }
}


###############################
###      SUPPORTED ZONES
###############################
if ($zoneid <> 1 && $zoneid <> 150 && $zoneid <> 66 && $zoneid <> 67) then {
    put #echo >Log Blue [repair] Not in a supported zone.  Must be in Crossing, Fang Cove, or Shard.
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
    if ("$righthandnoun" = "ticket") then {
        gosub look my ticket
        if (%repair.waitTimeMin > 2) then {
            # Wait time is too long, skip and check for other repairs.
            gosub stow ticket
            goto repair.main
        } else {
            # Wait the two minutes and pick up everything.
            gosub repair.checkTicketTime
            gosub repair.fetchItems
        }
    } else {
        # No tickets, begin repair.
        goto repair.main
    }


repair.main:
    if (%repair.forceFangCove = true) then {
        if (%repair.forceNight = true) then {
            var repair.forceRepairman true
        } else {
            if ($Time.isDay = 0) then {
                if ("$Time.timeOfDay" <> "sunrise") then {
                    var repair.forceRepairman true
                }
            }
        }
        if ($zoneid <> 150) then {
            gosub repair.moveToFangCove
        }
        gosub repair.moveToFangCove
    }
    gosub repair.checkMoney
    # Begin Metal Repair.
    gosub repair.moveToRepairMetal
    gosub repair.repairAll
    gosub repair.repairSingle %metalList

    # Begin Leather Repair.
    gosub repair.moveToRepairLeather
    gosub repair.repairAll
    gosub repair.repairSingle %leatherList

    # Deposit left over money.
    gosub repair.moveToBank
    put .deposit
    waitforre ^DEPOSIT DONE$
    gosub repair.checkTicketTime
    goto repair.fetchItems


repair.fetchItems:
    gosub get my ticket
    if ("$righthandnoun" <> "ticket") then {
        put #echo Blue >Log Blue [repair] Repairs complete.
        goto repair.exit
    }
    if (matchre("$righthand", "(%repair.npcs)")) then {
        var repair.ticketName $1
    } else {
        var repair.ticketName clerk
    }
    if ("%repair.ticketName" = "Catrox" || "%repair.ticketName" = "Granzer") then {
        if ("%repair.ticketName" = "Catrox") then {
            gosub repair.moveToCrossing
        }
        if ("%repair.ticketName" = "Granzer") then {
            gosub repair.moveToShard
        }
        gosub repair.moveToRepairMetal
    }
    if ("%repair.ticketName" = "repairman" || "%repair.ticketName" = "Lakyan") then {
        gosub repair.moveToFangCove
        gosub repair.moveToRepairLeather
    }
    if ("%repair.ticketName" = "Osmandikar" && repair.forceRepairman = true) then {
        gosub repair.moveToFangCove
        gosub repair.moveToRepairLeather
    }
    if ("%repair.ticketName" = "Osmandikar") then {
        gosub repair.moveToFangCove
        gosub repair.moveToRepairMetal
    }
    if ("%repair.ticketName" = "clerk") then {
        gosub repair.moveToCraftHall
    }


    repair.fetchItemsLoop:
        gosub get my %repair.ticketName ticket
        if ("$righthandnoun" = "ticket") then {
            gosub give %repair.ticketName
            if ("$righthand" <> "large sack") then {
                gosub wear $righthandnoun
                gosub stow $righthandnoun
            }
            if ("$righthandnoun" = "sack") then {
                gosub repair.sack
            }
        } else {
            echo [repair] Completed all %repair.ticketName tickets.. Checking for others.
            goto repair.fetchItems
        }
        goto repair.fetchItemsLoop


###############################
###      UTILITY
###############################
repair.checkMoney:
    gosub wealth
    evalmath repair.currencyTotal $char.repair.money * 10000
    if ($zoneid = 1) then {
        evalmath repair.currencyKronars $Kronars + 0
        if (%repair.currencyKronars >= %repair.currencyTotal) then return
    }
    if ($zoneid = 66 || $zoneid = 67 || $zoneid = 150) then {
        evalmath repair.currencyDokoras $Dokoras + 0
        if (%repair.currencyDokoras >= %repair.currencyTotal) then return
    }
    gosub repair.moveToBank
    put .deposit
    waitforre ^DEPOSIT DONE$
    put withdraw $char.repair.money plat
    return


repair.checkTicketTime:
    gosub look my ticket
    if (%repair.waitTimeSec <> 0) then {
        if ("%repair.waitRoomId" != "null" && "$roomid" != "%repair.waitRoomId") then gosub automove %repair.waitRoomId
        evalmath %repair.waitTimeMin %repair.waitTimeMin + 1
        put #echo >Log Blue [repair] Waiting %repair.waitTimeMin min to pick up.
        put .look
        pause %repair.waitTimeSec
        put #script abort look
    }
    return


repair.forceNight:
    # Encountered a closed shop.
    var repair.forceNight true
    goto repair.main


repair.getNpc:
    # Check the npc for the location.
    if (matchre("$monsterlist", "(%repair.npcs)")) then {
        var repair.npc $1
    }
    return


repair.repairAll:
    gosub repair.getNpc
    if (%repair.npc = 0) then {
        put #echo >Log Blue [repair] Cannot find NPC for repairs.
        goto repair.exit
    }
    gosub ask %repair.npc about repair all
    gosub ask %repair.npc about repair all
    gosub stow my ticket
    return


repair.repairSingle:
    var repair.group $0
    if (%repair.group = 0) then return
    eval repair.length count("%repair.group", "|")
    var repair.index 0
    gosub repair.getNpc
    if (%repair.npc = 0) then {
        put #echo >Log Blue [repair] Cannot find NPC for repairs.
        goto repair.exit
    }


    repair.repairSingleLoop:
        var repair.wornItem 0
        gosub get my %repair.group(%repair.index)
        if (%repair.wornItem = 1) then {
            gosub remove my %repair.group(%repair.index)
            if ("$lefthand" = "%repair.group(%repair.index)") then {
                gosub swap
            }
        }
        if ("$righthand" = "%repair.group(%repair.index)") then {
            gosub give %repair.npc
            gosub give %repair.npc
            if (%repair.wornItem = 1) then {
                gosub wear my %repair.group(%repair.index)
            }
        }
        if ("$righthand" <> "Empty") then {
            gosub stow
        }
        math repair.index add 1
        if (%repair.index > %repair.length) then return
        goto repair.repairSingleLoop


repair.sack:
    gosub runScript empty --from=large sack
    gosub look in my large sack
    if (%repair.emptySack = 0) then {
        if (contains("$roomobjs", "bucket")) then {
            var repair.trash bucket
        }

        if (contains("$roomobjs", "bin")) then {
            var repair.trash bin
        }

        if (%repair.trash = 0) then {
            gosub drop my sack
        } else {
            gosub put my sack in %repair.trash
        }
    } else {
        put #echo >Log Red [repair] There is something left in the sack. (%repair.sackItems)  Stowing it.
        gosub stow
    }
    return


repair.exit:
    if ("$righthand" != "Empty") then gosub wear right
    if ("$lefthand" != "Empty") then gosub wear left
    gosub stow right
    gosub stow left
    pause .2
    put #parse REPAIR DONE
    exit


###############################
###      MOVE TO
###############################
repair.moveToBank:
    if (%repair.forceFangCove = true && $zoneid <> 150) then gosub repair.moveToFangCove
    # Crossing - City
    if ($zoneid = 1) then {
        if ($roomid = 231) then return
        gosub automove bank
        goto repair.moveToBank
    }
    # Shard - East Gate
    if ($zoneid = 66) then {
        gosub automove east gate
        goto repair.moveToBank
    }
    # Shard - City
    if ($zoneid = 67) then {
        if ($roomid = 145) then return
        gosub automove bank
        goto repair.moveToBank
    }
    # Fang Cove
    if ($zoneid = 150) then {
        if ($roomid = 76) then return
        gosub automove bank
        goto repair.moveToBank
    }


repair.moveToCraftHall:
    # Crossing
    if ($zoneid = 1) then {
        if ($roomid = TODO) then return
        gosub move to engineering
        goto repair.moveToCraftHall
    }
    # Shard - East Gate
    if ($zoneid = 66) then {
        gosub move to east gate
        goto repair.moveToCraftHall
    }
    # Shard - City
    if ($zoneid = 67) then {
        if ("$roomname" = "Shard Engineering Society, Bookstore") then return
        gosub move to Engineering book
        goto repair.moveToCraftHall
    }
    # Fang Cove
    if ($zoneid = 150) then {
        if ($roomid = TODO) then return
        gosub move to engineering
        goto repair.moveToCraftHall
    }
    goto repair.moveToCraftHall


repair.moveToCrossing:
    # Crossing
    if ($zoneid = 1) then {
        return
    }
    # Shard - City
    if ($zoneid = 67 || $zoneid = 66) then {
        put #echo >Log Blue [repair] We're in the wrong zone.  Found a ticket for Crossing.
        goto repair.exit
    }
    # Fang Cove
    if ($zoneid = 150) then {
        gosub automove portal
        gosub move go exit portal
        goto repair.moveToCrossing
    }
    goto repair.moveToCrossing


repair.moveToFangCove:
    if ("$roomname" = "Private Home Interior") then {
        put .house
        waitforre ^HOUSE DONE$
        goto repair.moveToFangCove
    }
    # Crossing, Shard - City, East Gate
    if ($zoneid = 1 || $zoneid = 66 || $zoneid = 67) then {
        gosub automove portal
        if ($SpellTimer.EyesoftheBlind.active = 1) then gosub release eotb
        if ($SpellTimer.RefractiveField.active = 1) then gosub release rf
        gosub move go meeting portal
        goto repair.moveToFangCove
    }
    if ($zoneid = 150) then return
    goto repair.moveToFangCove


repair.moveToRepairLeather:
    if (%repair.forceFangCove = true && $zoneid <> 150) then gosub repair.moveToFangCove
    if ("$roomname" = "Private Home Interior") then {
        put .house
        waitforre ^HOUSE DONE$
        goto repair.moveToRepairLeather
    }
    # Crossing - City
    if ($zoneid = 1) then {
        gosub automove west gate
        if ($roomid = TODO) then return
        gosub automove repair leather
        goto repair.moveToRepairLeather
    }
    # Shard - East Gate
    if ($zoneid = 66) then {
        gosub automove portal
        gosub move go meeting portal
        goto repair.moveToRepairLeather
    }
    # Shard - City
    if ($zoneid = 67) then {
        gosub automove portal
        goto repair.moveToRepairLeather
    }
    # Fang Cove
    if ($zoneid = 150) then {
        if ($roomid = 55) then return
        gosub automove repair leather
        goto repair.moveToRepairLeather
    }
    goto repair.moveToRepairLeather


repair.moveToRepairMetal:
    if (%repair.forceFangCove = true && $zoneid <> 150) then gosub repair.moveToFangCove
    if ("$roomname" = "Private Home Interior") then {
        put .house
        waitforre ^HOUSE DONE$
        gosub repair.moveToRepairMetal
    }
    # Crossing - City
    if ($zoneid = 1) then {
        #TODO FIX ROOM
        if ($roomid = 159) then return
        gosub automove repair metal
        goto repair.moveToRepairMetal
    }
    # Shard - East Gate
    if ($zoneid = 66) then {
        if ($roomid = 212) then return
        gosub automove repair metal
        goto repair.moveToRepairMetal
    }
    # Shard - City
    if ($zoneid = 67) then {
        gosub automove portal
        goto repair.moveToRepairMetal
    }
    # Fang Cove
    if ($zoneid = 150) then {
        if (%repair.forceRepairman = true) then {
            if ($roomid = 55) then return
            gosub automove repair leather
            goto repair.moveToRepairMetal
        }
        if ($roomid = 54) then return
        gosub automove repair metal
        goto repair.moveToRepairMetal
    }
    goto repair.moveToRepairMetal


repair.moveToShard:
    # Crossing
    if ($zoneid = 1) then {
        put #echo >Log Blue [repair] We're in the wrong zone.  Ticket for Shard found.
        goto repair.exit
    }
    # Shard - City
    if ($zoneid = 67) then {
        gosub automove portal
        goto repair.moveToShard
    }
    #Shard - East Gate
    if ($zoneid = 66) then {
        return
    }
    # Fang Cove
    if ($zoneid = 150) then {
        gosub automove portal
        gosub move go exit portal
        goto repair.moveToShard
    }
    goto repair.moveToShard