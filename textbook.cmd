include libmaster.cmd

#var startAt Gidii
var startAt Dusk Ogre

var index 0

if ("$righthandnoun" != "textbook") then {
	gosub stow right
	gosub get my textbook
}

gosub stow left

gosub turn my textbook to %startAt

loop:
	if ($First_Aid.LearningRate >= 20 || %index > 100) then goto textbook.done
	if ("$righthandnoun" != "textbook") then {
		gosub stow right
		gosub get my textbook
	}
	gosub study my textbook
	gosub turn my textbook
	math index add 1
	goto loop


textbook.done:
	gosub stow right
	gosub stow left
	pause .2
	put #parse TEXTBOOK DONE
	exit