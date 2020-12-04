#stowbot.cmd

include libsel.cmd

action goto botAccept when \S+ offers you.*ACCEPT
action var givePerson $1; goto botGive when ^(Inauri|Selesthiel) whispers, "give"

waiting:
    pause 2
    goto waiting

botAccept:
    put accept
    pause
    gosub stow right
    gosub stow left
    gosub wear right
    goto waiting

botGive:
  gosub remove my backpack
  gosub give my backpack to %givePerson
  goto waiting