## Reveler's BurgleVariables Script
## v.3.0
## 04/03/2021
## Discord Reveler#6969

## v. 2.1 updates:
## Added option to hide before searches
## Added variable to drop all burgled items if not in your donotpawnthis variable
## Added variable to drop certain burgled items
## v. 3.0 updates:
## Changed var for burgle type to RING|LOCKPICK|ROPE|TOGGLE - with "TOGGLE" will pick the skill with lowest learning rate.  Must have worn lockpick ring for TOGGLE.

## THIS IS AN INCLUDED SCRIPT IN THE BURGLE SCRIPT AND MUST BE COMPLETED BEFORE RUNNING .BURGLE.CMD

#debug 10

#Preliminary variables - don't touch
var skip NULL
var donotpawnthis NULL
var trashall NO
### Edit below here


## SET YOUR CHARACTER'S NAMES BELOW, IF NOTHING USE NULL
## MAKE SURE TO UPDATE EACH CHARACTERS VARIABLES INDIVIDUALLY BELOW
var CHARACTER1 Qizhmur
var CHARACTER2 Selesthiel
var CHARACTER3 Khurnaarti
var CHARACTER4 Inauri

## SET ALL YOUR CUSTOM VARIABLES PER EACH CHARACTER IN THE BLOCKS BELOW THIS!
##### CHARACTER 1 VARIABLES
if ("$charactername" = "%CHARACTER1") then
{
# do you use the temporal eddy for storage of items?  If yes, list the items in an array, with LOOT for burgle loot, ROPE for burgle rope entry, RING for lockpick ring and LOCKPICK for loose lockpicks.  NULL if you don't use the eddy
var eddy NULL
# where do you want to store your stolen items?  If storing in your eddy, you must use noun "portal"
var pack portal
# method can be RING, LOCKPICK, ROPE, or TOGGLE; RING (uses lockpick stacker) and LOCKPICK (uses spare lockpicks) teach locks, ROPE teaches athletics.
# TOGGLE will swap between RING and ROPE - must set your lockpick stacker variable and rope variable
if ($Athletics.LearningRate >= $Locksmithing.LearningRate) then var method LOCKPICK
else var method ROPE
# ringtype is the type of lockpick ring you have.  It can be any of the following: lockpick ring|lockpick case|lockpick ankle-cuff|golden key
var ringtype lockpick ring
# Use your adjective-noun for your rope
# DANCING ROPES DO NOT WORK
var ropetype braided rope
# Toggle for worn rope - Note - MUST wear lockpick ring
var worn NO
# Travel location should be the city and the roomid.  Pick a room where you *know* there will not be a guard, or leave NULL NOTE: LEAVE NULL IF USING WITHIN UBERCOMBAT
var travel knife 450
var travel NULL
# maximum times to try to search surfaces
var maxgrabs 5
# do you want to hide before you search? Will ALWAYS be hidden for first search. ON will attempt to hide before any additional search. WARNING - MAY BE MORE RISKY BECAUSE OF ROUND TIME AND WILL REDUCE NUMBER OF POTENTIAL ROOMS YOU WILL HAVE TIME TO SEARCH
var hideme NO
# pawn YES will try to pawn your stolen goods NOTE - PUT NO IF PAWNING THROUGH UBERCOMBAT
var pawn NO
# put loot you DO NOT wish to sell here if you use pawning within .BURGLE.  The full lootpool variable is in .burgle. Separate with |
var donotpawnthis manual|keepsake box|memory orb
# if you want to drop everything EXCEPT the "donotpawnthis" items, put YES here
var trashall YES
# if you want to drop SOME things, put them here
var trashthings NULL
# Rooms you do not want to search.  Choose from following: kitchen|bedroom|workroom|sanctum|armory|library
var skip NULL
}

