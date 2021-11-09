include libmaster.cmd


action var nextTask $1 when I'd like you to.*(BUILD|DISARM|FORAGE|POKE|PULL|SCREAM|SEARCH|TOUCH)

loop:
	if ("%nextTask" = "BUILD") then put build
	if ("%nextTask" = "DISARM") then {
		gosub search
		put disarm trap
	}
	if ("%nextTask" = "FORAGE") then gosub forage
	if ("%nextTask" = "POKE") then put poke employee
	if ("%nextTask" = "PULL") then put pull weed
	if ("%nextTask" = "SCREAM") then put scream
	if ("%nextTask" = "SEARCH") then put search
	if ("%nextTask" = "TOUCH") then put touch


	pause
	pause
	goto loop