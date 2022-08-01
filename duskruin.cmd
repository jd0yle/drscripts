include libmaster.cmd

action goto completed when ^A pair of surly attendants escorts you from the arena floor.

if (contains("$roomname", "Arena")) then goto loop
if (contains("$roomname", "Victor Lounge")) then goto completed

top:
	#put title pre off
	put title pre choose prim arch
	pause .5
	#put title pre off confirm
	pause

    if ($SpellTimer.CallfromBeyond.duration < 10) then {
        put #echo >Log STOPPING DUSKRUIN, NO ZOMBIE!
        put #script abort all except duskruin
        put exit
        pause
        put exit
        exit
    }

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

	if ("$lefthand" = "Empty" || "$lefthandnoun" = "package") then {
	    put #echo >Log OUT OF SLIPS or inv space
        put #script abort all except duskruin
        put exit
        pause
        put exit
        exit
	}

	gosub move go portcul
	#gosub prep usol 10
	gosub prep usol 12
	#put zom come
	put zc come
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
	#put zom leave
	put zc leave
	pause
	gosub move se
	goto top