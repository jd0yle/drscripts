include libmaster.cmd

var nextTask null
action var nextTask $1 when I'd like you to.*(BUILD|DISARM|FORAGE|POKE|PULL|SCREAM|SEARCH|TOUCH|WAVE)
action var nextTask $1 when You believe you should.*(BUILD|DISARM|FORAGE|POKE|PULL|SCREAM|SEARCH|TOUCH|WAVE)

action goto loop when eval $roomname

loop:
	if ("$roomname" = "Sleeping Dragon Corn Maze, Small Clearing") then {
		gosub open my sack
		gosub inv my sack
		gosub stow my sack
		put go path
		put go trail
		var nextTask null
		pause
		echo READY TO START AGAIN
	}

	if ("$roomname" = "Sleeping Dragon Corn Maze, Exit") then {
		gosub stow right
		gosub stow left
		gosub get my pass
		if ("$righthand" = "Empty") then {
			echo OUT OF PASSES
			exit
		}
		put redeem my pass
		put redeem my pass
		pause
		gosub stow right
		gosub stow left
		put join harried halfling
		put join harried halfling
		pause

		goto loop
	}

	if ("%nextTask" = "null") then {
		if (contains("$roomname", "Corn Maze,")) then put task
		pause 1
		goto loop
	}

	if ("%nextTask" = "BUILD") then gosub build
	if ("%nextTask" = "DISARM") then {
		gosub search
		gosub disarm trap
	}
	if ("%nextTask" = "FORAGE") then gosub forage
	if ("%nextTask" = "POKE") then gosub poke employee
	if ("%nextTask" = "PULL") then gosub pull weed
	if ("%nextTask" = "SCREAM") then {
		gosub scream
		pause 2
	}
	if ("%nextTask" = "SEARCH") then gosub search
	if ("%nextTask" = "TOUCH") then {
		gosub touch
		pause 2
		pause
	}
	if ("%nextTask" = "WAVE") then gosub wave

	goto loop