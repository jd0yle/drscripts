#Mini Travel
  goto mTravel.main

mTravel.main:
  goto %1


################
Ratha
################

first:
  move go grate
  move go pipe
  move s
  move climb rung
  move s
  move s
  move se
  move e
  move d
  move se
  move ne
  move s
  move ne
  move e
  move s
  move d
  move e
  move ne
  move se
  move go pass
exit

fourth:
  move w
  move nw
  move sw
  move u
  move n
  move w
  move sw
  move n
  move sw
  move nw
  move u
  move w
  move nw
  move n
  move n
  move climb ladder
  move n
  move n
  move go pipe
  move n
  move go grat
exit

################
Aesry
################

aesryup:
  move go gate
  move w
  move w
  move w
  move climb stair
waitfor You reach the end
  move w
  move climb stair
waitfor You reach the end
  move w
  move climb stair
waitfor You reach the end
  move w
  move climb stair
waitfor You reach the end
  move w
  move climb stair
waitfor You reach the end
  move w
  move climb stair
waitfor You reach the end
  move w
  move climb stair
waitfor You reach the end
  move w
  move climb step
waitfor You reach the end
  move w
  move go gate
  move w
  move w
echo * .mtravel aesryup done
echo * .mtravel aesrybeach to continue up or
echo * .mtravel aesrydown to go back down
exit

aesrydown:
  move e
  move go gate
  move e
  move e
  move climb stair
waitfor You reach the end
  move e
  move climb stair
waitfor You reach the end
  move e
  move climb stair
waitfor You reach the end
  move e
  move climb stair
waitfor You reach the end
  move e
  move climb stair
waitfor You reach the end
  move e
  move climb stair
waitfor You reach the end
  move e
  move climb stair
waitfor You reach the end
  move e
  move climb stair
waitfor You reach the end
  move e
  move e
  move go gate
  move e
echo * .mtravel aesrydown done
echo * .mtravel aesryup to go back up
echo * 
exit


aesrybeach:
  move climb path
waitfor You reach
  move sw
  move w
  move climb trail
waitfor You reach the end
  move n
  move climb trail
waitfor You reach the end
  move nw
  move w
  move climb road
waitfor You reach the end
  move s
  move climb trail
waitfor You reach the end
  move sw
  move climb path
waitfor You reach the end
  move nw
  move climb ramp
waitfor You reach the end
  move w
  move climb walk
waitfor You reach the end
  move w
  move w
  move w
  move s
  move s
  move s
  move climb ladder
  move climb jetty
echo * .mtravel aesrybeach done
echo * .mtravel aesrywolves to go back up
echo * .aesryswim to go swimming
exit

aesrywolves:
  move climb jetty
  move climb ladder
  move n
  move n
  move n
  move e
  move e
  move e
  move climb walk
waitfor You reach the end
  move e
  move climb ramp
waitfor You reach the end
  move se
  move climb path
waitfor You reach the end
  move ne
  move climb trail
waitfor You reach the end
  move n
  move climb road
waitfor You reach the end
  move e
  move se
  move climb trail
waitfor You reach the end
  move s
  move climb trail
waitfor You reach the end
  move e
  move ne
  move climb path
waitfor You reach the end
echo * .mtravel aesrywovles done
echo * .mtravel aesrydown to go to the city
echo * .mtravel aesrybeach to go back down
exit



################
Therengia
################

theren:
  if "%LOCATION" = "[]" then goto bitheren
  if "%LOCATION" = "[]" then goto btheren
  if "%LOCATION" = "[]" then goto t.echo
  put look
  waitforre ^Obvious

bitheren:
  move ne
  move ne
  move e
  move n
  move n
  move ne
  move ne
  move n
  move nw
  move n
  move n
  move n
  move go bridge
  move n
  move n
  move go shore
  move n
  move nw
  move n
  move nw
  move ne
  move nw
  move n
  move n
  move ne
  move nw
main:
  move n 
  move w 
  move nw 
  move n 
  move n 
  move nw 
  move n 
  move ne 
  move ne 
  move n 
  move n 
  move nw 
  move n 
  move ne
  move n 
  move n 
  move ne 
  move nw 
  move ne 
  move e 
  move n 
  move n 
  move ne
  move n
  move n 
  move ne 
  move ne 
  move nw 
  move ne 
  move ne 
  move ne 
  move n 
  move ne
  move e
  move n
  move n
  move ne 
  move ne 
  move nw 
  move n 
