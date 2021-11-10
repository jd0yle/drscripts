include libmaster.cmd
include args.cmd

var tarantula.skill %args.skill

action evalmath timeRemaining ($1 * 60 + 60 + $gametime); put #var lib.timers.nextTarantulaAt %timeRemaining; echo $lib.timers.nextTarantulaAt when It needs approximately (\d+) roisaen to generate enough venom again\.$

var usedSkillset null
action var usedSkillset $1 when ^\[You need to vary which skillset you select with every use.  (\S+) was your last used skillset

action put #echo >Log #00dd00 Bonus Pool: $1 $2 when Your (\S+) pool could fill one empty skill to (\d+) ranks\.$
action put #echo >Log #00dd00 Bonus Pool: none when ^You do not have any experience in your bonus pools.

if (!($lib.timers.nextTarantulaAt > -1)) then put #var lib.timers.nextTarantulaAt 1
if ($lib.timers.nextTarantulaAt < $gametime) then {
	put #echo >Debug #00dd00 Using tarantula on %tarantula.skill
	gosub stow right
    gosub stow left
	if ("$guild" = "Moon Mage" && $Astrology.LearningRate < 30) then gosub runScript predict
	gosub get my $char.tarantula.item
	gosub turn my $char.tarantula.item to %tarantula.skill
	#if ("%usedSkillset" = "Magic") then gosub turn my $char.tarantula.item to thievery
	gosub retreat
	gosub rub my $char.tarantula.item
	gosub stow right
	gosub stow left
	gosub exp all
}

gosub exp bonus

pause .2
put #parse TARANTULA DONE
exit
