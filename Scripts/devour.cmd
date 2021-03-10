include libsel.cmd

var isFullyPrepped 0
action var isFullyPrepped 1 when ^You feel fully prepared to cast your spell.

#action goto noDeadCreature when ^This ritual may only be performed on a corpse

if_1 then {
    var creature %0
} else {
    #if ("$righthandnoun" != "material" && "$lefthandnoun" != "material") then {
    #    put #echo >Log [devour]: ERROR! No creature specified in .devour creature
    #    echo
    #    echo ** SPECIFY A CREATURE, NUB! .devour <creature>
    #    echo
    #    goto done
    #}
    var creature material
}

checkHealth:
    if ($SpellTimer.Devour.duration > 0) then goto done
    matchre heal ^You have.*(skin|head|neck|chest|abdomen|back|tail|hand|arm|leg|eye|twitching|paralysis)
    matchre done ^You have no significant injuries.
    put health
    matchwait 5
    goto done



heal:
    gosub release spell
    var isFullyPrepped 0
    gosub prep devour
    if (!(matchre ("$roomobjs", "(%critters) ((which|that) appears dead|(dead))") || "%creature" = "material") then {
        if ("$righthandnoun" != "material" && "$lefthandnoun" != "material") then {
            gosub stow right
            gosub stow left
            gosub get my material
        }
    }
    if ("%creature" != "material") then {
        gosub perf preserve on %creature
        gosub perf consume on %creature
    }
    gosub waitForPrep
    gosub cast
    goto done



waitForPrep:
    if (%isFullyPrepped = 1) then return
    pause
    goto waitForPrep


noDeadCreature:
    echo
    echo ** NO DEAD CREATURE **
    echo
    goto done


done:
    pause .2
    put #parse DEVOUR DONE
    exit