if ("$charactername" = "%CHARACTER2") then
{
# do you use the temporal eddy for storage of items?  If yes, list the items in an array, with LOOT for burgle loot, ROPE for burgle rope entry, RING for lockpick ring and LOCKPICK for loose lockpicks.  NULL if you don't use the eddy
var eddy NULL
# where do you want to store your stolen items?  If storing in your eddy, you must use noun "portal"
var pack shadows
# method can be RING, LOCKPICK, ROPE, or TOGGLE; RING (uses lockpick stacker) and LOCKPICK (uses spare lockpicks) teach locks, ROPE teaches athletics.
# TOGGLE will swap between RING and ROPE - must set your lockpick stacker variable and rope variable
if ($Athletics.LearningRate >= $Locksmithing.LearningRate) then var method LOCKPICK
else var method ROPE
# ringtype is the type of lockpick ring you have.  It can be any of the following: lockpick ring|lockpick case|lockpick ankle-cuff|golden key
var ringtype lockpick ring
# Use your adjective-noun for your rope
# DANCING ROPES DO NOT WORK
var ropetype braided rope
# Toggle for worn rope - Note - MUST wear lockpick ring
var worn NO
# Travel location should be the city and the roomid.  Pick a room where you *know* there will not be a guard, or leave NULL NOTE: LEAVE NULL IF USING WITHIN UBERCOMBAT
var travel NULL
# maximum times to try to search surfaces
var maxgrabs 5
# do you want to hide before you search? Will ALWAYS be hidden for first search. ON will attempt to hide before any additional search. WARNING - MAY BE MORE RISKY BECAUSE OF ROUND TIME AND WILL REDUCE NUMBER OF POTENTIAL ROOMS YOU WILL HAVE TIME TO SEARCH
var hideme NO
# pawn YES will try to pawn your stolen goods NOTE - PUT NO IF PAWNING THROUGH UBERCOMBAT
var pawn NO
# put loot you DO NOT wish to sell here if you use pawning within .BURGLE.  The full lootpool variable is in .burgle. Separate with |
var donotpawnthis manual|keepsake box|memory orb
# if you want to drop everything EXCEPT the "donotpawnthis" items, put YES here
var trashall NO
# if you want to drop SOME things, put them here
var trashthings blanket|kaleidoscope|earring|ring
# Rooms you do not want to search.  Choose from following: kitchen|bedroom|workroom|sanctum|armory|library
var skip NULL
}

if ("$charactername" = "%CHARACTER3") then
{
# do you use the temporal eddy for storage of items?  If yes, list the items in an array, with LOOT for burgle loot, ROPE for burgle rope entry, RING for lockpick ring and LOCKPICK for loose lockpicks.  NULL if you don't use the eddy
var eddy NULL
# where do you want to store your stolen items?  If storing in your eddy, you must use noun "portal"
var pack rucksack
# method can be RING, LOCKPICK, ROPE, or TOGGLE; RING (uses lockpick stacker) and LOCKPICK (uses spare lockpicks) teach locks, ROPE teaches athletics.
# TOGGLE will swap between RING and ROPE - must set your lockpick stacker variable and rope variable
if ($Athletics.LearningRate >= $Locksmithing.LearningRate) then var method RING
else var method ROPE
# ringtype is the type of lockpick ring you have.  It can be any of the following: lockpick ring|lockpick case|lockpick ankle-cuff|golden key
var ringtype lockpick ring
# Use your adjective-noun for your rope
# DANCING ROPES DO NOT WORK
var ropetype heavy rope
# Toggle for worn rope - Note - MUST wear lockpick ring
var worn NO
# Travel location should be the city and the roomid.  Pick a room where you *know* there will not be a guard, or leave NULL NOTE: LEAVE NULL IF USING WITHIN UBERCOMBAT
var travel NULL
# maximum times to try to search surfaces
var maxgrabs 5
# do you want to hide before you search? Will ALWAYS be hidden for first search. ON will attempt to hide before any additional search. WARNING - MAY BE MORE RISKY BECAUSE OF ROUND TIME AND WILL REDUCE NUMBER OF POTENTIAL ROOMS YOU WILL HAVE TIME TO SEARCH
var hideme NO
# pawn YES will try to pawn your stolen goods NOTE - PUT NO IF PAWNING THROUGH UBERCOMBAT
var pawn NO
# put loot you DO NOT wish to sell here if you use pawning within .BURGLE.  The full lootpool variable is in .burgle. Separate with |
var donotpawnthis manual|guide|keepsake box|jewelry box|memory orb
# if you want to drop everything EXCEPT the "donotpawnthis" items, put YES here
var trashall NO
# if you want to drop SOME things, put them here
var trashthings basket|kaleidoscope|sieve|stick|diary
# Rooms you do not want to search.  Choose from following: kitchen|bedroom|workroom|sanctum|armory|library
var skip NULL
}

