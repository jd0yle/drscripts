include libsel.cmd

gosub stowBunInServant
put #parse SS STOW BUNDLE DONE
exit


stowBunInServant:
    put .ret
    gosub summonServant
    gosub stow right
    gosub stow left
    gosub remove my bundle
    gosub give my bundle to servant
    gosub release servant
    put #script abort ret
    return


summonServant:
    if (!contains("$roomobjs", "brooding Shadow Servant")) then {
        if ($preparedspell != None) then gosub release spell
        gosub prep ss
        pause 10
        gosub cast
        goto summonServant
    }
    return

