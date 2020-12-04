include libsel.cmd

if ("$righthandnoun" = "stones") then gosub put my stones in my tel case
if ("$lefthandnoun" = "stones") then gosub put my stones in my tel case
if ("$righthandnoun" = "oil") then gosub put my oil in my tort sack

loop:
    gosub get stones from my tel case
    if ("$lefthandnoun" != "oil") then {
        gosub stow left
        gosub get my oil
    }
    gosub dip my stones in my oil
    gosub put my oil in my tort sack
    gosub get chain from my knapsack
    gosub affix my stones to my chain
    gosub put gweth in my tort sack
    goto loop
