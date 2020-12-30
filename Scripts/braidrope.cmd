include libsel.cmd

var skinType null
var skins skin|pelt|horn|sac|hide

var readyToPull false
action var readyToPull false when ^You are certain that the braided grass isn't usable for anything yet.
action var readyToPull true when  piece of bundling rope\.$


if (matchre ("$righthandnoun", "(%skins)")) then {
    var skinType $1
}

if (matchre ("$lefthandnoun", "(%skins)")) then {
    var skinType $1
}

gosub stow right
gosub stow left

main:
    gosub getGrass
    gosub braidIntoRope
    gosub pullIntoRope
    if (%skinType != null) then gosub get my %skinType
    goto done


getGrass:
    if ("$righthandnoun" != "grass") then {
        if ($monstercount != 0) then {
            gosub retreat
            gosub retreat
        }
        gosub forage grass
        goto getGrass
    }
    return


braidIntoRope:
    if (%readyToPull = true) then return
    if ($monstercount != 0) then {
        gosub retreat
        gosub retreat
    }    gosub retreat
    gosub braid my grass
    goto braidIntoRope


pullIntoRope:
    if ("$righthandnoun" = "rope") then return
    if ($monstercount != 0) then {
        gosub retreat
        gosub retreat
    }
    gosub pull my grass
    goto pullIntoRope


done:
    pause
    put #parse BRAIDROPE DONE
    exit
