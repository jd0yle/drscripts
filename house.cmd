include libmaster.cmd
###############################
# Housing Doors
###############################

###############################
###    IDLE ACTION ITEMS
###############################
action goto closeDoor when ^You must wait a few hours before entering this home again\.
action put .house when ^The door is closed\.$


###############################
###    VARIABLES
###############################
var knownLocation 0


###############################
###    LOCATION CHECK
###############################
house.locationCheck:
    if ($zoneid = 1 && $roomid = 258) then {
        var obj house
        var knownLocation 1
    }
    if ($zoneid = 66 && $roomid = 252) then {
        var obj sandalwood door
        var knownLocation 1
    }
    if ($zoneid = 150 && $roomid = 50) then {
        var obj fieldstone bothy
        var knownLocation 1
    }

    if ("$roomname" = "Private Home Interior") then {
        var obj door
        var knownLocation 1
    }

    if (%knownLocation <> 1) then {
        gosub house.findLocalHouse
        if !(matchre("$charactername", "Selesthiel|Inauri")) then {
            gosub house.releaseInvis
            goto house.enterHouse
        }
        goto house.locationCheck
    }
    goto house.main


house.enterHouse:
    matchre enterHouseCont suddenly rattles
    matchre enterHouseCont suddenly opens
    put peer %obj
    matchwait 20
    gosub open %obj
    gosub move go %obj
    goto house.locationCheck


house.enterHouseCont:
    gosub open %obj
    gosub move go %obj
    gosub close door
    goto house.locationCheck


###############################
###    MAIN
###############################
house.main:
    if ("$guild" <> "Necromancer") then {
        gosub house.releaseInvis
    }
    # Key holders going inside.
    if ("%obj" != "door" && matchre("$charactername", "Selesthiel|Inauri")) then {
        gosub unlock %obj
    }
    # Non-key holders going inside.
    if ("%obj" != "door" && !matchre("$charactername", "Selesthiel|Inauri")) then {
        gosub house.peer %obj
    }
    # Leaving a house.
    if ("%obj" = "door") then {
        gosub unlock %obj
    }

    house.mainEnter:
        gosub open %obj
        gosub move go %obj

        if ("%obj" <> "door") then {
            gosub close door
            gosub lock door
        } else {
            var closeObj house
            if (contains("$roomobjs", "farmstead") then var closeObj farmstead
            if (contains("$roomobjs", "sandalwood door") then var closeObj door
            if (contains("$roomobjs", "bothy") then var closeObj bothy
            gosub close %closeObj
            if (matchre("$charactername", "Selesthiel|Inauri")) then gosub lock %closeObj
        }
        goto house.exit


house.exit:
    pause .2
    put #parse HOUSE DONE
    exit


house.peer:
    var todo $0
    matchre house.mainEnter ^(.*)suddenly opens\!$|^(.*)suddenly rattles\!$
    matchre house.peer ^(.*)suddenly slams shut\!
    put peer %todo
    matchwait 20


house.releaseInvis:
    if ($SpellTimer.RefractiveField.active = 1) then gosub release rf
    if ($SpellTimer.EyesoftheBlind.active = 1) then gosub release eotb
    if ($SpellTimer.KhriSilence.active = 1) then gosub khri stop silence
    return


###############################
###     MOVE METHOD
###############################
house.findLocalHouse:
    echo Looking for local house..
    # Crossing - City
    if ($zoneid = 1) then {
        gosub house.releaseInvis
        gosub automove portal
        goto house.findLocalHouse
    }
    # Crossing - West Gate
    if ($zoneid = 4) then {
        gosub automove crossing
        goto house.findLocalHouse
    }
    # Crossing - North Gate
    if ($zoneid = 6) then {
        gosub automove crossing
        goto house.findLocalHouse
    }
    # Crossing - NTR
    if ($zoneid = 7) then {
        gosub automove crossing
        goto house.findLocalHouse
    }
    # NTR - Abandoned Mine
    if ($zoneid = 10) then {
        gosub automove crossing
        goto house.findLocalHouse
    }
    # Leth
    if ($zoneid = 61) then {
        gosub automove portal
        gosub house.releaseInvis
        gosub move go meeting portal
        goto house.findLocalHouse
    }
    # Shard - East Gate
    if ($zoneid = 66) then {
        gosub automove portal
        gosub house.releaseInvis
        gosub move go meeting portal
    }
    # Shard - City
    if ($zoneid = 67) then {
        gosub automove portal
        gosub house.releaseInvis
        gosub move go meeting portal
        goto house.findLocalHouse
    }
    # Shard - South of City
    if ($zoneid = 68) then {
        gosub automove 3
        gosub move go path
        goto house.findLocalHouse
    }
    # Shard - Ice Caves
    if ($zoneid = 68a) then {
        gosub automove 30
        goto house.findLocalHouse
    }
    # Storm Bulls
    if ($zoneid = 112) then {
        gosub automove leth
        goto house.findLocalHouse
    }
    # Fang Cove
    if ($zoneid = 150) then {
        if ($roomid = 50) then {
            goto house.locationCheck
        }
        gosub automove 50
        goto house.findLocalHouse
    }
    goto house.findLocalHouse