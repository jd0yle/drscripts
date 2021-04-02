action goto wall_adano when See Abbot Adano for your pay.

start:

	pause 1
	match wait_job You don't need to wait
	match grape_move prepare some bunches of grapes by pulling them off
	match plant_move tend to some vegetables
	match wood_move you need to chop some
	match herb_move gather some herbs from the forest
	match water_move draw some water from the pond
	match rug_move get the dirt out of a rug from one
	match apple_move and just pick some apples from the trees
	match sweep_move need to clean the cobblestone
	match clean_move wash some soiled clothing outside
	match Bean_move open a number of bean pods

	match clean_steps clean off the steps leading into
	match repair_tiles cracked stone tiles in the
	match clean_equipment need to clean some of the
	match clean_window wash some dusty windows
	match grave_move pull weeds and clean out the private
	match paint_move paint the siding of our new winepress
	match library_move transcribe a few texts in the library
	match wall_move repair the wall separating the cow pasture

	put ask adano about job
	matchwait

checkbook:
	match checkbook ...wait
	match guildend Zamidren Book
	match return the way out
	put look
	matchwait

return:
	goto %s

clean_steps:

	pause 1
	put go gate
	pause 0.5
	put peer key
	pause 0.5
	save steps
	goto checkbook

steps:
	pause 1
	match wall_adano What were you referring
	match steps Roundtime
	put clean step
	matchwait

clean_equipment:

	pause 1
	put go gate
	pause 0.5
	put open cabinet
	pause 0.5
	save infirmary
	goto checkbook

infirmary:
	pause 1
	match wall_adano What were you referring
	match infirmary Roundtime
	put Clean Equipment
	matchwait


repair_tiles:

	pause 1
	put go gate
	pause 0.5
	put pull curtain
	pause 0.5
	save tile
	goto checkbook

tile:
	pause 1
	match wall_adano What were you referring
	match tile Roundtime
	put repair tile
	matchwait


clean_window:

	pause 1
	put go gate
	pause 0.5
	put peer window
	pause 0.5
	save windows
	goto checkbook

windows:
	pause 1
	match wall_adano What were you referring
	match windows Roundtime
	put clean window
	matchwait


wall_move:

	pause 1
	put go gate
	pause .5
	put peer dirt
	pause 0.5
	save wall_do
	goto checkbook

wall_do:
	pause 1
	match wall_adano What were you referring
	match wall_do Roundtime
	put repair wall
	matchwait

wall_adano:
	pause 1
	put ask adano about job
	goto wait_job


library_move:

	put go gate
	pause 0.5
	put open tome
             pause 0.5
	put read tome
	pause 0.5
	save library_do
	goto checkbook

library_do:
	pause 1
	match wall_adaon You should try that
	match library_do Roundtime
	put scribe tome
	matchwait


bean_move:
	pause 1
	put go gate
	pause .5
	move w
	pause .5
	put open gate
	pause .5
	goto bean_do

bean_do:
	pause 1
	match bean_adano You think that you should go back to talk to Abbot Adano for your
	match bean_do Roundtime
	put open bean
	matchwait

bean_adano:
	pause 1
	put open gate
	pause .5
	move e
	pause .5
	put go gate
	pause .5
	put ask adano about job
	goto wait_job

paint_move:

	pause 1
	put go gate
	pause .5
	put peer crack
	pause 0.5
	save paint_do
	goto checkbook

paint_do:
	pause 1
	match wall_adano What were you referring
	match paint_do Roundtime
	put get paint
	matchwait


grave_move:

	pause 1
	put go gate
	pause 0.5
	put look headstone
	pause .5
	put peer headstone
	pause .5
	save grave_do
	goto checkbook

grave_do:
	pause 1
	match wall_adano What were you referring
	match grave_do Roundtime
	put pull weed
	matchwait


clean_move:
	pause 1
	put go gate
	pause .5
	move w
	pause .5
	goto clean_do

clean_do:
	pause 1
	match clean_adano You think that you should go back to talk to Abbot Adano for your
	match clean_do Roundtime
	put wash clothe
	matchwait

clean_adano:
	pause 1
	move e
	pause .5
	put open gate
	pause .5
	put ask adano about job
	goto wait_job

sweep_move:
	pause 1
	put go gate
	goto sweep_do

sweep_do:
	pause 1
	match sweep_adano You think that you should go back to talk to Abbot Adano for your
	match sweep_do Roundtime
	put clean path
	matchwait

sweep_adano:
	pause 1
	put open gate
	pause .5
	put ask adano about job
	goto wait_job


apple_move:
	pause 1
	put s
	pause .5
	put e
	pause 5
	goto apple_do

