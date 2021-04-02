include libmaster.cmd
action goto workOrderCraftMore when ^What were you referring to\?
action var workOrderTotalNeed $1 when I need (\d+) of exceptional quality

##############
# Variables Init
##############
var orderItem %1

workOrderCount:
    matchre workOrderDoCount ^You rummage through.*?and see (.*)\.$
    gosub rummage my workbag
    matchwait 5
    goto workOrderCountDone


workOrderDoCount:
    var contents $1
    eval itemArr replace("%contents", ",", "|")
    eval itemLength count("%itemArr", "|")
    var index 0

    workOrderDoCountDoCountLoop:
        if (matchre("%itemArr(%index)", "%1")) then math numCount add 1
        math index add 1
        if (%index > %itemLength) then goto workOrderCountDone
        goto doCountLoop


workOrderCountDone:
    pause .2
    put #var workOrderTotalHave %numCount
    goto getLogbook

##############
# Main
##############
getLogbook:  
    gosub get my logbook
    goto workOrderGet
    goto getItem


workOrderGet:
    matchre workOrderBundle %1
    matchre workOrderGet Alright, this is an order for
    put ask master for hard shaping work
    matchwait 5


workOrderBundle:
    if (%workOrderTotalNeed <> 0) then {
        if (%workOrderTotalHave >= %workOrderTotalNeed) then {
            gosub get %1 from my workbag
            gosub bundle %1 with my logbook
            evalmath workOrderTotalNeed (%workOrderTotalNeed - 1)
        }
    }
    goto workOrderTurnIn

bundleItem:
    matchre readBook What were you
    matchre getItem You notate|You realize you have items bundled with the logbook
    matchre orderDone ^You have already bundled enough
    matchre workOrderdrop quality
    put bundle %1 with my logbook
    matchwait 5


workOrderdrop:
    put drop my %1
    goto getItem


readBook:
    match needMore You must bundle and deliver
    match orderDone Now give it to a crafting
    put read my logbook
    matchwait 5


workOrderCraftMore:
    put #echo >log yellow [workorder] More items needed.
    exit


orderDone:
    gosub stow my %1 in my workbag
    put give master
    gosub stow my logbook in my workbag
    put #echo >log yellow [workorder] Order completed.
    exit 5