if ("$charactername" = "%CHARACTER4") then
{
# do you use the temporal eddy for storage of items?  If yes, list the items in an array, with LOOT for burgle loot, ROPE for burgle rope entry, RING for lockpick ring and LOCKPICK for loose lockpicks.  NULL if you don't use the eddy
var eddy NULL
# where do you want to store your stolen items?  If storing in your eddy, you must use noun "portal"
var pack satchel
# method can be RING, LOCKPICK, ROPE, or TOGGLE; RING (uses lockpick stacker) and LOCKPICK (uses spare lockpicks) teach locks, ROPE teaches athletics.
# TOGGLE will swap between RING and ROPE - must set your lockpick stacker variable and rope variable
if ($Athletics.LearningRate >= $Locksmithing.LearningRate) then var method LOCKPICK
else var method ROPE
# ringtype is the type of lockpick ring you have.  It can be any of the following: lockpick ring|lockpick case|lockpick ankle-cuff|golden key
var ringtype lockpick ring
# Use your adjective-noun for your rope
# DANCING ROPES DO NOT WORK
var ropetype braided rope
# Toggle for worn rope - Note - MUST wear lockpick ring
var worn YES
# Travel location should be the city and the roomid.  Pick a room where you *know* there will not be a guard, or leave NULL NOTE: LEAVE NULL IF USING WITHIN UBERCOMBAT
var travel NULL
# maximum times to try to search surfaces
var maxgrabs 5
# do you want to hide before you search? Will ALWAYS be hidden for first search. ON will attempt to hide before any additional search. WARNING - MAY BE MORE RISKY BECAUSE OF ROUND TIME AND WILL REDUCE NUMBER OF POTENTIAL ROOMS YOU WILL HAVE TIME TO SEARCH
var hideme NO
# pawn YES will try to pawn your stolen goods NOTE - PUT NO IF PAWNING THROUGH UBERCOMBAT
var pawn NO
# put loot you DO NOT wish to sell here if you use pawning within .BURGLE.  The full lootpool variable is in .burgle. Separate with |
var donotpawnthis manual|guide|scimitar|opener|keepsake box|arrow
# if you want to drop everything EXCEPT the "donotpawnthis" items, put YES here
var trashall NO
# if you want to drop SOME things, put them here
var trashthings NULL
# Rooms you do not want to search.  Choose from following: kitchen|bedroom|workroom|sanctum|armory|library
var skip NULL
}


######### END USER VARIABLES DON'T TOUCH ANYTHING ELSE


if matchre("%method", "(?i)toggle") then
{
	if ($Athletics.LearningRate >= $Locksmithing.LearningRate) then var method RING
else var method ROPE
}

put #var BURGLE.EDDY %eddy
put #var BURGLE.PACK %pack
put #var BURGLE.METHOD %method
put #var BURGLE.RINGTYPE %ringtype
put #var BURGLE.ROPETYPE %ropetype
put #var BURGLE.WORN %worn
put #var BURGLE.TRAVEL %travel
put #var BURGLE.MAXGRABS %maxgrabs
put #var BURGLE.PAWN %pawn
put #var BURGLE.KEEP %donotpawnthis
put #var BURGLE.TRASHALL %trashall
put #var BURGLE.TRASHITEMS %trashthings
put #var BURGLE.HIDE %hideme
put #var BURGLE.SKIP %skip
