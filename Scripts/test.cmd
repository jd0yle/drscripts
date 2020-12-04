include libsel.cmd

var isPrepped 0
action var isPrepped 1 when Your formation

loop:
var isPrepped 0
gosub target burn 30
pause 5
gosub retreat
gosub cast
gosub retreat
put loot treasure
goto loop


waitForMana:
    if ($mana > 13) then return
    pause
    gosub retreat
    goto waitForMana

waitForPrep:
    if (%isPrepped = 1) then return
    pause
    gosub retreat
    goto waitForPrep

exit









var charges null
action var charges $1; put #echo >Log Gweth charges: $1 when ^It has (\d+) charges

start:
    gosub get gweth from my tel case
    gosub focus my gweth
    gosub lower ground
    gosub get tag from tag sack
    gosub get my quill
    put write %charges
    gosub put my quill in my bag
    gosub get my gweth
    put put my tag on my gweth
    pause
    gosub put my gweth in my haversack
    goto start
