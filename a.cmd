include libmaster.cmd

var item %0

loop:
    gosub get my %item from my satchel
    put put my %item in my haversack
goto loop
