include libsel.cmd

action goto logout when eval $health < 50
action goto logout when eval $dead = 1

var inLeth false


# debug 10


#Set for leth
if ($zoneid = 112 || $zoneid = 61 || $zoneid = 150) then {
    echo ** inLeth = 1 **
    var inLeth true
    var sitRoom 42
    var burgleRoom 39
}



var burgleCooldown 0
var nextBurgleCheck 0
var injured 0

action var burgleCooldown $1 when ^You should wait at least (\d+) roisaen
action var burgleCooldown 0 when ^A tingling on the back of your neck draws attention to itself by disappearing, making you believe the heat is off from your last break in\.$
action var numBolts $1 when ^You count some basilisk bolts in the \S+ and see there are (\S+) left\.$
action var numArrows $1 when ^You count some basilisk arrows in the \S+ and see there are (\S+) left\.$
action send stand when ^You'll have to move off the sandpit first.


timer start

main:
    gosub abortScripts
    gosub resetState
    gosub checkBurgleCd

    if (%burgleCooldown = 0) then {
        put #echo >Log #cc99ff Train: Going to burgle

        gosub moveToBurgle

        gosub prep rf

        put .armor remove
        waitforre ^ARMOR DONE$

        gosub cast

        put .burgle
        waitforre ^BURGLE DONE$

        gosub release rf

        put .armor wear
        waitforre ^ARMOR DONE$

    }


    # Magic
    if ($bleeding = 1 || $Warding.LearningRate < 30 || $Utility.LearningRate < 30 || $Augmentation.LearningRate < 30 || $Arcana.LearningRate < 30) then {
        put #echo >Log #0099ff Moving to magic
        gosub moveToMagic
        gosub getHealed
        put .sel
        gosub waitForMagic
        goto main
    }

    # Main Combat
    put #echo >Log #cc99ff Moving to combat
    gosub moveToWyverns
    put .fight
    gosub waitForMainCombat
    goto main


    # Backtrain
    if (false) then {
        #if ($Heavy_Thrown.LearningRate < 10) then {
        put #echo >Log #0099ff Moving to backtrain
        gosub moveToGremlins
        put .fight backtrain
        gosub waitForBacktrain
        goto main
    }


    #if ($Crossbow.LearningRate < 30 || $Small_Edged.LearningRate < 30 || $Targeted_Magic.LearningRate < 30 || $Brawling.LearningRate < 30 || $Light_Thrown.LearningRate < 30 || $Evasion.LearningRate < 0 || $Parry_Ability.LearningRate < 30 || $Shield_Usage.LearningRate < 30) then {


    #}

    gosub abortScripts
    gosub resetState

    goto main


abortScripts:
    put #script abort all except seltrainshard
    pause 1
    put #script abort all except seltrainshard
    pause .2
    gosub stow right
    gosub stow left
    return


checkBurgleCd:
    var burgleCooldown 0
    gosub burgle recall
    pause
    evalmath nextBurgleCheck (%burgleCooldown * 60) + 60 + %t
    put #echo >Log #adadad Next burgle check in %burgleCooldown minutes
    return



getHealed:
    gosub checkHealth
    if (%injured = 1 && contains("$roomplayers", "Inauri")) then {
        gosub whisper inauri heal
        pause 30
    }
    return


checkHealth:
    matchre checkHealthInjured ^You have.*(skin|head|neck|chest|abdomen|back|tail|hand|arm|leg|eye|twitching|paralysis)
    matchre checkHealthNotInjured ^You have no significant injuries.
    put health
    matchwait 5
    return


checkHealthInjured:
    var injured 1
    return


checkHealthNotInjured:
    var injured 0
    return



moveToBurgle:
    if ("$roomname" = "Private Home Interior") then {
        gosub unlock door
        gosub open door
        gosub move go door
        gosub close third farmstead
        gosub lock third farmstead
        goto moveToBurgle
    }

    # Shard West Gate Area
    if ("$zoneid" = "69") then {
        if ("$roomid" = "204") then return
        gosub automove 204
        goto moveToBurgle
    }

    # Shard East Gate Area
    if ("$zoneid" = "66") then {
        gosub automove 217
        goto moveToBurgle
    }

    # Shard
    if ("$zoneid" = "67") then {
        gosub automove 132
        goto moveToBurgle
    }

    # FC
    if ("$zoneid" = "150") then {
        gosub automove portal
        gosub move go exit portal
        goto moveToBurgle
    }

    goto moveToBurgle



