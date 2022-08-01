include libmaster.cmd

var armors armet|aventail|backplate|balaclava|breastplate|cap|cowl|cuirass|dress|fauld|gauntlets|gloves|gorget|greaves|hood|jerkin|\bplate|hauberk|helm|lorica|leathers|mail|mantle|mask|pants|robe|sallet|shirt|sleeves|tasset|vambraces|vest
var shields aegis|buckler|shield|sipar|targe

var wornItems null
var itemTaps null

action (armorTrigger) var wornItems %wornItems|$1 when ^\W\W.*(%armors|%shields)


pause .2
matchre armor.cont ^\[Use INVENTORY HELP for more options\.\]$
put inv armor
matchwait 5



armor.cont:
	eval wornItems replace("%wornItems", "null|", "")
	echo %wornItems
	gosub armor.remove

	eval itemTaps replace("%itemTaps", "null|", "")
	echo %itemTaps
	goto armor.done


armor.remove:
	gosub stow right
	gosub stow left

	var armor.index 0

	armor.remove.loop:
		if (%armor.index > count("%wornItems", "|") then return
		gosub remove my %wornItems(%armor.index)
		if ("$righthand" != "Empty") then var itemTaps %itemTaps|$righthand
		if ("$lefthand" != "Empty") then var itemTaps %itemTaps|$lefthand
		gosub stow my %wornItems(%armor.index)
		math armor.index add 1
		goto armor.remove.loop


armor.done:
	pause .2
	#put #parse ARMOR DONE
	put #parse ARMORREMOVE DONE

	exit

#All of your armor:#
#
#
#  a contoured demonscale mask darkened to a deep abyssal black
#  a tapered demonscale helm darkened to a deep abyssal black
#  a small demonscale shield pyrographed with a map of the Blasted Plains
#  some sleek demonscale gloves darkened to a deep abyssal black
#  some sleek demonscale leathers darkened to a deep abyssal black
#[Use INVENTORY HELP for more options.]