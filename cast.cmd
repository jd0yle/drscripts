include libmaster.cmd
action var isFullyPrepped 1 when ^You feel fully prepared to cast your spell\.
action var isFullyPrepped 1 when ^You have lost the spell you were preparing\.

###################
# Variable Inits
###################
put .var_$charactername.cmd
waitforre ^CHARVARS DONE$

var useCambrinth 1
var cambrinthFull 0
action var cambrinthFull 1 when dissipates (uselessly|harmlessly)\.$

if ("%1" = "n") then {
    var useCambrinth 0
    shift
}

var spell %1

if_2 then {
    var target %2
} else {
    var target $charactername
}

var isFullyPrepped 0
var stowedItemNoun null


###################
# Main
###################
if ("$char.wornCambrinth" != 1 && "$righthand" != "Empty" && "$lefthand" != "Empty") then {
    var stowedItemNoun $lefthandnoun
    gosub stow left
}

if ("$preparedspell" != "None") then gosub release spell

if ("%spell" = "bc" || "%spell" = "dc" || "%spell" = "pop") then goto ritualSpell
if ("%spell" = "col") then {
    var target null
    if ($Time.isYavashUp = 1) then {
        var target yavash
    }
    if ($Time.isXibarUp = 1) then {
        var target xibar
    }
    if ($Time.isKatambaUp = 1) then {
        var target katamba
    }
    if ("%moon" = "null") then goto done
}

gosub prep %1 $char.cast.default.prep

if (%useCambrinth = 1) then {
    if ("$char.wornCambrinth" != 1) then {
        gosub get my $char.cambrinth
        gosub remove my $char.cambrinth
    }

    gosub charge my $char.cambrinth $char.cast.default.charge
    gosub invoke my $char.cambrinth spell
    #var cambrinthFull 0
    #if (%cambrinthFull = 0) then gosub charge my $char.cambrinth $char.cast.default.charge
    #gosub invoke my $char.cambrinth $char.cast.default.charge
} else {
    gosub harness $char.cast.default.harness
    gosub harness $char.cast.default.harness
    gosub harness $char.cast.default.harness
    gosub harness $char.cast.default.harness
}
gosub waitPrep
goto done


waitPrep:
    pause 1
    if %isFullyPrepped != 1 then goto waitPrep
    gosub cast %target
    if ("char.wornCambrinth" != 1) then {
        gosub wear my $char.cambrinth
        gosub stow my $char.cambrinth
    }
    return


ritualSpell:
    gosub get my $char.ritualFocus
    gosub prep %spell $char.cast.ritual.%spell
    gosub invoke my $char.ritualFocus
    if %isFullyPrepped != 1 then gosub waitPrep
    gosub cast
    gosub stow my $char.ritualFocus in my $char.focusContainer
    goto done


done:
    if ("%spell" = "shadowling") then gosub invoke shadowling

    if ("%stowedItemNoun" != "null") then gosub get my %stowedItemNoun
    put #parse CAST DONE
    exit
