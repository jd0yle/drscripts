include libmaster.cmd

####### CONFIG #######
put .var_$charactername.cmd
waitforre ^CHARVARS DONE$

var cambrinth $char.cambrinth
var worncambrinth $char.wornCambrinth
var focus $char.ritualFocus

######################

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

action var isFullyPrepped 1 when ^You feel fully prepared to cast your spell.
action var isFullyPrepped 1 when ^You have lost the spell you were preparing.

if ("%worncambrinth" != 1 && "$righthand" != "Empty" && "$lefthand" != "Empty") then {
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
    if ("%worncambrinth" != 1) then {
        gosub get my %cambrinth
        gosub remove my %cambrinth
    }

    var cambrinthFull 0
    gosub charge my %cambrinth $char.cast.default.charge
    gosub invoke my %cambrinth spell
    #if (%cambrinthFull = 0) then gosub charge my %cambrinth $char.cast.default.charge
    #gosub invoke my %cambrinth $char.cast.default.charge
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
    if ("%worncambrinth" != 1) then {
        gosub wear my %cambrinth
        gosub stow my %cambrinth
    }
    return


ritualSpell:
    gosub get my %focus
    gosub prep %spell $char.cast.ritual.%spell
    gosub invoke my %focus
    if %isFullyPrepped != 1 then gosub waitPrep
    gosub cast
    gosub stow my %focus in my $char.focusContainer
    goto done

done:
    if ("%spell" = "shadowling") then gosub invoke shadowling

    if ("%stowedItemNoun" != "null") then gosub get my %stowedItemNoun
    put #parse CAST DONE
    exit
