## Reveler's Burgle Script
## v.5.0
## 06/15/2021
## Discord Reveler#6969
##
## Version 5.0 Changes - SpicyDiapsid
##          Reduced function cyclomatic complexity throughout.
##          Modified burgle variables to use temp vars.
##          Implemented Pawn support for users with automapping.
## --------------
## TO USE:
##		FIRST SET YOUR VARIABLES IN BURGLEVARIABLES.CMD
##		If travel is off, go to an appropriate room
##		The script will check if there is a guard in the room
##		PLEASE MESSAGE ME IF YOU FIND A GUARD NOT LISTED IN THE GUARD VARIABLE BELOW OR LOOT NOT LISTED IN LOOT VARIABLES BELOW
##		YOU need to confirm there's no guard in NEARBY rooms (hint: HUNT or be sure it's a no-guard room)
##		hit .burgle and go at it!
##
## Required Plugins and Scripts:
##      burgleVariables.cmd
##      Automapper scripts and updated maps.
##      Spell Timer Plugin.
##
## DISCLAIMER: NOT RESPONSIBLE FOR YOUR ASTRONOMICAL FINES

put .burgleVariables.cmd
waitforre ^BURGLEVARIABLES DONE$


###############################
###      ACTION
###############################
action math successful add 1 when ^You rummage around (.*)\, until you find
action var footsteps ON when ^Footsteps nearby make you wonder if you\'re pushing your luck\.

