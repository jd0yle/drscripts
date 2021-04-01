include libsel.cmd

caracalLoop:
    if ("$righthandnoun" != "caracal") then {
        gosub stow right
        gosub get my caracal
    }
    if ($Skinning.LearningRate < 33 || $First_Aid.LearningRate < 33) then {
        gosub skin my caracal
        gosub repair my caracal
    } else {
        pause 2
    }
goto caracalLoop
