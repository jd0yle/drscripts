include libmaster.cmd
action goto workOrderBadQuality when ^The work order requires items of a higher quality, so you decide against bundling that\.|^Only completed items can be bundled with the work order\.
action var workOrderBundleSuccess 1 when ^waitforre ^You notate the $char.craft.workorder.item in the logbook then bundle it up for delivery\.
action goto workOrderDone when ^What were you referring to\?
action var workOrderTotalNeed $1 when I need (\d+) of (exceptional|superior) quality
action var workOrderTotalNeed $1 when You must bundle and deliver (\d+)(.*)\.$
action var workOrderTotalNeed 0 when This work order appears to be complete\.
#action var workOrderMaster $3 when ^You also see(.*)Engineering(.*)(Master|Mistress)(\S+)(.*)\.$
action var workOrderMaster Brogir when ^You also see(.*)Engineering Society Master Brogir(.*)\.$
action var workOrderMasterHuntLocation $1 when (\d+)(.*)Engineering(.*)(Master|Mistress)(.*)$
action var workOrderLumberHave $1 when ^You count out (\d+) pieces of lumber remaining\.$

##############
# Variables Init
##############
var orderItem %1
gosub look
if ("%workOrderMaster" = null) then {
    var workOrderLocation workOrderCount
    goto workOrderFindMaster
}


workOrderCount:
    matchre workOrderDoCount ^In the.*?you see (.*)\.$
    gosub look in my $char.inv.container.craft
    matchwait 5
    goto workOrderCountDone


workOrderDoCount:
    var contents $1
    eval itemArr replace("%contents", ",", "|")
    eval itemLength count("%itemArr", "|")
    var index 0
    var numCount 0

    workOrderDoCountDoCountLoop:
        if (matchre("%itemArr(%index)", "\b$char.craft.workorder.item\b")) then math numCount add 1
        math index add 1
        if (%index > %itemLength) then goto workOrderCountDone
        goto workOrderDoCountDoCountLoop


workOrderCountDone:
    pause .2
    var workOrderTotalHave %numCount
    goto getLogbook


##############
# Main
##############
getLogbook:  
    gosub get my logbook
    goto workOrderGet
    goto getItem


workOrderGet:
    if !(contains("$roomobjs", "Master") || contains("$roomobjs", "Mistress")) then {
        goto workOrderFindMaster
    }
    var workOrderLocation workOrderGet
    if (%workOrderTotalHave < 3) then {
        gosub stow my logbook
        goto workOrderRestock
    }
    pause .2
    var location workOrderGet1
    workOrderGet1:
    matchre workOrderBundle $char.craft.workorder.item
    matchre workOrderGet Alright, this is an order for
    matchre workOrderRead ^You realize you have items bundled with the logbook
    matchre workOrderFindMaster ^Usage: ASK
    put ask %workOrderMaster for hard shaping work
    goto retry


workOrderBundle:
    if (%workOrderTotalNeed <> 0) then {
        if (%workOrderTotalHave >= %workOrderTotalNeed) then {
            gosub get $char.craft.workorder.item from my $char.inv.container.craft
            gosub bundle my $char.craft.workorder.item with my logbook
            evalmath workOrderTotalNeed (%workOrderTotalNeed - 1)
            evalmath workOrderTotalHave (%workOrderTotalHave - 1)
        } else {
            goto workOrderDone
        }
    } else {
        goto workOrderTurnIn
    }
    goto workOrderBundle


workOrderTurnIn:
    var workOrderLocation workOrderTurnIn
    workOrderTurnIn1:
    matchre workOrderGet ^You hand
    matchre workOrderFindMaster ^What is it you're trying to give\?
    put give %workOrderMaster
    matchwait 5


##############
# Utility
##############
workOrderBadQuality:
    gosub drop my $char.craft.workorder.item
    evalmath workOrderTotalNeed (%workOrderTotalNeed + 1)
    goto workOrderBundle


workOrderFindMaster:
    gosub hunt
    if (%workOrderMasterHuntLocation <> 0) then {
        gosub hunt %workOrderMasterHuntLocation
    }
    if ("%workOrderLocation" = "workOrderTurnIn") then {
        goto workOrderTurnIn
    }
    if ("%workOrderLocation" = "workOrderGet") then {
        goto workOrderGet
    }
    goto workOrderCount


workOrderRead:
    gosub read my logbook
    if (%workOrderTotalNeed <> 0) then {
        goto workOrderBundle
    }
    goto workOrderTurnIn


workOrderRestock:
    gosub automove engineering supplies
    if ("$righthand" <> "Empty" && "$lefthand" <> "Empty") then {
        gosub stow
        gosub stow left
    }
    var workOrderLumberHave 0
    gosub count my lumber
    if (%workOrderLumberHave <> 0 && %workOrderLumberHave < 65) then {
        gosub get my lumber
    }
    workOrderRestockLoop:
        if (%workOrderLumberHave < 65) then {
            gosub order 11
            gosub order 11
            gosub combine
            math workOrderLumberHave add 10
            goto workOrderRestockLoop
        } else {
            gosub put my lumber in my $char.inv.container.craft
            put #echo >log yellow [workorder] Lumber count: %workOrderLumberHave.
            goto workOrderDone
        }
        put #echo >log yellow [workorder] Lumber restocked to %workOrderLumberHave.
        goto workOrderDone


##############
# Exit and Log
##############
workOrderDone:
    if ("$righthandnoun" = "logbook") then {
        gosub put my logbook in my $char.inv.container.craft
    }
    if (%workOrderTotalHave < %workOrderTotalNeed) then {
        put #echo >log yellow [workorder] More items needed. (%workOrderTotalHave/%workOrderTotalNeed)
    } else {
        put #echo >log yellow [workorder] Unable to turn in more orders. %workOrderTotalHave remaining in $char.inv.container.craft.
    }

    pause .2
    put #parse WORKORDER DONE
    exit
