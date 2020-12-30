include libsel.cmd

action goto logout when eval $health < 50
action goto logout when eval $dead = 1

var inLeth false

# debug 10


#Set for leth
if ($zoneid = 112) then {
    var inLeth true
    var sitRoom 42
    var burgleRoom 39
}



var burgleCooldown 0
var nextBurgleCheck 0

action var burgleCooldown $1 when ^You should wait at least (\d+) roisaen
action var burgleCooldown 0 when ^A tingling on the back of your neck draws attention to itself by disappearing, making you believe the heat is off from your last break in\.$
action var numBolts $1 when ^You count some basilisk bolts in the \S+ and see there are (\S+) left\.$
action var numArrows $1 when ^You count some basilisk arrows in the \S+ and see there are (\S+) left\.$

timer start


main:
    gosub abortScripts
    gosub resetState
    gosub checkBurgleCd

    if (%burgleCooldown = 0) then {
        put #echo >Log #fff2de Train: Going to burgle
        if (%inLeth = true) then {
            gosub moveToBurgleRoom

            gosub prep rf

            put .armor remove
            waitforre ^ARMOR DONE$

            gosub cast

            put .burgle
            waitforre ^BURGLE DONE$

            gosub release rf

            put .armor wear
            waitforre ^ARMOR DONE$
        } else {
            gosub moveToLawn
            put .selburgle
            waitforre ^SELBURGLE DONE$
            gosub release rf
        }
    }

    if (%inLeth = true) then {
        if ($Crossbow.LearningRate < 31 || $Small_Edged.LearningRate < 31 || $Targeted_Magic.LearningRate < 31 || $Brawling.LearningRate < 31 || $Light_Thrown.LearningRate < 31 || $Evasion.LearningRate < 31 || $Parry_Ability.LearningRate < 31 || $Shield_Usage.LearningRate < 31) then {
            put #echo >Log #fff2de Moving to combat
            put .findSpot bull
            waitforre ^FINDSPOT DONE$
            put .fight
            gosub waitForMainCombat
            goto main
        } else {
            put #echo >Log #fff2de Moving to magic
            gosub moveToSitRoom
            put .sel
            gosub waitForMagic
            goto main
        }
        
    } else {
        #if ($Enchanting.LearningRate > 30) then {
        #    put #echo >Log #fff2de Moving to backtrain
        #    gosub moveToGremlins
        #    put .fight backtrain
        #    gosub waitForBacktrain
        #} else {
            put #echo >Log #fff2de Moving to magic
            gosub moveToHouse
            put .sel
            gosub waitForBurgleCd
        #}
    }

    gosub abortScripts
    gosub resetState

    goto main


abortScripts:
    put #script abort all except seltrain
    pause 1
    put #script abort all except seltrain
    pause .2
    return


checkBurgleCd:
    var burgleCooldown 0
    gosub burgle recall
    pause
    evalmath nextBurgleCheck (%burgleCooldown * 60) + %t
    put #echo >Log #adadad Next burgle check in %burgleCooldown minutes
    return


moveToBurgleRoom:
    if ($roomid = %burgleRoom) then return
    gosub automove %burgleRoom
    pause .2
    goto moveToBurgleRoom


moveToGremlins:
    if ("$roomname" = "Private Home Interior") then {
        gosub moveToLawn
        goto moveToGremlins
    }

    # Fang Cove
    if ($zoneid = 150) then {
        if ($roomid < 108 || $roomid > 117) then {
            put .findSpot gremlin
            waitforre ^FINDSPOT DONE$
            goto moveToGremlins
        }
        return
    }

    # Crossing
    if ($zoneid = 1) then {
        gosub automove portal
        gosub move go portal
        goto moveToGremlins
    }

    gosub moveToLawn
    goto moveToGremlins


