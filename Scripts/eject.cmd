

action goto ejectFromHouse when eval "$roomplayers" != ""

ejectLoop:
    if (contains("$roomplayers", "Nideaya")) then {
        put #script abort all except eject
        put .reconnect
        put show Nideaya to door
        pause .2
        put show Nideaya to door
        pause 1
        goto ejectLoop
    }

ejectFromHouse:
	eval names replacere("$roomplayers", "Also here: ", "")
	eval names replacere("%names", "(,| and)", "|")
	eval names replacere("%names", "\.", "")

	var index 0
	eval namesLength count("%names", "|")

	ejectloop:
	    if ("%names(%index)" != "Inauri") then {
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