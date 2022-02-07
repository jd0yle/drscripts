include libmaster.cmd
action var isAsleep 1 when ^You awaken from your reverie

###############################
###      INIT
###############################
if (!($lastAlmanacGametime >0)) then put #var lastAlmanacGametime 0
var noloop %1
var isAsleep 0


###############################
###      MAIN
###############################
main:
    evalmath nextStudyAt $lastAlmanacGametime + 600

    if (%nextStudyAt < $gametime) then {
        if ("$lefthandnoun" != "$char.trainer.almanac" && "$righthandnoun" != "$char.trainer.almanac") then {
            gosub get my $char.trainer.almanac
            gosub awake
        }
        if ("$lefthandnoun" != "$char.trainer.almanac" && "$righthandnoun" != "$char.trainer.almanac") then goto done
        if ("$lefthandnoun" != "$char.trainer.almanac") then gosub swap
        gosub study my $char.trainer.almanac
        gosub put my $char.trainer.almanac in my $char.inv.container.almanac
        if (%isAsleep = 1) then {
            gosub sleep
            gosub sleep
            var isAsleep 0
        }
        if ("$lefthand" != "Empty") then gosub swap
        put #var lastAlmanacGametime $gametime
    }
    pause 2
    if ("%noloop" = "noloop") then goto done
    goto main


done:
    delay .2
    put #parse ALMANAC DONE
    exit