include libmaster.cmd

var suspects steward|artist|deckhand|chef|director|beautician|bartender|boatswain|entertainer
var weapons comb|cleaver|corkscrew|knife|baton|logbook|zills|bottle




action var weapon comb when The.*slashes marked by odd perforations of the skin
action var weapon cleaver when The.*chop marks that reveal flesh and bone
action var weapon corkscrew when The.* oddly curved puncture wounds
action var weapon knife when The.*ragged edges
action var weapon baton when The.*soft tissue damage and internal bleeding
action var weapon zills when The.*clean edges
action var weapon glass bottle when The body.* severe lacerations

var murderer null
action var murderer $1 when (\S+) says while
action var murderer $1 when (\S+) says with
action var murderer $1 when (\S+) says, fingers

var location null
action var location $roomname when A thorough search of the area uncovers an area of damp stickiness on the floor where a large amount of blood has partially dried

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


#echo location is %location
eval location replacere("%location", "The Morada, ", "")
#echo location is %location

#echo put accuse %murderer with %weapon in %location
put accuse %murderer with %weapon in %location

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