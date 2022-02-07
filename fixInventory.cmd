include libmaster.cmd

gosub stow right
gosub stow left

loop:
    gosub get my gem pouch from my $char.inv.container.default
    if ("$righthand" = "Empty") then goto shadowToBack
    matchre loopcont ^You sort through the contents of the gem pouch and find (\d+) gems in
    matchre loopcont ^The gem pouch
    put count my gem pouch
    matchwait

    loopcont:
    var numGems $1
    if ("%numGems" = "500") then {
        gosub put my gem pouch in my $char.inv.container.fullGemPouch
    } else {
        gosub put my gem pouch in my $char.inv.container.temp
    }

    goto loop


shadowToBack:
    gosub get gem pouch from my $char.inv.container.temp
    if ("$righthand" = "Empty") then goto done
    gosub put my gem pouch in my $char.inv.container.emptyGemPouch
    goto shadowToBack


done:
    put #parse FIXINVENTORY DONE
    pause .2
    exit