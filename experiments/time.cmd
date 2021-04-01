####################################################################################################
# time.cmd
# Selesthiel - justin@jmdoyle.com
# USAGE
# include libsel.cmd
####################################################################################################

include libsel.cmd

var ts $time

echo ts is %ts

eval hh substring("%ts", 0, 2)
eval mm substring("%ts", 3, 2)
eval ss substring("%ts", 6, 2)

if (matchre("%ts", "PM")) then math hh add 12

echo hh is %hh
echo mm is %mm
echo ss is %ss


evalmath seconds (60 * 60 * %hh) + (%mm * 60) + %ss)

echo %hh:%mm:%ss - %seconds
