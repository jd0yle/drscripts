include libmaster.cmd

var numbers first|second|third|fourth|fifth|sixth|seventh|eighth|ninth|tenth
var index 0

gosub stow right
gosub stow left


gosub summonServant
gosub sellAllBundles
#gosub checkForAvailableHaversack
goto done


gosub remove my bundle
gosub sell my bundle
if ($righthandnoun = rope) then gosub stow my rope

#gosub sellHaversackBundles

var contBackback 1
var contShadows 1
var contPortal 1

sellAllBundles:
    if (%index = 0) then {
        gosub get bundle from my backpack
        if ("$righthand" != "Empty") then {
            gosub sell my bundle
            gosub drop my rope
        } else {
            var contBackback 0
        }

        gosub get bundle from my shadows
        if ("$righthand" != "Empty") then {
            gosub sell my bundle
            gosub drop my rope
        } else {
            var contShadows 0
        }

        gosub get bundle from my portal
        if ("$righthand" != "Empty") then {
            gosub sell my bundle
            gosub drop my rope
        } else {
            var contPortal 0
        }

        gosub ask servant for haversack
    } else {
        gosub ask servant for %numbers(%index) haversack
    }
    if ("$righthand" = "Empty") then var index 10
    gosub open my haversack
    gosub sellHaversack
    gosub close my haversack
    gosub give servant

    if (%contBackback = 1) then {
        gosub get bundle from my backpack
        if ("$righthand" != "Empty") then {
            gosub sell my bundle
            gosub drop my rope
        } else {
            var contBackback 0
        }
    }
    if (%contShadows = 1) then {
        gosub get bundle from my shadows
        if ("$righthand" != "Empty") then {
            gosub sell my bundle
            gosub drop my rope
        } else {
            var contShadows 0
        }
    }
    if (%contPortal = 1) then {
        gosub get bundle from my portal
        if ("$righthand" != "Empty") then {
            gosub sell my bundle
            gosub drop my rope
        } else {
            var contPortal 0
        }
    }

    math index add 1
    if (%index > 10) then return
    goto sellAllBundles


sellHaversack:
    var haverIndex 0

    sellHaversack1:
    var cont 0
    gosub get bundle from my haversack
    if ("$lefthand" != "Empty") then {
        gosub sell my bundle
        gosub stow left
        var cont 1
    }
    math haverIndex add 1
    if (%cont = 0 || %haverIndex > 4) then return
    goto sellHaversack1


sellBundle:
    gosub sell my bundle
    gosub stow my rope
    return


summonServant:
    if (!matchre("$roomobjs", "a mischievous Shadow Servant composed of fractured shadows")) then {
        echo No servant!
        gosub prep ss
        pause 10
        gosub cast
        goto summonServant
    }
    return


done:
    gosub release servant
    pause .2
    put #parse SELLBUNDLE DONE
    exit