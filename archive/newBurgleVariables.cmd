## Reveler's BurgleVariables Script
## v.4.0
## 06/15/2021
## Discord Reveler#6969
##
## Version 5.0 Changes - SpicyDiapsid
##		Modified burgle variables to use temp vars.
##		Cleaned up character variable sections for improved readability.
##		Added variable help section and lootpool section.
## --------------
## THIS IS AN INCLUDED SCRIPT IN THE BURGLE SCRIPT AND MUST BE COMPLETED BEFORE RUNNING .BURGLE.CMD


###############################
###      VARIABLES
###############################
# Add your character names below and update the variables for them.
var CHARACTER1 NULL
var CHARACTER2 NULL
var CHARACTER3 NULL
var CHARACTER4 NULL


if ("$charactername" = "%CHARACTER1") then {
	# ------ ATTEMPT HANDLING ------
	# hideBefore: NO/NULL, YES/ON
	# maxGrabs: 0-7
	# skipRoom: (kitchen|bedroom|workroom|sanctum|armory|library)
	# travel: location roomid  ie: knife 450
	put #tvar char.burgle.hideBefore NULL
	put #tvar char.burgle.maxGrabs 5
	put #tvar char.burgle.skipRoom NULL
	put #tvar char.burgle.travel NULL

	# ------ ENTRY HANDLING ------
	# entyMethod: LOCKPICK, ROPE, RING, or TOGGLE.
	# lockpickRingType: lockpick ring, lockpick case, lockpick ankle-cuff, golden key.
	# ropeType: heavy rope, braided rope
	# ropeWorn: NO/NULL, YES/ON
	put #tvar char.burgle.entryMethod TOGGLE
	put #tvar char.burgle.lockpickRingType lockpick ring
	put #tvar char.burgle.ropeType heavy rope
	put #tvar char.burgle.ropeWorn NULL

	# ------ LOOT HANDLING ------
	# pawn:  NO/NULL, YES/ON
	# keepThisList:  NULL or array
	# trashAllExceptKeep:  NO/NULL, YES/ON
	# trashThisList:  NULL or array
	put #tvar char.burgle.pawnAll NULL
	put #tvar char.burgle.keepThisList memory orb|keepsake box|jewelry box
	put #tvar char.burgle.trashAllExceptKeep NULL
	put #tvar char.burgle.trashThisList mixing stick|sieve

	# ------ STORAGE HANDLING ------
	# container: pack, rucksack, portal, shadows, backpack, satchel, etc.
	put #tvar char.inv.container.burgle pack
}

if ("$charactername" = "%CHARACTER2") then {
	# ------ ATTEMPT HANDLING ------
	# hideBefore: NO/NULL, YES/ON
	# maxGrabs: 0-7
	# skipRoom: (kitchen|bedroom|workroom|sanctum|armory|library)
	# travel: location roomid  ie: knife 450
	put #tvar char.burgle.hideBefore NULL
	put #tvar char.burgle.maxGrabs 5
	put #tvar char.burgle.skipRoom NULL
	put #tvar char.burgle.travel NULL

	# ------ ENTRY HANDLING ------
	# entyMethod: LOCKPICK, ROPE, RING, or TOGGLE.
	# lockpickRingType: lockpick ring, lockpick case, lockpick ankle-cuff, golden key.
	# ropeType: heavy rope, braided rope
	# ropeWorn: NO/NULL, YES/ON
	put #tvar char.burgle.entryMethod TOGGLE
	put #tvar char.burgle.lockpickRingType lockpick ring
	put #tvar char.burgle.ropeType heavy rope
	put #tvar char.burgle.ropeWorn NULL

	# ------ LOOT HANDLING ------
	# pawn:  NO/NULL, YES/ON
	# keepThisList:  NULL or array
	# trashAllExceptKeep:  NO/NULL, YES/ON
	# trashThisList:  NULL or array
	put #tvar char.burgle.pawnAll NULL
	put #tvar char.burgle.keepThisList memory orb|keepsake box|jewelry box
	put #tvar char.burgle.trashAllExceptKeep NULL
	put #tvar char.burgle.trashThisList mixing stick|sieve

	# ------ STORAGE HANDLING ------
	# container: pack, rucksack, portal, shadows, backpack, satchel, etc.
	put #tvar char.inv.container.burgle pack
}

if ("$charactername" = "%CHARACTER3") then {
	# ------ ATTEMPT HANDLING ------
	# hideBefore: NO/NULL, YES/ON
	# maxGrabs: 0-7
	# skipRoom: (kitchen|bedroom|workroom|sanctum|armory|library)
	# travel: location roomid  ie: knife 450
	put #tvar char.burgle.hideBefore NULL
	put #tvar char.burgle.maxGrabs 5
	put #tvar char.burgle.skipRoom NULL
	put #tvar char.burgle.travel NULL

	# ------ ENTRY HANDLING ------
	# entyMethod: LOCKPICK, ROPE, RING, or TOGGLE.
	# lockpickRingType: lockpick ring, lockpick case, lockpick ankle-cuff, golden key.
	# ropeType: heavy rope, braided rope
	# ropeWorn: NO/NULL, YES/ON
	put #tvar char.burgle.entryMethod TOGGLE
	put #tvar char.burgle.lockpickRingType lockpick ring
	put #tvar char.burgle.ropeType heavy rope
	put #tvar char.burgle.ropeWorn NULL

	# ------ LOOT HANDLING ------
	# pawn:  NO/NULL, YES/ON
	# keepThisList:  NULL or array
	# trashAllExceptKeep:  NO/NULL, YES/ON
	# trashThisList:  NULL or array
	put #tvar char.burgle.pawnAll NULL
	put #tvar char.burgle.keepThisList memory orb|keepsake box|jewelry box
	put #tvar char.burgle.trashAllExceptKeep NULL
	put #tvar char.burgle.trashThisList mixing stick|sieve

	# ------ STORAGE HANDLING ------
	# container: pack, rucksack, portal, shadows, backpack, satchel, etc.
	put #tvar char.inv.container.burgle pack
}

