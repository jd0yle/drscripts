include libsel.cmd

var ritualFocus inauri plush

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

#action put #queue clear;put #send 1 $lastcommand when ^Sorry,|^\.\.\.wait

gosub stow right
gosub stow left

put .astro
waitforre ^ASTRO DONE$

gosub waitForConcentration

put sit

if ($SpellTimer.ReadtheRipples.active = 1) then goto rtrObserve

gosub prep rtr 750
gosub get my %ritualFocus
put invoke my %ritualFocus
goto prepWait

prepWait:
pause 1
if (%isFullyPrepped != 1) then goto prepWait
gosub cast
gosub stow right
goto rtrObserve



rtrObserve:
    matchre rtrPred ^Although you were nearly overwhelmed by some aspects of your observation, you still learned more of the future.
    matchre rtrPred ^You learned something useful from
    matchre rtrObserve ^You see nothing regarding the future.
    put observe %object in sky
    matchwait


rtrPred:
    if (%doPredictions) then {
        gosub pred state all
        if ("%lorePredState" != "no") then {
            gosub align lore
            gosub predict future $charactername
        } else if ("%offensePredState" != "no") then {
            gosub align offense
            gosub predict future $charactername
        } else if ("%survivalPredState" != "no") then {
            gosub align survival
            gosub predict future $charactername
        } else if ("%defensePredState" != "no") then {
            gosub align defense
            gosub predict future $charactername
        } else if ("%magicPredState" != "no") then {
            gosub align magic
            gosub predict future $charactername
        }
        echo predictionCount: $predictionCount
        put title pre choose moonm harbi
    }
    gosub rtrWait
    return


waitForConcentration:
    if ($concentration > 50) then return
    pause 2
    goto waitForConcentration


rtrWait:
    pause 2
    goto rtrWait

rtrDone:
    gosub stand
    echo RTR Complete
    put #parse RTR DONE
    exit




exit

var args %1|%2|%3|%4|%5|%6|%7|%8|%9




echo %args

echo %args(0)
echo %args(1)
