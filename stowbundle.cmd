include libmaster.cmd

var numbers first|second|third|fourth|fifth|sixth|seventh|eighth|ninth|tenth

gosub stow right
gosub stow left


gosub summonServant
gosub checkForAvailableHaversack


goto done


checkForAvailableHaversack:
    var index 0
    gosub remove my bundle
    gosub swap

    checkForAvailableHaversackLoop:
        if (%index = 0) then {
            gosub retreat
            gosub retreat
            gosub ask servant for haversack
        } else {
            gosub retreat
            gosub retreat
            gosub ask servant for %numbers(%index) haversack
        }
        #if ("$righthand" = "Empty") then
        gosub open my haversack
        gosub put my bundle in my haversack
        gosub close my haversack
        gosub retreat
        gosub retreat
        gosub give servant
        if ("$lefthand" = "Empty") then return
        math index add 1
        if (%index > 10) then goto doneErr
        goto checkForAvailableHaversackLoop


summonServant:
    if (!matchre("$roomobjs", "a mischievous Shadow Servant composed of fractured shadows")) then {
        echo No servant!
        gosub prep ss
        pause 8
        gosub cast
        goto summonServant
    }
    return


doneErr:
    echo **** ERROR ****
    exit

done:
    gosub release servant
    put #parse STOWBUNDLE DONE
    exit