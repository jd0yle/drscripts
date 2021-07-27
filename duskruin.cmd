include libmaster.cmd

action goto completed when ^A pair of surly attendants escorts you from the arena floor.

if (contains("$roomname", "Arena")) then goto loop
if (contains("$roomname", "Victor Lounge")) then goto completed

top:
	put title pre off
	pause .5
	put title pre off confirm
	pause

	if ("$righthand" != "lion dragon") then {
		gosub stow right
		gosub get my dragon
		gosub invoke my dragon
	}

	gosub runScript buff
	gosub waitForMana 100

	if ("$lefthand" != "dueling slips") then {
		gosub stow left
		gosub get my slip
	}

	gosub move go portcul
	gosub prep usol 10
	put zom come
	gosub stow slip

	gosub release cyclic
	gosub stow slip
	gosub waitForPrep
	gosub cast
	gosub runScript cast qe

	put .arena
	goto loop

loop:
	pause 2
	goto loop


completed:
	put #script abort arena
	pause 2
	gosub stow my package
	gosub release qe
	put zom leave
	pause
	gosub move se
	goto top