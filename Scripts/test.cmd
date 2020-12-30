include libsel.cmd

action put accept; put put box in my portal when offers you

loop:
pause 2
goto loop

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
