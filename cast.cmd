####################################################################################################
# cast.cmd
# Selesthiel - justin@jmdoyle.com
# Inauri - snmurphy95@gmail.com
#
# USAGE
# .cast <spell> [target]
#
# .cast maf
# .cast seer Inauri
# .cast col
#
# Spell values set in var_$charactername.cmd !
####################################################################################################
include libmaster.cmd
action var isFullyPrepped 1 when ^You feel fully prepared to cast your spell\.
action var isFullyPrepped 1 when ^You have lost the spell you were preparing\.


###############################
###      INIT
###############################
var useCambrinth 1
var cambrinthFull 0
action var cambrinthFull 1 when dissipates (uselessly|harmlessly)\.$

var noTargetSpells fp|cd
var isFullyPrepped 0
var stowedItemNoun null

if ("%1" = "n") then {
    var useCambrinth 0
    shift
}

var spell %1

if_2 then {
    var target %2
} else {
    if (!matchre("%spell", "%noTargetSpells") then var target $charactername
}


###############################
###      MAIN
###############################
if ($char.wornCambrinth != 1 && "$righthand" != "Empty" && "$lefthand" != "Empty") then {
    var stowedItemNoun $lefthandnoun
    if ("$lefthandnoun" = "telescope") then {
        gosub close my $char.observe.telescope
        gosub put my $char.observe.telescope in $char.observe.telescope.container
    } else {
        gosub stow left
    }
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

# Init to character spell defaults
var prepAt $char.cast.default.prep
var charge $char.cast.default.charge
var chargeTimes $char.cast.default.chargeTimes
var harness $char.cast.default.harness

# If the character has specific values for this spell, use those values
if ($char.cast.%spell.prep > 0) then var prepAt $char.cast.%spell.prep
if ($char.cast.%spell.charge > 0) then var charge $char.cast.%spell.charge
if ($char.cast.%spell.chargeTimes > 0) then var chargeTimes $char.cast.%spell.chargeTimes
if ($char.cast.%spell.harness > 0) then var prepAt $char.cast.%spell.harness

# Set anything that had no default or specific value
if (!(%prepAt > -1)) then var prepAt 1
if (!(%charge > -1)) then var charge 0
if (!(%chargeTimes > -1)) then var chargeTimes 1
if (!(%harness > -1)) then var harness 0

if (%useCambrinth = 0 || %charge = 0 || %chargeTimes = 0) then var useCambrinth 0

gosub prep %spell %prepAt

if (%useCambrinth = 1) then {
    if ($char.wornCambrinth != 1) then {
        gosub get my $char.cambrinth
        if ("$righthandnoun" <> "$char.cambrinth" || "$lefthandnoun" <> "$char.cambrinth") then {
            gosub remove my $char.cambrinth
        }
    }

    if (%charge > 0) then gosub charge my $char.cambrinth %charge

    var invokeAmount %charge
    if (1=0 && %chargeTimes = 2 && %cambrinthFull != 1) then {
        gosub charge my $char.cambrinth %charge
        evalmath invokeAmount (%invokeAmount * 2)
    }

    var invokeSpell
    if ($char.cast.invokeSpell = 1) then var invokeSpell spell

    gosub invoke my $char.cambrinth %charge %invokeSpell

	if ($char.wornCambrinth != 1) then {
	    gosub wear my $char.cambrinth
	    if ("$righthand" <> "Empty" && "$lefthand" <> "Empty") then {
	        gosub stow my $char.cambrinth
	    }
	}
}

if (%harness > 0) then gosub harness %harness

gosub waitForPrep
if ("%target" != "0arget") then {
    gosub cast %target
} else {
    gosub cast
}

goto done


###############################
###      ritualSpell
###############################
ritualSpell:
    gosub get my $char.ritualFocus
    gosub prep %spell $char.cast.%spell.prep
    gosub invoke my $char.ritualFocus
    if %isFullyPrepped != 1 then gosub waitForPrep
    gosub cast
    gosub put my $char.ritualFocus in my $char.focusContainer
    goto done


###############################
###      done
###############################
done:
    if ("%spell" = "shadowling") then gosub invoke shadowling

    if ("%stowedItemNoun" != "null") then gosub get my %stowedItemNoun
    pause .2
    put #parse CAST DONE
    exit
