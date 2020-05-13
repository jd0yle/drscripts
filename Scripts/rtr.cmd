include libsel.cmd

var doPredictions %1

var isFullyPrepped 0

action var object $1; goto rtrObserve when ^As your consciousness drifts amongst the currents of Fate, you find yourself drawn towards the .* (\S+)\.
action goto rtrDone when ^As your ritual ebbs away, you find yourself returned to a world of immutable, indisputable facts

action var isFullyPrepped 1 when ^You feel fully prepared to cast your spell.

action var magicPredState $1 when (\S+) understanding of the celestial influences over magic.$
action var lorePredState $1 when (\S+) understanding of the celestial influences over lore.$
action var offensePredState $1 when (\S+) understanding of the celestial influences over offensive combat.$
action var defensePredState $1 when (\S+) understanding of the celestial influences over defensive combat.$
action var survivalPredState $1 when (\S+) understanding of the celestial influences over survival.$

#goto rtrWait

gosub stow right
gosub stow left

put sit

if ($SpellTimer.ReadtheRipples.active = 1) then goto rtrObserve

gosub prep rtr 690
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
    matchre rtrPred ^Although you were nearly overwhelmed by some aspects of your observation, you still learned more of the future.
    matchre rtrPred ^You learned something useful from
    matchre rtrObserve ^You see nothing regarding the future.
    put observe %object in sky
    matchwait


rtrPred:
    if (%doPredictions) then {
        if ("$righthand" != "Empty" && "$righthandnoun" != "bones") then gosub stow right
        if ("$righthandnoun" != "bones") then gosub get my bones
        put pred state all
        if ("%lorePredState" != "no") then {
            gosub align lore
            gosub roll bones at $charactername
        } else if ("%offensePredState" != "no") then {
            gosub align offense
            gosub roll bones at $charactername
        } else if ("%survivalPredState" != "no") then {
            gosub align survival
            gosub roll bones at $charactername
        } else if ("%defensePredState" != "no") then {
            gosub align defense
            gosub roll bones at $charactername
        } else if ("%magicPredState" != "no") then {
            gosub align magic
            gosub roll bones at $charactername
        }
    }
    gosub rtrWait
    return


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
