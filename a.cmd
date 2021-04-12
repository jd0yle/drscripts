include libmaster.cmd

var item %0

loop:
    gosub get my %item from my satchel
    gosub put my %item in my silver backpack
goto loop
