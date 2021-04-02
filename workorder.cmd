include libmaster.cmd
action goto needMore when ^What were you referring to\?


##############
# Variables Init
##############
var orderItem %1

getLogbook:  
    gosub get my logbook
    goto getWorkorder
    goto getItem
  
getWorkorder:
    matchre getItem %1
    matchre getWorkorder Alright, this is an order for
    put ask master for hard shaping work
    matchwait 5
  
getItem:
    gosub get %1 from my workbag
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
  
needMore:
    put #echo >log yellow [workorder] More items needed.
    exit

orderDone:
    gosub stow my %1 in my workbag
    put give master
    gosub stow my logbook in my workbag
    put #echo >log yellow [workorder] Order completed.
    exit 5
