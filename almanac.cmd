include libmaster.cmd
action var isAsleep 1 when ^You awaken from your reverie

##############
# Variables Init
##############
if (!($lastAlmanacGametime >0)) then put #var lastAlmanacGametime 0

put .var_$charactername.cmd
waitforre ^CHARVARS DONE$
var noloop %1
var isAsleep 0


##############
# Main
##############
main:
    evalmath nextStudyAt $lastAlmanacGametime + 600

    if (%nextStudyAt < $gametime) then {
        #put #script pause all except almanac
        if ("$lefthandnoun" != "$char.magic.train.almanac" && "$righthandnoun" != "$char.magic.train.almanac") then {
            gosub get my $char.magic.train.almanac
            gosub awake
        }
        if ("$lefthandnoun" != "$char.magic.train.almanac") then gosub swap
        gosub study my $char.magic.train.almanac
        gosub put my $char.magic.train.almanac in my $char.magic.train.almanacContainer
        if (%isAsleep = 1) then {
            gosub sleep
            gosub sleep
            var isAsleep 0
        }
        put #var lastAlmanacGametime $gametime
        put #script resume all
    }
    pause 2
    if ("%noloop" = "noloop") then goto done
    goto main


done:
    delay .2
    put #parse ALMANAC DONE
    exit