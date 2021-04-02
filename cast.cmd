include libmaster.cmd
action var isFullyPrepped 1 when ^You feel fully prepared to cast your spell\.
action var isFullyPrepped 1 when ^You have lost the spell you were preparing\.

###############################
###      INIT
###############################
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


###############################
###      MAIN
###############################
if ($char.wornCambrinth != 1 && "$righthand" != "Empty" && "$lefthand" != "Empty") then {
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

var prepAt $char.cast.default.prep
var charge $char.cast.default.charge
var chargeTimes $char.cast.default.chargeTimes
var harness $char.cast.default.harness

if ($char.cast.%spell.prep > 0) then var prepAt $char.cast.%spell.prep
if ($char.cast.%spell.charge > 0) then var charge $char.cast.%spell.charge
if ($char.cast.%spell.chargeTimes > 0) then var chargeTimes $char.cast.%spell.chargeTimes
if ($char.cast.%spell.harness > 0) then var prepAt $char.cast.%spell.harness

gosub prep %spell %prepAt

if (%useCambrinth = 1) then {
    if ($char.wornCambrinth != 1) then {
        gosub get my $char.cambrinth
        gosub remove my $char.cambrinth
    }

    gosub charge my $char.cambrinth %charge
    if (%chargeTimes = 2 && %cambrinthFull != 1) then gosub charge my $char.cambrinth %charge
    var invokeSpell
    if ($char.cast.invokeSpell = 1) then var invokeSpell spell
    gosub invoke my $char.cambrinth %charge %invokeSpell

} else {
    gosub harness %harness
}
gosub waitPrep
goto done


waitPrep:
    pause 1
    if %isFullyPrepped != 1 then goto waitPrep
    gosub cast %target
    if ($char.wornCambrinth != 1) then {
        gosub wear my $char.cambrinth
        gosub stow my $char.cambrinth
    }
    return


ritualSpell:
    gosub get my $char.ritualFocus
    gosub prep %spell $char.cast.%spell.prep
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
