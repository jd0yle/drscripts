include libsel.cmd
####################################################################################################
# .astral
# Selesthiel - justin@jmdoyle.com
# USAGE
# .astral <destination>
#
# NOTE: This assumes you have the 100th circle ability!
####################################################################################################

if_1 then {
    var destination %1
} else {
    echo [astral] Must specify a destination
    echo .astral destination
    exit
}

var moveToAxis 1
var isAtPillars 0
var moveToEnd 0

action var directionToAxis $1 when ^You believe the center of the microcosm is to the (\S+)\.
action var directionToEnd $1 when ^You believe the end of the conduit lies (\S+)\.


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
} else if (matchre("%destination", "dinegavren|theren") then {
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

gosub awake

waitForConcentration:
    if ($concentration < 75) then {
        pause 2
        goto waitForConcentration
    }

if (contains("$roomname", "Astral Plane")) then {
    var moveToAxis 0
    var moveToEnd 1
    goto loop
}

top:
    gosub release
    if ($SpellTimer.AuraSight.active != 1) then {
        put .cast aus
        waitforre ^CAST DONE
    }
    gosub prep mg
    gosub harness 30
    gosub harness 30
    gosub harness 30
    gosub harness 30
    if ($charactername = "Selesthiel" && contains("$roomplayers", "Inauri")) then {
        pause
        put lick inauri
    }
    gosub cast grazhir

loop:
    if (contains("$roomobjs", "%destShardName")) then {
        gosub prep mg
        gosub focus %destShardName
        gosub cast %destShardName
        gosub release
        goto done
    }

    if (%moveToEnd = 1) then {
        gosub perc
        gosub perc
        gosub move %directionToEnd
    }

    if (%moveToAxis = 1) then {
        gosub perc
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

done:
    put #parse ASTRAL DONE
    exit
   # You believe the center of the microcosm is to the north.
   # You are already at the end of the conduit.
   # You believe the center of the microcosm is to the west.
   # You believe the end of the conduit lies northwest.
