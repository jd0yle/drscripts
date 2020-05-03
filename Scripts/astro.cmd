


var cooldown 1

action var predPool$2 $1 when ^You have (.*?) understanding of the celestial influences over (magic|lore|offensive|defensive|survival|future)
action var cooldown 1 when ^You learned something useful from your observation.
action var cooldown 0 when ^You have not pondered your last observation sufficiently.
action var cooldown 0 when ^You feel you have sufficiently pondered your latest observation.


loop:
	if (%cooldown = 1) then 
	{	
		gosub predState
	}
	
	if (%cooldown = 1) then 
	{
		send observe xibar
	}
	
	echo "Pausing for 60s"
	pause 60
	goto loop
	
	
	
predState:
	send pred state all
	pause 1
	
	if %predPoollore != "no" then {
		gosub predict lore
		return
	}
	
	if %predPoolMagic != "no" then {
		gosub predict magic
		return
	}
	
	
	
	if %predPooloffensive != "no" then {
		gosub predict lore
		return
	}
	
	if %predPooldefensive != "no" then {
		gosub predict lore
		return
	}
	
	if %predPoolsurvival != "no" then {
		gosub predict lore
		return
	}
	return
	
predict:
	pause 2
	send align $1
	pause 2
	send predict future Selesthiel
	pause 10
	return




echo %predPoolmagic
echo %predPoollore
echo %predPooloffensive
echo %predPooldefensive
echo %predPoolsurvival
echo %predPoolfuture

exit



#heart survival
#sun survival
#yavash magic
#xibar lore
#katamba defense

#You feel you have sufficiently pondered your latest observation.

#observe object in sky

#loop:







#action var predPoolMagic $1 when ^You have (.*?) understanding of the celestial influences over magic.
#You have a feeble understanding of the celestial influences over lore.
#You have no understanding of the celestial influences over offensive combat.
#You have no understanding of the celestial influences over defensive combat.
#You have no understanding of the celestial influences over survival.
#You have no understanding of the celestial influences over future events.