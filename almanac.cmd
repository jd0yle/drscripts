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
        if ("$lefthandnoun" != "$char.magic.train.almanacItem" && "$righthandnoun" != "$char.magic.train.almanacItem") then {
            gosub get my $char.magic.train.almanacItem
            gosub awake
        }
        if ("$lefthandnoun" != "$char.magic.train.almanacItem") then gosub swap
        gosub study my $char.magic.train.almanacItem
        gosub put my $char.magic.train.almanacItem in my $char.magic.train.almanacContainer
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