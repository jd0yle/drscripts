
var isObsOnCd 0

#action goto obs when ^You feel you have sufficiently pondered your latest observation.
action var isObsOnCd 0 when ^You feel you have sufficiently pondered your latest observation.

loop:
    gosub checkBuffs
    if %isObsOnCd = 0 then gosub obs
    goto waiting

waiting:
    pause 2
    goto loop


obs:
    send observe yoa
    var isObsOnCd 1
    pause
    send pred stat all
    pause
    send align survival
    pause
    send pred fut selesthiel
    pause
    return


checkBuffs:
    var buffs cv|pg|seer|aus|shadows|psy|col
    var buffVars ClearVision|PiercingGaze|SeersSense|AuraSight|Shadows|PsychicShield|CageofLight

    var i 0
    eval len count("%buffs", "|")
    gosub buffLoop
    return

buffLoop:
    if %i > %len then return
    var name %buffVars(%i)

    if $SpellTimer.%name.active != 1 then gosub cast %buffs(%i)
    math i add 1
    goto buffLoop


cast:
    if "$1" = "col" then
    {
        if $Time.isYavashUp = 1 then var target yavash
        if $Time.isXibarUp = 1 then var target xibar
        if $Time.isKatambaUp = 1 then var target katamba
        if "%target" = "" then return
    }
    send prep $1 50
    waitfor You feel fully prepared
    send cast %target
    return
