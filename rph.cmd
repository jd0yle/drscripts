include libmaster.cmd

if_1 then {
    var numHours %1
} else {
    echo
    echo MUST SPECIFY NUMBER OF HOURS
    echo .rph <numHours>
    exit
}

var skills skills
var ranks ranks

action var skills %skills|$1; var ranks %ranks|$2 when (\S.*):.*34\) \+(\d+\.\d+)
#action var skillName {#eval {replace($1, " ", "_"}}; var %skillName $2 when (\S.*):.*34\) \+(\d+\.\d+)

pause .5
put /track report
pause 2

var i 0
eval len count("%skills", "|")

loop:
    #eval n replace(%skills(%i), " ", "_")
    #eval skillName replace(%skills(%i), " ", "_")

    evalmath rph round(%ranks(%i) / %numHours, 2)
    echo %skills(%i): %ranks(%i) - %rph
    math i add 1
    if (%i > %len) then goto done
    goto loop


done:
    exit