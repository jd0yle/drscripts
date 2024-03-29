####################################################################################################
# .astral
# Selesthiel - justin@jmdoyle.com
# USAGE
# .astral <destination>
#
# DEFAULTS to harnessing 50 mana 3 times!
# Set char.astral.manaPerHarness and char.astral.timesToHarness to change defaults
####################################################################################################
include libmaster.cmd

if_1 then {
    var destination %1
} else {
    echo [astral] Must specify a destination
    echo .astral destination
    exit
}

var manaPerHarness $char.astral.manaPerHarness
var timesToHarness $char.astral.timesToHarness

if (!(%manaPerHarness > 0)) then var manaPerHarness 50
if (!(%timesToHarness > 0)) then var timesToHarness 3

var moveToAxis 1
var isAtPillars 0
var moveToEnd 0

var use100thAbility 1

action var directionToAxis $1 when ^You believe the center of the microcosm is to the (\S+)\.
action var directionToEnd $1 when ^You believe the end of the conduit lies (\S+)\.

action var circle $1 when Circle: (\d+)


if (matchre("%destination", "rolagi|crossing|cross")) then {
    var pillar Nightmares
    var destShardName Rolagi
} else if (matchre("%destination", "besoge|kresh|merkresh|mriss") then {
    var pillar Secrets
    var destShardName Besoge
} else if (matchre("%destination", "shard|marendin") then {
    var pillar Secrets
    var destShardName Marendin
} else if (matchre("%destination", "tabelrem|muspari") then {
    var pillar Nightmares
    var destShardName Tabelrem
} else if (matchre("%destination", "taniendar|haven|riverhaven") then {
    var pillar Introspection
    var destShardName Taniendar
} else if (matchre("%destination", "auilusi|aesry") then {
    var pillar Tradition
    var destShardName Auilusi
} else if (matchre("%destination", "asharshpar'i|leth") then {
    var pillar Heavens
    var destShardName Asharshpar'i
} else if (matchre("%destination", "ratha|Erekinzil|taisgath") then {
    var pillar Fortune
    var destShardName Erekinzil
} else if (matchre("%destination", "hib|Dornatorna|Dor'na'torna") then {
    var pillar Tradition
    var destShardName Dor'na'torna
} else if (matchre("%destination", "mintais|throne|tc") then {
    var pillar Fortune
    var destShardName Mintais
} else if (matchre("%destination", "vellano|fangcove|fc") then {
    var pillar Unity
    var destShardName Vellano
} else if (matchre("%destination", "dinegavren|theren|therengia") then {
    var pillar Introspection
    var destShardName Dinegavren
} else if (matchre("%destination", "emalerje|volcano|lesserfist|fist") then {
    var pillar Shrew
    var destShardName Emalerje
} else if (matchre("%destination", "tamigen|ravenspoint|raven|rp") then {
    var pillar Heavens
    var destShardName Tamigen
}

echo %destShardName %pillar

# Check for 100th ability
if (!contains("$roomname", "Astral Plane")) then {
	gosub info
	if (%circle < 100) then {
	    var use100thAbility 0
	    var shardName 0
		if (matchre("$roomobjs", "the silvery-white shard (\S+)\b")) then {
		    var shardName $1
		    echo shardName %shardName
		}
		if (%shardName = 0 && "$zoneid" = "42" && "$roomid" = "291") then {
		    var shardName Dinegavren
		    echo shardName %shardName
		}
		if (%shardName = 0) then {
		    echo
		    echo UNDER 100th CIRCLE, NO GRAZHIR SHARD IN ROOM
		    echo
		    exit
		}
    }
}


gosub awake

if ($SpellTimer.Shear.active = 1) then gosub release shear
gosub release cyclic
if ($SpellTimer.Shadowling.active != 1 || $SpellTimer.Shadowling.duration < 5) then gosub runScript cast shadowling
if ($SpellTimer.AuraSight.active != 1 || $SpellTimer.AuraSight.duration < 5) then gosub runScript cast aus
if ($char.astral.useBc = 1 && ($SpellTimer.BraunsConjecture.active != 1 || $SpellTimer.BraunsConjecture.duration < 5)) then gosub runScript cast bc


gosub waitForConcentration 30

if (contains("$roomname", "Astral Plane")) then {
    var moveToAxis 0
    var moveToEnd 1
    goto loop
}

top:
    gosub release
    gosub release cyclic
    gosub prep mg
    if (%use100thAbility = 1) then {
	    gosub astral.harnessLoop

	    if ($charactername = "Selesthiel" && contains("$roomplayers", "Inauri")) then {
	        pause
	        put lick inauri
	    }
	    gosub cast grazhir
    } else {
        gosub focus %shardName
        gosub harness 15
        gosub harness 15
        gosub cast %shardName
    }


loop:
    if (contains("$roomobjs", "%destShardName")) then {
        gosub prep mg
        gosub focus %destShardName
        gosub cast %destShardName
        gosub release
        goto done
    }

    if (%moveToEnd = 1) then {
        #gosub perc
        gosub perc
        gosub move %directionToEnd
    }

    if (%moveToAxis = 1) then {
        #gosub perc
        gosub perc
        gosub move %directionToAxis
    }

    if (contains("$roomname", "Astral Plane, Pillar of")) then {
        var isAtPillars 1
        var moveToAxis 0
        #eval pillar replacere("$roomname", ^.*(\S+)$, "$1")
        if (contains("$roomname", %pillar)) then {
            gosub focus %destShardName
            var moveToEnd 1
            var isAtPillars 0
        } else {
            move east
        }
    }

    goto loop


astral.harnessLoop:
	if (%timesToHarness <= 0) then return
	gosub harness %manaPerHarness
	evalmath timesToHarness (%timesToHarness - 1)
	goto astral.harnessLoop


done:
    put #parse ASTRAL DONE
    exit
   # You believe the center of the microcosm is to the north.
   # You are already at the end of the conduit.
   # You believe the center of the microcosm is to the west.
   # You believe the end of the conduit lies northwest.