if ("$charactername" = "%CHARACTER4") then {
	# ------ ATTEMPT HANDLING ------
	# hideBefore: NO/NULL, YES/ON
	# maxGrabs: 0-7
	# skipRoom: (kitchen|bedroom|workroom|sanctum|armory|library)
	# travel: location roomid  ie: knife 450
	put #tvar char.burgle.hideBefore NULL
	put #tvar char.burgle.maxGrabs 5
	put #tvar char.burgle.skipRoom NULL
	put #tvar char.burgle.travel NULL

	# ------ ENTRY HANDLING ------
	# entyMethod: LOCKPICK, ROPE, RING, or TOGGLE.
	# lockpickRingType: lockpick ring, lockpick case, lockpick ankle-cuff, golden key.
	# ropeType: heavy rope, braided rope
	# ropeWorn: NO/NULL, YES/ON
	put #tvar char.burgle.entryMethod TOGGLE
	put #tvar char.burgle.lockpickRingType lockpick ring
	put #tvar char.burgle.ropeType heavy rope
	put #tvar char.burgle.ropeWorn NULL

	# ------ LOOT HANDLING ------
	# pawn:  NO/NULL, YES/ON
	# keepThisList:  NULL or array
	# trashAllExceptKeep:  NO/NULL, YES/ON
	# trashThisList:  NULL or array
	put #tvar char.burgle.pawnAll NULL
	put #tvar char.burgle.keepThisList memory orb|keepsake box|jewelry box
	put #tvar char.burgle.trashAllExceptKeep NULL
	put #tvar char.burgle.trashThisList mixing stick|sieve

	# ------ STORAGE HANDLING ------
	# container: pack, rucksack, portal, shadows, backpack, satchel, etc.
	put #tvar char.inv.container.burgle pack
}

goto burgleVariables.done
###############################
###      VARIABLE HELP
###############################
# Container - Where do you want to store your stolen items?  If you are using an eddy, set the noun to portal.
# EntryMethod - How are you getting in?
#	RING - lockpick stacker items and teaches Locksmithing
#	LOCKPICK - spare lockpick and teaches Locksmithing
#	ROPE - braided or heavy rope and teaches Athletics
#	TOGGLE - Will swap between an option that teaches Athletics and Locksmithing based on your learning rates.
#
# HideBeforeAttempt - Do you want to hide before each surface search?  You will always be hidden for the first search.  Note:  This increases risk due to round time and reduces number of potential rooms.  Options:  NO/NULL, YES/ON.
#
# KeepThisList - List of loot items you do not want to pawn or trash.  See full lootpool below.  If adding more than one item, must be in an array.  ie:  memory orb|keepsake box
#
# LockpickRingType - The type of lockpick stacker you have.  You must be wearing this.  Options: lockpick ring, lockpick case, lockpick ankle-cuff, golden key
#
# MaxGrabs - Maximum times to try to search surfaces.  Suggested options: 0-7
#
# PawnAll - YES/ON will try to pawn all stolen goods not present in the KeepThisList variable.  Otherwise use NO/NULL.
#
# RopeType - The type of rope you are using.  Note:  Dancing ropes do not work.
#
# RopeWorn - If you wear your rope or not.  Options are NO/NULL or YES/ON.
#
# SkipRooms - Rooms you do not want to search.  If adding more than one room, must be in an array.  ie:  kitchen|sanctum.  If not skipping any rooms, set to NO/NULL.
#
# TrashAll - YES/ON will drop/trash everything that is not present in the KeepThisList.    Otherwise use NO/NULL.
#
# TrashThisList - List of loot items you want to always trash.  If adding more than one item, must be in an array.  ie:  mixing stick|sieve  If not using this, set to NO/NULL.
#
# Travel - Location should be the city and the roomid or left NULL.


###############################
###      FULL LOOT POOL
###############################
# Armory:
# arrows, bolts, briquet, crossbow, cudgel, dagger, hammer, hauberk, gloves, leathers, longsword, plate, scimitar, shield, sipar, stick, stones.
# Bedroom:
# bangles, bank, bathrobe, bear, blanket, (pajama) bottoms, (jewelry/keepsake) box, choker, cloak, comb, cube, cufflinks, diary, fabric, handkerchief, locket, mirror, nightcap, nightgown, pajamas, pillow, razor, slippers, (pajama) top.
# Kitchen:
# basket, bowl, (recipe) box, broom, cylinder, helm, (cider) jug, knife, knives, lunchbox, mortar, (house) mouse, napkin, pestle, (kitchen) rat, shakers, sieve, skillet, snare, stick, sphere, stove, tankard, tote, towel, twine, vase.
# Library:
# book, case, cowbell, fan, harp, guide, lamp, leaflet, manual, paperweight, portrait, quill, ring, scroll, slate.
# Sanctum:
# amulet, ball, blossom, bracer, case, charts, kaleidoscope, lens, opener, orb, prism, ring, rod, statuette, telescope.
# Workroom:
# apron, brush, burin, case, distaff, ledger, oil, pins, rasp, rod, scissors, shaper.


burgleVariables.done:
	pause .2
	put #parse BURGLEVARIABLES DONE
	exit