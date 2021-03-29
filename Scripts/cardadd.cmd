include libsel.cmd

if ("$righthand" != "Empty") then {
    if ("$righthand" != "collector's case") then gosub stow right
    gosub stow left
    gosub get my collector's case
}


loop:
    gosub get my card from my backpack
    if ("$lefthand" = "Empty") then goto done
    gosub card add
    if ("$lefthand" != "Empty") then gosub put my card in my bucket
goto loop


done:
    gosub put my collector's case in my thigh bag
    put #parse CARDADD DONE
    exit