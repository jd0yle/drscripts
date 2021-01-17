
# .timer <seconds> <command>
# Runs command after given number of seconds

evalmath newNextTimerActionAt $gametime + %1
eval newNextTimerActionCommand replacere("%0", ^\d+\s*, "")

if (!($nextTimerActionAt > 0)) then put #var nextTimerActionAt 0

put #var nextTimerActionAt %newNextTimerActionAt
put #var nextTimerActionCommand %newNextTimerActionCommand

echo $nextTimerActionAt
echo $nextTimerActionCommand


loop:
    if ($nextTimerActionAt < $gametime) then {
        pause .2
        send $nextTimerActionCommand
        put #echo >Log [timer] Performed action
        goto done
    }
    pause 1
    goto loop


done:
    pause .2
    put #parse TIMER DONE
    exit

