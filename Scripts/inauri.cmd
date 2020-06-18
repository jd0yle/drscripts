include libsel.cmd

action goto giveInauri when eval contains("$roomplayers", "Inauri")

waiting:
    pause 2
    goto waiting

giveInauri:
    put say /sleep I waited all night to give you this!
    gosub get my rose
    put give inauri
    pause
    put say /sleep My soul is complete.
    pause
    pause
    put lay on sandpit
    waitfor You lie down
    gosub get my s'kra doll
    put snuggle s'kra doll
    pause
    put smile contentedly as he drifts off to sleep.
    exit