moveToMagic:
    if (contains("$roomplayers", "Inauri") then {
        if ($Enchanting.LearningRate < 15) then {
            gosub whisper inauri teach enchanting
        } else {
            gosub stop teach
            gosub stop listen
            gosub teach tm to inauri
        }
        pause 2
    }

    if ("$roomname" = "Private Home Interior") then {
        return
    }

    # Shard East Gate Area
    if ("$zoneid" = "66") then {
        if ("$roomid" != "640") then gosub automove 640
        gosub unlock third farmstead
        gosub open third farmstead
        gosub move go third farmstead
        gosub close door
        gosub lock door
        goto moveToMagic
    }

    # Shard
    if ("$zoneid" = "67") then {
        gosub automove 132
        goto moveToMagic
    }

    # Shard West Gate Area
    if ("$zoneid" = "69") then {
        gosub automove n gate
        goto moveToMagic
    }

    # FC
    if ("$zoneid" = "150") then {
        if ("$roomid" = "106") then return
        gosub automove 106
        goto moveToMagic
    }

    goto moveToMagic



moveToWyverns:
    if ("$roomname" = "Private Home Interior") then {
        gosub unlock door
        gosub open door
        gosub move go door
        gosub close third farmstead
        gosub lock third farmstead
        goto moveToWyverns
    }

    # Shard West Gate Area
    if ("$zoneid" = "69") then {
        put .findSpot wyvern
        waitforre ^FINDSPOT DONE$
        return
    }

    # Shard East Gate Area
    if ("$zoneid" = "66") then {
        gosub automove w gate
        goto moveToWyverns
    }

    # Shard
    if ("$zoneid" = "67") then {
        gosub automove 132
        goto moveToWyverns
    }

    # FC
    if ("$zoneid" = "150") then {
        gosub automove portal
        gosub move go exit portal
        goto moveToWyverns
    }

    goto moveToWyverns


moveToHeal:
    put #script abort all except seltrainshard
    pause 1
    put #script abort all except seltrainshard
    if ("$righthandnoun" = "lockbow" || "$righthandnoun" = "crossbow") then gosub unload my $righthandnoun
    gosub stow right
    gosub stow left
    gosub retrieveBolts
    gosub stow hhr'ata
    gosub stow bola
    gosub moveToMagic
    gosub getHealed
    put #script abort all except seltrainshard
    put .seltrainshard
    exit


resetState:
    if ("$righthandnoun" = "compendium" || "$lefthandnoun" = "compendium") then gosub put my compendium in my bag
    if ("$righthandnoun" = "telescope" || "$lefthandnoun" = "telescope") then gosub put my telescope in my bag
    gosub stow right
    gosub stow left
    gosub release spell
    gosub release mana
    gosub release symbi
    gosub release shear
    gosub release cyclic
    gosub retrieveBolts
    gosub stow hhr'ata
    gosub stow bola
    return


retrieveArrows:
    gosub count my basilisk arrows
    if ("%numArrows" = "nineteen") then {
        gosub stow right
        return
    }
    if ("$righthandnoun" != "scimitar") then {
        gosub stow right
        gosub get my haralun scimitar
    }
    gosub attack slice
    gosub attack draw
    gosub loot treasure
    put .loot
    waitforre ^LOOT DONE$
    goto retrieveArrows


retrieveBolts:
    gosub count my basilisk bolts
    if ("%numBolts" = "thirty-four") then {
        gosub stow right
        return
    }
    if ("$righthandnoun" != "scimitar") then {
        gosub stow right
        gosub get my haralun scimitar
    }
    gosub attack slice
    gosub attack draw
    gosub loot treasure
    put .loot
    waitforre ^LOOT DONE$
    goto retrieveBolts


waitForBurgleCd:
    if (%nextBurgleCheck < %t) then {
        put #script abort all except seltrainshard
        gosub stow right
        gosub stow left
        gosub checkBurgleCd
    }
    if (%burgleCooldown = 0) then return
    pause 2
    goto waitForBurgleCd



waitForMagic:
    pause 2
    if (%nextBurgleCheck < %t) then {
        put #script abort all except seltrainshard
        pause 1
        put #script abort all except seltrainshard
        gosub stow right
        gosub stow left
        gosub checkBurgleCd
        put .sel
        pause 1
    }

    #if (%burgleCooldown = 0 || $Crossbow.LearningRate < 5 || $Small_Edged.LearningRate < 5 || $Targeted_Magic.LearningRate < 5 || $Brawling.LearningRate < 5 || $Light_Thrown.LearningRate < 5 || $Evasion.LearningRate < 0 || $Parry_Ability.LearningRate < 5 || $Shield_Usage.LearningRate < 5) then {
    if (%burgleCooldown = 0 || ($Warding.LearningRate > 30 && $Utility.LearningRate > 30 && $Augmentation.LearningRate > 30 && $Arcana.LearningRate > 30)) then {
        put #script abort all except seltrainshard
        pause 1
        put #script abort all except seltrainshard
        gosub resetState
        return
    }

    goto waitForMagic



waitForMainCombat:
    pause 2
    if ($bleeding = 1) then goto moveToHeal
    if (%nextBurgleCheck < %t) then {
        put #script abort all except seltrainshard
        pause 1
        put #script abort all except seltrainshard
        gosub stow right
        gosub stow left
        gosub checkBurgleCd
        put .fight
        pause 1
    }
    #if (%burgleCooldown = 0 || ($Crossbow.LearningRate > 29 && $Small_Edged.LearningRate > 29 && $Targeted_Magic.LearningRate > 29 && $Brawling.LearningRate > 29 && $Light_Thrown.LearningRate > 29 && $Parry_Ability.LearningRate > 29 && $Shield_Usage.LearningRate > 29 && $Evasion.LearningRate > 29)) then {
    if (%burgleCooldown = 0 || ($Warding.LearningRate < 1 || $Utility.LearningRate < 1 || $Augmentation.LearningRate < 1 || $Arcana.LearningRate < 1)) then {
        put #script abort all except seltrainshard
        pause 1
        put #script abort all except seltrainshard
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
    put #script abort all except seltrainshard
    pause 1
    put #script abort all except seltrainshard
    put exit
    exit