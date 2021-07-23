include libmaster.cmd

var noCommune 0
if (%1 = nocommune) then var noCommune 1

action send roll my rug when ^You should roll it up first

gosub stow right
gosub stow left

gosub stand

gosub remove my badge
gosub pray my badge
gosub wear my badge

gosub get my rug
gosub unroll my rug
put kneel my rug
put kiss my rug

gosub pray huldah

gosub get my wine
if ("$righthandnoun" = "wine" || "$lefthandnoun" = "wine") then {
	put kneel my rug
	put pour my wine on my rug
	gosub stow my wine
}

gosub stand
gosub dance my rug
gosub dance my rug
gosub dance my rug

gosub roll my rug
gosub stow my rug

gosub stow right
gosub stow left

if (%noCommune != 1) then gosub runScript commune --deity=meraud

pause .2
put #parse DEVOTION DONE
exit
