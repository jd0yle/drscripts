include libsel.cmd


loop:
    gosub prep pd 20
    gosub target
    pause 7
    gosub cast
    if $monsterdead > 0 then gosub Skinning
goto loop