exit

btheren:
  move n 
  move w 
  move nw 
  move n 
  move n 
  move nw 
  move n 
  move ne 
  move ne 
  move n 
  move n 
  move nw 
  move n 
  move ne
  move n 
  move n 
  move ne 
  move nw 
  move ne 
  move e 
  move n 
  move n 
  move ne
  move n
  move n 
  move ne 
  move ne 
  move nw 
  move ne 
  move ne 
  move ne 
  move n 
  move ne
  move e
  move n
  move n
  move ne 
  move ne 
  move nw 
  move n 
exit

t.echo:
  echo  You're already in Therenborough.

bain:
  if "%LOCATION" = "[]" then goto lbain
  if "%LOCATION" = "[]" then goto tbain
  if "%LOCATION" = "[]" then goto b.echo
  put look
  waitforre ^Obvious

lbain:
  move ne
  move ne
  move e
  move n
  move n
  move ne
  move ne
  move n
  move nw
  move n
  move n
  move n
  move go bridge
  move n
  move n
  move go shore
  move n
  move nw
  move n
  move nw
  move ne
  move nw
  move n
  move n
  move ne
  move nw
exit

tbain:
  move s 
  move se
  move sw 
  move sw 
  move s 
  move s 
  move w 
  move sw 
  move s 
  move sw 
  move sw 
  move sw
  move se
  move sw 
  move sw
  move s
  move s 
  move sw 
  move s
  move s 
  move w 
  move sw 
  move se 
  move sw 
  move s 
  move s 
  move sw
  move s
  move se
  move s 
  move s 
  move sw 
  move sw 
  move s 
  move se
  move s 
  move s 
  move se
  move e
  move s 
exit

b.echo:
echo  You're already in El'Bain's.


bin:
if "%LOCATION" = "[]" then goto bbin
if "%LOCATION" = "[]" then goto tbin
if "%LOCATION" = "[]" then goto bi.echo
put look
waitforre ^Obvious

lbin:
  move se
  move sw
  move s
  move s
  move se
  move sw
  move se
  move s
  move se
  move s
  move go bridge
  move s
  move s
  move go shore
  move s
  move s
  move s
  move se
  move s
  move sw
  move sw
  move s
  move s
  move w
  move sw
  move sw
exit

tbin:
  move s 
  move se
  move sw 
  move sw 
  move s 
  move s 
  move w 
  move sw 
  move s 
  move sw 
  move sw 
  move sw
  move se
  move sw 
  move sw
  move s
  move s 
  move sw 
  move s
  move s 
  move w 
  move sw 
  move se 
  move sw 
  move s 
  move s 
  move sw
  move s
  move se
  move s 
  move s 
  move sw 
  move sw 
  move s 
  move se
  move s 
  move s 
  move se
  move e
  move s 
  move se
  move sw
  move s
  move s
  move se
  move sw
  move se
  move s
  move se
  move s
  move go bridge
  move s
  move s
  move go shore
  move s
  move s
  move s
  move se
  move s
  move sw
  move sw
  move s
  move s
  move w
  move sw
  move sw
exit

bi.echo:
echo You are already at the bin.

################
Forfedhvar
################

boar:
  move e
  move go door
  move go gate
  move e
  move se
  move s
  move s
  move sw
  move sw
  move sw
  move w
  move sw
  move go trail
  move sw
  move se
  move s
  move sw
  move sw
  move se
  move sw
  move s
  move sw
  move s
  move go trail
  move s
  move s
  move se
  move se
  move s
  move s
  move s
  move e
  move se
  move s
  move s
  move sw
  move sw
  move go bri
  move nw
  move ne
  move w
exit

cleric:
  move e
  move sw
  move se
  move go bri
  move ne
  move ne
  move n
  move n
  move nw
  move w
  move n
  move n
  move n
  move nw
  move nw
  move n
  move n
  move go trail
  move n
  move ne
  move n
  move ne
  move nw
  move ne
  move ne
  move n
  move nw
  move ne
  move go trail
  move ne
  move e
  move ne
  move ne
  move ne
  move n
  move n
  move nw
  move w
  move go gate
  move go door
  move w
exit