# Rooms and Surfaces
action var surface bed ; var room bedroom when ^\[Someone Else\'s Home\, Bedroom\]$
action var surface bookshelf ; var room library when ^\[Someone Else\'s Home\, Library\]$
action var surface counter ; var room kitchen when ^\[Someone Else\'s Home\, Kitchen\]$
action var surface desk ; var room sanctum when ^\[Someone Else\'s Home\, Sanctum\]$
action var surface rack ; var room armory when ^\[Someone Else\'s Home\, Armory\]$
action var surface table ; var room workroom when ^\[Someone Else\'s Home\, Work Room\]$

# Jail
action instant goto JAIL when ^Before you really realize what\'s going on\, your hands are firmly bound behind you and you are marched off\.$
action goto PLEA when ^The eyes of the court|PLEAD INNOCENT or PLEAD GUILTY|Your silence shall be taken|How do you plead\?
action goto CLANJUSTICE when ^After a moment the leader steps forward grimly
action instant var fine 0;var platfine 0;var goldfine 0;var silverfine 0;var bronzefine 0;var copperfine 0;if ($1) then evalmath platfine $1*10000;if ($2) then evalmath goldfine $2*1000;if ($3) then evalmath silverfine $3*100;if ($4) then evalmath bronzefine $4*10;if ($5) then var copperfine $5;evalmath fine %platfine+%goldfine+%silverfine+%bronzefine+%copperfine when I pronounce a fine upon you of (?:(\d+) platinum[,.]?)?(?:(?: and)? ?(\d+) gold[,.]?)?(?:(?: and)? ?(\d+) silver[,.]?)?(?:(?: and)? ?(\d+) bronze[,.]?)?(?:(?: and)? ?(\d+) copper\.)?

# Testing
#action put #var test.burgle.start $gametime;put #log >Burgle.log Start,$charactername,$gametime when ^You make short work of the lock on the window and slip inside|^You scale up the side of a wall, quickly slipping inside
#action put #var test.burgle.warntime $gametime;put #evalmath test.burgle.warning $gametime - $test.burgle.start;put #log >Burgle.log Footsteps,$charactername,$gametime,$test.burgle.warning when ^Footsteps nearby make you wonder if you're pushing your luck
#action put #evalmath test.burgle.caught $gametime - $test.burgle.warntime;put -1 #log >Burgle.log Caught,$charactername,$gametime,$test.burgle.caught when ^Before you really realize what\'s going on\, your hands are firmly bound behind you|^After a moment the leader steps forward


###############################
###      VARIABLE INITS
###############################
var footsteps OFF
var items NULL
var grabs 0
var guards Gwaerd|guard|Shard sentinel|Sentinel|Elven Warden|Riverhaven Warden|Warden|Baronial guardsman|sickly tree|Muspar'i constable
var moves 0
var pawnmoveloop 0
var priorexit(armory)
var priorexit(bedroom)
var priorexit(kitchen)
var priorexit(library)
var priorexit(sanctum)
var priorexit(workroom)
var rooms_captured kitchen
var searched NULL
var successful 0
var surface NULL


###############################
###      BURGLEVARIABLES
###############################
var pack $char.burgle.container
var method $char.burgle.entryMethod
var lockpickRingType $char.burgle.lockpickRingType
var ropeType $char.burgle.ropeType
var ropeWorn $char.burgle.wornRope
var travel $char.burgle.travel
var maxGrabs $char.burgle.maxGrabs
var keepList $char.burgle.keepThisList
var pawnAll $char.burgle.pawnAll
var trashAll $char.burgle.trashAllExceptKeep
var trashList $char.burgle.trashThisList
var hideBefore $char.burgle.hideBefore
var skipRoom $char.burgle.skipRoom


###############################
###      LOOTPOOL
###############################
var armoryLoot arrows|bolts|briquet|crossbow|cudgel|dagger|hammer|hauberk|gloves|leathers|longsword|plate|scimitar|shield|sipar|stick|stones
var bedroomLoot bangles|bank|bathrobe|bear|blanket|bottoms|box|choker|cloak|comb|cube|cufflinks|diary|fabric|handkerchief|locket|mirror|nightcap|nightgown|pajamas|pillow|razor|slippers|top
var kitchenLoot basket|bowl|box|broom|cylinder|helm|jug|knife|knives|lunchbox|mortar|mouse|napkin|pestle|rat|shakers|sieve|skillet|snare|stick|sphere|stove|tankard|tote|towel|twine|vase
var libraryLoot book|case|cowbell|fan|harp|guide|lamp|leaflet|manual|paperweight|portrait|quill|ring|scroll|slate
var sanctumLoot amulet|ball|blossom|bracer|case|charts|kaleidoscope|lens|opener|orb|prism|ring|rod|statuette|telescope
var workroomLoot apron|brush|burin|case|distaff|ledger|oil|pins|rasp|rod|scissors|shaper
put #tvar burgle.lootpool %armoryLoot|%bedroomLoot|%kitchenLoot|%libraryLoot|%sanctumLoot|%workroomLoot


###############################
###      START CHECKS
###############################
if ($standing = 0) then put stand

if !matchre("%method", "(?i)(RING|ROPE|LOCKPICK)") then {
    echo [burgle] Your burgle variable for entry method has not been set up properly, exiting.
    put #echo >log red [burgle] Error with entry method variable.
    goto burgle.end
}

if matchre("$roomname", "Someone Else\'s Home") then goto burgle.escape


burgle.checkTimer:
    var location burgle.checkTimer
    gosub put burgle recall


burgle.travel:
	if matchre("%travel" = "(?i)NULL") then goto burgle.buff
	else put .travel %travel
	waitforre ^YOU ARRIVED\!


###############################
###      UTILITY
###############################
put:
	var todo $0
	var location put1
	put1:
	matchre burgle.wait ^\.\.\.wait|^Sorry,|^Please wait\.
	matchre burgle.wait ^\[If you still wish to drop it
	matchre burgle.wait ^Roundtime\:?|^\[Roundtime\:?|^\(Roundtime\:?|^\[Roundtime|^Roundtime
	matchre burgle.wait ^The weight of all your possessions prevents you from standing\.
	matchre burgle.wait ^You are overburdened and cannot manage to stand\.
    matchre return ^You drop|^You put|^You sling|^You attach|^You attempt to relax|^You rummage|^What were|^You sell|^You get|not worth anything to me\.\"$
	matchre return ^You slip into a hiding|^You melt into the background|^Eh\?  But you're already hidden\!|^You blend in with your surroundings|
	matchre return ^You stand|^As you stand|^You are already
	matchre burgle.leave ^You\'re going to need a free hand to rummage around in there\.
	matchre burgle.noWear ^You can\'t wear
    matchre burgle.notReady ^You should wait at least (.+) roisaen for the heat to die down\.
	matchre burgle.storageError ^But that\'s closed|^That\'s too heavy|too long to fit|too long\, even after stuffing it\, to fit
	matchre burgle.takeOver ^After a weighty pause\,
	matchre burgle.travel ^The heat has died down from your last caper\.
	put %todo
	matchwait 5
	return


return:
	return


###############################
###      FUNCTIONS
###############################
burgle.clanJustice:
	echo ###################################
	echo #####
	echo ##### YOU GOT CAUGHT IN CLAN JUSTICE!
	echo ##### GO HEAL YOURSELF!
	echo #####
	echo #####
	echo ###################################
	put #echo >log red [burgle] Caught in clan justice!
	goto burgle.done


burgle.drop:
    var location burgle.drop
    gosub put empty $0
    return


burgle.jail:
    put tdp
	pause 5
	goto burgle.jail


burgle.noWear:
	var worn NO
	goto burgle.emptyHands


burgle.plea:
	var location burgle.plea
	gosub put plead guilty


burgle.stopInvis:
    var location burgle.stopInvis
    if ("$guild" = "Necromancer") then {
        gosub put release eotb
    }
    if ("$guild" = "Thief") then {
        gosub put khri stop silence vanish
    }
    if ("$guild" = "Moon Mage") then {
        gosub put release rf
    }
    pause 0.3
    return


burgle.takeOver:
	echo ###################################
	echo #####
	echo #####       JAILED - FINE: %fine
	echo #####
	echo ###################################
	put #echo >log red [burgle] Jailed when burgling!
	goto burgle.done


burgle.wait:
	goto %location


###############################
###      ERROR AND EXIT
###############################
burgle.error:
	echo ###################################
	echo #####
	echo #####       UNKNOWN ERROR WITH $0
	echo #####
	echo ###################################
	put #echo >log red [burgle] Unknown error - $0.
	goto burgle.end


burgle.noBurgle:
	echo ###################################
	echo #####
	echo #####       Not a valid place to burgle.
	echo #####
	echo #####
	echo ###################################
	put #echo >log red [burgle] Not a valid place to burgle
	goto burgle.end


burgle.noHide:
	echo ###################################
	echo #####
	echo #####       Could not hide, not invisible
	echo #####          Try a different room
	echo #####
	echo #####
	echo ###################################
	put #echo >log red [burgle] Unable to hide.
	goto burgle.end


burgle.guardAbort:
	echo ###################################
	echo #####
	echo #####       There's a guard in the room!
	echo #####          PAY ATTENTION NEWB
	echo #####
	echo #####
	echo ###################################
	put #echo >log red [burgle] Did not burgle - guard alert!
	goto burgle.end


burgle.noLockpick:
	echo ###################################
	echo #####
	echo #####       No Lockpick?
	echo #####
	echo #####
	echo ###################################
	put #echo >log red [burgle] Missing lockpick?
    goto burgle.end


burgle.noLockpickRing:
	echo ###################################
	echo #####
	echo #####       No Lockpick Ring?
	echo #####
	echo #####
	echo ###################################
	put #echo >log red [burgle] Missing lockpick ring?
	goto burgle.end

burgle.noRope:
	echo ###################################
	echo #####
	echo #####       No Climbing Rope?
	echo #####
	echo #####
	echo ###################################
	put #echo >log red [burgle]: Missing climbing rope?
	goto burgle.end


burgle.notReady:
	echo ###################################
	echo #####
	echo #####       STILL ON COOLDOWN
	echo #####          WAIT $1 ROIS
	echo #####
	echo #####
	echo ###################################
	put #echo >log red [burgle] $1 minute cooldown left
	goto burgle.end


burgle.storageError:
	echo ###################################
	echo #####
	echo #####       ERROR WITH STORAGE? LEAVING
	echo #####
	echo ###################################
	goto burgle.leave


burgle.end:
    pause .2
    put #parse BURGLE DONE
	exit