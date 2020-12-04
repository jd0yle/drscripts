include libsel.cmd

action goto dirtdone when ^There doesn't seem to be any more room left in your silver vial to fit that dirt!


dirtLoop:
    gosub forage dirt
    gosub put my dirt in my vial
    goto dirtLoop

dirtdone:
    gosub drop my dirt
    exit
