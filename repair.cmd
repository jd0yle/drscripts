include libmaster.cmd
action var repair.emptySack 0 when ^There is nothing in there\.$
action var repair.emptySack 1 ; var repair.sackItems $1 when ^In the large sack you see (.*)\.$
action var repair.waitTimeMin $1 ;evalmath repair.waitTimeSec %repair.waitTimeMin * 60 when ^.*be ready for another (\d+) roisaen\.$
action var repair.waitTimeMin 0 ; var repair.waitTimeSec 0 when ^.* be ready by now\.$
action var repair.waitTimeMin 2 ; var repair.waitTimeSec 60 when ^.* be ready any moment now\.$


###############################
###      VARIABLES
###############################
var armorLeather $char.repair.armor.leather
var armorMetal $char.repair.armor.metal
var toolMetal $char.repair.tool.metal
var toolLeather $char.repair.tool.leather
var weaponLeather $char.repair.weapon.leather
var weaponMetal $char.repair.weapon.metal

var repair.index
var repair.needMoney false
var repair.sackItems 0
var repair.ticketName 0
var repair.trash 0
var repair.waitTimeMin 0
var repair.waitTimeSec 0


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
if ($zoneid <> 1 || $zoneid <> 150 || $zoneid <> 66 || $zoneid <> 67) then {
    put #echo >Log Orange [repair] Not in a supported zone.  Must be in Crossing, Fang Cove, or Shard.
    goto repair.exit
}


gosub stow right
gosub stow left
goto repair.checkInventory
###############################
###      MAIN
###############################
repair.checkForTicket:
    gosub get my ticket
    if ("$righthandnoun" <> "ticket") then goto repair.main
    else goto repair.pickUpSpot


repair.main:
    if ($repair.forceFangCove) then {
        if ($zoneid <> 150) then {
            gosub moveToFangCove
        }
        gosub moveToFangCove
    }
    gosub repair.getMoney
    # Begin Metal Repair unless skipping for Fang Cove.
    if !(%repair.skipMetalRepair) then {
        gosub moveToRepairMetal
        gosub repair.repairAll
        gosub repair.repairWeaponMetal
        gosub repair.repairToolMetal
    }
    # Begin Leather Repair.
    gosub moveToRepairLeather
    gosub repair.repairAll
    gosub repair.repairWeaponLeather
    gosub repair.toolLeather

    # Deposit left over money.
    gosub moveToTeller
    put .deposit
    waitforre ^DEPOSIT DONE$

    # Determine wait time.
    gosub look my ticket
    if (%repair.waitTimeSec <> 0) then {
        put #echo >Log Orange [repair] Waiting %repair.waitTimeMin min to pick up.
        put .look
        pause %repair.waitTimeSec
        put #script abort look
    }

    goto repair.pickUpSpot


repair.pickUpSpot:
    matchre repair.pickUpSpotSetLocation Catrox|Randal|Lakyan|Osmandikar|Ylono|Granzer|Society
    matchre repair.exit ^I could not find what you were referring to\.$
    put look ticket
    matchwait 5


repair.pickUpSpotSetLocation:
    var repair.ticketName $1
    if ("%repair.ticketName" = "Catrox" || "%ticketName" = "Granzer") then {
        gosub moveToRepairMetal
    }
    if ("%repair.ticketName" = "Osmandikar" && repair.skipMetalRepair) then {
        gosub moveToRepairLeather
    }
    if ("%repair.ticketName" = "Osmandikar") then {
        gosub moveToRepairMetal
    }
    gosub moveToRepairLeather


    repair.pickUpLoop:
        gosub get my %ticketName ticket
        if ("$righthandnoun" = "ticket") then {
            gosub give %ticketName
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
                put #echo >Log Red [repair] There is something left in the sack.  Stowing it.  Please update repair variables for any uncaught items.
                gosub stow
            }
        } else goto repair.pickUpSpot
        goto repair.pickUpLoop


repair.checkMoney:
    put .deposit
    waitforre ^DEPOSIT DONE$
    put withdraw 50 plat
    return


repair.repairAll:
    if (contains("$roomobjs", "apprentice repairman")) then {
        var %repair.ticketName repairman
    }
    gosub ask %repair.ticketName about repair all

    if ("$righthandnoun" <> "ticket") then goto repair.repairAll
    gosub stow my ticket
    return


repair.repairWeaponMetal:
repair.repairToolMetal:
repair.repairWeaponLeather:
repair.repairToolLeather:
repair.sack:
    # Look in the sack
    # Get items
    # Wear or stow items
    # return


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
    if ($zoneid = 66) {
        if ($roomid = 71) then return
        gosub automove repair leather
        goto moveToRepairLeather
    }
    # Shard - City
    if ($zoneid = 67) then {
        gosub automove portal
        goto moveToRepairLeather
    }
    # Fang Cove
    if ($zoneid = 150) then {
        if ($roomid = 7) then return
        gosub automove repair leather
        goto moveToRepairLeather
    }
    goto moveToRepairLeather


moveToRepairMetal:
    if ("$roomname" = "Private Home Interior") then {
        put .house
        waitforre ^HOUSE DONE$
        gosub moveToRepairMetal
    }
    # Crossing - City
    if ($zoneid = 1) then {
        if ($roomid = 159) then return
        gosub automove repair metal
        goto moveToRepairMetal
    }
    # Shard - East Gate
    if ($zoneid = 66) {
        if ($roomid = 100) then return
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
        if ($roomid = 8) then return
        gosub automove repair metal
        goto moveToRepairMetal
    }
    goto moveToRepairMetal
