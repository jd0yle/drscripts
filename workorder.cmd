include libmaster.cmd
action goto workOrderBadQuality when ^The work order requires items of a higher quality, so you decide against bundling that\.|^Only completed items can be bundled with the work order\.
action var workOrderBundleSuccess 1 when ^waitforre ^You notate the $char.craft.item in the logbook then bundle it up for delivery\.
action goto workOrderDone when ^What were you referring to\?
action var workOrderTotalNeed $1 when I need (\d+) of exceptional quality
action var workOrderTotalNeed $1 when You must bundle and deliver (\d+)(.*)\.$
action var workOrderTotalNeed 0 when This work order appears to be complete\.
action var workOrderMaster $3 when ^You also see(.*)Engineering(.*)(Master|Mistress)(.*)\.$
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
    matchre workOrderDoCount ^You rummage through.*?and see (.*)\.$
    gosub rummage my $char.craft.container
    matchwait 5
    goto workOrderCountDone


workOrderDoCount:
    var contents $1
    eval itemArr replace("%contents", ",", "|")
    eval itemLength count("%itemArr", "|")
    var index 0
    var numCount 0

    workOrderDoCountDoCountLoop:
        if (matchre("%itemArr(%index)", "$char.craft.item")) then math numCount add 1
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
    var workOrderLocation workOrderGet
    if (%workOrderTotalHave < 3) then {
        gosub stow my logbook
        goto workOrderRestock
    }
    pause 1
    workOrderGet1:
    matchre workOrderBundle $char.craft.item
    matchre workOrderGet Alright, this is an order for
    matchre workOrderRead ^You realize you have items bundled with the logbook
    matchre workOrderFindMaster ^Usage: ASK
    put ask %workOrderMaster for hard shaping work
    matchwait 5


workOrderBundle:
    if (%workOrderTotalNeed <> 0) then {
        if (%workOrderTotalHave >= %workOrderTotalNeed) then {
            gosub get $char.craft.item from my $char.craft.container
            gosub bundle $char.craft.item with my logbook
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
    gosub drop my $char.craft.item
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
            gosub put my lumber in my $char.craft.container
            put #echo >log yellow [workorder] Lumber count: %workOrderLumberHave.
            goto workOrderDone
        }
        put #echo >log yellow [workorder] Lumber restocked to %workOrderLumberHave.
        goto workOrderDone


##############
# Exit and Log
##############
workOrderDone:
    gosub put my logbook in my $char.craft.container
    if (%workOrderTotalHave < %workOrderTotalNeed) then {
        put #echo >log yellow [workorder] More items needed. (%workOrderTotalHave/%workOrderTotalNeed)
    } else {
        put #echo >log yellow [workorder] Unable to turn in more orders. %workOrderTotalHave remaining in $char.craft.container.
    }
    exit
