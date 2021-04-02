action goto ejectFromHouse when eval "$roomplayers" != ""

ejectFromHouse:
    eval names replacere("$roomplayers", "Also here: ", "")
    eval names replacere("%names", "(,| and)", "|")
    eval names replacere("%names", "\.", "")

    var index 0
    eval namesLength count("%names", "|")

    ejectloop:
        if ("%names(%index)" != "Selesthiel") then {
            put show %names(%index) to door
            pause .5
            put show %names(%index) to door
            pause .5
        }
        math index add 1
        if (%index > %namesLength) then goto ejectdone
        goto ejectloop

    ejectdone:
    exit