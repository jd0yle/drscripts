include libmaster.cmd
###############################
###      SELL GEMS
###############################
# Change Log
# 29-DEC-2021 - Only sells nuggets and bars.  Only works in Fang Cove.
# 06-FEB-2022 - Added platinum.  Updated container variables and updated to use a tvar if desired.


###############################
###      IDLE ACTION TRIGGERS
###############################
action var sellgem.bagContents $1 when ^In .* you see (.*)\.$
action goto sellgem-errornpc when ^There doesn't seem to be anyone around\.

###############################
###      VARIABLES
###############################
var sellgem.gem nugget|bar
var sellgem.indexGem 0
var sellgem.mat brass|bronze|coal|copper|covellite|electrum|gold|iron|lead|nickel|pewter|platinum|silver|steel|oravir|zinc
var sellgem.indexMat 0
var sellgem.lengthMat 0
eval sellgem.lengthMat count("%sellgem.mat", "|")

if_1 then {
    var sellgem.bag %1
    gosub sellgem-checkBag
} else {
    if ($char.inv.container.sellGemBag <> 0) then {
        var sellgem.bag $char.inv.container.sellGemBag
        gosub sellgem-checkBag
    }
    echo ************
    echo   SELLGEM
    echo ************
    echo Please call this script with a bag to check.  This is to prevent accidental sales.
    echo Example:  .sellgem purse
    echo Alternatively, you can set char.inv.container.sellGemBag to a default bag to check.
    echo Example:  .sellgem
    echo ************
    exit
}


sellgem-checkBag:
    gosub look in my %sellgem.bag
    if (matchre("%sellgem.bagContents", "%sellgem.gem")) then {
        goto sellgem-main
    } else {
        put #echo >Log [sellgem] Did not find any loose gems in your %sellgem.bag.
        goto sellgem-exit
    }


###############################
###      MAIN
###############################
sellgem-main:
    gosub sellgem-checkLocation
    gosub sellgem-clearHands
    goto sellgem-get


sellgem-get:
    if (%sellgem.indexGem < 2) then {
        if (%sellgem.indexMat =< %sellgem.lengthMat) then {
            var gem %sellgem.mat(%sellgem.indexMat) %sellgem.gem(%sellgem.indexGem)
            gosub get my %gem from my %sellgem.bag

            if ("$righthand" <> "%gem" && "$righthand" = "Empty") then {
                if ("%sellgem.mat(%sellgem.indexMat)" = "zinc") then {
                    var sellgem.indexMat 0
                    math sellgem.indexGem add 1
                    goto sellgem-get
                } else {
                    math sellgem.indexMat add 1
                    goto sellgem-get
                }
            } else {
                gosub sellgem-sell
                goto sellgem-get
            }
        }
    }
    goto sellgem-deposit


sellgem-sell:
    gosub sell my %gem
    if (matchre("$righthandnoun|$lefthandnoun", "%gem")) then {
        put #echo >Log [sellgem] Unable to sell this item, exiting.  rh: $righthand lh:$lefthand
        gosub sellgem-clearHands
        goto sellgem-exit
    }
    return


###############################
###      UTILITY
###############################
sellgem-checkLocation:
    if ("$roomname" = "Private Home Interior") then {
        gosub runScript house
    }

    if ("$zoneid" <> "150") then {
        put #echo >Log [sellgem] Not in Fang Cove, exiting.
        goto sellgem-exit
    } else {
        if ("$roomid" <> "127") then {
            gosub automove gem
        }
        return
    }


sellgem-clearHands:
    if ("$righthand" <> "Empty") then {
        gosub stow
    }
    if ("$lefthand" <> "Empty") then {
        gosub stow left
    }
    return


sellgem-deposit:
    gosub runScript deposit
    gosub sellgem-exit


sellgem-errornpc:
    put #echo >Log [sellgem] No NPC currently in the shop.  Roomobjs: ($roomobjs)
    gosub sellgem-clearHands
    goto sellgem-exit


sellgem-exit:
    pause .001
    put #parse SELLGEM DONE
    exit
