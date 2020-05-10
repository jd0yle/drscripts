var friends $charactername
action var friends %friends|$1 when (\S+)
pause .5
put #names
pause .5
echo %friends
exit
