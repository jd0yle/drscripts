include libmaster.cmd
###############################
###      SELL BUNDLES
###############################


###############################
###      IDLE ACTION TRIGGERS
###############################
action var sb.haveBundle 1 when (a tight bundle|a lumpy bundle)

###############################
###      VARIABLES
###############################
var sb.haveBundle 0


###############################
###      MAIN
###############################
sb.main:
    gosub sb.checkLocation
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
sb.checkLocation:
    if ("$roomname" = "Private Home Interior") then {
        put .house
        waitforre ^HOUSE DONE$
    }

    if ("$zoneid" <> "150") then {
        put #echo >Log [sellbundle] Not in Fang Cove, existing.
        goto sb.exit
    } else {
        if ("$roomid" <> "139") then {
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
    gosub remove my bundle
    if (matchre("$righthandnoun|$lefthandnoun", "bundle")) then {
        var sb.haveBundle 1
        return
    } else {
        gosub get my bundle
        if (matchre("$righthandnoun|$lefthandnoun", "bundle")) then {
            var sb.haveBundle 1
            return
        } else {
            put #echo >Log [sellbundle] No more bundles found.
            var sb.haveBundle 0
            return
        }
    }


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
