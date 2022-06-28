####################################################################################################
# autocast.cmd
# Selesthiel - justin@jmdoyle.com
#
# USAGE
# .autocast
# whisper yourCharacterName cast <spellname>
#
# Will try to cast the spell someone whispers to you
# EX: Someone whispers, "Cast bless"
#  casts 'bless' on 'Someone'
# Selesthiel whispers, "cast uncurse"
#  casts uncurse on Selesthiel
#
####################################################################################################

###############################
###      CONFIG
###############################
# THE AMOUNT TO PREP THE SPELL AT
var prepAmount 10

# THE MINIMUM AMOUNT OF TIME TO PREPARE BEFORE CASTING
var minPrepTime 20

# IF YOU WANT TO USE CAMBRINTH, CHANGE useCambrinth to 1
var useCambrinth 0
var cambrinthItem mammoth calf
var chargeAmount 10

# SET enforceWhitelist TO 1 TO ALLOW ONLY THE WHITELIST SPELLS
var enforceWhitelist 0

# IF enforceWhitelist IS 1, ONLY ALLOW THESE SPELLS:
var whitelist uncurse|bless

# NOTE: The whispered spells will need to exactly match the spells as listed in the whitelist
# ex: if the whitelist has 'mg', but the person whispers "cast moongate", it won't be allowed to cast


###############################
###      INIT
###############################
action (idling) eval spellName tolower($2); var target $1; echo Casting %spellName on %target; goto newTarget when (\S+) whispers, "[Cc]ast (\S+)

# With variable spell name input, need to handle busy notification a different way. Leaving out for now - JD
#action (busy) whisper $1 Busy when ^(\S+) whispers, "[Cc]ursed
action (busy) off

action var isFullyPrepped 1 when ^Your concentration lapses for a moment, and your spell is lost.$
action var isFullyPrepped 1 when ^Your concentration slips for a moment, and your spell is lost.$
action var isFullyPrepped 1 when ^You feel fully prepared to cast your spell.
action var isFullyPrepped 1 when ^Your formation of a targeting pattern
action var isFullyPrepped 0 when eval $preparedspell = None

var isFullyPrepped 0


###############################
###      idle
###############################
idle:
    action (idling) on
    action (busy) off

    if ("$preparedspell" != "None") then {
        put release spell
        pause .5
    }

    waitfor ThisWillNeverHappenSoJustWaitIndefinitely
    pause 30
goto idle


###############################
###      newTarget
###############################
newTarget:
    action (idling) off
    action (busy) on

    if (!matchre("$roomplayers", "%target")) then {
        var target null
        var spellName null
        if ("$preparedspell" != "None") then {
            put release spell
            pause .5
        }
        goto idle
    }
    if (%enforceWhitelist = 1 && !matchre("%spellName", "%whitelist")) then {
        put whisper %target Can't cast %spellName
        pause .5
        var target null
        var spellName null
        goto idle
    }
    if ("$preparedspell" = "None"} then {
        put prep %spellName %prepAmount
        pause 1
        if ("%useCambrinth" = "1") then {
            put charge my %cambrinthItem %chargeAmount
            pause
            pause
            put invoke my %cambrinthItem %chargeAmount
            pause
        }
        goto newTarget
    }

    gosub waitForPrep %minPrepTime
    gosub waitForMana 50

    put cast %target
    pause .5
    put whisper %target All set!
    var target null
    var spellName null
    goto idle


###############################
###      UTILITIES
###############################
waitForPrep:
	var waitForPrep.minSpellTime $1
	if (!(%waitForPrep.minSpellTime > -1)) then var waitForPrep.minSpellTime 20
    var isFullyPrepped 0
    echo waitForPrep: Waiting for minspell time: %waitForPrep.minSpellTime
    waitForPrep1:
    gosub waitForMana 30
    pause .1
    if (%isFullyPrepped = 1 || "$preparedspell" = "None" || $spelltime > %waitForPrep.minSpellTime) then return
    goto waitForPrep1


waitForMana:
    var waitManaForAmount $1
    if (!(%waitManaForAmount > 0)) then var waitManaForAmount 50

    waitForMana1:
    pause .5
    #if ($mana > %waitManaForAmount || "$preparedspell" = "None") then return
    if ($mana >= %waitManaForAmount) then return
    goto waitForMana1



