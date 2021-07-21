include libmaster.cmd

var mobs libger|drake|bowman|gargoyle|moth|orek|mage|armadillo|eel|husk|cabalist

action (mobchange) goto moblistChange when eval $monsterlist
action send watch when ^An announcer shouts, "FIGHT!"


moblistChange:
	if (matchre ("$roomobjs", "(%mobs) ((which|that) appears dead|(dead))") || !matchre("$monsterlist", "(%mobs)") ) then {
		var deadMobName $1
		if ("$preparedspell" = "Petrifying Visions") then goto waitForMob
		if ("$preparedspell" != "None") then gosub release spell
		gosub prep pv 20
	}

	if (contains("$monsterlist", "immobilized")) then {
		action (mobchange) off
		gosub target blb 20
		gosub perform cut
		pause 4
		gosub cast
		action (mobchange) on
		goto moblistChange
	}

	if (matchre("$monsterlist", "(%mobs)")) then {
		if ("$preparedspell" = "Petrifying Visions" && $spelltime > 3) then {
		    pause .5
			gosub cast
			goto moblistChange
		}
		#if ("$preparedspell" != "None") then gosub release spell
		action (mobchange) off
		gosub prep pv 20
		pause 4
		gosub cast
		action (mobchange) on
		goto moblistChange
	}
	goto waitForMob


waitForMob:
    pause .5
    goto moblistChange

