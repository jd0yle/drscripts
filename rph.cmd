include libmaster.cmd

var skillToCheck null
var skillRanksToCheck 0

if_1 then {
    var skillToCheck %1
}

if_2 then {
    var skillRanksToCheck %2
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

        var echoSkillRanks
	    if (%skillRanksToCheck != 0) then {
	        evalmath ranksToGain round(%skillRanksToCheck - $%skillToCheck.Ranks, 2)
	        evalmath hoursToRanks round(%ranksToGain * %hpr, 2)
	        evalmath daysToRanks round(%ranksToGain * %dpr, 2)
	        var echoSkillRanks Time To Gain %ranksToGain: %hoursToRanks hrs  (%daysToRanks days)
	    }

	    echo %rph  |  %rpd  |  %hpr  |  %dpr  - %skills(%i) $%skills(%i).Ranks (+%ranks(%i))  %echoSkillRanks
    }
    math i add 1
    if (%i > %len) then goto done
    goto loop





done:
    exit