include libmaster.cmd
action goto workOrderBadQuality when ^The work order requires items of a higher quality, so you decide against bundling that\.
action goto workOrderCraftMore when ^What were you referring to\?
action var workOrderTotalNeed $1 when I need (\d+) of exceptional quality

##############
# Variables Init
##############
var orderItem %1

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

    workOrderDoCountDoCountLoop:
        if (matchre("%itemArr(%index)", "$char.craft.item")) then math numCount add 1
        math index add 1
        if (%index > %itemLength) then goto workOrderCountDone
        goto doCountLoop


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
    matchre workOrderBundle $char.craft.item
    matchre workOrderGet Alright, this is an order for
    put ask master for hard shaping work
    matchwait 5


workOrderBundle:
    if (%workOrderTotalNeed <> 0) then {
        if (%workOrderTotalHave >= %workOrderTotalNeed) then {
            gosub get $char.craft.item from my $char.craft.container
            gosub bundle $char.craft.item with my logbook
            waitforre ^You bundle up your
            evalmath workOrderTotalNeed (%workOrderTotalNeed - 1)
        } else {
            goto workOrderCraftMore
        }
    } else {
        goto workOrderTurnIn
    }
    goto workOrderBundle


workOrderTurnIn:
  gosub give master
  gosub stow my logbook in my $char.craft.container
  put #echo >log yellow [workorder] Order completed.
  exit


workOrderBadQuality:
    gosub drop my $char.craft.item
    evalmath workOrderTotalNeed (%workOrderTotalNeed + 1)
    goto workOrderBundle


workOrderCraftMore:
    put #echo >log yellow [workorder] More items needed.
    exit

