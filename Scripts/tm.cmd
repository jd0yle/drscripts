include libsel.cmd

var stance shield

gosub stance shield

loop:
    if ($monstercount > 1) then {
        if (%stance != shield) then gosub stance shield
        var stance shield
    } else {
        if (%stance != parry) then gosub stance parry
        var stance parry
    }



    if ($monstercount > 1 && $mana > 80) then {
        if ($Targeted_Magic.LearningRate < 34 || $monstercount > 2) then {
            gosub tm
        } else {
            gosub brawl
        }
    } else {
        if $mana > 80 then gosub prep mb 20
        gosub hide
        gosub attack bob
        gosub attack circle
        gosub attack weave
        gosub hunt
        if "$preparedspell" != "None" then gosub cast
    }
    if $monsterdead > 0 then gosub Skinning
goto loop


tm:
    if ($mana < 80) then gosub waitMana
    gosub prep pd 20
    gosub target
    if ($Perception.LearningRate < 34) then gosub hunt
    #if ($Hiding.LearningRate < 34) then gosub hide
    gosub hide
    gosub cast
return


brawl:
    gosub prep mb 20
    gosub hunt
    gosub hide
    gosub cast
    gosub attack punch
    gosub attack elbow
    gosub attack circle
return



waitMana:
    pause 1
    if $mana < 80 then goto waitMana
    return
