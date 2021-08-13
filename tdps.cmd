var stats Strength|Stamina|Agility|Reflex|Discipline|Charisma|Intelligence|Wisdom

var costs null

action var costs.$2 $1 when ^It will cost you (\d+) TDPs to raise your (%stats)


gosub getCosts
gosub printCosts

exit

getCosts:
	var i 0
	getCosts.loop:
		if (%i > count("%stats", "|")) then return
		matchre getCosts.loopNext ^Use INFO
		put %stats(%i)
		matchwait 5

	getCosts.loopNext:
		math i add 1
		goto getCosts.loop


printCosts:
	var i 0
	printCosts.loop:
		echo %stats(%i) : %costs.%stats(%i)
		math i add 1
		if (%i > count("%stats", "|")) then return
		goto printCosts.loop



