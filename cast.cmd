include libsel.cmd

####### CONFIG #######

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

if ("%spell" = "bc" || "%spell" = "dc") then goto ritualSpell
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

gosub prep %1 60

if (%useCambrinth = 1) then {
    if ("%worncambrinth" != 1) then {
        gosub get my %cambrinth
    }

    var cambrinthFull 0
    gosub charge my %cambrinth 40
    #if (%cambrinthFull = 0) then gosub charge my %cambrinth 40
    gosub invoke my %cambrinth 40
} else {
    gosub harness 20
    gosub harness 20
    gosub harness 20
    gosub harness 20
}
gosub waitPrep
goto done

waitPrep:
    pause 1
    if %isFullyPrepped != 1 then goto waitPrep
    gosub cast %target
    if ("%worncambrinth" != 1) then {
        gosub stow my %cambrinth
    }
    return


ritualSpell:
    gosub get my %focus
    if (%spell = bc) then gosub prep bc 700
    if (%spell = dc) then gosub prep dc 600
    gosub invoke my %focus
    if %isFullyPrepped != 1 then gosub waitPrep
    gosub cast
    gosub stow my %focus
    goto done

done:
    if ("%spell" = "shadowling") then gosub invoke shadowling

    if ("%stowedItemNoun" != "null") then gosub get my %stowedItemNoun
    put #parse CAST DONE
    exit
