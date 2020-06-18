include libsel.cmd

action goto doAcc when offers you

doWait:
    pause 2
    goto doWait

doAcc:
    put accept
    pause
    gosub put $righthandnoun in my canvas backpack
    goto doWait


