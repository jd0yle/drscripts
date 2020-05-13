include libsel.cmd


loop:
    if ($Attunement.LearningRate < 34) then gosub perc mana
    pause 61
    goto loop
