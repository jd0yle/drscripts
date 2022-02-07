include libmaster.cmd

var orbContainer $char.inv.container.memoryOrb
var tempContainer $char.inv.container.temp

action var orbSkill $1 when for a little enlightment on (.*)\.$

gosub stow right
gosub stow left

gosub moveOrbsToContainer %orbContainer

gosub doOrb

exit




doOrb:
	gosub get my memory orb from my %tempContainer
	if ("$righthand" = "Empty") then return
	gosub study my memory orb
	eval orbSkill replacere("%orbSkill", " ", "_")
	echo %orbSkill $%orbSkill.LearningRate
	if ($%orbSkill.LearningRate > 0) then gosub invoke my memory orb
	if ("$righthand" != "Empty") then gosub put my memory orb in my %orbContainer
	goto doOrb




moveOrbsToContainer:
	var moveFromContainer $0
	gosub get my memory orb from my %moveFromContainer
	if ("$righthand" = "Empty") then return
	gosub put my memory orb in my %tempContainer
	goto moveOrbsToContainer