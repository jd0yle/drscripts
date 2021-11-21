include libmaster.cmd
include var_mobs.cmd
###############################
###    IDLE ACTION TRIGGERS
###############################
action goto targetExit when ^You think that you've killed enough (.*) and should|You've completed 10 of the 10 things you were asked to do.
action goto targetCast when Your formation of a targeting pattern around
action goto targetLoop when ^Your concentration slips for a moment|^Your concentration lapses
action goto targetFaceNext when ^Target what|^Your pattern dissipates with the loss of your target\.
action put target when It is already dead\.
action var taskProgress 10 when The Scarecrow collapses to the ground, its tattered robe fluttering as it falls, and the burlap sack that comprises its head splits open, revealing nothing but straw inside\.|Harawep's Spider collapses to the ground on its back with its legs flailing wildly, looking defeated but not quite dead\.
action put target %targetCreature when But you're already preparing a spell\!
action var taskProgress $1 when You've completed (.*) of the 10 things you were asked to do\.
action goto targetCheck when ^You think that the (.*)'s death counts toward your (.*) kill total\.
action put #echo >%logWindow Yellow Scarecrow appears!;goto corn.scarecrow;put #play NewRank when You hear sinister laughter as the Scarecrow invades the Corn Maze!
action put #echo >%logWindow Yellow Spider appears!;put #play NewRank when A hissing sound echoes through the Corn Maze as Harawep's Spider makes its appearance!


###############################
###    VARIABLES
###############################
if (!($lastHuntGametime >0)) then put #var lastHuntGametime 0
var targetCreature 0
var taskProgress 0
var targetSpell pd
var targetMana 30
var targetLocation chest
var targetFocus lightning bolt

if_1 then {
    if ("%1" <> "") then {
        var targetCreature %1
    } else {
        put #echo >Log [target] Proper syntax is .target (creature)  Additional options:  spider, scarecrow
        exit
    }
}

if !(matchre("$righthand|$lefthand", "%targetFocus")) then {
    gosub get my %targetFocus
    gosub invoke my %targetFocus
}
###############################
###    MAIN
###############################
targetCheck:
    gosub loot
    gosub runScript loot
    gosub task
    put #echo >log [target] Task Progress - %taskProgress/10
    if (%taskProgress = 10) then {
        gosub targetExit
    } else {
        gosub targetLoop
    }


targetLoop:
    #gosub targetHunt
    if ($monstercount = 0) then {
        put #echo >Log [target] No mobs.
        goto targetLoop
    }
    if ("%targetSpell" <> "burn") then {
        gosub target %targetSpell %targetMana %targetCreature %targetLocation
    } else {
        gosub target %targetSpell %targetMana %targetCreature
    }
    waitforre ^Your formation of a targeting pattern
    goto targetCast
    goto targetLoop


###############################
###    UTILITY
###############################
targetCast:
    gosub cast
    goto targetLoop


targetFaceNext:
    gosub face next
    gosub target
    goto targetLoop


targetHunt:
    gosub hunt.onTimer
    return


targetExit:
    gosub stow
    gosub stow left
    pause .001
    put #parse TARGET DONE
    exit