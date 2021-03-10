include libsel.cmd

gosub stow left
gosub stow right

loop:
    put .enchant 5 4 gwethdesuan
    waitforre ^ENCHANT DONE
    gosub put my gweth in my tel case
    goto loop
