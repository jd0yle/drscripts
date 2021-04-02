## Reveler's BurgleVariables Script
## v.2.0
## 05/30/2020
## Discord Reveler#6969

## v. 2.0 updates:
## Added option to hide before searches
## Added variable to drop burgled items if not in your donotpawnthis variable

## THIS IS AN INCLUDED SCRIPT IN THE BURGLE SCRIPT AND MUST BE COMPLETED BEFORE RUNNING .BURGLE.CMD

#debug 10

#Preliminary variables - don't touch
var skip NULL
var donotpawnthis NULL
var trashit NO
### Edit below here

## SET YOUR CHARACTER'S NAMES BELOW, IF NOTHING USE NULL
## MAKE SURE TO UPDATE EACH CHARACTERS VARIABLES INDIVIDUALLY BELOW
var CHARACTER1 Qizhmur
var CHARACTER2 Selesthiel
var CHARACTER3 Khurnaarti
var CHARACTER4 Inauri
var CHARACTER5 NULL
var CHARACTER6 NULL
var CHARACTER7 NULL

## SET ALL YOUR CUSTOM VARIABLES PER EACH CHARACTER IN THE BLOCKS BELOW THIS!
##### CHARACTER 1 VARIABLES
if ("$charactername" = "%CHARACTER1") then
{
# where do you want to store your stolen items?
var pack portal
# method can be RING, LOCKPICK, or ROPE; RING (uses lockpick stacker) and LOCKPICK (uses spare lockpicks) teach locks, ROPE teaches athletics. VARIABLE MUST BE IN ALL CAPS
if ($Athletics.LearningRate >= $Locksmithing.LearningRate) then var method LOCKPICK
else var method ROPE
# ringtype is the type of lockpick ring you have.  It can be any of the following: lockpick ring|lockpick case|lockpick ankle-cuff|golden key
var ringtype lockpick ring
# Use your adjective-noun for your rope
# DANCING ROPES DO NOT WORK
var ropetype braided rope
# Toggle for worn lockpick ring/rope
if ("%method" = "RING") then var worn YES
else var worn NO
# Travel location should be the city and the roomid.  Pick a room where you *know* there will not be a guard, or leave NULL NOTE: LEAVE NULL IF USING WITHIN UBERCOMBAT
var travel knife 450
var travel null
# maximum times to try to search surfaces
var maxgrabs 5
# do you want to hide before you search? Will ALWAYS be hidden for first search. ON will attempt to hide before any additional search. WARNING - MAY BE MORE RISKY BECAUSE OF ROUND TIME AND WILL REDUCE NUMBER OF POTENTIAL ROOMS YOU WILL HAVE TIME TO SEARCH
var hideme NO
# pawn YES will try to pawn your stolen goods NOTE - PUT NO IF PAWNING THROUGH UBERCOMBAT
var pawn NO
# put loot you DO NOT wish to sell here if you use pawning within .BURGLE.  The full lootpool variable is in .burgle. Separate with |
var donotpawnthis manual|scimitar|opener|keepsake box|arrow
# if you want to drop everything EXCEPT the "donotpawnthis" items, put YES here
var trashit YES
# Rooms you do not want to search.  Choose from following: kitchen|bedroom|workroom|sanctum|armory|library
var skip NULL
}

if ("$charactername" = "%CHARACTER2") then
{
# where do you want to store your stolen items?
var pack shadows
# method can be RING, LOCKPICK, or ROPE; RING (uses lockpick stacker) and LOCKPICK (uses spare lockpicks) teach locks, ROPE teaches athletics. VARIABLE MUST BE IN ALL CAPS
if ($Athletics.LearningRate >= $Locksmithing.LearningRate) then var method LOCKPICK
else var method ROPE
# ringtype is the type of lockpick ring you have.  It can be any of the following: lockpick ring|lockpick case|lockpick ankle-cuff|golden key
var ringtype lockpick ring
# Use your adjective-noun for your rope
# DANCING ROPES DO NOT WORK
var ropetype braided rope
# Toggle for worn lockpick ring/rope
var worn NO
# Travel location should be the city and the roomid.  Pick a room where you *know* there will not be a guard, or leave NULL NOTE: LEAVE NULL IF USING WITHIN UBERCOMBAT
var travel NULL
# maximum times to try to search surfaces
var maxgrabs 2
# do you want to hide before you search? Will ALWAYS be hidden for first search. ON will attempt to hide before any additional search. WARNING - MAY BE MORE RISKY BECAUSE OF ROUND TIME AND WILL REDUCE NUMBER OF POTENTIAL ROOMS YOU WILL HAVE TIME TO SEARCH
var hideme NO
# pawn YES will try to pawn your stolen goods NOTE - PUT NO IF PAWNING THROUGH UBERCOMBAT
var pawn NO
# put loot you DO NOT wish to sell here if you use pawning within .BURGLE.  The full lootpool variable is in .burgle. Separate with |
var donotpawnthis case|manual|keepsake box|arrow
# if you want to drop everything EXCEPT the "donotpawnthis" items, put YES here
var trashit YES
# Rooms you do not want to search.  Choose from following: kitchen|bedroom|workroom|sanctum|armory|library
var skip NULL
}

