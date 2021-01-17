include libsel.cmd

#action put #echo >Everything $1 when ^(.*)$

#action echo Caught when DESTINATION NOT FOUND
#action send 2 #parse MOVE FAILED when DESTINATION NOT FOUND

pause
gosub automove -1
echo After Move

exit


asdfautomove:
    var toroom $0
    var moveAttemptsRemaining 5

asdfautomovecont:
    match return YOU HAVE ARRIVED
    match automovecont1 YOU HAVE FAILED
    match automovecont1 AUTOMAPPER MOVEMENT FAILED!
    match automovecont1 MOVE FAILED
    matchre automovecont1 DESTINATION NOT FOUND
    put #walk %toroom
    matchwait 30
    goto automovecont1

asdfautomovecont1:
    math moveAttemptsRemaining subtract 1
    if (%moveAttemptsRemaining < 1) then {
        echo No more attempts, it's dead, Jim
        return
    }
    pause 1
    put look
    pause 1
    goto automovecont


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
