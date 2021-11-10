include libmaster.cmd

var noCommune 0
if (%1 = nocommune) then var noCommune 1

action send roll my prayer cloth when ^You should roll it up first

gosub stow right
gosub stow left

gosub stand

gosub remove my pilgrim badge
if ("$righthand" = "Empty") then gosub get my pilgrim badge
gosub pray my badge
gosub wear my badge

gosub get my prayer cloth
gosub unroll my prayer cloth
put kneel my prayer cloth
put kiss my prayer cloth

gosub pray huldah

gosub get my wine
if ("$righthandnoun" = "wine" || "$lefthandnoun" = "wine") then {
	put kneel my prayer cloth
	put pour my wine on my prayer cloth
	gosub stow my wine
}

gosub stand
gosub dance my prayer cloth
gosub dance my prayer cloth
gosub dance my prayer cloth

gosub roll my prayer cloth
gosub stow my prayer cloth

gosub stow right
gosub stow left

#if (%noCommune != 1 && $Theurgy.LearningRate < 10) then gosub runScript commune --deity=meraud

pause .2
put #parse DEVOTION DONE
exit
