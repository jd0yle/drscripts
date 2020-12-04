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

var topic %1
var student %2
if ("%2" = "to") then var student %3

put #script pause all except teach
pause
gosub awake
put stop listen
gosub teach %topic to %student
pause
put #script resume all
exit
