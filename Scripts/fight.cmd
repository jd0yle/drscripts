include libsel.cmd


var attacks
var doAnalyze 1
#action var attacks $2; goto doTheThing when ^(Balance reduction|Armor reduction|A chance for a stun) can be inflicted.* by landing (.*)

action send adv when ^You must be closer to use tactical abilities on your opponent.
action var doAnalyze 1 when ^Utilizing \S+ tactics
action var doAnalyze 0; var attacks $2 when ^(Balance reduction|Armor reduction|A chance for a stun) can be inflicted.* by landing (.*)
action var doAnalyze 1 when ^You can no longer see openings
action var doAnalyze 1 when You fail to find any




loop:
    if $monsterdead > 0 then gosub Skinning

    if (%doAnalyze = 1) then {
        gosub hunt
        gosub hide
    }

    if $monstercount > 0 && %doAnalyze = 1 then gosub analyze
    if %doAnalyze = 0 then {
        goto doTheThing
    }
    goto loop


doTheThing:
    if ($monstercount < 2) then goto loop
    eval attacks replace("%attacks", " and", ",")
    eval attacks replace("%attacks", "a ", "")
    eval attacks replace("%attacks", "an ", "")
    eval attacks replace("%attacks", ",", "|")
    eval attacks replace("%attacks", ".", "")
    eval attacks replace("%attacks", " ", "")
    eval length count("%attacks", "|")
    var index 0

    #echo %attacks
    if (!contains("$monsterlist", "sleeping")) then gosub prep mb
    pause 4
    gosub cast

attackLoop:
    gosub attack %attacks(%index)
    math index add 1
    if (%index > %length) then goto loop
    goto attackLoop