if ("$charactername" = "%CHARACTER1") then
{
# where do you want to store your stolen items?
var pack rucksack
# method can be RING, LOCKPICK, or ROPE; RING (uses lockpick stacker) and LOCKPICK (uses spare lockpicks) teach locks, ROPE teaches athletics. VARIABLE MUST BE IN ALL CAPS
#if ($Athletics.LearningRate >= $Locksmithing.LearningRate) then var method RING
else var method ROPE
# ringtype is the type of lockpick ring you have.  It can be any of the following: lockpick ring|lockpick case|lockpick ankle-cuff|golden key
var ringtype lockpick
# Use your adjective-noun for your rope
# DANCING ROPES DO NOT WORK
var ropetype heavy rope
# Toggle for worn lockpick ring/rope
if ("%method" = "RING") then var worn YES
else var worn NO
# Travel location should be the city and the roomid.  Pick a room where you *know* there will not be a guard, or leave NULL NOTE: LEAVE NULL IF USING WITHIN UBERCOMBAT
var travel NULL
# maximum times to try to search surfaces
var maxgrabs 5
# do you want to hide before you search? Will ALWAYS be hidden for first search.
# ON will attempt to hide before any additional search.
# WARNING - MAY BE MORE RISKY BECAUSE OF ROUND TIME AND WILL REDUCE NUMBER OF
# POTENTIAL ROOMS YOU WILL HAVE TIME TO SEARCH
var hideme NO
# pawn YES will try to pawn your stolen goods NOTE - PUT NO IF PAWNING THROUGH UBERCOMBAT
var pawn NO
# put loot you DO NOT wish to sell here if you use pawning within .BURGLE.  The full lootpool variable is in .burgle. Separate with |
var donotpawnthis manual|guide|scimitar|opener|keepsake box|arrow
# if you want to drop everything EXCEPT the "donotpawnthis" items, put YES here
var trashit NO
# Rooms you do not want to search.  Choose from following: kitchen|bedroom|workroom|sanctum|armory|library
var skip NULL
}

if ("$charactername" = "%CHARACTER2") then
{
# where do you want to store your stolen items?
var pack satchel
# method can be RING, LOCKPICK, or ROPE; RING (uses lockpick stacker) and LOCKPICK (uses spare lockpicks) teach locks, ROPE teaches athletics. VARIABLE MUST BE IN ALL CAPS
#if ($Athletics.LearningRate >= $Locksmithing.LearningRate) then var method RING
else var method ROPE
# ringtype is the type of lockpick ring you have.  It can be any of the following: lockpick ring|lockpick case|lockpick ankle-cuff|golden key
var ringtype lockpick ring
# Use your adjective-noun for your rope
# DANCING ROPES DO NOT WORK
var ropetype braided rope
# Toggle for worn lockpick ring/rope
if ("%method" = "RING") then var worn YES
else var worn YES
# Travel location should be the city and the roomid.  Pick a room where you *know* there will not be a guard, or leave NULL NOTE: LEAVE NULL IF USING WITHIN UBERCOMBAT
var travel NULL
# maximum times to try to search surfaces
var maxgrabs 5
# do you want to hide before you search? Will ALWAYS be hidden for first search.
# ON will attempt to hide before any additional search.
# WARNING - MAY BE MORE RISKY BECAUSE OF ROUND TIME AND WILL REDUCE NUMBER OF
# POTENTIAL ROOMS YOU WILL HAVE TIME TO SEARCH
var hideme NO
# pawn YES will try to pawn your stolen goods NOTE - PUT NO IF PAWNING THROUGH UBERCOMBAT
var pawn NO
# put loot you DO NOT wish to sell here if you use pawning within .BURGLE.  The full lootpool variable is in .burgle. Separate with |
var donotpawnthis manual|guide|scimitar|opener|keepsake box|arrow
# if you want to drop everything EXCEPT the "donotpawnthis" items, put YES here
var trashit NO
# Rooms you do not want to search.  Choose from following: kitchen|bedroom|workroom|sanctum|armory|library
var skip NULL
}

if ("$charactername" = "%CHARACTER5") then
{
# where do you want to store your stolen items?
var pack carryall
# method can be RING, LOCKPICK, or ROPE; RING (uses lockpick stacker) and LOCKPICK (uses spare lockpicks) teach locks, ROPE teaches athletics. VARIABLE MUST BE IN ALL CAPS
var method ROPE
# ringtype is the type of lockpick ring you have.  It can be any of the following: lockpick ring|lockpick case|lockpick ankle-cuff|golden key
var ringtype lockpick ring
# Use your adjective-noun for your rope
# DANCING ROPES DO NOT WORK
var ropetype braided rope
# Toggle for worn lockpick ring/rope
var worn YES
# Travel location should be the city and the roomid.  Pick a room where you *know* there will not be a guard, or leave NULL NOTE: LEAVE NULL IF USING WITHIN UBERCOMBAT
var travel NULL
# maximum times to try to search surfaces
var maxgrabs 2
# do you want to hide before you search? Will ALWAYS be hidden for first search. ON will attempt to hide before any additional search. WARNING - MAY BE MORE RISKY BECAUSE OF ROUND TIME AND WILL REDUCE NUMBER OF POTENTIAL ROOMS YOU WILL HAVE TIME TO SEARCH
var hideme NO
# pawn YES will try to pawn your stolen goods NOTE - PUT NO IF PAWNING THROUGH UBERCOMBAT
var pawn NO
# put loot you DO NOT wish to sell here if you use pawning within .BURGLE.  The full lootpool variable is in .burgle. Separate with |
var donotpawnthis keepsake box|arrow
# if you want to drop everything EXCEPT the "donotpawnthis" items, put YES here
var trashit NO
# Rooms you do not want to search.  Choose from following: kitchen|bedroom|workroom|sanctum|armory|library
var skip NULL
}

