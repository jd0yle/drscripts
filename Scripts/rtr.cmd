include libsel.cmd

var isFullyPrepped 0

action var object $1; goto rtrObserve when ^As your consciousness drifts amongst the currents of Fate, you find yourself drawn towards the .* (\S+)\.
action goto rtrDone when ^As your ritual ebbs away, you find yourself returned to a world of immutable, indisputable facts

action var isFullyPrepped 1 when ^You feel fully prepared to cast your spell.

#goto rtrWait

gosub stow right
gosub stow left

put sit

if ($SpellTimer.ReadTheRipples.active = 1) then goto rtrObserve

gosub prep rtr 675
gosub remove my staff
put invoke my staff
goto prepWait

prepWait:
pause 1
if (%isFullyPrepped != 1) then goto prepWait
gosub cast
gosub wear my staff
goto rtrObserve



rtrObserve:
    matchre rtrWait ^Although you were nearly overwhelmed by some aspects of your observation, you still learned more of the future.
    matchre rtrWait ^You learned something useful from
    matchre rtrObserve ^You see nothing regarding the future.
    put observe %object in sky
    matchwait

rtrWait:
    pause 2
    goto rtrWait

rtrDone:
    put stand
    echo RTR Complete
    put pred state all
    exit




exit

var args %1|%2|%3|%4|%5|%6|%7|%8|%9




echo %args

echo %args(0)
echo %args(1)
