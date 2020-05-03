put #class racial on
put #class rp on
put #class combat off
put #class joust off
action goto exit when closes to .+ range on you


# ----------------------------------------
# Movement script that uses the built in DIR command to move.
# Script created by Conny 2004-01-05
# Script updated 2007-10-20
# ----------------------------------------

# standard = 2, premium = 3
setvar maxdepth 1
setvar depth 0

action math depth subtract 1 when ^Obvious
action math depth subtract 1 when ^It's pitch dark

put #script abort to

if_1 goto start
put dir list
exit

start:
    action setvar next $2;setvar move $1;goto parse when ^@([\w\- ]+), (.+)\.
    action setvar next $2;setvar move $1;goto parse when ^Directions towards.+: ([\w\- ]+), (.+)\.
    action setvar next $2;setvar move $1;goto parse when ^Directions towards.+: ([\w\- ]+) and you're there.
    action setvar next $2;setvar move $1;goto parse when ^Directions towards.+: ([^,]+) and you're there.
    matchre parsefail ^Directions aren't available in your current area\.
    matchre parsefail ^I don't know the way from here to the
    matchre done ^You're there already!
    put dir %0 50
    put dir stop
    matchwait

parse:
    gosub move %move
    put #parse @%next.
    pause 1
    goto done
parsefail:
    echo *** Movement failed! ***
    exit
done:
    put look
    echo *** You are there! ***
    exit

# ---

move:
    math depth add 1
    setvariable direction $0
    if %depth < %maxdepth then goto move.whip
    goto move.real
move.whip:
    put %direction
    goto return
move.real:
    matchre move.real ^\.\.\.wait
    matchre move.real ^Sorry, you may only type ahead
    matchre move.failed ^You can't go there
    matchre move.failed ^Remove what?$
    matchre move.failed ^What were you referring to
    matchre move.retreat ^You are engaged to
    matchre return ^It's pitch dark
    matchre return ^Obvious
    put %direction
    matchwait
move.retreat:
    put retreat
    put retreat
    wait
    goto move.real
move.failed:
    echo *** MOVE FAILED ***
    goto move.real

return:
    return
	
exit:
exit