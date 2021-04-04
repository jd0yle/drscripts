include libmaster.cmd

var skillToCheck null
if_1 then {
    var skillToCheck %0
} else {

    #echo
    #echo MUST SPECIFY NUMBER OF HOURS
    #echo .rph <numHours>
    #exit
}

evalmath numHours (($gametime - $lastLoginTime) / 60 / 60)
evalmath numDays (($gametime - $lastLoginTime) / 60 / 60 / 24)
if (!(%numHours > 0)) then var %numHours 1
if (!(%numDays > 0)) then var %numDays 1
echo numHours: %numHours




var skills skills
var ranks ranks

action var skills %skills|$1; var ranks %ranks|$2 when (\S.*):.*34\) \+(\d+\.\d+)
#action var skillName {#eval {replace($1, " ", "_"}}; var %skillName $2 when (\S.*):.*34\) \+(\d+\.\d+)

delay .5
put /track report
delay 2

var i 0
eval len count("%skills", "|")

echo RPH  |  RPD  |  HPR  |  DPR  - SKILL: RANKS




loop:
    #eval n replace(%skills(%i), " ", "_")
    #eval skillName replace(%skills(%i), " ", "_")
    if ("%skillToCheck" = "null" || "%skillToCheck" = "%skills(%i)") then {
	    evalmath rph round(%ranks(%i) / %numHours, 2)
	    evalmath rpd round(%ranks(%i) / %numDays, 2)
	    evalmath hpr round(1 / %rph, 2)
	    evalmath dpr round(1 / %rpd, 2)
	    echo %rph  |  %rpd  |  %hpr  |  %dpr  - %skills(%i): %ranks(%i)
    }
    math i add 1
    if (%i > %len) then goto done
    goto loop





done:
    exit