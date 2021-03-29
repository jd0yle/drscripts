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

var topic %1
var student %2
if ("%2" = "to") then var student %3


doTeach:
	gosub awake
	gosub stop listen
	gosub teach %topic to %student
	pause 3
	if (%isTeaching = 1) then goto done
	goto doTeach


done:
    pause .2
    put #parse TEACH DONE
    exit
