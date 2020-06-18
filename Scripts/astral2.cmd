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
} else if (matchre("%destination", "ratha|Erekinzil|taisgath") then {
   var pillar Fortune
   var destShardName Erekinzil
} else if (matchre("%destination", "theren") then {
 var pillar Introspection
 var destShardName Dinegavren
}


echo %destShardName %pillar

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
    if (contains("$roomplayers", "Inauri")) then {
        #gosub get my bean
        #pause
        #put throw bean at inauri
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
        exit
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


   # You believe the center of the microcosm is to the north.
   # You are already at the end of the conduit.
   # You believe the center of the microcosm is to the west.
   # You believe the end of the conduit lies northwest.
