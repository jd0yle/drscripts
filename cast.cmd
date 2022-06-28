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

var noTargetSpells gg|fp|cd|bless
var noCast 0
var isFullyPrepped 0
var stowedItemNoun null

if ("%1" = "n") then {
    var useCambrinth 0
    shift
}

var spell %1

if_2 then {
    if ("%2" = "noCast") then {
       var noCast 1
    } else {
        var target %2
    }
} else {
    if (!matchre("%spell", "%noTargetSpells")) then var target $charactername
}


###############################
###      MAIN
###############################
if ($char.wornCambrinth != 1 && "$righthand" != "Empty" && "$lefthand" != "Empty") then {
    var stowedItemNoun $lefthandnoun
    if ("$lefthandnoun" = "telescope") then {
        gosub close my $char.observe.telescope
        gosub put my $char.observe.telescope in $char.inv.container.telescope
    } else {
        gosub stow left
    }
}

if ("$preparedspell" != "None") then gosub release spell




# Init to character spell defaults
var prepAt $char.cast.default.prep
var charge $char.cast.default.charge
var chargeTimes $char.cast.default.chargeTimes
var harness $char.cast.default.harness

# If the character has specific values for this spell, use those values
if ($char.cast.%spell.prep > 0) then var prepAt $char.cast.%spell.prep
if ($char.cast.%spell.charge > -1) then var charge $char.cast.%spell.charge
if ($char.cast.%spell.chargeTimes > 0) then var chargeTimes $char.cast.%spell.chargeTimes
if ($char.cast.%spell.harness > 0) then var prepAt $char.cast.%spell.harness

# Set anything that had no default or specific value
if (!(%prepAt > -1)) then var prepAt 1
if (!(%charge > -1)) then var charge 0
if (!(%chargeTimes > -1)) then var chargeTimes 1
if (!(%harness > -1)) then var harness 0

if (%useCambrinth = 0 || %charge = 0 || %chargeTimes = 0) then var useCambrinth 0

if ($char.cast.useOm = 1 && $SpellTimer.OsrelMeraud.active = 1 && matchre("%spell", "($char.cast.omSpells)")) then {
	evalmath prepAt (%prepAt + (%charge * %chargeTimes))
	var charge 0
	var chargeTimes 0
	var useCambrinth 0

	echo USING OM, prepAt %prepAt, charge %charge, chargeTimes %chargeTimes
}

if ("%spell" = "bc" || "%spell" = "dc" || "%spell" = "pop" || "%spell" = "pom" || "%spell" = "mf") then goto ritualSpell
if ("%spell" = "col") then {
    # Replacing moons with ambient all the time because of the inaccuracy of the Genie time plugin - JD
    #gosub checkMoons
    #if ("%target" = "$charactername") then var target $moon
    #if ("$moon" = "null") then var target ambient

    var target ambient

}

if ("%spell" = "om") then {
	var target orb
}

#echo $char.cast.useOm = 1 && $SpellTimer.OsrelMeraud.active = 1 && matchre("%spell", "($char.cast.omSpells)")
#if ($char.cast.useOm = 1 && $SpellTimer.OsrelMeraud.active = 1 && matchre("%spell", "($char.cast.omSpells)")) then {
#	evalmath prepAt (%prepAt + (%charge * %chargeTimes))
#	var charge 0
#	var chargeTimes 0
#	var useCambrinth 0
#
#	echo USING OM, prepAt %prepAt, charge %charge, chargeTimes %chargeTimes
#}

if ("%spell" = "$char.cast.tattoo.spellName") then {
	gosub invoke tattoo
} else {
	gosub prep %spell %prepAt
}

if (%useCambrinth = 1) then {
    if ($char.wornCambrinth != 1) then {
        gosub get my $char.cambrinth
        if ("$righthandnoun" <> "$char.cambrinth" || "$lefthandnoun" <> "$char.cambrinth") then {
            gosub remove my $char.cambrinth
        }
    }

    if (%charge > 0) then gosub charge my $char.cambrinth %charge

	var invokeAmount %charge
	gosub chargeLoop

    #if (%chargeTimes > 1 && %cambrinthFull != 1) then {
    #    gosub charge my $char.cambrinth %charge
    #    evalmath invokeAmount (%invokeAmount * 2)
    #}

    var invokeSpell
    if ($char.cast.invokeSpell = 1) then var invokeSpell spell

    gosub invoke my $char.cambrinth %invokeAmount %invokeSpell

    if ("%spell" = "qe") then {
        gosub push my vial
        gosub perform cut
    }
    if ("%spell" = "nr") then {
        gosub perform cut
    }

	if ($char.wornCambrinth != 1) then {
	    gosub wear my $char.cambrinth
	    if ("$righthand" <> "Empty" && "$lefthand" <> "Empty") then {
	        gosub stow my $char.cambrinth
	    }
	}
}

if (%harness > 0) then gosub harness %harness

# Check if we wanted to only prep the spell
if (%noCast = 1) then goto done

if (!($char.cast.default.minPrepTime > -1)) then var minPrepTime 40
if ($char.cast.%spell.minPrepTime >= 0) then var minPrepTime $char.cast.%spell.minPrepTime
gosub waitForPrep %minPrepTime

if ("%spell" = "devour") then gosub get my material

gosub castOrTouch

goto done


chargeLoop:
    if (%chargeTimes > 1 && %cambrinthFull != 1) then {
        gosub charge my $char.cambrinth %charge
        evalmath invokeAmount (%invokeAmount + %charge)
        evalmath chargeTimes (%chargeTimes - 1)
        goto chargeLoop
    }
    return

###############################
###      ritualSpell
###############################
ritualSpell:
	if ($hidden = 1) then gosub shiver
	if ($SpellTimer.RefractiveField.active = 1) then gosub release rf

    if ("$righthand" != "Empty" || "$lefthand" != "Empty") then {
        gosub stow right
        gosub stow left
    }
    if ($char.wornFocus = 1) then {
        gosub remove my $char.ritualFocus
    }
    if ("$righthand" = "Empty") then {
        gosub get my $char.ritualFocus
    }
    gosub prep %spell $char.cast.%spell.prep
    gosub invoke my $char.ritualFocus
    if (%isFullyPrepped != 1) then gosub waitForPrep
    gosub castOrTouch
    if ($char.wornFocus = 1) then {
        gosub wear my $char.ritualFocus
        gosub wear my $char.ritualFocus
        gosub sort auto head
    } else {
        gosub put my $char.ritualFocus in my $char.inv.container.focus
    }
    goto done



###############################
###      castOrTouch
###############################
castOrTouch:
    if ($char.cast.useOm = 1 && matchre("%spell", "($char.cast.omSpells)") && $SpellTimer.OsrelMeraud.active = 1) then {
        gosub touch orb
    } else {
        if ("%target" != "0arget" && !(matchre("%spell", "(%noTargetSpells)")) then {
            gosub cast %target
        } else {
            gosub cast
        }
    }
    return


###############################
###      done
###############################
done:
	if ("%spell" = "rev" || "%spell" = "ghs" || "%spell" = "hyh") then put #echo >Debug [cast] Cast %spell
    if ("%spell" = "shadowling") then gosub invoke shadowling

    if ("%spell" = "qe" && ("$lefthandnoun" = "dirt" || "$righthandnoun" = "dirt")) then gosub put my dirt in my vial

    if ("%stowedItemNoun" != "null") then gosub get my %stowedItemNoun

    if ("$righthandnoun" = "apple" || "$lefthandnoun" = "apple") then gosub stow apple

    pause .2
    put #parse CAST DONE
    exit
