include libmaster.cmd
###############################
###    SU HELMAS
###############################
#  Spawned from Reveler's Su Helmas Script
#
###############################
###    IDLE ACTION TRIGGERS
###############################
if (matchre("$guild" = "Empath")) then {
    action var action touch seed when The seed might well be the only thing in the world right now, as you slowly threaten to
} else {
    action var action smite when The seed might well be the only thing in the world right now, as you slowly threaten to
}
if (matchre("$guild", "(Commoner|Barbarian|Thief)")) then {
    action var action break when magical barrier blocks further travel down the cold passageway
}
if (matchre("$guild", "(Bard|Cleric|Empath|Moon Mage|Necromancer|Paladin|Ranger|Trader|Warrior Mage)")) then {
    action var action invoke when magical barrier blocks further travel down the cold passageway
}

action var action climb when granite slab at the center of the sunken pit
action var action crawl when little sense moving forward until this is dealt with
action var action dodge when past the vines you see a lit chamber beckoning
action var action meditate when but it's certainly enough to make someone scream\, too
action var action move darkness when stir within it may have other things in mind
action var action search when tickle at the frayed edges of sanity
action var activeContract 1 when Forbidden Temple of Su Helmas, charges remaining\:
action var lootHand $1 when Your guide shoves .* into your (.*) hand\.

action goto suhelmas-loop when \[Beneath Su Helmas\]
action goto suhelmas-loop when ^You hesitate at the edge of the light
action goto suhelmas-looting when ^Your guide enthusiastically greets you as you return
action put #echo >log [suhelmas] Loot: $1 when guide shoves (.*?) into
action put .suhelmas when ^You lash out at everything around you!


###############################
###    VARIABLES
###############################
var action 0
var activeContract 0
var lootHand left
var SHtrash NULL
var suhelmas.weapon scythe


###############################
###    MAIN
###############################
suhelmas-roomCheck:
	#if !(matchre("$roomobjs", "empath")) then goto suhelmas-errorRoom
	goto suhelmas-weaponCheck


suhelmas-weaponCheck:
    if ("$guild" <> "Empath") then {
        if !(matchre("$righthand", "%suhelmas.weapon")) then
            if !(matchre("$righthand", "Empty")) then {
                gosub stow
            }
            gosub get my %suhelmas.weapon
            gosub remove my %suhelmas.weapon
            if !(matchre("$righthand|$lefthand", "%suhelmas.weapon")) then goto suhelmas-errorWeapon
        }
    }
    goto suhelmas-contractCheck


suhelmas-contractCheck:
    var activeContract 0
    gosub info
    if (%activeContract = 1) then goto suhelmas-join
    if !(matchre("$lefthand", "Empty")) then {
        gosub stow left
    }
    if !(matchre("$lefthand|$righthand", "Su Helmas contract")) then {
        gosub get my contract from my $char.inv.defaultContainer
        if !(matchre("$lefthand|$righthand", "Su Helmas contract")) then goto suhelmas-errorContract
    }
    goto suhelmas-redeem


suhelmas-redeem:
    gosub redeem my contract
    gosub redeem my contract
	if matchre("$righthand|$lefthand", "contract(s?)") then {
	    gosub put contract in my $char.inv.defaultContainer
	}
	goto suhelmas-join


suhelmas-join:
    var action 0
	gosub join empath
	goto suhelmas-loop


suhelmas-loop:
    if (%action <> 0) then {
        if ("%action" = "move darkness") then {
            pause .2
            put move darkness
            pause .2
            put move darkness
        } else {
            gosub %action
        }
    }
    pause 2
    goto suhelmas-loop


###############################
###    UTILITY
###############################
suhelmas-looting:
	pause .5
	if !(matchre("$%lootHandhandnoun", "(%SHtrash)")) then {
	    gosub put my $%lootHandhandnoun in my sack in my $char.inv.defaultContainer
	} else {
	    gosub put my $%lootHandhandnoun in my $char.inv.defaultContainer
	}
	pause 3
	goto suhelmas-contractCheck


suhelmas-errorRoom:
    put #echo >log [suhelmas] Could not find 'empath wreathed in violet robes' please check your room.
    goto suhelmas-end


suhelmas-errorContract:
    put #echo >log [suhelmas] You are out of contracts.
    goto suhelmas-end


suhelmas-errorWeapon:
    put #echo >log [suhelmas] Weapon variable not set.
    goto suhelmas-end


suhelmas-end:
    pause .2
    put #parse SUHELMAS DONE
    exit