setvariable numfavors 50
setvariable wep1
setvariable wep2

put #script abort favors

#echo **********************************************************
#echo **********************************************************
#echo
#echo          By default this script will get you
#echo          favors until you have 10.  If you
#echo          want more than 10 favors, change the
#echo          first line of this script.
#echo
#echo          This script requires the .go (dir) and
#echo          .climb (climbing) scripts.
#echo
#echo          START IN CROSSING WHERE DIR IS ACCESSIBLE
#echo
#echo **********************************************************
#echo **********************************************************

pause 2

goto rub

gate_favors:
#echo ************** GETTING AN ORB **************
put .go favors
waitfor [Siergelde, Ruins]
put go stone
put kneel
put pray
pause
put pray
put pray
pause
put '$favorgod
pause
put stand
pause
put get $favorgod orb
pause
put go arch
goto puzzle

puzzle:
pause
match fillfont You also see a granite altar with several candles and a water jug on it, and a granite font.
match lightcandle You also see some tinders, several candles, a granite font and a granite altar.
match cleanaltar You also see a granite altar with several candles on it, a granite font and a small sponge.
match pickflowers You also see a vase on top of the altar.
match openwindow A table sits against one wall, directly opposite an ancient window.
match favors_gate [Siergelde, Stone Grotto]
put look
matchwait

fillfont:
pause
put fill font
pause
match fillfont With a practiced eye, you begin to check the various acoutrements around you.
match fillfont2 You reach the top of the stairway, and notice that the door has swung open of its own accord!
put go stair
matchwait
fillfont2:
put go door
goto puzzle

pickflowers:
pause
put pick flowers
pause
put go tree
goto puzzle

lightcandle:
pause
put light candle
pause
match lightcandle With a practiced eye, you begin to check the various acoutrements around you.
match lightcandle2 You reach the top of the stairway, and notice that the door has swung open of its own accord!
put go stair
matchwait
lightcandle2:
put go door
goto puzzle

cleanaltar:
pause
put clean altar
pause
match cleanaltar With a practiced eye, you begin to check the various acoutrements around you.
match cleanaltar2 You reach the top of the stairway, and notice that the door has swung open of its own accord!
put go stair
matchwait
cleanaltar2:
put go door
goto puzzle

openwindow:
pause
match openwindow Roundtime
match openwindow2 cool, swift breeze
put open window
matchwait
openwindow2:
pause
match openwindow closed window
match puzzle hoist yourself
put go window
matchwait

favors_gate:
#echo ************** FILLING THE ORB **************
move e
put #walk crossing
waitfor [The Crossing, Western Gate]

put #walk temple
waitfor [Temple Grounds, Entry Gates]

put #walk favor
waitfor [Resurrection Creche, Li Stil rae Kwego ia Kweld]
put stow my orb
waitfor You put
goto rub

rub:
match gate_favors Hug what?
match gate_favors Rub what?
match rub not yet fully prepared.
match fill_pool lacking in the type of sacrifice the orb requires.
match get_favor your sacrifice is properly prepared.
put rub my $favorgod orb
matchwait


fill_pool:
put .climb 1
pause 5
waitfor [First Provincial Bank, Lobby]
put #script abort climb
goto rub

get_favor:
#echo ************** TO THE TEMPLE **************
put .go temple
waitfor [Resurrection Creche, Li Stil rae Kwego ia Kweld]
put get my $favorgod orb
waitfor You get
put put my $favorgod orb on altar
pause
put #walk crossing
waitfor [The Crossing, Immortals' Approach]
match gate_favors EXP HELP
match done Favors: %numfavors
put exp
matchwait

done:
pause 2
#echo ************** YOU NOW HAVE %num_favors FAVORS! **************
