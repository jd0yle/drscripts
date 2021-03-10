

action #setvariable heal 1 when ^Selesthiel whispers, \"heal\"
action #setvariable heal 2 when ^Selesthiel whispers, \"heal again\"
action #setvariable poison 1 when ^Selesthiel whispers, \"poison\"
action #setvariable expSleep 1 when ^Selesthiel whispers, \"!sleep\"
action #setvariable expSleep 2 when ^Selesthiel whispers, \"!awaken\"

if (!($lastAlmanacGametime >0)) then put #var lastAlmanacGametime 0

loop:
    if ($heal = 1 || $heal = 2) then {
        #do the heal thing
    }
    if ($poison = 1) then {
        #do the poison thing
    }

    gosub studyAlmanac
    pause 2
goto loop






studyAlmanac:
    evalmath nextStudyAt $lastAlmanacGametime + 600

    if (%nextStudyAt < $gametime) then {
        if ("$lefthandnoun" != "almanac" && "$righthandnoun" != "almanac") then {
            gosub get my almanac
        }
        gosub study my almanac
        gosub stow my almanac
        put #var lastAlmanacGametime $gametime
    }
    return