moveToHouse:
    if (contains("$roomplayers", "Inauri") then {
        if ($Tactics.LearningRate >= $Enchanting.LearningRate) then {
            gosub whisper inauri teach enchanting
        } else {
            gosub whisper inauri teach tactics
        }
        pause 2
    }
    if ("$roomname" = "Private Home Interior") then {
        put #echo In house
        return
    }
    gosub moveToLawn
    gosub unlock house
    gosub open house
    gosub move go house
    gosub close door
    gosub lock door
    goto moveToHouse


moveToLawn:
    # House
    if ("$roomname" = "Private Home Interior") then {
        gosub unlock door
        gosub open door
        gosub move go door
        gosub close house
        gosub lock house
        goto moveToLawn
    }

    # Crossing
    if ($zoneid = 1) then {
        if ($roomid != 258) then {
            gosub automove 258
            goto moveToLawn
        } else {
            return
        }
    }

    # North Gate
    if ($zoneid = 6) then {
        gosub automove crossing
        goto moveToLawn
    }

    # NTR
    if ($zoneid = 7) then {
        gosub automove crossing
        goto moveToLawn
    }

    # Fang Cove
    if ($zoneid = 150) then {
        gosub automove portal
        gosub move go portal
        put .dep
        waitforre ^DEP DONE$
        goto moveToLawn
    }

    goto moveToLawn






moveToSitRoom:
    if ($roomid = %sitRoom) then return
    gosub automove %sitRoom
    pause .2
    goto moveToSitRoom


resetState:
    if ("$righthandnoun" = "compendium" || "$lefthandnoun" = "compendium") then gosub put my compendium in my bag
    if ("$righthandnoun" = "telescope" || "$lefthandnoun" = "telescope") then gosub put my telescope in my bag
    gosub stow right
    gosub stow left
    gosub release spell
    gosub release mana
    gosub release symbi
    gosub release shear
    gosub retrieveBolts
    gosub stow hhr'ata
    gosub stow bola
    return


retrieveArrows:
    gosub count my basilisk arrows
    if ("%numArrows" = "twenty") then {
        gosub stow right
        return
    }
    if ("$righthandnoun" != "scimitar") then {
        gosub stow right
        gosub get my haralun scimitar
    }
    gosub attack slice
    gosub attack draw
    gosub loot
    put .loot
    waitforre ^LOOT DONE$
    goto retrieveArrows


retrieveBolts:
    gosub count my basilisk bolts
    if ("%numBolts" = "eighteen") then {
        gosub stow right
        return
    }
    if ("$righthandnoun" != "scimitar") then {
        gosub stow right
        gosub get my haralun scimitar
    }
    gosub attack slice
    gosub attack draw
    gosub loot
    put .loot
    waitforre ^LOOT DONE$
    goto retrieveBolts


waitForBurgleCd:
    if (%nextBurgleCheck < %t) then {
        put #script abort all except seltrain
        gosub checkBurgleCd
    }
    if (%burgleCooldown = 0) then return
    pause 2
    goto waitForBurgleCd
    

waitForBacktrain:
    pause 2
    if (%nextBurgleCheck < %t) then {
        put #script abort all except seltrain
        pause 1
        put #script abort all except seltrain
        gosub checkBurgleCd
        put .fight backtrain
        pause 1
    }
    if (%burgleCooldown = 0 || $Enchanting.LearningRate < 3) then {
        put #script abort all except seltrain
        pause 1
        put #script abort all except seltrain
        if ("$righthandnoun" = "lockbow" || "$righthandnoun" = "crossbow" || "$righthandnoun" = "shortbow" || "$righthandnoun" = "sling") then gosub unload my $righthandnoun
        gosub stow right
        gosub stow left
        gosub retrieveBolts
        gosub retrieveArrows
        gosub stow hhr'ata
        gosub stow bola
        return
    }
    goto waitForBacktrain


waitForMagic:    
    pause 2
    if (%nextBurgleCheck < %t) then {
        put #script abort all except seltrain
        pause 1
        put #script abort all except seltrain
        gosub checkBurgleCd
        put .sel
        pause 1
    }
    if (%inLeth = 1) then {
        if (%burgleCooldown = 0 || $Crossbow.LearningRate < 5 || $Small_Edged.LearningRate < 5 || $Targeted_Magic.LearningRate < 5 || $Brawling.LearningRate < 5 || $Light_Thrown.LearningRate < 5 || $Evasion.LearningRate < 5 || $Parry_Ability.LearningRate < 5 || $Shield_Usage.LearningRate < 5) then {
            put #script abort all except seltrain
            pause 1
            put #script abort all except seltrain
            gosub resetState
            return
        }
    } else {
        if (%burgleCooldown = 0 || $Enchanting.LearningRate > 31) then {
            put #script abort all except seltrain
            pause 1
            put #script abort all except seltrain
            gosub resetState
            return
        }
    }
    goto waitForMagic



waitForMainCombat:
    pause 2
    if (%nextBurgleCheck < %t) then {
        put #script abort all except seltrain
        pause 1
        put #script abort all except seltrain
        gosub checkBurgleCd
        put .fight
        pause 1
    }
    if (%burgleCooldown = 0 || ($Crossbow.LearningRate > 30 && $Small_Edged.LearningRate > 30 && $Targeted_Magic.LearningRate > 30 && $Brawling.LearningRate > 30 && $Light_Thrown)) then {
        put #script abort all except seltrain
        pause 1
        put #script abort all except seltrain
        if ("$righthandnoun" = "lockbow" || "$righthandnoun" = "crossbow") then gosub unload my $righthandnoun
        gosub stow right
        gosub stow left
        gosub retrieveBolts
        gosub stow hhr'ata
        gosub stow bola
        return
    }
    goto waitForMainCombat


logout:
    put exit
    put #script abort all except seltrain
    pause 1
    put #script abort all except seltrain
    put exit
    exit