apple_do:
	pause 1
	match apple_adano You think that you should go back to talk to Abbot Adano for your
	match apple_do Roundtime
	put get apple
	matchwait

apple_adano:
	pause 1
	put w
	pause .5
	put n
	pause .5
	put ask adano about job
	goto wait_job

rug_move:
	pause 1
	put go gate
	pause .5
	put e
	pause .5
	put e
	pause .5
	goto rug_do

rug_do:
	pause 1
	match rug_adano You think that you should go back to talk to Abbot Adano for your
	match rug_do Roundtime
	put clean rug
	matchwait

rug_adano:
	pause 1
	move w
	pause .5
	move w
	pause .5
	put open gate
	put ask adano about job
	goto wait_job

water_move:
	put s
	pause .5
	put e
	pause .5
	put sw
	pause .5
	goto water_do

water_do:
	pause 1
	match water_adano You think that you should go back to talk to Abbot Adano for your
	match water_do Roundtime
	put get water
	matchwait

water_adano:
	pause 1
	put ne
	pause .5
	put w
	pause .5
	put n
	pause .5
	put ask adano about job
	counter add 1
	goto wait_job


herb_move:
	put s
	pause .5
	put sw
	pause 5
	goto herb_do

herb_do:
	pause 1
	match herb_adano You think that you should go back to talk to Abbot Adano for your
	match herb_do Roundtime
	put get herb
	matchwait

herb_adano:
	put ne
	pause .5
	put n
	pause .5
	put ask adano about job
	goto wait_job

wood_move:
	put south
	pause .5
	goto wood_do

wood_do:
	pause 1
	match wood_adano You think that you should go back to talk to Abbot Adano for your
	match wood_do Roundtime
	put cut fire
	matchwait

wood_adano:
	pause 1
	put n
	put ask adano about job
	goto wait_job

plant_move:
	put go gate
	pause .5
	put w
	pause .5
	put open gate
	goto plant_do

plant_do:
	pause 1
	match plant_adano You think that you should go back to talk to Abbot Adano for your
	match plant_do Roundtime
	put turn plant
	matchwait

plant_adano:
	pause 1
	put open gate
	pause .5
	put east
	pause .5
	put open gate
	put ask adano about job
	goto wait_job


grape_move:
	pause 1
	put go gate
	goto grape_do

grape_do:
	pause 1
	match grape_adano You think that you should go back to talk to Abbot Adano for your
	match grape_do Roundtime
	put pull grapes
	matchwait

grape_adano:
	pause 1
	put open gate
	put ask adano about job
	goto wait_job

wait_job:
	pause 1
	move s
	move sw
	put exp
	put ask ty about lecture
	pause 305
	put exp
	pause 305
	move ne
	move n
	goto start


reset:
	pause 1
	move s
	move e
	move sw
	move s
	move go path
	pause 2


look:
match moo and cloak the trees in jade filigree
match moo1 orbweaver's web twitches slightly with the struggles
match moo2 grasslands stretching out to the west breathe quietly the open
match moo3 of a few butterflies, who flutter across the trail
match moo4 You also see a vast crater
match moo5 pale trunks catching the sunlight and glowing
match moo6 prey soar effortlessly far above and cry out as they
match moo7 small burrs catch on your clothing like the hands of a child
match moo8 caravan drivers hurrying their animals along can be heard
match moo9 mark the start of a small gully
put look
matchwait

moo:
	move sw
	move sw
	move w
	move w
	move go copse
	move sw
	move sw
	move w
	move sw
	move n
	goto moo9
moo1:
	move sw
	move w
	move w
	move go copse
	move sw
	move sw
	move w
	move sw
	move n
	goto moo9

moo2:
	move w
	move w
	move go copse
	move sw
	move sw
	move w
	move sw
	move n
	goto moo9

moo3:

	move w
	move go copse
	move sw
	move sw
	move w
	move sw
	move n
	goto moo9

moo4:

	move go copse
	move sw
	move sw
	move w
	move sw
	move n
	goto moo9

moo5:

	move sw
	move sw
	move w
	move sw
	move n
	goto moo9

moo6:

	move sw
	move w
	move sw
	move n
	goto moo9

moo7:

	move w
	move sw
	move n
	goto moo9

moo8:

	move sw
	move n
	goto moo9

moo9:
	pause 0.5
	put ask monk about job
	pause 0.5
	put ask monk about job
	pause 0.5
	move n
	move ne
	move w
	move n
	goto start




guildend:

echo ****************************************************************
echo **** Here you are, your in.
echo ****************************************************************
	exit
