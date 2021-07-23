include libmaster.cmd

var startAt Gidii

if ("$righthandnoun" != "textbook") then {
	gosub stow right
	gosub get my textbook
}

gosub stow left

gosub turn my textbook to %startAt

loop:
	if ($First_Aid.LearningRate > 20) then goto textbook.done
	gosub study my textbook
	gosub turn my textbook
	goto loop


textbook.done:
	gosub stow right
	gosub stow left
	pause .2
	put #parse TEXTBOOK DONE
	exit