if ("$charactername" = "%CHARACTER6") then
{
# where do you want to store your stolen items?
var pack rucksack
# method can be RING, LOCKPICK, or ROPE; RING (uses lockpick stacker) and LOCKPICK (uses spare lockpicks) teach locks, ROPE teaches athletics. VARIABLE MUST BE IN ALL CAPS
var method ROPE
# ringtype is the type of lockpick ring you have.  It can be any of the following: lockpick ring|lockpick case|lockpick ankle-cuff|golden key
var ringtype lockpick ring
# Use your adjective-noun for your rope
# DANCING ROPES DO NOT WORK
var ropetype heavy rope
# Toggle for worn lockpick ring/rope
var worn NO
# Travel location should be the city and the roomid.  Pick a room where you *know* there will not be a guard, or leave NULL NOTE: LEAVE NULL IF USING WITHIN UBERCOMBAT
var travel NULL
# maximum times to try to search surfaces
var maxgrabs 3
# do you want to hide before you search? Will ALWAYS be hidden for first search. ON will attempt to hide before any additional search. WARNING - MAY BE MORE RISKY BECAUSE OF ROUND TIME AND WILL REDUCE NUMBER OF POTENTIAL ROOMS YOU WILL HAVE TIME TO SEARCH
var hideme NO
# pawn YES will try to pawn your stolen goods NOTE - PUT NO IF PAWNING THROUGH UBERCOMBAT
var pawn YES
# put loot you DO NOT wish to sell here if you use pawning within .BURGLE.  The full lootpool variable is in .burgle. Separate with |
var donotpawnthis keepsake box|arrow
# if you want to drop everything EXCEPT the "donotpawnthis" items, put YES here
var trashit NO
# Rooms you do not want to search.  Choose from following: kitchen|bedroom|workroom|sanctum|armory|library
var skip NULL
}

if ("$charactername" = "%CHARACTER7") then
{
# where do you want to store your stolen items?
var pack sidebag
# method can be RING, LOCKPICK, or ROPE; RING (uses lockpick stacker) and LOCKPICK (uses spare lockpicks) teach locks, ROPE teaches athletics. VARIABLE MUST BE IN ALL CAPS
var method lockpick
# ringtype is the type of lockpick ring you have.  It can be any of the following: lockpick ring|lockpick case|lockpick ankle-cuff|golden key
var ringtype lockpick ring
# Use your adjective-noun for your rope
# DANCING ROPES DO NOT WORK
var ropetype heavy rope
# Toggle for worn lockpick ring/rope
var worn NO
# Travel location should be the city and the roomid.  Pick a room where you *know* there will not be a guard, or leave NULL NOTE: LEAVE NULL IF USING WITHIN UBERCOMBAT
var travel NULL
# maximum times to try to search surfaces
var maxgrabs 2
# do you want to hide before you search? Will ALWAYS be hidden for first search. ON will attempt to hide before any additional search. WARNING - MAY BE MORE RISKY BECAUSE OF ROUND TIME AND WILL REDUCE NUMBER OF POTENTIAL ROOMS YOU WILL HAVE TIME TO SEARCH
var hideme YES
# pawn YES will try to pawn your stolen goods NOTE - PUT NO IF PAWNING THROUGH UBERCOMBAT
var pawn NO
# put loot you DO NOT wish to sell here if you use pawning within .BURGLE.  The full lootpool variable is in .burgle. Separate with |
var donotpawnthis bolt|keepsake box|arrow
# if you want to drop everything EXCEPT the "donotpawnthis" items, put YES here
var trashit NO
# Rooms you do not want to search.  Choose from following: kitchen|bedroom|workroom|sanctum|armory|library
var skip kitchen
}

######### END USER VARIABLES DON'T TOUCH ANYTHING ELSE



put #var BURGLE.PACK %pack
put #var BURGLE.METHOD %method
put #var BURGLE.RINGTYPE %ringtype
put #var BURGLE.ROPETYPE %ropetype
put #var BURGLE.WORN %worn
put #var BURGLE.TRAVEL %travel
put #var BURGLE.MAXGRABS %maxgrabs
put #var BURGLE.PAWN %pawn
put #var BURGLE.KEEP %donotpawnthis
put #var BURGLE.TRASH %trashit
put #var BURGLE.HIDE %hideme
put #var BURGLE.SKIP %skip
