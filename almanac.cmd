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
        if ("$lefthandnoun" != "$char.trainer.almanacItem" && "$righthandnoun" != "$char.trainer.almanacItem") then {
            gosub get my $char.trainer.almanacItem
            gosub awake
        }
        if ("$lefthandnoun" != "$char.magic.train.almanacItem") then gosub swap
        gosub study my $char.trainer.almanacItem
        gosub put my $char.magic.train.almanacItem in my $char.trainer.almanacContainer
        if (%isAsleep = 1) then {
            gosub sleep
            gosub sleep
            var isAsleep 0
        }
        put #var lastAlmanacGametime $gametime
    }
    pause 2
    if ("%noloop" = "noloop") then goto done
    goto main


done:
    delay .2
    put #parse ALMANAC DONE
    exit