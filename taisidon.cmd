include libmaster.cmd

###############################
###      VARIABLES
###############################
var suspects artist|bartender|beautician|boatswain|chef|deckhand|director|entertainer|steward
var weapons baton|cleaver|comb|corkscrew|bottle|knife|logbook|paintbrush|zills

action var weapon baton when The.*soft tissue damage and internal bleeding
action var weapon bottle when The.*severe lacerations
action var weapon cleaver when The.*chop marks that reveal flesh and bone
action var weapon comb when The.*slashes marked by odd perforations of the skin
action var weapon corkscrew when The.* oddly curved puncture wounds
action var weapon knife when The.*ragged edges
action var weapon logbook when The.*severe blunt trauma
action var weapon paintbrush when The.*deep and lethal puncture wounds
action var weapon zills when The.*clean edges

action var weapon glass bottle when The.*severe lacerations
action var weapon paintbrush when The.*deep and lethal puncture wounds
action var weapon logbook when The.*gashes and severe blunt trauma

var murderer null
action var murderer $1 when (\S+) says while
action var murderer $1 when (\S+) says with
action var murderer $1 when (\S+) says coughing
action var murderer $1 when (\S+) says, fingers
action var murderer $1 when (\S+) says\s

action var murderer $1 when (\S+) says\s

var location null
action var location $roomname when A thorough search of the area uncovers an area of damp stickiness on the floor where a large amount of blood has partially dried


###############################
###      PASSES
###############################
if ("$righthandnoun" <> "passes" && "$lefthandnoun" <> "passes") then {
    gosub get my passes

    if ("$righthandnoun" <> "passes" && "$lefthandnoun" <> "passes") then {
        put #echo Red >Log [taisidon] Out of passes!
        exit
    }
}
put redeem pass
put redeem pass
put ask coord about access
pause .2

###############################
###      MAIN
###############################
put study corpse
pause
echo weapon was %weapon

move up
gosub investigateRoom
move aft
gosub investigateRoom
move starboard
gosub investigateRoom
move aft
gosub investigateRoom

move forward
move port
move port
gosub investigateRoom

move starboard
move up
gosub investigateRoom

eval location replacere("%location", "The Morada, ", "")
put accuse %murderer with %weapon in %location

pause 1
if ("$righthandnoun" = "coupon" || "$lefthandnoun" = "coupon") then {
    put #echo Green >Log [taisidon] Gained 1 coupon.
    gosub stow my coupon
} else {
    put #echo Red >Log [taisidon] Failed.
}
exit

investigateRoom:
	pause
	if (matchre("$roomobjs", "(%suspects)")) then {
		var suspect $1
		if ("%murderer" = "null") then {
			#echo put ask %suspect about alibi
			put ask %suspect about alibi
			waitforre A.*says
		}
	}

	if ("%location" = "null") then {
		put search
		waitforre ^A thorough
		pause
	}
	return