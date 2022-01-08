include libmaster.cmd
###############################
###      SELL BUNDLES
###############################


###############################
###      IDLE ACTION TRIGGERS
###############################
action var sb.haveBundle 1 when (tight bundle|lumpy bundle)

###############################
###      VARIABLES
###############################
var sb.haveBundle 0


###############################
###      MAIN
###############################
sb.main:
    gosub sb.checkLocation
    gosub sb.checkInventory
    gosub sb.clearHands

    sb.loop:
        gosub sb.getBundle
        if (%sb.haveBundle = 1) then {
            gosub sb.sellBundle
            goto sb.loop
        }
        gosub sb.deposit
        gosub sb.exit


###############################
###      UTILITY
###############################
sb.checkInventory:
    gosub inventory search bundle
    if (%sb.haveBundle = 0) then {
        put #echo >Log [sellbundle] No bundles to sell.
        gosub sb.exit
    } else {
        return
    }


sb.checkLocation:
    if ("$roomname" = "Private Home Interior") then {
        put .house
        waitforre ^HOUSE DONE$
    }

    if ("$zoneid" <> "150") then {
        put #echo >Log [sellbundle] Not in Fang Cove, exiting.
        goto sb.exit
    } else {
        if ("$roomid" <> "137") then {
            gosub automove bundle
        }
        return
    }


sb.clearHands:
    if ("$righthand" <> "Empty") then {
        gosub stow
    }
    if ("$lefthand" <> "Empty") then {
        gosub stow left
    }
    return


sb.deposit:
    gosub runScript deposit
    return


sb.getBundle:
    var sb.haveBundle 0
    gosub remove my bundle
    if (%sb.haveBundle = 0) then {
        gosub get my bundle
    }
    if ((%sb.haveBundle = 0) && ($char.inv.eddyContainer <> null)) then {
        gosub get my bundle from my portal
    }
    return


sb.sellBundle:
    if (matchre("$righthandnoun|$lefthandnoun", "bundle")) then {
        gosub sell my bundle
    }
    if (matchre("$righthandnoun|$lefthandnoun", "bundle")) then {
        put #echo >Log [sellbundle] Unable to sell this bundle.  rh: $righthand lh:$lefthand
        gosub sb.clearHands
        goto sb.exit
    }
    if (matchre("$righthandnoun|$lefthandnoun", "rope")) then {
        gosub sb.clearHands
    }
    return


sb.exit:
    pause .001
    put #parse SELLBUNDLE DONE
    exit
