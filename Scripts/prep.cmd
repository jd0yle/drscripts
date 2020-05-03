#name prepmin prepmax skillmin skillmax durationmin max
#col 15 100 80 800 10m 40m

var buffs cv|pg|seer|aus|shadows|psy|col
var buffVars ClearVision|PiercingGaze|SeersSense|AuraSight|Shadows|PsychicShield|CageofLight

var i 0
eval len count("%buffs", "|")

loop:
    if %i > %len then goto waiting
    var name %buffVars(%i)
    echo %name
    if $SpellTimer.%name.active != 1 then gosub cast %buffs(%i)
    math i add 1
    goto loop


cast:
    if "$1" = "col" then
    {
        if $Time.isYavashUp = 1 then var target yavash
        if $Time.isXibarUp = 1 then var target xibar
        if $Time.isKatambaUp = 1 then var target katamba
        if "%target" = "" then return
    }
    send prep $1 60
    pause
    send charge my armband 40
    pause
    send charge my armband 40
    pause
    send focus my armband
    pause
    send invoke my armband
    waitfor You feel fully prepared
    send cast %target
    return


waiting:
exit
    pause 30
    goto loop
