include libsel.cmd
####################################################################################################
# .teach
# Selesthiel - Justin Doyle - justin@jmdoyle.com
# 2020/07/06
#
# USAGE
# .teach SKILL [to] CHARACTER
# .teach tactics inauri
# .teach enchanting to selesthiel
#
# DEPENDENCIES: libsel.cmd, .logafter
# TODO: Add teaching the entire room
####################################################################################################

var isTeaching 0
action var isTeaching 1 when ^You begin to lecture

action goto done when ^You are already teaching a different class.$
action goto done when ^I could not find who you were referring to.$

var topic %1
var student %2
if ("%2" = "to") then var student %3


doTeach:
    #gosub awake

    put awake
	gosub stop listen
	gosub teach %topic to %student
	pause 2
	if (%isTeaching = 1) then goto done
	pause 2
	goto doTeach


done:
    pause .2
    put #parse TEACH DONE
    exit
